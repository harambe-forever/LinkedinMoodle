#Kisilerden WorkExperience'ı olanların calıstığı sirketler, calısanların isimleri ve baslama tarihleri 
SELECT C.CompanyName, P.FName, P.LName, E.WorkingPosition, E.StartDate
FROM EXPERIENCE AS E, PERSON AS P, COMPANY AS C
WHERE E.ExperienceUserID = P.PersonUserID AND E.Company = C.CompanyUserID;