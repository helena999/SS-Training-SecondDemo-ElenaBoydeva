namespace EmployeesManagementSystem.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Linq;
    using System.Web.Mvc;

    public partial class Employee : IDisposable
    {
        EmployeesManagementEntities db = new EmployeesManagementEntities();
        private bool disposed = false;

        public Employee()
        {
            this.Employees1 = new HashSet<Employee>();
            this.Teams = new HashSet<Team>();
            this.Teams1 = new HashSet<Team>();
        }
    
        public int EmployeeID { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public int JobPositionID { get; set; }

        public decimal Salary { get; set; }

        [Display(Name = "Workplace")]
        public int TownID { get; set; }

        public string Email { get; set; }

        [Display(Name = "Phone")]
        public string Phone { get; set; }

        public Nullable<int> ManagerID { get; set; }
    
        public virtual ICollection<Employee> Employees1 { get; set; }
        public virtual Employee Employee1 { get; set; }
        public virtual JobPosition JobPosition { get; set; }
        public virtual Workplace Workplace { get; set; }
        public virtual ICollection<Team> Teams { get; set; }
        public virtual ICollection<Team> Teams1 { get; set; }

        public SelectList GetJobPosition()
        {
            IEnumerable<SelectListItem> jobPositionList = (from j in db.JobPositions
                                                           select j).AsEnumerable().Select(j => new                                     SelectListItem()
                                                           {
                                                               Text = j.Name,
                                                               Value = j.JobPositionID.ToString()
                                                           });

            return new SelectList(jobPositionList, "Value", "Text", JobPositionID);
        }

        public SelectList GetWorkplace()
        {
            IEnumerable<SelectListItem> workplaceList = (from w in db.Workplaces select w)
                                                        .AsEnumerable()
                                                        .Select(w => new SelectListItem()
                                                         {
                                                            Text = w.Name,
                                                            Value = w.TownID.ToString()
                                                         });

            return new SelectList(workplaceList, "Value", "Text", TownID);
        }

        public SelectList GetManager()
        {
            IEnumerable<SelectListItem> managerList = (from m in db.Employees select m)
                                                      .AsEnumerable()
                                                      .Select(m => new SelectListItem()
                                                       {
                                                          Text = m.FirstName + " " + m.LastName,
                                                          Value = m.EmployeeID.ToString()
                                                       });

            return new SelectList(managerList, "Value", "Text", ManagerID);
        }

        #region IDisposable Members


        protected virtual void Dispose(bool disposing)
        {

            if (!this.disposed)
                if (disposing)
                    db.Dispose();

            this.disposed = true;
        }

        public void Dispose()
        {

            Dispose(true);
            GC.SuppressFinalize(this);
        }       
        #endregion

    }
}
