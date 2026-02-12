create or replace function fn_upper_tr(p_text varchar)
returns varchar
language plpgsql as $$

declare

begin
	
	if p_text is null then
		return null;
	end if;

	return upper(translate(p_text, 'ıiğüşçö', 'IİĞÜŞÇÖ'));
end;
$$
