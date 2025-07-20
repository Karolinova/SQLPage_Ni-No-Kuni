select 'redirect' as component,
    'st_wybor_gry.sql?login='||$login||'&gra='||gra||'&offset=0&page=10' as link
from users
where login = :User;
