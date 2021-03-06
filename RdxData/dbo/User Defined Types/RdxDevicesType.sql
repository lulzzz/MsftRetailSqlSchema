﻿CREATE TYPE [dbo].[RdxDevicesType] AS TABLE (
    [DeviceId]         VARCHAR (100) NULL,
    [DeviceIp]         VARCHAR (100) NULL,
    [OEMName]          VARCHAR (100) NULL,
    [OEMModel]         VARCHAR (100) NULL,
    [OEMSerialNumber]  VARCHAR (100) NULL,
    [DeviceModel]      VARCHAR (100) NULL,
    [OSVersionFull]    VARCHAR (100) NULL,
    [OSBranch]         VARCHAR (100) NULL,
    [OSBuildNumber]    VARCHAR (100) NULL,
    [OSInstallDate]    VARCHAR (100) NULL,
    [Latitude]         VARCHAR (100) NULL,
    [Longitude]        VARCHAR (100) NULL,
    [AccuracyKm]       VARCHAR (100) NULL,
    [Source]           VARCHAR (100) NULL,
    [FirstOnlineDate]  VARCHAR (100) NULL,
    [LastOnlineDate]   VARCHAR (100) NULL,
    [Retailer]         VARCHAR (100) NULL,
    [RAC]              VARCHAR (100) NULL,
    [SKU]              VARCHAR (100) NULL,
    [StoreId]          VARCHAR (100) NULL,
    [DeviceName]       VARCHAR (100) NULL,
    [MDC1DeviceFamily] VARCHAR (100) NULL,
    [MDC2FormFactor]   VARCHAR (100) NULL,
    [IsRetailPhone]    VARCHAR (100) NULL);

