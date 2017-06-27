-- 06.26.2017 (MSRETEL-386): convert ip to integer

CREATE FUNCTION dbo.ufnIPAddressToInteger(@ip as varchar(15))
  RETURNS bigint
AS
  BEGIN
    RETURN (
      CONVERT(bigint, PARSENAME(@ip, 1)) +
      CONVERT(bigint, PARSENAME(@ip, 2)) * 256 +
      CONVERT(bigint, PARSENAME(@ip, 3)) * 65536 +
      CONVERT(bigint, PARSENAME(@ip, 4)) * 16777216
    )
  END