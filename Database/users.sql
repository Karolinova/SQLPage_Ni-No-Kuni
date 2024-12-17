-- Table users to store data of users
create table users (id bigint primary key
  , login varchar(20)
  , password varchar(20)
  , read_only boolean
  , password_hash varchar(100)
  );
