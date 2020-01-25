function Move-Message($message, $rule) {
	$target = Get-Target-Directory $rule

	log "Move $rule $message"

	try {
		Mark-As-Read $message $target
		$message.Move($target) | Out-Null
	} catch {
		log "Error moving message: $rule $message"
	}
}

function Mark-As-Read($message, $target) {
	if ( $read -or $target.FolderPath -match "non-actionable" ) {
		$message.UnRead = $false
	}
}

function Delete-Message($message, $rule) {
	log "Delete $rule $message"
	try {
		$message.Delete() | Out-Null
	} catch {
		log "Error deleting message: $message $rule"
	}
}
