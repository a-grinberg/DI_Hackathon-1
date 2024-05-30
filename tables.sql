CREATE TABLE roles (
  id serial PRIMARY KEY,
  role_name varchar(50) NOT NULL
);

CREATE TABLE status (
  id serial PRIMARY KEY,
  status_name varchar(50) NOT NULL
);

CREATE TABLE users (
  id serial PRIMARY KEY,
  name varchar(50) NOT NULL,
  last_name varchar(50) NOT NULL,
	phone varchar (20),
	address varchar (255),
	email varchar (320) unique not null,
	role_id int NOT NULL,
	password varchar (255) not null,
	user_name varchar (255) unique not null,
	FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE deals (
  id serial PRIMARY KEY,
  deal_dscription text,
  client_id int,
  manager_id int not null,
  status_id int default 1 not null,
  create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (client_id) REFERENCES users(id) on delete SET NULL,
	FOREIGN KEY (manager_id) REFERENCES users(id) on delete SET NULL,
	FOREIGN KEY (status_id) REFERENCES status(id)
);

CREATE TABLE comments (
  id serial PRIMARY KEY,
  deal_id int not null,
  user_id int not null,
  comment text not null,
	create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (deal_id) REFERENCES deals(id) on delete cascade,
	FOREIGN KEY (user_id) REFERENCES users(id) on delete cascade
);


insert into roles (role_name) values ('manager'),('client')

insert into status (status_name) values ('new'),('process'),('complete'),('canceled'),('on hold'), ('waiting for payment')

select * from deals


	
drop TABLE comments
drop TABLE deals 
drop TABLE users
drop TABLE roles
drop TABLE status

SELECT d.id, to_char(create_date, 'YYYY-MM-DD HH24:MI:SS') AS date_string,
  (u_client.name || ' ' || u_client.last_name) AS client_full_name,
  u_client.phone AS client_phone,
  u_client.address AS client_address,
  u_client.email AS client_email,
  CONCAT(u_manager.name, ' ', u_manager.last_name) AS manager_name,
  s.status_name
FROM deals d
INNER JOIN users u_client ON d.client_id = u_client.id 
INNER JOIN users u_manager ON d.manager_id = u_manager.id   
INNER JOIN status s ON d.status_id = s.id  
WHERE d.id = 5;

-- -- another option
-- SELECT d.id,
--   (u_client.name || ' ' || u_client.last_name) AS client_full_name,
--   u_client.phone AS client_phone,
--   u_client.address AS client_address,
--   u_client.email AS client_email,
--   CONCAT(u_manager.name, ' ', u_manager.last_name) AS manager_name,
--   (SELECT array_to_string(array_agg(c.comment), '/// ') FROM comments c WHERE c.deal_id = d.id) AS all_comments,
--   s.status_name
-- FROM deals d
-- INNER JOIN users u_client ON d.client_id = u_client.id  
-- INNER JOIN users u_manager ON d.manager_id = u_manager.id  
-- LEFT JOIN comments c ON c.deal_id = d.id  
-- INNER JOIN status s ON d.status_id = s.id 
-- WHERE d.id = 5 limit 1;