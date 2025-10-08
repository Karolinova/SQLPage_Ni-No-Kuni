select 'dynamic' as component
, sqlpage.run_sql('shell_stw.sql') AS properties;

-- Add return button
 Select 'button' as component
    ,'sm' as size;
select 
    '/strona_glowna_gry.sql?gra='||$gra||'' as link,
    'Powrót'  as title;

-- Alert communique
select 'alert' as component
, 'Sukces!' as title
, 'stworzenie "'||$name||'" zostało zmodyfikowane.' as description
, 'green' as color;

select 
    'title'   as component
    , 'Lista stworzeń' as contents
    , true as center;

select 
    'tab' as component,
    TRUE  as center;
select 'WSZYSTKO' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1' as link;
select 'A' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=A' as link;
select 'B' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=B' as link;
select 'C' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=C' as link;
select 'D' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=D' as link;
select 'E' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=E' as link;
select 'F' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=F' as link;
select 'G' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=G' as link;
select 'H' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=H' as link;
select 'I' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=I' as link;
select 'J' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=J' as link;
select 'K' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=K' as link;
select 'L' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=L' as link;
select 'M' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=M' as link;
select 'N' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=N' as link;
select 'O' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=O' as link;
select 'P' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=P' as link;
select 'R' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=R' as link;
select 'S' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=S' as link;
select 'T' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=T' as link;
select 'U' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=U' as link;
select 'W' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=W' as link;
select 'Z' as title
, 'modyfikuj_usun_stworzenie.sql?gra=1&litera=Z' as link;


select 'list' as component
, TRUE as search
, 'true' as compact
;

select nazwa as title
, 'Akcje/modyfikuj_stw.sql?gra='||$gra||'&id='||id||'' as edit_link
, 'Akcje/usun_stw.sql?gra='||$gra||'&id='||id||'' as delete_link
from stworzenia
where gra_id = $gra::int
and (left(nazwa,1) ilike $litera or $litera is null)
order by nazwa;