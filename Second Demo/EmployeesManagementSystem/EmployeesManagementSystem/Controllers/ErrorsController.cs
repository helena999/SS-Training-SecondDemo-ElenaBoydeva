using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EmployeesManagementSystem.Models;

namespace EmployeesManagementSystem.Controllers
{
    public class ErrorsController : Controller
    {
        private EmployeesManagementEntities db;

        public ErrorsController()
        {
            db = new EmployeesManagementEntities();
        }

        public ActionResult Index(int id)
        {
            Team team = db.Teams.Find(id);
            return View(team);
        }

        public ActionResult AddEmployeeToTeam(int id)
        {
            return RedirectToAction("Details", "Team", id);
        }

        public ActionResult HasTeamLead(int id)
        {
            Team team = db.Teams.Find(id);
            return View(team);
        }

        public ActionResult FillAllTheFields()
        {
            return View();
        }

        public ActionResult CreateEmployee()
        {
            return RedirectToAction("Create", "Employee"); ;
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();

            base.Dispose(disposing);
        }
    }
}