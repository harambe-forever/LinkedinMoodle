# 420 nolu dersin ogretmeni ile ilgili bilgiler
select *
from course, teacher, teaching_staff, person, users
where CourseCode = 420 and courseTeacherUserID = 8 and courseTeacherUserID = TeacherUserID
and teacherUserID = TeachingUserID and TeachingUserID = PersonUserID and PersonUserID = UserID;