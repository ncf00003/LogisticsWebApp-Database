-- Required Everytime
USE LogisticsWebData
GO

--spUserDeliveryStatus 1: Find User Delivery Date 
Create proc spUserDelivery
@userid int,
@shipmentid int
AS 
BEGIN	
	SELECT 
	U.Userid,
	-- concat and additional columns to look like an email response
	CONCAT (U.FirstName, ' ', U.LastName),
	S.OriginAddress,
	S.DestinationAddress,
	S.DeliveryDate,
	-- Something Fancy to determine delivered or in-route
	-- Make sure these two fields match in the data entry
	CASE WHEN T.CurrentLocation = S.DestinationAddress  
	THEN 'Delivered'
	WHEN T.CurrentLocation != S.DestinationAddress
	THEN 'In-Route'
	END AS [Status],
	T.LastUpdated
	FROM dbo.users as U
	-- Inner join since there is no status without a shipment, proc is meant to be specific to a certain Delivery
	INNER JOIN dbo.shipments S on U.userid = S.userID 
	LEFT JOIN dbo.[tracking] T on S.Shipmentid = T.Shipmentid
	WHERE U.Userid = @userid and S.Shipmentid = @shipmentid
END
GO


--Execute After Data is entered
/* 
EXEC spUserDeliveryStatus
@userid int = '1',
@shipmentid = '1';

*/

--spVehicleDrivers 2: Find all drivers based on a vehicle
