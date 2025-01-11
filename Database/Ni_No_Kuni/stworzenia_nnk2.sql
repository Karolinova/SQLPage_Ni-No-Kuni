-- table 'stworzenia_nnk2'
create table stworzenia_nnk2 (stw_id bigserial primary key
, imie varchar
, constraint FK_stworzenia2 foreign key(stw_id) references stworzenia (id)
);
