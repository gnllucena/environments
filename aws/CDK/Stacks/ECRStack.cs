using Amazon.CDK;
using Amazon.CDK.AWS.ECR;
using AWS.CDK.Constructs;
using System;

namespace AWS.CDK.Stacks
{
    public class ECRStack : Stack
    {
        public ECRStack(Construct parent, string name, IStackProps props) : base(parent, name, props)
        {
            new ECRRepositoryConstruct(this, Guid.NewGuid().ToString(), new RepositoryProps()
            {
                LifecycleRegistryId = name,
                LifecycleRules = new LifecycleRule[]
                {
                    new LifecycleRule()
                    {
                        Description = "Default registry for staging account",
                        MaxImageAgeDays = 10,
                        TagStatus =  TagStatus.Tagged,
                        TagPrefixList = new string[]
                        {
                            "STAGING_"
                        }
                    }
                },
                RepositoryName = "Default name",
                Retain = true
            });
        }
    }
}
