select 'dynamic' as component, sqlpage.run_sql('shell.sql') as properties;

-- at this momment it is not necessary
-- select 'text' as component
-- , 'Witamy ' || 
--     (select u.login 
--     from users u 
--     join user_log ul on ul.user_id=u.id
--     where ul.token=sqlpage.cookie('session_token')) 
--     as contents;

-- Add header on main page
select 'title' as component
, 'Ni No Kuni' as contents
, 1 as LEVEL
, true as center
;

-- Add image on main page
select 'html' as component
, '<br>
    <img src ="ni_no_kuni.jpg" width="600" style="max-width: 600px; height: auto;"/>
    <img src ="ni_no_kuni_II.jpg" width="600" style="max-width: 600px; height: auto;"/>
<br>' as html

-- Add menu
select 'datagrid' as component
;

select 'Stworzenia' as description
,'Stworzenia/stworzenia.sql' as link;
select 'Postacie' as description
, '/' as link
;
