Import-Module AWSPowerShell
Import-Module .\PSWinDocumentation.AWS.psd1 -Force

$Configuration = [ordered] @{
    AWSAccessKey = ''
    AWSSecretKey = ''
    AWSRegion    = 'eu-west-1'
}

$AWS = Get-WinAWSInformation -AWSAccessKey $Configuration.AWSAccessKey -AWSSecretKey $Configuration.AWSSecretKey -AWSRegion $Configuration.AWSRegion
$AWS