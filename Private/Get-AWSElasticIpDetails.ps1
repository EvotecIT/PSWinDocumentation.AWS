function Get-AWSElasticIpDetails {
    [CmdletBinding()]
    param (
        [string] $AWSAccessKey,
        [string] $AWSSecretKey,
        [string] $AWSRegion
    )
    try {
        $EIPs = Get-EC2Address -AccessKey $AWSAccessKey -SecretKey $AWSSecretKey -Region $AWSRegion
    } catch {
        $ErrorMessage = $_.Exception.Message
        Write-Warning "Get-AWSElasticIpDetails - Error: $ErrorMessage"
        return
    }

    $EIPDetailsList = foreach ($eip in $EIPs) {
        $ElasticIP = [pscustomobject] @{
            "Name"              = $eip.Tags | Where-Object {$_.key -eq "Name"} | Select-Object -Expand Value
            "IP"                = $eip.PublicIp
            "Assigned to"       = $eip.InstanceId
            "Network Interface" = $eip.NetworkInterfaceId

        }
        $ElasticIP
    }
    return $EIPDetailsList
}