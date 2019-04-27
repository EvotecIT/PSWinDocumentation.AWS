function Get-AWSEC2Details {
    [CmdletBinding()]
    param (
        [string] $AWSAccessKey,
        [string] $AWSSecretKey,
        [string] $AWSRegion
    )
    try {
        $EC2Instances = Get-EC2Instance -AccessKey $AWSAccessKey -SecretKey $AWSSecretKey -Region $AWSRegion
    } catch {
        $ErrorMessage = $_.Exception.Message
        Write-Warning "Get-AWSEC2Details - Error: $ErrorMessage"
        return
    }
    $EC2DetailsList = foreach ($instance in $EC2Instances) {
        $ec2 = [pscustomobject] @{
            'Instance ID'   = $instance[0].Instances[0].InstanceId
            "Instance Name" = $instance[0].Instances[0].Tags | Where-Object {$_.key -eq "Name"} | Select-Object -Expand Value
            "Environment"   = $instance[0].Instances[0].Tags | Where-Object {$_.key -eq "Environment"} | Select-Object -Expand Value
            "Instance Type" = $instance[0].Instances[0].InstanceType
            "Private IP"    = $instance[0].Instances[0].PrivateIpAddress
            "Public IP"     = $instance[0].Instances[0].PublicIpAddress
        }
        $ec2
    }
    return $EC2DetailsList
}
