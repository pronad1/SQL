-- Trigger Management


create table edge(
    Title varchar2(100) primary key,
    Publisher varchar2(20),
    Categoryname varchar2(20),
    rating NUMERIC
);

insert into edge values
('TO KILL A MOCKINGBIRD','HARPERCOLLINS','ADULTFIC','5');

select * from edge;

CREATE table edge_audit(
    Title varchar2(100),
    Publisher VARCHAR2(20),
    CategoryName varchar2(20),
    Old_Rating NUMERIC,
    New_Rating NUMERIC,
    Audit_Date DATE
);
-- DROP TABLE EDGE_AUDIT;
-- DROP TRIGGER edge_audit_rec;
SELECT * from EDGE_AUDIT;

create or replace trigger edge_audit_rec
before insert or update of rating on edge
for each row BEGIN
if inserting THEN
insert into EDGE_AUDIT
(Title,PUBLISHER,CategoryName,NEW_RATING,AUDIT_DATE)
VALUES
(:new.Title,:new.Publisher,:new.CategoryName,:new.rating,SYSDATE);
ELSE
INSERT into EDGE_AUDIT
(Title,PUBLISHER,CATEGORYNAME,OLD_RATING,NEW_RATING,AUDIT_DATE)
VALUES
(:old.title,:old.Publisher,:old.CategoryName,:old.rating,:new.rating,SYSDATE);
end IF;
end;
/

INSERT into EDGE
values('SHOWLESS','MARING','AUDITER',10);

SELECT * from EDGE_AUDIT;
select * from EDGE;

update EDGE set RATING = 20 where TITLE='SHOWLESS';


-- Project Privilege Management
show user;
create user b identified by b;
grant create session to b;
create user a identified by a;
grant create session,create TABLE,create view,create SYNONYM to a;

alter user A
DEFAULT tablespace users
QUOTA 5m on users;

CONNECT a/a;
show user;

CREATE table newspaper(
    feature VARCHAR2(20) not null,
    section char(1),
    page NUMBER
);

select * from newspaper;

grant select on newspaper to b;

connect b/b;

select * from a.newspaper;

connect a/a;

grant insert on newspaper to b;

CONNECT b/b;

INSERT into a.newspaper values('Nation News','A',9);

SELECT * from a.newspaper;


-- Project Password Management

SQL> connect system/0000;
Connected.
SQL> create profile edge limit
  2  password_life_time 5
  3  password_grace_time 5
  4  password_reuse_time 4
  5  password_reuse_max 3
  6  password_lock_time 2
  7  failed_login_attempts 2
  8  ;

Profile created.


SQL> create user edge identified by edge
  2  profile edge;

User created.
SQL> grant create session to edge;

Grant succeeded.

SQL> connect edge/edge;
Connected.
SQL> connect system/0000;
Connected.

--failed_login_attempts 2
SQL> connect edge/edg;
ERROR:
ORA-01017: invalid username/password; logon denied


Warning: You are no longer connected to ORACLE.
SQL> connect edge/edg;
ERROR:
ORA-01017: invalid username/password; logon denied


SQL> connect edge/edg;
ERROR:
ORA-28000: the account is locked


SQL>

-- password_lock_time 2 mean after 2 days we connect this user

SQL> connect edge/edge;
ERROR:
ORA-28000: the account is locked


SQL> connect edge/edge;
Connected.

-- password life time 5 mean after 5 days it's show a sms for changing password
SQL> connect edge/edge;
ERROR:
ORA-28002: the password will expire within 5 days


Connected.

-- password grace time 5 mean after expire password life time then after 5 day it's also show same sms but when expire 5 days then it's must change password

SQL> connect edge/edge;
ERROR:
ORA-28002: the password will expire within 2 days


Connected.

SQL> connect system/0000;
Connected.
SQL> connect edge/edge;
ERROR:
ORA-28001: the password has expired


Changing password for edge
New password:1
Retype new password:1
Password changed
Connected.

--password_reuse_time 4 mean Specifies that a user cannot reuse an old password for 4 days.

sql> connect edge/1;
connected
SQL> password
Changing password for EDGE
Old password:1
New password:1
Retype new password:1
ERROR:
ORA-28008: invalid old password


Password unchanged

SQL> connect system/0000;
Connected.
-- After 4 day
sql> connect edge/1;
connected
SQL> password
Changing password for EDGE
Old password:1
New password:2
Retype new password:2
Password changed

