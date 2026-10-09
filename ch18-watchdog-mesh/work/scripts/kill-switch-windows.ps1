# Kill-switch hook for the watchdog mesh — Windows variant (PowerShell).
# Same logic as kill-switch.sh: reads the PreToolUse JSON payload from
# stdin, gates only on the "[WATCHDOG:ESCALATE]" prefix, blocks with
# exit 2 (the only exit code that blocks a tool call in Claude Code).
#
# Hooks have no console to type into, so the code is typed into a small
# Windows dialog. Once a message is known to be an escalation, every
# failure path exits 2: a crash, any other exit code, or a hook that runs
# past its timeout would let the call go through.
#
# Register it with -STA so the dialog can open, for example:
#   powershell.exe -STA -NoProfile -ExecutionPolicy Bypass -File C:\Users\YOU\work\scripts\kill-switch-windows.ps1

$Log = "$HOME\work\watchdog\escalations.log"
$LogDir = Split-Path $Log -Parent
try {
    if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir | Out-Null }
} catch {}

# Read the JSON hook payload from stdin.
$Payload = [Console]::In.ReadToEnd()

# Only gate watchdog-orchestrator escalate-tier sends. Checked on the raw
# payload with a literal match (-like would treat the brackets as a pattern).
if (-not $Payload.Contains("[WATCHDOG:ESCALATE]")) {
    exit 0
}

try {
    $ToolName = "unknown"
    $Message = "[WATCHDOG:ESCALATE] (message could not be read)"
    try {
        $Parsed = $Payload | ConvertFrom-Json
        if ($Parsed.tool_name) { $ToolName = $Parsed.tool_name }
        if ($Parsed.tool_input.text) { $Message = $Parsed.tool_input.text }
        elseif ($Parsed.tool_input.message) { $Message = $Parsed.tool_input.message }
    } catch {}

    $Snippet = if ($Message.Length -gt 80) { $Message.Substring(0, 80) } else { $Message }
    $ProposedAction = "${ToolName}: $Snippet"
    $Code = "{0:0000}" -f (Get-Random -Minimum 0 -Maximum 10000)
    $Now = (Get-Date).ToString("yyyy-MM-ddTHH:mm:sszzz")
    Add-Content -Path $Log -Value "[$Now] INTERCEPT: $ProposedAction"

    # A small dialog showing the action and the code, with a box to type it
    # back. It closes itself after 50 seconds, which counts as a denial.
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Kill-switch"
    $form.TopMost = $true
    $form.StartPosition = "CenterScreen"
    $form.ClientSize = New-Object System.Drawing.Size(440, 170)
    $label = New-Object System.Windows.Forms.Label
    $label.Text = "Watchdog wants to: $ProposedAction`r`n`r`nType code $Code to approve."
    $label.SetBounds(10, 10, 420, 80)
    $box = New-Object System.Windows.Forms.TextBox
    $box.SetBounds(10, 95, 420, 24)
    $approve = New-Object System.Windows.Forms.Button
    $approve.Text = "Approve"
    $approve.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $approve.SetBounds(250, 130, 85, 28)
    $deny = New-Object System.Windows.Forms.Button
    $deny.Text = "Deny"
    $deny.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $deny.SetBounds(345, 130, 85, 28)
    $form.Controls.AddRange(@($label, $box, $approve, $deny))
    $form.AcceptButton = $approve
    $form.CancelButton = $deny
    $timer = New-Object System.Windows.Forms.Timer
    $timer.Interval = 50000
    $timer.Add_Tick({ $timer.Stop(); $form.DialogResult = [System.Windows.Forms.DialogResult]::Abort; $form.Close() })
    $timer.Start()
    $result = $form.ShowDialog()
    $timer.Stop()
    $entered = if ($result -eq [System.Windows.Forms.DialogResult]::OK) { $box.Text.Trim() } else { "" }

    $Now = (Get-Date).ToString("yyyy-MM-ddTHH:mm:sszzz")
    if ($entered -eq "") {
        Add-Content -Path $Log -Value "[$Now] DENIED (no answer): $ProposedAction"
        [Console]::Error.WriteLine("Kill-switch denied: no code entered")
        exit 2
    } elseif ($entered -eq $Code) {
        Add-Content -Path $Log -Value "[$Now] APPROVED: $ProposedAction"
        exit 0
    } else {
        Add-Content -Path $Log -Value "[$Now] DENIED (wrong code): $ProposedAction"
        [Console]::Error.WriteLine("Kill-switch denied: wrong code")
        exit 2
    }
} catch {
    [Console]::Error.WriteLine("Kill-switch error; blocking to be safe: $_")
    exit 2
}
