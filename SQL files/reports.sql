USE MartialArtsSchoolDB;

-- Report Queries

-- Number of students enrolled in each class offering
SELECT m.MAID, m.name AS ClassName, COUNT(e.StudentID) AS TotalStudents
FROM MartialArts m
LEFT JOIN Enrolled e ON m.MAID = e.MAID
GROUP BY m.MAID, m.name
ORDER BY TotalStudents DESC;

-- Number of instructors assigned to each class offering
SELECT m.MAID, m.name AS ClassName, COUNT(t.InstructorID) AS TotalInstructors
FROM MartialArts m
LEFT JOIN Teaches t ON m.MAID = t.MAID
GROUP BY m.MAID, m.name
ORDER BY TotalInstructors DESC;

-- Class offerings and their available ranks
SELECT m.name AS ClassName, r.RankName, r.level
FROM MartialArts m
JOIN Ranks r ON m.MAID = r.MAID
ORDER BY m.name, r.level;

-- Students and the classes they are enrolled in
SELECT s.StudentID, s.sname, m.name AS ClassName, e.Enroll_Date
FROM Students s
JOIN Enrolled e ON s.StudentID = e.StudentID
JOIN MartialArts m ON e.MAID = m.MAID
ORDER BY s.sname, m.name;

-- Instructors and the classes they teach
SELECT i.InstructorID, i.iname, m.name AS ClassName
FROM Instructors i
JOIN Teaches t ON i.InstructorID = t.InstructorID
JOIN MartialArts m ON t.MAID = m.MAID
ORDER BY i.iname, m.name;