$matched = (
  $message.Subject -match "Reference Documentation - "
)

if ( $matched ) {
  $hour = Get-Date -Format 'HH'

  # mark as read if the email comes in really early or really late
  $read = ($hour -lt 6 -or $hour -gt 20)
}
