USE [db_academy_19.04]
GO

-- Task 1: Display building numbers if the total funding fund of the departments located in them exceeds 100,000.
SELECT Building
FROM Departments
GROUP BY Building
HAVING SUM(Financing) > 100000;

-- Task 2: Display the names of the groups of the 5th year of the department "Software Development," who have more than 10 lectures in the first week.
SELECT G.Name
FROM Groups G
JOIN Departments D ON G.DepartmentId = D.Id
JOIN Subjects S ON D.Name = 'Software Development'
JOIN GroupsLectures GL ON G.Id = GL.GroupId
JOIN Lectures L ON GL.LectureId = L.Id
WHERE G.Year = 5 AND L.Date BETWEEN '2024-04-01' AND '2024-04-07'
GROUP BY G.Name
HAVING COUNT(GL.LectureId) > 10;

-- Task 3: Display the names of groups that have a rating (average rating of all students of the group) higher than the rating of the group "D221."
SELECT G.Name
FROM Groups G
JOIN GroupsStudents GS ON G.Id = GS.GroupId
JOIN Students S ON GS.StudentId = S.Id
WHERE G.Id <> (SELECT Id FROM Groups WHERE Name = 'D221')
GROUP BY G.Name
HAVING AVG(S.Rating) > (SELECT AVG(Rating) FROM Students WHERE Id IN (SELECT StudentId FROM GroupsStudents WHERE GroupId = (SELECT Id FROM Groups WHERE Name = 'D221')));

-- Task 4: Display the names and surnames of teachers whose salary is higher than the average salary of professors.
SELECT Name, Surname
FROM Teachers
WHERE Salary > (SELECT AVG(Salary) FROM Teachers WHERE IsProfessor = 1);

-- Task 5: Display the names of groups that have more than one curator.
SELECT G.Name
FROM Groups G
JOIN GroupsCurators GC ON G.Id = GC.GroupId
GROUP BY G.Name
HAVING COUNT(GC.CuratorId) > 1;

-- Task 6: Display the names of groups that have a rating (average rating of all students of the group) less than the minimum rating of 5th year groups.
SELECT G.Name
FROM Groups G
JOIN GroupsStudents GS ON G.Id = GS.GroupId
JOIN Students S ON GS.StudentId = S.Id
WHERE G.Year = 5
GROUP BY G.Name
HAVING AVG(S.Rating) < (SELECT MIN(Rating) FROM Students WHERE Id IN (SELECT StudentId FROM GroupsStudents WHERE GroupId IN (SELECT Id FROM Groups WHERE Year = 5)));

-- Task 7: Display the names of faculties whose total funding fund for departments is greater than the total funding fund Departments of the Computer Science Faculty.
SELECT F.Name
FROM Faculties F
JOIN Departments D ON F.Id = D.FacultyId
GROUP BY F.Name
HAVING SUM(D.Financing) > (SELECT SUM(Financing) FROM Departments WHERE FacultyId = 1);

-- Task 8: Display the names of disciplines and full names of teachers who read the largest number of lectures among them.
SELECT S.Name AS Discipline, T.Name + ' ' + T.Surname AS Teacher
FROM Lectures L
JOIN Subjects S ON L.SubjectId = S.Id
JOIN Teachers T ON L.TeacherId = T.Id
GROUP BY S.Name, T.Name, T.Surname
HAVING COUNT(L.Id) = (
    SELECT MAX(CountLectures)
    FROM (
        SELECT COUNT(*) AS CountLectures
        FROM Lectures
        GROUP BY SubjectId
    ) AS LectureCounts
);

-- Task 9: Display the name of the discipline that reads the least lectures.
SELECT S.Name AS Discipline
FROM Lectures L
JOIN Subjects S ON L.SubjectId = S.Id
GROUP BY S.Name
HAVING COUNT(L.Id) = (
    SELECT MIN(CountLectures)
    FROM (
        SELECT COUNT(*) AS CountLectures
        FROM Lectures
        GROUP BY SubjectId
    ) AS LectureCounts
);

-- Task 10: Output the number of students and disciplines read at the Department of Software Development.
SELECT 
    (SELECT COUNT(*) FROM Students WHERE Id IN (SELECT StudentId FROM GroupsStudents WHERE GroupId IN (SELECT Id FROM Groups WHERE DepartmentId = (SELECT Id FROM Departments WHERE Name = 'Software Development')))) AS StudentCount,
    (SELECT COUNT(*) FROM Subjects WHERE Id IN (SELECT SubjectId FROM Lectures WHERE TeacherId IN (SELECT Id FROM Teachers WHERE IsProfessor = 1))) AS DisciplineCount;
