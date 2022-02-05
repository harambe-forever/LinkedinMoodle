DROP DATABASE IF EXISTS LinkedinMoodle;
CREATE DATABASE LinkedinMoodle;

#Creating LinkedinMoodle Schema
Use LinkedinMoodle;

DROP TABLE IF EXISTS USERS;
CREATE TABLE USERS(
	UserID int not null,
    Passwordd varchar(25) not null,
    EMail varchar(50) not null,
    CONSTRAINT pk_USERS primary key (UserID),
    CONSTRAINT uq_EMail UNIQUE (EMail)
);

INSERT INTO USERS VALUES ("0", "sebastian123", "sebastianvettel@gmail.com");
INSERT INTO USERS VALUES ("1", "12ferrari34", "scuderiaferrari@gmail.com");
INSERT INTO USERS VALUES ("2", "password", "gokberkayhan@gmail.com");
INSERT INTO USERS VALUES ("3", "123123", "cankan23@hotmail.com");
INSERT INTO USERS VALUES ("4", "98765", "redbullracing@gmail.com");
INSERT INTO USERS VALUES ("5", "selin35", "selinpaksoy@gmail.com");
INSERT INTO USERS VALUES ("6", "ichLaubeDatabeisieren", "dataismylife@ege.edu.tr");
INSERT INTO USERS VALUES ("7", "sevgi<3", "bestekaysi@gmail.com");
INSERT INTO USERS VALUES ("8", "intel8086", "micropro@gmail.com");
INSERT INTO USERS VALUES ("9", "stackQueue", "datastructures@gmail.com");
INSERT INTO USERS VALUES ("10", "mrDatabase", "mrdatabase@ege.edu.tr");
INSERT INTO USERS VALUES ("11", "sifresifre", "eposta@gmail.com");
INSERT INTO USERS VALUES ("12", "isletimsis", "isletimsis@yahoo.com");
INSERT INTO USERS VALUES ("13", "bilgag", "internationallove@gmail.com");
INSERT INTO USERS VALUES ("14", "nesnelbilgiler35", "oopismylife@gmail.com");

DROP TABLE IF EXISTS USER_PHONE;
CREATE TABLE USER_PHONE(
	PhoneUsersID int not null,
    PhoneNumber varchar(11) not null,
    CONSTRAINT pk_USER_PHONE primary key (PhoneUsersID, PhoneNumber),
    CONSTRAINT pf_USER_PHONE_USERS foreign key (PhoneUsersID) references USERS(UserID)
);

INSERT INTO USER_PHONE VALUES ("5", "05364418586");
INSERT INTO USER_PHONE VALUES ("5", "05325320532");

DROP TABLE IF EXISTS USER_ADDRESS;
CREATE TABLE USER_ADDRESS(
	AddressUsersID int not null,
    Address varchar(50) not null,
    CONSTRAINT pk_USER_ADDRESS primary key (AddressUsersID, Address),
    CONSTRAINT pf_USER_ADDRESS_USERS foreign key (AddressUsersID) references USERS(UserID)
);

INSERT INTO USER_ADDRESS VALUES ("1", "Via Paolo Ferrari, 85, 41121 Modena, Italy");

DROP TABLE IF EXISTS PERSON;
CREATE TABLE PERSON(
	PersonUserID int not null,
    FName varchar(17) not null,
    Minit varchar(1),
    LName varchar(17) not null,
    DoB date, 
    Sex char,
    CV text,
    PersonType varchar(15) not null,
    CONSTRAINT pk_PERSON primary key (PersonUserID),
    CONSTRAINT fk_PERSON_USERS foreign key (PersonUserID) references USERS(UserID)
);

INSERT INTO PERSON VALUES ("0", "Sebastian", null, "Vettel", "1987-7-3", "M", "Toro Rosso, Red Bull Racing, Scuderia Ferrari, Aston Martin", "Student");
INSERT INTO PERSON VALUES ("2", "Gokberk", "M", "Ayhan", "2000-11-15", "M", null, "Student");
INSERT INTO PERSON VALUES ("5", "Selin", "Z", "Paksoy", "2001-03-30", "F", "Ege uni", "Student");
INSERT INTO PERSON VALUES ("10", "William", "M", "Database", "1969-01-30", "M", "Facebook", "Administrator");
INSERT INTO PERSON VALUES ("6", "Osman", "K", "Unalir", "1971-10-08", "M", "Ege Univ", "Teaching Staff");
INSERT INTO PERSON VALUES ("7", "Beste", "Z", "Kaysi", "1992-03-01", "F", "Dokuz Eylul", "Teaching Staff");
INSERT INTO PERSON VALUES ("8", "Sebnem", null, "Bora", "1980-04-10", "F", "Intel", "Teaching Staff");
INSERT INTO PERSON VALUES ("9", "Aybars", null, "Ugur", "1967-03-11", "M", "Izmir BSB", "Teaching Staff");
INSERT INTO PERSON VALUES ("11", "Esra", "K", "Duman", "2000-01-29", "F", null, "Student");
INSERT INTO PERSON VALUES ("12", "Aylin", "K", "Kantarci", "1980-01-30", "F", "Microsoft", "Teaching Staff");
INSERT INTO PERSON VALUES ("13", "Levent", "T", "Toker", "1960-07-15", "M", "Turk Telekom", "Teaching Staff");
INSERT INTO PERSON VALUES ("14", "Riza", "C", "Erdur", "1963-12-31", "M", "Automata", "Teaching Staff");


DROP TABLE IF EXISTS MESSAGES;
CREATE TABLE MESSAGES(
	SenderUserID int not null,
    RecieverUserID int not null,
    MTime double not null,			# 10.31
    MText text not null,
    MType char not null,			# T for Text, I for Image, V for Video
    CONSTRAINT pk_MESSAGES primary key (SenderUserID, RecieverUserID),
    CONSTRAINT fk_MESSAGES_USERS1 foreign key (SenderUserID) references USERS(UserID),
    CONSTRAINT fk_MESSAGES_USERS2 foreign key (RecieverUserID) references USERS(UserID)
);

INSERT INTO MESSAGES VALUES("5","2", "18.06", "Gokberk projeyi bitirdin mi?", "T");
INSERT INTO MESSAGES VALUES("2","5", "20.03", "HAYIR.:D", "T");

DROP TABLE IF EXISTS FOLLOWS;
CREATE TABLE FOLLOWS(
	FollowerUserID int not null,
    FollowedUserID int not null,
    FollowTime decimal not null,
    CONSTRAINT pk_FOLLOWS primary key (FollowerUserID, FollowedUserID),
    CONSTRAINT fk_FOLLOWS_USERS1 foreign key (FollowerUserID) references USERS(UserID),
    CONSTRAINT fk_FOLLOWS_USERS2 foreign key (FollowedUserID) references USERS(UserID)
);

DROP TABLE IF EXISTS GRUP;
CREATE TABLE GRUP(
	GroupID int not null,
    GroupName varchar(25) not null,
    MemberNo int not null,
    CreatorPersonUserID int not null,
    CONSTRAINT pk_GRUP primary key (GroupID),
    CONSTRAINT fk_GRUP_PERSON foreign key (CreatorPersonUserID) references PERSON(PersonUserID)
);

INSERT INTO GRUP VALUES ("3", "TIFOSI IZMIR", "1", "2");
INSERT INTO GRUP VALUES ("1", "DBProje Grubu", "1", "5");

DROP TABLE IF EXISTS MEMBER_OF;
CREATE TABLE MEMBER_OF(
	MemberPersonUserID int not null,
    MemberGroupID int not null,
    CONSTRAINT pk_MEMBER_OF primary key (MemberPersonUserID, MemberGroupID),
    CONSTRAINT fk_MEMBER_OF_PERSON foreign key (MemberPersonUserID) references PERSON(PersonUserID),
    CONSTRAINT fk_MEMBER_OF_GRUP foreign key (MemberGroupID) references GRUP(GroupID)
);

CREATE TRIGGER after_member_attend
AFTER INSERT ON MEMBER_OF
FOR EACH ROW
	UPDATE GRUP,MEMBER_OF SET MemberNo = MemberNo + 1 
    WHERE  MemberNo = GRUP.MemberNo AND MEMBER_OF.MemberGroupID = GRUP.GroupID;

INSERT INTO MEMBER_OF VALUES ("0", "3");
INSERT INTO MEMBER_OF VALUES ("5", "3");
INSERT INTO MEMBER_OF VALUES ("10", "3");		# tifosi izmir 4 kisi olmali
INSERT INTO MEMBER_OF VALUES ("0", "1");		
INSERT INTO MEMBER_OF VALUES ("7", "1");		# db proje grup 3 kisi olmali
INSERT INTO MEMBER_OF VALUES ("8", "1");
INSERT INTO MEMBER_OF VALUES ("9", "1");

DROP TABLE IF EXISTS COMPANY;
CREATE TABLE COMPANY(
	CompanyUserID int not null,
    CompanyName varchar(40),
    EmployeeNumber int,
    CONSTRAINT uq_CompanyName UNIQUE (CompanyName),
    CONSTRAINT pk_COMPANY primary key (CompanyUserID),
    CONSTRAINT fk_COMPANY_USERS foreign key (CompanyUserID) references USERS(UserID)
);

INSERT INTO COMPANY VALUES ("1", "Scuderia Ferrari", "250");
INSERT INTO COMPANY VALUES ("4", "Red Bull Racing Honda", "600");

DROP TABLE IF EXISTS EXPERIENCE;
CREATE TABLE EXPERIENCE(
	Company int not null, 			# reference to company id
    ExperienceUserID int not null, 	# reference to PersonUserID
    WorkingPosition varchar(30) not null,
    StartDate date not null,
    EndDate date,
    CONSTRAINT pk_EXPERIENCE primary key (Company, ExperienceUserID),
    CONSTRAINT fk_EXPERIENCE_COMPANY foreign key (Company) references COMPANY(CompanyUserID),
    CONSTRAINT fk_EXPERIENCE_PERSON foreign key (ExperienceUserID) references PERSON(PersonUserID)
);

CREATE TRIGGER after_insert_experience
AFTER INSERT ON EXPERIENCE
FOR EACH ROW
	UPDATE COMPANY,EXPERIENCE SET EmployeeNumber = EmployeeNumber + 1 WHERE EmployeeNumber = COMPANY.EmployeeNumber
															AND EXPERIENCE.Company = COMPANY.CompanyUserID;
    
INSERT INTO EXPERIENCE VALUES("4", "2", "internship", "2020-07-05", "2021-01-31");
INSERT INTO EXPERIENCE VALUES("4", "0", "longterm", "2018-08-11", " 2022-08-15");
INSERT INTO EXPERIENCE VALUES("1", "5", "internship", "2022-01-01", null);

DROP TABLE IF EXISTS JOB_ALERT;
CREATE TABLE JOB_ALERT(
	AlertID int not null,
    AlertingCompanyUserID int not null,
    JobPosition varchar(20) not null,
    JobLocation varchar(15) not null,
    JobTitle varchar(15) not null,
    JobDescription text,
    CONSTRAINT pk_JOB_ALERT primary key (AlertID, AlertingCompanyUserID),
    CONSTRAINT fk_JOB_ALERT_COMPANY foreign key (AlertingCompanyUserID) references COMPANY(CompanyUserID)
);

INSERT INTO JOB_ALERT VALUES ("1000", "4", "Tyre Expert", "London", "Junior", "Can speak english");
INSERT INTO JOB_ALERT VALUES ("999", "1", "Data Engineer", "Maranello", "Senior", "Grazie regazzi");
INSERT INTO JOB_ALERT VALUES ("998", "4", "Pilot", "London", "Junior", "Drivers licence req.");
INSERT INTO JOB_ALERT VALUES ("997", "1", "Pilot", "London", "Senior", "No requirement needed");
INSERT INTO JOB_ALERT VALUES ("996", "1", "Team Coach", "Maranello", "New Grad", "Speaks Italian");

DROP TABLE IF EXISTS VIEW_ALERT;
CREATE TABLE VIEW_ALERT(
	ViewingPersonID int not null,
	ViewedAlertID int not null,
    CONSTRAINT pk_VIEW_ALERT primary key (ViewingPersonID, ViewedAlertID),
    CONSTRAINT fk_VIEW_ALERT_PERSON foreign key (ViewingPersonID) references PERSON(PersonUserID),
    CONSTRAINT fk_VIEW_ALERT_JOB_ALERT foreign key (ViewedAlertID) references JOB_ALERT(AlertID) ON DELETE CASCADE
);
INSERT INTO VIEW_ALERT VALUES("2", "999");

DROP TABLE IF EXISTS FORUM;
CREATE TABLE FORUM(
	ForumTitle varchar(20) not null, 
    CreatorUserID int not null, 
    CONSTRAINT pk_FORUM primary key (ForumTitle),
    CONSTRAINT fk_FORUM_USERS foreign key (CreatorUserID) references USERS(UserID)
);

INSERT INTO FORUM VALUES ("Database Management", "2");

DROP TABLE IF EXISTS POST;
CREATE TABLE POST(
	PostID int not null,
    ContentType char, 					# V for Video, I for Image, T for Text
    ForumTitle varchar(20) not null,
    PosterUserID int not null,
    CONSTRAINT pk_POST primary key (PostID),
    CONSTRAINT fk_POST_FORUM foreign key (ForumTitle) references FORUM(ForumTitle),
    CONSTRAINT fk_POST_USERS foreign key (PosterUserID) references USERS(UserID)
);

INSERT INTO POST VALUES ("11", "I", "Database Management", "2");

DROP TABLE IF EXISTS COMMENTS;
CREATE TABLE COMMENTS(
	CommentingUserID int not null,
    CommentedPostID int not null,
    CONSTRAINT pk_COMMENTS primary key (CommentingUserID, CommentedPostID),
    CONSTRAINT fk_COMMENTS_USERS foreign key (CommentingUserID) references USERS(UserID)
);

INSERT INTO COMMENTS VALUES ("5", "41");

DROP TABLE IF EXISTS SAVES;
CREATE TABLE SAVES(
	SavingUserID int not null,
    SavedPostID int not null,
    CONSTRAINT pk_SAVES primary key (SavingUserID, SavedPostID),
    CONSTRAINT fk_SAVES_USERS foreign key (SavingUserID) references USERS(UserID)
);

INSERT INTO SAVES VALUES ("0", "11");

DROP TABLE IF EXISTS LIKES;
CREATE TABLE LIKES(
	LikingUserID int not null,
    LikedPostId int not null,
    CONSTRAINT pk_LIKES primary key (LikingUserID, LikedPostID),
    CONSTRAINT fk_LIKES_USERS foreign key (LikingUserID) references USERS(UserID)
);

INSERT INTO LIKES VALUES ("5", "17");

DROP TABLE IF EXISTS SKILL;
CREATE TABLE SKILL(
	SkillID varchar(5) not null,
    SkillName varchar(15) not null,
    SkillPersonUserID int not null,
    CONSTRAINT pk_SKILL primary key (SkillID),
    CONSTRAINT fk_SKILL_USERS foreign key (SkillPersonUserID) references PERSON(PersonUserID) ON DELETE CASCADE
);

INSERT INTO SKILL VALUES ("cdg", "Coding", "2");
INSERT INTO SKILL VALUES ("sgn", "Singing", "5");

DROP TABLE IF EXISTS HOBBY;
CREATE TABLE HOBBY(
	HobbyID varchar(5) not null, 			# cdg (coding) falan filan
    HobbyName varchar(15) not null,
    HobbyPersonUserID int not null,
    CONSTRAINT pk_HOBBY primary key (HobbyID),
    CONSTRAINT fk_Hobby_USERS foreign key (HobbyPersonUserID) references PERSON(PersonUserID) ON DELETE CASCADE
);

INSERT INTO HOBBY VALUES ("drvg", "Driving", "0");
INSERT INTO HOBBY VALUES ("read", "Reading", "8");
INSERT INTO HOBBY VALUES ("trvl", "Traveling", "9");

DROP TABLE IF EXISTS HAS;
CREATE TABLE HAS(
	HobbysPersonUserID int not null,
    HHobbyID varchar(5) not null,			# cdg (coding) falan filan
    CONSTRAINT pk_HAS primary key (HobbysPersonUserID, HHobbyID),
    CONSTRAINT fk_HAS_PERSON foreign key (HobbysPersonUserID) references PERSON(PersonUserID),
    CONSTRAINT fk_HAS_HOBBY foreign key (HHobbyID) references HOBBY(HobbyID)
);

INSERT INTO HAS VALUES ("0", "drvg");
INSERT INTO HAS VALUES ("8", "read");
INSERT INTO HAS VALUES ("9", "trvl");

DROP TABLE IF EXISTS ADMINISTRATOR;
CREATE TABLE ADMINISTRATOR(
	AdminID int not null,
    CONSTRAINT pk_ADMINISTRATOR primary key (AdminID),
    CONSTRAINT fk_ADMINISTRATOR_USERS foreign key (AdminID) references PERSON(PersonUserID)
);

INSERT INTO ADMINISTRATOR VALUES ("10");

DROP TABLE IF EXISTS TEACHING_STAFF;
CREATE TABLE TEACHING_STAFF(
	TeachingUserID int not null,
    DiplomaGivenDate date not null,
    CollegeObtained varchar(25) not null,
    TeachingStaffType char not null, 				# T for teacher, A for assistant
    CONSTRAINT pk_TEACHING_STAFF primary key (TeachingUserID),
    CONSTRAINT fk_TEACHING_STAFF_USER foreign key (TeachingUserID) references PERSON(PersonUserID)
);

INSERT INTO TEACHING_STAFF VALUES ("6", "1993-06-06", "Ege Univ", "T");
INSERT INTO TEACHING_STAFF VALUES ("8", "1996-10-01", "Dokuz Eylul", "T");
INSERT INTO TEACHING_STAFF VALUES ("7", "2010-06-07", "ITU", "A");
INSERT INTO TEACHING_STAFF VALUES ("9", "1996-01-10", "Ege Univ", "T");
INSERT INTO TEACHING_STAFF VALUES ("12", "1993-05-11", "Dokuz Eylul", "T");
INSERT INTO TEACHING_STAFF VALUES ("13", "1989-01-21", "Ege Univ", "T");
INSERT INTO TEACHING_STAFF VALUES ("14", "1991-01-31", "Ege Univ", "T");

DROP TABLE IF EXISTS STUDENT;
CREATE TABLE STUDENT(
	StudentUserID int not null,
    GPA double,
    CONSTRAINT pk_STUDENT primary key (StudentUserID),
    CONSTRAINT fk_STUDENT_USERS foreign key (StudentUserID) references Person(PersonUserID)
);

INSERT INTO STUDENT VALUES ("5", "3.31");
INSERT INTO STUDENT VALUES ("2", "3.62");
INSERT INTO STUDENT VALUES ("0", "2.93");
INSERT INTO STUDENT VALUES ("11", "3.01");

DROP TABLE IF EXISTS TEACHER;
CREATE TABLE TEACHER(
	TeacherUserID int not null,
    Major varchar(20) not null,
    Salary double not null CHECK (Salary >= 0.0),
    CONSTRAINT pk_TEACHER primary key (TeacherUserID),
    CONSTRAINT fk_TEACHER_USER foreign key (TeacherUserID) references TEACHING_STAFF(TeachingUserID)
);

INSERT INTO TEACHER VALUES ("6", "Database Management", "30000.00");
INSERT INTO TEACHER VALUES ("8", "Microprocessors", "25000.00");
INSERT INTO TEACHER VALUES ("9", "Data Structures", "27000.00");
INSERT INTO TEACHER VALUES ("12", "Operating Systems", "28000.00");
INSERT INTO TEACHER VALUES ("13", "Computer Networks", "51000.00");
INSERT INTO TEACHER VALUES ("14", "OOP", "31000.00");

DROP TABLE IF EXISTS FEEDBACK;
CREATE TABLE FEEDBACK(
	FeedbackID int not null,
    Content text not null,
    SendingStudentUserID int not null,
    RecievingTeacherUserID int not null,
    CONSTRAINT pk_FEEDBACK primary key (FeedbackID),
    CONSTRAINT fk_FEEDBACK_STUDENT foreign key (SendingStudentUserID) references STUDENT(StudentUserID),
    CONSTRAINT fk_FEEDBACK_TEACHER foreign key (RecievingTeacherUserID) references TEACHER(TeacherUserID)
);
INSERT INTO FEEDBACK VALUES ("15", "Soru eksik verilmis!", "5", "8");

DROP TABLE IF EXISTS ASSISTANT;
CREATE TABLE ASSISTANT(
	AssistantUserID int not null,
    Thesis text not null,
    CONSTRAINT pk_ASSISTANT primary key (AssistantUserID),
    CONSTRAINT fk_ASSISTANT_USERS foreign key (AssistantUserID) references TEACHING_STAFF(TeachingUserID)
);

INSERT INTO ASSISTANT VALUES ("7", "Cizge Teorisi");

DROP TABLE IF EXISTS COURSE;
CREATE TABLE COURSE(
	CourseCode int not null,
    CourseName varchar(25) not null, 
    CourseDescription text,
    CourseLevel double not null,
    CreditHours int not null CHECK (CreditHours >= 1),
    CourseTeacherUserID int not null,
    StudentAmount int not null,
    CONSTRAINT pk_COURSE primary key (CourseCode),
    CONSTRAINT fk_COURSE foreign key (CourseTeacherUserID) references TEACHER(TeacherUserID) ON DELETE CASCADE
);

INSERT INTO COURSE VALUES ("420", "Microprocessors", "Welcome to MicroProcessor class", "3.1", "5", "8", "0");
INSERT INTO COURSE VALUES ("538", "Data Structures", "Theory of data structures", "2.1", "6", "9", "0");
INSERT INTO COURSE VALUES ("111", "Operating Systems", "History of operating systems and their usings", "3.1", "4", "12", "0");
INSERT INTO COURSE VALUES ("121", "Computer Networks", "History of operating systems and their usings", "3.1", "4", "13", "0");
INSERT INTO COURSE VALUES ("131", "OOP", "History of operating systems and their usings", "3.1", "5", "14", "0");

DROP TABLE IF EXISTS CONTENT;
CREATE TABLE CONTENT(
	ContentNo int not null,
    FileType varchar(5) not null,
    UploadDate date not null,
    DownDate date ,
    UploaderUserID int not null,
    CONSTRAINT pk_CONTENT primary key (ContentNo),
    CONSTRAINT fk_CONTENT_TEACHING_STAFF foreign key (UploaderUserID) references TEACHING_STAFF(TeachingUserID)
);
INSERT INTO CONTENT VALUES ("13", "pdf", "2022-02-02", null, "8");
INSERT INTO CONTENT VALUES ("11", "jpg", "2022-01-28", "2022-02-01", "9");
INSERT INTO CONTENT VALUES ("911", "pdf", "2022-02-02", null, "7");


DROP TABLE IF EXISTS UPLOADS;
CREATE TABLE UPLOADS(
	UppingTeachingStaffUserID int not null,
    UppedContentNo int not null,
    CONSTRAINT pk_UPLOADS primary key (UppingTeachingStaffUserID),
    CONSTRAINT fk_UPLOADS_TEACHING_STAFF foreign key (UppedContentNo) references TEACHING_STAFF(TeachingUserID)
);
INSERT INTO UPLOADS VALUES ("6", "7");
INSERT INTO UPLOADS VALUES ("9", "6");

DROP TABLE IF EXISTS EVALUATION;
CREATE TABLE EVALUATION(
	EvaluationID int not null,
    TakingStudentUserID int not null,			# student id
    MakerUserID int not null,					# teaching staff id who makes this evaluation
    CourseID int not null, 						# course code
    GraderUserID int not null, 						# teaching staff id who grades this evaluation
    Grade int not null CHECK (Grade < 101),
    CONSTRAINT pk_EVALUATION primary key (EvaluationID, TakingStudentUserID, MakerUserID, CourseID, GraderUserID),
    CONSTRAINT fk_EVALUATION_TEACHING_STAFF1 foreign key (MakerUserID) references TEACHING_STAFF(TeachingUserID),
	CONSTRAINT fk_EVALUATION_TEACHING_STAFF2 foreign key (GraderUserID) references TEACHING_STAFF(TeachingUserID),
	CONSTRAINT fk_EVALUATION_COURSE foreign key (CourseID) references COURSE(CourseCode),
    CONSTRAINT fk_EVALUATION_STUDENT foreign key (TakingStudentUserID) references STUDENT(StudentUserID)
);

INSERT INTO EVALUATION VALUES ("1", "0", "6", "420", "6", "22");
INSERT INTO EVALUATION VALUES ("1", "11", "6", "420", "6", "59");
INSERT INTO EVALUATION VALUES ("1", "2", "6", "420", "8", "47");
INSERT INTO EVALUATION VALUES ("1", "5", "6", "420", "8", "95");
INSERT INTO EVALUATION VALUES ("6", "5", "12", "111", "12", "41");
INSERT INTO EVALUATION VALUES ("3", "5", "13", "121", "13", "60");
INSERT INTO EVALUATION VALUES ("4", "5", "14", "131", "14", "90");
INSERT INTO EVALUATION VALUES ("2", "2", "9", "538", "9", "100");

DROP TABLE IF EXISTS ASSIGNMENT;
CREATE TABLE ASSIGNMENT(
	ATakingStudentUserID int not null,			# references to student id
    AEvaluationID int not null, 				# references to eval id
    DueDate date,
    NumberOfAttempts int not null,
    CONSTRAINT pk_ASSIGNMENT primary key (ATakingStudentUserID, AEvaluationID),
    CONSTRAINT fk_ASSIGNMENT_STUDENT foreign key (ATakingStudentUserID) references STUDENT(StudentUserID),
    CONSTRAINT fk_ASSIGNMENT_EVALUATION foreign key (AEvaluationID) references EVALUATION(EvaluationID)
);

INSERT INTO ASSIGNMENT VALUES ("5", "2", "2022-01-31", "1");

DROP TABLE IF EXISTS QUIZ;
CREATE TABLE QUIZ(
	QTakingStudentUserID int not null,
    QEvaluationID int not null, 
    CONSTRAINT pk_QUIZ primary key (QTakingStudentUserID, QEvaluationID),
    CONSTRAINT fk_QUIZ_STUDENT foreign key (QTakingStudentUserID) references STUDENT(StudentUserID),
    CONSTRAINT fk_QUIZ_EVALUATION foreign key (QEvaluationID) references EVALUATION(EvaluationID)
);

INSERT INTO QUIZ VALUES ("2", "1");
INSERT INTO QUIZ VALUES ("5", "2");

DROP TABLE IF EXISTS ENROLLS;
CREATE TABLE ENROLLS(
	EnrolledCourseCode int not null,
    EnrollingStudentUserID int not null,
    CONSTRAINT pk_ENROLLS primary key (EnrolledCourseCode, EnrollingStudentUserID),
    CONSTRAINT fk_ENROLLS_COURSE foreign key (EnrolledCourseCode) references COURSE(CourseCode),
    CONSTRAINT fk_ENROLLS_STUDENT foreign key (EnrollingStudentUserID) references STUDENT(StudentUserID)
);

CREATE TRIGGER after_student_enrolls
AFTER INSERT ON ENROLLS
FOR EACH ROW
	UPDATE COURSE,ENROLLS SET StudentAmount = StudentAmount + 1 WHERE StudentAmount = COURSE.StudentAmount
																AND ENROLLS.EnrolledCourseCode = COURSE.CourseCode;

INSERT INTO ENROLLS VALUES ("420", "5");
INSERT INTO ENROLLS VALUES ("420", "2");
INSERT INTO ENROLLS VALUES ("420", "0");
INSERT INTO ENROLLS VALUES ("538", "5");
INSERT INTO ENROLLS VALUES ("538", "2");

DROP TABLE IF EXISTS TAKE;
CREATE TABLE TAKE(
	TStudentUserID int not null,
    TEvaluationID int not null,
    EMakerID int not null, 						# references teachingStaffID that makes this evaluation
    EGraderID int not null,	
    EvalTakenCourseID int not null,
    CONSTRAINT pk_TAKE primary key (TStudentUserID, TEvaluationID, EMakerID, EGraderID, EvalTakenCourseID),
    CONSTRAINT fk_TAKE_STUDENT foreign key (TStudentUserID) references STUDENT(StudentUserID),
    CONSTRAINT fk_TAKE_EVALUATION foreign key (TEvaluationID) references EVALUATION(EvaluationID),
    CONSTRAINT fk_TAKE_TEACHING_STAFF1 foreign key (EMakerID) references TEACHING_STAFF(TeachingUserID),
    CONSTRAINT fk_TAKE_TEACHING_STAFF2 foreign key (EGraderID) references TEACHING_STAFF(TeachingUserID),
    CONSTRAINT fk_TAKE_COURSE foreign key (EvalTakenCourseID) references COURSE(CourseCode)
);

INSERT INTO TAKE VALUES ("2", "1", "9", "8", "420");
INSERT INTO TAKE VALUES ("2", "1", "8", "9", "538");
INSERT INTO TAKE VALUES ("5", "2", "6", "7", "538");

DROP TABLE IF EXISTS CERTIFICATE;
CREATE TABLE CERTIFICATE(
	CertificateID int not null,
    CertificateName varchar(25) not null,
    GivenDate date not null,
    CertificateCourseID int not null,			# references to courseCode
    CertificatedStudentUserID int not null,		# references to person that achieves certificate
    CertificatingEvaluationID int not null,		# references EvaluationID
    EMakerID int not null, 						# references teachingStaffID that makes this evaluation
    EGraderID int not null,						# references teachingStaffID that grades this evaluation
	CONSTRAINT pk_CERTIFICATE primary key (CertificateID),
    CONSTRAINT fk_CERTIFICATE_COURSE foreign key (CertificateCourseID) references COURSE(CourseCode),
    CONSTRAINT fk_CERTIFICATE_STUDENT foreign key (CertificatedStudentUserID) references STUDENT(StudentUserID),
	CONSTRAINT fk_CERTIFICATE_EVALUATION foreign key (CertificatingEvaluationID) references EVALUATION(EvaluationID),
    CONSTRAINT fk_CERTIFICATE_TEACHING_STAFF1 foreign key (EMakerID) references TEACHING_STAFF(TeachingUserID),
	CONSTRAINT fk_CERTIFICATE_TEACHING_STAFF2 foreign key (EGraderID) references TEACHING_STAFF(TeachingUserID)
);

INSERT INTO CERTIFICATE VALUES ("41233", "Programming Cer.", "2018-04-22", "420", "5", "2", "7","8");
INSERT INTO CERTIFICATE VALUES ("40222", "Cer. of Education", "2008-04-22", "538", "2", "2", "9","6");

DROP TABLE IF EXISTS EARNS;
CREATE TABLE EARNS(
	EarningPersonUserID int not null,
    EarnedCertificateID int not null,
    CONSTRAINT pk_EARNS primary key (EarningPersonUserID, EarnedCertificateID),
    CONSTRAINT fk_EARNS_PERSON foreign key (EarningPersonUserID) references PERSON(PersonUserID),
    CONSTRAINT fk_EARNS_CERTIFICATE foreign key (EarnedCertificateID) references CERTIFICATE(CertificateID)
);

INSERT INTO EARNS VALUES("5", "41233");
INSERT INTO EARNS VALUES("2", "40222");

DROP TABLE IF EXISTS QUESTIONS;
CREATE TABLE QUESTIONS(
	QuestionID int not null,
    ExamEvaluationID int not null,				# references evaluation
	QuestionType char not null,					# C for Classic, T for Test
    Answer text,
    CONSTRAINT pk_QUESTIONS primary key (QuestionID, ExamEvaluationID),
    CONSTRAINT fk_QUESTIONS_EVALUATION foreign key (ExamEvaluationID) references EVALUATION(EvaluationID)
);

INSERT INTO QUESTIONS VALUES("711", "1", "C", "True");
INSERT INTO QUESTIONS VALUES("712", "2", "T", "D");

UPDATE TEACHER SET Salary = "40000.00" WHERE TeacherUserID = "6";
UPDATE COURSE SET CourseTeacherUserID = "9" WHERE CourseCode = "111";
UPDATE COMPANY SET CompanyName = "Red Bull Racing" WHERE CompanyUserID = "4";

/*SELECT * FROM TEACHER;
SELECT * FROM COURSE;
SELECT * FROM COMPANY;*/

DELETE FROM FEEDBACK WHERE FeedbackID = "15";
DELETE FROM JOB_ALERT WHERE AlertID = "999";
DELETE FROM POST WHERE PostID = "11";

SELECT * FROM FEEDBACK;
SELECT * FROM JOB_ALERT;
SELECT * FROM POST;

/*SELECT * FROM USERS;
SELECT * FROM PERSON;
SELECT * FROM COMPANY;
SELECT * FROM JOB_ALERT;
SELECT * FROM FORUM;
SELECT * FROM POST;
SELECT * FROM COMMENTS;
SELECT * FROM SAVES;
SELECT * FROM LIKES;
SELECT * FROM SKILL;
SELECT * FROM HOBBY;
SELECT * FROM TEACHING_STAFF;
SELECT * FROM STUDENT;
SELECT * FROM TEACHER;
SELECT * FROM ASSISTANT;
SELECT * FROM GRUP;
SELECT * FROM COURSE;
SELECT * FROM EVALUATION;*/