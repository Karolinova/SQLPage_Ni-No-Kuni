-- table 'triki_zaklecia' (tricks and spells of familiars and characters)
create table triki_zaklecia (id bigserial primary key
, nazwa varchar
, stworzenie_postac boolean
);

-- modyfiy column type - possible values S (stworzenia - familiars) or P (postacie - characters)
ALTER TABLE triki_zaklecia ALTER COLUMN stworzenie_postac type varchar(10);
