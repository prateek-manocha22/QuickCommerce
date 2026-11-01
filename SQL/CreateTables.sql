-- ALL the table related related queries to be written here in this file :

-- 1. For Company operating in cities : City ID, City name, State.

Create Table ActiveCities(
    CityID varchar(10) Primary KEY NOT NULL,
    CityName varchar(50),
    InState varchar(20)
);

-- 2. DarkStore Location : City ID, DARK STORE ID : Location inside sity (area / sector)(Format : DSXXX)

create table DarkStores(
    DarkStroreID varchar(10) Primary Key NOT NULL,
    CityID varchar(10) NOT NULL
);

-- 3. For Customer Info : Customer ID, Customer Name, Phone number, mail id, Customer ratings, Customer City ID.

create table CustomerInfo(
    CustomerID varchar(20) primary key not null,
    CityID varchar(10)
    CustomerName varchar(15) NOT NULL,
    PhoneNumber int NOT NULL,
    Ratings int,        -- 1/2/3/4/5.
);

-- 4. Customer Adress : Customer ID, Adress ID, DARK STORE ID.

create table CustomerAdd(
    CustomerID varchar(20),
    AddressID varchar(10) Primary Key NOT NULL,
    DarkStroreID varchar(10)
);

-- 5. Order details : Order ID, Customer ID, Dark Store ID, ADDRESS ID, Order initiated date, Order initiated time, price, discount on that perticular ORDER.

-- 5b Order Items : Order ID, Product ID, Product quantity

-- 6. Product details : Product ID, product name, rarings, product status (in stock or out), price, discount applied, Number of peice in the pack, Refundable or non refundable, Arrival date and best before date.

-- 7. PostPaid details : cancelled, refunds, replace and returns.  (OPTIONAL TABLES)

-- 8. Discounts : Sale Discounts, Coupons, referal codes.   (OPTIONAL TABLES)

-- 9. Inventory : Product ID, DARK STORE ID,Name, quantity remaining, arrival date.

-- 10. Delievery details : Delievery ID, Delievery partner ID, Delievery Status(Delievered or not), Order ID, Payment Status (Paid or not paid).

-- 11. Delievery partner details : partner Name, Partner ID, Ratings, Number of Delievery Handled.