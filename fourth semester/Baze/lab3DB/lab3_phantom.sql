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

begin tran
waitfor delay '00:00:10'
insert into Formula1Team (team_id, name, country, team_principal) values (2, 'Team B', 'Germany', 'Max Verstappen')
exec sp_log_changes null, 'Team B', 'Phantom 1: insert'
exec sp_log_locks 'Phantom 1: after insert'
commit tran

-- Query Console 2
select @@SPID
select @@TRANCOUNT
DBCC USEROPTIONS

set transaction isolation level repeatable read
--set transaction isolation level serializable --solution
begin tran
select * from Formula1Team
exec sp_log_locks 'Phantom 2: between selects'
waitfor delay '00:00:10'
select * from Formula1Team
exec sp_log_locks 'Phantom 2: after both selects'
commit tran
