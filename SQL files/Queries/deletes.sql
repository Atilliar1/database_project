-- =========================================================
-- This code was created by Group 48: Riley Parkin, Jonathon Hurley, and Ryan Acevedo
-- MARTIAL ARTS SCHOOL MANAGEMENT DATABASE DELETE 
-- =========================================================

USE MartialArtsSchoolDB;

-- Delete Operations

-- Remove a student from a class offering
DELETE FROM Enrolled
WHERE StudentID = 1 AND MAID = 2;

-- Remove an instructor from teaching a class offering
DELETE FROM Teaches
WHERE InstructorID = 3 AND MAID = 1;

-- Delete a rank
DELETE FROM Ranks
WHERE RankID = 23;

-- Delete a student
DELETE FROM Students
WHERE StudentID = 6;