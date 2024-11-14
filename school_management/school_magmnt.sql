-- 1. Create the Database
CREATE DATABASE school_management;

-- Use the Database
USE school_management;

-- 2. Create Tables

-- students table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

-- teachers table
CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    subject_id INT,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- classes table
CREATE TABLE classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL
);

-- subjects table
CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL
);

-- student_subjects table (for mapping students to subjects)
CREATE TABLE student_subjects (
    student_id INT,
    subject_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    PRIMARY KEY (student_id, subject_id)
);

-- teacher_subjects table (for mapping teachers to subjects)
CREATE TABLE teacher_subjects (
    teacher_id INT,
    subject_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    PRIMARY KEY (teacher_id, subject_id)
);

-- 3. Insert Sample Data

-- Insert data into classes
INSERT INTO classes (class_name) VALUES
('Grade 1'),
('Grade 2'),
('Grade 3');

-- Insert data into students
INSERT INTO students (first_name, last_name, age, class_id) VALUES
('John', 'Doe', 14, 1),
('Emma', 'Stone', 13, 2),
('Liam', 'Brown', 15, 3),
('Olivia', 'Johnson', 14, 1),
('Sophia', 'Wilson', 13, 2);

-- Insert data into subjects
INSERT INTO subjects (subject_name) VALUES
('Mathematics'),
('Science'),
('English'),
('History');

-- Insert data into teachers
INSERT INTO teachers (first_name, last_name, subject_id) VALUES
('Michael', 'Smith', 1),
('Emily', 'Davis', 2),
('Daniel', 'Garcia', 3),
('Linda', 'Martinez', 4);

-- Insert data into student_subjects
INSERT INTO student_subjects (student_id, subject_id) VALUES
(1, 1), (1, 2),
(2, 2), (2, 3),
(3, 1), (3, 3), (3, 4),
(4, 1), (4, 4),
(5, 2), (5, 3);

-- Insert data into teacher_subjects
INSERT INTO teacher_subjects (teacher_id, subject_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(1, 2),
(2, 3);

-- 4. Write Queries

-- 4.1 List all students with their first and last names.
SELECT first_name, last_name FROM students;

-- 4.2 Find the name and age of students who are 14 years old.
SELECT first_name, last_name, age FROM students WHERE age = 14;

-- 4.3 Show the names of all classes available in the school.
SELECT class_name FROM classes;

-- 4.4 List all teachers with their first and last names.
SELECT first_name, last_name FROM teachers;

-- 4.5 Display the names of all subjects taught in the school.
SELECT subject_name FROM subjects;

-- 4.6 Retrieve a list of students along with their class names.
SELECT s.first_name, s.last_name, c.class_name
FROM students s
JOIN classes c ON s.class_id = c.class_id;

-- 4.7 Find the subjects assigned to a specific student (e.g., student_id = 1).
SELECT sub.subject_name
FROM student_subjects ss
JOIN subjects sub ON ss.subject_id = sub.subject_id
WHERE ss.student_id = 1;

-- 4.8 List all teachers who teach "Mathematics".
SELECT t.first_name, t.last_name
FROM teachers t
JOIN teacher_subjects ts ON t.teacher_id = ts.teacher_id
JOIN subjects sub ON ts.subject_id = sub.subject_id
WHERE sub.subject_name = 'Mathematics';

-- 4.9 Show the total number of students in each class.
SELECT c.class_name, COUNT(s.student_id) AS total_students
FROM classes c
LEFT JOIN students s ON c.class_id = s.class_id
GROUP BY c.class_id;

-- 4.10 Display the names of all students who are enrolled in "Science".
SELECT s.first_name, s.last_name
FROM students s
JOIN student_subjects ss ON s.student_id = ss.student_id
JOIN subjects sub ON ss.subject_id = sub.subject_id
WHERE sub.subject_name = 'Science';
