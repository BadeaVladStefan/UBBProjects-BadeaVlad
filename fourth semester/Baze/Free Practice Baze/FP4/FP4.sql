--Categories: id, Name, Description
create table Categories(
	CategoryId int primary key,
	CategoryName varchar(50),
	CategoryDescription varchar(250)
);

--Projects: Id, categoryId, name, teamLead, 
create table Projects(
	ProjectId int primary key,
	CategoryId int foreign key references Categories(CategoryId),
	ProjectName varchar(50),
	ProjectTeamLead varchar(50)
);

--Developers: Id, ProjectId, name, age, experience
create table Developers(
	DeveloperId int primary key,
	ProjectId int foreign key references Projects(ProjectId),
	DeveloperName varchar(50),
	DeveloperAge int,
	DeveloperExperience int
);

--Task: id, developerid, description, due date
create table Tasks(
	TaskId int primary key,
	DeveloperId int foreign key references Developers(DeveloperId),
	TaskDescription varchar(250),
	TaskDueDate date
);

--Features: id, taskid, name, estimation
create table Features(
	FeatureId int primary key,
	TaskId int foreign key references Tasks(TaskId),
	FeatureName varchar(50),
	FeatureEstimation smallint
);

INSERT INTO Categories (CategoryId, CategoryName, CategoryDescription) VALUES
(1, 'Web Development', 'Projects related to building and maintaining websites'),
(2, 'Mobile Development', 'Projects related to developing mobile applications'),
(3, 'Data Science', 'Projects related to data analysis and machine learning');

INSERT INTO Projects (ProjectId, CategoryId, ProjectName, ProjectTeamLead) VALUES
(1, 1, 'Corporate Website', 'Alice Smith'),
(2, 1, 'E-commerce Platform', 'Bob Johnson'),
(3, 2, 'Fitness Tracker App', 'Carol White'),
(4, 3, 'Sales Forecasting', 'Dave Black');

INSERT INTO Developers (DeveloperId, ProjectId, DeveloperName, DeveloperAge, DeveloperExperience) VALUES
(1, 1, 'Emily Davis', 28, 5),
(2, 1, 'Frank Miller', 35, 10),
(3, 2, 'Grace Lee', 30, 7),
(4, 2, 'Hannah Wilson', 25, 3),
(5, 3, 'Ian Moore', 32, 8),
(6, 4, 'Jack Brown', 29, 6);

INSERT INTO Tasks (TaskId, DeveloperId, TaskDescription, TaskDueDate) VALUES
(1, 1, 'Design homepage layout', '2024-06-15'),
(2, 2, 'Implement user authentication', '2024-06-20'),
(3, 3, 'Develop shopping cart feature', '2024-06-25'),
(4, 4, 'Optimize database queries', '2024-06-30'),
(5, 5, 'Integrate fitness tracking API', '2024-07-05'),
(6, 6, 'Analyze historical sales data', '2024-07-10');

INSERT INTO Features (FeatureId, TaskId, FeatureName, FeatureEstimation) VALUES
(1, 1, 'Responsive Design', 8),
(2, 1, 'SEO Optimization', 5),
(3, 2, 'OAuth Integration', 10),
(4, 3, 'Multi-currency Support', 12),
(5, 4, 'Indexing Optimization', 7),
(6, 5, 'Step Counter Integration', 15),
(7, 6, 'Predictive Model', 20);
