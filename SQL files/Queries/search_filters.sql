-- =========================================================
-- This code was created by Group 48: Riley Parkin, Jonathon Hurley, and Ryan Acevedo
-- MARTIAL ARTS SCHOOL MANAGEMENT DATABASE SEARCH/FILTERS
-- =========================================================

USE MartialArtsSchoolDB;

-- Searches/Filters through Queries

-- Show all students
SELECT * FROM Students;

-- Search students by partial name
SELECT *
FROM Students
WHERE sname LIKE '%Ri%';

-- Find all students enrolled in Karate
SELECT s.StudentID, s.sname, m.name AS ClassName, e.Enroll_Date
FROM Students s
JOIN Enrolled e ON s.StudentID = e.StudentID
JOIN MartialArts m ON e.MAID = m.MAID
WHERE m.name = 'Goju-Ryu';

-- Find all students enrolled after a certain date
SELECT s.StudentID, s.sname, m.name AS ClassName, e.Enroll_Date
FROM Students s
JOIN Enrolled e ON s.StudentID = e.StudentID
JOIN MartialArts m ON e.MAID = m.MAID
WHERE e.Enroll_Date >= '2026-02-01'
ORDER BY e.Enroll_Date;

-- Find instructors assigned to teach Taekwondo
SELECT i.InstructorID, i.iname, m.name AS ClassName
FROM Instructors i
JOIN Teaches t ON i.InstructorID = t.InstructorID
JOIN MartialArts m ON t.MAID = m.MAID
WHERE m.name = 'Taekwondo';

-- Find all ranks for Judo
SELECT r.RankID, r.RankName, r.level, m.name AS ClassName
FROM Ranks r
JOIN MartialArts m ON r.MAID = m.MAID
WHERE m.name = 'Judo'
ORDER BY r.level;
