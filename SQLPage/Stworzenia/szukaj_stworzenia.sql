select 'dynamic' as component
, sqlpage.run_sql('shell.sql') AS properties;

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
, 'szukaj_stworzenia.sql?id=g.g1_id&g_id='||id||'' as action
from help_list hl
join gatunek g on g.g1_id = hl.id
where hl.nazwa='Gra'
and g.nazwa=:gatunek;

-- Genus is selected
with lista_gatunkow as (
    select 'select' as type
    ,'gatunek' as name
    ,'Wybierz z listy gatunek' as label
    ,'pytanie' as class
    , true as disabled
    , jsonb_agg(json_build_object(
        'label', nazwa,
        'value', nazwa,
        'selected', nazwa = $selected  --nazwa in (select value from jsonb_array_elements_text($selected_ids::jsonb))
        -- nazwa = 'Ni no Kuni: Wrath of the White Witch'
    ))::text as OPTIONS
    -- , 4 as width
    from gatunek
    where nazwa =:gatunek
)
select * from lista_gatunkow;

-- Add filter result
select 'table' as component;

select imie, gatunek, nazwa, nazwa_rec as "Przysmak", "Trik 1", "Trik 2", "Trik 3"
      from (
         select '1' as gra --Ni no Kuni: Wrath of the White Witch
         , s1.imie, s.nazwa, g.nazwa as gatunek, r.nazwa as nazwa_rec 
         , t1.nazwa as "Trik 1", t2.nazwa as "Trik 2", t3.nazwa as "Trik 3"
         from stworzenia s 
         join stworzenia_nnk1 s1 on s1.stw_id = s.id
         join triki_zaklecia t1 on t1.id = trik1_id
         join triki_zaklecia t2 on t2.id = trik2_id
         join triki_zaklecia t3 on t3.id = trik3_id
         join gatunek g on g.g_id = s.gatunek_id 
         join recepta r on r.id = g.przysmak_id 
         union all
         select 'Ni no Kuni II: Revenant Kingdom' as gra
         , s2.imie, s.nazwa, g.nazwa as gatunek, r.nazwa as nazwa_rec 
         , t1.nazwa as "Trik 1", t2.nazwa as "Trik 2", t3.nazwa as "Trik 3"
         from stworzenia s 
         join stworzenia_nnk2 s2 on s2.stw_id = s.id
         join triki_zaklecia t1 on t1.id = trik1_id
         join triki_zaklecia t2 on t2.id = trik2_id
         join triki_zaklecia t3 on t3.id = trik3_id
         join gatunek g on g.g_id = s.gatunek_id 
         join recepta r on r.id = g.przysmak_id 
         union all
         select '2' as gra -- Ni No Kuni I/Ni no Kuni II
         , nnk1_nnk2.imie, nnk1_nnk2.nazwa, nnk1_nnk2.gatunek, nnk1_nnk2.nazwa_rec
         , nnk1_nnk2."Trik 1", nnk1_nnk2."Trik 2", nnk1_nnk2."Trik 3"
         from
         (select '3' as gra -- Ni no Kuni: Wrath of the White Witch
         , s1.imie, s.nazwa, g.nazwa as gatunek, r.nazwa as nazwa_rec 
         , t1.nazwa as "Trik 1", t2.nazwa as "Trik 2", t3.nazwa as "Trik 3"
         from stworzenia s 
         join stworzenia_nnk1 s1 on s1.stw_id = s.id
         join triki_zaklecia t1 on t1.id = trik1_id
         join triki_zaklecia t2 on t2.id = trik2_id
         join triki_zaklecia t3 on t3.id = trik3_id
         join gatunek g on g.g_id = s.gatunek_id 
         join recepta r on r.id = g.przysmak_id 
         union all
         select 'Ni no Kuni II: Revenant Kingdom' as gra
         , s2.imie, s.nazwa, g.nazwa, r.nazwa as nazwa_rec 
         , t1.nazwa as "Trik 1", t2.nazwa as "Trik 2", t3.nazwa as "Trik 3"
         from stworzenia s 
         join stworzenia_nnk2 s2 on s2.stw_id = s.id
         join triki_zaklecia t1 on t1.id = trik1_id
         join triki_zaklecia t2 on t2.id = trik2_id
         join triki_zaklecia t3 on t3.id = trik3_id
         join gatunek g on g.g_id = s.gatunek_id 
         join recepta r on r.id = g.przysmak_id 
         ) nnk1_nnk2
      ) as dane
where gra = $id
and gatunek = :gatunek;
