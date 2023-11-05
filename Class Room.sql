SELECT class_room.class_room_name, course.course_title, semester.semester_title, faculty.faculty_name, teacher.teacher_name,
department.department_name, class_room.section,class_room_activities.class_room_activity_name, class_room_activities.gpa_weight, class_room_activities.obe_weight,
class_room_activities.start_date, class_room_activities.end_date, class_room_activities.total_marks, 
class_room_activities.outcomes_added, class_room_activities.question_count, problem_complexity.problem_complexity_name, CASE WHEN [class_room].[status] = 0 THEN 'No'
     WHEN [class_room].[status] = 1 THEN 'Yes'
	 ELSE 'N/A'
	 END AS 'status' FROM class_room

INNER JOIN course ON class_room.course_id = course.course_id
INNER JOIN semester ON class_room.semester_id = semester.semester_id
INNER JOIN faculty ON class_room.faculty_id = faculty.faculty_id
INNER JOIN teacher ON class_room.teacher_id = teacher.teacher_id
INNER JOIN department ON class_room.department_id = department.department_id
INNER JOIN class_room_activities ON class_room.class_room_id = class_room_activities.class_room_id
INNER JOIN problem_complexity ON class_room_activities.problem_complexity_id = problem_complexity.problem_complexity_id
INNER JOIN program_batch ON class_room.program_batch_id = program_batch.program_batch_id
LEFT JOIN degree_program ON program_batch.degree_program_id = degree_program.degree_program_id 

WHERE (faculty.faculty_id = @faculty OR @faculty IS NULL)
AND (department.department_id = @department OR @department IS NULL)
AND (degree_program.degree_program_id = @degree_program OR @degree_program IS NULL)
AND (program_batch.program_batch_id = @program_batch OR @program_batch IS NULL)