-- Genus - main division of familiars
create table gatunek(id bigserial primary key
, nazwa varchar
, przysmak_id int
, constraint FK_przysmak foreign key(przysmak_id) references recepta (id));
