with uprawnienia AS (
    select case when READ_ONLY is true then 'WIDOK'
        when read_only is false then 'EDYCJA' end as widok_edycja
        from users
        where id = (select user_id from user_log
                    where token=sqlpage.cookie('session_token'))
)
, update_stw as (
update stworzenia_nnk
set imie = :imie
, stw_id = (select id from stworzenia where nazwa = :nazwa)
from uprawnienia
where id = $stw_id::BIGINT
and widok_edycja = 'EDYCJA'
returning 'EDYCJA' as widok_edycja
)
select 'redirect' as component
, case when u.widok_edycja = 'EDYCJA' then '/Stworzenia/st_wybor_gry.sql?login='||$login||'&id=' ||$gra||'&offset=0&page=10'
    when u.widok_edycja <> 'EDYCJA' then 'edytuj_stworzenie.sql?login='||$login||'&gra='||$gra||'&id='||$stw_id||'' end as link
from uprawnienia u
left join update_stw us on us.widok_edycja = 'EDYCJA';