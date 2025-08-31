create or replace function update_stw_gold ()
returns trigger as $$
begin 
	update stworzenia
	set gold = case when nazwa like '%(gold)' then true else false end
	where id = new.id;
	return null;
end;
$$ LANGUAGE plpgsql;

create TRIGGER update_gold
after insert on stworzenia
for each row
execute function update_stw_gold();

create TRIGGER ins_update_gold
after update on stworzenia
for each row
execute function update_stw_gold();