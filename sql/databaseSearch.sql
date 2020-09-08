SELECT      c.name  AS 'ColumnName'
            ,t.name AS 'TableName'
FROM        sys.columns c
JOIN        sys.tables  t   ON c.object_id = t.object_id
WHERE       c.name LIKE '%CommissionRate%'
ORDER BY    TableName
            ,ColumnName;


SELECT name
FROM   sys.procedures
WHERE  Object_definition(object_id) LIKE '%7703091425545%'


SELECT DISTINCT NAME AS [NAME],
 CASE  WHEN TYPE ='P' THEN 'PROCEDURE'
     WHEN TYPE IN('FN', 'IF','TF') THEN 'FUNCTION'
 END AS OBJECTTYPE
FROM SYSCOMMENTS as comm
JOIN sysobjects as obj
ON comm.id = obj.id and obj.type IN ('P','FN', 'IF', 'TF')
WHERE lower(TEXT) LIKE '%' + ltrim(rtrim(lower('ProlongValueType'))) + '%'