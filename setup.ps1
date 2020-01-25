# configuration
. ~\.email.ps1

Add-Type -assembly "Microsoft.Office.Interop.Outlook"
$Outlook = New-Object -comobject Outlook.Application
$namespace = $Outlook.GetNameSpace("MAPI")

$Account = $namespace.Folders.Item($emailAddress)
$Inbox = $Account.Folders.Item("Inbox")

if($debug) {
	if($logTarget -match "Stdout") {
		$logDirectory = Split-Path -Path $LogFile -Parent
		if(!(test-path $LogDirectory)) {
			New-Item -ItemType Directory -Force -Path $LogDirectory | Out-Null
		}
	}
}

function log($message) {
	if($debug) {
		if($logTarget -match "Stdout") {
			write-host $message
		} else {
			Add-Content $LogFile $message
		}
	}
}
