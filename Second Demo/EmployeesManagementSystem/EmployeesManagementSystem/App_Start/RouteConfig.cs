using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace EmployeesManagementSystem
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Team",
                url: "Team/AddEmployeeToTeam/{id}",
                defaults: new { controller = "Team", action = "AddEmployeeToTeam", 
                    id = UrlParameter.Optional }
            );

            routes.MapRoute(
            name: "TeamDetails",
            url: "Team/Details/{id}",
            defaults: new { controller = "Team", action = "Details", id = UrlParameter.Optional }
        );

            routes.MapRoute(
                name: "DeleteEmpFTeam",
                url: "Team/DeleteEmployeeFromTeam/{id}",
                defaults: new { controller = "Team", action = "DeleteEmployeeFromTeam", 
                    id = UrlParameter.Optional }
);

            routes.MapRoute(
                name: "Employee",
                url: "Team/DetailsOfEmployee/{id}",
                defaults: new { controller = "Employee", action = "Details", 
                    id = UrlParameter.Optional }
);

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
