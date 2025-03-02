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