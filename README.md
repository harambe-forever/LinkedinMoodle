# LinkedinMoodle
Database for application LinkedinMoodle

In this project, you will design a database model for the virtually integrated version (say
LinkedinMoodle) of the popular web applications LinkedIn and Moodle. The project is more than a
technical implementation project, which means it should much more concentrated on the design of
the database. How you integrated these web applications is critical for the evaluation and the
originality of your design is crucial.
After analyzing the web applications, you are expected to:
ANALYSIS
1. Write a brief explanation using your own words (in English) about these applications in terms
of their scope.
2. Write an analysis report for each web application:
a. What is the aim of each application?
b. What are the main entities of them?
c. What are the characteristics of each entity?
d. What relationships exists among the entities?
e. What are the constraints related to entities, their characteristics and the
relationships among them?
DESIGN-CONCEPTUAL DESIGN
3. Create an EER diagram for the virtually integrated version of the applications,
LinkedinMoodle. Try to use enhanced/extended features of ER modeling. Do not use any
tool. You can use any drawing application with the right legend for ER modeling. The output
of this step is just an EER diagram for LinkedinMoodle.
4. The most important point of your design is how to integrate web applications and generate
added value. Therefore, you should accurately examine the contribution of each web
application's own core feature to the integrated application. You should determine the
interaction points of the applications. You can define new entities where interaction and
integration are required. At this point your creativity has an artistic significance.
DESIGN-LOGICAL MODEL
5. Convert EER diagram into relational model using the methodology that will be introduced in
your course.
IMPLEMENTATION-PHYSICAL MODEL
6. Write down the appropriate SQL scripts (DDL statements) for creating the database and its
relational model. You can select any of the DBMS you wish.7. Populate the database you just created again using SQL script file loaded with sample tuples.
(The tables should have enough number of tuples for the SELECT statements to be run
accordingly.)
8. Write down 3 triggers for 3 different tables. Triggers should be meaninful.
9. Write down 3 check constraints and 3 assertions. Check constraints and assertions should be
meaninful.
10. Write down the following SQL statements:
a. Write sample INSERT, DELETE and UPDATE statements for 3 of the tables you have
chosen.
b. Write 10 SELECT statements for the database you have implemented.
i. 3 of them should use just one table.
ii. 4 of them should use minimum 2 tables.
iii. 3 of them should use minimum 3 tables.
c. Write 5 original SELECT statements that you think critical to interaction and
integration points for the database.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

LINKEDIN ANALYSIS AND DESIGN:

Key Entities:
Users -> User must be a company or a person account
Company -> Company account where people work and can offer people an optional job
Person -> Person accounts that have worked or are working somewhere, have hobbies, skills, certificates; graduated from a school, etc.
Posts –> shared, liked, saved, commented by the user
Forum-> where posts are shared
Job Alert- offer that companies can create and that can be accepted by the user
Experience -> shows the experience of employees in companies
Group -> users can create a new group or join already created groups
Skill -> users can have many skills
Hobby -> users may have multiple hobbies
Certificate-> The user may have gained a certificate because of various evaluations.

What are the characteristics of each entity?
USERS
•	E-mail
•	UserID
•	Password
•	Phone
•	Address
The user can be a person, a company:
	PERSON
•	Person ID -PK
•	Person’s Name (FName, Minit, LName)
•	Date of Birth
•	Sex
•	CV
COMPANY
•	CompanyName
•	EmployeeNumber
POST
The users can post something with others, or like or comment on others’ posts.
•	Post-ID
•	ContentType
•	PostedDate
GROUP
The user can create a group or join another group.
•	G-ID (Group-ID)
•	GroupName
•	MemberNo
COURSE
The user can take a course or give a course to another people.
•	CCode (CourseCode)
•	CourName(CourseName)
•	Level
CERTIFICATE
The user can earn certificate. 
•	Cer-ID (Certificate ID)
•	CourseID
•	UserID
•	CerDate(Certificate Date)
•	CerName(Certificate Name)
SKILL 
The user can have skills, skills have id and name.
•	SkID(Skill ID)
•	SName(Skill Name)
HOBBY
The user also can have hobbies.
•	H-ID(HobbyID)
•	HName(HobbyName)


What relationships exists among the entities? 
The user must have a company or person type.  Companies can create job offers and people can view this offer. Users can share, like, save or comment as many posts as they want. Users can follow or send to messages to other users.  Also, persons can create a group or can be member of others’ groups. Person also can have certificate, skills, or hobbies.  Person can have experience with companies.
	COMPANY 1 CREATE N EXPERIENCE
	PERSON M VIEW N EXPERIENCE
	COMPANY 1 CREATE N JOB_AD
	JOB_AD N VIEW M PERSON
	PERSON 1 CREATE N GROUP
	GROUP M MEMBER_OF N PERSON
	PERSON N TAKES M COURSE
	COURSE N GIVES 1 PERSON
	PERSON N HAS M CERTIFICATE
	PERSON N SKILLS M SKILL
	USER N MESSAGES M
	USER N FOLLOWS M
	USER N LIKES M POST
	USER 1 POSTS N POST
	USER N COMMENTS M POST
	USER N SAVES M POST 


What are the constraints related to entities, their characteristics and the relationships among them? 
	CONSTRAINTS:
	GRUP:
	CONSTRAINT pk_GRUP primary key (GroupID), CONSTRAINT fk_GRUP_PERSON foreign key (CreatorPersonUserID) references PERSON(PersonUserID)
	MEMBER_OF:
	CONSTRAINT pk_MEMBER_OF primary key (MemberPersonUserID, MemberGroupID),
    	CONSTRAINT fk_MEMBER_OF_PERSON foreign key (MemberPersonUserID) references PERSON(PersonUserID),
  	CONSTRAINT fk_MEMBER_OF_GRUP foreign key (MemberGroupID) references GRUP(GroupID)
	COMPANY:
CONSTRAINT uq_CompanyName UNIQUE (CompanyName),
  	CONSTRAINT pk_COMPANY primary key (CompanyUserID),
    	CONSTRAINT fk_COMPANY_USERS foreign key (CompanyUserID) references USERS(UserID)
EXPERIENCE:
CONSTRAINT pk_EXPERIENCE primary key (Company, ExperienceUserID),
    	CONSTRAINT fk_EXPERIENCE_COMPANY foreign key (Company) references COMPANY(CompanyUserID),
   	 CONSTRAINT fk_EXPERIENCE_PERSON foreign key (ExperienceUserID) references PERSON(PersonUserID)
JOB_ALERT:
CONSTRAINT pk_JOB_ALERT primary key (AlertID, AlertingCompanyUserID),
    	CONSTRAINT fk_JOB_ALERT_COMPANY foreign key (AlertingCompanyUserID) references COMPANY(CompanyUserID)
	VIEW_ALERT:
CONSTRAINT pk_VIEW_ALERT primary key (ViewingPersonID, ViewedAlertID),
    CONSTRAINT fk_VIEW_ALERT_PERSON foreign key (ViewingPersonID) references PERSON(PersonUserID),
    CONSTRAINT fk_VIEW_ALERT_JOB_ALERT foreign key (ViewedAlertID) references JOB_ALERT(AlertID)
	FORUM:
CONSTRAINT pk_FORUM primary key (ForumTitle),
    	CONSTRAINT fk_FORUM_USERS foreign key (CreatorUserID) references USERS(UserID)
	POST:
CONSTRAINT pk_POST primary key (PostID),
    	CONSTRAINT fk_POST_FORUM foreign key (ForumTitle) references FORUM(ForumTitle),
    	CONSTRAINT fk_POST_USERS foreign key (PosterUserID) references USERS(UserID)
COMMENTS:
CONSTRAINT pk_COMMENTS primary key (CommentingUserID, CommentedPostID),
    	CONSTRAINT fk_COMMENTS_USERS foreign key (CommentingUserID) references USERS(UserID)
	SAVES:
CONSTRAINT pk_SAVES primary key (SavingUserID, SavedPostID),
    	CONSTRAINT fk_SAVES_USERS foreign key (SavingUserID) references USERS(UserID)
LIKES:
CONSTRAINT pk_LIKES primary key (LikingUserID, LikedPostID),
    	CONSTRAINT fk_LIKES_USERS foreign key (LikingUserID) references USERS(UserID)
	SKILL:
CONSTRAINT pk_SKILL primary key (SkillID),
    	CONSTRAINT fk_SKILL_USERS foreign key (SkillPersonUserID) references PERSON(PersonUserID)

	HOBBY:
CONSTRAINT pk_HOBBY primary key (HobbyID),
   	 CONSTRAINT fk_Hobby_USERS foreign key (HobbyPersonUserID) references PERSON(PersonUserID)
HAS:
CONSTRAINT pk_HAS primary key (HobbysPersonUserID, HHobbyID),
    	CONSTRAINT fk_HAS_PERSON foreign key (HobbysPersonUserID) references PERSON(PersonUserID),
    	CONSTRAINT fk_HAS_HOBBY foreign key (HHobbyID) references HOBBY(HobbyID)

EER DIAGRAM FOR LINKEDIN MODEL

<img width="538" alt="linkedineer1" src="https://user-images.githubusercontent.com/71318378/152635570-9a29e5c1-bd03-46c1-a29b-9145ea4f2586.png">


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

MOODLE ANALYSIS AND DESIGN

KEY ENTITIES:
•	Site Administrator
o	This type of user can do anything.
•	Manager
o	Is similar to site administrator but with a few tweaks
•	Course Creator
o	This user creates courses. By default a course creator is the Teacher.
•	Teacher
o	Can manage and edit the contents of courses
•	Non-Editing Teacher
o	This type of user can grade courses but can’t do much else. Sort of like course assistans.
•	Student
o	Students can access and participate in courses and performsa assigned tasks.
•	Guest
o	Guests can view courses but they can’t be a part of them
•	Authenticated User
o	This is a meta role. All logged in users have this role.

In actual Moodle database there are way more entities. But in this project, we will be focusing on these key entities:  
PERSON
o	A person is the main user of this system.
•	ACCOUNT
o	Every person has some kind of account.
•	COURSE
o	This is where classes happen.
•	CONTENT
o	Any informational material that is needed for participation or understanding classes.
•	QUIZ
o	A test of knowledge. Series of questions that is asked to students.
•	ASSIGNMENT
o	Long term homework given to students.
•	QUESTIONS
o	Contents of a quiz or an assignment.
•	CERTIFICATE
o	A certificate of achievement that you get for successfully completing all the tasks.
•	MESSAGAES
o	Communication box between two people. (a person can send and receive messages- unary relationship)
•	FEEDBACK
o	Students can send feedback to teachers about things that they don’t like.


PERSON:
A person is the main user of this system. This person can be a teacher, student, assistant or administrator. Apart from the differences, each person has their username (first name, middle name initials, last name), date of birth, address, phone number, e-mail and a unique user id stored in this database.
o	Teacher:
If this person is a teacher, their expertness, department ,salary and diploma information (diploma given date, college obtained) is stored.
o	Student:
If this person is a student, their gpa, enrolled courses and their department is stored.
o	Assistant:
If this person is an assistant, their thesis and diploma information is stored.
o	Administrator:
If this person is an administrator, there is no extra information is stored.

![resim](https://user-images.githubusercontent.com/71318378/152635599-c6a7961c-8f7d-4b8b-8b9e-1ab69bed4ec5.png)

ACCOUNT:
	Every user listed above must have some kind of an account. And every account has their person’s role and a unique account id stored in them.

![resim](https://user-images.githubusercontent.com/71318378/152635604-2d0643a4-2a02-4389-8a7f-40c62e6f3543.png)


COURSE:
	Every course has their credit hours, level of education, description and unique course code and course name kept in this database.

![resim](https://user-images.githubusercontent.com/71318378/152635612-c8b95950-c60f-4388-8494-c0200501501e.png)

CONTENT:
	Materials that are used in the courses are called, course contents. It can be of different file types. A content has a file type, availability date range (upload date and self-destruct date), and a unique content no.

![resim](https://user-images.githubusercontent.com/71318378/152635618-60ec3f0b-a880-421c-89b1-e21c17975a75.png)

EVALUATION:
	Evaluation is done by QUIZ and ASSIGNMENTS. Every Quiz is graded, has a number of questions and has it’s unique quiz no. Every Assignment is also graded and has a number of questions. They also have a user’s number of attempts, due date and a unique assignment id. And Evaluation has a feedback process as well.

![resim](https://user-images.githubusercontent.com/71318378/152635628-804eadf1-299a-487f-8dc2-8c4d4400dd48.png)

QUESTIONS:
	Every Evaluation process is made out of questions. Every question entity has a question type.

![resim](https://user-images.githubusercontent.com/71318378/152635633-5cd49173-af8e-4d28-847f-79ebc7954a9e.png)

CERTIFICATE:
	A certificate is given after a student achieves necessary amount achievements for a course. A certificate has given date, course name and a unique certificate id.  

![resim](https://user-images.githubusercontent.com/71318378/152635645-7c593d61-538a-4a41-aab7-3f1d47795e3a.png)

FORUM:
	Users share their ideas and ask and answer each other’s posts. Every user has to post with their user id and every post has it’s unique post id.  

![resim](https://user-images.githubusercontent.com/71318378/152635647-f3e39836-9293-41c6-9ad7-031046ca1c4d.png)

MESSAGES:
	It’s a communication process between two people. A person can both send and receive messages. Every message has information about both sender and receiver and time sent.


DATA REQUIREMENTS AND RELATIONSHIPS BETWEEN ENTITIES 

A person must have an account and an account must be bound to one person only. A person can message with another person as well. A person can share posts in forums and forums may have multiple people posting on them. If this person is a teacher, they may be giving more than one course, but a course must have only one teacher.  A teacher and assistants can upload contents to courses, naturally they can upload more than one content per course. Students can use these contents via downloading them. Accounts earn certificates. A certificate may be possessed by more than one person and a person may achieve more than one certificate. Administrators provide support and they contact with other group of people.
Teachers will make evaluations for students. So, a course must have at least one of these evaluation tasks. And students are evaluated. Quizzes and assignments can be graded by both teacher and assistants. Both of these evaluation elements are made of multiple questions. These evaluation tasks are answered by students. A student may have more than one evaluation per course. Evaluations grant students, certificates.  After the exams are done, students get to give feedback about them. A teacher will receive these feedbacks. 
PERSON	1	HAS	1	ACCOUNT	
PERSON	M	EARNS	M	CERTIFICATE	
PERSON	1	MESSAGES 1	PERSON
PERSON	M	POSTS ON  M	FORUM	
TEACHER	1	GIVES	M	COURSE	
TEACHER	1	DOES	M	EVALUATIONS	
TEACHER	1	UPLOADS M	CONTENT
TEACHER	1	GRADES  M	EVALUATIONS
TEACHER 	1	RECIEVES M	FEEDBACK
ASSISTANT	1	GRADES  M	EVALUATIONS
ASSISTANT	1	UPLOADS   M 	CONTENT
STUDENTS 	1	TAKE	M	EVALUATIONS
STUDENTS	M	USE	M	CONTENT
STUDENTS 	M	ENROLL	 TO  M	COURSE            
STUDENTS 	1	GIVE	M	FEEDBACK
ADMINISTRATORS M	SUPPORT M	PERSON ?????
EVALUATIONS	M	GRANTS     1	CERTIFICATE
EVALUATIONS     M	HAS	    M	QUESTIONS
COURSE 		CONTAINS		CONTENT
COURSE    		HAS 			EVALUATIONS

Constraints:
Users:
	CONSTRAINT pk_USERS primary key (UserID),
 CONSTRAINT uq_EMail UNIQUE (EMail)
	PhoneNumber:
		CONSTRAINT pk_USER_PHONE primary key (PhoneUsersID, PhoneNumber),
   		 CONSTRAINT pf_USER_PHONE_USERS foreign key (PhoneUsersID) references USERS(UserID)
	Address:
		CONSTRAINT pk_USER_ADDRESS primary key (AddressUsersID, Address),
   		 CONSTRAINT pf_USER_ADDRESS_USERS foreign key (AddressUsersID) references USERS(UserID)
	Person:
CONSTRAINT pk_PERSON primary key (PersonUserID),
    		CONSTRAINT fk_PERSON_USERS foreign key (PersonUserID) references USERS(UserID)
	Messages:
CONSTRAINT pk_MESSAGES primary key (SenderUserID, RecieverUserID),
    		CONSTRAINT fk_MESSAGES_PERSON1 foreign key (SenderUserID) references PERSON(PersonUserID),
    		CONSTRAINT fk_MESSAGES_PERSON2 foreign key (RecieverUserID) references PERSON(PersonUserID)
Administrator:
	CONSTRAINT pk_ADMINISTRATOR primary key (AdminID),
    	CONSTRAINT fk_ADMINISTRATOR_USERS foreign key (AdminID) references PERSON(PersonUserID)
Teaching Staff:
	CONSTRAINT pk_TEACHING_STAFF primary key (TeachingUserID),
    	CONSTRAINT fk_TEACHING_STAFF_USER foreign key (TeachingUserID) references PERSON(PersonUserID)
Student:
	CONSTRAINT pk_STUDENT primary key (StudentUserID),
    CONSTRAINT fk_STUDENT_USERS foreign key (StudentUserID) references Person(PersonUserID)
Teacher:
	CONSTRAINT pk_TEACHER primary key (TeacherUserID),
    	CONSTRAINT fk_TEACHER_USER foreign key (TeacherUserID) references TEACHING_STAFF(TeachingUserID)
Feedback:
CONSTRAINT pk_FEEDBACK primary key (FeedbackID),
    	CONSTRAINT fk_FEEDBACK_STUDENT foreign key (SendingStudentUserID) references STUDENT(StudentUserID),
    	CONSTRAINT fk_FEEDBACK_TEACHER foreign key (RecievingTeacherUserID) references TEACHER(TeacherUserID)
Assistant:
	CONSTRAINT pk_ASSISTANT primary key (AssistantUserID),
 	CONSTRAINT fk_ASSISTANT_USERS foreign key (AssistantUserID) references TEACHING_STAFF(TeachingUserID)
Course:
	CONSTRAINT pk_COURSE primary key (CourseCode),
 	CONSTRAINT fk_COURSE foreign key (CourseTeacherUserID) references TEACHER(TeacherUserID)
Content:
CONSTRAINT pk_CONTENT primary key (ContentNo),
    	CONSTRAINT fk_CONTENT_TEACHING_STAFF foreign key (UploaderUserID) references TEACHING_STAFF(TeachingUserID)
Uploads:
CONSTRAINT pk_UPLOADS primary key (UppingTeachingStaffUserID),
    	CONSTRAINT fk_UPLOADS_TEACHING_STAFF foreign key (UppedContentNo) references TEACHING_STAFF(TeachingUserID)
Evaluation:
CONSTRAINT pk_EVALUATION primary key (EvaluationID, TakingStudentUserID, MakerUserID, CourseID, GraderUserID),
    	CONSTRAINT fk_EVALUATION_TEACHING_STAFF1 foreign key (MakerUserID) references TEACHING_STAFF(TeachingUserID),
    	CONSTRAINT fk_EVALUATION_TEACHING_STAFF2 foreign key (GraderUserID) references TEACHING_STAFF(TeachingUserID),
    	CONSTRAINT fk_EVALUATION_COURSE foreign key (CourseID) references COURSE(CourseCode),
   	 CONSTRAINT fk_EVALUATION_STUDENT foreign key (TakingStudentUserID) references STUDENT(StudentUserID)
Assignment:
CONSTRAINT pk_ASSIGNMENT primary key (ATakingStudentUserID, AEvaluationID),
    	CONSTRAINT fk_ASSIGNMENT_STUDENT foreign key (ATakingStudentUserID) references STUDENT(StudentUserID),
    	CONSTRAINT fk_ASSIGNMENT_EVALUATION foreign key (AEvaluationID) references EVALUATION(EvaluationID)
Quiz:
CONSTRAINT pk_QUIZ primary key (QTakingStudentUserID, QEvaluationID),
    	CONSTRAINT fk_QUIZ_STUDENT foreign key (QTakingStudentUserID) references STUDENT(StudentUserID),
    	CONSTRAINT fk_QUIZ_EVALUATION foreign key (QEvaluationID) references EVALUATION(EvaluationID)
Enrolls:
CONSTRAINT pk_ENROLLS primary key (EnrolledCourseCode, EnrollingStudentUserID),
    	CONSTRAINT fk_ENROLLS_COURSE foreign key (EnrolledCourseCode) references COURSE(CourseCode),
    	CONSTRAINT fk_ENROLLS_STUDENT foreign key (EnrollingStudentUserID) references STUDENT(StudentUserID)
Take:
CONSTRAINT pk_TAKE primary key (TStudentUserID, TEvaluationID, EMakerID, EGraderID, EvalTakenCourseID),
    	CONSTRAINT fk_TAKE_STUDENT foreign key (TStudentUserID) references STUDENT(StudentUserID),
    	CONSTRAINT fk_TAKE_EVALUATION foreign key (TEvaluationID) references EVALUATION(EvaluationID),
    	CONSTRAINT fk_TAKE_TEACHING_STAFF1 foreign key (EMakerID) references TEACHING_STAFF(TeachingUserID),
    	CONSTRAINT fk_TAKE_TEACHING_STAFF2 foreign key (EGraderID) references TEACHING_STAFF(TeachingUserID),
    	CONSTRAINT fk_TAKE_COURSE foreign key (EvalTakenCourseID) references COURSE(CourseCode)
Certificate:
CONSTRAINT pk_CERTIFICATE primary key (CertificateID),
   	 CONSTRAINT fk_CERTIFICATE_COURSE foreign key (CertificateCourseID) references COURSE(CourseCode),
    	CONSTRAINT fk_CERTIFICATE_STUDENT foreign key (CertificatedStudentUserID) references STUDENT(StudentUserID),
    	CONSTRAINT fk_CERTIFICATE_EVALUATION foreign key (CertificatingEvaluationID) references EVALUATION(EvaluationID),
    	CONSTRAINT fk_CERTIFICATE_TEACHING_STAFF1 foreign key (EMakerID) references TEACHING_STAFF(TeachingUserID),
   	CONSTRAINT fk_CERTIFICATE_TEACHING_STAFF2 foreign key (EGraderID) references TEACHING_STAFF(TeachingUserID)
Earns:
CONSTRAINT pk_EARNS primary key (EarningPersonUserID, EarnedCertificateID),
    	CONSTRAINT fk_EARNS_PERSON foreign key (EarningPersonUserID) references PERSON(PersonUserID),
    	CONSTRAINT fk_EARNS_CERTIFICATE foreign key (EarnedCertificateID) references CERTIFICATE(CertificateID)
Questions:
CONSTRAINT pk_QUESTIONS primary key (QuestionID, ExamEvaluationID),
    	CONSTRAINT fk_QUESTIONS_EVALUATION foreign key (ExamEvaluationID) references EVALUATION(EvaluationID)

