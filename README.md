# LogisticsWebApp-DataBase
### Company Statement
Now that we have a prototype web application, our Logistics firm needs to create a database. 
In doing so, we will be able to store users, tracking and route information referencable by our web app. 
<p> Additionally, having a database allows us to improve functionallity of our web application. Using back-end MySQL code helps us to improve the functionality of our front-end development. A seperate database improves security as well by not having our data easily accessible within our front-end code. </p>

### Stored Procedures and End User Actions
<strong> 1. spDeliveryTracking </strong>
<br> Description: Find User Delivery Date and Tracking Information with format similar to an order emails </br>
<p> Parameters: 
<br> • @userid 
<br> • @shipmentid int </p>

<strong> 2. spVehicleDrivers </strong>
<br> Description: Find all drivers based on a vehicle </br>
<p> Parameters: 
<br> • @vehicleid </p>

<strong> 3. sp(storedprocname) </strong>
<br> Description: </br>
<p> Parameters:
<br> • @() </p>

<strong> 4. sp(storedprocname) </strong>
<br> Description:  </br>
<p> Parameters: 
<br> • @() </p>

<strong> 5. sp(storedprocname) </strong>
<br> Description:  </br>
<p> Parameters: 
<br> • @() </p>

<strong> 6. sp(storedprocname) </strong>
<br> Description:  </br>
<p> Parameters: 
<br> • @() </p>

<strong> 7. sp(CreateUserProfile) </strong>
<br> Description: To create a profile or return a message if the profile already exists  </br>
<p> Parameters:
<br> • @(Firstname)
<br> • @(LastName)
<br> • @(Email)
<br> • @(Password)
<br> • @(ContactNumber)
<br> • @(Address) </p>

<strong> 8. sp(VerifyLogin) </strong>
<br> Description: To verify a users email and password to login to account  </br>
<p> Parameters: 
<br> • @(Email)
<br> • @(Password) </p>

# Collaborative Work
## Natalia Furmanek 
<strong>1. Create Database Tables </strong>
<br> Created tables using MySQL. <br>

<strong>2. Stored Procedures: 1 & 2 </strong>
<br>  • spDeliveryTracking </br>
 • spVehicleDrivers

<strong>3. Resources </strong>
<br> ChatGPT Used to Generate Table Ideas </br>
<p> Prompts Used: 
<br> "Ideas for logistics web app database" </br>
</p>

## Leonardo Cuellar
<strong>1. Update Database Tables </strong>
<br> Updated Table columns to add in joins in effort to normalize database. Added in data. </br>

<strong>2. Stored Procedures: 3 & 4 </strong>

<strong>3. Resources </strong>
<br> ChatGPT for Mock Data </br>
<p> Prompts Used: </p>

## Luke Chittenden
<strong>1. Stored Procedures: 5 & 6 </strong>
<br>  • spShipmentType </br>
 • spNewVehicle

<strong>2. Resources </strong>
<br> [W3 Schools](https://www.w3schools.com/sql/default.asp) </br>
ChatGPT
<p> Prompts Used:
<br> "Write a return message in sql server that lets the user know that there are no values found that match the input using the @@ROWCOUNT function"</br>
</p>

## Landen Riggleman
<strong>1. Stored Procedures: 7 & 8 </strong>
<br>  • spCreateUserProfile </br>
 • spVerifyLogin </br>
<strong>2. Resources </strong>
<br> ChatGPT used to check code for errors on stored procedures  </br>
<p> Prompts Used: "Please review the follwong sql stored procedure for mistakes" </p>
