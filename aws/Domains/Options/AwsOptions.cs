namespace AWS.Domains.Options
{
    public class AwsOptions
    {
        public string Account { get; set; }
        public string Region { get; set; }
        public ECR Registry { get; set; }
        public RDS Database { get; set; }

        public class ECR
        {
            public string Name { get; set; }
            public string Description { get; set; }
            public string Prefix { get; set; }
            public bool Retain { get; set; }
            public int MaxDaysRetention { get; set; }
        }

        public class RDS
        {
            public string Name { get; set; }
            public string Username { get; set; }
            public string Password{ get; set; }
            public string Description { get; set; }
            public int BackupMaxDaysRetention { get; set; }
            public string BackupWindow { get; set; }
            public EC2 Instance { get; set; }
        }


        public class EC2
        {
            public int Class { get; set; }
            public int Size { get; set; }
            public VPC Subnet { get; set; }
        }
        

        public class VPC
        {
            public string Name { get; set; }
            public int Type { get; set; }
            public string[] Zones { get; set; }

            //vpcId: 'someid',
            //    availabilityZones: ['eu-central-1a', 'eu-central-1b', 'eu-central-1c'],
            //    publicSubnetIds: [
            //        'someid',
            //        'someid',
            //        'someid',
            //    ],
        }
    }
}
