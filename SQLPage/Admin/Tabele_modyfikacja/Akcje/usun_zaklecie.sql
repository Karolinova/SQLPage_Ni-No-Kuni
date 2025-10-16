select 'dynamic' as component
, sqlpage.run_sql('shell_stw.sql') AS properties;

-- Form to delete spell
select 'form' as component
       , 'Czy chcesz usunąć całkowicie zaklęcie '||nazwa||'?' as title
       , '' as VALIDATE
       from triki_zaklecia
       where gra_id = $gra::BIGINT
       and id = $id::bigint       
       ;

select 
    'button' as component
    , 'center' as justify;
select 'TAK' as title
    , 'success' as color
    , 'delete_spell.sql?gra='||$gra||'&id='||$id||'' as link
    , 'Całkowite usunięcie danych z bazy' as tooltip;
select 'NIE' as title
    , 'danger' as color
    , '/Admin/Tabele_modyfikacja/dane_zaklecia.sql?gra='||$gra||'' as link
    , 'Rezygnacja z usunięcia danych' as tooltip;