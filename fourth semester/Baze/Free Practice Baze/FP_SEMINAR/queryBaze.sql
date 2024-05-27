

--questions: 
--1.C
--2.C
--3.B,C,D

create table Users(
	UserId int primary key,
	UserName varchar(50),
	CurrentCity varchar(50),
	DateOfBirth date
);

create table Categories(
	CategoryId int primary key,
	CategoryName varchar(50),
	CategoryDescription varchar(50)
);

create table Pages(
	PageId int primary key,
	PageName varchar(50),
	Categoryid int foreign key references Categories(CategoryId)
);

create table Likes(
	UserId int foreign key references Users(UserId),
	PageId int foreign key references Pages(PageId),
	primary key (UserId,PageId),
	DateOfLike date
);

create table Posts(
	PostId int primary key,
	UserId int foreign key references Users(UserId),
	DateOfPost date,
	PostText varchar(250),
	NumberOfShares int
);

create table Comment(
	CommentId int primary key,
	PostId int foreign key references Posts(PostId),
	CommentText varchar(250),
	CommentDate date,
	TopComment bit
);

-- Inserting entries into Users table
INSERT INTO Users (UserId, UserName, CurrentCity, DateOfBirth) 
VALUES 
    (1, 'JohnDoe', 'New York', '1990-05-15'),
    (2, 'JaneSmith', 'Los Angeles', '1985-10-20');

-- Inserting entries into Categories table
INSERT INTO Categories (CategoryId, CategoryName, CategoryDescription)
VALUES
    (1, 'Technology', 'Latest tech news and updates'),
    (2, 'Travel', 'Explore the world and share your experiences');

-- Inserting entries into Pages table
INSERT INTO Pages (PageId, PageName, CategoryId)
VALUES
    (101, 'TechUpdates', 1),
    (102, 'TravelDiaries', 2);

-- Inserting entries into Likes table
INSERT INTO Likes (UserId, PageId, DateOfLike)
VALUES
    (1, 101, '2024-05-10'),
    (2, 102, '2024-05-12');

-- Inserting entries into Posts table
INSERT INTO Posts (PostId, UserId, DateOfPost, PostText, NumberOfShares)
VALUES
    (501, 1, '2024-05-10', 'Excited about the new iPhone release!', 10),
    (502, 2, '2024-05-12', 'Had an amazing trip to Japan!', 20);

-- Inserting entries into Comment table
INSERT INTO Comment (CommentId, PostId, CommentText, CommentDate, TopComment)
VALUES
    (1001, 501, 'Can''t wait to get my hands on it!', '2024-05-11', 1),
    (1002, 502, 'Japan is on my bucket list!', '2024-05-13', 1);
