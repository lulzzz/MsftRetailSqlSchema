CREATE EXTERNAL DATA SOURCE [RemoteRedDb]
    WITH (
    TYPE = RDBMS,
    LOCATION = N'lz83tiv9bx.database.windows.net',
    DATABASE_NAME = N'MSFTIoTPOC',
    CREDENTIAL = [ElasticDBQueryCred]
    );

