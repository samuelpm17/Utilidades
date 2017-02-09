SELECT  hp.party_id,
        hp.party_name,
        hp.party_type,
        hp.party_number,
        hp.tax_reference,
        ps.location_id,
        100 score,
        jgzz_fiscal_code taxpayer_id,
        fnd1.meaning type_lookup,
        (100||'%') percentage,
        (SELECT  terr.territory_short_name
        FROM Fnd_territories_tl terr
        WHERE hp.country = terr.territory_code(+)
        AND   terr.language(+) = userenv('lang')
        ) country,
        hp.duns_number_c duns_number,
        hp.known_as known_as,
        hp.primary_phone_country_code primary_phone_country_code,
        hp.primary_phone_area_code primary_phone_area_code,
        hp.primary_phone_number primary_phone_number,
        hp.primary_phone_line_type primary_phone_line_type,
        hp.primary_phone_extension primary_phone_extension,
        hp.email_address email,
        hp.organization_name_phonetic,
        hp.person_first_name_phonetic,
        hp.person_last_name_phonetic,
        cp.contact_point_id,
        hp.url primary_url,
        fnd2.meaning certification_level_meaning
FROM    (SELECT /*+ no_merge */ DISTINCT  aaa.customer_id
         FROM As_accesses_all aaa
         WHERE aaa.sales_lead_id IS NULL
         AND   aaa.lead_id IS NULL
       --  AND   aaa.salesforce_id = :1
         ) secu,
        Hz_parties hp,
        Hz_party_sites ps,
        Hz_contact_points cp,
        Fnd_lookup_values fnd1,
        Fnd_lookup_values fnd2,                
        po_vendors pv
WHERE hp.party_id = secu.customer_id
--AND   hp.party_type  = :2
AND   hp.status = 'A'
AND   hp.party_id = ps.party_id(+)
AND   ps.identifying_address_flag(+) = 'Y'
AND   hp.party_id = cp.owner_table_id(+)
AND   cp.owner_table_name(+) = 'HZ_PARTIES'
AND   cp.primary_flag(+) = 'Y'
AND   cp.contact_point_type(+) = 'PHONE'
AND   fnd1.view_application_id(+) = 222
AND   fnd1.lookup_type(+) = 'PARTY_TYPE'
AND   fnd1.language(+) = userenv('LANG')
AND   fnd1.lookup_code(+) = hp.party_type
AND   fnd2.view_application_id(+) = 222
AND   fnd2.lookup_type(+) = 'HZ_PARTY_CERT_LEVEL'
AND   fnd2.language(+) = userenv('LANG')
AND   fnd2.lookup_code(+) = hp.certification_level
AND   hp.party_id = pv.party_id(+)
--AND   pv.party_id IS NULL 
AND hp.party_id=13932
