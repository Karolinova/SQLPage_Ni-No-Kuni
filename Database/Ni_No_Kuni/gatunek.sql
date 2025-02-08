-- Genus - main division of familiars
create table gatunek(id bigserial primary key
, nazwa varchar
, przysmak_id int
, constraint FK_przysmak foreign key(przysmak_id) references recepta (id));

-- Add extra column to connect with game (is is necessary to use in create URL adres on pages)
alter table gatunek 
add column g1_id int;
alter table gatunek
add constraint FK_gra1 foreign key(g1_id) references help_list (id);

alter table gatunek 
add column g2_id int;
alter table gatunek
add constraint FK_gra2 foreign key(g2_id) references help_list (id);

alter table gatunek 
add column g1_2_id int;
alter table gatunek
add constraint FK_gra1_2 foreign key(g1_2_id) references help_list (id);

-- Rename column
alter table gatunek 
rename column id to g_id;
