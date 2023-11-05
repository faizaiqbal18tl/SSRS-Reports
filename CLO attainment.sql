SELECT faculty.faculty_name, department.department_name ,class_room.class_room_id, class_room.class_room_name, class_room_student.roll_no, activity_assesment.assesment_id,
activity_assesment.activity_assesment_name AS activity_name, STRING_AGG(class_room_activities.sub_activity_name, ', ') AS sub_activities,
activity_assesment_batch.weightage AS total_marks,
STRING_AGG(class_room_student.obtained_marks, ',') AS 
sub_activities_obtained_marks,
(SUM(class_room_student.obtained_marks)) AS obtained_marks, 
((SUM(class_room_student.obtained_marks) * 100) / SUM(class_room_activities.total_marks)) AS obe_weight,
STRING_AGG(clo.clo_code, ', ') AS clo,
CASE WHEN (SUM(class_room_student.obtained_marks) * 100 / SUM(class_room_activities.total_marks)) >= 50 THEN 'Y' ELSE 'N' END
AS 'clo_achieved'
FROM  class_room
INNER JOIN faculty ON class_room.faculty_id = faculty.faculty_id
INNER JOIN department ON class_room.department_id = department.department_id
INNER JOIN class_room_activities ON class_room.class_room_id = class_room_activities.class_room_id
INNER JOIN activity_assesment_batch ON class_room_activities.activity_assesment_batch_id = activity_assesment_batch.activity_assesment_batch_id
INNER JOIN activity_assesment ON activity_assesment_batch.assesment_id = activity_assesment.assesment_id
LEFT JOIN class_room_student ON class_room.class_room_id = class_room_student.class_room_id
AND class_room_activities.sub_activity_id = class_room_student.sub_activity_id
INNER JOIN clo_class_room ON class_room.class_room_id = clo_class_room.class_room_id
AND class_room_activities.sub_activity_id = clo_class_room.sub_activity_id
INNER JOIN clo ON clo_class_room.clo_id = clo.clo_id
WHERE  (faculty.faculty_id = @faculty_id or @faculty_id IS NULL)
AND (department.department_id = @department_id or @department_id IS NULL)
AND (class_room.class_room_id =@class_room_id or @class_room_id IS NULL)

GROUP BY faculty.faculty_name, department.department_name ,class_room.class_room_id, class_room.class_room_name, class_room_student.roll_no, activity_assesment.assesment_id, 
activity_assesment.activity_assesment_name, activity_assesment_batch.weightage
ORDER BY class_room.class_room_id, activity_assesment.assesment_id