# sertifikasi olan ogrencilerin tum bilgileri
select *
from CERTIFICATE as c, PERSON as p
where CertificatedStudentUserID = PersonUserID;