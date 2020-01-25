. .\setup

# https://blog.netnerds.net/2016/12/runspaces-simplified
$poolSize = [int]$env:NUMBER_OF_PROCESSORS*8
$pool = [RunspaceFactory]::CreateRunspacePool(1, $poolSize)
$pool.Open()

$runspaces = @()

$scriptblock = {
  Param ([int]$messageIndex)
  . .\message $messageIndex
}

$runspaces = for ( $i = $global:Inbox.Items.Count;$i -gt 0;$i--) {
  $runspace = [PowerShell]::Create()
  $runspace.RunspacePool = $pool

  $runspace.AddScript($scriptblock) | Out-Null
  $runspace.AddArgument($i) | Out-Null

  $runspace | Add-Member -MemberType NoteProperty -Name 'AsyncResult' -Value $runspace.BeginInvoke() -PassThru
}

$results = foreach ( $runspace in $runspaces ) {
  $runspace.EndInvoke($runspace.AsyncResult)
}

$runspaces | % { $_.Dispose()}
$runspaces = $null
if ( $pool ) { $pool.Close() }
