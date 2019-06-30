using Amazon.CDK;
using AWS.Domains.Options;

namespace AWS.CDK.Stacks
{
    public class EKSStack : Stack
    {
        public EKSStack(Construct parent, IStackProps props, AwsOptions awsOptions) : base(parent, awsOptions.Database.Name, props)
        {
            //var cluster = new Cluster(this, "iddocluster", new ClusterProps()
            //{
            //    ClusterName = "NomeCluster",
            //    Vpc = new Vpc(),
            //    Role = new Role(this, "nomedarole", new RoleProps()
            //    {

            //    })
            //});

            //cluster.AddCapacity("", new AddWorkerNodesOptions()
            //{
            //    // keyName = ssh-key
            //    MinCapacity = 1,
            //    MaxCapacity = 1,
            //    DesiredCapacity = 1,
            //    InstanceType = new InstanceTypePair((InstanceClass)awsOptions.Database.Instance.Class, (InstanceSize)awsOptions.Database.Instance.Size),
            //    //NotificationsTopic = new Topic(this, "", new TopicProps()
            //    //{
                    
            //    //})
            //});

            // if (production)

            // cluster.AddAutoScalingGroup()

        }
    }
}
