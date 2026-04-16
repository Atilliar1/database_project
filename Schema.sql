-- =========================================================
-- This code was created by Group 48: Riley Parkin, Jonathon Hurley, and Ryan Acevedo
-- MARTIAL ARTS SCHOOL MANAGEMENT DATABASE
-- MartialArts = class offerings
-- =========================================================

DROP DATABASE IF EXISTS MartialArtsSchoolDB;
CREATE DATABASE MartialArtsSchoolDB;
USE MartialArtsSchoolDB;

-- =========================================================
-- Tables
-- =========================================================

CREATE TABLE Students (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    sname VARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(150)
);

CREATE TABLE Instructors (
    InstructorID INT AUTO_INCREMENT PRIMARY KEY,
    iname VARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(150)
);

CREATE TABLE MartialArts (
    MAID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Ranks (
    RankID INT AUTO_INCREMENT PRIMARY KEY,
    MAID INT NOT NULL,
    RankName VARCHAR(50) NOT NULL,
    level INT NOT NULL,
    CONSTRAINT fk_ranks_martialarts
        FOREIGN KEY (MAID) REFERENCES MartialArts(MAID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT uq_rank_per_martialart UNIQUE (MAID, RankName),
    CONSTRAINT chk_rank_level CHECK (level > 0)
);

CREATE TABLE Enrolled (
    StudentID INT NOT NULL,
    MAID INT NOT NULL,
    Enroll_Date DATE NOT NULL,
    PRIMARY KEY (StudentID, MAID),
    CONSTRAINT fk_enrolled_student
        FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_enrolled_martialart
        FOREIGN KEY (MAID) REFERENCES MartialArts(MAID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Teaches (
    InstructorID INT NOT NULL,
    MAID INT NOT NULL,
    PRIMARY KEY (InstructorID, MAID),
    CONSTRAINT fk_teaches_instructor
        FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_teaches_martialart
        FOREIGN KEY (MAID) REFERENCES MartialArts(MAID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =========================================================
-- Sample Data to fill database
-- =========================================================

INSERT INTO Students (sname, DOB, phone, address) VALUES
('Riley Parkin', '2003-12-29', '8505551001', '123 Sesame St'),
('Ryan Acevedo', '2004-09-22', '3215551002', '456 Oak Ave'),
('Carly Simpson', '2004-02-24', '7195551003', '789 Pine Rd'),
('Daniel LaRusso', '1995-11-18', '3215551004', '222 Lake Dr'),
('Shaggy Rogers', '1950-07-09', '3215551005', '901 Palm St');

INSERT INTO Instructors (iname, DOB, phone, address) VALUES
('Sensei Jahani', '1985-09-12', '4075552003', '132 Visual Arts Building'),
('Coach Lee', '1940-11-27', '4075552005', '45 Training Ln'),
('Master Jonathan', '1982-03-21', '4075531982', '78 Black Belt Blvd'),
('Sensei Po', '1988-12-11', '3215452004', '998 Dragon Warrior Way');

INSERT INTO MartialArts (name) VALUES
('Traditional Karate'),
('Taekwondo'),
('Judo'),
('Brazilian Jiu-Jitsu');

INSERT INTO Ranks (MAID, RankName, level) VALUES
(1, 'White Belt', 1),
(1, 'Yellow Belt', 2),
(1, 'Green Belt', 3),
(1, 'Brown Belt', 4),
(1, 'Black Belt', 5),

(2, 'White Belt', 1),
(2, 'Yellow Belt', 2),
(2, 'Green Belt', 3),
(2, 'Red Belt', 4),
(2, 'Black Belt', 5),

(3, 'White Belt', 1),
(3, 'Yellow Belt', 2),
(3, 'Orange Belt', 3),
(3, 'Green Belt', 4),
(3, 'Brown Belt', 5),
(3, 'Black Belt', 6),

(4, 'White Belt', 1),
(4, 'Blue Belt', 2),
(4, 'Purple Belt', 3),
(4, 'Brown Belt', 4),
(4, 'Black Belt', 5);

INSERT INTO Enrolled (StudentID, MAID, Enroll_Date) VALUES
(1, 1, '2026-01-10'),
(2, 1, '2026-01-15'),
(3, 2, '2026-02-01'),
(4, 3, '2026-02-10'),
(5, 4, '2026-03-20'),
(1, 2, '2026-03-05');

INSERT INTO Teaches (InstructorID, MAID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(3, 1);

-- =========================================================
-- Insert Operations
-- =========================================================

-- Add a new student
INSERT INTO Students (sname, DOB, phone, address)
VALUES ('Johnny Lawrence', '2006-05-14', '3215551006', '45 Sunset Blvd');

-- Add a new instructor
INSERT INTO Instructors (iname, DOB, phone, address)
VALUES ('Sensei Miyagi', '1932-09-19', '4075552155', '150 Palm Ave');

-- Add a new martial art/class offering
INSERT INTO MartialArts (name)
VALUES ('Kickboxing');

-- Add ranks for that martial art
INSERT INTO Ranks (MAID, RankName, level)
VALUES
(5, 'Beginner', 1),
(5, 'Intermediate', 2),
(5, 'Advanced', 3);

-- Enroll a student in a class offering
INSERT INTO Enrolled (StudentID, MAID, Enroll_Date)
VALUES (6, 5, '2026-04-01');

-- Assign an instructor to teach a class offering
INSERT INTO Teaches (InstructorID, MAID)
VALUES (5, 5);

-- =========================================================
-- Update Operations
-- =========================================================

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

-- =========================================================
-- Delete Operations
-- =========================================================

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

-- =========================================================
-- Searches/Filters through Queries
-- =========================================================

-- 1. Show all students
SELECT * FROM Students;

-- 2. Search students by partial name
SELECT *
FROM Students
WHERE sname LIKE '%Jon%';

-- 3. Find all students enrolled in Karate
SELECT s.StudentID, s.sname, m.name AS ClassName, e.Enroll_Date
FROM Students s
JOIN Enrolled e ON s.StudentID = e.StudentID
JOIN MartialArts m ON e.MAID = m.MAID
WHERE m.name = 'Goju-Ryu';

-- 4. Find all students enrolled after a certain date
SELECT s.StudentID, s.sname, m.name AS ClassName, e.Enroll_Date
FROM Students s
JOIN Enrolled e ON s.StudentID = e.StudentID
JOIN MartialArts m ON e.MAID = m.MAID
WHERE e.Enroll_Date >= '2026-02-01'
ORDER BY e.Enroll_Date;

-- 5. Find instructors assigned to teach Taekwondo
SELECT i.InstructorID, i.iname, m.name AS ClassName
FROM Instructors i
JOIN Teaches t ON i.InstructorID = t.InstructorID
JOIN MartialArts m ON t.MAID = m.MAID
WHERE m.name = 'Taekwondo';

-- 6. Find all ranks for Judo
SELECT r.RankID, r.RankName, r.level, m.name AS ClassName
FROM Ranks r
JOIN MartialArts m ON r.MAID = m.MAID
WHERE m.name = 'Judo'
ORDER BY r.level;

-- =========================================================
-- Report Queries
-- =========================================================

-- 1. Number of students enrolled in each class offering
SELECT m.MAID, m.name AS ClassName, COUNT(e.StudentID) AS TotalStudents
FROM MartialArts m
LEFT JOIN Enrolled e ON m.MAID = e.MAID
GROUP BY m.MAID, m.name
ORDER BY TotalStudents DESC;

-- 2. Number of instructors assigned to each class offering
SELECT m.MAID, m.name AS ClassName, COUNT(t.InstructorID) AS TotalInstructors
FROM MartialArts m
LEFT JOIN Teaches t ON m.MAID = t.MAID
GROUP BY m.MAID, m.name
ORDER BY TotalInstructors DESC;

-- 3. Class offerings and their available ranks
SELECT m.name AS ClassName, r.RankName, r.level
FROM MartialArts m
JOIN Ranks r ON m.MAID = r.MAID
ORDER BY m.name, r.level;

-- 4. Students and the classes they are enrolled in
SELECT s.StudentID, s.sname, m.name AS ClassName, e.Enroll_Date
FROM Students s
JOIN Enrolled e ON s.StudentID = e.StudentID
JOIN MartialArts m ON e.MAID = m.MAID
ORDER BY s.sname, m.name;

-- 5. Instructors and the classes they teach
SELECT i.InstructorID, i.iname, m.name AS ClassName
FROM Instructors i
JOIN Teaches t ON i.InstructorID = t.InstructorID
JOIN MartialArts m ON t.MAID = m.MAID
ORDER BY i.iname, m.name;

-- =========================================================
-- Views
-- =========================================================

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

-- =========================================================
-- View Usage
-- =========================================================

SELECT * FROM StudentEnrollmentView;
SELECT * FROM InstructorAssignmentView;