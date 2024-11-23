USE [master]
GO

/****** Object:  LinkedServer [EDUCPROD]    Script Date: 6/10/2024 3:59:28 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'EDUCPROD', @srvproduct=N'', @provider=N'SQLNCLI', @datasrc=N'localhost,1435', @provstr=N'App=https://lsu.my.salesforce.com'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'EDUCPROD',@useself=N'False',@locallogin=NULL,@rmtuser=N'lsu_migrationuser@cloud4good.com.ec.edu',@rmtpassword='PzLML5NRAgL6j8XaVOvLKfcFd0a1QfIu4Ov91HCT5'
GO

EXEC master.dbo.sp_serveroption @server=N'EDUCPROD', @optname=N'collation compatible', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EDUCPROD', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EDUCPROD', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EDUCPROD', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EDUCPROD', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EDUCPROD', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EDUCPROD', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EDUCPROD', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'EDUCPROD', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'EDUCPROD', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EDUCPROD', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'EDUCPROD', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EDUCPROD', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


