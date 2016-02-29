using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.DynamicData;
using System.Web.Mvc;
using EmployeesManagementSystem.Models;
using WebGrease.Css.Extensions;


namespace EmployeesManagementSystem.Controllers
{
    public class TeamController : Controller
    {        
        private EmployeesManagementEntities db;

        public TeamController()
        {
            db = new EmployeesManagementEntities();
        }

        public ActionResult Index()
        {
            var teams = from t in db.Teams
                            orderby t.TeamID ascending
                            select t;
            return View(teams.ToList());
        }

        [HttpGet]
        public ActionResult Create()
        {
            Team team = new Team();
            return View(team);
        }

        [HttpPost]
        public ActionResult Create(Team team)
        {
            if (ModelState.IsValid)
            {
                db.Teams.Add(team);
                db.SaveChanges();

                return RedirectToAction("Index");
            }

            return View(team);
        }

        [HttpGet]
        public ActionResult Delete(int id)
        {
            Team team = db.Teams.Find(id);
            ViewBag.tName = team.Name;
            ViewBag.mName = team.Employee.FirstName + " " + team.Employee.LastName;

            return View();
        }

        [HttpPost]
        public ActionResult Delete(int id, Team team)
        {
            team = db.Teams.Find(id);

            if (ModelState.IsValid)
            {
                foreach (var emp in team.Employees)
                {
                    emp.ManagerID = null;
                }

                team.Employees.Clear();
                db.Teams.Remove(team);
                db.SaveChanges();
            }

            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult Edit(int id)
        {
            Team team = db.Teams.Find(id);

            return View(team);
        }

        [HttpPost]
        public ActionResult Edit(int id, Team objTeam)
        {
            Team team = db.Teams.Find(id);

            if (ModelState.IsValid)
            {
                team.Name = objTeam.Name;
                team.ManagerID = objTeam.ManagerID;

                team.Employees.FirstOrDefault().ManagerID = team.ManagerID;

                db.SaveChanges();               
            }

            return RedirectToAction("Index");
        }

        public ActionResult Details(int id)
        {
            Team team = db.Teams.Find(id);

            var projectManager = team.Employee;
            var deliveryDirector = projectManager.Employee1;
            var ceo = deliveryDirector.Employee1;

            //to display in view the name of the current team, PM, DD and CEO
            ViewBag.PM = projectManager.FirstName + " " + projectManager.LastName;
            ViewBag.DD = deliveryDirector.FirstName + " " + deliveryDirector.LastName;
            ViewBag.CEO = ceo.FirstName + " " + ceo.LastName;
            ViewBag.TeamName = team.Name;

            IEnumerable<Employee> teamInfo = team.Employees.ToList().OrderBy(t => t.JobPositionID);

            return View(teamInfo);

        }

        [HttpGet]
        public ActionResult AddEmployeeToTeam(int id)
        {
            Team team = db.Teams.Find(id);

            var employees = from e in db.Employees.ToList()
                            where e.JobPositionID > 3 && e.ManagerID == null
                            orderby e.JobPosition ascending 
                            select new
                            {
                                EmployeeID = e.EmployeeID,
                                FullNameAndPosition = e.FirstName + " " + e.LastName + " - " + e.JobPosition.Name
                            };

            ViewBag.Employees = new SelectList(employees, "EmployeeID", "FullNameAndPosition");

            return View();
        }

        [HttpPost]
        public ActionResult AddEmployeeToTeam(int id, Employee emp)
        {
            Team team = db.Teams.Find(id);
            Employee employee = db.Employees.Find(emp.EmployeeID);

            bool hasTeamLeader = false;

            foreach (var empl in team.Employees)
            {
                if (empl.JobPosition.Name == "Team Leader" && employee.JobPosition.Name == "Team Leader")
                {
                    hasTeamLeader = true;
                }
            }
            if (hasTeamLeader)
            {
                return RedirectToAction("HasTeamLead", "Errors", new { id = team.TeamID }); 
            }                                

            var manager = new List<Employee>();

            if (ModelState.IsValid)
            {
                team.Employees.Add(employee);

                //assign employee to manager using switch cases for every job position and the boss is once higher position from employee
                try
                {
                    switch (employee.JobPosition.Name)
                    {
                        case "Trainee":
                            manager = team
                                     .Employees
                                     .Where(x => x.JobPosition.Name == "Junior")
                                     .ToList();

                            employee.ManagerID = manager.FirstOrDefault().EmployeeID;
                            break;

                        case "Junior":
                            manager = team
                                      .Employees
                                      .Where(x => x.JobPosition.Name == "Intermediate")
                                      .ToList();

                            employee.ManagerID = manager.FirstOrDefault().EmployeeID;
                            break;

                        case "Intermediate":
                            manager = team
                                      .Employees
                                      .Where(x => x.JobPosition.Name == "Senior")
                                      .ToList();

                            employee.ManagerID = manager.FirstOrDefault().EmployeeID;
                            break;

                        case "Senior":
                            manager = team
                                      .Employees
                                      .Where(x => x.JobPosition.Name == "Team Leader")
                                      .ToList();

                            employee.ManagerID = manager.FirstOrDefault().EmployeeID;
                            break;

                        case "Team Leader":
                            var projManager = team.Employee.EmployeeID;
                            employee.ManagerID = projManager;
                            break;
                    }

                    db.SaveChanges();
                }
                catch
                {
                    return RedirectToAction("Index", "Errors", new { id = team.TeamID });  
                }

                return RedirectToAction("Details", new { id = team.TeamID });
            }
            return View();
        }

        [HttpGet]
        public ActionResult DeleteEmployeeFromTeam(int id)
        {
            Employee employee = db.Employees.Find(id);

            return View(employee);
        }

        [HttpPost]
        public ActionResult DeleteEmployeeFromTeam(int id, Employee employee)
        {
            employee = db.Employees.Find(id);
            var idOfTeam = employee.Teams1.FirstOrDefault().TeamID;
            Team team = db.Teams.Find(idOfTeam);

            if (ModelState.IsValid)
            {
                team.Employees.Remove(employee);
                employee.ManagerID = null;
                db.SaveChanges();                
            }

            return RedirectToAction("Details", new { id = team.TeamID });
        }

        public ActionResult DetailsOfEmployee()
        {
            return RedirectToAction("Details", "Employee");       
        }
        protected override void Dispose(bool disposing)
        {
            db.Dispose();

            base.Dispose(disposing);
        }
    }
}