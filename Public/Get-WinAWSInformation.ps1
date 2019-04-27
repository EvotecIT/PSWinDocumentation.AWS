function Get-WinAWSInformation {
    [CmdletBinding()]
    param(
        [alias('AccessKey')][string] $AWSAccessKey,
        [alias('SecretKey')][string] $AWSSecretKey,
        [alias('Region')][string] $AWSRegion,
        [PSWinDocumentation.AWS[]] $TypesRequired
    )
    $Data = [ordered] @{}
    if ($null -eq $TypesRequired) {
        Write-Verbose 'Get-AWSInformation - TypesRequired is null. Getting all AWS types.'
        $TypesRequired = Get-Types -Types ([PSWinDocumentation.AWS])  # Gets all types
    }
    if (Find-TypesNeeded -TypesRequired $TypesRequired -TypesNeeded @([PSWinDocumentation.AWS]::AWSEC2Details)) {
        Write-Verbose "Getting AWS information - AWSEC2Details"
        $Data.AWSEC2Details = Get-AWSEC2Details -AWSAccessKey $AWSAccessKey -AWSSecretKey $AWSSecretKey -AWSRegion $AWSRegion -Verbose:$False
    }
    if (Find-TypesNeeded -TypesRequired $TypesRequired -TypesNeeded @([PSWinDocumentation.AWS]::AWSRDSDetails)) {
        Write-Verbose "Getting AWS information - AWSRDSDetails"
        $Data.AWSRDSDetails = Get-AWSRDSDetails -AWSAccessKey $AWSAccessKey -AWSSecretKey $AWSSecretKey -AWSRegion $AWSRegion -Verbose:$False
    }
    if (Find-TypesNeeded -TypesRequired $TypesRequired -TypesNeeded @([PSWinDocumentation.AWS]::AWSLBDetails)) {
        Write-Verbose "Getting AWS information - AWSLBDetails"
        $Data.AWSLBDetails = Get-AWSLBDetails -AWSAccessKey $AWSAccessKey -AWSSecretKey $AWSSecretKey -AWSRegion $AWSRegion -Verbose:$False
    }
    if (Find-TypesNeeded -TypesRequired $TypesRequired -TypesNeeded @([PSWinDocumentation.AWS]::AWSSubnetDetails)) {
        Write-Verbose "Getting AWS information - AWSSubnetDetails"
        $Data.AWSSubnetDetails = Get-AWSSubnetDetails -AWSAccessKey $AWSAccessKey -AWSSecretKey $AWSSecretKey -AWSRegion $AWSRegion -Verbose:$False
    }
    if (Find-TypesNeeded -TypesRequired $TypesRequired -TypesNeeded @([PSWinDocumentation.AWS]::AWSElasticIpDetails)) {
        Write-Verbose "Getting AWS information - AWSElasticIpDetails"
        $Data.AWSElasticIpDetails = Get-AWSElasticIpDetails -AWSAccessKey $AWSAccessKey -AWSSecretKey $AWSSecretKey -AWSRegion $AWSRegion -Verbose:$False
    }
    if (Find-TypesNeeded -TypesRequired $TypesRequired -TypesNeeded @([PSWinDocumentation.AWS]::AWSIAMDetails)) {
        Write-Verbose "Getting AWS information - AWSIAMDetails"
        $Data.AWSIAMDetails = Get-AWSIAMDetails -AWSAccessKey $AWSAccessKey -AWSSecretKey $AWSSecretKey -AWSRegion $AWSRegion -Verbose:$False
    }
    return $Data
}