--Choose Database
USE LogisticsWebData
GO

--spShipmentOrigin 5: Find all shipments based on shipment type
create proc ShipmentType
	@ShipmentType NVARCHAR(255)
AS
BEGIN
	--Select all shipments where the shipment type matches the input
	SELECT *
    FROM shipments
    WHERE ShipmentType = @ShipmentType;

	--Return message if no shipments are found with that shipment type
    IF @@ROWCOUNT = 0
    BEGIN
        PRINT 'No shipments found for the specified shipment type.';
    END
END
GO

/*
--Execute stored procedure after data is entered
EXEC ShipmentType 'Electronics';
*/






--Choose Database
USE LogisticsWebData
GO

--spNewVehicle 6: Add a new vehicle to the database
create proc NewVehicle
    @model NVARCHAR(255), 
    @vin VARCHAR(17), 
    @plate VARCHAR(8), 
    @capacity INT, 
    @driverID INT
AS
BEGIN
    --Inserts the values into their correct spots in the vehicle table
    INSERT INTO vehicles (model, vin, plate, capacity, driverID)
    VALUES (@model, @vin, @plate, @capacity, @driverID);
    
    --Return message that confirms the addition to the database
    PRINT 'New vehicle added.';
END
GO

/*
--Execute stored procedure after data is entered
EXEC NewVehicle 'Toyota Prius', 'JTEBU4BF3FK194556', 'ABC1234', 900, 4;
*/