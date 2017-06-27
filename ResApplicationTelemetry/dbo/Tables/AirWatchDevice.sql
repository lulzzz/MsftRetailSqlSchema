CREATE TABLE [dbo].[AirWatchDevice] (
    [Id]              INT          IDENTITY (1, 1) NOT NULL,
    [ModifiedAt]      DATETIME     NULL,
    [CreatedAt]       DATETIME     NULL,
    [LastSeen]        DATETIME     NULL,
    [DeviceId]        INT          NULL,
    [Udid]            VARCHAR (50) NULL,
    [Imei]            VARCHAR (50) NULL,
    [SerialNumber]    VARCHAR (50) NULL,
    [IpAddress]       VARCHAR (50) NULL,
    [MacAddress]      VARCHAR (50) NULL,
    [AssetNumber]     VARCHAR (50) NULL,
    [OsPlatform]      VARCHAR (50) NULL,
    [Model]           VARCHAR (50) NULL,
    [OperatingSystem] VARCHAR (50) NULL,
    [WifiIPAddress]   VARCHAR (50) NULL,
    [WifiMacAddress]  VARCHAR (50) NULL,
    [Latitude]        VARCHAR (50) NULL,
    [Longitude]       VARCHAR (50) NULL,
    [UserName]        VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

