select 'dynamic' as component, sqlpage.run_sql('shell.sql') as properties;

select 'text' as component
    , 'Witamy ' || 
    (select u.login 
    from users u 
    join user_log ul on ul.user_id=u.id
    where ul.token=sqlpage.cookie('session_token')) 
    as contents;
