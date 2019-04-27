Add-Type -TypeDefinition @"
    using System;

    namespace PSWinDocumentation
    {
        [Flags]
        public enum AWS {
            AWSEC2Details,
            AWSElasticIpDetails,
            AWSIAMDetails,
            AWSLBDetails,
            AWSRDSDetails,
            AWSSubnetDetails
        }
    }
"@