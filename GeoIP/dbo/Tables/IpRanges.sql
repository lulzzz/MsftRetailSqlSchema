CREATE TABLE [dbo].[IpRanges] (
    [IpRangeId]            UNIQUEIDENTIFIER NOT NULL,
    [CityId]               INT              NULL,
    [StoreId]              INT              DEFAULT ((0)) NOT NULL,
    [IpFrom]               NVARCHAR (15)    NOT NULL,
    [IpTo]                 NVARCHAR (15)    NOT NULL,
    [IpFrom_ZeroBased]     AS               ([dbo].[fn_GetZeroBasedIPv4]([IpFrom])),
    [IpTo_ZeroBased]       AS               ([dbo].[fn_GetZeroBasedIPv4]([IpTo])),
    [IpFrom_INT]           AS               (CONVERT([int],[dbo].[fn_GetBinaryIPv4]([NetworkId]))),
    [IpTo_INT]             AS               (CONVERT([int],[dbo].[fn_GetBinaryIPv4]([NetworkId]))),
    [IpFrom_ZeroBased_INT] AS               (CONVERT([int],[dbo].[fn_GetBinaryIPv4]([dbo].[fn_GetZeroBasedIPv4]([IpFrom])))),
    [IpTo_ZeroBased_INT]   AS               (CONVERT([int],[dbo].[fn_GetBinaryIPv4]([dbo].[fn_GetZeroBasedIPv4]([IpTo])))),
    [NetworkId]            NVARCHAR (15)    NULL,
    CONSTRAINT [PK_IpRanges] PRIMARY KEY CLUSTERED ([IpRangeId] ASC),
    CONSTRAINT [FK_IpRanges_Cities_CityId] FOREIGN KEY ([CityId]) REFERENCES [dbo].[Cities] ([CityId])
);

