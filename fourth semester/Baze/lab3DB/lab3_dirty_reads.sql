use [LAB3_SEM2]

-- Query Console 1
select @@SPID
select @@TRANCOUNT
DBCC USEROPTIONS

delete from Formula1TeamDriver
delete from Formula1Team
delete from Formula1Driver

insert into Formula1Team (team_id, name, country, team_principal) values (1, 'Team A', 'France', 'John Doe')
insert into Formula1Driver (driver_id, name, nationality) values (1, 'Lewis Hamilton', 'British')
insert into Formula1TeamDriver (team_id, driver_id) values (1, 1)

set transaction isolation level read uncommitted
-- set transaction isolation level read committed --solution

begin tran
select * from Formula1Team
exec sp_log_locks 'Dirty reads 2: after select'
waitfor delay '00:00:10'
select * from Formula1Team
waitfor delay '00:00:10'
select * from Formula1Team
commit tran

-- Query Console 2
select @@SPID
select @@TRANCOUNT
DBCC USEROPTIONS

begin tran
declare @oldData varchar(100)
declare @newData varchar(100)
update Formula1Team set @oldData=team_principal, team_principal='New Team Principal', @newData=team_principal where team_id=1
exec sp_log_changes @oldData, @newData, 'Dirty reads 1: update'
exec sp_log_locks 'Dirty reads 1: after update'
waitfor delay '00:00:10'
update Formula1Team set @oldData=team_principal, team_principal='Another New Team Principal', @newData=team_principal where team_id=1
exec sp_log_changes @oldData, @newData, 'Dirty reads 1: update'
exec sp_log_locks 'Dirty reads 1: after update'
waitfor delay '00:00:10'
commit tran
