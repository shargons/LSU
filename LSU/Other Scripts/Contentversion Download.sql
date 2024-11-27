--DROP TABLE ContentVersion_All
CREATE TABLE ContentVersion_All
(
	id_num INT IDENTITY(1, 1),
	ID NVARCHAR (18)
)

--SET IDENTITY_INSERT ContentVersion_All ON;
INSERT INTO ContentVersion_All(ID)
SELECT ID
FROM ContentVersion


CREATE TABLE ContentVersion_1_100000
(
	ID NVARCHAR (18)
)

INSERT INTO ContentVersion_1_100000
SELECT ID
FROM ContentVersion_All
WHERE id_num <=100000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_1_100000'

CREATE TABLE ContentVersion_100001_200000
(
	ID NVARCHAR (18)
)

INSERT INTO ContentVersion_100001_200000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=100001 and id_num <=200000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_100001_200000'


CREATE TABLE ContentVersion_200001_300000
(
	ID NVARCHAR (18)
)


INSERT INTO ContentVersion_200001_300000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=200001 and id_num <=300000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_200001_300000'


CREATE TABLE ContentVersion_300001_400000
(
	ID NVARCHAR (18)
)

INSERT INTO ContentVersion_300001_400000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=300001 and id_num <=400000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_300001_400000'

CREATE TABLE ContentVersion_400001_500000
(
	ID NVARCHAR (18)
)

INSERT INTO ContentVersion_400001_500000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=400001 and id_num <=500000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_400001_500000'

CREATE TABLE ContentVersion_500001_600000
(
	ID NVARCHAR (18)
)

INSERT INTO ContentVersion_500001_600000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=500001 and id_num <=600000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_500001_600000'


CREATE TABLE ContentVersion_600001_700000
(
	ID NVARCHAR (18)
)

INSERT INTO ContentVersion_600001_700000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=600001 and id_num <=700000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_600001_700000'

CREATE TABLE ContentVersion_700001_800000
(
	ID NVARCHAR (18)
)

INSERT INTO ContentVersion_700001_800000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=700001 and id_num <=800000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_700001_800000'

CREATE TABLE ContentVersion_800001_900000
(
	ID NVARCHAR (18)
)

INSERT INTO ContentVersion_800001_900000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=800001 and id_num <=900000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_800001_900000'

CREATE TABLE ContentVersion_900001_1000000
(
	ID NVARCHAR (18)
)
INSERT INTO ContentVersion_900001_1000000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=900001 and id_num <=1000000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_900001_1000000'

CREATE TABLE ContentVersion_1000001_1100000
(
	ID NVARCHAR (18)
)


CREATE TABLE ContentVersion_1100001_1200000
(
	ID NVARCHAR (18)
)
CREATE TABLE ContentVersion_1200001_1300000
(
	ID NVARCHAR (18)
)
CREATE TABLE ContentVersion_1300001_1400000
(
	ID NVARCHAR (18)
)
CREATE TABLE ContentVersion_1400001_1500000
(
	ID NVARCHAR (18)
)
CREATE TABLE ContentVersion_1500001_1600000
(
	ID NVARCHAR (18)
)
CREATE TABLE ContentVersion_1600001_1700000
(
	ID NVARCHAR (18)
)
CREATE TABLE ContentVersion_1700001_1800000
(
	ID NVARCHAR (18)
)
CREATE TABLE ContentVersion_1800001_1900000
(
	ID NVARCHAR (18)
)

INSERT INTO ContentVersion_1800001_1900000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=1800001 and id_num <=1900000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_1800001_1900000'

CREATE TABLE ContentVersion_1900001_2000000
(
	ID NVARCHAR (18)
)
INSERT INTO ContentVersion_1900001_2000000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=1900001 and id_num <=2000000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_1900001_2000000'


CREATE TABLE ContentVersion_2000001_2100000
(
	ID NVARCHAR (18)
)

INSERT INTO ContentVersion_2000001_2100000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=2000001 and id_num <=2100000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_2000001_2100000'

CREATE TABLE ContentVersion_2100001_2200000
(
	ID NVARCHAR (18)
)

INSERT INTO ContentVersion_2100001_2200000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=2100001 and id_num <=2200000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_2100001_2200000'

CREATE TABLE ContentVersion_2200001_2300000
(
	ID NVARCHAR (18)
)

INSERT INTO ContentVersion_2200001_2300000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=2200001 and id_num <=2300000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_2200001_2300000'

CREATE TABLE ContentVersion_2300001_2400000
(
	ID NVARCHAR (18)
)

INSERT INTO ContentVersion_2300001_2400000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=2300001 and id_num <=2400000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_2300001_2400000'


CREATE TABLE ContentVersion_2400001_2500000
(
	ID NVARCHAR (18)
)

INSERT INTO ContentVersion_2400001_2500000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=2400001 and id_num <=2500000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_2400001_2500000'


CREATE TABLE ContentVersion_2500001_2700000
(
	ID NVARCHAR (18)
)

select * from ContentVersion_All

INSERT INTO ContentVersion_2500001_2700000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=2500001 and id_num <=2700000

EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_2500001_2700000'



INSERT INTO ContentVersion_All
SELECT ID
FROM ContentVersion
ORDER BY ID

INSERT INTO ContentVersion_1_800000
SELECT ID
FROM ContentVersion_All
WHERE id_num <=800000


INSERT INTO ContentVersion_800001_1600000
SELECT ID
FROM ContentVersion_All
WHERE id_num >=800001 and id_num<=1600000


INSERT INTO ContentVersion_1600001_2556037
SELECT ID
FROM ContentVersion_All
WHERE id_num >=1600001



EXEC SF_DownloadBlobs 'EDAPROD','ContentVersion_800001_1600000'

