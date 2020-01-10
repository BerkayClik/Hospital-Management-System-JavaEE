CREATE SCHEMA cs202;

CREATE TABLE cs202.Roles
(
  name VARCHAR(40) NOT NULL,
  role_id INT NOT NULL,
  PRIMARY KEY (role_id)
);

CREATE TABLE cs202.Departments
(
  dept_id INT NOT NULL auto_increment,
  name VARCHAR(40) NOT NULL,
  PRIMARY KEY (dept_id)
);

CREATE TABLE cs202.Rooms
(
  room_id INT NOT NULL auto_increment,
  name VARCHAR(40) NOT NULL,
  PRIMARY KEY (room_id)
);

CREATE TABLE cs202.Links
(
  l_id INT NOT NULL,
  name VARCHAR(150) NOT NULL,
  button_name VARCHAR(40) NOT NULL,
  PRIMARY KEY (l_id)
);

CREATE TABLE cs202.LinkRoleRel
(
  l_id INT NOT NULL,
  role_id INT NOT NULL,
  FOREIGN KEY (l_id) REFERENCES Links(l_id),
  FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

CREATE TABLE cs202.Users
(
  u_id INT NOT NULL auto_increment,
  name VARCHAR(45) NOT NULL,
  pw VARCHAR(50) NOT NULL,
  email VARCHAR(40) NOT NULL,
  role_id INT NOT NULL,
  PRIMARY KEY (u_id),
  FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

CREATE TABLE cs202.UserDepRel
(
  dept_id INT NOT NULL,
  u_id INT NOT NULL,
  FOREIGN KEY (dept_id) REFERENCES Departments(dept_id),
  FOREIGN KEY (u_id) REFERENCES Users(u_id)
);

CREATE TABLE cs202.Appointments
(
  app_id INT NOT NULL auto_increment,
  datetime DATETIME NOT NULL,
  p_id INT NOT NULL,
  d_id INT NOT NULL,
  PRIMARY KEY (app_id),
  FOREIGN KEY (p_id) REFERENCES Users(u_id),
  FOREIGN KEY (d_id) REFERENCES Users(u_id)
);

CREATE TABLE cs202.RoomReservations
(
  res_id INT NOT NULL auto_increment,
  enter DATETIME NOT NULL,
  exit_ DATETIME NOT NULL,
  room_id INT NOT NULL,
  p_id INT NOT NULL,
  d_id INT NOT NULL,
  PRIMARY KEY (res_id),
  FOREIGN KEY (room_id) REFERENCES Rooms(room_id),
  FOREIGN KEY (p_id) REFERENCES Users(u_id),
  FOREIGN KEY (d_id) REFERENCES Users(u_id)
);

CREATE TABLE cs202.OffDays
(
  start DATETIME NOT NULL,
  end DATETIME NOT NULL,
  id INT NOT NULL auto_increment,
  d_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (d_id) REFERENCES Users(u_id)
);

insert into cs202.roles values('Patient',1);
insert into cs202.roles values('Doctor',2);
insert into cs202.roles values('Admin',3);
insert into cs202.roles values('Nurse',4);

insert into cs202.users values(1,'Emir Arditi','33X+VUiYs06eTZKROmV/AA==','emir.arditi@ozu.edu.tr',3);
insert into cs202.users values(2,'Cihan Eren','veKtX2iwifW5zoktXYb6Ug==','cihan.eren@ozu.edu.tr',3);
insert into cs202.users values(3,'admin','OAHoK1SqcoGmfRRTPBgY2w==','admin',3);

insert into cs202.users values(4,'Emre Karakuz','I1m6zLHvcryAtRsLr1wZug==','emrekarakuz@gmail.com',2);
insert into cs202.users values(5,'Dogukan Duduoglu','VWcUX22twzoH8tAzFy1DoA==','dogukan.duduoglu@ozu.edu.tr',2);
insert into cs202.users values(6,'Berkay Celik','TTdKHTddkYw1OdjloidyoQ==','berkay.celik@ozu.edu.tr',2);
insert into cs202.users values(7,'Ahmet Bilici','gNHtwNcowoI0fQRc2pE2Cw==','ahmet.cilici@ozu.edu.tr',2);
insert into cs202.users values(8,'Ali Aydin','oGsDOs3lQ0yHqMAoGO3MNA==','ali.aydin@ozu.edu.tr',2);
insert into cs202.users values(9,'Akif Tan','+fo/G5z3MeimQ0NvvVRZkQ==','akif.tan@ozu.edu.tr',2);
insert into cs202.users values(10,'Dilek Akan','HHvD7vRkKzPDobGB4aKqHw==','dilek.akan@ozu.edu.tr',2);
insert into cs202.users values(11,'Lale Tamer','H8HJ0gapI+H49dueyabR2w==','lale.tamer@ozu.edu.tr',2);
insert into cs202.users values(12,'Mehmet Sait','3o6dlnpvfrJrlAmfLqENag==','mehmet.sait@ozu.edu.tr',2);
insert into cs202.users values(13,'Meryem Can','5hwsC1M64N1wrdnofuoCWw==','meryem.can@ozu.edu.tr',2);
insert into cs202.users values(14,'Ozlem Balci','qEx12zTum5MTybtGfAcf5A==','ozlem.balci@ozu.edu.tr',2);
insert into cs202.users values(15,'Pelin Kara','IxhbyPvyrCQhRUcs+DH7GA==','pelin.kara@ozu.edu.tr',2);
insert into cs202.users values(16,'Asli Cakir','cygUlEf9er3bboFSLgW54w==','asli.cakir@ozu.edu.tr',2);
insert into cs202.users values(17,'Berna Turk','kU7h8C5LF2fnRxRy69G19g==','berna.turk@ozu.edu.tr',2);
insert into cs202.users values(18,'Berkan Kaplan','XmZwPCc4bhcN4MeR9sENMA==','berkan.kaplan@ozu.edu.tr',2);
insert into cs202.users values(19,'Cem Turan','wmaryEXBeIcLTy5DCBLj5A==','cem.turan@ozu.edu.tr',2);
insert into cs202.users values(20,'Deniz Arslan','SUj3QCoMejgEmtoUX5VtBw==','deniz.arslan@ozu.edu.tr',2);
insert into cs202.users values(21,'Ipek Ceylan','b901bi6bN9pV9Z89+3Jt7g==','ipek.ceylan@ozu.edu.tr',4);

insert into cs202.rooms(name) values('Room101');
insert into cs202.rooms(name) values('Room102');
insert into cs202.rooms(name) values('Room103');
insert into cs202.rooms(name) values('Room104');



insert into cs202.departments(name) values("Cardiology");
insert into cs202.departments(name) values("Ear Nose and Throat");
insert into cs202.departments(name) values("General surgery");
insert into cs202.departments(name) values("Neurology");
insert into cs202.departments(name) values("Nutrition and dietetics");
insert into cs202.departments(name) values("Oncology");

insert into cs202.UserDepRel values(1,21);
insert into cs202.UserDepRel values(1,4);
insert into cs202.UserDepRel values(1,7);
insert into cs202.UserDepRel values(1,10);
insert into cs202.UserDepRel values(2,19);
insert into cs202.UserDepRel values(2,6);
insert into cs202.UserDepRel values(2,9);
insert into cs202.UserDepRel values(3,20);
insert into cs202.UserDepRel values(3,5);
insert into cs202.UserDepRel values(3,8);
insert into cs202.UserDepRel values(4,11);
insert into cs202.UserDepRel values(4,14);
insert into cs202.UserDepRel values(4,17);
insert into cs202.UserDepRel values(5,12);
insert into cs202.UserDepRel values(5,15);
insert into cs202.UserDepRel values(5,18);
insert into cs202.UserDepRel values(6,13);
insert into cs202.UserDepRel values(6,16);



