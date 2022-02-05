# diplomasini Ege Universitesinden alan ogretim uyeleri
select FName, LName, DiplomaGivenDate
from PERSON as p, TEACHING_STAFF as ts
where CollegeObtained = "Ege Univ" and TeachingUserID = PersonUserID;