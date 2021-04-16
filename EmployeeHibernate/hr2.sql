DROP DATABASE if exists hr2;
create database hr2;
use hr2;
# CREATE USER 'hr_admin' IDENTIFIED BY '135791';
GRANT ALL ON TABLE Employees TO 'hr_admin';
GRANT ALL ON TABLE departments TO 'hr_admin';

create table departments
(
    code    int primary key,
    descrip varchar(15) not null
);
create table employees
(
    id   int primary key,
    name varchar(15) not null,
    code int         not null,
    foreign key (code) references departments (code)
);
insert into departments
values (1, "HR");
insert into departments
values (2, "IT");
insert into employees
values (2, "Stan", 1);
insert into employees
values (1, "Perry", 1);
insert into employees
values (4, "Emily", 2);
insert into employees
values (3, "Cynthia", 2);
select *
from departments;
select *
from employees;
GRANT ALL ON TABLE departments TO 'hr_admin';
GRANT ALL ON TABLE Employees TO 'hr_admin';