function Get-Target-Directory($rule) {
	$elements = $rule.Split("\")

	$targetDirectory = $Inbox
	for($i = 0;$i -lt $elements.Count;$i++) {
		$global:targetDirectory = $global:targetDirectory.Folders.Item($elements[$i])
	}

	#log "target folder: " $global:targetDirectory.FolderPath
	return $targetDirectory
}
