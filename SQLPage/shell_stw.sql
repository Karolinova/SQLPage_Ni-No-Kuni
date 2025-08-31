select 'shell' as component
-- , 'boxed' as layout
, 'Twórca: Karolinova' as footer
, '/style.css' as css
, true as sidebar
, jsonb_build_array(
  jsonb_build_object('title', 'Stworzenia', 'link', '/Stworzenia/stworzenia_user.sql?gra=' ||$gra||'')
) as menu_item
, (select jsonb_build_array(
  jsonb_build_object('title', 'Nowe stworzenie', 'link', '/Admin/nowe_stworzenie.sql?gra=' ||$gra||'')
) as menu_item
from users
where id = (select user_id from user_log
            where token=sqlpage.cookie('session_token'))
  and login = 'Admin') as menu_item
;