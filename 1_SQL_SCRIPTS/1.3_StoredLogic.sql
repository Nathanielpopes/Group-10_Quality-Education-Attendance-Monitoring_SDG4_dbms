CREATE TRIGGER CountAbsentAfterInsert
AFTER INSERT ON attendance
FOR EACH ROW
BEGIN
    IF NEW.status = 'Absent' THEN
        UPDATE students
        SET total_absent = total_absent + 1
        WHERE student_id = NEW.student_id;
    END IF;
END;


DELIMITER $$

CREATE PROCEDURE InsertAttendance
(
    IN p_student_id INT,
    IN p_class_id INT,
    IN p_attendance_date DATE,
    IN p_status ENUM('Present','Absent','Late','Excused')
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO attendance (student_id, class_id, attendance_date, status)
    VALUES (p_student_id, p_class_id, p_attendance_date, p_status);

    COMMIT;
END$$

DELIMITER ;


CREATE VIEW attendancereport AS
SELECT 
    a.attendance_id,
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.student_section,
    c.class_id,
    c.class_name,
    t.teacher_id,
    t.full_name AS teacher,
    a.attendance_date,
    a.status
FROM attendance a
JOIN students s ON a.student_id = s.student_id
JOIN classes c ON a.class_id = c.class_id
JOIN teachers t ON c.teacher_id = t.teacher_id;

