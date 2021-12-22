-- SELECT f_insert_business_partner(8, '1', 'testy address', 1234, 'Dhaka', 'Test name', null, 'test123', 'test@email.com', 'testPulse', '12345', 'token');

-- Function: f_insert_business_partner(numeric, character varying, character varying, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying)

-- DROP FUNCTION f_insert_business_partner(numeric, character varying, character varying, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION f_insert_business_partner(p_org_id numeric, p_country_code character varying, p_address_line_1 character varying, p_postal_code numeric, p_city character varying, p_bp_name character varying, p_title character varying, p_first_name character varying, p_last_name character varying, p_username character varying, p_userpwd character varying, p_email_1 character varying, p_bp_company character varying, p_phone_1 character varying, p_token character varying)
  RETURNS void AS
$BODY$

DECLARE
	v_max_bp_id	 integer;
	-- v_token   	 character varying;
	v_max_address_id integer;
BEGIN

	INSERT INTO address (org_id, country_code, address_desc, address_line_1, postal_code, city, address_full) 
	VALUES (p_org_id, p_country_code, 'REG-LICENSE', p_address_line_1, p_postal_code, p_city, p_address_line_1 );

	SELECT MAX(address_id::numeric) INTO v_max_address_id FROM address;

	INSERT INTO business_partner(org_id, address_id, bp_name, title, first_name, last_name, username, userpwd, email_1, bp_company, phone_1)
	VALUES (p_org_id, v_max_address_id, p_bp_name,  p_title, p_first_name, p_last_name, p_username, p_userpwd, p_email_1, p_bp_company, p_phone_1 );

	SELECT MAX(bp_id::numeric) INTO v_max_bp_id FROM business_partner;

	--SELECT f_random_token_generator(16) INTO v_token;

	UPDATE business_partner
	SET bp_code = v_max_bp_id
	WHERE bp_id = v_max_bp_id;

	INSERT INTO bp_attrib(org_id, bp_id, attrib_code, attrib_desc, attrib_data_type, attrib_value)
	VALUES (p_org_id, v_max_bp_id, 'REG_STATUS', 'REG_STATUS_DESC', 'string', 'Email not verified' );

	INSERT INTO bp_attrib(org_id, bp_id, attrib_code, attrib_desc, attrib_data_type, attrib_value)
	VALUES (p_org_id, v_max_bp_id, 'REG_TOCKEN', 'REG_TOCKEN_DESC', 'string', p_token);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION f_insert_business_partner(numeric, character varying, character varying, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying)
  OWNER TO "ERP";
GRANT EXECUTE ON FUNCTION f_insert_business_partner(numeric, character varying, character varying, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying) TO public;
GRANT EXECUTE ON FUNCTION f_insert_business_partner(numeric, character varying, character varying, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying) TO "ERP";
GRANT EXECUTE ON FUNCTION f_insert_business_partner(numeric, character varying, character varying, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying) TO "PPEDOCREAD";
GRANT EXECUTE ON FUNCTION f_insert_business_partner(numeric, character varying, character varying, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying) TO "PPEDOCLOAD" WITH GRANT OPTION;
