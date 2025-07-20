insert into stworzenia_nnk (imie, stw_id, gra_id, user_id)
select :imie as imie
, id as stw_id
, $gra::int as gra_id
, (select id from users where login = $login) as user_id
from stworzenia
where nazwa = :nazwa
returning
    'redirect' as component,
    '/Stworzenia/st_wybor_gry.sql?login='||$login||'&gra='||$gra||'&offset=0&page=10' as link;