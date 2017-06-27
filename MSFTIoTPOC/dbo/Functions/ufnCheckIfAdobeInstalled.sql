-- MSRETEL-074 (10.03.2016): determines if adobe 2015 is installed on device 

CREATE FUNCTION [dbo].[ufnCheckIfAdobeInstalled] (@adobe_result INT, @adobe_version VARCHAR(50))
RETURNS INT
WITH EXECUTE AS CALLER
AS
BEGIN

/*
    - RED client agent checks if adobe is installed using the config file Win32_InstalledWin32Program_AdobePhotoshop2015.json
    - RED client agent only includes the adobe_result property in the telemetry message if adobe is NOT installed
		- if adobe_result is missing from the device telemetry, it could be one of two reasons:
			- adobe is installed on the device (adobe_result is not set if adobe IS installed)
			- RED client agent never processed the adobe config file ()
	- because we can't be 100% certain a missing adobe_result property indicates adobe is not installed, we have to also
	  check for a second property called adobe_version, which is ALWAYS set if adobe IS installed
	    - the conditional logic within this SQL function defines the adobe installation state
	- adobe_result (see 'RED Client Agent Specs' document for more information) can have one of three values:
	    - 1: No WMI records found (this error likely will never occur in WMI searches)
		- 2: No matching apps found in WMI search (if WMI query executes succesfully, but does not find adobe installed)
		- 4: A WMI exception was thrown while querying for the Adobe app
		- Note: if adobe_result is not set in the device telemetry, SQL defauts its value to 0 in the table DeviceMessage
	-- @adobe_installed (the return parameter) can be one of three values:
	    - NULL : RED client agent never received config file Win32_InstalledWin32Program_AdobePhotoshop2015.json
	    - 1    : installed
		- 2    : not installed
*/

	DECLARE @adobe_installed INT = NULL --default to not installed

	--if the @adobe_version was found, then we know adobe is installed
	If ((@adobe_result = 0) AND (@adobe_version IS NOT NULL))
	    SET @adobe_installed = 1
	--if the red client agent returned a status result code of 2, then we know adobe was not found 
	ELSE IF (@adobe_result = 2)
	    SET @adobe_installed = 2

	RETURN @adobe_installed;

END;