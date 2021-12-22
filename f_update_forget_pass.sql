-- Function: f_update_forget_pass(numeric, numeric, character varying, character varying)

-- DROP FUNCTION f_update_forget_pass(numeric, numeric, character varying, character varying);

CREATE OR REPLACE FUNCTION f_update_forget_pass(p_org_id numeric, p_bp_id numeric, p_token character varying, p_new_pass character varying)
  RETURNS void AS
$BODY$

DECLARE
BEGIN	
	UPDATE business_partner
	SET userpwd = p_new_pass
	WHERE org_id = p_org_id AND bp_id = p_bp_id AND userpwd = p_token;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION f_update_forget_pass(numeric, numeric, character varying, character varying)
  OWNER TO "ERP";
GRANT EXECUTE ON FUNCTION f_update_forget_pass(numeric, numeric, character varying, character varying) TO public;
GRANT EXECUTE ON FUNCTION f_update_forget_pass(numeric, numeric, character varying, character varying) TO "ERP";
GRANT EXECUTE ON FUNCTION f_update_forget_pass(numeric, numeric, character varying, character varying) TO "PPEDOCREAD";
GRANT EXECUTE ON FUNCTION f_update_forget_pass(numeric, numeric, character varying, character varying) TO "PPEDOCLOAD" WITH GRANT OPTION;
