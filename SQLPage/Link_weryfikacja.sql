-- validation for exisisting user in database if we don't want to have an information about user on other pages
-- with dane_uzytkownika as 
-- (
--     select login, password from Ni_No_Kuni.dbo.users
-- )
-- select 'redirect' as component
-- , case when exists (select 1 from dane_uzytkownika
--                     where login = :Login and password = :Haslo)
--                     then 'Strona_glowna.sql' else 'index.sql'
--                     end as link;

-- authentication component to maintain user information
select 'authentication' as component, 
       (select password_hash 
        from users
        where login = :login and password=:password) as password_hash,
       :password as password;

-- Insert login session into user_log table
insert into user_log (user_id, token)
        select id, sqlpage.random_string(32)
        from users where login =:login
RETURNING
    'cookie' as component
    , 'session_token' as name
    , token as value
    ;
-- redirect to main page 
SELECT 'redirect' AS component, 'Strona_glowna.sql' AS link;
