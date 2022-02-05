# 420 numarali dersten ogrencilerin aldigi notlar, yuksekten aza siralanmis
select FName, LName, StudentUserID, Grade, CourseID
from PERSON, STUDENT, EVALUATION
where TakingStudentUserID = StudentUserID and StudentUserID = PersonUserID and CourseID = 420
order by Grade desc;