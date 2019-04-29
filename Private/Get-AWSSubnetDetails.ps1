function Get-AWSSubnetDetails {
    [CmdletBinding()]
    param (
        [string] $AWSAccessKey,
        [string] $AWSSecretKey,
        [string] $AWSRegion
    )
    try {
        $Subnets = Get-EC2Subnet -AccessKey $AWSAccessKey -SecretKey $AWSSecretKey -Region $AWSRegion
    } catch {
        $ErrorMessage = $_.Exception.Message
        Write-Warning "Get-AWSSubnetDetails - Error: $ErrorMessage"
        return
    }
    try {
        $VPCID = (Get-EC2Vpc -AccessKey $AWSAccessKey -SecretKey $AWSSecretKey -Region $AWSRegion)
    } catch {
        $ErrorMessage = $_.Exception.Message
        Write-Warning "Get-AWSSubnetDetails - Error: $ErrorMessage"
        return
    }
    $NetworkDetailsList = foreach ($subnet in $Subnets) {
        $SN = [pscustomobject] @{
            "Subnet ID"    = $subnet.SubnetId
            "Subnet Name"  = $subnet.Tags | Where-Object {$_.key -eq "Name"} | Select-Object -Expand Value
            "CIDR"         = $subnet.CidrBlock
            "Available IP" = $subnet.AvailableIpAddressCount
            "VPC"          = ($VPCID | Where-Object { $_.VpcId -eq $Subnet.VpcId }).Tags | Where-Object {$_.key -eq "Name"} | Select-Object -Expand Value
        }
        $SN
    }
    return $NetworkDetailsList
}