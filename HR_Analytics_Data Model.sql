CREATE DATABASE HR;
USE HR;

#Creating Department table

CREATE TABLE Departments (Dept_ID INT AUTO_INCREMENT PRIMARY KEY,
						  Dept_Name VARCHAR(50)
                          );
                          
#Creating Region Table
CREATE TABLE Regions (Region_ID INT AUTO_INCREMENT PRIMARY KEY,
					  Region_Name VARCHAR(50)
					 );
                     
#Creating Province Table
CREATE TABLE Provinces (Province_ID INT AUTO_INCREMENT PRIMARY KEY,
					  Province_Name VARCHAR(50)
					 );				
             
#Creating Employee Table
CREATE TABLE Employees (Emp_ID INT AUTO_INCREMENT PRIMARY KEY,
                        Dept_ID INT,
                        Region_ID INT,
                        Province_ID INT,
                        Education VARCHAR(50),
						Gender CHAR(6),
						Recruitment_Channel VARCHAR(50),
						Training_Count INT,
						Age INT,
						Age_Group VARCHAR(10),
						Previous_Year_Rating INT,
						Service_Length INT,
						KPIs_Met_Above_80 CHAR(3),
						Awards_Won CHAR(3),
						Avg_Training_Score INT,
                        FOREIGN KEY (Dept_ID) REFERENCES Departments (Dept_ID) ON UPDATE CASCADE ON DELETE CASCADE,
                        FOREIGN KEY (Region_ID) REFERENCES Regions (Region_ID) ON UPDATE CASCADE ON DELETE CASCADE,
                        FOREIGN KEY (Province_ID) REFERENCES Provinces (Province_ID) ON UPDATE CASCADE ON DELETE CASCADE
					 );             
             
