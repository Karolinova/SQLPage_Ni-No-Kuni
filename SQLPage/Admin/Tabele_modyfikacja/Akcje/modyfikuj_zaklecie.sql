select 'dynamic' as component
, sqlpage.run_sql('shell_stw.sql') AS properties;

-- Add return button
 Select 'button' as component
    ,'sm' as size;
select 
    '/Admin/Tabele_modyfikacja/dane_zaklecia.sql?gra='||$gra||'' as link,
    'Powrót'  as title;

-- Add modification form
select 'form' as component
, 'Zmień dane zaklęcia' as title
, 'update_spell.sql?gra='||$gra||'&id='||id||'' as action
, 'Edytuj' as validate
from triki_zaklecia
where id = $id::BIGINT;

-- Name of spell/trick
select 'Nazwa' as label
, true as required
, nazwa as value
, 'nazwa' as name
from triki_zaklecia
where id = $id::BIGINT;

