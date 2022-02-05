# kisinin sinavina girdigi derslerden aldigi notlar
select FName, Minit, LName, Grade, CourseName
from evaluation, person, users, course
where TakingStudentUserID = 5 and TakingStudentUserID = PersonUserID and PersonUserID = UserID and CourseCode = CourseID;