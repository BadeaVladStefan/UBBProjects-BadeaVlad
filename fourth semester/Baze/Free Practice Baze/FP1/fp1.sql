--Libraries, Publishers, Books, Authors, Readers, Affiliations

create table Libraries(
	LibraryId int primary key,
	LibraryName varchar(50),
	LibraryLocation varchar(250)
);

create table Authors(
	AuthorId int primary key,
	AuthorName varchar(250)
);

create table Publishers(
	PublisherId int primary key,
	PublisherName varchar(250)
);

Create table Books(
	BookId int primary key,
	Libraryid int foreign key references Libraries(LibraryId),
	BookTitle varchar(50),
	BookCategory varchar(100),
	PublisherId int foreign key references Publishers(PublisherId)
);

create table BooksAuthors(
	BookId int foreign key references Books(BookId),
	AuthorId int foreign key references Authors(AuthorId),
	primary key (BookId, AuthorId) 
);

create table Affiliations(
	AffiliationId int primary key,
	AffiliationName varchar(250)
);

create table Readers(
	ReaderId int primary key,
	ReaderName varchar(250),
	ReaderPreference varchar(250),
	AffiliationId int foreign key references Affiliations(AffiliationId)
);

create table ReadersBooks(
	BookId int foreign key references Books(BookId),
	ReaderId int foreign key references Readers(ReaderId),
	primary key (BookId, ReaderId) 
);

-- Insert sample data into Libraries
INSERT INTO Libraries (LibraryId, LibraryName, LibraryLocation) VALUES 
(1, 'Central Library', '123 Main St'),
(2, 'Westside Branch', '456 West St'),
(3, 'Eastside Branch', '789 East St');

-- Insert sample data into Authors
INSERT INTO Authors (AuthorId, AuthorName) VALUES 
(1, 'J.K. Rowling'),
(2, 'George R.R. Martin'),
(3, 'J.R.R. Tolkien'),
(4, 'Agatha Christie');

-- Insert sample data into Publishers
INSERT INTO Publishers (PublisherId, PublisherName) VALUES 
(1, 'Penguin Random House'),
(2, 'HarperCollins'),
(3, 'Simon & Schuster'),
(4, 'Hachette Book Group');

-- Insert sample data into Books
INSERT INTO Books (BookId, LibraryId, BookTitle, BookCategory, PublisherId) VALUES 
(1, 1, 'Harry Potter and the Sorcerers Stone', 'Fantasy', 1),
(2, 1, 'A Game of Thrones', 'Fantasy', 2),
(3, 2, 'The Hobbit', 'Fantasy', 1),
(4, 3, 'Murder on the Orient Express', 'Mystery', 3);

-- Insert sample data into BooksAuthors
INSERT INTO BooksAuthors (BookId, AuthorId) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- Insert sample data into Affiliations
INSERT INTO Affiliations (AffiliationId, AffiliationName) VALUES 
(1, 'University of Fictional Studies'),
(2, 'Fantasy Book Club'),
(3, 'Mystery Lovers Association');

-- Insert sample data into Readers
INSERT INTO Readers (ReaderId, ReaderName, ReaderPreference, AffiliationId) VALUES 
(1, 'Alice Smith', 'Fantasy', 1),
(2, 'Bob Johnson', 'Fantasy', 2),
(3, 'Charlie Brown', 'Mystery', 3),
(4, 'Diana Prince', 'Fantasy', 2);

-- Insert sample data into ReadersBooks
INSERT INTO ReadersBooks (BookId, ReaderId) VALUES 
(1, 1),
(1, 2),
(2, 1),
(3, 2),
(4, 3),
(2, 4);
