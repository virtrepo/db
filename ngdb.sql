-- practical 1 -- mysql1
-- mysql -u root -P

CREATE DATABASE cinema;
use cinema;

CREATE TABLE CUSTOMERS(
    Custid VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(50),
    Contact_no VARCHAR(50),
    CONSTRAINT chk_contact_no_length CHECK(COUNT(Contact_no) <= 10);
);

CREATE TABLE MOVIE(
    MovieID VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    ActorName VARCHAR(50),
    ActresName VARCHAR(50),
    DirectorName VARCHAR(50),
    ReleaseName VARCHAR(50),
    CountryName VARCHAR(50),
    Price NUMERIC(9,2) CHECK(price > 0)
);

CREATE TABLE SCREEN (
    ScreenID VARCHAR(50) PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL,
    MovieID VARCHAR(50),
    Capacity VARCHAR(50),
    CONSTRAINT fk_movieid FOREIGN KEY (MovieID) REFERENCES MOVIE(MovieID)
);

CREATE TABLE TICKETS (
    TicketID VARCHAR(50) PRIMARY KEY NOT NULL
    MovieID VARCHAR(50)
    ScreenID VARCHAR(50)
    Date DATE,
    Price VARCHAR(50),
    CONSTRAINT FOREIGN KEY (MovieID) REFERENCES MOVIE(MovieID),
    CONSTRAINT FOREIGN KEY (ScreenID) REFERENCES SCREEN(ScreenID),
)


-- INSERT DATA IN DATABASE
INSERT INTO Customer (CustId, Name, Contact_no) VALUES ('C001', 'Rahul Sharma', '9876543210'),
('C002', 'Priya Singh', '9123456789'),
('C003', 'Arjun Mehta', '9988776655'),
('C004', 'Sneha Gupta', '8765432109'),
('C005', 'Aditi Verma', '9988112233');


-- //insert Query for Movie table
INSERT INTO Movie (MovieID, Name, ActorName, ActressName, DirectorName, ReleaseDate,
CountryName, Price) VALUES
('M001', 'Kabir Singh', 'Shahid Kapoor', 'Kiara Advani', 'Sandeep Reddy Vanga', '2019-06-21', 'India', 350.00), ('M002', 'Bajrangi Bhaijaan', 'Salman Khan', 'Harshaali Malhotra', 'Kabir Khan', '2015-07-17', 'India', 400.00), ('M003', '3 Idiots', 'Aamir Khan', 'Kareena Kapoor', 'Rajkumar Hirani', '2009-12-25', 'India', 300.00), ('M004', 'Dangal', 'Aamir Khan', 'Fatima Sana Shaikh', 'Nitesh Tiwari', '2016-12-23', 'India', 450.00), ('M005', 'Chennai Express', 'Shah Rukh Khan', 'Deepika Padukone', 'Rohit Shetty', '2013-08-09', 'India', 380.00);


-- //insert Query for Screen table
INSERT INTO Screen (ScreenID, Name, MovieID, Capacity) VALUES ('S001', 'PVR Juhu', 'M001', '200'),
('S002', 'Inox Mall', 'M002', '250'),
('S003', 'Cinepolis', 'M003', '300'),
('S004', 'SRS Cinemas', 'M004', '150'),
('S005', 'Big Cinemas', 'M005', '220');


-- //insert Query for Tickets table
INSERT INTO Tickets (TicketID, MovieID, ScreenID, Date, Price) VALUES ('T001', 'M001', 'S001', '2023-10-01', 350.00),
('T002', 'M002', 'S002', '2023-10-02', 400.00),
('T003', 'M003', 'S003', '2023-10-03', 300.00),
('T004', 'M004', 'S004', '2023-10-04', 450.00),
('T005', 'M005', 'S005', '2023-10-05', 380.00);



-- practical 2 -- mysql2
-- create tabe
CREATE TABLE Patient (
    Patient_id VARCHAR(10) PRIMARY KEY, 
    Patient_name VARCHAR(100), 
    Address VARCHAR(255), 
    Age INT, 
    Ailment VARCHAR(255)
);

CREATE TABLE Doctor (
    Doc_id VARCHAR(10) PRIMARY KEY, 
    Doc_name VARCHAR(255), 
    Specialization VARCHAR(100), 
    Qualification VARCHAR(100)
);

CREATE TABLE Admit (
    Bed_no VARCHAR(10), 
    Patient_id VARCHAR(10), 
    Doc_id VARCHAR(10), 
    Disease VARCHAR(100), 
    Dt_of_admit DATE, 
    Dt_of_discharge DATE,
    PRIMARY KEY (Bed_no, Patient_id), 
    FOREIGN KEY (Doc_id) REFERENCES Doctor(Doc_id) ON DELETE CASCADE
);

-- insert data into data table --
INSERT INTO Patient (Patient_id, Patient_name, Address, Age, Ailment) VALUES 
('P01', 'Santosh', 'Mumbai', 67, 'Heart attack'), 
('P02', 'Rohini', 'Bangalore', 65, 'Stroke'), 
('P03', 'Tilak', 'Mumbai', 54, 'Backache'), 
('P04', 'Rohini', 'Chennai', 34, 'Stomach ache'), 
('P05', 'Riddhi', 'Mumbai', 25, 'Fever');

INSERT INTO Doctor (Doc_id, Doc_name, Specialization, Qualification) VALUES 
('D01', 'Ragini', 'Cardiac', 'MD'), 
('D02', 'Rishav', 'Gynaecology', 'MD'), 
('D03', 'Somnath', 'Cardiac', 'MD'), 
('D04', 'Raghav', 'General', 'MD'), 
('D05', 'Royston', 'General', 'MBBS');

INSERT INTO Admit (Bed_no, Patient_id, Doc_id, Disease, Dt_of_admit, Dt_of_discharge) VALUES 
('B01', 'P01', 'D01', 'Heart related', '2023-01-22', '2023-01-25'), 
('B02', 'P02', 'D01', 'Heart related', '2024-02-11', '2024-03-12'), 
('B03', 'P05', 'D05', 'Dengue', '2024-03-15', '2024-03-22');

-- show the data in tables --
SELECT * FROM Patient;
SELECT * FROM Doctor;
SELECT * FROM Admit;

-- patient treated by dr Ragini
SELECT p.Patient_name 
FROM Patient p 
JOIN Admit a ON p.Patient_id = a.Patient_id 
JOIN Doctor d ON a.Doc_id = d.Doc_id 
WHERE d.Doc_name = 'Ragini';

-- Print the names of the patients who are not admitted 
SELECT Patient_name 
FROM Patient 
WHERE Patient_id NOT IN (SELECT Patient_id FROM Admit);

-- Print the details of the doctors who are General physicians.
SELECT * FROM Doctor WHERE Specialization = 'General';

-- Print the details of the docto who is treating Riddhi
SELECT d.* 
FROM Doctor d  
JOIN Admit a  
ON d.Doc_id = a.Doc_id 
JOIN Patient p  
ON a.Patient_id = p.Patient_id 
WHERE p.Patient_name = 'Riddhi';

--  Update the date_of_discharge for patient P01 to ‘26-01-2023’ 
UPDATE Admit 
SET Dt_of_discharge = '2023-01-26' 
WHERE Patient_id = 'P01';

SELECT * FROM Admit;

-- Rename the “Ailment” column of “Patient” table to symptoms.
ALTER TABLE Patient CHANGE Ailment Symptoms VARCHAR(255);

-- Delete the patients records who have not been admitted.
DELETE FROM Patient 
WHERE Patient_id NOT IN (SELECT Patient_id FROM Admit);

-- both qury check which was helpful

DELETE 
FROM Patient 
WHERE Patient_id NOT IN 
( 
SELECT p.Patient_id 
FROM Patient p  
JOIN Admit a  
ON p.Patient_id = a.Patient_id); 
 
SELECT * FROM Patient;

-- Delete the specialization column for the “Doctor” table 
ALTER TABLE Doctor DROP COLUMN Specialization;

--  Modify the data type of “Address” column from length 30 to 50.
ALTER TABLE Patient MODIFY Address VARCHAR(50);

-- practical 3 mongodb1
-- create data base library
use Library

-- craete table book
db.createCollection("book") 

-- Create the following collections as shown in the table in MongoDB
db.book.insertMany([ 
    { 
        Title: "Programming with Java", 
        Status_Info: [{ Accession_No: "BS001", Status: "Issued" }], 
        Book_Details_Info: { Author: "E Balaguruswamy", Cost: 350, Publisher_Name: 
"TMH" } 
    }, 
    { 
        Title: "ASP.NET 3.5 VB 2008", 
        Status_Info: [{ Accession_No: "BS002", Status: "Avail" }], 
        Book_Details_Info: { Author: "Anne Boehm", Cost: 650, Publisher_Name: 
"Murach" } 
    }, 
    { 
        Title: "Programming in VB", 
        Status_Info: [{ Accession_No: "BS003", Status: "Issued" }], 
        Book_Details_Info: { Author: "Julia Case Bradley", Cost: 600, Publisher_Name: 
"TMH" } 
    }, 
    { 
        Title: "Database System Concepts", 
        Status_Info: [{ Accession_No: "BS004", Status: "Issued" }], 
        Book_Details_Info: { Author: "Korth Sudarshan", Cost: 500, Publisher_Name: 
"TMH" } 
    }, 
    { 
        Title: "Distributed Systems", 
        Status_Info: [ 
            { Accession_No: "BS005", Status: "Avail" }, 
            { Accession_No: "BS006", Status: "Issued" }, 
            { Accession_No: "BS007", Status: "Issued" }, 
            { Accession_No: "BS008", Status: "Issued" }, 
            { Accession_No: "BS009", Status: "Avail" }, 
            { Accession_No: "BS010", Status: "Avail" }, 
            { Accession_No: "BS011", Status: "Avail" } 
        ], 
        Book_Details_Info: { Author: "Andrew S Tanenbaum", Cost: 350, 
Publisher_Name: "Pearson" } 
    }, 
    { 
        Title: "Let Us C", 
        Status_Info: [ 
            { Accession_No: "BS012", Status: "Issued" }, 
            { Accession_No: "BS013", Status: "Avail" }, 
            { Accession_No: "BS014", Status: "Avail" } 
        ], 
        Book_Details_Info: { Author: "Kanetkar Yashavant P.", Cost: 600, 
Publisher_Name: "B.P.B." } 
    }, 
    { 
        Title: "Modern Digital Electronics", 
        Status_Info: [ 
            { Accession_No: "BS015", Status: "Issued" }, 
            { Accession_No: "BS016", Status: "Avail" } 
        ], 
        Book_Details_Info: { Author: "Jain R.P.", Cost: 650, Publisher_Name: "TMH" } 
    }, 
    { 
        Title: "Computer Organization & Architecture", 
        Status_Info: [ 
            { Accession_No: "BS017", Status: "Issued" }, 
            { Accession_No: "BS018", Status: "Issued" }, 
            { Accession_No: "BS019", Status: "Avail" }, 
            { Accession_No: "BS020", Status: "Avail" } 
        ], 
        Book_Details_Info: { Author: "Stallings William", Cost: 600, Publisher_Name: 
"Dorling Kindersley" } 
    } 
])

-- Print all the records
db.book.find().pretty()

--  Print the Title where author is “E Balaguruswamy”
db.book.find({"Book_Details_Info.Author":"E Balaguruswamy"},{_id:0,Title:1})

-- Update the tile of book “Digital electronics” to “Ramakrishna” 
db.book.updateOne(
    { Title: "Modern Digital Electronics" },
    { $set: { Title: "Ramakrishna" } }
)

--  Print the collections where price of the book is greater than 500. 
db.book.find( 
    { "Book_Details_Info.Cost": { $gt: 500 } }  
).pretty()


-- practical 4 mongodb2
-- import json file in mongodb

-- Print the collection containing “Chinese” cuisine in “Manhattan”
db.restaurants.find(
{ cuisine: "Chinese", borough: "Manhattan" }
);

-- Write a MongoDB query to find the restaurants which do not prepare any cuisine of 
-- 'American ' and achieved a grade point 'A' not belongs to the borough Brooklyn. 
-- The document must be displayed according to the cuisine in descending order

db.restaurants.find(
{
cuisine: { $ne: "American " },
"grades.grade": "A",
borough: { $ne: "Brooklyn" }
}
).sort({ cuisine:-1 });

--  Print names of the restaurants which ends with “food"
db.restaurants.find(
 { name: { $regex: "food$", $options: "i" } },
 { name: 1, _id: 0 }
 );


-- Print the average score obtained by the restaurants if grouped by cuisine
db.restaurants.aggregate([
 { $unwind: "$grades" },
 { $group: { _id: "$cuisine", avgScore: { $avg: "$grades.score" } } },
 { $sort: { avgScore:-1 } }
 ]);

-- Print maximum score obtained as per the “Borough"
db.restaurants.aggregate([
 { $unwind: "$grades" },
 { $group: { _id: "$borough", maxScore: { $max: "$grades.score" } } },
 { $sort: { maxScore:-1 } }
 ]);

-- namenode format
hdfs namenode -format

-- practical 5 hadoop


-- hadoop setup
HADOOP_HOME
C:\hadoop
%HADOOP_HOME%\bin --path

-- Start Hadoop Name node and data node
-- please go inside the sbin directory and then run in some pc not working the comand
start-dfs.cmd 

--to chek the version of hadoop
hadoop version 

--to chek the running nodes
jps 

-- check the directory of / path with the hadoop
hadoop fs -ls /     
or
hdfs dfs -ls /

-- webui for browse files
http://localhost:9870  

-- make NEW subdirectory
hadoop fs -mkdir /BIGDATA-DS24322/MYROLL-DS24322   -- OR THE hdfs dfs

-- view sub directory
hadoop fs -ls /BIGDATA-DS24322/   -- OR THE hdfs dfs

-- make file as roll number in subdirectory
hadoop fs -touchz /BIGDATA-DS24322/MYROLL-DS24322/PRACTICAL-DS24322.txt

--create emoty file on the root folder
hadoop fs -touchz /PRACTICAL-DS24322.txt

-- append content available in the file
hdfs dfs -appendToFile "C:\Users\DIPESH\Videos\MSC DATA-SCIENCE\NGDB\dataset\tips2.csv" /PRACTICAL-DS24322.txt

-- view content available in the file
hdfs dfs -cat /PRACTICAL-DS24322.txt

-- put the file or copy the file form system to hadoop
hdfs dfs -put "C:\Users\DIPESH\Videos\MSC DATA-SCIENCE\NGDB\dataset\bank.csv" /

-- copy from hadoop to localsystem
hdfs dfs -get /PRACTICAL-DS24322.txt "C:\Users\DIPESH\Downloads\"

-- Create two folder folder_1 and folder_2 use mkdir command

-- copy file root to folder_1 
hdfs dfs -cp /PRACTICAL-DS24322.txt /folder_1/

-- move file from folder_1 to folder_2
hdfs dfs -mv /folder_1/PRACTICAL-DS24322.txt /folder_2

-- delete file without going to trash from directory
hdfs dfs -rm -skipTrash /folder_2/PRACTICAL-DS24322.txt

-- remove the directory folder_1
hdfs dfs -rm -r /folder_1

-- print the size fo files in kb
hdfs dfs -du -h /

-- practical 6 hadoop pig
hdfs dfs -ls /

-- copy file from local to Hadoop
hdfs dfs -put "C:\Users\DIPESH\Videos\MSC DATA-SCIENCE\NGDB\dataset\Never_Stop.txt" /

-- check again file via ls present or NOT

-- pig run
pig -x local

-- map reduce to perform word count of the file
-- load the file
-- lines = load 'hdfs://localhost:9000/Never_Stop.txt' using TextLoader() as (line:charArray);
lines = LOAD 'file:///C:/Users/DIPESH/Videos/MSC DATA-SCIENCE/NGDB/dataset/Never_Stop.txt' using TextLoader() as (line:charArray);

-- insert line in words
word_list = foreach lines generate FLATTEN(TOKENIZE(line)) as word;

-- group word
word_gr = group word_list by word;

-- word_count
word_count = foreach word_gr generate group, COUNT(word_list);

-- show word_count
dump word_count;


-- practical 7 word wrangling
start-fds.cmd
start-yarn.cmd

pig -x local -- for local Modern

-- load the file
bank_data = LOAD 'file:///C:/Users/DIPESH/Videos/MSC DATA-SCIENCE/NGDB/dataset/bank.csv'
USING PigStorage(',')  
AS (id:int, age:int, job:chararray, marital:chararray, education:chararray,  
    default:chararray, balance:int, housing:chararray, loan:chararray,  
    contact:chararray, day:int, month:chararray, duration:int,  
    campaign:int, pdays:int, previous:int, poutcome:chararray, y:chararray);

-- bankdata = LOAD 'hdfs://localhost:9000/bank.csv'
-- USING PigStorage(',')  
-- AS (id:int, age:int, job:chararray, marital:chararray, education:chararray,  
--     default:chararray, balance:int, housing:chararray, loan:chararray,  
--     contact:chararray, day:int, month:chararray, duration:int,  
--     campaign:int, pdays:int, previous:int, poutcome:chararray, y:chararray);


-- data_bank = LOAD '/bank.csv' USING PigStorage(',')
-- AS (id:int, age:int, job:chararray, marital:chararray, education:chararray,  
--     default:chararray, balance:int, housing:chararray, loan:chararray,  
--     contact:chararray, day:int, month:chararray, duration:int,  
--     campaign:int, pdays:int, previous:int, poutcome:chararray, y:chararray);

-- Display first 10 rows
DUMP bank_data;

--print 4 columns
columns = foreach bank_data generate age, job, balance, loan;

DUMP bank_data;

-- top 10 entry in the variable
top_10 = LIMIT bank_data 10;

DUMP top_10;

-- for married data
married_customers = filter bank_data by marital == 'married';

DUMP married_customers;

-- average balance of customers based on education
group_by_education = GROUP bank_data BY education;
avg_balance = FOREACH group_by_education GENERATE group, AVG(bank_data.balance);
DUMP avg_balance

-- number of customers taken the loan on marital status
loan_customers = FILTER bank_data BY loan == 'yes';
group_by_marital = GROUP loan_customers BY marital;
loan_count = FOREACH group_by_marital GENERATE group AS marital_status, COUNT(loan_customers) AS loan_count;
dump loan_count;

-- number of defaulters and non defaulters
default = GROUP bank_data BY default;
default_count = FOREACH default GENERATE group AS default_group, COUNT(bank_data) AS count;

-- loan taken more than 1000 days
long_duration = FILTER bank_data BY duration > 1000;
DUMP long_duration;


-- practical 8 hive

-- practical 10 neo4j
CREATE (:Product_node {pid: "p01", pname: "soap", comp_name: "lux", cost: 20}); 
CREATE (:Product_node {pid: "p01", pname: "soap", comp_name: "lux", cost: 20});  
CREATE (:Product_node {pid: "p03", pname: "toothpaste", comp_name: "colgate", cost: 100}); CREATE (:Order_node {orderid: "ord1", pid: "p01", qty: 5}); 
CREATE (:Order_node {orderid: "ord2", pid: "p01", qty: 2}); 
CREATE (:Order_node {orderid: "ord3", pid: "p02", qty: 2}); 
CREATE (:Order_node {orderid: "ord4", pid: "p01", qty: 1}); 
CREATE (:Order_node {orderid: "ord5", pid: "p02", qty: 2}); 
CREATE (:Order_node {orderid: "ord6", pid: "p04", qty: 5}); 
CREATE (:Order_node {orderid: "ord7", pid: "p05", qty: 2});


Create Relationships (Link Products to Orders)

MATCH (p:Product_node), (o:Order_node) WHERE p.pid = o.pid MERGE (p)-[:HAS_ORDER]->(o);

-- Queries to Fetch Data
-- Check the nodes in graphical & table format
MATCH (n:Product_node) RETURN n
MATCH (n:Order_node) RETURN n

-- Print the product names where price is more than or equal to 50
MATCH (p:Product_node) WHERE p.cost >= 50 RETURN p.pname AS Product_Name;

-- Print the product name, order ID, and quantity of the product ordered
MATCH (p:Product_node)-[:HAS_ORDER]->(o:Order_node) 
RETURN p.pname AS product_name, o.orderid AS order_id, o.qty AS quantity;

-- Print the number of items ordered for each product
MATCH (p:Product_node)-[:HAS_ORDER]->(o:Order_node) 
RETURN p.pname AS product_name, SUM(toInteger(o.qty)) AS total_quantity ORDER BY total_quantity DESC;

-- Select the average quantity of items available for category "entertainment"
MATCH (p:Product_node)-[:HAS_ORDER]->(o:Order_node) 
WHERE p.comp_name = "entertainment" 
RETURN AVG(toInteger(o.qty)) AS average_quantity;

Delete All Orders & Products
MATCH (o:Order_node) DETACH DELETE o; 
MATCH (p:Product_node) DETACH DELETE p;






