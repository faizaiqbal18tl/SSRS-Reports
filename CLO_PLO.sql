SELECT clo_code, clo_description,course_code,course_title, plo_code, program_batch_code, department_name, degree_program_name, faculty_name FROM clo_plo
INNER JOIN clo ON clo_plo.clo_id = clo.clo_id
INNER JOIN plo ON clo_plo.plo_id = plo.plo_id
INNER JOIN course ON clo.course_id = course.course_id
INNER JOIN program_batch ON clo_plo.program_batch_id = program_batch.program_batch_id
INNER JOIN department ON program_batch.department_id = department.department_id
INNER JOIN degree_program ON program_batch.degree_program_id = degree_program.degree_program_id
INNER JOIN faculty ON department.faculty_id = faculty.faculty_id
WHERE (course.course_id =@course_id or @course_id IS NULL)
AND (program_batch.program_batch_id= @program_batch_id OR @program_batch_id IS NULL)
AND (department.department_id = @department_id OR @department_id IS NULL)
AND (degree_program.degree_program_id = @degree_program_id OR @degree_program_id IS NULL)
AND (faculty.faculty_id = @faculty_id OR @faculty_id IS NULL)