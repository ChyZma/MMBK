using BusinessLogic.Common;
using BusinessLogic.Managers;

namespace CaffBackend.Config
{
    public static class DependencyInjectionConfig
    {
        public static void AddManagers(this IServiceCollection services)
        {
            services.AddScoped<ICaffManager, CaffManager>();
            services.AddScoped<ICaffCommentManager, CaffCommentManager>();
            services.AddScoped<ICurrentUser, CurrentUser>();
        }
    }
}
