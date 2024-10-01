Create Database LogisticsWebData
GO
-- May want to run this in a seperate query before USING

-- Required Every Time  
Use LogisticsWebData
Go 

-- User table, generic information listed
-- Users is One-to-many with shipments, tracking, and notifications.
Create TABLE [users] (
  [userid] int PRIMARY KEY IDENTITY(1, 1),
  [FirstName] varchar(255),
  [LastName] varchar(255) NOT NULL,
  [Email] nvarchar(255) NOT NULL,
  [Password] nvarchar(255) NOT NULL,
  [ContactNumber] nvarchar(255) NOT NULL,
  [Address] nvarchar(255) NOT NULL,
)
GO

-- Keep track of trucks, vans, or other vehicles 
-- Vehicles One-to-many with routes and shipments
Create TABLE [vehicles] (
  [vehicleid] int PRIMARY KEY IDENTITY(1, 1),
  [model] nvarchar(255) NOT NULL,
  [vin] varchar(17) NOT NULL,
  [plate] varchar(8) NOT NULL,
  -- Based on max shipping container capacity should be in sqaure feet
  [capacity] int NOT NULL,
  [driverID] int NOT NULL,
  CONSTRAINT FK_Vehicle_Driver FOREIGN KEY (driverID) REFERENCES users(userid) -- Relationship with users (drivers)
)
GO

-- Record the route details for deliveries
-- One-to-many with shipments, vehicles
CREATE TABLE [routes] (
  [Routeid] int PRIMARY KEY IDENTITY(1, 1),
  [Origin] nvarchar(255) NOT NULL,
  [Destination] nvarchar(255) NOT NULL,
  [Distance] decimal(6,2) NOT NULL
)
GO

-- Store shipment details
-- shipments are One-to-many with vehicles and routes.
CREATE TABLE [shipments] (
  [Shipmentid] int PRIMARY KEY IDENTITY(1, 1),
  [OriginAddress] nvarchar(255) NOT NULL,
  [DestinationAddress] nvarchar(255) NOT NULL,
  [DeliveryDate] date,
  [ShipmentType] varchar(255),
  [Weight] decimal(6,2) NOT NULL,
  [Cost] decimal(6,2) NOT NULL
)
GO


--Store information about warehousing facilities.
--warehouses are One-to-many with shipments and inventory
CREATE TABLE [warehouses] (
  [warehouseid] int PRIMARY KEY IDENTITY(1, 1),
  [location] nvarchar(255) NOT NULL,
  [capacity] decimal(6,2) NOT NULL,
  [CurrentStock] int
) 
GO

--Store pickup and drop-off locations
--locations One-to-many with shipments and warehouses
CREATE TABLE [locations] (
  [locationid] int PRIMARY KEY IDENTITY(1, 1),
  [Address] nvarchar(255) NOT NULL,
  [City] varchar(255) NOT NULL,
  -- 2 varchar to use Abv. names
  [State] varchar(2) NOT NULL,
  [Country] varchar(2) NOT NULL,
  -- Can be 5 digit or hyphened and have 4 added numbers
  [PostalCode] nvarchar(10) NOT NULL
) 
GO


--tracking One-to-one with shipments
CREATE TABLE [tracking] (
  [trackingid] int PRIMARY KEY IDENTITY(1, 1),
  [Shipmentid] int NOT NULL UNIQUE,
  [CurrentLocation] nvarchar(255) NOT NULL,
  [OrderDate] datetime NOT NULL,
  [LastUpdated] datetime NOT NULL
) 
GO

-- Create joins after tables and attributes, easier for organization purposes. 

-- Alter the Vehicles table to add a foreign key relationship with users (drivers)
-- Drivers are users too
ALTER TABLE [vehicles]
ADD CONSTRAINT FK_Vehicle_Driver FOREIGN KEY ([driverID]) REFERENCES [users]([userid]);
GO

-- Alter the Shipments table to add foreign key relationships
ALTER TABLE [shipments]
ADD
    [userID] int NOT NULL,
    [vehicleID] int NOT NULL,
    [routeID] int NOT NULL;
-- Add foreign key constraints to the Shipments table
ALTER TABLE [shipments]
ADD CONSTRAINT FK_Shipment_User FOREIGN KEY ([userID]) REFERENCES [users]([userid]),
    CONSTRAINT FK_Shipment_Vehicle FOREIGN KEY ([vehicleID]) REFERENCES [vehicles]([vehicleid]),
    CONSTRAINT FK_Shipment_Route FOREIGN KEY ([routeID]) REFERENCES [routes]([routeid]);
GO

--Add relationship from Warehouse to location 
ALTER TABLE [warehouses]
ADD CONSTRAINT UQ_Warehouse_Location UNIQUE ([location]);
GO
--Alter the shipments table to add a warehouseID column
ALTER TABLE [shipments]
ADD [warehouseID] int;
GO
--Add a foreign key constraint linking shipments' OriginAddress to the location in warehouse
ALTER TABLE [shipments]
ADD CONSTRAINT FK_Shipment_Warehouse FOREIGN KEY ([warehouseID]) REFERENCES [warehouses]([warehouseid]);
GO


ALTER TABLE [shipments]
ADD [locationID] int; -- Add the foreign key column
GO
--Add a foreign key constraint linking shipments to locations
ALTER TABLE [shipments]
ADD CONSTRAINT FK_Shipment_Location FOREIGN KEY ([locationID]) REFERENCES [locations]([locationid]);
GO

--Alter the Warehouses table to add a foreign key to Locations
ALTER TABLE [warehouses]
ADD [locationID] int; -- Add the foreign key column
GO

--Add a foreign key constraint linking warehouses to locations
ALTER TABLE [warehouses]
ADD CONSTRAINT FK_Warehouse_Location FOREIGN KEY ([locationID]) REFERENCES [locations]([locationid]);
GO

-- Needs additional Update to bring schema into normal form: for all addresses to be uniform
