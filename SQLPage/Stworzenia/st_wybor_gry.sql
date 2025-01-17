select 'dynamic' as component
, sqlpage.run_sql('shell.sql') AS properties;

-- Add return button
 Select 'button' as component
    ,'sm' as size;
select 
    'stworzenia.sql' as link,
    'Powrót'  as title;

-- Add filter result
select 'table' as component;

select imie, nazwa, gatunek, nazwa_rec as "Przysmak", "Trik 1", "Trik 2", "Trik 3"
      from (
         select 'Ni no Kuni: Wrath of the White Witch' as gra
         , s1.imie, s.nazwa, s.gatunek, r.nazwa as nazwa_rec
         , t1.nazwa as "Trik 1", t2.nazwa as "Trik 2", t3.nazwa as "Trik 3"
         from stworzenia s 
         join stworzenia_nnk1 s1 on s1.stw_id = s.id
         join triki_zaklecia t1 on t1.id = trik1_id
         join triki_zaklecia t2 on t2.id = trik2_id
         join triki_zaklecia t3 on t3.id = trik3_id
         join recepta r on r.id = s.przysmak_id
         union all
         select 'Ni no Kuni II: Revenant Kingdom' as gra
         , s2.imie, s.nazwa, s.gatunek, r.nazwa as nazwa_rec
         , t1.nazwa as "Trik 1", t2.nazwa as "Trik 2", t3.nazwa as "Trik 3"
         from stworzenia s 
         join stworzenia_nnk2 s2 on s2.stw_id = s.id
         join triki_zaklecia t1 on t1.id = trik1_id
         join triki_zaklecia t2 on t2.id = trik2_id
         join triki_zaklecia t3 on t3.id = trik3_id
         join recepta r on r.id = s.przysmak_id
         union all
         select 'Ni No Kuni I/Ni no Kuni II' as gra
         , nnk1_nnk2.imie, nnk1_nnk2.nazwa, nnk1_nnk2.gatunek, nnk1_nnk2.nazwa_rec
         , nnk1_nnk2."Trik 1", nnk1_nnk2."Trik 2", nnk1_nnk2."Trik 3"
         from
         (select s1.imie, s.nazwa, s.gatunek, r.nazwa as nazwa_rec
         , t1.nazwa as "Trik 1", t2.nazwa as "Trik 2", t3.nazwa as "Trik 3"
         from stworzenia s 
         join stworzenia_nnk1 s1 on s1.stw_id = s.id
         join triki_zaklecia t1 on t1.id = trik1_id
         join triki_zaklecia t2 on t2.id = trik2_id
         join triki_zaklecia t3 on t3.id = trik3_id
         join recepta r on r.id = s.przysmak_id
         union all
         select s2.imie, s.nazwa, s.gatunek, r.nazwa as nazwa_rec
         , t1.nazwa as "Trik 1", t2.nazwa as "Trik 2", t3.nazwa as "Trik 3"
         from stworzenia s 
         join stworzenia_nnk2 s2 on s2.stw_id = s.id
         join triki_zaklecia t1 on t1.id = trik1_id
         join triki_zaklecia t2 on t2.id = trik2_id
         join triki_zaklecia t3 on t3.id = trik3_id
         join recepta r on r.id = s.przysmak_id) nnk1_nnk2
      ) as dane
where gra = :Kolumna;
