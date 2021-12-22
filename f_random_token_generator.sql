-- Function: f_random_token_generator(integer)

-- DROP FUNCTION f_random_token_generator(integer);

CREATE OR REPLACE FUNCTION f_random_token_generator(length integer)
  RETURNS text AS
$BODY$
WITH chars AS (
    SELECT unnest(string_to_array('A B C D E F 0 1 2 3 4 5 6 7 8 9', ' ')) AS _char
),
charlist AS
(
    SELECT _char FROM chars ORDER BY random() LIMIT $1
)
SELECT string_agg(_char, '')
FROM charlist;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION f_random_token_generator(integer)
  OWNER TO "ERP";
GRANT EXECUTE ON FUNCTION f_random_token_generator(integer) TO public;
GRANT EXECUTE ON FUNCTION f_random_token_generator(integer) TO "ERP";
GRANT EXECUTE ON FUNCTION f_random_token_generator(integer) TO "PPEDOCREAD";
GRANT EXECUTE ON FUNCTION f_random_token_generator(integer) TO "PPEDOCLOAD" WITH GRANT OPTION;
