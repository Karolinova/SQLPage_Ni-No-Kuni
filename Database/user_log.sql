-- Table user_log to store log session of users
create table user_log (id bigserial primary key
, user_id int
, token text);
