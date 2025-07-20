select 'dynamic' as component
, sqlpage.run_sql('shell.sql') AS properties;

-- Add return button
 Select 'button' as component
    ,'sm' as size;
select 
    '/Stworzenia/st_wybor_gry.sql?login='||$login||'&gra='||gra||'&offset=0&page=10' as link,
    'Powrót'  as title;

-- Add form to add data
select 'form' as component
, 'Dodaj nowe stworzenie' as title
, 'Dodaj' as validate
, 'ins_stw.sql?login='||$login||'&gra='||$gra||'' as action 
, 'cyan' as validate_color
;

-- Name
select 'Imię' as label
, 'imie' as name
, true as required
;

-- Name of genus
select 'select' as type
, 'nazwa' as name
, 'Nazwa' as label
, true as required
, 'pytanie' as class
, '[{"label": "Wybierz nazwę", "value": "Wybierz nazwę"}]'::jsonb || jsonb_agg(json_build_object(
        'label', nazwa,
        'value', nazwa
    )) as OPTIONS
    from (
        select nazwa from stworzenia order by nazwa
        ) nazwa
;
