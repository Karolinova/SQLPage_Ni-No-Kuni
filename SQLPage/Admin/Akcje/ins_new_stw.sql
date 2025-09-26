with licznik_trikow as (
    select jsonb_array_length(:trik::jsonb) as i
)
, wstaw_dane as (
    insert into stworzenia (nazwa, trik1_id, trik2_id, trik3_id, gatunek_id, trik4_id, trik5_id, trik6_id, gra_id)
    select :name as nazwa
    , (:trik::jsonb ->> 0)::int as trik1_id
    , (:trik::jsonb ->> 1)::int as trik2_id
    , (:trik::jsonb ->> 2)::int as trik3_id
    , :gatunek::int as gatunek_id
    , (:trik::jsonb ->> 3)::int as trik4_id
    , (:trik::jsonb ->> 4)::int as trik5_id
    , (:trik::jsonb ->> 5)::int as trik6_id
    , $gra::BIGINT as gra_id
    from licznik_trikow
    where i < 7
)
select 'redirect' as component
    , case when (select i from licznik_trikow)> 6 
        then '/Admin/nowe_stworzenie_error.sql?gra='||$gra||'&name='||$name||'&gatunek='||$gatunek||''  
      when (select i from licznik_trikow) < 7
        then '/Admin/nowe_stworzenie_success.sql?gra='||$gra||'&name='||$name||'' end as link
      ;


