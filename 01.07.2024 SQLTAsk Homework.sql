Create Database LibraryDB
Use LibraryDB

Create Table Authors (
Id Int Identity Primary Key,
Name Nvarchar (50),
Surname Nvarchar (50)
)

Create Table Books (
Id Int Identity Primary Key,
Name Nvarchar (100),
PageCount Int,
AuthorId Int Foreign Key References Authors(Id)
)

Insert Into Authors
Values ('Zulfi', 'Livaneli'),
('Cafar', 'Cabbarli'),
('Celil', 'Memmedguluzade'),
('Victor', 'Huqo')

Insert Into Books
Values ('Serenad', 467,1),
('Kardeslerim', 516,1),
('Sevil', 315,2),
('Ana', 260,2),
('Danabas kendinin ehvalatlari', 400,3),
('Oluler', 355,3),
('Anamin kitabi', 200,3),
('Sefiller', 1500, 4),
('Edam mehkumunun son gunu', 78,4),
('Qurbaneli bey', 120, 3)

Select * from Books
Select * from Authors

Create View Books_With_Authors 
As
Select B.Id, B.Name, B.PageCount, A.Name 'Author Name', A.Surname 'Author Surname' 
From Books as B
Inner Join Authors as A
On B.AuthorId = A.Id

Select * from Books_With_Authors

Create procedure USP_GET_BOOKS_BY_NAME @name Nvarchar (100)
As
Select * from Books_With_Authors
Where Name = @name

Exec USP_GET_BOOKS_BY_NAME 'Kardeslerim'

Create View Books_With_Info 
As
Select A.Id 'Author Id', A.Name 'Author Name', A.Surname 'Author Surname', Count (B.AuthorId) As 'The number of all the authors books', Max (B.PageCount) as 'Max page count' 
From Books as B
Inner Join Authors as A
On B.AuthorId = A.Id
Group By A.Id, A.Name, A.Surname
Having Max (B.PageCount) Is not null;

Select * from Books_With_Info