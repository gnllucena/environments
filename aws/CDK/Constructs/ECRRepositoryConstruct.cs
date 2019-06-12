using Amazon.CDK;
using Amazon.CDK.AWS.ECR;

namespace AWS.CDK.Constructs
{
    public class ECRRepositoryConstruct : Construct
    {
        public ECRRepositoryConstruct(Construct parent, string id, IRepositoryProps options) : base(parent, id)
        {
            new Repository(this, id, options);
        }
    }
}
