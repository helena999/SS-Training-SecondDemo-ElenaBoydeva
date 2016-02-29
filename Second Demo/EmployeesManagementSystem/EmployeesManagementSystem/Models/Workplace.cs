namespace EmployeesManagementSystem.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Workplace
    {
        public Workplace()
        {
            this.Employees = new HashSet<Employee>();
        }
    
        public int TownID { get; set; }
        public string Name { get; set; }
    
        public virtual ICollection<Employee> Employees { get; set; }
    }
}
