create or replace function fn_monthly_mask(
	p_start date,
	p_end_included date,
	p_period_start date,
	p_period_end_included date
)
returns int 
language plpgsql as $$
declare
	v_included_start date;
	v_included_end date;
	v_result bigint;
	v_offset int := 0;
	v_included_day_count int := 0;
begin
	if p_start > p_end_included then
		raise exception 'p_start must not be greater than p_end_included';
	end if;

	if p_period_start > p_period_end_included then
		raise exception 'p_period_start must not be greater than p_period_end_included';
	end if;

	if p_period_end_included - p_period_start + 1 > 31 then
		raise exception 'Period dates max 31 range';
	end if;

	v_included_start := greatest(p_start, p_period_start);
	v_included_end := least(p_end_included, p_period_end_included);

	if v_included_start > v_included_end then
		return 0;
	end if;

	v_included_day_count := v_included_end - v_included_start + 1;

	v_result := (cast(1 as bigint) << v_included_day_count) - 1 ;

	v_offset := cast(v_included_start - p_period_start as int);


	return cast((v_result << v_offset) as int );
	

end;
$$
