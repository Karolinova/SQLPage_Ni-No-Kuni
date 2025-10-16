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

-- Add field with upload data
select 'form' as component
, 'Import danych za pomocą pliku CSV' as title
, 'Prześlij' as validate
, 'Import/spell_upload.sql?gra='||$gra||'' as action;
select 'spell_data_upload' as name
, 'file' as type
, 'text/csv' as accept
, 'Importuj zaklęcia' as label
, 'Podaj w pliku nazwę (kolumna nazwa) oraz określ, czy to jest stworzenie, czy postać (kolumna stworzenie_postać) oraz podaj id gry (kolumna gra_id).' as description
, true as required;

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
and stworzenie_postac = 'P'
order by nazwa;