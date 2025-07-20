select 'shell' as component
, 'Twórca: Karolinova' as footer;

select 'form' as component
, 'Zaloguj się' as validate
, 'Link_weryfikacja.sql' as action -- page to verify if user exists in base
, 'Logowanie' as title
; 

select 'login' as name
, 'Login' as label
, 'text' as type
, true as required
;

select 'password' as name
, 'Hasło' as label -- to display name
, 'password' as type -- to hide password on display
, true as required
;
