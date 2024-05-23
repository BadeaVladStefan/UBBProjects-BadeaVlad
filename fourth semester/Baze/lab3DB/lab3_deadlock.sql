-- Query Console 1

select @@TRANCOUNT
select @@SPID

delete from Formula1TeamDriver
delete from Formula1Team
delete from Formula1Driver

insert into Formula1Team (team_id, name, country, team_principal) values (1, 'Team A', 'France', 'John Doe')
insert into Formula1Driver (driver_id, name, nationality) values (1, 'Lewis Hamilton', 'British')
insert into Formula1TeamDriver (team_id, driver_id) values (1, 1)

begin tran
declare @oldData varchar(100)
declare @newData varchar(100)
update Formula1Team set @oldData=team_principal, team_principal='New Team Principal', @newData=team_principal where team_id=1
exec sp_log_changes @oldData, @newData, 'Deadlock 1: Update 1'
exec sp_log_locks 'Deadlock 1: between updates'
waitfor delay '00:00:05'
update Formula1Team set @oldData=team_principal, team_principal='Another New Team Principal', @newData=team_principal where team_id=2
exec sp_log_changes @oldData, @newData, 'Deadlock 1: Update 2'
commit tran

-- Query Console 2

select @@TRANCOUNT
select @@SPID

begin tran
declare @oldData varchar(100)
declare @newData varchar(100)
update Formula1Team set @oldData=team_principal, team_principal='Another Team Principal', @newData=team_principal where team_id=2
exec sp_log_changes @oldData, @newData, 'Deadlock 2: Update 1'
exec sp_log_locks 'Deadlock 2: between updates'
waitfor delay '00:00:05'
update Formula1Team set @oldData=team_principal, team_principal='Yet Another Team Principal', @newData=team_principal where team_id=1
exec sp_log_changes @oldData, @newData, 'Deadlock 2: Update 2'
commit tran
