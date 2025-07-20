with uprawnienia AS (
    select case when READ_ONLY is true then 'WIDOK'
        when read_only is false then 'EDYCJA' end as widok_edycja
        from users
        where id = (select user_id from user_log
                    where token=sqlpage.cookie('session_token'))
)
select 'redirect' as component
, case when widok_edycja = 'EDYCJA' then 'del_stw.sql?login='||$login||'&gra='||$gra||'&stw_id='||$id||''
    when widok_edycja <> 'EDYCJA' then '/Stworzenia/st_wybor_gry.sql?login='||$login||'&id='||$gra||'&offset=0&page=10' end as LINK
    from uprawnienia;