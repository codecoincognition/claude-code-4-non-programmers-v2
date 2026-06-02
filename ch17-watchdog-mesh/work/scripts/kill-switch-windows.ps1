# Kill-switch hook for the watchdog mesh — Windows variant (PowerShell).
# Same logic as kill-switch.sh: per-interception 4-digit code, 60s timeout, append-only log.

$ErrorActionPreference = "Stop"

$Log = "$HOME\work\watchdog\escalations.log"
$ProposedAction = if ($args.Count -ge 1) { $args[0] } else { "unspecified" }
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
    exit 1
}

$now3 = (Get-Date).ToString("yyyy-MM-ddTHH:mm:sszzz")
if ($entered -eq $Code) {
    Add-Content -Path $Log -Value "[$now3] APPROVED: $ProposedAction"
    exit 0
} else {
    Add-Content -Path $Log -Value "[$now3] DENIED (wrong code): $ProposedAction"
    exit 1
}
