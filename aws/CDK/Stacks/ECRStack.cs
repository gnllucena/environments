using Amazon.CDK;
using Amazon.CDK.AWS.ECR;
using AWS.CDK.Constructs;
using AWS.Domains.Options;

namespace AWS.CDK.Stacks
{
    public class ECRStack : Stack
    {
        public ECRStack(Construct parent, IStackProps props, AwsOptions awsOptions) : base(parent, awsOptions.Registry.Name, props)
        {
            new ECRRepositoryConstruct(this, awsOptions.Registry.Name, new RepositoryProps()
            {
                LifecycleRules = new LifecycleRule[]
                {
                    new LifecycleRule()
                    {
                        Description = awsOptions.Registry.Description,
                        MaxImageAgeDays = awsOptions.Registry.MaxDaysRetention,
                        TagStatus =  TagStatus.Tagged,
                        TagPrefixList = new string[]
                        {
                            awsOptions.Registry.Prefix
                        }
                    }
                },
                RemovalPolicy = RemovalPolicy.Destroy,
                RepositoryName = awsOptions.Registry.Name
            });
        }
    }
}
