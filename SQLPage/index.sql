select 'dynamic' as component, sqlpage.run_sql('shell.sql') as properties;

select 'form' as component
, 'Logowanie' as validate
, 'Link_weryfikacja.sql' as action -- page to verify if user exists in base
, 'Zaloguj się' as title
; 

select 'Login' as name
, 'text' as type
, true as required
;

select 'Haslo' as name
, 'Hasło' as label -- to display name
, 'password' as type -- to hide password on display
, true as required
;
