# content yukleyen ogretmenlerin listesi ve contentleri
select FName, LName, TeachingStaffType, ContentNo, FileType, UploadDate, DownDate
from CONTENT, TEACHING_STAFF, PERSON
where UploaderUserID = TeachingUserID and TeachingUserID = PersonUserID and TeachingStaffType = "T";