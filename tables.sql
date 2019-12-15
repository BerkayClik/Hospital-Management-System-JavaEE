CREATE SCHEMA cs202;

CREATE TABLE cs202.Roles
(
  name VARCHAR(40) NOT NULL,
  role_id INT NOT NULL,
  PRIMARY KEY (role_id)
);

CREATE TABLE cs202.Departments
(
  dept_id INT NOT NULL,
  name INT NOT NULL,
  PRIMARY KEY (dept_id)
);

CREATE TABLE cs202.Rooms
(
  room_id INT NOT NULL,
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
  u_id INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  pw VARCHAR(50) NOT NULL,
  user_name VARCHAR(40) NOT NULL,
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
  app_id INT NOT NULL,
  datetime DATE NOT NULL,
  p_id INT NOT NULL,
  d_id INT NOT NULL,
  PRIMARY KEY (app_id),
  FOREIGN KEY (p_id) REFERENCES Users(u_id),
  FOREIGN KEY (d_id) REFERENCES Users(u_id)
);

CREATE TABLE cs202.RoomReservations
(
  res_id INT NOT NULL,
  enter DATE NOT NULL,
  exit_ DATE NOT NULL,
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
  start DATE NOT NULL,
  end DATE NOT NULL,
  id INT NOT NULL,
  d_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (d_id) REFERENCES Users(u_id)
);

insert into roles values('Patient',1);
insert into roles values('Doctor',2);
insert into roles values('Admin',3);
insert into roles values('Nurse',4);

insert into users values(1,'Doğukan','admin*123','dogukan',3);
insert into users values(2,'Emre','admin*123','emre',3);
insert into users values(3,'Berkay','admin*123','berkay',3);

insert into users values(4,'Emir','emir32','emir',2);
insert into users values(5,'Cihan','cihan32','cihan',2);
insert into users values(6,'Reyhan','reyhan32','reyhan',2);

insert into users values(7,'Alp','alp15','alp',4);
insert into users values(8,'Oğuz','oguz15','oguz',4);