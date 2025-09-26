delete from stworzenia where id = $id::BIGINT and gra_id = $gra::bigint
returning
    'redirect' as component,
    '/Admin/modyfikuj_usun_stworzenie.sql?gra='||$gra||'' as link;
