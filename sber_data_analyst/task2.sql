DO $$
DECLARE
    column_list text := '';
    _query text;
    _cursor CONSTANT refcursor := '_cursor';
BEGIN
    with loans as (
        select lt.client_id, gender, COUNT(loan_id) AS num_loans
        from loans_table lt
        join clients_table ct on lt.client_id = ct.client_id
        where EXTRACT(year from loan_date) = 2020
        group by lt.client_id, gender
    ), gen_rows as (
        select * from generate_series(1, (select max(num_loans) from loans)) n_loans
    ), clients_by_loans as (
        select n_loans, gender, COUNT(case when loans.num_loans >= n_loans then 1 end) cnt
        from gen_rows, loans
        group by 1, 2
        order by 1, 2
    )
    -- Формируем список столбцов на основе уникальных значений столбца n_loans
    SELECT string_agg('"Количество ' || n_loans || 'х договоров" int', ', ')
    INTO column_list
    FROM (select DISTINCT n_loans from clients_by_loans order by 1) t;
    
    -- Формируем запрос для получения кросс таблицы
    _query := format('
        SELECT * FROM crosstab(
           ''select gender, n_loans, cnt from temp_table order by 1, 2'',
           ''select distinct n_loans::int from temp_table order by 1 asc''
        ) AS ct (
          "Пол" text,
          %s
        )', column_list);
    OPEN _cursor FOR EXECUTE _query;
END
$$;
FETCH ALL FROM _cursor;