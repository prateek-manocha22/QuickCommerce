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
    CityID varchar(10) NOT NULL,

    Constraint fk_DS_City
    FOREIGN KEY (CityID)
    REFERENCES ActiveCities(CityID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- 3. For Customer Info : Customer ID, Customer Name, Phone number, mail id, Customer ratings, Customer City ID.

create table CustomerInfo(
    CustomerID varchar(20) primary key NOT NULL,
    CityID varchar(10) NOT NULL,
    CustomerName varchar(15) NOT NULL,
    PhoneNumber int NOT NULL,
    Ratings int,        -- 1/2/3/4/5.

    Constraint fk_Customer_City
    FOREIGN KEY (CityID)
    REFERENCES ActiveCities(CityID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- 4. Customer Adress : Customer ID, Adress ID, DARK STORE ID.

create table CustomerAdd(
    CustomerID varchar(20) NOT NULL,
    AddressID varchar(10) Primary Key NOT NULL,
    DarkStroreID varchar(10),

    Constraint fk_CusAdd_CusID
    FOREIGN KEY (CustomerID)
    REFERENCES CustomerInfo(CustomerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    Constraint fk_CusAdd_DSID
    FOREIGN KEY (DarkStroreID)
    REFERENCES DarkStores(DarkStroreID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- 5. Order details : Order ID, Customer ID, Dark Store ID, ADDRESS ID, Order initiated date, Order initiated time, price, discount on that perticular ORDER.

create table OrderDetails(
    OrderID varchar(10) Primary key NOT NULL,
    CustomerID varchar(20) Not null,
    DarkStroreID varchar(10) NOT NULL,
    OrderDate date NOT NULL,
    OrderTime time NOT NULL,
    AddressID varchar(10) NOT NULL,
    DelieverytID varchar(10) NOT NULL,

    Constraint fk_CusOrder_CusID
    FOREIGN KEY (CustomerID)
    REFERENCES CustomerInfo(CustomerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    Constraint fk_CusAdd_DSID_2
    FOREIGN KEY (DarkStroreID)
    REFERENCES DarkStores(DarkStroreID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    Constraint fk_Order_CusAdd
    FOREIGN KEY (AddressID)
    REFERENCES CustomerAdd(AddressID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- 5b. Product details : Product ID, product name, rarings, product status (in stock or out), price, discount applied, Number of peice in the pack, Refundable or non refundable, Arrival date and best before date.

create table ProductDetails(
    ProductID varchar(10) Primary key NOT NULL,
    ProductName varchar(50) Not null,
    ProductStatus varchar(15) NOT NULL,
    ProductStars int Default 5,                         -- I want the data inserted in the tables to be in the range 1-5, so i can't use between operator ?
    ProductPrice decimal(10, 4) Primary key NOT NULL,
    RefundStatus varchar(10) Not NULL,
);

-- 5c. Product availability in darkstores : ProductId, DarkstoreID (One product can obviously present in many darkstores)

craete table ProductAvail(
    ProductID varchar(10) NOT NULL,
    DarkStroreID varchar(10) NOT NULL,
    AvailStatus varchar(10) primary key. -- if not available then none otherwise not null (either just enter : 1)
);

-- 6 Order Items : Order ID, Product ID, Product quantity (the bridge between the table : OrderDetails and ProductDetails)

Create table OrderItems(
    OrderID varchar(10),
    ProductID varchar(10),
    ProductQuantity int NOT NULL,
    ProductPrice decimal(10, 4),
    AvailabilityStatus varchar(10) NOT NULL,

    Constraint fk_Item_Order
    FOREIGN KEY (OrderID)
    REFERENCES OrderDetails(OrderID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    Constraint fk_Item_Product
    FOREIGN KEY (ProductID)
    REFERENCES ProductDetails(ProductID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    Constraint fk_ItemPrize_Prize
    FOREIGN KEY (ProductPrice)
    REFERENCES ProductDetails(ProductPrice)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    Constraint fk_AvailItem_AvailStat
    FOREIGN KEY (AvailabilityStatus)
    REFERENCES ProductAvail(AvailStatus)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- 7. PostPaid details : cancelled, refunds, replace and returns.  (OPTIONAL TABLES)

-- 8. Discounts : Sale Discounts, Coupons, referal codes.   (OPTIONAL TABLES)

-- 9. Inventory : Product ID, DARK STORE ID,Name, quantity remaining, arrival date.

-- 10. Delievery partner details : partner Name, Partner ID, Ratings, Number of Delievery Handled.

Create table PartnerDetails (
    PartnerID varchar(10) Not NUll Primary key,
    PartnerName varchar(25) NOT NULL,
    PartnerRatings int NOT NULL,
    NumberOfDeievery int NOT NULL
);

-- 11. Delievery details : Delievery ID, Delievery partner ID, Delievery Status(Delievered or not), Order ID, Payment Status (Paid or not paid).

Create table DelieveryDetails(
    DelieverytID varchar(10) Primary Key NOT NULL,
    PartnerID varchar(10) NOT NULL,
    DelieveryStatus varchar(10) NOT NULL,
    OrderID varchar(10) NOT NULL,
    PaymentStatus varchar(10) NOT NULL,

    Constraint fk_delievery_partner
    FOREIGN KEY (PartnerID)
    REFERENCES PartnerDetails(PartnerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    Constraint fk_delievery_partner
    FOREIGN KEY (PartnerID)
    REFERENCES PartnerDetails(PartnerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    Constraint fk_delievery_Order
    FOREIGN KEY (OrderID)
    REFERENCES OrderDetails(OrderID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

Alter table OrderDetails ADD 
CONSTRAINT FK_ORDER_DELIEVERY
FOREIGN KEY (DelieverytID)
REFERENCES DelieveryDetails(DelieverytID); 