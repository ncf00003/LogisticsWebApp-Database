-- Required Everytime
USE LogisticsWebData
GO

--spUserDeliveryStatus 1: Find User Delivery Date and Tracking Information 
Create proc spDeliveryTracking
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
	FROM dbo.users as U
	-- Inner join since there is no status without a shipment, proc is meant to be specific to a certain Delivery
	INNER JOIN dbo.shipments S on U.userid = S.userID 
	LEFT JOIN dbo.[tracking] T on S.Shipmentid = T.Shipmentid
	LEFT JOIN dbo.[routes] R on S.routeID = R.Routeid 
	WHERE U.Userid = @userid and S.Shipmentid = @shipmentid
END
GO


--Execute After Data is entered
/* 
EXEC spDeliveryTracking
@userid = '1',
@shipmentid = '1';
*/

--spVehicleDrivers 2: Find all drivers based on a vehicle
