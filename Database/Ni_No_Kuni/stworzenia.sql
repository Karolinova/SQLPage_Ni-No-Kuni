-- Table 'Stworzenia' (all familiars)
create table stworzenia (id bigserial primary key
, nazwa varchar
, trik1_id int
, trik2_id int
, trik3_id int
, constraint FK_triki_zaklecia1 foreign key(trik1_id) references triki_zaklecia (id)
, constraint FK_triki_zaklecia2 foreign key(trik2_id) references triki_zaklecia (id)
, constraint FK_triki_zaklecia3 foreign key(trik3_id) references triki_zaklecia (id)
, gatunek_id int
, constraint FK_gatunek foreign key(gatunek_id) references gatunek (g_id)
);

