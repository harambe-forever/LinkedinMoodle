# kisilerin yetenek, hobi, ve sertifikalarini gosterio
select PersonUserID, FName, LName, Sex, CV, HobbyName, SkillName, CertificateName
from PERSON
LEFT JOIN HOBBY
ON(HobbyPersonUserID = PersonUserID)
LEFT JOIN SKILL
ON(SkillPersonUserID = PersonUserID)
LEFT JOIN CERTIFICATE
ON(CertificatedStudentUserID = PersonUserID);