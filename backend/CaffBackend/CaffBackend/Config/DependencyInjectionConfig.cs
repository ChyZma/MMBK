﻿using System.Runtime.CompilerServices;

namespace CaffBackend.Config
{
    public static class DependencyInjectionConfig
    {
        public static void AddManagers(this IServiceCollection services)
        {
            services.AddScoped<ICaffManager, CaffManager>();
        }
    }
}
