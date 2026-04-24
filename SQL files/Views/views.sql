-- =========================================================
-- This code was created by Group 48: Riley Parkin, Jonathon Hurley, and Ryan Acevedo
-- MARTIAL ARTS SCHOOL MANAGEMENT DATABASE VIEWS
-- =========================================================

USE MartialArtsSchoolDB;

-- Views

CREATE OR REPLACE VIEW StudentEnrollmentView AS
SELECT
    s.StudentID,
    s.sname,
    m.MAID,
    m.name AS ClassName,
    e.Enroll_Date
FROM Students s
JOIN Enrolled e ON s.StudentID = e.StudentID
JOIN MartialArts m ON e.MAID = m.MAID;

CREATE OR REPLACE VIEW InstructorAssignmentView AS
SELECT
    i.InstructorID,
    i.iname,
    m.MAID,
    m.name AS ClassName
FROM Instructors i
JOIN Teaches t ON i.InstructorID = t.InstructorID
JOIN MartialArts m ON t.MAID = m.MAID;

-- View Usage

SELECT * FROM StudentEnrollmentView;
SELECT * FROM InstructorAssignmentView;