Use LogisticsWebData
Go 

-- User table, generic information listed
-- One-to-many with shipments, tracking, and notifications.
CREATE TABLE [users] (
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
-- One-to-many with routes and shipments
CREATE TABLE [vehicles] (
  [vehicleid] int PRIMARY KEY IDENTITY(1, 1),
  [model] nvarchar(255) NOT NULL,
  [vin] varchar(17) NOT NULL,
  [plate] varchar(8) NOT NULL,
  -- Based on max shipping container capacity should be in sqaure feet
  [capacity] int NOT NULL,
  [driverID] int NOT NULL
)
GO

-- Store shipment details
-- One-to-many with vehicles, drivers, and routes.
CREATE TABLE [shipments] (
  [ShipmentID] int PRIMARY KEY IDENTITY(1, 1),
  [OriginAddress] nvarchar(255) NOT NULL,
  [DestinationAddress] nvarchar(255) NOT NULL,
  [DeliveryDate] date,
  [ShipmentType] varchar(255),
  [Weight] decimal(6,2) NOT NULL,
  [Cost] decimal(6,2) NOT NULL
)
GO

CREATE TABLE [routes] (
  [RouteID] int PRIMARY KEY IDENTITY(1, 1)
)
GO




/*
CREATE TABLE [ext_vehicle_trip] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [vehicle_id] int NOT NULL,
  [user_id] int NOT NULL,
  [department] nvarchar(255) NOT NULL,
  [travel_reason] nvarchar(255),
  [additional_travelers] nvarchar(255),
  [funding_source] nvarchar(255)
)
GO

CREATE TABLE [ext_vehicle_trip_info] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [trip_id] int NOT NULL,
  [type] int NOT NULL,
  [ts] datetime NOT NULL,
  [mileage] int NOT NULL,
  [fuel_gallons] decimal(6,3),
  [fuel_total_cost] decimal(6,2),
  [filepath] nvarchar(255)
)
GO

ALTER TABLE [ext_vehicle] ADD FOREIGN KEY ([org_id]) REFERENCES [ext_vehicle_org] ([id])
GO

ALTER TABLE [ext_vehicle_permissions] ADD FOREIGN KEY ([vehicle_id]) REFERENCES [ext_vehicle] ([id])
GO

ALTER TABLE [ext_vehicle_org_permissions] ADD FOREIGN KEY ([org_id]) REFERENCES [ext_vehicle_org] ([id])
GO

ALTER TABLE [ext_vehicle_trip] ADD FOREIGN KEY ([vehicle_id]) REFERENCES [ext_vehicle] ([id])
GO

ALTER TABLE [ext_vehicle_trip_info] ADD FOREIGN KEY ([trip_id]) REFERENCES [ext_vehicle_trip] ([id])
GO
*/