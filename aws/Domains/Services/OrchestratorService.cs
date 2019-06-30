using Amazon.CDK;
using Amazon.CDK.AWS.EC2;
using Amazon.CDK.AWS.RDS;
using AWS.CDK.Stacks;
using AWS.Domains.Options;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System;
using System.IO;
using System.Threading.Tasks;

namespace AWS.Domains.Services
{
    public interface IOrchestratorService
    {
        Task OrchestrateAsync();
    }

    public class OrchestratorService : IOrchestratorService
    {
        private readonly ILogger<OrchestratorService> _logger;
        private AwsOptions _awsOptions;

        public OrchestratorService(
            ILogger<OrchestratorService> logger,
            IOptions<AwsOptions> awsOptions)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _awsOptions = awsOptions.Value ?? throw new ArgumentNullException(nameof(awsOptions));
        }

        public async Task OrchestrateAsync()
        {
            var directory = Path.Combine(Directory.GetCurrentDirectory(), "manifest");

            Directory.CreateDirectory(directory);

            var app = AWS(directory);

            Directory.Delete(directory, true);

            app.Synth();
        }

        private App AWS(string directory)
        {
            var app = new App(new AppProps()
            {
                RuntimeInfo = true,
                Outdir = directory
            });

            var options = new StackProps()
            {
                Env = new Amazon.CDK.Environment()
                {
                    Account = _awsOptions.Account,
                    Region = _awsOptions.Region
                },
                StackName = "KMS"
            };

            ECR(app, options);
            RDS(app, options);

            return app;
        }
        
        private void ECR(App app, StackProps options)
        {
            _logger.LogInformation("===== ECR");

            new ECRStack(
                app,
                options,
                _awsOptions);
        }
        
        private void RDS(App app, StackProps options)
        {
            _logger.LogInformation("===== RDS");

            new RDSStack(
                app,
                options,
                _awsOptions,
                DatabaseInstanceEngine.Mysql
                // new InstanceProps()
                // {
                //     InstanceType = new InstanceTypePair((InstanceClass)_awsOptions.Database.Instance.Class, (InstanceSize) _awsOptions.Database.Instance.Size),
                //     VpcSubnets = new SubnetSelection()
                //     {
                //         SubnetName = _awsOptions.Database.Instance.Subnet.Name,
                //         SubnetType = (SubnetType) _awsOptions.Database.Instance.Subnet.Type,
                //     }
                // }
                );
        }
    }
}