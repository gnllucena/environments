using Amazon.CDK;
using AWS.CDK.Stacks;
using Microsoft.Extensions.Logging;
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

        public OrchestratorService(
            ILogger<OrchestratorService> logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public async Task OrchestrateAsync()
        {
            var directory = Path.Combine(Directory.GetCurrentDirectory(), "manifest");

            _logger.LogInformation("===== LIMPANDO CONFIGURAÇÔES ANTERIORES");
            Directory.Delete(directory, true);

            _logger.LogInformation("===== CONFIGURANDO O CDK CLI");
            var appOptions = new AppProps()
            {
                RuntimeInfo = true,
                Outdir = directory
            };
            
            var app = new App(appOptions);

            _logger.LogInformation("===== ECR");
            new ECRStack(app, "ECR", new StackProps()
            {
                Env = new Amazon.CDK.Environment()
                {
                    Account = "985598771480",
                    Region = "us-east-1"
                },
                StackName = "ECR"
            });

            var output = app.Run();

            _logger.LogInformation(output.ToString());
        }
    }
}