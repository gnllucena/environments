using Amazon.CDK;
using Amazon.CDK.AWS.EC2;
using Amazon.CDK.AWS.RDS;
using AWS.CDK.Constructs;
using AWS.Domains.Options;

namespace AWS.CDK.Stacks
{
    public class RDSStack : Stack
    {
        public RDSStack(Construct parent, IStackProps props, AwsOptions awsOptions, DatabaseInstanceEngine engine) : base(parent, awsOptions.Database.Name, props)
        {

            var vpc = new Vpc(this, "vpc", new VpcProps()
            {
                Cidr = "10.0.0.0/21",
                
                //NatGateways = new SubnetConfiguration()
                //{
                // pra expor o banco de dados pra internet
                //},
                SubnetConfiguration = new SubnetConfiguration[]
                {
                    new SubnetConfiguration()
                    {
                        CidrMask = 24,
                        Name = "Ingress",
                        SubnetType = SubnetType.Public
                    },
                    new SubnetConfiguration()
                    {
                        CidrMask = 24,
                        Name = "Applications",
                        SubnetType = SubnetType.Private,
                    },
                    new SubnetConfiguration()
                    {
                        CidrMask = 28,
                        Name = "Databases",
                        SubnetType = SubnetType.Isolated
                    }
                }
            });

            vpc.AddInterfaceEndpoint("id", new InterfaceVpcEndpointOptions()
            {
                Service = new InterfaceVpcEndpointAwsService("interfaceendpointname", "prefixendpointname", 3030),
                Subnets = new SubnetSelection()
                {
                    SubnetName = "intefacesubnetname",
                    SubnetType = SubnetType.Public
                }
            });

            new RDSDatabaseClusterConstruct(this, awsOptions.Database.Name, new DatabaseInstanceProps()
            {
                Engine = engine,
                PreferredBackupWindow = awsOptions.Database.BackupWindow,
                BackupRetentionPeriod = awsOptions.Database.BackupMaxDaysRetention,
                InstanceClass = new InstanceTypePair((InstanceClass)awsOptions.Database.Instance.Class, (InstanceSize)awsOptions.Database.Instance.Size),
                Vpc = vpc,
                MasterUsername = awsOptions.Database.Username,
                MasterUserPassword = new SecretValue(awsOptions.Database.Password),
                //KmsKey = new Key(this, awsOptions.Database.Name + "_KEY", new KeyProps()
                //{
                //    Description = awsOptions.Database.Description,
                //    Enabled = true,
                //    EnableKeyRotation = false
                //}),
            });
        }
    }
}
