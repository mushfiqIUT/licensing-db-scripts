-- Function: f_update_forget_pass_token(numeric, character varying, character varying)

-- DROP FUNCTION f_update_forget_pass_token(numeric, character varying, character varying);

CREATE OR REPLACE FUNCTION f_update_forget_pass_token(p_org_id numeric, p_email_1 character varying, p_token character varying)
  RETURNS void AS
$BODY$

DECLARE
BEGIN
	
	UPDATE business_partner
	SET userpwd = p_token
	WHERE org_id = p_org_id AND email_1 = p_email_1;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION f_update_forget_pass_token(numeric, character varying, character varying)
  OWNER TO "ERP";
GRANT EXECUTE ON FUNCTION f_update_forget_pass_token(numeric, character varying, character varying) TO public;
GRANT EXECUTE ON FUNCTION f_update_forget_pass_token(numeric, character varying, character varying) TO "ERP";
GRANT EXECUTE ON FUNCTION f_update_forget_pass_token(numeric, character varying, character varying) TO "PPEDOCREAD";
GRANT EXECUTE ON FUNCTION f_update_forget_pass_token(numeric, character varying, character varying) TO "PPEDOCLOAD" WITH GRANT OPTION;
