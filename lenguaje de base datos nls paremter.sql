SELECT initcap((SELECT ndp.value
        FROM   nls_database_parameters ndp
        WHERE  ndp.parameter = 'NLS_LANGUAGE')) || '_' ||
       initcap((SELECT ndp.value
        FROM   nls_database_parameters ndp
        WHERE  ndp.parameter = 'NLS_TERRITORY')) || '.' ||
       (SELECT ndp.value
        FROM   nls_database_parameters ndp
        WHERE  ndp.parameter = 'NLS_CHARACTERSET')
FROM   dual;
