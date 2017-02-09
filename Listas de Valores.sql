SELECT fvs.flex_value_set_name
      ,fvt.flex_value_meaning
      ,fvt.description
      ,fv.flex_value
  FROM fnd_flex_values fv
      ,fnd_flex_value_sets fvs
      ,fnd_flex_values_tl fvt
 WHERE fvs.flex_value_set_id = fv.flex_value_set_id
   AND fvt.flex_value_id = fv.flex_value_id
   AND fvs.flex_value_set_name = 'CGP_CONCEPTOS_TRADE'
   AND fvt.language = USERENV('LANG')
   AND fv.enabled_flag = 'Y'
   AND SYSDATE >= NVL(fv.start_date_active,SYSDATE)
   AND SYSDATE < NVL(fv.end_date_active,SYSDATE + 1)
ORDER BY flex_value ASC;
