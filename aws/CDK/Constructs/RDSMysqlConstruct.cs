using Amazon.CDK;
using Amazon.CDK.AWS.RDS;

namespace AWS.CDK.Constructs
{
    public class RDSMysqlConstruct : Construct
    {
        public RDSMysqlConstruct(Construct parent, string id, IRepositoryProps options) : base(parent, id)
        {
            //Amazon.CDK.AWS.RDS.

            // Amazon.CDK.AWS.RDS.DatabaseEngine.Mysql;

            // Amazon.CDK.AWS.RDS.DatabaseEngine.Mysql;
            new (this, id, options);
        }
    }
}
