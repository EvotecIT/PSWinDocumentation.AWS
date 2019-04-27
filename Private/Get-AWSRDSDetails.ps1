function Get-AWSRDSDetails {
    [CmdletBinding()]
    param (
        [string] $AWSAccessKey,
        [string] $AWSSecretKey,
        [string] $AWSRegion
    )

    try {
        $RDSInstances = Get-RDSDBInstance -AccessKey $AWSAccessKey -SecretKey $AWSSecretKey -Region $AWSRegion
    } catch {
        $ErrorMessage = $_.Exception.Message
        Write-Warning "Get-AWSRDSDetails - Error: $ErrorMessage"
        return
    }

    $RDSDetailsList = foreach ($instance in $RDSInstances) {
        $RDS = [pscustomobject] @{
            "Name"           = $instance.DBInstanceIdentifier
            "Class"          = $instance.DBInstanceClass
            "MutliAz"        = if ($instance.Engine.StartsWith("aurora")) { "not applicable" } Else { $instance.MultiAz }
            "Engine"         = $instance.Engine
            "Engine Version" = $instance.EngineVersion
            "Storage"        = if ($instance.Engine.StartsWith("aurora")) { "Dynamic" } Else { [string]::Format("{0} GB", $instance.AllocatedStorage) }
            "Environment"    = Get-RDSTagForResource -AccessKey $AWSAccessKey -SecretKey $AWSSecretKey -Region $AWSRegion -ResourceName $instance.DBInstanceArn | Where-Object {$_.key -eq "Environment"} | Select-Object -Expand Value

        }
        $RDS
    }
    return $RDSDetailsList
}
