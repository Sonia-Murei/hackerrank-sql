Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE (CITY NOT LIKE "a%" AND CITY NOT LIKE "e%" AND CITY NOT LIKE "i%" AND CITY NOT LIKE "o%" AND CITY NOT LIKE "u%") OR (CITY NOT LIKE "%a" AND CITY NOT LIKE "%e" AND CITY NOT LIKE "%i" AND CITY NOT LIKE "%o" AND CITY NOT LIKE "%u");

Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE (CITY NOT LIKE "a%" AND CITY NOT LIKE "e%" AND CITY NOT LIKE "i%" AND CITY NOT LIKE "o%" AND CITY NOT LIKE "u%") AND (CITY NOT LIKE "%a" AND CITY NOT LIKE "%e" AND CITY NOT LIKE "%i" AND CITY NOT LIKE "%o" AND CITY NOT LIKE "%u");

Query the Name of any student in STUDENTS who scored higher than 75 Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
SELECT NAME FROM STUDENTS WHERE MARKS > 75 ORDER BY RIGHT(NAME,3),ID ASC; / 
* The RIGHT function is used to extract the last three characters of the NAME field for sorting purposes. The primary sort is done on these last three characters, and if there are ties, the secondary sort is done on the ID in ascending order. * /
SELECT NAME FROM STUDENTS WHERE MARKS > 75 ORDER BY SUBSTR(NAME,-3),ID ASC;
* The SUBSTR function with a negative starting position is used to extract the last three characters of the NAME field for sorting purposes. The primary sort is done on these last three characters, and if there are ties, the secondary sort is done on the ID in ascending order. * /

Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
SELECT name FROM EMPLOYEE ORDER BY NAME ASC;

Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than $2000  per month who have been employees for less than 10 months. Sort your result by ascending employee_id.
SELECT name FROM Employee WHERE salary > 2000 AND months < 10
ORDER BY employee_id ASC;

You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.If the End_Date of the tasks are consecutive, then they are part of the same project. Samantha is interested in finding the total number of different projects completed.
Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. If there is more than one project that have the same number of completion days, then order by the start date of the project.
SELECT
 start_date ,min(end_date) from
-- start dates not in end dates
(Select start_date from projects Where start_date not in (select end_date from projects))st,
-- endates not in start dates
(Select end_date from projects Where end_date not in (select start_date from projects))ed
Where start_date<end_date
group by start_date
order by min(end_date) - start_date ASC ,start_date ASC;

    My Answer(where I got stuck):
SELECT Start_Date,End_Date, DATEDIFF(End_Date,Start_Date) FROM Projects ORDER BY DATEDIFF(End_Date,Start_Date), Start_Date ASC;

You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary (offered salary in $ thousands per month).
Write a query to output the names of those students whose best friends got offered a higher salary than them. Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.

What to do: For each student:
Get their salary
Get their best friend’s ID
Get the friend’s salary
Compare → keep only cases where friend’s salary > student’s salary
Output student name, ordered by friend’s salary

SELECT Students.Name FROM Students
JOIN Friends ON Students.ID = Friends.ID
JOIN Packages ON Students.ID = Packages.ID
JOIN Packages p2 ON Friends.Friend_ID = p2.ID
WHERE p2.Salary > Packages.Salary ORDER BY p2.Salary;

n// Explanation of the query:
1. We start by selecting the Name from the Students table.
p2 → friend’s salary

Joins:
Students.ID = Friends.ID → match student to their friend record
Packages.ID = Students.ID → student’s salary
Packages p2.ID = Friends.Friend_ID → friend’s salary

 