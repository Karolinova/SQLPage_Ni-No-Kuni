-- table 'stworzenia_nnk1'
create table stworzenia_nnk1 (stw_id bigserial primary key
, imie varchar
, constraint FK_stworzenia1 foreign key(stw_id) references stworzenia (id)
);
