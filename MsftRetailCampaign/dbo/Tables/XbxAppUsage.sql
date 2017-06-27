CREATE TABLE [dbo].[XbxAppUsage] (
    [ID]                    BIGINT          IDENTITY (1, 1) NOT NULL,
    [DateLoaded]            DATETIME        DEFAULT (getdate()) NULL,
    [DateAdded]             DATETIME        NULL,
    [ReportDateID]          BIGINT          NULL,
    [ReportDate]            DATE            NULL,
    [ProductName]           VARCHAR (100)   NULL,
    [PackageFullName]       VARCHAR (150)   NULL,
    [StoreNumber]           INT             NULL,
    [RetailerLocation]      VARCHAR (100)   NULL,
    [Msa]                   VARCHAR (150)   NULL,
    [HardwareID]            VARCHAR (300)   NULL,
    [XboxTitleID]           BIGINT          NULL,
    [InFocusDurationSec]    DECIMAL (10, 3) NULL,
    [UserActiveDurationSec] DECIMAL (10, 3) NULL,
    [FriendlyAppType]       VARCHAR (50)    NULL,
    [Type]                  VARCHAR (50)    NULL,
    [IsAutoInstall]         BIT             NULL,
    [IsBackCompat]          BIT             NULL,
    CONSTRAINT [PK_XbxAppUsage_ID] PRIMARY KEY CLUSTERED ([ID] ASC)
);

