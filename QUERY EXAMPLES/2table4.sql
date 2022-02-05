# maasi en yuksek 3 hoca
SELECT  t1.Salary, PERSON.FName, PERSON.LName
FROM TEACHER as t1, PERSON 
WHERE 3 >= (SELECT count(distinct Salary) 
            FROM TEACHER as t2
            WHERE (t1.Salary <= t2.Salary) order by t1.Salary desc) AND t1.TeacherUserID = PERSON.PersonUserID;