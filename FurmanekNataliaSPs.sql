-- Required Everytime
USE LogisticsWebData
GO

--spUserDeliveryStatus 1: Find User Delivery Date 
Create proc spUserDelivery
@userid int,
@shipmentid int
AS 
	SELECT 
	U.Userid,
	-- concat and additional columns to look like an email response
	CONCAT (U.FirstName, ' ', U.LastName),
	S.OriginAddress,
	S.DestinationAddress,
	S.DeliveryDate,
	-- Something Fancy to determine delivered or in-route
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

GO


--Execute After Data is entered
/* 
EXEC spUserDeliveryStatus


*/

--spVehicleDrivers 2: Find all drivers based on a vehicle
