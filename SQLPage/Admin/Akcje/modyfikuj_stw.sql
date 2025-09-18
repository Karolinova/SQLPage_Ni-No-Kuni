select 'dynamic' as component
, sqlpage.run_sql('shell_stw.sql') AS properties;

-- Add return button
 Select 'button' as component
    ,'sm' as size;
select 
    '/Admin/modyfikuj_usun_stworzenie.sql?gra='||$gra||'' as link,
    'Powrót'  as title;

-- Add header
select 'title' as component
, 'Modyfikuj dane stworzenia' as contents
, 3 as LEVEL
, true as center
;

-- Add form to add data
select 'form' as component
, 'Dane stworzenia' as title
, 'Modyfikuj' as validate
, 'update_new_stw.sql?&gra='||$gra||'&id='||$id||'' as action
;

-- Name of genus
select 'Nazwa' as label
, 'name' as name
, true as required
, nazwa as value
from stworzenia 
where id = $id::bigint
;

-- Genus
select 'select' as type
, 'gatunek' as name
, 'Gatunek' as label
, jsonb_agg(json_build_object(
    'label', nazwa,
    'value', g_id,
    'selected', nazwa = (select g.nazwa 
        from stworzenia s 
        join gatunek g on g.g_id = s.gatunek_id
        where s.id = $id::BIGINT)
)) as OPTIONS
from (select distinct g.nazwa, g_id
        from gatunek g order by g.nazwa ) g
;

with selected as (
  select
    array_remove(array[
      s.trik1_id, s.trik2_id, s.trik3_id,
      s.trik4_id, s.trik5_id, s.trik6_id
    ], NULL)::int[] as ids
  from stworzenia s
  where s.id = $id::bigint
)
-- Tricks
select 'select' as type
, 'trik[]' as name
, 'Trik' as label
, true as multiple
, jsonb_agg(json_build_object(
    'label', nazwa,
    'value', id,
    'selected', id = any(coalesce((select ids from selected limit 1), ARRAY[]::int[]))
)) as OPTIONS
from (select g.nazwa, g.id
        from triki_zaklecia g 
        where g.stworzenie_postac = 'S' order by g.nazwa ) g;