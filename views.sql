create view patient as select u_id,name,pw,user_name from users;
create view doctor as select u_id,name,pw,user_name from users;
create view admin as select u_id,name,pw,user_name,role_id from users;