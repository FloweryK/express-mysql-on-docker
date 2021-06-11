## timezone
set global time_zone = 'Asia/Seoul';
set time_zone = 'Asia/Seoul';

drop database if exists waplshop;

create database waplshop;

use waplshop;

create table tables (
	tableID int not null auto_increment,
	name char(20) not null,
	isDeleted boolean not null default 0,
	primary key (tableID)
    );

create table categories (
	categoryID int not null auto_increment,
	name char(20) not null,
    isDeleted boolean not null default 0,
    primary key (categoryID)
    );

create table items (
	itemID int not null auto_increment,
	name char(20) not null,
	price int not null,
	isOrder boolean not null,
    categoryID int,
    isDeleted boolean not null default 0,
    primary key (itemID),
    foreign key (categoryID) references categories (categoryID)
    );

create table orders (
    orderID int not null auto_increment,
    bundleID int not null,
    tableID int,
    itemID int not null,
    itemAmount int not null,
    orderAt datetime not null default current_timestamp on update current_timestamp,
    status int not null default 0,
    isPayed boolean not null,
    isDeleted boolean not null default 0,
    primary key (orderID),
    foreign key (tableID) references tables (tableID),
    foreign key (itemID) references items (itemID)
    );

## Add Tables
delimiter $$
create procedure addTables()
begin
    declare i int default 1;
    while (i <= 5) do
            insert into tables (tableID, name, isDeleted) value(i, i, 0);
            set i = i + 1;
        end while ;
end $$
delimiter ;

call addTables();

## Add Categories
delimiter $$
create procedure addCategories()
begin
    declare i int default 1;
    while (i <= 3) do
            insert into categories (name) value(i);
            set i = i + 1;
        end while ;
end $$
delimiter ;

call addCategories();

## Add Items
delimiter $$
create procedure addItems()
begin
    declare i int default 1;
    while (i <= 10) do
            insert into items (name, price, isOrder, categoryID) value(i, i*1000, round(rand()), 1+floor(rand()*3));
            set i = i + 1;
        end while ;
end $$
delimiter ;

call addItems();

## Add Orders
delimiter $$
create procedure addOrders()
begin
    declare i int default 1;
    while (i <= 20) do
            insert into orders (bundleID, tableID, itemID, itemAmount, isPayed) value (i, 1+floor(rand()*5), 1+floor(rand()*10), 1+floor(rand()*3), 0);
            set i = i + 1;
        end while ;
end $$
delimiter ;

call addOrders();