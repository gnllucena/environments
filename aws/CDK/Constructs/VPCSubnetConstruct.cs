using Amazon.CDK;
using Amazon.CDK.AWS.EC2;

namespace AWS.CDK.Constructs
{
    public class VPCSubnetConstruct : Construct
    {
        public VPCSubnetConstruct(Construct parent, string id, IVpcProps options) : base(parent, id)
        {
            new Vpc(this, id, options);
        }
    }
}
