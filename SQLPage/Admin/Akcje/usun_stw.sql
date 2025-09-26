select 'dynamic' as component
, sqlpage.run_sql('shell_stw.sql') AS properties;

-- Form to delete familiar
select 'form' as component
       , 'Czy chcesz usunąć całkowicie stworzenie '||nazwa||'?' as title
       , '' as VALIDATE
       from stworzenia
       where gra_id = $gra::BIGINT
       and id = $id::bigint       
       ;

select 
    'button' as component
    , 'center' as justify;
select 'TAK' as title
    , 'success' as color
    , 'delete_stw.sql?gra='||$gra||'&id='||$id||'' as link
    , 'Całkowite usunięcie danych z bazy' as tooltip;
select 'NIE' as title
    , 'danger' as color
    , '/Admin/modyfikuj_usun_stworzenie.sql?gra='||$gra||'' as link
    , 'Rezygnacja z usunięcia danych' as tooltip;