-- SELECT f_update_business_partner(8, 11307, 0, 10747, '1', 'test address', 1212, 'Dhaka', 'Test Name', 'asif.rahman@impulsebdltd.com', 'TeamPulse', '12345', 'token');

-- Function: f_update_business_partner(numeric, numeric, numeric, numeric, character varying, character varying, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying)

-- DROP FUNCTION f_update_business_partner(numeric, numeric, numeric, numeric, character varying, character varying, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION f_update_business_partner(p_org_id numeric, p_bp_id numeric, p_email_status numeric, p_address_id numeric, p_country_code character varying, p_address_line_1 character varying, p_postal_code numeric, p_city character varying, p_bp_name character varying, p_email_1 character varying, p_bp_company character varying, p_phone_1 character varying, p_token character varying, p_title character varying, p_first_name character varying, p_last_name character varying)
  RETURNS void AS
$BODY$

DECLARE
	-- v_token   	character varying;
BEGIN
	
	UPDATE business_partner
	SET bp_name = p_bp_name, email_1 = p_email_1, bp_company = p_bp_company, phone_1 = p_phone_1, title = p_title, first_name = p_first_name, last_name = p_last_name
	WHERE org_id = p_org_id AND bp_id = p_bp_id AND address_id = p_address_id;

	UPDATE address
	SET country_code = p_country_code, address_line_1 = p_address_line_1, postal_code = p_postal_code, city = p_city, address_full = p_address_line_1
	WHERE org_id = p_org_id AND address_id = p_address_id;

	IF p_email_status = 1 THEN 
	
		UPDATE bp_attrib
		SET attrib_value = 'Email not verified'
		WHERE org_id = p_org_id AND bp_id = p_bp_id AND attrib_code = 'REG_STATUS';

		UPDATE bp_attrib
		SET attrib_value = p_token
		WHERE org_id = p_org_id AND bp_id = p_bp_id AND attrib_code = 'REG_TOCKEN';

	END IF;

	-- RETURN v_token;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION f_update_business_partner(numeric, numeric, numeric, numeric, character varying, character varying, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying)
  OWNER TO "ERP";
GRANT EXECUTE ON FUNCTION f_update_business_partner(numeric, numeric, numeric, numeric, character varying, character varying, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying) TO public;
GRANT EXECUTE ON FUNCTION f_update_business_partner(numeric, numeric, numeric, numeric, character varying, character varying, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying) TO "ERP";
GRANT EXECUTE ON FUNCTION f_update_business_partner(numeric, numeric, numeric, numeric, character varying, character varying, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying) TO "PPEDOCREAD";
GRANT EXECUTE ON FUNCTION f_update_business_partner(numeric, numeric, numeric, numeric, character varying, character varying, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying) TO "PPEDOCLOAD" WITH GRANT OPTION;

