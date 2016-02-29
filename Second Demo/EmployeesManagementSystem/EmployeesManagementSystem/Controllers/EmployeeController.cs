using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Mime;
using System.Web;
using System.Web.Mvc;
using EmployeesManagementSystem.Models;

namespace EmployeesManagementSystem.Controllers
{
    public class EmployeeController : Controller
    {
        private EmployeesManagementEntities db;

        public EmployeeController()
        {
            db = new EmployeesManagementEntities();
        }

        public ActionResult Index()
        {
            //employees list order by job Position DESC
            var employees = from e in db.Employees
                            orderby e.JobPositionID ascending
                            select e;

            return View(employees.ToList());

        }

        [HttpGet]
        public ActionResult Create()
        {
            Employee employee = new Employee();
            return View(employee);
        }

        [HttpPost]
        public ActionResult Create(Employee employee)
        {
            if (ModelState.IsValid)
            {
                db.Employees.Add(employee);
                try
                {
                    db.SaveChanges();
                }
                catch
                {

                    return RedirectToAction("FillAllTheFields", "Errors");
                }                
                return RedirectToAction("Index");
            }
            return View(employee);
        }

        public ActionResult Details(int id)
        {
            Employee employee = db.Employees.Find(id);

            return View(employee);
        }

        [HttpGet]
        public ActionResult Edit(int id)
        {
            Employee employee = db.Employees.Find(id);

            return View(employee);
        }

        [HttpPost]
        public ActionResult Edit(Employee employee)
        {
            if (ModelState.IsValid)
            {
                db.Entry(employee).State = EntityState.Modified;
                db.SaveChanges();

                return RedirectToAction("Index");
            }
            return View(employee);
        }

        //Method for getting managers by chosen job position
        public JsonResult GetManagers(string id)
        {
            List<SelectListItem> managerList = new List<SelectListItem>();
            managerList.Add(new SelectListItem { Text = "-No Manager-", Value = null });

            switch (id)
            {
                //if position is Delivery Director - managers can be only CEO
                case "2": managerList.AddRange((from m in db.Employees
                                                where m.JobPositionID == 1
                                                select m)
                                                      .AsEnumerable()
                                                      .Select(m => new SelectListItem()
                                                      {
                                                          Text = m.FirstName + " " + m.LastName,
                                                          Value = m.EmployeeID.ToString()
                                                      }));
                    break;

                //if position is Project Manager - managers can be only Delivery Director
                case "3": managerList.AddRange((from m in db.Employees
                                                where m.JobPositionID == 2
                                                select m)
                                                      .AsEnumerable()
                                                       .Select(m => new SelectListItem()
                                                       {
                                                           Text = m.FirstName + " " + m.LastName,
                                                           Value = m.EmployeeID.ToString()
                                                       }));
                    break;                
            }

            return Json(new SelectList(managerList, "Value", "Text", null));
        }

        protected override void Dispose(bool disposing)
        {

            db.Dispose();

            base.Dispose(disposing);
        }

    }
}