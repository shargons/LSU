USE [master]
GO

/****** Object:  LinkedServer [EDAPROD]    Script Date: 6/10/2024 3:59:28 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'EDAPROD', @srvproduct=N'', @provider=N'SQLNCLI', @datasrc=N'localhost,1435', @provstr=N'App=https://lsuonline.lightning.force.com/'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'EDAPROD',@useself=N'False',@locallogin=NULL,@rmtuser=N'sharon.gonsalves@cloud4good.com.eda',@rmtpassword='qNfE6GgzAfpB7L8DUus2idt6OHZQKCF3b6v5vxx2'
GO

EXEC master.dbo.sp_serveroption @server=N'EDAPROD', @optname=N'collation compatible', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EDAPROD', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EDAPROD', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EDAPROD', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EDAPROD', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EDAPROD', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EDAPROD', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EDAPROD', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'EDAPROD', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'EDAPROD', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EDAPROD', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'EDAPROD', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EDAPROD', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


