select SendingStudentUserID, FeedbackID, Content, RecievingTeacherUserID, Major, FName as RecievingTeacherFirstName, LName as  RecievingTeacherLastName
from STUDENT, FEEDBACK, TEACHER, PERSON
where SendingStudentUserID = StudentUserID and RecievingTeacherUserID = TeacherUserID and TeacherUserID = PersonUserID;