create or replace function update_stw_gold ()
returns trigger as $$
begin 
	NEW.gold := (NEW.nazwa like '%(gold)');
    return NEW;
end;
$$ LANGUAGE plpgsql;

create TRIGGER update_gold
before insert on stworzenia
for each row
execute function update_stw_gold();

create TRIGGER ins_update_gold
before update on stworzenia
for each row
execute function update_stw_gold();