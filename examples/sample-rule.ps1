$matched = $true

$matched = (
	$message.Sender.Name -match "Some Sender" -or
	$message.Subject -match "Subject goes here"
)
