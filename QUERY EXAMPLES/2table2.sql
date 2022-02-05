# "17" PostID'li postu beğenen kisiler
SELECT P.PersonUserID, P.Fname, P.LName
FROM LIKES AS L, PERSON AS P
WHERE L.LikedPostID = "17" AND  L.LikingUserID = P.PersonUserID;