-- personalization to each page
select 'shell' as component
, 'Twórca: Karolinova' as footer
, '/style.css' as css
, true as sidebar
, jsonb_build_array(
  jsonb_build_object('title', 'Stworzenia', 'link', '/Stworzenia/stworzenia_user.sql?gra=' ||$gra||'')
) as menu_item
;
