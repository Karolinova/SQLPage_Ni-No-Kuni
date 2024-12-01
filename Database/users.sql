-- Table users to store data of users
create table users (login varchar(20)
  , password varchar(20)
  , read_only bit
  , password_hash varchar(100)
  );
