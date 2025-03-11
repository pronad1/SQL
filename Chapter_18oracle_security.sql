
show user;
connect SYSTEM/0000;

grant CREATE session to dora;

show user;

CONNECT dora/avocado;

show dora;

alter user Dora IDENTIFIED by psyche;

grant CREATE session to dora;

CONNECT dora/psyche;

-- show all user

SELECT username FROM dba_users;


-- show all profile 

 SELECT DISTINCT profile FROM dba_profiles;



-- show profile attribute ---

SELECT RESOURCE_NAME, LIMIT
FROM DBA_PROFILES
WHERE PROFILE = 'LIMITED_PROFILE';


-- create and connect a new user

 create user prosen identified by prosen;

 show user;
 GRANT CREATE SESSION to prosen;
 show USER;
 CONNECT prosen/prosen;

-- Password Change
 show USER

  password
Changing password for PROSEN
Old password:prosen
New password:pro
Retype new password:pro
Password changed

show user
USER is "PROSEN"
SQL> connect system/0000
Connected.
SQL> show user
USER is "SYSTEM"
SQL> connect prosen/pro;
Connected.
SQL> show user
USER is "PROSEN"
SQL>

-- FAILED LOGIN ATTEMPTS

 show user
USER is "SYSTEM"

-- create profile
SQL> create profile limit_profile limit
  2  failed_login_attempts 3;

Profile created.


-- create user
SQL> create user jane identified by eyre
  2  profile limit_profile;

User created.

show user
USER is "SYSTEM"
grant create session to jane;

Grant succeeded.

connect jane/eyre;
Connected.
SQL> show user
USER is "JANE"
SQL> connect system/0000
Connected.
SQL> show user
USER is "SYSTEM"
SQL> connect jane/eyr;
ERROR:
ORA-01017: invalid username/password; logon denied


Warning: You are no longer connected to ORACLE.
SQL> connect jane/eyr;
ERROR:
ORA-01017: invalid username/password; logon denied


SQL> connect jane/eyr;
ERROR:
ORA-01017: invalid username/password; logon denied


SQL> connect jane/eyr;
ERROR:
ORA-28000: the account is locked

--  account unlock

alter user JANE account unlock;
User altered.
SQL> connect jane/eyre;
Connected.
SQL> show user
USER is "JANE"


-- Profile update

alter profile LIMITED_PROFILE limit
PASSWORD_LOCK_TIME 2;

-- PASSWORD_LOCK_TIME 

-- Combined

 create profile combined_profile limit
    failed_login_attempts 2
    password_life_time 10
    password_reuse_time 5
    password_reuse_max 2
    password_lock_time 2
    password_grace_time 8
  ;

Profile created.
create user JANEcom identified by eyre
profile COMBINED_PROFILE;

user created

grant CREATE SESSION to JANEcom;

connect  JANEcom/pk;

connect  JANEcom/pk;
ERROR:
ORA-28002: the password will expire within 8 days


Connected.
SQL> show user
USER is "JANECOM"




-- password expire
 connect dora/dora;
ERROR:
ORA-28001: the password has expired


Changing password for dora
New password:
Retype new password:
Password changed
Connected.
SQL> connect dora/dora
Connected.
SQL> show user
USER is "DORA"

-- Alter user profile
alter user dora profile LIMITED_PROFILE;
User altered.

-- PASSWORD_REUSE_MAX,PASSWORD_REUSE_TIME    //PASSWORD_REUSE_TIME is 30 and PASSWORD_REUSE_MAX is 10, the user can reuse a password after 30 days if it is not one of the last 10 passwords used.
alter profile LIMITED_PROFILE limit
PASSWORD_REUSE_MAX 3
PASSWORD_REUSE_TIME UNLIMITED;

create user password identified by pass profile LIMITED_PROFILE;

User created.
SQL> show user;
USER is "SYSTEM"
SQL> grant CREATE SESSION to password;

Grant succeeded.
SQL> connect password/pass;
Connected.
SQL> password
Changing password for PASSWORD
Old password:
New password:
Retype new password:
Password changed
SQL> password
Changing password for PASSWORD
Old password:
New password:
Retype new password:
Password changed
SQL> password
Changing password for PASSWORD
Old password:
New password:
Retype new password:
Password changed
SQL> password
Changing password for PASSWORD
Old password:
New password:
Retype new password:
Password changed
SQL> password
Changing password for PASSWORD
Old password:
New password:
Retype new password:
ERROR:
ORA-28007: the password cannot be reused


Password unchanged
SQL> password
Changing password for PASSWORD
Old password:
New password:
Retype new password:
Password changed
-- In this case we cann't use mutually exclusive mean if we set a value for one of them, the other must not be set to UNLIMITED.

-- Assignment

create profile combine limit
    password_life_time 10
    password_grace_time 8
    password_reuse_max 3
    password_lock_time 1
    failed_login_attempts 2
    password_reuse_time 10
    ;

    Profile created.



-- Project privilege Management
-- Allow access to other user to create table

SQL> create user tab identified by tab;

User created.

SQL> grant create session to tab;

Grant succeeded.

SQL> connect tab/tab;
Connected.
SQL> show user;
USER is "TAB"
SQL> connect system/0000;
Connected.
SQL> create user bob identified by bob
  2  ;

User created.

SQL> grant create session, create table,create view, create synonym to bob;

Grant succeeded.
alter user bob
default tablespace users
quota 5m on users;

User altered.

SQL> show user
USER is "BOB"
SQL> create table newspaper(
  2  Feature varchar(25) not null,
  3  Section char(1),
  4  page number
  5  );

Table created.

 insert into NEWSPAPER values ('National News', 'A', 1);


select * from newspaper;

FEATURE                   S       PAGE
------------------------- - ----------
National News             A          1
Sports                    D          1
Editorials                A         12
Business                  E          1
Weather                   C          2
Television                B          7
Births                    F          7
Classified                F          8
Modern Life               B          1
Comics                    C          4
Movies                    B          4

FEATURE                   S       PAGE
------------------------- - ----------
Bridge                    B          2
Obituaries                F          6
Doctor Is In              F          6

14 rows selected.

 grant select on newspaper to tab;

Grant succeeded.

SQL> connect tab/tab;
Connected.
SQL> select * from bob.newspaper;

FEATURE                   S       PAGE
------------------------- - ----------
National News             A          1
Sports                    D          1
Editorials                A         12
Business                  E          1
Weather                   C          2
Television                B          7
Births                    F          7
Classified                F          8
Modern Life               B          1
Comics                    C          4
Movies                    B          4

FEATURE                   S       PAGE
------------------------- - ----------
Bridge                    B          2
Obituaries                F          6
Doctor Is In              F          6

14 rows selected.
connect bob/bob;
Connected.
SQL> grant insert on newspaper to tab;

Grant succeeded.

connect tab/tab;
Connected.
SQL> show user;
USER is "TAB"
 insert into bob.newspaper values ('Nation News','A',3);

1 row created.

select * from bob.newspaper;

FEATURE                   S       PAGE
------------------------- - ----------
National News             A          1
Sports                    D          1
Editorials                A         12
Business                  E          1
Weather                   C          2
Television                B          7
Births                    F          7
Classified                F          8
Modern Life               B          1
Comics                    C          4
Movies                    B          4

FEATURE                   S       PAGE
------------------------- - ----------
Bridge                    B          2
Obituaries                F          6
Doctor Is In              F          6
Nation News               A          3

15 rows selected.

show user;


-- Project Password Management
--a. Create a profile
create profile Password_Management limit
    PASSWORD_LIFE_TIME 10
    PASSWORD_GRACE_TIME 8
    PASSWORD_REUSE_MAX 3
    PASSWORD_LOCK_TIME 1
    FAILED_LOGIN_ATTEMPTS 2
    PASSWORD_REUSE_TIME 10
    ;

create user project identified by project
profile Password_Management;

grant create session to project;

connect project/project;

SQL> connect system/0000
Connected.
SQL> connect project/11
ERROR:
ORA-01017: invalid username/password; logon denied


Warning: You are no longer connected to ORACLE.
-- Account is lock after 2 failed login
SQL> connect project/1
ERROR:
ORA-01017: invalid username/password; logon denied


SQL> connect project/1
ERROR:
ORA-28000: the account is locked

-- After 1 day

SQL> connect project/project
Connected.

-- password expire after 10 days
connect system/0000
Connected.
SQL> connect project/project
ERROR:
ORA-28002: the password will expire within 8 days


Connected.

-- password grace time 8 days

SQL> connect project/project
ERROR:
ORA-28001: the password has expired


Changing password for project
New password:1
Retype new password:1
Password changed
Connected.

SQL> connect system/0000
Connected.
SQL> connect project/1
Connected.

-- password reuse time 10 days
SQL> password
Changing password for PROJECT
Old password:
New password:
Retype new password:
ERROR:
ORA-28007: the password cannot be reused


Password unchanged
SQL> password
Changing password for PROJECT
Old password:
New password:
Retype new password:
Password changed

--password reuse max 3
SQL> password
Changing password for PROJECT
Old password:
New password:
Retype new password:
ERROR:
ORA-28007: the password cannot be reused


Password unchanged
SQL> password
Changing password for PROJECT
Old password:
New password:
Retype new password:
ERROR:
ORA-28008: invalid old password


Password unchanged


-- b. mutually exclusive
-- PASSWORD_REUSE_MAX,PASSWORD_REUSE_TIME    //PASSWORD_REUSE_TIME is 30 and PASSWORD_REUSE_MAX is 10, the user can reuse a password after 30 days if it is not one of the last 10 passwords used.
alter profile LIMITED_PROFILE limit
PASSWORD_REUSE_MAX 3
PASSWORD_REUSE_TIME UNLIMITED;

create user password identified by pass profile LIMITED_PROFILE;

User created.
SQL> show user;
USER is "SYSTEM"
SQL> grant CREATE SESSION to password;

Grant succeeded.
SQL> connect password/pass;
Connected.
SQL> password
Changing password for PASSWORD
Old password:
New password:
Retype new password:
Password changed
SQL> password
Changing password for PASSWORD
Old password:
New password:
Retype new password:
Password changed
SQL> password
Changing password for PASSWORD
Old password:
New password:
Retype new password:
Password changed
SQL> password
Changing password for PASSWORD
Old password:
New password:
Retype new password:
Password changed
SQL> password
Changing password for PASSWORD
Old password:
New password:
Retype new password:
ERROR:
ORA-28007: the password cannot be reused


Password unchanged
SQL> password
Changing password for PASSWORD
Old password:
New password:
Retype new password:
Password changed
-- In this case we cann't use mutually exclusive mean if we set a value for one of them, the other must not be set to UNLIMITED.


--  Project privilege Management
-- A table that create under a user and show that table and insert data from another user

create user Person2 identified by 1234;

SQL> grant create session to Person2;

Grant succeeded.

connect Person2/1234;
Connected.

SQL> create user Person1 identified by pp;

User created.

SQL> grant create session to Person1;

Grant succeeded.

connect Person1/5678; 
Connected.

 grant create user, grant any privilege to Person2;

Grant succeeded.

 connect Person2/1234;
Connected.
SQL> grant create session, create table, create view, create synonym to Person1;

Grant succeeded.

 alter user Person1
  2    default tablespace users
  3    quota 5m on users;

User altered.


SQL> show user
USER is "SYSTEM"
SQL> connect Person1/5678;
Connected.
SQL> show user
USER is "PERSON1"
SQL> create table newspaper(
  2   Feature varchar(25) not null,
  3  Section char(1),
  4  page number
  5  );

Table created.

SQL> insert into NEWSPAPER values ('National News', 'A', 1);

1 row created.

SQL> insert into NEWSPAPER values ('Sports', 'D', 1);

1 row created.

SQL> insert into NEWSPAPER values ('Editorials', 'A', 12);

1 row created.

SQL> insert into NEWSPAPER values ('Business', 'E', 1);

1 row created.

SQL> insert into NEWSPAPER values ('Weather', 'C', 2);

1 row created.

SQL> insert into NEWSPAPER values ('Television', 'B', 7);

1 row created.

SQL> insert into NEWSPAPER values ('Births', 'F', 7);

1 row created.

SQL> insert into NEWSPAPER values ('Classified', 'F', 8);

1 row created.

SQL> insert into NEWSPAPER values ('Modern Life', 'B', 1);

1 row created.

SQL> insert into NEWSPAPER values ('Comics', 'C', 4);

1 row created.

SQL> insert into NEWSPAPER values ('Movies', 'B', 4);

1 row created.

SQL> insert into NEWSPAPER values ('Bridge', 'B', 2);

1 row created.

SQL> insert into NEWSPAPER values ('Obituaries', 'F', 6);

1 row created.

SQL> insert into NEWSPAPER values ('Doctor Is In', 'F', 6);

1 row created.

SQL> select * from newspaper
  2  ;

FEATURE                   S       PAGE
------------------------- - ----------
National News             A          1
Sports                    D          1
Editorials                A         12
Business                  E          1
Weather                   C          2
Television                B          7
Births                    F          7
Classified                F          8
Modern Life               B          1
Comics                    C          4
Movies                    B          4

FEATURE                   S       PAGE
------------------------- - ----------
Bridge                    B          2
Obituaries                F          6
Doctor Is In              F          6

14 rows selected.

SQL> grant select on newspaper to Person2;

Grant succeeded.

SQL> connect Person2/1234;
Connected.
SQL> select * from Person1.newspaper;

FEATURE                   S       PAGE
------------------------- - ----------
National News             A          1
Sports                    D          1
Editorials                A         12
Business                  E          1
Weather                   C          2
Television                B          7
Births                    F          7
Classified                F          8
Modern Life               B          1
Comics                    C          4
Movies                    B          4

FEATURE                   S       PAGE
------------------------- - ----------
Bridge                    B          2
Obituaries                F          6
Doctor Is In              F          6

14 rows selected.

SQL> connect Person1/5678;
Connected.
SQL> grant insert on newspaper to Person2;

Grant succeeded.

SQL> connect Person2/1234;

Connected.

SQL> insert into Person1.newspaper values ('Nation News','A',3);

1 row created.


SQL> select * from Person1.newspaper;
