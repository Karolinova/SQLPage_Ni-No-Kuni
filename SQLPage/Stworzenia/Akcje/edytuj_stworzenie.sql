select 'dynamic' as component
, sqlpage.run_sql('shell_stw.sql') AS properties;

-- Add return button
 Select 'button' as component
    ,'sm' as size;
select 
    '/Stworzenia/st_wybor_gry.sql?login='||$login||'&gra='||$gra||'&offset=0&page=10' as link,
    'Powrót'  as title;


with uprawnienia AS (
    select case when READ_ONLY is true then 'WIDOK'
        when read_only is false then 'EDYCJA' end as widok_edycja
        from users
        where id = (select user_id from user_log
                    where token=sqlpage.cookie('session_token'))
)
select 'html' as component
, case when u.widok_edycja = 'EDYCJA' then NULL
    when u.widok_edycja <> 'EDYCJA' then
        '<h5 style="color: green">Nie możesz edytować danych</h5>' end as html
from uprawnienia u;

-- Add form to edit data
select 'form' as component
, 'Zmień dane stworzenia' as title
, 'update_stw.sql?login='||$login||'&gra='||$gra||'&stw_id='||$id||'' as action
, 'Edytuj' as validate;

-- Name
select 'Imię' as label
, true as required
, imie as value
, 'imie' as name
from stworzenia_nnk
where id = $id::BIGINT;

-- Name of genus
select 'select' as type
, 'nazwa' as name
, 'Nazwa' as label
, 'pytanie' as class
, jsonb_agg(json_build_object(
    'label', nazwa,
    'value', nazwa,
    'selected', nazwa = (select nazwa 
        from stworzenia s 
        join stworzenia_nnk sn on sn.stw_id = s.id 
        where sn.id = $id::BIGINT)
)) as OPTIONS
from (select nazwa, id from stworzenia order by nazwa) s
;

-- Genus
select 'select' as type
, 'gatunek' as name
, 'Gatunek' as label
, 'pytanie' as class
, true as DISABLED
, jsonb_agg(json_build_object(
    'label', nazwa,
    'value', nazwa,
    'selected', nazwa = (select g.nazwa 
        from stworzenia s 
        join stworzenia_nnk sn on sn.stw_id = s.id 
        left join gatunek g on g.g_id = s.gatunek_id
        where sn.id = $id::BIGINT)
)) as OPTIONS
from (select distinct g.nazwa 
        from stworzenia s 
        join stworzenia_nnk sn on sn.stw_id = s.id 
        left join gatunek g on g.g_id = s.gatunek_id) s
;

-- Treat
select 'select' as type
, 'przysmak' as name
, 'Przysmak' as label
, 'pytanie' as class
, true as DISABLED
, jsonb_agg(json_build_object(
    'label', nazwa,
    'value', nazwa,
    'selected', nazwa = (select r.nazwa
        from stworzenia s 
        join stworzenia_nnk sn on sn.stw_id = s.id 
        join gatunek g on g.g_id = s.gatunek_id
        join recepta r on r.id = g.przysmak_id 
        where sn.id = $id::BIGINT)
)) as OPTIONS
from (select r.nazwa
    from gatunek g
    join recepta r on r.id = g.przysmak_id
    group by r.nazwa
    order by r.nazwa) s
;

-- Trick number 1 
select 'select' as type
, 'trik1' as name
, 'Trik 1' as label
, 'pytanie' as class
, true as DISABLED
,  '[{"label": "Wybierz trik", "value": "Wybierz trik"}]'::jsonb ||  jsonb_agg(json_build_object(
    'label', nazwa,
    'value', nazwa,
    'selected', nazwa = (select t.nazwa 
        from stworzenia s 
        join stworzenia_nnk sn on sn.stw_id = s.id 
        left join triki_zaklecia t on t.id = s.trik1_id
        where sn.id = $id::BIGINT)
)) as OPTIONS
, 2 as width
from (select nazwa, stworzenie_postac from triki_zaklecia ORDER BY nazwa) s
where stworzenie_postac = 'S'
;

-- Trick number 2
select 'select' as type
, 'trik2' as name
, 'Trik 2' as label
, 'pytanie' as class
, true as DISABLED
, '[{"label": "Wybierz trik", "value": "Wybierz trik"}]'::jsonb || jsonb_agg(json_build_object(
    'label', nazwa,
    'value', nazwa,
    'selected', nazwa = (select t.nazwa 
        from stworzenia s 
        join stworzenia_nnk sn on sn.stw_id = s.id 
        left join triki_zaklecia t on t.id = s.trik2_id
        where sn.id = $id::BIGINT)
)) as OPTIONS
, 2 as width
from (select nazwa, stworzenie_postac from triki_zaklecia ORDER BY nazwa) s
where stworzenie_postac = 'S'
;

-- Trick number 3
select 'select' as type
, 'trik3' as name
, 'Trik 3' as label
, 'pytanie' as class
, true as DISABLED
, '[{"label": "Wybierz trik", "value": "Wybierz trik"}]'::jsonb || jsonb_agg(json_build_object(
    'label', nazwa,
    'value', nazwa,
    'selected', nazwa = (select t.nazwa 
        from stworzenia s 
        join stworzenia_nnk sn on sn.stw_id = s.id 
        left join triki_zaklecia t on t.id = s.trik3_id
        where sn.id = $id::BIGINT)
)) as OPTIONS
, 2 as width
from (select nazwa, stworzenie_postac from triki_zaklecia ORDER BY nazwa) s
where stworzenie_postac = 'S'
;

-- Trick number 4
select 'select' as type
, 'trik4' as name
, 'Trik 4' as label
, 'pytanie' as class
, true as DISABLED
, '[{"label": "Wybierz trik", "value": "Wybierz trik"}]'::jsonb || jsonb_agg(json_build_object(
    'label', nazwa,
    'value', nazwa,
    'selected', nazwa = (select t.nazwa 
        from stworzenia s 
        join stworzenia_nnk sn on sn.stw_id = s.id 
        left join triki_zaklecia t on t.id = s.trik4_id
        where sn.id = $id::BIGINT)
)) as OPTIONS
, 2 as width
from (select nazwa, stworzenie_postac from triki_zaklecia ORDER BY nazwa) s
where stworzenie_postac = 'S'
;

-- Trick number 5
select 'select' as type
, 'trik5' as name
, 'Trik 5' as label
, 'pytanie' as class
, true as DISABLED
, '[{"label": "Wybierz trik", "value": "Wybierz trik"}]'::jsonb || jsonb_agg(json_build_object(
    'label', nazwa,
    'value', nazwa,
    'selected', nazwa = (select t.nazwa 
        from stworzenia s 
        join stworzenia_nnk sn on sn.stw_id = s.id 
        left join triki_zaklecia t on t.id = s.trik5_id
        where sn.id = $id::BIGINT)
)) as OPTIONS
, 2 as width
from (select nazwa, stworzenie_postac from triki_zaklecia ORDER BY nazwa) s
where stworzenie_postac = 'S'
;

-- Trick number 6
select 'select' as type
, 'trik6' as name
, 'Trik 6' as label
, 'pytanie' as class
, true as DISABLED
, '[{"label": "Wybierz trik", "value": "Wybierz trik"}]'::jsonb || jsonb_agg(json_build_object(
    'label', nazwa,
    'value', nazwa,
    'selected', nazwa = (select t.nazwa 
        from stworzenia s 
        join stworzenia_nnk sn on sn.stw_id = s.id 
        left join triki_zaklecia t on t.id = s.trik6_id
        where sn.id = $id::BIGINT)
)) as OPTIONS
, 2 as width
from (select nazwa, stworzenie_postac from triki_zaklecia ORDER BY nazwa) s
where stworzenie_postac = 'S'
;
