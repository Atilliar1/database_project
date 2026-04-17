USE MartialArtsSchoolDB;

-- Sample Data to fill database

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

-- Insert Operations

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