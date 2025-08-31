select 'dynamic' as component
, sqlpage.run_sql('shell_stw.sql') AS properties;

-- Add return button
 Select 'button' as component
    ,'sm' as size;
select 
    '/strona_glowna_gry.sql?gra='||$gra||'' as link,
    'Powrót'  as title;

-- Add header
select 'title' as component
, 'Dodaj dane nowego stworzenia' as contents
, 3 as LEVEL
, true as center
;

-- Error - kouminikat
select 'alert' as component
, 'Błąd!' as title
, 'Zostało wybranych więcej trików - maksymalna liczba to 6.' as description
, 'red' as color;

-- Add form to add data
select 'form' as component
, 'Dane stworzenia' as title
, 'Dodaj' as validate
, 'Akcje/ins_new_stw.sql?&gra='||$gra||'' as action
;

-- Name of genus
select 'Nazwa' as label
, 'name' as name
, true as required
;

-- Genus
select 'select' as type
, 'gatunek' as name
, 'Gatunek' as label
, jsonb_agg(json_build_object(
    'label', nazwa,
    'value', g_id
)) as OPTIONS
from (select distinct g.nazwa, g_id
        from gatunek g order by g.nazwa ) g
;

-- Tricks
select 'select' as type
, 'trik[]' as name
, 'Trik' as label
, true as multiple
-- , 6 as max_options
, jsonb_agg(json_build_object(
    'label', nazwa,
    'value', id
)) as OPTIONS
from (select g.nazwa, g.id
        from triki_zaklecia g 
        where g.stworzenie_postac = 'S' order by g.nazwa ) g;
