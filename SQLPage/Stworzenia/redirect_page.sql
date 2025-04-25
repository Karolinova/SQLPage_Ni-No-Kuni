select 'redirect' as component,
    'st_wybor_gry.sql?id='||id||'' as link
    from help_list
    where wartosc = :Kolumna
    and nazwa = 'Gra';
