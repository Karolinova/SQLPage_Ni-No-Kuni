select 'dynamic' as component
, sqlpage.run_sql('shell.sql') AS properties;

-- Add return button
 Select 'button' as component
    ,'sm' as size;
select 
    '/Stworzenia/st_wybor_gry.sql?id='||id||'' as link,
    'Powrót'  as title
    from help_list
    where nazwa='Gra'
    and id = $gra::BIGINT;


with uprawnienia AS (
    select case when READ_ONLY is true then 'WIDOK'
        when read_only is false then 'EDYCJA' end as widok_edycja
        from users
        where id = (select user_id from user_log
                    where token=sqlpage.cookie('session_token'))
)
select 'html' as component
, case when u.widok_edycja = 'EDYCJA' then NULL
    when u.widok_edycja <> 'EDYCJA' then
        '<h5 style="color: green">Nie możesz edytować danych</h5>' end as html
from uprawnienia u;

-- Add form to edit data
select 'form' as component
, 'Zmień dane stworzenia' as title;
select 'Imie' as label
, true as required
, imie as value
from stworzenia_nnk
where id = $id::BIGINT;

