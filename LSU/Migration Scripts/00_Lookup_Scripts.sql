

/********** UserRole Lookup *************/
select a.id as EDA_ID,b.id AS EDC_ID from edaprod.dbo.UserRole a
inner join edcuat.dbo.UserRole b
on a.DeveLoperName = b.DeveLoperName

SELECT * FROM edcuat.dbo.UserRole


SELECT * FROM edaprod.dbo.UserRole


/********** Recordtype Lookup *************/
select a.id as EDA_ID,b.id AS EDC_ID from edaprod.dbo.Recordtype a
inner join edcuat.dbo.Recordtype b
on a.DeveLoperName = b.DeveLoperName

SELECT * FROM edcuat.dbo.Recordtype

SELECT * FROM edaprod.dbo.Recordtype