-- validation for exisisting user in database
with dane_uzytkownika as 
(
    select login, password from Ni_No_Kuni.dbo.users
)
select 'redirect' as component
, case when exists (select 1 from dane_uzytkownika
                    where login = :Login and password = :Haslo)
                    then 'Strona_glowna.sql' else 'index.sql'
                    end as link;
