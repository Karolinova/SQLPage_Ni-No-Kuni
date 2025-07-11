-- table 'stworzenia_nnk1' (familiars from Ni No Kuni: Wrath of The White Witch)
create table stworzenia_nnk (id bigserial primary key
, imie varchar
, stw_id int
, constraint FK_stworzenia1 foreign key(stw_id) references stworzenia (id)
, gra_id int
, constraint FK_gra foreign key(gra_id) references help_list (id)
, user_id int
, constraint FK_user foreign key(user_id) references users(id)
);
