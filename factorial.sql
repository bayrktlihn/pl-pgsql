create or replace function fn_factorial(p_number numeric)
returns numeric
language plpgsql as $$

declare

begin
	if p_number < 0 then
		raise exception 'number must not be negative';
	end if;

	if p_number in (0, 1) then
		return 1;
	end if;

	return p_number * fn_factorial(p_number - 1);
	
end;
$$
