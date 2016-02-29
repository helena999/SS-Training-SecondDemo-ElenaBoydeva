namespace EmployeesManagementSystem.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class JobPosition
    {

        public JobPosition()
        {
            this.Employees = new HashSet<Employee>();
        }
    
        public int JobPositionID { get; set; }
        public string Name { get; set; }
    
        public virtual ICollection<Employee> Employees { get; set; }
    }
}
