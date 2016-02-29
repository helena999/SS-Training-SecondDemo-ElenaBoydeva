namespace EmployeesManagementSystem.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;
    using System.Web.Mvc;
    public partial class Team : IDisposable
    {
        private EmployeesManagementEntities db = new EmployeesManagementEntities();
        private bool disposed = false;

        public Team()
        {
            this.Employees = new HashSet<Employee>();
        }

        public int TeamID { get; set; }

        public string Name { get; set; }

        [Display(Name = "Manager")]
        public int ManagerID { get; set; }

        public virtual Employee Employee { get; set; }

        public virtual ICollection<Employee> Employees { get; set; }

        public SelectList GetManager()
        {
            IEnumerable<SelectListItem> managerList = (from m in db.Employees
                where m.JobPositionID == 3
                select m)
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
