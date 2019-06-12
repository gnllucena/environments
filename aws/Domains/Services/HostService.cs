using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace AWS.Domains.Services
{
    public class HostService : BackgroundService
    {
        private readonly IOrchestratorService _orchestratorService;
        private readonly ILogger<HostService> _logger;

        public HostService(
            IOrchestratorService orchestratorService,
            ILogger<HostService> logger)
        {
            _orchestratorService = orchestratorService ?? throw new ArgumentNullException(nameof(orchestratorService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        protected override async Task ExecuteAsync(CancellationToken cancellationToken)
        {
            using (_logger.BeginScope(Guid.NewGuid().ToString()))
            {
                try
                {
                    await _orchestratorService.OrchestrateAsync();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
    }
}