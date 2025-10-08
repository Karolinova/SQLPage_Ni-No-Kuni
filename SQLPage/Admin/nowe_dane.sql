select 'dynamic' as component
, sqlpage.run_sql('shell_stw.sql') AS properties;

-- Add return button
 Select 'button' as component
    ,'sm' as size;
select 
    '/strona_glowna_gry.sql?gra='||$gra||'' as link,
    'Powrót'  as title;

select 
    'title'   as component
    , 'Tabele do modyfikacji' as contents
    , true as center;

select 'card' as component;
select 'Triki' as title
, 'green' as color
, 'green-lt' as background_color
, 4 as width
, 'Lista trików stworzeń' as description
, 'Tabele_modyfikacja/dane_triki.sql?gra='||$gra||'' as link
;
select 'Zaklęcia' as title
, 'red' as color
, 'red-lt' as background_color
, 4 as width
, 'Lista zaklęć postaci' as description
, 'Tabele_modyfikacja/dane_zaklecia.sql?gra='||$gra||'' as link
;