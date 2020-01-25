. .\setup
. .\action
. .\folders

$global:message = $global:Inbox.Items[$args[0]]
$logTarget = $logTarget + "." + $args[0]
$rules = Get-Content ~\.email.rules.order

function get-rule-path($rule) {
  return $global:rulesPath + $rule + ".ps1"
}

function process-message() {
  log "Processing $global:rulePath"
  . $global:rulePath

  $processed = $false
  if ( $delete ) {
    Delete-Message $message $rule

    $processed = $true
  } elseif ( $matched ) {
    Move-Message $message $rule
    $processed = $true
  }

  $matched = $false
  $delete = $false
  $read = $false

  return $processed
}

$global:message = $global:Inbox.Items[$args[0]]
foreach ( $global:rule in $rules ) {
  if ( $rule -eq $null -or $rule.length -eq 0 ) {
    continue
  }

  $global:rulepath = get-rule-path $rule

  # log "processing rule: $rule"
  if ( process-message ) {
    return
  }
}
