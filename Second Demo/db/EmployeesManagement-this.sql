USE master
GO

CREATE DATABASE EmployeesManagement
GO

USE EmployeesManagement
GO

CREATE TABLE JobPositions(
JobPositionID int IDENTITY NOT NULL,
Name nvarchar(50) NOT NULL
CONSTRAINT PK_JobPosition PRIMARY KEY CLUSTERED(JobPositionID ASC)
)
GO

SET IDENTITY_INSERT JobPositions ON

INSERT INTO JobPositions(JobPositionID, Name)
VALUES (1, 'CEO')

INSERT INTO JobPositions(JobPositionID, Name)
VALUES (2, 'Delivery Director')

INSERT INTO JobPositions(JobPositionID, Name)
VALUES (3, 'Project Manager')

INSERT INTO JobPositions(JobPositionID, Name)
VALUES (4, 'Team Leader')

INSERT INTO JobPositions(JobPositionID, Name)
VALUES (5, 'Senior')

INSERT INTO JobPositions(JobPositionID, Name)
VALUES (6, 'Intermediate')

INSERT INTO JobPositions(JobPositionID, Name)
VALUES (7, 'Junior')

INSERT INTO JobPositions(JobPositionID, Name)
VALUES (8, 'Trainee')

SET IDENTITY_INSERT JobPositions OFF
GO

CREATE TABLE Workplaces(
TownID int IDENTITY NOT NULL,
Name nvarchar(50) NOT NULL
CONSTRAINT PK_Workplaces PRIMARY KEY CLUSTERED(TownID ASC)
)
GO

SET IDENTITY_INSERT Workplaces ON

INSERT INTO Workplaces(TownID,Name)
VALUES(1, 'Sofia')

INSERT INTO Workplaces(TownID,Name)
VALUES(2, 'Plovdiv')

INSERT INTO Workplaces(TownID,Name)
VALUES(3, 'London')

INSERT INTO Workplaces(TownID,Name)
VALUES(4, 'Madrid')

INSERT INTO Workplaces(TownID,Name)
VALUES(5, 'New York')

SET IDENTITY_INSERT Workplaces OFF
GO

CREATE TABLE Employees(
  EmployeeID int IDENTITY NOT NULL,
  FirstName nvarchar(50) NOT NULL,
  LastName nvarchar(50) NOT NULL,
  JobPositionID int NOT NULL,
  Salary money NOT NULL,
  TownID int NOT NULL,
  Email nvarchar(50) NOT NULL,
  Phone nvarchar(50) NOT NULL,
  ManagerID int NULL,
  CONSTRAINT PK_Employees PRIMARY KEY CLUSTERED (EmployeeID ASC)
)
GO

SET IDENTITY_INSERT Employees ON

INSERT Employees(EmployeeID,FirstName,LastName,JobPositionID,Salary,TownID,Email,Phone,ManagerID)
VALUES(1,'Simeon', 'Slavchev', 1, $24000, 5, 'simeonslav@mail.us', +1243243242, null)

INSERT Employees(EmployeeID,FirstName,LastName,JobPositionID,Salary,TownID,Email,Phone,ManagerID)
VALUES(2,'John', 'Willson', 2, $15000, 5, 'johnjohn@mail.us', +142332534, 1)

INSERT Employees(EmployeeID,FirstName,LastName,JobPositionID,Salary,TownID,Email,Phone,ManagerID)
VALUES(3,'Plamen', 'Kolev', 2, $15000, 5, 'kolevplamen@mail.us', +124322342, 1)

INSERT Employees(EmployeeID,FirstName,LastName,JobPositionID,Salary,TownID,Email,Phone,ManagerID)
VALUES(4,'Irina', 'Smith', 2, $15000, 4, 'irinasmith@mail.com', +124324334, 1)

INSERT Employees(EmployeeID,FirstName,LastName,JobPositionID,Salary,TownID,Email,Phone,ManagerID)
VALUES(5,'David', 'Cholakov', 3, $10000, 3, 'cholakov@mail.com', +234324324, 2)

INSERT Employees(EmployeeID,FirstName,LastName,JobPositionID,Salary,TownID,Email,Phone,ManagerID)
VALUES(6,'Zhivko', 'Petrov', 3, $10000, 1, 'petrovsf@mail.com', +35924324, 2)

INSERT Employees(EmployeeID,FirstName,LastName,JobPositionID,Salary,TownID,Email,Phone,ManagerID)
VALUES(7,'Silvia', 'Petkova', 3, $10000, 1, 'silviaptk@mail.com', +35933224, 2)

INSERT Employees(EmployeeID,FirstName,LastName,JobPositionID,Salary,TownID,Email,Phone,ManagerID)
VALUES(8,'Yana', 'Petkova', 4, $7800, 2, 'ypetkova@mail.com', +543355423, 5)

INSERT Employees(EmployeeID,FirstName,LastName,JobPositionID,Salary,TownID,Email,Phone,ManagerID)
VALUES(9,'Alexandra', 'Slavova', 5, $5500, 1, 'alexsavova@mail.com', +35943323, 8)

INSERT Employees(EmployeeID,FirstName,LastName,JobPositionID,Salary,TownID,Email,Phone,ManagerID)
VALUES(10,'Pavlin', 'Tomov', 6, $4300, 1, 'pavlintomov@mail.com', +35954423, 11)

INSERT Employees(EmployeeID,FirstName,LastName,JobPositionID,Salary,TownID,Email,Phone,ManagerID)
VALUES(11, 'Igor', 'Ivanov', 6, $4300, 1, 'pavlintomov@mail.com', +35954423, 11)

INSERT Employees(EmployeeID,FirstName,LastName,JobPositionID,Salary,TownID,Email,Phone,ManagerID)
VALUES(12,'George', 'Rigov', 7, 2100, 2, 'gogog@mail.com', +35912223, 12)

INSERT Employees(EmployeeID,FirstName,LastName,JobPositionID,Salary,TownID,Email,Phone,ManagerID)
VALUES(13,'Teodor', 'Todorow', 8, 1000, 1, 'teotoe@mail.com', +35900923, 14)

INSERT Employees(EmployeeID,FirstName,LastName,JobPositionID,Salary,TownID,Email,Phone,ManagerID)
VALUES(14,'Yung', 'Ing', 8, 1000, 5, 'yunging@mail.com', +1120923, null)

SET IDENTITY_INSERT Employees OFF
GO

CREATE TABLE Teams(
TeamID int IDENTITY NOT NULL,
Name nvarchar(50) NOT NULL,
ManagerID int NOT NULL,
CONSTRAINT PK_TeamProjects PRIMARY KEY CLUSTERED(TeamID ASC)
)
GO

SET IDENTITY_INSERT Teams ON

INSERT INTO Teams(TeamID,Name,ManagerID)
VALUES(1,'Lolo',5)

SET IDENTITY_INSERT Teams OFF

CREATE TABLE TeamEmployee(
TeamID int NOT NULL,
EmployeeID int NOT NULL
CONSTRAINT PK_TeamEmployee PRIMARY KEY CLUSTERED(TeamID ASC, EmployeeID ASC)
)
GO

INSERT INTO TeamEmployee(TeamID, EmployeeID)
VALUES (1, 8)

INSERT INTO TeamEmployee(TeamID, EmployeeID)
VALUES (1 ,11)

INSERT INTO TeamEmployee(TeamID, EmployeeID)
VALUES (1, 12)

INSERT INTO TeamEmployee(TeamID, EmployeeID)
VALUES (1, 13)

INSERT INTO TeamEmployee(TeamID, EmployeeID)
VALUES (1, 14)

INSERT INTO TeamEmployee(TeamID, EmployeeID)
VALUES (1, 15)
GO

ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_JobPositions FOREIGN KEY(JobPositionID)
REFERENCES JobPositions(JobPositionID)
GO

ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Employees FOREIGN KEY(ManagerID)
REFERENCES Employees(EmployeeID)
GO

ALTER TABLE TeamEmployee
ADD CONSTRAINT FK_TeamEmployee_Employees FOREIGN KEY(EmployeeID)
REFERENCES Employees(EmployeeID)
GO

ALTER TABLE TeamEmployee
ADD CONSTRAINT FK_TeamEmployee_Teams FOREIGN KEY(TeamID)
REFERENCES Teams(TeamID)
GO

ALTER TABLE Teams
ADD CONSTRAINT FK_Teams_Employees FOREIGN KEY(ManagerID)
REFERENCES Employees(EmployeeID)
GO

ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Workplaces FOREIGN KEY(TownID)
REFERENCES Workplaces(TownID)
GO
