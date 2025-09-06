select 'dynamic' as component
, sqlpage.run_sql('shell_stw.sql') AS properties;

-- Add return button
 Select 'button' as component
    ,'sm' as size;
select 
    'stworzenia_user.sql?gra='||$gra||'' as link,
    'Powrót'  as title;

-- Add title page
select 'title' as component
   , wartosc as contents
   , true as center
   from lista_gier
   where id = $gra::BIGINT;

-- Add filtration to table
select 'form' as component
, 'Szukaj stworzenia' as title
, 'Szukaj' as validate
, 'przycisk' as class
, 'Wyczyść' as reset
, 'szukaj_stworzenia.sql?login='||$login||'&gra='||$gra||'&offset=0&page=10' as action;

-- select name
with imie as (
    select 'select' as TYPE
    , 'imie' as NAME
    , 'Imię' as LABEL
    , 'pytanie' as class
    ,  '[{"label": "Wybierz imię", "value": "Wybierz imię"}]'::jsonb || jsonb_agg(json_build_object(
    'label', s.imie,
    'value', s.imie )) as options
    , 2 as width
    from (
        select s.gra_id, sn.imie from stworzenia_nnk sn 
        join stworzenia s on s.id = sn.id
        order by imie) s
    join lista_gier hl on hl.id=s.gra_id
    -- list of names depends on the game
    where case when $gra::bigint = 1 then s.gra_id = 1
        when $gra::bigint = 2 then s.gra_id = 2
        when $gra::bigint = 3 then s.gra_id in (1,2)
        end
)
-- select genus
, lista_gatunkow as (
    select 'select' as type
    ,'gatunek' as name
    ,'Gatunek' as label
    ,'pytanie' as class
    , '[{"label": "Wybierz gatunek", "value": "Wybierz gatunek"}]'::jsonb || jsonb_agg(json_build_object(
        'label', nazwa,
        'value', nazwa )) as OPTIONS
    , 2 as width
    from (
        select DISTINCT nazwa from gatunek ORDER BY nazwa
    ) gatunek
)
-- select name of genus
, nazwa as (
    select 'select' as type
    , 'nazwa' as name
    , 'Nazwa' as label
    , 'pytanie' as class
    , '[{"label": "Wybierz nazwę", "value": "Wybierz nazwę"}]'::jsonb || jsonb_agg(json_build_object(
        'label', nazwa,
        'value', nazwa )) as OPTIONS
    , 2 as width
    from (
        select nazwa from stworzenia order by nazwa
        ) nazwa
)
-- select treat
, przysmak AS (
        select 'select' as type
    , 'przysmak' as name
    , 'Przysmak' as label
    , 'pytanie' as class
    , '[{"label": "Wybierz przysmak", "value": "Wybierz przysmak"}]'::jsonb || jsonb_agg(json_build_object(
        'label', x.nazwa,
        'value', x.nazwa
    )) as OPTIONS
    , 2 as width
    from
    (select r.nazwa
    from gatunek g
    join recepta r on r.id = g.przysmak_id
    group by r.nazwa
    order by r.nazwa) x
)
-- select tricks
, triki AS (
        select 'select' as type
    , 'triki' as name
    , 'Triki' as label
    , 'pytanie' as class
    , '[{"label": "Wybierz trik", "value": "Wybierz trik"}]'::jsonb || jsonb_agg(json_build_object(
        'label', nazwa,
        'value', nazwa
    )) as OPTIONS
    , 2 as width
    from (
        select nazwa, stworzenie_postac from triki_zaklecia ORDER BY nazwa
        ) triki_zaklecia
    where stworzenie_postac = 'S'
)
-- select gold
, zloty AS (
        select 'select' as type
    , 'gold' as name
    , 'Złoty' as label
    , 'pytanie' as class
    , '[{"label": "Wybierz", "value": "Wybierz"}]'::jsonb || jsonb_agg(json_build_object(
        'label', case when gold = true then 'TAK' else 'NIE' end,
        'value', gold
    )) as OPTIONS
    , 2 as width
    from (
        select distinct gold from stworzenia
        ) zloty
)
select * from imie
union all
select * from nazwa
union all
select * from lista_gatunkow
union all
select * from przysmak
union all
select * from triki
union all
select * from zloty
;

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
, 'Akcje/dodaj_stworzenie.sql?login='||$login||'&gra='||$gra||'' as link
, 'cyan' as color
from uprawnienia
where widok_edycja = 'EDYCJA';

-- Add filter result of the selected game
select 'table' as component
, 'Akcje'  as markdown
, 'Złoty' as icon;

select imie, nazwa, gatunek, nazwa_rec as "Przysmak", "Trik 1", "Trik 2", "Trik 3", "Trik 4", "Trik 5", "Trik 6"
    , case when gold = true then 'check' else null end as "Złoty"
    , '[Usuń](Akcje/usun_stworzenie.sql?login='||$login||'&gra='||$gra||'&id='||stw_id||') 
    [Edytuj](Akcje/edytuj_stworzenie.sql?login='||$login||'&gra='||$gra||'&id='||stw_id||')' as akcje
      from (
         select s.gra_id as gra
         , stw.id as stw_id, stw.imie, s.nazwa, g.nazwa as gatunek, r.nazwa as nazwa_rec
         , t1.nazwa as "Trik 1", t2.nazwa as "Trik 2", t3.nazwa as "Trik 3"
         , t4.nazwa as "Trik 4", t5.nazwa as "Trik 5", t6.nazwa as "Trik 6"
         , s.gold, s.id, stw.user_id
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
where case when $gra::bigint = 1 then gra = 1 
    when $gra::bigint = 2 then gra = 2
    when $gra::bigint = 3 then gra in (1,2) end
    and user_id = (select id from users where login = $login)
    and id >= COALESCE($start_id::integer,0)
    order by dane.id
    limit COALESCE($page::integer,0) 
    offset COALESCE($offset::integer,0);

-- Pagination
select 'button' as component
, true as center;

select '|<' as title
, '?login='||$login||'&gra='||$gra||'&offset=0&page='||COALESCE($page::integer,10) as link
, $offset::integer <= 0 as disabled;

select '<<' as title
, '?login='||$login||'&gra='||$gra||'&offset='||(COALESCE($offset::integer,0) - COALESCE($page::integer,5))||'&page='||COALESCE($page::integer,5) as LINK
, $offset::integer <= 0 as disabled;

select '>>' as title
, '?login='||$login||'&gra='||$gra||'&offset='||(COALESCE($offset::integer,0)+COALESCE($page::integer,5))||'&page='||COALESCE($page::integer,5) as link;