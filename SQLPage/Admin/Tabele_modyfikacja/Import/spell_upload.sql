-- insert data to table
copy triki_zaklecia(nazwa, stworzenie_postac, gra_id) from 'spell_data_upload'
DELIMITER ';'
CSV HEADER;
select
'redirect' as component,
    '/Admin/Tabele_modyfikacja/dane_zaklecia.sql?gra='||$gra||'' as link;

