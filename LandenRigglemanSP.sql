--for creating an account
use LogisticsWebData
go
create procedure CreateUserProfile
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @Email NVARCHAR(255),
    @Password NVARCHAR(255),
    @ContactNumber NVARCHAR(255),
    @Address NVARCHAR(255)
as
begin
    if 
    exists (select 1 from users where Email = @Email)
    begin
        Print 'User already exists, please try a new email or login to your existing account'
    end
    else    
    insert into users (FirstName, LastName, Email, Password, ContactNumber, Address)
    values (@FirstName, @LastName, @Email, @Password, @ContactNumber, @Address);
end
go


-- Check login for users to use their account
use LogisticsWebData
go
create procedure VarifyLogin
    @Email NVARCHAR(255),
    @Password NVARCHAR(255),
as
begin
    Select userid 
    from users
    where Email = @Email and Password = @Password;
end
go
    
