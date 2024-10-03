use LogisticsWebData
GO

-- Find number of shipments in x warehouse
create or alter proc spSumShipmentsWarehouse
@warehouseid int 
AS
BEGIN
	SELECT w.warehouseid, sum(s.Shipmentid) AS 'Number of Shipments'
	FROM warehouses AS w
	INNER JOIN locations as l
	ON l.locationid = w.warehouseid
	INNER JOIN shipments AS s 
	ON w.warehouseid=s.warehouseID
	GROUP BY w.warehouseid
	HAVING w.warehouseid=@warehouseid
END
GO

exec spSumShipmentsWarehouse 1
GO