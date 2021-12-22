-- View: v_business_partner_attribute

-- DROP VIEW v_business_partner_attribute;

CREATE OR REPLACE VIEW v_business_partner_attribute AS 
 SELECT bp.org_id, bp.bp_id, bp.address_id, ad.country_code, c.country_desc, bp.bp_name, bp.email_1, bp.username, bp.userpwd, bat.attrib_value, bp.bp_company, bp.phone_1, ad.address_line_1, ad.postal_code, ad.city
   FROM business_partner bp, bp_attrib bat, address ad, country c
  WHERE bp.org_id = bat.org_id AND bp.bp_id = bat.bp_id AND bat.attrib_code::text = 'REG_STATUS'::text AND bp.org_id = ad.org_id AND bp.address_id = ad.address_id AND ad.country_code::text = c.country_code::text;

ALTER TABLE v_business_partner_attribute
  OWNER TO "ERP";
GRANT ALL ON TABLE v_business_partner_attribute TO "ERP";
GRANT SELECT ON TABLE v_business_partner_attribute TO "PPEDOCREAD";
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE v_business_partner_attribute TO "PPEDOCLOAD" WITH GRANT OPTION;

