CREATE TABLE `students` (
  `student_id` INT(11) NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `student_section` VARCHAR(50) NOT NULL,
  `total_absent` INT(11) DEFAULT 0
)

CREATE TABLE `teachers` (
  `teacher_id` INT(11) NOT NULL,
  `full_name` VARCHAR(100) NOT NULL,
  `subject` VARCHAR(100) NOT NULL
)

CREATE TABLE `classes` (
  `class_id` INT(11) NOT NULL,
  `class_name` VARCHAR(100) NOT NULL,
  `teacher_id` INT(11) NOT NULL
)

CREATE TABLE `attendance` (
  `attendance_id` INT(11) NOT NULL,
  `student_id` INT(11) NOT NULL,
  `class_id` INT(11) NOT NULL,
  `attendance_date` DATE NOT NULL,
  `status` ENUM('Present','Absent','Late') NOT NULL
)



