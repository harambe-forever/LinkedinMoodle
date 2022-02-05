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

![LinkedIn drawio](https://user-images.githubusercontent.com/71318378/152635520-b02ce144-7258-4530-83ed-7bf71deee88b.png)



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

MOODLE ANALYSIS AND DESIGN

