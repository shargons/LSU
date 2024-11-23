

/********** UserRole Lookup *************/
select a.id as EDA_ID,b.id AS EDC_ID from edaprod.dbo.UserRole a
inner join EDUCPROD.dbo.UserRole b
on a.DeveLoperName = b.DeveLoperName

SELECT * FROM EDUCPROD.dbo.UserRole


SELECT * FROM edaprod.dbo.UserRole


/********** Recordtype Lookup *************/
select a.id as EDA_ID,b.id AS EDC_ID from edaprod.dbo.Recordtype a
inner join EDUCPROD.dbo.Recordtype b
on a.DeveLoperName = b.DeveLoperName

SELECT * FROM EDUCPROD.dbo.Recordtype

SELECT * FROM edaprod.dbo.Recordtype