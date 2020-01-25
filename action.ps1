function Move-Message($message, $rule) {
	if($message -eq $null) {
		write-host "Message is null"
		return
	}

	if($rule -eq $null) {
		write-host "Rule is null"
		return
	}

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
	if ( $message -eq $null ) {
		log "message is null"
		return
	}

	if ( $rule -eq $null ) {
		log "rule is null"
		return
	}

	log "Delete $rule $message"
	try {
		$message.Delete() | Out-Null
	} catch {
		log "Error deleting message: $message $rule"
	}
}
