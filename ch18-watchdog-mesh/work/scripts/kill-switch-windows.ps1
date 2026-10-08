# Kill-switch hook for the watchdog mesh — Windows variant (PowerShell).
# Same logic as kill-switch.sh: reads the PreToolUse JSON payload from
# stdin, gates only on the "[WATCHDOG:ESCALATE]" prefix, blocks with
# exit 2 (the documented Claude Code blocking exit code).

$ErrorActionPreference = "Stop"

$Log = "$HOME\work\watchdog\escalations.log"
$LogDir = Split-Path $Log -Parent
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir | Out-Null }

# Read the JSON hook payload from stdin.
$Payload = [Console]::In.ReadToEnd()
try {
    $Parsed = $Payload | ConvertFrom-Json
} catch {
    # Malformed payload — fail open (pass through) so we don't block real work.
    exit 0
}

$ToolName = if ($Parsed.tool_name) { $Parsed.tool_name } else { "unknown" }
$Message = ""
if ($Parsed.tool_input) {
    if ($Parsed.tool_input.text)    { $Message = $Parsed.tool_input.text }
    elseif ($Parsed.tool_input.message) { $Message = $Parsed.tool_input.message }
}

# Only gate watchdog-orchestrator escalate-tier sends.
if ($Message -notlike "*[WATCHDOG:ESCALATE]*") {
    exit 0
}

$Snippet = if ($Message.Length -gt 80) { $Message.Substring(0, 80) } else { $Message }
$ProposedAction = "${ToolName}: $Snippet"
$Code = "{0:0000}" -f (Get-Random -Minimum 0 -Maximum 10000)
$Now = (Get-Date).ToString("yyyy-MM-ddTHH:mm:sszzz")

Add-Content -Path $Log -Value "[$Now] INTERCEPT: $ProposedAction"

# Windows toast notification.
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
$template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent(
    [Windows.UI.Notifications.ToastTemplateType]::ToastText02)
$texts = $template.GetElementsByTagName("text")
$texts.Item(0).AppendChild($template.CreateTextNode("Kill-switch")) | Out-Null
$texts.Item(1).AppendChild($template.CreateTextNode("Watchdog wants to: $ProposedAction. Type code $Code to approve.")) | Out-Null
$toast = [Windows.UI.Notifications.ToastNotification]::new($template)
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("Watchdog").Show($toast)

# Wait up to 60s for the code typed back at the console.
$entered = $null
$job = Start-Job { Read-Host "Enter 4-digit code to approve" }
if (Wait-Job $job -Timeout 60) {
    $entered = Receive-Job $job
} else {
    Stop-Job $job
    $now2 = (Get-Date).ToString("yyyy-MM-ddTHH:mm:sszzz")
    Add-Content -Path $Log -Value "[$now2] DENIED (timeout): $ProposedAction"
    [Console]::Error.WriteLine("Kill-switch timed out")
    exit 2
}

$now3 = (Get-Date).ToString("yyyy-MM-ddTHH:mm:sszzz")
if ($entered -eq $Code) {
    Add-Content -Path $Log -Value "[$now3] APPROVED: $ProposedAction"
    exit 0
} else {
    Add-Content -Path $Log -Value "[$now3] DENIED (wrong code): $ProposedAction"
    [Console]::Error.WriteLine("Kill-switch denied: wrong code")
    exit 2
}
