select 'dynamic' as component
, sqlpage.run_sql('shell.sql') AS properties;

-- Add return button
 Select 'button' as component
    ,'sm' as size
   ;
select 
    'st_wybor_gry.sql?id='||id||'' as link,
    'Powrót'  as title
    from help_list
    where nazwa='Gra'
    and id = $id::BIGINT;

-- Add title to page
select 'title' as component
, wartosc as contents
, true as center
from help_list 
where id = $id::BIGINT
and nazwa = 'Gra'; 

-- Add second filtration
select 'form' as component
, 'Szukaj stworzenia' as title
, 'Szukaj' as validate
, 'przycisk' as class
, 'szukaj_stworzenia.sql?id='||id||'' as action
from help_list hl
where hl.nazwa='Gra'
and id = $id::BIGINT
;

-- Name is selected
with imie as (
    select 'select' as TYPE
    , 'imie' as NAME
    , 'Imię' as LABEL
    , 'pytanie' as class
    ,  '[{"label": "Wybierz imię", "value": "Wybierz imię"}]'::jsonb || jsonb_agg(json_build_object(
        'label', s.imie,
        'value', s.imie,
        'selected', imie = :imie )) as options
    , 2 as width
    from (
        select gra_id, imie from stworzenia_nnk order by imie) s
    where case when $id::BIGINT = 1 then s.gra_id = 1
        when $id::BIGINT = 2 then s.gra_id = 2
        when $id::BIGINT = 3 then s.gra_id in (1,2)
        end
)
-- Name of genus is selected
, nazwa as (
    select 'select' as type
    , 'nazwa' as name
    , 'Nazwa' as label
    , 'pytanie' as class
    , '[{"label": "Wybierz nazwę", "value": "Wybierz nazwę"}]'::jsonb || jsonb_agg(json_build_object(
        'label', nazwa,
        'value', nazwa,
        'selected', nazwa = :nazwa
    )) as OPTIONS
    , 2 as width
        from (
        select nazwa from stworzenia order by nazwa
        ) nazwa
)
-- Genus is selected
, lista_gatunkow as (
    select 'select' as type
    ,'gatunek' as name
    ,'Gatunek' as label
    ,'pytanie' as class
    , '[{"label": "Wybierz gatunek", "value": "Wybierz gatunek"}]'::jsonb || jsonb_agg(json_build_object(
        'label', nazwa,
        'value', nazwa,
        'selected', nazwa = :gatunek
    )) as OPTIONS
    , 2 as width
       from (
        select DISTINCT nazwa from gatunek ORDER BY nazwa
    ) gatunek
)
-- Treat is selected
, przysmak AS (
    select 'select' as type
    , 'przysmak' as name
    , 'Przysmak' as label
    , 'pytanie' as class
    , '[{"label": "Wybierz przysmak", "value": "Wybierz przysmak"}]'::jsonb || jsonb_agg(json_build_object(
        'label', nazwa,
        'value', nazwa,
        'selected', nazwa = :przysmak
    )) as OPTIONS
    , 2 as width
    from 
    (select r.nazwa
    from gatunek g
    join recepta r on r.id = g.przysmak_id
    group by r.nazwa
    order by r.nazwa) x
)
-- Trick is selected
, triki AS (
    select 'select' as type
    , 'triki' as name
    , 'Triki' as label
    , 'pytanie' as class
    , '[{"label": "Wybierz trik", "value": "Wybierz trik"}]'::jsonb ||  jsonb_agg(json_build_object(
        'label', nazwa,
        'value', nazwa,
        'selected', nazwa = :triki
    )) as OPTIONS
    , 2 as width
    from (
        select nazwa, stworzenie_postac from triki_zaklecia ORDER BY nazwa
        ) triki_zaklecia
    where stworzenie_postac = 'S'
)
select * from imie
union all
select * from nazwa
union all
select * from lista_gatunkow
union all
select * from przysmak
union all
select * from triki;

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
        '<h5 style="color: green">Nie możesz usuwać ani edytować danych</h5>' end as html
from uprawnienia u;

-- Add button to 'add familiar'
select 'button' as component
, 'start' as justify;

with uprawnienia AS (
    select case when READ_ONLY is true then 'WIDOK'
        when read_only is false then 'EDYCJA' end as widok_edycja
        from users
        where id = (select user_id from user_log
                    where token=sqlpage.cookie('session_token'))
)
select 'Dodaj nowe stworzenie' as title
, 'Dodaj' as validate
, 'Akcje/dodaj_stworzenie.sql?gra='||$id||'' as link
, 'cyan' as color
from uprawnienia
where widok_edycja = 'EDYCJA';

-- Add filter result
select 'table' as component
, 'Akcje'  as markdown;

select imie, nazwa, gatunek, nazwa_rec as "Przysmak", "Trik 1", "Trik 2", "Trik 3", "Trik 4", "Trik 5", "Trik 6"
    ,  '[Usuń](Akcje/usun_stworzenie.sql?gra='||$id||'&id='||stw_id||') 
    [Edytuj](Akcje/edytuj_stworzenie.sql?gra='||$id||'&id='||stw_id||')' as akcje
      from (
         select stw.gra_id as gra --Ni no Kuni: Wrath of the White Witch
         , stw.id as stw_id, stw.imie, s.nazwa, g.nazwa as gatunek, r.nazwa as nazwa_rec 
         , t1.nazwa as "Trik 1", t2.nazwa as "Trik 2", t3.nazwa as "Trik 3"
         , t4.nazwa as "Trik 4", t5.nazwa as "Trik 5", t6.nazwa as "Trik 6"
         from stworzenia s 
         join stworzenia_nnk stw on stw.stw_id = s.id
         join triki_zaklecia t1 on t1.id = s.trik1_id
         join triki_zaklecia t2 on t2.id = s.trik2_id
         left join triki_zaklecia t3 on t3.id = s.trik3_id
         left join triki_zaklecia t4 on t4.id = s.trik4_id
         left join triki_zaklecia t5 on t5.id = s.trik5_id
         left join triki_zaklecia t6 on t6.id = s.trik6_id
         join gatunek g on g.g_id = s.gatunek_id 
         join recepta r on r.id = g.przysmak_id 
      ) as dane
where case when $id::bigint = 1 then gra = 1 
    when $id::bigint = 2 then gra = 2
    when $id::bigint = 3 then gra in (1,2) end
and case when :imie <>'Wybierz imię' then imie = :imie
    else imie <>'Wybierz imię'
    end
and case when :nazwa <>'Wybierz nazwę' then nazwa = :nazwa
    else nazwa <>'Wybierz nazwę'
    end
and case when :gatunek <>'Wybierz gatunek' then gatunek = :gatunek
    else gatunek <>'Wybierz gatunek'
    end
and case when :przysmak <>'Wybierz przysmak' then nazwa_rec = :przysmak
    else nazwa_rec <>'Wybierz przysmak'
    end
and case when :triki<>'Wybierz trik' then "Trik 1"=:triki or "Trik 2"=:triki or "Trik 3"=:triki or "Trik 4"=:triki or "Trik 5"=:triki or "Trik 6"=:triki
    else "Trik 1"<>'Wybierz trik' or "Trik 2"<>'Wybierz trik' or "Trik 3"<>'Wybierz trik' or "Trik 3"<>'Wybierz trik' or "Trik 4"<>'Wybierz trik' or "Trik 5"<>'Wybierz trik' or "Trik 6"<>'Wybierz trik'
    end
 ;
