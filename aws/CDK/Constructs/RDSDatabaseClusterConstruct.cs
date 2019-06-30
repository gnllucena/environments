using Amazon.CDK;
using Amazon.CDK.AWS.RDS;

namespace AWS.CDK.Constructs
{
    public class RDSDatabaseClusterConstruct : Construct
    {
        public RDSDatabaseClusterConstruct(Construct parent, string id, IDatabaseInstanceProps options) : base(parent, id)
        {
            new DatabaseInstance(this, id, options);
        }
    }
}
