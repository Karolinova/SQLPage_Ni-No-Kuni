select 'dynamic' as component
, sqlpage.run_sql('shell_stw.sql') AS properties;

-- Add return button
 Select 'button' as component
,'sm' as size
;
select '../Strona_glowna.sql?gra='||$gra||'' as link,
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
, 'Wybór użytkownika' as title
, 'Wybierz' as validate
, 'przycisk' as class
, 'redirect_page.sql?gra='||$gra||'' as action;


with lista_uzytkownikow as (
    select 'select' as type
    , 'User' as name
    ,'' as label
    , jsonb_agg(json_build_object(
        'label', login,
        'value', login,
        'selected', login = $selected 
    ))::text as OPTIONS
    from users
)
select * from lista_uzytkownikow;