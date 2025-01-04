select 'dynamic' as component
, sqlpage.run_sql('shell.sql') AS properties;

-- Add filtration
select 'form' as component
, 'Filtrowanie po stworzeniach' as title
, 'Filtruj' as validate
, 'stworzenia_filtrowanie.sql' as action;

select 'Rodzaj' as name
,  'input' as type
;
