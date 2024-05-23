-- Query Console 1
select @@SPID
select @@TRANCOUNT
DBCC USEROPTIONS

delete from Formula1TeamDriver
delete from Formula1Team
delete from Formula1Driver

insert into Formula1Team (team_id, name, country, team_principal) values (1, 'Team A', 'France', 'John Doe')

alter database LAB3_SEM2 set allow_snapshot_isolation on

begin tran
declare @oldData varchar(100)
declare @newData varchar(100)
update Formula1Team set @oldData=team_principal, team_principal='New Team Principal', @newData=team_principal where team_id=1
waitfor delay '00:00:10'
exec sp_log_changes @oldData, @newData, 'Update Conflict 1: update'
exec sp_log_locks 'Update Conflict 1: after update'
select * from Formula1Team
commit tran

-- Query Console 2
select @@SPID
select @@TRANCOUNT
DBCC USEROPTIONS

--set transaction isolation level read uncommitted --solution
set transaction isolation level snapshot

begin tran
declare @oldData varchar(100)
declare @newData varchar(100)
update Formula1Team set @oldData=team_principal, team_principal='Another New Team Principal', @newData=team_principal where team_id=1
exec sp_log_changes @oldData, @newData, 'Update Conflict 2: update'
exec sp_log_locks 'Update Conflict 2: after update'
select * from Formula1Team
commit tran
