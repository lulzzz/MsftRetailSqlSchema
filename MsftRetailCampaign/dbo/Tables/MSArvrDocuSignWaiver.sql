CREATE TABLE [dbo].[MSArvrDocuSignWaiver] (
    [ID]                BIGINT           IDENTITY (1, 1) NOT NULL,
    [DateLoaded]        DATETIME         DEFAULT (getdate()) NULL,
    [CompletedDateTime] DATETIME         NULL,
    [CompletedDate]     DATE             NULL,
    [StoreNumber]       INT              NULL,
    [EnvelopeID]        UNIQUEIDENTIFIER NULL,
    [Experience]        VARCHAR (100)    NULL,
    CONSTRAINT [PK_MSArvrDocuSignWaiver_ID] PRIMARY KEY CLUSTERED ([ID] ASC)
);

