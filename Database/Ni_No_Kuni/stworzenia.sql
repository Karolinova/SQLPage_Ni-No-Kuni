-- Table 'Stworzenia' (all familiars)
create table stworzenia (id bigserial primary key
, nazwa varchar
, gatunek varchar
, przysmak_id int
, trik1_id int
, trik2_id int
, trik3_id int
, constraint FK_triki_zaklecia1 foreign key(trik1_id) references triki_zaklecia (id)
, constraint FK_triki_zaklecia2 foreign key(trik2_id) references triki_zaklecia (id)
, constraint FK_triki_zaklecia3 foreign key(trik3_id) references triki_zaklecia (id)
);

-- add connection between two tables: stworzenia and recepta
alter table stworzenia 
add constraint FK_recepta foreign key(przysmak_id) references recepta (id);

-- change column 'gatunek'
alter table stworzenia
add column gatunek_id int references gatunek(id);

update stworzenia s
set gatunek_id = g.id
from gatunek g
where s.gatunek = g.nazwa;

alter table stworzenia drop column gatunek;

alter table stworzenia drop column przysmak_id;
