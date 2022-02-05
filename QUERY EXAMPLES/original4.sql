# 1 kodlu dersten dersi gecen ogrenciler
select CourseID, TakingStudentUserID, FName, LName, Grade
from EVALUATION, STUDENT, PERSON, USERS
where EvaluationID = "1" and TakingStudentUserID = StudentUserID and StudentUserID = PersonUserID and PersonUserID = UserID 
		and Grade >= 45
order by TakingStudentUserID asc;