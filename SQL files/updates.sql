USE MartialArtsSchoolDB;

-- Update Operations

-- Update student phone number
UPDATE Students
SET phone = '3215551111'
WHERE StudentID = 1;

-- Update instructor address
UPDATE Instructors
SET address = '500 New Dojo Ave'
WHERE InstructorID = 2;

-- Update martial art/class name
UPDATE MartialArts
SET name = 'Goju-Ryu'
WHERE MAID = 1;

-- Update rank level
UPDATE Ranks
SET level = 6
WHERE RankID = 5;

-- Update enrollment date
UPDATE Enrolled
SET Enroll_Date = '2026-03-08'
WHERE StudentID = 1 AND MAID = 2;