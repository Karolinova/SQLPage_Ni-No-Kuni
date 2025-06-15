delete from stworzenia_nnk where id = $stw_id::BIGINT and gra_id = $gra::bigint
returning
    'redirect' as component,
    '/Stworzenia/st_wybor_gry.sql?id='||$gra||'&offset=0&page=10' as link;