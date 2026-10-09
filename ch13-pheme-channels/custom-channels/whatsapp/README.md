# whatsapp — a custom WhatsApp channel for Pheme (via Twilio)

Make-it-yours #3 in Chapter 13. Twilio receives WhatsApp messages and calls a
webhook; this server receives that webhook and pushes each message from an
allowlisted number into your running Claude Code session as a
`<channel source="whatsapp">` event. Pheme answers with the `reply` tool, which
sends the answer back through Twilio.

It follows Anthropic's channel contract
(<https://code.claude.com/docs/en/channels-reference>):

- declares the `claude/channel` capability and emits `notifications/claude/channel`
- exposes one tool, `reply` (`chat_id`, `text`)
- checks Twilio's `X-Twilio-Signature` on every request, then gates on the
  **sender's phone number** (`+country` format)
- optional permission relay to the numbers in `relayTo`
  (they answer `yes <id>` or `no <id>`)

It also implements the quiet hours from the make-it-yours prompt: no replies
between 22:00 and 07:00 (the machine's local time) unless the incoming message
contains the exact word `URGENT`. Every event carries `urgent` and
`quiet_hours` attributes so Pheme knows which case he is in; during quiet hours
the `reply` tool holds non-urgent answers and says so. Permission prompts are
not held: when Claude is waiting on an approval, it goes out at any hour.

## Files

| Path | What it is |
|---|---|
| `src/index.ts` | The channel server |
| `test/smoke.mjs` | End-to-end test against a fake Twilio (no account needed) |
| `package.json`, `package-lock.json`, `tsconfig.json` | Build setup (Node 20+, no Twilio SDK needed) |
| `.env.example` | Twilio settings, to copy into `~/.claude/channels/whatsapp/.env` |
| `access.example.json` | Allowlist, relay list, quiet hours, to copy into `~/.claude/channels/whatsapp/access.json` |
| `mcp.json.example` | The entry to add to `~/work/.mcp.json` |

## Set it up

1. **Get a Twilio WhatsApp sender.** For testing, use the Twilio WhatsApp
   Sandbox (in the Twilio Console under *Messaging → Try it out → Send a
   WhatsApp message*): each phone that will text Pheme sends the sandbox's
   `join <code>` message once. For real use you need an approved WhatsApp
   sender on your Twilio account.
2. **Open a tunnel to your Mac.** Twilio must reach a public HTTPS URL; the
   server listens only on `127.0.0.1`. For example, with Cloudflare's free quick
   tunnel:

   ```bash
   cloudflared tunnel --url http://localhost:8790
   ```

   It prints an address like `https://words-words.trycloudflare.com`. Your
   webhook URL is that address plus `/whatsapp`. (Quick-tunnel addresses change
   every time you start one; a named tunnel or ngrok's fixed domain avoids
   re-doing step 3.)
3. **Point Twilio at it.** In the sandbox settings (or your sender's
   configuration), set *When a message comes in* to your webhook URL, method
   POST.
4. **Save the settings and the allowlist**, readable only by you:

   ```bash
   mkdir -p ~/.claude/channels/whatsapp
   cp .env.example ~/.claude/channels/whatsapp/.env               # fill in SID, token, sender, PUBLIC_URL
   cp access.example.json ~/.claude/channels/whatsapp/access.json  # put in real numbers
   chmod 600 ~/.claude/channels/whatsapp/.env
   ```

   `PUBLIC_URL` must be exactly the URL you gave Twilio, character for
   character: the signature check depends on it, and the server listens on its
   path. If the tunnel address changes, update both places.
   `relayTo` must be a subset of `allowFrom`; leave it empty to turn permission
   relay off. `access.json` is re-read on every message (turning relay on or
   off needs a restart).
5. **Build it:**

   ```bash
   mkdir -p ~/work/mcp-servers
   cp -R . ~/work/mcp-servers/whatsapp && cd ~/work/mcp-servers/whatsapp
   npm install && npm run build
   ```

6. **Register it** in `~/work/.mcp.json` (see `mcp.json.example`; use the full
   path to `dist/index.js`).
7. **Launch with the development flag** (custom channels are not on Anthropic's
   approved list during the research preview; the flag works only in an
   interactive session and asks for confirmation):

   ```bash
   cd ~/work
   claude --dangerously-load-development-channels server:whatsapp
   ```

   To have Pheme listen on WhatsApp, add that flag to
   `~/work/scripts/pheme-listen.sh` and add `mcp__whatsapp__reply` to the
   `tools:` list in `~/work/.claude/agents/pheme.md`.

## Check it

```bash
npm test
```

The test signs requests the way Twilio does and checks, among other things:
unsigned or forged requests are rejected; an allowlisted number becomes a
channel event; a stranger is dropped; replies go out through the Twilio
Messages API; quiet hours hold non-urgent replies and let URGENT ones through;
permission prompts go only to `relayTo`; and only `relayTo` can approve.

## Limits to know

- **WhatsApp's 24-hour window.** WhatsApp lets a business send a free-form
  message only within 24 hours of the person's last message. Outside that
  window Twilio refuses the send, and the `reply` tool returns Twilio's error
  (code 63016) instead of "sent". The same applies to permission prompts:
  whoever approves from their phone must have messaged Pheme in the last 24
  hours.
- **Text only.** If a message has photos or files, Pheme sees a note like
  `[1 attachment(s) not shown]`; the files themselves are not downloaded.
- **Long replies** are split into parts of up to 1,500 characters (Twilio's
  limit for WhatsApp is 1,600).
- **The session must be open.** Claude Code starts this server, so when no
  session is running nothing is listening: Twilio's webhook call fails and the
  message never reaches Pheme. Twilio shows the failed call in its debugger.
