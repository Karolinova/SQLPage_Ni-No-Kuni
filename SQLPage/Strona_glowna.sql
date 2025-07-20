select 'shell' as component
, 'Twórca: Karolinova' as footer;

-- at this momment it is not necessary
-- select 'text' as component
-- , 'Witamy ' || 
--     (select u.login 
--     from users u 
--     join user_log ul on ul.user_id=u.id
--     where ul.token=sqlpage.cookie('session_token')) 
--     as contents;

-- Add header on main page
select 'title' as component
, 'Wybór gry' as contents
, 1 as LEVEL
, true as center
;

-- Add image on main page
select 'html' as component
, 'obrazki_naglowek' as class
, '<br>
    <a href="strona_glowna_gry.sql?gra=1"><img src ="ni_no_kuni.jpg" width="600" style="max-width: 600px; height: auto;"/></a>
    <a href="strona_glowna_gry.sql?gra=2"><img src ="ni_no_kuni_II.jpg" width="600" style="max-width: 600px; height: auto;"/></a>
<br>' as html
