# configuration
. ~\.email.ps1

Add-Type -assembly "Microsoft.Office.Interop.Outlook"
$Outlook = New-Object -comobject Outlook.Application
$namespace = $Outlook.GetNameSpace("MAPI")

$Account = $namespace.Folders.Item($emailAddress)
$Inbox = $Account.Folders.Item("Inbox")

if($debug) {
	if($logTarget -match "Stdout") {
		$logDirectory = Split-Path -Path $logTarget -Parent
		if(!(test-path $logDirectory)) {
			New-Item -ItemType Directory -Force -Path $logDirectory | Out-Null
		}
	}
}

function log($message) {
	if($debug) {
		if($logTarget -match "Stdout") {
			write-host $message
		} else {
			Add-Content $logTarget $message
		}
	}
}
