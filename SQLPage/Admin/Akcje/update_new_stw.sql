with licznik_trikow as (
    select jsonb_array_length(:trik::jsonb) as i
)
, aktualizuj_dane as (
    update stworzenia
    set nazwa = $name
    , gatunek_id = $gatunek::BIGINT
    , trik1_id = (:trik::jsonb ->> 0)::int 
    , trik2_id = (:trik::jsonb ->> 1)::int 
    , trik3_id = (:trik::jsonb ->> 2)::int 
    , trik4_id = (:trik::jsonb ->> 3)::int 
    , trik5_id = (:trik::jsonb ->> 4)::int 
    , trik6_id = (:trik::jsonb ->> 5)::int 
    from licznik_trikow
    where i < 7
    and id = $id::bigint
)
select 'redirect' as component
    , case when (select i from licznik_trikow)> 6 
        then '/Admin/modyfikuj_usun_stworzenie_error.sql?gra='||$gra||''
      when (select i from licznik_trikow) < 7
        then 
       '/Admin/modyfikuj_usun_stworzenie_success.sql?gra='||$gra||'&name='||$name||'' end as link
      ;


