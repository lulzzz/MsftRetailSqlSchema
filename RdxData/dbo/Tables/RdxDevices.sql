CREATE TABLE [dbo].[RdxDevices] (
    [Id]               INT           IDENTITY (1, 1) NOT NULL,
    [DateAdded]        DATETIME      NULL,
    [DateUpdated]      DATETIME      NULL,
    [DeviceId]         VARCHAR (100) NOT NULL,
    [DeviceIp]         VARCHAR (100) NULL,
    [OEMName]          VARCHAR (100) NULL,
    [OEMModel]         VARCHAR (100) NULL,
    [OEMSerialNumber]  VARCHAR (100) NULL,
    [DeviceModel]      VARCHAR (100) NULL,
    [OSVersionFull]    VARCHAR (100) NULL,
    [OSBranch]         VARCHAR (100) NULL,
    [OSBuildNumber]    VARCHAR (100) NULL,
    [OSInstallDate]    VARCHAR (100) NULL,
    [OSOOBEDateTime]   DATETIME      NULL,
    [Latitude]         VARCHAR (100) NULL,
    [Longitude]        VARCHAR (100) NULL,
    [AccuracyKm]       VARCHAR (100) NULL,
    [Source]           VARCHAR (100) NULL,
    [FirstOnlineDate]  DATETIME      NULL,
    [LastOnlineDate]   DATETIME      NULL,
    [Retailer]         VARCHAR (100) NULL,
    [RAC]              VARCHAR (100) NULL,
    [SKU]              VARCHAR (100) NULL,
    [StoreId]          VARCHAR (100) NULL,
    [DeviceName]       VARCHAR (100) NULL,
    [MDC1DeviceFamily] VARCHAR (100) NULL,
    [MDC2FormFactor]   VARCHAR (100) NULL,
    [IsRetailPhone]    VARCHAR (100) NULL,
    [StoreNumber]      INT           NULL,
    [Processed]        INT           DEFAULT ((0)) NULL,
    CONSTRAINT [PK_RdxDevices_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_RdxDevices_StoreNumber]
    ON [dbo].[RdxDevices]([StoreNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RdxDevices_Processed]
    ON [dbo].[RdxDevices]([Processed] ASC);

