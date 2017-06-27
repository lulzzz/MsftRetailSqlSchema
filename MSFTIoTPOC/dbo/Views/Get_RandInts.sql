CREATE VIEW Get_RandInts
AS
SELECT 
    ROUND(((3 - 1 -1) * RAND() + 1), 0) AS RandomInt1to2,
    ROUND(((4 - 1 -1) * RAND() + 1), 0) AS RandomInt1to3,
    ROUND(((5 - 1 -1) * RAND() + 1), 0) AS RandomInt1to4,
    ROUND(((6 - 1 -1) * RAND() + 1), 0) AS RandomInt1to5,
    ROUND(((7 - 1 -1) * RAND() + 1), 0) AS RandomInt1to6,
    ROUND(((8 - 1 -1) * RAND() + 1), 0) AS RandomInt1to7,
    ROUND(((9 - 1 -1) * RAND() + 1), 0) AS RandomInt1to8