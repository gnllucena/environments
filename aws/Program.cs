using AWS.Domains.Options;
using AWS.Domains.Services;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Serilog;
using System;
using System.IO;
using System.Threading.Tasks;

namespace AWS
{
    class Program
    {
        public static IConfiguration Configuration { get; } = new ConfigurationBuilder()
           .SetBasePath(Directory.GetCurrentDirectory())
           .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
           .AddJsonFile($"appsettings.{ Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Production" }.json", optional: true)
           .AddEnvironmentVariables()
           .Build();

        public static IHost BuildHost(string[] args) => new HostBuilder()
            .ConfigureAppConfiguration((hostContext, configuration) =>
            {
                configuration.AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);
                configuration.AddEnvironmentVariables();
            })
            .ConfigureServices((hostContext, services) =>
            {
                services.AddOptions();

                services.Configure<AwsOptions>(hostContext.Configuration.GetSection("AWS"));

                services.AddTransient<IOrchestratorService, OrchestratorService>();

                services.AddHostedService<HostService>();
            })
            .UseSerilog()
            .Build();

        public static async Task<int> Main(string[] args)
        {
            Log.Logger = new LoggerConfiguration()
                .Enrich.FromLogContext()
                .ReadFrom.Configuration(Configuration)
                .CreateLogger();

            try
            {
                var host = BuildHost(args);

                using (host)
                {
                    await host.StartAsync();
                }

                return 0;
            }
            catch
            {
                return 1;
            }
            finally
            {
                Log.CloseAndFlush();
            }
        }
    }
}
