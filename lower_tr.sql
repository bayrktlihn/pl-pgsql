create or replace function fn_lower_tr(p_text varchar)
returns varchar
language plpgsql as $$

declare

begin
	
	if p_text is null then
		return null;
	end if;

	return lower(translate(p_text, 'IİĞÜŞÇÖ', 'ıiğüşçö'));
end;
$$
