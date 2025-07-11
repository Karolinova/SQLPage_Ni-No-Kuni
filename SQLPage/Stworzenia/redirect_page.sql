select 'redirect' as component,
    'st_wybor_gry.sql?login='||$login||'&id='||id||'&offset=0&page=10' as link
    from help_list
    where wartosc = :Kolumna
    and nazwa = 'Gra';
