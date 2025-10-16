delete from triki_zaklecia 
where id = $id::BIGINT and gra_id = $gra::bigint
RETURNING
'redirect' as component,
    '/Admin/Tabele_modyfikacja/dane_zaklecia.sql?gra='||$gra||'' as link;