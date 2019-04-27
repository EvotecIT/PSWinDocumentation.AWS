function Get-AWSLBDetails {
    [CmdletBinding()]
    param (
        [string] $AWSAccessKey,
        [string] $AWSSecretKey,
        [string] $AWSRegion
    )


    try {
        $ELBs = Get-ELBLoadBalancer -AccessKey $AWSAccessKey -SecretKey $AWSSecretKey -Region $AWSRegion # Classic Load Balancers
        $ALBs = Get-ELB2LoadBalancer -AccessKey $AWSAccessKey -SecretKey $AWSSecretKey -Region $AWSRegion # Application Load Balancers
    } catch {
        $ErrorMessage = $_.Exception.Message
        Write-Warning "Get-AWSLBDetails - Error: $ErrorMessage"
        return
    }

    $LBDetailsList = @(
        foreach ($lb in $ELBs) {
            $LB = [pscustomobject] @{
                "Name"     = $lb.LoadBalancerName
                "Type"     = "ELB"
                "Scheme"   = $lb.Scheme
                "DNS Name" = $lb.DNSName
                "Targets"  = $lb.Instances.InstanceId -join ", "
            }
            $LB
        }
        foreach ($lb in $ALBs) {
            $LB = [pscustomobject] @{
                "Name"     = $lb.LoadBalancerName
                "Type"     = "ALB"
                "Scheme"   = $lb.Scheme
                "DNS Name" = $lb.DNSName
                "Targets"  = "Dynamic Routing"
            }
            $LB
        }
    )
    return $LBDetailsList
}
