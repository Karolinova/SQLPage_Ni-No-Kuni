-- table 'skladniki' (all ingredients used in games)
create table skladniki (id bigserial primary key
, nazwa varchar
, wyposazenie boolean
, prowiant boolean
, przysmak boolean
  );
