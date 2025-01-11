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
, 'Filtrowanie po stworzeniach' as title
, 'Filtruj' as validate
, 'stworzenia_filtrowanie.sql' as action;

select 'Rodzaj' as name
,  'input' as type
;
