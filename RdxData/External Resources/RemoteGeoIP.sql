CREATE EXTERNAL DATA SOURCE [RemoteGeoIP]
    WITH (
    TYPE = RDBMS,
    LOCATION = N'lz83tiv9bx.database.windows.net',
    DATABASE_NAME = N'GeoIp',
    CREDENTIAL = [ElasticDBQueryCred]
    );

