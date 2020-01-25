# configuration
$emailAddress = "EMAIL-ADDRESS@gmail.com"
$debug = $true


# do not log
#$logTarget = $null
# log to Stdout
#$logTarget = "Stdout"

# write to file
$executionDate = Get-Date -Format "yyyy/MM/dd.HH.mm"
$logTarget = ".\logs\${executionDate}.log"

# path to rules
$rulesPath = ".\rules\"
