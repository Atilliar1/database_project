USE MartialArtsSchoolDB;

-- Create Tables

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