-- table 'triki_zaklecia' (tricks and spells of familiars and characters)
create table triki_zaklecia (id bigserial primary key
, nazwa varchar
, stworzenie_postac varchar(10)
, gra_id int
, constraint FK_gra foreign key(gra_id) references lista_gier (id)
);

