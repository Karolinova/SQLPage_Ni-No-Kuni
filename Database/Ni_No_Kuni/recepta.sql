-- table 'recepta' (all recipes for everything)
create table recepta (id bigserial primary key
, nazwa varchar
, skladnik1_id int
, constraint FK_skladnik1 foreign key(skladnik1_id) references skladniki (id)
, skladnik2_id int
, constraint FK_skladnik2 foreign key(skladnik2_id) references skladniki (id)
, skladnik3_id int
, constraint FK_skladnik3 foreign key(skladnik3_id) references skladniki (id)
  );
