insert into stworzenia_nnk (imie, stw_id, gra_id)
select :imie as imie
, id as stw_id
, $gra::int as gra_id
from stworzenia
where nazwa = :nazwa
returning
    'redirect' as component,
    '/Stworzenia/st_wybor_gry.sql?id=' ||$gra||'' as link;