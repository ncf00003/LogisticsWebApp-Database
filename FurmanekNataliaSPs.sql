-- Required Everytime
USE LogisticsWebData
GO

--spUserDeliveryStatus 1: Find User Delivery Date and Tracking Information 
Create or alter proc spDeliveryTracking
@userid int,
@shipmentid int
AS 
BEGIN	
	SELECT 
	-- concat and additional columns to look like an email response
	CONCAT (U.FirstName, ' ', U.LastName) as [User],
	T.OrderDate, 
	T.CurrentLocation,
	S.DeliveryDate,
	-- Something Fancy to determine delivered or in-route
	CASE WHEN T.CurrentLocation = R.Destination
	THEN 'Delivered'
	WHEN T.CurrentLocation != R.Destination
	THEN 'In-Route'
	END AS [Status],
	T.LastUpdated
	FROM dbo.users U
	-- Inner join since there is no status without a shipment, proc is meant to be specific to a certain Delivery
	INNER JOIN dbo.shipments S on U.userid = S.userID 
	LEFT JOIN dbo.[tracking] T on S.Shipmentid = T.Shipmentid
	LEFT JOIN dbo.[routes] R on S.routeID = R.Routeid 
	WHERE U.Userid = @userid and S.Shipmentid = @shipmentid
END
GO

--Execute After Data is entered
/* 
USE LogisticsWebData
GO

EXEC spDeliveryTracking
-- used = '1' out of habit, one would be more proper  
@userid = 1,
@shipmentid = 1;
GO
*/


-- Required Everytime - Added again for ease of testing
USE LogisticsWebData
GO
--spVehicleDrivers 2: Find all drivers based on a vehicle
CREATE or alter proc spVehicleDrivers
@vehicleid int
AS
BEGIN
	SELECT
	V.vehicleid,
	V.model,
	V.vin,
	V.plate,
	--CONCAT for display purposes
	CONCAT (U.FirstName, ' ', U.LastName) as [Driver]
	FROM 
	dbo.vehicles V
	-- JOIN to users on driverid as FK link - INNER Since id must match with a 'driver'
	INNER JOIN dbo.users U on V.driverID = U.userid
	WHERE V.vehicleid = @vehicleid
END
GO

-- rewrite use-go for quick testing
/* 
USE LogisticsWebData
GO

EXEC spVehicleDrivers
@vehicleid = 2;
GO
*/
