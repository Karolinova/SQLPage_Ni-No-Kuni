select 'dynamic' as component
, sqlpage.run_sql('shell.sql') AS properties;

-- Add return button
 Select 'button' as component
,'sm' as size
;
select 'Strona_glowna.sql' as link,
'Powrót'  as title
;

-- Add title page
select 'title' as component
   , wartosc as contents
   , true as center
    from help_list
    where nazwa='Gra'
    and id = $gra::BIGINT;

-- Add image on main page
select 'html' as component
, true as center
, '<br><img src ="'||obrazek||'" width="600" style="max-width: 600px; height: auto; display:block; margin:auto;"/><br>' as html
from lista_gier
where id = $gra::bigint;