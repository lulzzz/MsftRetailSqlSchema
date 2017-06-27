CREATE TABLE [dbo].[XbxAppUsage] (
    [Id]                    BIGINT          IDENTITY (1, 1) NOT NULL,
    [DateAdded]             DATETIME        DEFAULT (getdate()) NULL,
    [ReportDateId]          BIGINT          NULL,
    [ReportDate]            DATETIME        NULL,
    [ProductName]           VARCHAR (100)   NULL,
    [PakcageFullName]       VARCHAR (150)   NULL,
    [StoreNumber]           INT             NULL,
    [RetailerLocation]      VARCHAR (100)   NULL,
    [MSA]                   VARCHAR (150)   NULL,
    [HardwareId]            VARCHAR (300)   NULL,
    [XboxTitleId]           BIGINT          NULL,
    [InFocusDurationSec]    DECIMAL (10, 3) NULL,
    [UserActiveDurationSec] DECIMAL (10, 3) NULL,
    [FriendlyAppType]       VARCHAR (50)    NULL,
    [Type]                  VARCHAR (50)    NULL,
    [IsAutoInstall]         BIT             NULL,
    [IsBackCompat]          BIT             NULL,
    [AdfSliceIdentifier]    BINARY (32)     NULL,
    CONSTRAINT [PK_XboxAppUsage_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

