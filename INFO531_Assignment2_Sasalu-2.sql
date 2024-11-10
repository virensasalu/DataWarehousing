

/*Q1. Show the screenshot of a successful installation of MySQL Software and MySQL Workbench with the latest version on your machine. 
Show the screenshot of the database “Worker” created.
Link: https://dev.mysql.com/downloads/file/?id=508935 NOTE: As part of MySQL Software installation, make sure you have installed MySQL Workbench. 
Using the MySQL Workbench, create a database called Worker. 
I repeat, the database must be named “Worker”. Use the below command: CREATE DATABASE Worker; Check if the database was created. 
Use with the following SQL command: SHOW DATABASES; Show the screenshot of the execution of the above statements and results.*/



CREATE DATABASE Worker;
SHOW DATABASES;


/*Q2. . Create the Department table in the Worker database (table must be based on Physical Model Provided in the Assignment folder). 
(a) Columns, Primary Key (PK), Data Type & length, and NULL/NOT NULL need to be implemented, as provided in the Physical Model. 
(b) Show the table definition (DDL) that you implemented. 
(c) Insert the complete set of data provided in the Excel file (uploaded in the Assignment folder) and show the insert statements used. 
(d) Retrieve the data from the Department table by using the SELECT * statement and order by PK column(s). 
Show the output. Make sure you show the print screen of the complete set of the rows and columns. The rows must be ordered by PK column(s).*/



USE Worker;
CREATE TABLE Department (
    DepartmentID TINYINT NOT NULL PRIMARY KEY,
    DepartmentNm CHAR(30) NOT NULL
);



INSERT INTO Department (DepartmentID, DepartmentNm) VALUES
(1, 'Research & Development'),
(2, 'Production'),
(3, 'IT Support'),
(4, 'Operations'),
(5, 'Customer Service'),
(6, 'Purchasing'),
(7, 'Sales & Marketing'),
(8, 'Human Resource Management'),
(9, 'Accounting and Finance'),
(10, 'Legal');

SELECT * FROM Department ORDER BY DepartmentID;

/*Q3. Create the Employee table in the Worker database (table must be based on Physical Model Provided in the Assignment folder). 
(a) Columns, Primary Key (PK), Data Type and length, and NULL/NOT NULL need to be implemented, as provided in the Physical Model. 
(b) Show the table definition (DDL) that you implemented (not in a graphical view). 
(c) Insert the complete set of data provided in the Excel file (uploaded in the Assignment folder) and show the insert statements used. 
(d) Retrieve the data from the Employee table by using the SELECT * statement and order by PK column(s).
 Show the output. Make sure you show the print screen of the complete set of the rows and columns. The rows must be ordered by PK column(s).*/

USE Worker;

CREATE TABLE Employee (
    EmployeeID INTEGER NOT NULL PRIMARY KEY,
    DepartmentID TINYINT NOT NULL,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Address VARCHAR(50),
    PhoneNumberTxt VARCHAR(15),
    HireDate DATE NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);


INSERT INTO Employee (EmployeeID, DepartmentID, FirstName, LastName, Address, PhoneNumberTxt, HireDate ) VALUES
(1, 2, 'Andy', 'Wong', '345 South Street', '(603) 555-6880', ' 2001-01-15,') ,
(2, 1, 'John', 'Wilson', '560 Broadway', '(518) 555-6690', '2017-03-19'),
(3, 3, 'Vivek', 'Pandey', '15 Mineral Drive', '(603) 555-4420', '2003-11-15'),
(4, 7 , 'Nola','Davis', '15 Long Ave', '(478) 555-8822', '2016-03-23'),
(5, 8, 'Kathy', 'Cooper', '15 Hatter Drive','(212) 555-9630','2011-11-18' ),
(6, 9, 'Tom','Harper','64 Highland Street','(212) 555-7755', '2010-04-11')
;

SELECT * FROM Employee ORDER BY EmployeeID;



/*Q4. Create the Equipment table in the Worker database (table must be based on Physical Model Provided in the Assignment folder). 
(a) Columns, Primary Key (PK), Data Type & length, and NULL/NOT NULL need to be implemented, as provided in the Physical Model. 
(b) Show the table definition (DDL) that you implemented. 
(c) Insert the complete set of data provided in the Excel file (uploaded in the Assignment folder) and show the insert statements used. 
(d) Retrieve the data from the Equipment table by using the SELECT * statement and order by PK column(s). Show the output.
 Make sure you show the print screen of the complete set of the rows and columns. The rows must be ordered by PK column(s).*/

USE Worker;
CREATE TABLE Equipment (
EquipmentID INTEGER NOT NULL PRIMARY KEY,
EquipmentName VARCHAR(30) NOT NULL,
EquipmentCostAmount DECIMAL(13,2)
);

INSERT INTO Equipment(EquipmentID, EquipmentName, EquipmentCostAmount) VALUES
('1','Notebook Computers','1000.00'),
('2','Headsets','250.00'),
('3','Computer Monitor','185.00'),
('4','Multi-Function Printers','1250.00'),
('5','Projector or a Big Screen TV','1600.50'),
('6','Servers','4500.00'),
('7','Internet Modem','80.75'),
('8','Cell Phone','999.99')
;
SELECT * FROM Equipment ORDER BY EquipmentID;



/*Q5. Create the EmployeeEquipment table in the Worker database (table must be based on Physical Model Provided in the Assignment folder). 
(a) Columns, Primary Key (PK), Data Type & length, and NULL/NOT NULL need to be implemented, as provided in the Physical Model. 
(b) Show the table definition (DDL) that you implemented. 
(c) Insert the complete set of data provided in the Excel file (uploaded in the Assignment folder) and show the insert statements used. 
(d) Retrieve the data from the EmployeeEquipment table by using the SELECT * statement and order by PK column(s). 
Show the output. Make sure you show the print screen of the complete set of the rows and columns. The rows must be ordered by PK column(s).*/


USE Worker;
CREATE TABLE EmployeeEquipment (
	EmployeeID INTEGER NOT NULL,
    EquipmentID INTEGER NOT NULL,
    
    PRIMARY KEY ( EmployeeID, EquipmentID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID)
    
);

INSERT INTO EmployeeEquipment(EmployeeID, EquipmentID) VALUES
(1, 1),
(2, 1),
(2, 3),
(3, 1),
(3, 2),
(3, 3),
(4, 1),
(4, 2),
(5, 1),
(5, 2),
(5, 3),
(6, 1),
(6, 3)
;

SELECT * FROM EmployeeEquipment ORDER BY EmployeeID;

/*Q6. Create the Training table in the Worker database (table must be based on Physical Model Provided in the Assignment folder). 
(a) Columns, Primary Key (PK), Data Type & length, and NULL/NOT NULL need to be implemented, as provided in the Physical Model. 
(b) Show the table definition (DDL) that you implemented. 
(c) Insert the complete set of data provided in the Excel file (uploaded in the Assignment folder) and show the insert statements used. 
(d) Retrieve the data from the Training table by using the SELECT * statement and order by PK column(s). 
Show the output. Make sure you show the print screen of the complete set of the rows and columns. The rows must be ordered by PK column(s).

*/



USE Worker;
CREATE TABLE Training(
TrainingID INTEGER NOT NULL PRIMARY KEY,
TrainingName VARCHAR(50) NOT NULL
);


INSERT INTO Training (TrainingID, TrainingName) VALUES 
(1, 'COVID-19 Awareness and Protection Training'),
(2, 'Code of Conduct Training'),
(3, 'Safety Traning'),
(4, 'Intro to Python'),
(5, 'Machine Learning'),
(6, 'Microsoft Certifications'),
(7, 'Security and Privacy'),
(8, 'Product Knowledge'),
(9, 'Sales Skills'),
(10, 'Employee Relations'),
(11, 'Travel and Expense Management')

;
SELECT * FROM Training ORDER BY TrainingID;

/*Q7. Create the EmployeeTraining table in the Worker database (table must be based on Physical Model Provided in the Assignment folder). 
(a) Columns, Primary Key (PK), Data Type & length, and NULL/NOT NULL need to be implemented, as provided in the Physical Model. 
(b) Show the table definition (DDL) that you implemented. 
(c) Insert the complete set of data provided in the Excel file (uploaded in the Assignment folder) and show the insert statements used. 
(d) Retrieve the data from the EmployeeTraining table by using the SELECT * statement and order by PK column(s). 
Show the output. Make sure you show the print screen of the complete set of the rows and columns. The rows must be ordered by PK column(s).*/


CREATE TABLE EmployeeTraining (
EmployeeID INTEGER NOT NULL,
TrainingID INTEGER NOT NULL,
PRIMARY KEY ( EmployeeID, TrainingID),
FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
FOREIGN KEY (TrainingID) REFERENCES Training(TrainingID)
);

INSERT INTO EmployeeTraining(EmployeeID, TrainingID) VALUES 
(1,2), 
(1,3), 
(2,2), 
(2,4), 
(2,5), 
(3,2), 
(3,6), 
(3,7), 
(4,2), 
(4,8), 
(4,9), 
(5,2), 
(5,10),
(6,2), 
(6,11)
;

SELECT * FROM EmployeeTraining ORDER BY EmployeeID;

/*Q8. Create the Trainer table in the Worker database (table must be based on Physical Model Provided in the Assignment folder). 
(a) Columns, Primary Key (PK), Data Type & length, and NULL/NOT NULL need to be implemented, as provided in the Physical Model. 
(b) Show the table definition (DDL) that you implemented. 
(c) Insert the complete set of data provided in the Excel file (uploaded in the Assignment folder) and show the insert statements used. 
(d) Retrieve the data from the Trainer table by using the SELECT * statement and order by PK column(s). 
Show the output. Make sure you show the print screen of the complete set of the rows and columns. The rows must be ordered by PK column(s).*/



CREATE TABLE Trainer(
TrainerID INTEGER NOT NULL PRIMARY KEY,
TrainingID INTEGER NOT NULL,
TrainerFirstName VARCHAR(20) NOT NULL,
TrainerLastName VARCHAR(20) NULL,
FOREIGN KEY (TrainingID) REFERENCES Training(TrainingID)
);

INSERT INTO Trainer (TrainerID, TrainingID, TrainerFirstName, TrainerLastName)VALUES 
(1, 1, 'James', 'Smith'),
(2, 1, 'Johnny', 'Khor'),
(3, 2, 'Michael', 'Smith'),
(4, 3, 'Maria', 'Garcia'),
(5, 4, 'John', NULL),
(6, 4, 'Paul', 'Deitel'),
(7, 5, 'Mike', 'Taylor'),
(8, 5, 'Avinash', 'Navlani'),
(9, 6, 'Robert', 'Smith'),
(10, 7, 'Maria', 'Rodriguez'),
(11, 8, 'Mike', 'Donlon'),
(12, 9, 'Kathy', 'Corby'),
(13, 10, 'Mary', 'Garcia'),
(14, 10, 'Vanessa', NULL),
(15, 11, 'Jordan', NULL),
(16, 11, 'Maria', 'Hernandez')
;

SELECT * FROM Trainer ORDER BY TrainerID;

/*Q9. Retrieve the data from the Trainer table by using the SELECT * statement with filter, WHERE TrainerLastName IS NULL. Show the output. 
Make sure you show the print screen of the complete set of the rows and columns. The rows must be ordered by PK column(s).*/

SELECT * FROM Trainer WHERE TrainerLastName IS NULL;

/*Q10. By using the SHOW tables statements, show the list of tables you have created in the Worker database.
 Show the screenshot of the execution of the above statements and results. Make sure you show the print screen of the complete set of the rows and columns. 
 The rows must be ordered by PK column(s).*/


SHOW TABLES ;

/*Q11. Write a single-row subquery to display EmployeeID, FirstName, LastName, and HireDate of employees hired after employee Vivek Pandey. 
Sort the results by EmployeeID. Make sure you show the print screen of the complete set of the rows, and columns as specified.*/

SELECT EmployeeID, FirstName, LastName, HireDate
FROM Employee
WHERE HireDate > (SELECT HireDate FROM Employee WHERE FirstName = 'Vivek' AND LastName = 'Pandey')
ORDER BY EmployeeID
LIMIT 1;

 /*Q12. Write a query to display FirstName, LastName, and TrainingName for employee Tom Harper. Sort the results by TrainingName. 
 Make sure you show the print screen of the complete set of the rows, and columns as specified.*/
 
SELECT 
    e.FirstName, 
    e.LastName, 
    t.TrainingName
FROM 
    Worker.Employee AS e
INNER JOIN 
    Worker.EmployeeTraining AS et ON e.EmployeeID = et.EmployeeID
INNER JOIN 
    Worker.Training AS t ON et.TrainingID = t.TrainingID
WHERE 
    e.FirstName = 'Tom' 
    AND e.LastName = 'Harper'
ORDER BY 
    t.TrainingName;


/*Q13. Write a query to display the complete list of Trainings, and trainers (first and last name) available for each training. 
Sort the output by TrainingName and Trainers' first and last name. Make sure you show the print screen of the complete set of the rows, and columns as specified.*/


SELECT 
    t.TrainingName, 
    tr.TrainerFirstName, 
    tr.TrainerLastName
FROM 
    Worker.Training AS t
INNER JOIN 
    Worker.Trainer AS tr ON t.TrainingID = tr.TrainingID
ORDER BY 
    t.TrainingName, 
    tr.TrainerFirstName, 
    tr.TrainerLastName;


/*Q14. Write a multiple-row subquery to display EmployeeID, FirstName, LastName, and HireDate of employees who work for the following departments: 
Accounting and Finance, IT Support, and Production. Sort the results by EmployeeID. Make sure you show the print screen of the complete set of the rows, 
and columns as specified.*/


SELECT EmployeeID, FirstName, LastName, HireDate
FROM Employee
WHERE DepartmentID IN (
    SELECT DepartmentID
    FROM Department
    WHERE DepartmentNM IN ('Accounting and Finance', 'IT Support', 'Production')
)
ORDER BY EmployeeID;


/*Q15. Write a query to display the EmployeeID, FirstName, LastName, EquipmentName, and EquipmentCostAmount for one of the employees. 
Sort the results by EmployeeID. Make sure you show the print screen of the complete set of the rows, and columns as specified.*/


SELECT 
    e.EmployeeID, 
    e.FirstName, 
    e.LastName, 
    eq.EquipmentName, 
    eq.EquipmentCostAmount
FROM 
    Employee AS e
JOIN 
    EmployeeEquipment AS ee ON e.EmployeeID = ee.EmployeeID
JOIN 
    Equipment AS eq ON ee.EquipmentID = eq.EquipmentID
ORDER BY 
    e.EmployeeID;
    

/*Q16. Write a query to display the TrainingID, TrainingName, TrainerID, TrainerFirstName, and TrainerLastName with the trainers who did not provide their last name.
 Sort the results by TrainingID and TrainerID. Make sure you show the print screen of the complete set of the rows, and columns as specified.*/
    
    
SELECT 
    t.TrainingID, 
    t.TrainingName, 
    tr.TrainerID, 
    tr.TrainerFirstName, 
    tr.TrainerLastName
FROM 
    Training AS t
JOIN 
    Trainer AS tr ON t.TrainingID = tr.TrainingID
WHERE 
    tr.TrainerLastName IS NULL
ORDER BY 
    t.TrainingID, 
    tr.TrainerID;

   
   /*Q17. Write a query to display the distinct list of equipments used by the current employees.
   Sort the output by EquipmentName.
   Make sure you show the print screen of the complete set of the rows, and columns as specified.*/
   

SELECT DISTINCT EquipmentName
FROM EmployeeEquipment AS ee
JOIN Equipment AS eq ON ee.EquipmentID = eq.EquipmentID
ORDER BY EquipmentName;

/*Q18. Write a query to display the FirstName, LastName, TrainingName, and trainer(s) (with first and last name in two separate columns) for one of the employees. 
Sort the results by TrainingName and TrainerFirstName. 
Make sure you show the print screen of the complete set of the rows, and columns as specified.*/


SELECT 
    e.FirstName, 
    e.LastName, 
    t.TrainingName, 
    tr.TrainerFirstName, 
    tr.TrainerLastName
FROM 
    Employee AS e
JOIN 
    EmployeeTraining AS et ON e.EmployeeID = et.EmployeeID
JOIN 
    Training AS t ON et.TrainingID = t.TrainingID
LEFT JOIN 
    Trainer AS tr ON t.TrainingID = tr.TrainingID
ORDER BY 
    t.TrainingName, 
    tr.TrainerFirstName
    LIMIT 1;



/*Q19. Write a query to display the EmployeeID, FirstName, LastName, DepartmentID, DepartmentName, EquipmentID, EquipmentName for all employees.
 Sort the results by EmployeeID, DepartmentID, and EquipmentID. 
 Make sure you show the print screen of the complete set of the rows, and columns as specified.*/


SELECT 
    e.EmployeeID, 
    e.FirstName, 
    e.LastName, 
    e.DepartmentID, 
    d.DepartmentNm, 
    ee.EquipmentID, 
    eq.EquipmentName
FROM 
    Employee AS e
JOIN 
    Department AS d ON e.DepartmentID = d.DepartmentID
LEFT JOIN 
    EmployeeEquipment AS ee ON e.EmployeeID = ee.EmployeeID
LEFT JOIN 
    Equipment AS eq ON ee.EquipmentID = eq.EquipmentID
ORDER BY 
    e.EmployeeID, 
    e.DepartmentID, 
    ee.EquipmentID;


/*Q20. Write a query to display the EmployeeID, FirstName, LastName, DepartmentID, DepartmentName, TrainingID, TrainingName for all employees. 
Sort the results by EmployeeID, DepartmentID, and TrainingID. 
Make sure you show the print screen of the complete set of the rows, and columns as specified.*/



SELECT 
    e.EmployeeID, 
    e.FirstName, 
    e.LastName, 
    e.DepartmentID, 
    d.DepartmentNm, 
    et.TrainingID, 
    t.TrainingName
FROM 
    Employee AS e
JOIN 
    Department AS d ON e.DepartmentID = d.DepartmentID
LEFT JOIN 
    EmployeeTraining AS et ON e.EmployeeID = et.EmployeeID
LEFT JOIN 
    Training AS t ON et.TrainingID = t.TrainingID
ORDER BY 
    e.EmployeeID, 
    e.DepartmentID, 
    et.TrainingID;
