USE [db_academy_19.04]
GO

INSERT INTO Faculties (Name) VALUES ('Computer Science'), ('Engineering'), ('Mathematics');

INSERT INTO Departments (Building, Financing, Name, FacultyId) VALUES 
('CS Building', 150000, 'Computer Science Department', 1),
('Engineering Building', 120000, 'Engineering Department', 2),
('Mathematics Building', 100000, 'Mathematics Department', 3);

INSERT INTO Groups (Name, Year, DepartmentId) VALUES 
('CS101', 1, 1),
('CS201', 2, 1),
('ENG101', 1, 2),
('ENG201', 2, 2),
('MATH101', 1, 3),
('MATH201', 2, 3);

INSERT INTO Students (Name, Rating, Surname) VALUES 
('John', 4.5, 'Doe'),
('Jane', 4.8, 'Smith'),
('Alice', 4.3, 'Johnson'),
('Bob', 4.7, 'Williams');

INSERT INTO Curators (Name, Surname) VALUES 
('Michael', 'Brown'),
('Emily', 'Davis'),
('David', 'Wilson');

INSERT INTO Subjects (Name) VALUES 
('Introduction to Computer Science'),
('Mathematics for Engineers'),
('Software Engineering');

INSERT INTO Teachers (IsProfessor, Name, Salary, Surname) VALUES 
(1, 'Professor', 60000, 'Anderson'),
(0, 'John', 50000, 'Smith'),
(0, 'Emily', 55000, 'Johnson');

INSERT INTO Lectures (Date, SubjectId, TeacherId) VALUES 
('2024-04-01', 1, 1),
('2024-04-02', 2, 2),
('2024-04-03', 3, 3);

INSERT INTO GroupsStudents (GroupId, StudentId) VALUES 
(1, 1),
(1, 2),
(2, 3),
(2, 4);

INSERT INTO GroupsLectures (GroupId, LectureId) VALUES 
(1, 1),
(2, 1),
(3, 2),
(4, 2);

INSERT INTO GroupsCurators (CuratorId, GroupId) VALUES 
(1, 1),
(2, 2),
(3, 3);
