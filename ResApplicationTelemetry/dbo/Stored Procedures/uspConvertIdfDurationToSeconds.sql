CREATE PROCEDURE dbo.[uspConvertIdfDurationToSeconds]
AS
BEGIN

DECLARE @asa_output_id INT, @page_view_duration VARCHAR(50), @video_play_duration VARCHAR(50)
DECLARE @page_view_duration_secs INT, @video_play_duration_secs INT

DECLARE AsaOutput_Cursor CURSOR FOR 
	select Id, PageViewDuration, VideoPlayDuration from InputIdfTelemetry where Processed = 3

OPEN AsaOutput_Cursor 

FETCH NEXT FROM AsaOutput_Cursor INTO
    @asa_output_id, @page_view_duration, @video_play_duration

	WHILE @@FETCH_STATUS = 0
	BEGIN
    
        SET @page_view_duration_secs = [dbo].[ufnGetIdfDurationInSeconds](@page_view_duration)
		SET @video_play_duration_secs = [dbo].[ufnGetIdfDurationInSeconds](@video_play_duration)

		UPDATE dbo.InputIdfTelemetry 
		SET VideoPlayDurationSecs = @video_play_duration_secs, PageViewDurationSecs = @page_view_duration_secs, Processed = 1
		WHERE Id = @asa_output_id

		FETCH NEXT FROM AsaOutput_Cursor INTO
        @asa_output_id, @page_view_duration, @video_play_duration

	END

	CLOSE AsaOutput_Cursor 
	DEALLOCATE AsaOutput_Cursor

END