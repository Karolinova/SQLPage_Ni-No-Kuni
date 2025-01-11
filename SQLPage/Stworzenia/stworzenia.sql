select 'dynamic' as component
, sqlpage.run_sql('shell.sql') AS properties;

-- Add return button
 Select 'button' as component
,'sm' as size
;
select '../Strona_glowna.sql' as link,
'Powrót'  as title
;


-- Add header
select 'title' as component
, 'Stworzenia' as contents
, 3 as LEVEL
, true as center
;

-- Add filtration
select 'form' as component
, 'Wybór gry' as title
, 'Wybierz' as validate
, 'st_wybor_gry.sql.sql' as action;

with lista_gier as (
    select 'select' as type
    -- , 'Kolumna' as name
    , jsonb_agg(json_build_object(
        'label', wartosc,
        'value', wartosc,
        'selected', nazwa in (select value from jsonb_array_elements_text($selected_id::jsonb))
    ))::text as OPTIONS
    -- , 4 as width
    from help_list where nazwa='Gra'
)
select * from lista_gier;
