select 'dynamic' as component
, sqlpage.run_sql('shell_stw.sql') AS properties;

-- Add return button
 Select 'button' as component
    ,'sm' as size;
select 
    '/Admin/nowe_dane.sql?gra='||$gra||'' as link,
    'Powrót'  as title;

-- Add header on page
select 
    'title'   as component
    , 'Zaklęcia' as contents
    , true as center;

-- Add list to page
select 'list' as component
, TRUE as search
, true as compact
, '4' as width
;

select nazwa as title
, 'Akcje/modyfikuj_zaklecie.sql?gra='||$gra||'&id='||id||'' as edit_link 
, 'Akcje/usun_zaklecie.sql?gra='||$gra||'&id='||id||'' as delete_link
from triki_zaklecia
where gra_id = $gra::int
and stworzenie_postac = 'S'
order by nazwa;