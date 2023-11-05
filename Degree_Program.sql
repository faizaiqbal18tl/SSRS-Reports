SELECT
  degree_program.degree_program_name
  ,degree_program.program_code
  ,department.department_name
  ,degree_program.degree_program_completion_min
  ,degree_program.degree_program_completion_max
  ,degree_program_level.degree_program_level_name
  ,session_type.name
FROM
  degree_program
  INNER JOIN degree_program_level
    ON degree_program.degree_program_level_id = degree_program_level.degree_program_level_id
  INNER JOIN department
    ON degree_program.department_id = department.department_id
  INNER JOIN session_type
    ON degree_program.session_type_id = session_type.session_type_id