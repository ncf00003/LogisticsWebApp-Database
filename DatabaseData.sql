USE LogisticsWebData
GO

--Insert Sample Users
INSERT INTO users (FirstName, LastName, Email, Password, ContactNumber, Address)
VALUES
('John', 'Doe', 'johndoe@example.com', 'password123', '123-456-7890', '123 Main St'),
('Jane', 'Smith', 'janesmith@example.com', 'password456', '987-654-3210', '456 Oak St'),
('Mike', 'Johnson', 'mikejohnson@example.com', 'password789', '555-555-5555', '789 Pine St');
GO

-- Insert sample vehicles
INSERT INTO vehicles (model, vin, plate, capacity, driverID)
VALUES
('Ford F-150', '1FTFW1ET4EFA94850', 'ABC1234', 1000, 1), 
('Toyota Tacoma', '3TMCZ5AN5KM304456', 'XYZ5678', 1200, 2),
('Chevrolet Silverado', '1GC1KWE80FF134503', 'LMN4321', 1500, 3);
GO

-- Insert sample locations
INSERT INTO locations (Address, City, State, Country, PostalCode)
VALUES
('123 Main St', 'New York', 'NY', 'US', '10001'),
('456 Oak St', 'Los Angeles', 'CA', 'US', '90001'),
('789 Pine St', 'Chicago', 'IL', 'US', '60601'),
('101 Maple St', 'Houston', 'TX', 'US', '77001'),
('202 Cedar St', 'Miami', 'FL', 'US', '33101');
GO

-- Insert sample routes
INSERT INTO routes (Origin, Destination, Distance)
VALUES
('New York', 'Los Angeles', 2451.5),
('Chicago', 'Miami', 1372.3),
('Houston', 'New York', 1628.5);
GO

-- Insert sample warehouses
INSERT INTO warehouses (capacity, CurrentStock, locationID)
VALUES
(2000.5, 500, 1),
(3000.0, 1500, 2),
(4000.0, 1000, 3);
GO

-- Insert sample shipments
INSERT INTO shipments (DeliveryDate, ShipmentType, Weight, Cost, userID, vehicleID, routeID, warehouseID, OriginLocationID, DestinationLocationID)
VALUES
('2024-10-01', 'Electronics', 500.25, 150.75, 1, 1, 1, 1, 1, 2),
('2024-10-02', 'Furniture', 1200.50, 350.00, 2, 2, 2, 2, 3, 4),
('2024-10-03', 'Clothing', 800.00, 200.00, 3, 3, 3, 3, 2, 5);
GO

-- Insert sample tracking
INSERT INTO tracking (Shipmentid, CurrentLocation, OrderDate, LastUpdated)
VALUES
(1, 'Los Angeles', '2024-09-30 08:00:00', '2024-10-01 12:00:00'),
(2, 'Miami', '2024-09-29 14:00:00', '2024-10-02 10:00:00'),
(3, 'Chicago', '2024-09-28 16:00:00', '2024-10-03 14:00:00');
GO