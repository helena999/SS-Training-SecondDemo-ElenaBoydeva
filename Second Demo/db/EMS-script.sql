USE [master]
GO
/****** Object:  Database [EmployeesManagement]    Script Date: 29.2.2016 г. 04:11:20 ч. ******/
CREATE DATABASE [EmployeesManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmployeesManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\EmployeesManagement.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EmployeesManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\EmployeesManagement_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EmployeesManagement] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmployeesManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmployeesManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmployeesManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmployeesManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmployeesManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmployeesManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmployeesManagement] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [EmployeesManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmployeesManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmployeesManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmployeesManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmployeesManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmployeesManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmployeesManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmployeesManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmployeesManagement] SET  ENABLE_BROKER 
GO
ALTER DATABASE [EmployeesManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmployeesManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmployeesManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmployeesManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmployeesManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmployeesManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmployeesManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmployeesManagement] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EmployeesManagement] SET  MULTI_USER 
GO
ALTER DATABASE [EmployeesManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmployeesManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmployeesManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmployeesManagement] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [EmployeesManagement] SET DELAYED_DURABILITY = DISABLED 
GO
USE [EmployeesManagement]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 29.2.2016 г. 04:11:20 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[JobPositionID] [int] NOT NULL,
	[Salary] [money] NOT NULL,
	[TownID] [int] NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[ManagerID] [int] NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JobPositions]    Script Date: 29.2.2016 г. 04:11:20 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobPositions](
	[JobPositionID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_JobPosition] PRIMARY KEY CLUSTERED 
(
	[JobPositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TeamEmployee]    Script Date: 29.2.2016 г. 04:11:20 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamEmployee](
	[TeamID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
 CONSTRAINT [PK_TeamEmployee] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC,
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Teams]    Script Date: 29.2.2016 г. 04:11:20 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teams](
	[TeamID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ManagerID] [int] NOT NULL,
 CONSTRAINT [PK_Teams] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Workplaces]    Script Date: 29.2.2016 г. 04:11:20 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Workplaces](
	[TownID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Workplaces] PRIMARY KEY CLUSTERED 
(
	[TownID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Employees] FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Employees]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_JobPositions] FOREIGN KEY([JobPositionID])
REFERENCES [dbo].[JobPositions] ([JobPositionID])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_JobPositions]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Workplaces] FOREIGN KEY([TownID])
REFERENCES [dbo].[Workplaces] ([TownID])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Workplaces]
GO
ALTER TABLE [dbo].[TeamEmployee]  WITH CHECK ADD  CONSTRAINT [FK_TeamEmployee_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[TeamEmployee] CHECK CONSTRAINT [FK_TeamEmployee_Employees]
GO
ALTER TABLE [dbo].[TeamEmployee]  WITH CHECK ADD  CONSTRAINT [FK_TeamEmployee_Teams] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Teams] ([TeamID])
GO
ALTER TABLE [dbo].[TeamEmployee] CHECK CONSTRAINT [FK_TeamEmployee_Teams]
GO
ALTER TABLE [dbo].[Teams]  WITH CHECK ADD  CONSTRAINT [FK_Teams_Employees] FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Teams] CHECK CONSTRAINT [FK_Teams_Employees]
GO
USE [master]
GO
ALTER DATABASE [EmployeesManagement] SET  READ_WRITE 
GO
