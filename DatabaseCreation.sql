-- Create Database Script. (May want to run this chunk separate)
Create Database LogisticsWebData
GO

-- Required Every Time  
USE LogisticsWebData
GO 

-- User table
CREATE TABLE [users] (
  [userid] int PRIMARY KEY IDENTITY(1, 1),
  [FirstName] varchar(255),
  [LastName] varchar(255) NOT NULL,
  [Email] nvarchar(255) NOT NULL,
  [Password] nvarchar(255) NOT NULL,
  [ContactNumber] nvarchar(255) NOT NULL,
  [Address] nvarchar(255) NOT NULL
);
GO

-- Vehicles table
CREATE TABLE [vehicles] (
  [vehicleid] int PRIMARY KEY IDENTITY(1, 1),
  [model] nvarchar(255) NOT NULL,
  [vin] varchar(17) NOT NULL,
  [plate] varchar(8) NOT NULL,
  [capacity] int NOT NULL,
  [driverID] int NOT NULL,
  CONSTRAINT FK_Vehicle_Driver FOREIGN KEY ([driverID]) REFERENCES [users]([userid])
);
GO

-- Routes table
CREATE TABLE [routes] (
  [Routeid] int PRIMARY KEY IDENTITY(1, 1),
  [Origin] nvarchar(255) NOT NULL,
  [Destination] nvarchar(255) NOT NULL,
  [Distance] decimal(6,2) NOT NULL
);
GO

-- Locations table
CREATE TABLE [locations] (
  [locationid] int PRIMARY KEY IDENTITY(1, 1),
  [Address] nvarchar(255) NOT NULL,
  [City] varchar(255) NOT NULL,
  [State] varchar(2) NOT NULL,
  [Country] varchar(2) NOT NULL,
  [PostalCode] nvarchar(10) NOT NULL
);
GO

-- Warehouses table
CREATE TABLE [warehouses] (
  [warehouseid] int PRIMARY KEY IDENTITY(1, 1),
  [capacity] decimal(6,2) NOT NULL,
  [CurrentStock] int,
  [locationID] int NOT NULL,
  CONSTRAINT FK_Warehouse_Location FOREIGN KEY ([locationID]) REFERENCES [locations]([locationid])
);
GO

-- Shipments table
-- Main normalization effort and in line  relationships with Primary and Foriegn keys. 
CREATE TABLE [shipments] (
  [Shipmentid] int PRIMARY KEY IDENTITY(1, 1),
  [DeliveryDate] date,
  [ShipmentType] varchar(255),
  [Weight] decimal(6,2) NOT NULL,
  [Cost] decimal(6,2) NOT NULL,
  [userID] int NOT NULL,
  [vehicleID] int NOT NULL,
  [routeID] int NOT NULL,
  [warehouseID] int NOT NULL,
  [OriginLocationID] int NOT NULL,
  [DestinationLocationID] int NOT NULL,
  -- Connects users to shipments on UserID
  CONSTRAINT FK_Shipment_User FOREIGN KEY ([userID]) REFERENCES [users]([userid]),
  -- Connects shipments to vehicles on vehicleID
  CONSTRAINT FK_Shipment_Vehicle FOREIGN KEY ([vehicleID]) REFERENCES [vehicles]([vehicleid]),
  -- Connects shimpents to routes 
  CONSTRAINT FK_Shipment_Route FOREIGN KEY ([routeID]) REFERENCES [routes]([routeid]),
  -- Connects Shipments to warehouse
  CONSTRAINT FK_Shipment_Warehouse FOREIGN KEY ([warehouseID]) REFERENCES [warehouses]([warehouseid]),
  -- Connects to Location table (very important join for functionality)
  CONSTRAINT FK_Shipment_OriginLocation FOREIGN KEY ([OriginLocationID]) REFERENCES [locations]([locationid]),
  -- Different address must join on location seperately 
  CONSTRAINT FK_Shipment_DestinationLocation FOREIGN KEY ([DestinationLocationID]) REFERENCES [locations]([locationid])
);
GO

-- Tracking table
CREATE TABLE [tracking] (
  [trackingid] int PRIMARY KEY IDENTITY(1, 1),
  [Shipmentid] int NOT NULL UNIQUE,
  [CurrentLocation] nvarchar(255) NOT NULL,
  [OrderDate] datetime NOT NULL,
  [LastUpdated] datetime NOT NULL,
  CONSTRAINT FK_Tracking_Shipment FOREIGN KEY ([Shipmentid]) REFERENCES [shipments]([Shipmentid])
);
GO
