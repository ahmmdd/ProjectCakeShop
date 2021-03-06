USE [master]
GO
/****** Object:  Database [BalloonShop]    Script Date: 2015-12-17 2:06:36 PM ******/
CREATE DATABASE [BalloonShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BalloonShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BalloonShop.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BalloonShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BalloonShop_log.ldf' , SIZE = 1088KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BalloonShop] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BalloonShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BalloonShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BalloonShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BalloonShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BalloonShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BalloonShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [BalloonShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BalloonShop] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [BalloonShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BalloonShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BalloonShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BalloonShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BalloonShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BalloonShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BalloonShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BalloonShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BalloonShop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BalloonShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BalloonShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BalloonShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BalloonShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BalloonShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BalloonShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BalloonShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BalloonShop] SET RECOVERY FULL 
GO
ALTER DATABASE [BalloonShop] SET  MULTI_USER 
GO
ALTER DATABASE [BalloonShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BalloonShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BalloonShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BalloonShop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'BalloonShop', N'ON'
GO
USE [BalloonShop]
GO
/****** Object:  FullTextCatalog [BalloonShopFullText]    Script Date: 2015-12-17 2:06:36 PM ******/
CREATE FULLTEXT CATALOG [BalloonShopFullText]WITH ACCENT_SENSITIVITY = ON
AS DEFAULT

GO
/****** Object:  StoredProcedure [dbo].[CatalogAddDepartment]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogAddDepartment]
(@DepartmentName nvarchar(50),
@DepartmentDescription nvarchar(1000))
AS
INSERT INTO Department (Name, Description)
VALUES (@DepartmentName, @DepartmentDescription)


GO
/****** Object:  StoredProcedure [dbo].[CatalogAssignProductToCategory]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogAssignProductToCategory]
(@ProductID int, @CategoryID int)
AS
INSERT INTO ProductCategory (ProductID, CategoryID)
VALUES (@ProductID, @CategoryID)


GO
/****** Object:  StoredProcedure [dbo].[CatalogCreateCategory]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogCreateCategory]
(@DepartmentID int,
@CategoryName nvarchar(50),
@CategoryDescription nvarchar(50))
AS
INSERT INTO Category (DepartmentID, Name, Description)
VALUES (@DepartmentID, @CategoryName, @CategoryDescription)


GO
/****** Object:  StoredProcedure [dbo].[CatalogCreateProduct]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogCreateProduct]
(@CategoryID INT,
 @ProductName NVARCHAR(50),
 @ProductDescription NVARCHAR(MAX),
 @Price MONEY,
 @Thumbnail NVARCHAR(50),
 @Image NVARCHAR(50),
 @PromoFront BIT,
 @PromoDept BIT)
AS
-- Declare a variable to hold the generated product ID
DECLARE @ProductID int
-- Create the new product entry

INSERT INTO Product 
    (Name, 
     Description, 
     Price, 
     Thumbnail, 
     Image,
     PromoFront, 
     PromoDept)
VALUES 
    (@ProductName, 
     @ProductDescription, 
     @Price, 
     @Thumbnail, 
     @Image,
     @PromoFront, 
     @PromoDept)
-- Save the generated product ID to a variable
SELECT @ProductID = @@Identity
-- Associate the product with a category
INSERT INTO ProductCategory (ProductID, CategoryID)
VALUES (@ProductID, @CategoryID)


GO
/****** Object:  StoredProcedure [dbo].[CatalogDeleteCategory]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogDeleteCategory]
(@CategoryID int)
AS
DELETE FROM Category
WHERE CategoryID = @CategoryID


GO
/****** Object:  StoredProcedure [dbo].[CatalogDeleteDepartment]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogDeleteDepartment]
(@DepartmentID int)
AS
DELETE FROM Department
WHERE DepartmentID = @DepartmentID


GO
/****** Object:  StoredProcedure [dbo].[CatalogDeleteProduct]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogDeleteProduct]
(@ProductID int)
AS
DELETE FROM ShoppingCart WHERE ProductID=@ProductID
DELETE FROM ProductCategory WHERE ProductID=@ProductID
DELETE FROM Product where ProductID=@ProductID


GO
/****** Object:  StoredProcedure [dbo].[CatalogGetAllProductsInCategory]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetAllProductsInCategory]
(@CategoryID INT)
AS
SELECT Product.ProductID, Name, Description, Price, Thumbnail, 
       Image, PromoDept, PromoFront
FROM Product INNER JOIN ProductCategory
  ON Product.ProductID = ProductCategory.ProductID
WHERE ProductCategory.CategoryID = @CategoryID


GO
/****** Object:  StoredProcedure [dbo].[CatalogGetCategoriesInDepartment]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--missing procedures from 05-07


CREATE PROCEDURE [dbo].[CatalogGetCategoriesInDepartment]
(@DepartmentID INT)
AS
SELECT CategoryID, Name, Description
FROM Category
WHERE DepartmentID = @DepartmentID


GO
/****** Object:  StoredProcedure [dbo].[CatalogGetCategoriesWithoutProduct]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetCategoriesWithoutProduct]
(@ProductID int)
AS
SELECT CategoryID, Name
FROM Category
WHERE CategoryID NOT IN
   (SELECT Category.CategoryID
    FROM Category INNER JOIN ProductCategory
    ON Category.CategoryID = ProductCategory.CategoryID
    WHERE ProductCategory.ProductID = @ProductID)


GO
/****** Object:  StoredProcedure [dbo].[CatalogGetCategoriesWithProduct]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetCategoriesWithProduct]
(@ProductID int)
AS
SELECT Category.CategoryID, Name
FROM Category INNER JOIN ProductCategory
ON Category.CategoryID = ProductCategory.CategoryID
WHERE ProductCategory.ProductID = @ProductID


GO
/****** Object:  StoredProcedure [dbo].[CatalogGetCategoryDetails]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetCategoryDetails]
(@CategoryID INT)
AS
SELECT DepartmentID, Name, Description
FROM Category
WHERE CategoryID = @CategoryID


GO
/****** Object:  StoredProcedure [dbo].[CatalogGetDepartmentDetails]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetDepartmentDetails]
(@DepartmentID INT)
AS
SELECT Name, Description
FROM Department
WHERE DepartmentID = @DepartmentID


GO
/****** Object:  StoredProcedure [dbo].[CatalogGetDepartments]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetDepartments] AS
SELECT DepartmentID, Name, Description
FROM Department


GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductAttributeValues]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create CatalogGetProductAttributeValues stored procedure
CREATE PROCEDURE [dbo].[CatalogGetProductAttributeValues]
(@ProductId INT)
AS
SELECT a.Name AS AttributeName,
       av.AttributeValueID, 
       av.Value AS AttributeValue
FROM AttributeValue av
INNER JOIN attribute a ON av.AttributeID = a.AttributeID
WHERE av.AttributeValueID IN
  (SELECT AttributeValueID
   FROM ProductAttributeValue
   WHERE ProductID = @ProductID)
ORDER BY a.Name;


GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductDetails]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetProductDetails]
(@ProductID INT)
AS
SELECT Name, Description, Price, Thumbnail, Image, PromoFront, PromoDept
FROM Product
WHERE ProductID = @ProductID


GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductRecommendations]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CatalogGetProductRecommendations]
(@ProductID INT,
@DescriptionLength INT)
AS
SELECT ProductID,
Name,
CASE WHEN LEN(Description) <= @DescriptionLength THEN Description
ELSE SUBSTRING(Description, 1, @DescriptionLength) + '...' END
AS Description
FROM Product
WHERE ProductID IN
(
SELECT TOP 5 od2.ProductID
FROM OrderDetail od1
JOIN OrderDetail od2 ON od1.OrderID = od2.OrderID
WHERE od1.ProductID = @ProductID AND od2.ProductID != @ProductID
GROUP BY od2.ProductID
ORDER BY COUNT(od2.ProductID) DESC
)


GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductsInCategory]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetProductsInCategory]
(@CategoryID INT,
@DescriptionLength INT,
@PageNumber INT,
@ProductsPerPage INT,
@HowManyProducts INT OUTPUT)
AS

-- declare a new TABLE variable
DECLARE @Products TABLE
(RowNumber INT,
 ProductID INT,
 Name NVARCHAR(50),
 Description NVARCHAR(MAX),
 Price MONEY,
 Thumbnail NVARCHAR(50),
 Image NVARCHAR(50),
 PromoFront bit,
 PromoDept bit)


-- populate the table variable with the complete list of products
INSERT INTO @Products
SELECT ROW_NUMBER() OVER (ORDER BY Product.ProductID),
       Product.ProductID, Name,
       CASE WHEN LEN(Description) <= @DescriptionLength THEN Description 
            ELSE SUBSTRING(Description, 1, @DescriptionLength) + '...' END 
       AS Description, Price, Thumbnail, Image, PromoFront, PromoDept 
FROM Product INNER JOIN ProductCategory
  ON Product.ProductID = ProductCategory.ProductID
WHERE ProductCategory.CategoryID = @CategoryID

-- return the total number of products using an OUTPUT variable
SELECT @HowManyProducts = COUNT(ProductID) FROM @Products

-- extract the requested page of products
SELECT ProductID, Name, Description, Price, Thumbnail,
       Image, PromoFront, PromoDept
FROM @Products
WHERE RowNumber > (@PageNumber - 1) * @ProductsPerPage
  AND RowNumber <= @PageNumber * @ProductsPerPage


GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductsOnDeptPromo]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetProductsOnDeptPromo]
(@DepartmentID INT,
@DescriptionLength INT,
@PageNumber INT,
@ProductsPerPage INT,
@HowManyProducts INT OUTPUT)
AS

-- declare a new TABLE variable
DECLARE @Products TABLE
(RowNumber INT,
 ProductID INT,
 Name NVARCHAR(50),
 Description NVARCHAR(MAX),
 Price MONEY,
 Thumbnail NVARCHAR(50),
 Image NVARCHAR(50),
 PromoFront bit,
 PromoDept bit)

-- populate the table variable with the complete list of products
INSERT INTO @Products
SELECT ROW_NUMBER() OVER (ORDER BY ProductID) AS Row,
       ProductID, Name, SUBSTRING(Description, 1, @DescriptionLength)
+ '...' AS Description,
       Price, Thumbnail, Image, PromoFront, PromoDept
FROM
(SELECT DISTINCT Product.ProductID, Product.Name,
       CASE WHEN LEN(Product.Description) <= @DescriptionLength 
            THEN Product.Description 
            ELSE SUBSTRING(Product.Description, 1, @DescriptionLength) + '...' END 
       AS Description, Price, Thumbnail, Image, PromoFront, PromoDept 
  FROM Product INNER JOIN ProductCategory
                      ON Product.ProductID = ProductCategory.ProductID
              INNER JOIN Category
                      ON ProductCategory.CategoryID = Category.CategoryID
  WHERE Product.PromoDept = 1
   AND Category.DepartmentID = @DepartmentID
) AS ProductOnDepPr

-- return the total number of products using an OUTPUT variable
SELECT @HowManyProducts = COUNT(ProductID) FROM @Products

-- extract the requested page of products
SELECT ProductID, Name, Description, Price, Thumbnail,
       Image, PromoFront, PromoDept
FROM @Products
WHERE RowNumber > (@PageNumber - 1) * @ProductsPerPage
  AND RowNumber <= @PageNumber * @ProductsPerPage


GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductsOnFrontPromo]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetProductsOnFrontPromo]
(@DescriptionLength INT,
@PageNumber INT,
@ProductsPerPage INT,
@HowManyProducts INT OUTPUT)
AS

-- declare a new TABLE variable
DECLARE @Products TABLE
(RowNumber INT,
 ProductID INT,
 Name NVARCHAR(50),
 Description NVARCHAR(MAX),
 Price MONEY,
 Thumbnail NVARCHAR(50),
 Image NVARCHAR(50),
 PromoFront bit,
 PromoDept bit)


-- populate the table variable with the complete list of products
INSERT INTO @Products
SELECT ROW_NUMBER() OVER (ORDER BY Product.ProductID),
       ProductID, Name,
       CASE WHEN LEN(Description) <= @DescriptionLength THEN Description 
            ELSE SUBSTRING(Description, 1, @DescriptionLength) + '...' END 
       AS Description, Price, Thumbnail, Image, PromoFront, PromoDept
FROM Product
WHERE PromoFront = 1

-- return the total number of products using an OUTPUT variable
SELECT @HowManyProducts = COUNT(ProductID) FROM @Products

-- extract the requested page of products
SELECT ProductID, Name, Description, Price, Thumbnail,
       Image, PromoFront, PromoDept
FROM @Products
WHERE RowNumber > (@PageNumber - 1) * @ProductsPerPage
  AND RowNumber <= @PageNumber * @ProductsPerPage


GO
/****** Object:  StoredProcedure [dbo].[CatalogMoveProductToCategory]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogMoveProductToCategory]
(@ProductID int, @OldCategoryID int, @NewCategoryID int)
AS
UPDATE ProductCategory
SET CategoryID = @NewCategoryID
WHERE CategoryID = @OldCategoryID
  AND ProductID = @ProductID


GO
/****** Object:  StoredProcedure [dbo].[CatalogRemoveProductFromCategory]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogRemoveProductFromCategory]
(@ProductID int, @CategoryID int)
AS
DELETE FROM ProductCategory
WHERE CategoryID = @CategoryID AND ProductID = @ProductID


GO
/****** Object:  StoredProcedure [dbo].[CatalogUpdateCategory]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogUpdateCategory]
(@CategoryID int,
@CategoryName nvarchar(50),
@CategoryDescription nvarchar(1000))
AS
UPDATE Category
SET Name = @CategoryName, Description = @CategoryDescription
WHERE CategoryID = @CategoryID


GO
/****** Object:  StoredProcedure [dbo].[CatalogUpdateDepartment]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogUpdateDepartment]
(@DepartmentID int,
@DepartmentName nvarchar(50),
@DepartmentDescription nvarchar(1000))
AS
UPDATE Department
SET Name = @DepartmentName, Description = @DepartmentDescription
WHERE DepartmentID = @DepartmentID


GO
/****** Object:  StoredProcedure [dbo].[CatalogUpdateProduct]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogUpdateProduct]
(@ProductID INT,
 @ProductName VARCHAR(50),
 @ProductDescription VARCHAR(5000),
 @Price MONEY,
 @Thumbnail VARCHAR(50),
 @Image VARCHAR(50),
 @PromoFront BIT,
 @PromoDept BIT)
AS
UPDATE Product
SET Name = @ProductName,
    Description = @ProductDescription,
    Price = @Price,
    Thumbnail = @Thumbnail,
    Image = @Image,
    PromoFront = @PromoFront,
    PromoDept = @PromoDept
WHERE ProductID = @ProductID


GO
/****** Object:  StoredProcedure [dbo].[CreateOrder]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateOrder] 
(@CartID char(36))
AS
/* Insert a new record INTo Orders */
DECLARE @OrderID INT
INSERT INTO Orders DEFAULT VALUES
/* Save the new Order ID */
SET @OrderID = @@IDENTITY
/* Add the order details to OrderDetail */
INSERT INTO OrderDetail 
     (OrderID, ProductID, ProductName, Quantity, UnitCost)
SELECT 
     @OrderID, Product.ProductID, Product.Name, 
     ShoppingCart.Quantity, Product.Price
FROM Product JOIN ShoppingCart
ON Product.ProductID = ShoppingCart.ProductID
WHERE ShoppingCart.CartID = @CartID
/* Clear the shopping cart */
DELETE FROM ShoppingCart
WHERE CartID = @CartID
/* Return the Order ID */
SELECT @OrderID


GO
/****** Object:  StoredProcedure [dbo].[CustomerAnalysis]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[CustomerAnalysis]
as
SELECT Region,ShippingAddress,DateCreated,DateShipped,ProductName, UnitCost, Quantity, Thumbnail
FROM    OrderDetail
INNER JOIN Orders ON Orders.OrderID = OrderDetail.OrderID
INNER JOIN Product ON Product.ProductID = OrderDetail.ProductID
GROUP BY Region,ShippingAddress,DateCreated,DateShipped,ProductName, UnitCost, Quantity,Thumbnail
ORDER BY Region DESC;

GO
/****** Object:  StoredProcedure [dbo].[Favorite]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Favorite]
as
SELECT  ProductName,description,Price, Quantity
FROM    OrderDetail
INNER JOIN Product ON Product.ProductID = OrderDetail.ProductID
WHERE   Quantity  >  (SELECT AVG(Quantity) FROM OrderDetail)
GROUP BY ProductName,description,price,Quantity
ORDER BY Quantity DESC

;

GO
/****** Object:  StoredProcedure [dbo].[GetShoppingCartRecommendations]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetShoppingCartRecommendations]
(@CartID CHAR(36),
 @DescriptionLength INT)
AS
--- Returns the product recommendations
SELECT ProductID,
       Name,
       SUBSTRING(Description, 1, @DescriptionLength) + '...' AS Description
FROM Product
WHERE ProductID IN
   (
   -- Returns the products that exist in a list of orders
   SELECT TOP 5 od1.ProductID AS Rank
   FROM OrderDetail od1 
     JOIN OrderDetail od2
       ON od1.OrderID=od2.OrderID
     JOIN ShoppingCart sp
       ON od2.ProductID = sp.ProductID
   WHERE sp.CartID = @CartID
        -- Must not include products that already exist in the visitor''s cart
      AND od1.ProductID NOT IN
      (
      -- Returns the products in the specified shopping cart
      SELECT ProductID 
      FROM ShoppingCart
      WHERE CartID = @CartID
      )
   -- Group the ProductID so we can calculate the rank
   GROUP BY od1.ProductID
   -- Order descending by rank
   ORDER BY COUNT(od1.ProductID) DESC
   )


GO
/****** Object:  StoredProcedure [dbo].[LoyalCustomer]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[LoyalCustomer]
as
SELECT CustomerName,ShippingAddress,ProductName,DateCreated, Subtotal,Thumbnail
FROM    OrderDetail
INNER JOIN Orders ON Orders.OrderID = OrderDetail.OrderID
INNER JOIN Product ON Product.ProductID = OrderDetail.ProductID
GROUP BY CustomerName,ShippingAddress,ProductName,DateCreated, Subtotal,Thumbnail;

GO
/****** Object:  StoredProcedure [dbo].[maxQuantity]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[maxQuantity]
as
SELECT ProductName,  max(Quantity) as maxQuantities
FROM OrderDetail
INNER JOIN Product ON Product.ProductID = OrderDetail.ProductID
GROUP BY ProductName order by maxQuantities desc;

GO
/****** Object:  StoredProcedure [dbo].[maxSales]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[maxSales]
as
SELECT ProductName, description,Price, max(Quantity) as maxQuantities, Thumbnail
FROM OrderDetail
INNER JOIN Product ON Product.ProductID = OrderDetail.ProductID
GROUP BY ProductName,description,price,Thumbnail order by maxQuantities desc;

GO
/****** Object:  StoredProcedure [dbo].[OrderGetDetails]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderGetDetails]
(@OrderID INT)
AS
SELECT Orders.OrderID, 
       ProductID, 
       ProductName, 
       Quantity, 
       UnitCost, 
       Subtotal
FROM OrderDetail JOIN Orders
ON Orders.OrderID = OrderDetail.OrderID
WHERE Orders.OrderID = @OrderID


GO
/****** Object:  StoredProcedure [dbo].[OrderGetInfo]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderGetInfo]
(@OrderID INT)
AS
SELECT OrderID, 
      (SELECT ISNULL(SUM(Subtotal), 0) FROM OrderDetail WHERE OrderID = @OrderID)        
       AS TotalAmount, 
       DateCreated, 
       DateShipped, 
       Verified, 
       Completed, 
       Canceled, 
       Comments, 
       CustomerName, 
       ShippingAddress, 
       CustomerEmail
FROM Orders
WHERE OrderID = @OrderID


GO
/****** Object:  StoredProcedure [dbo].[OrderMarkCanceled]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderMarkCanceled]
(@OrderID INT)
AS
UPDATE Orders
SET Canceled = 1
WHERE OrderID = @OrderID


GO
/****** Object:  StoredProcedure [dbo].[OrderMarkCompleted]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderMarkCompleted]
(@OrderID INT)
AS
UPDATE Orders
SET Completed = 1,
    DateShipped = GETDATE()
WHERE OrderID = @OrderID


GO
/****** Object:  StoredProcedure [dbo].[OrderMarkVerified]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderMarkVerified]
(@OrderID INT)
AS
UPDATE Orders
SET Verified = 1
WHERE OrderID = @OrderID


GO
/****** Object:  StoredProcedure [dbo].[OrdersGetByDate]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrdersGetByDate] 
(@StartDate SMALLDATETIME,
 @EndDate SMALLDATETIME)
AS
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
WHERE DateCreated BETWEEN @StartDate AND @EndDate
ORDER BY DateCreated DESC


GO
/****** Object:  StoredProcedure [dbo].[OrdersGetByRecent]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrdersGetByRecent] 
(@Count smallINT)
AS
-- Set the number of rows to be returned
SET ROWCOUNT @Count
-- Get list of orders
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
ORDER BY DateCreated DESC
-- Reset rowcount value
SET ROWCOUNT 0


GO
/****** Object:  StoredProcedure [dbo].[OrdersGetUnverifiedUncanceled]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrdersGetUnverifiedUncanceled]
AS
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
WHERE Verified=0 AND Canceled=0
ORDER BY DateCreated DESC


GO
/****** Object:  StoredProcedure [dbo].[OrdersGetVerifiedUncompleted]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrdersGetVerifiedUncompleted]
AS
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
WHERE Verified=1 AND Completed=0
ORDER BY DateCreated DESC


GO
/****** Object:  StoredProcedure [dbo].[OrderUpdate]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderUpdate]
(@OrderID INT,
 @DateCreated SMALLDATETIME,
 @DateShipped SMALLDATETIME = NULL,
 @Verified BIT,
 @Completed BIT,
 @Canceled BIT,
 @Comments VARCHAR(200),
 @CustomerName VARCHAR(50),
 @ShippingAddress VARCHAR(200),
 @CustomerEmail VARCHAR(50))
AS
UPDATE Orders
SET DateCreated=@DateCreated,
    DateShipped=@DateShipped,
    Verified=@Verified,
    Completed=@Completed,
    Canceled=@Canceled,
    Comments=@Comments,
    CustomerName=@CustomerName,
    ShippingAddress=@ShippingAddress,
    CustomerEmail=@CustomerEmail
WHERE OrderID = @OrderID


GO
/****** Object:  StoredProcedure [dbo].[SearchCatalog]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SearchCatalog] 
(@DescriptionLength INT,
 @PageNumber TINYINT,
 @ProductsPerPage TINYINT,
 @HowManyResults INT OUTPUT,
 @AllWords BIT,
 @Word1 NVARCHAR(15) = NULL,
 @Word2 NVARCHAR(15) = NULL,
 @Word3 NVARCHAR(15) = NULL,
 @Word4 NVARCHAR(15) = NULL,
 @Word5 NVARCHAR(15) = NULL)
AS

/* @NecessaryMatches needs to be 1 for any-word searches and
   the number of words for all-words searches */
DECLARE @NecessaryMatches INT
SET @NecessaryMatches = 1
IF @AllWords = 1 
  SET @NecessaryMatches =
    CASE WHEN @Word1 IS NULL THEN 0 ELSE 1 END + 
    CASE WHEN @Word2 IS NULL THEN 0 ELSE 1 END + 
    CASE WHEN @Word3 IS NULL THEN 0 ELSE 1 END +
    CASE WHEN @Word4 IS NULL THEN 0 ELSE 1 END +
    CASE WHEN @Word5 IS NULL THEN 0 ELSE 1 END;

/* Create the table variable that will contain the search results */
DECLARE @Matches TABLE
([Key] INT NOT NULL,
 Rank INT NOT NULL)

-- Save matches for the first word
IF @Word1 IS NOT NULL
  INSERT INTO @Matches
  EXEC SearchWord @Word1

-- Save the matches for the second word
IF @Word2 IS NOT NULL
  INSERT INTO @Matches
  EXEC SearchWord @Word2

-- Save the matches for the third word
IF @Word3 IS NOT NULL
  INSERT INTO @Matches
  EXEC SearchWord @Word3

-- Save the matches for the fourth word
IF @Word4 IS NOT NULL
  INSERT INTO @Matches
  EXEC SearchWord @Word4

-- Save the matches for the fifth word
IF @Word5 IS NOT NULL
  INSERT INTO @Matches
  EXEC SearchWord @Word5

-- Calculate the IDs of the matching products
DECLARE @Results TABLE
(RowNumber INT,
 [KEY] INT NOT NULL,
 Rank INT NOT NULL)

-- Obtain the matching products 
INSERT INTO @Results
SELECT ROW_NUMBER() OVER (ORDER BY COUNT(M.Rank) DESC),
       M.[KEY], SUM(M.Rank) AS TotalRank
FROM @Matches M
GROUP BY M.[KEY]
HAVING COUNT(M.Rank) >= @NecessaryMatches

-- return the total number of results using an OUTPUT variable
SELECT @HowManyResults = COUNT(*) FROM @Results

-- populate the table variable with the complete list of products
SELECT Product.ProductID, Name,
       CASE WHEN LEN(Description) <= @DescriptionLength THEN Description 
            ELSE SUBSTRING(Description, 1, @DescriptionLength) + '...' END 
       AS Description, Price, Thumbnail, Image, PromoFront, PromoDept 
FROM Product 
INNER JOIN @Results R
ON Product.ProductID = R.[KEY]
WHERE R.RowNumber > (@PageNumber - 1) * @ProductsPerPage
  AND R.RowNumber <= @PageNumber * @ProductsPerPage
ORDER BY R.Rank DESC


GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartAddItem]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[ShoppingCartAddItem]
(@CartID char(36),
 @ProductID int,
 @Attributes nvarchar(1000))
AS
IF EXISTS
        (SELECT CartID
         FROM ShoppingCart
         WHERE ProductID = @ProductID AND CartID = @CartID)
    UPDATE ShoppingCart
    SET Quantity = Quantity + 1
    WHERE ProductID = @ProductID AND CartID = @CartID
ELSE
    IF EXISTS (SELECT Name FROM Product WHERE ProductID=@ProductID)
        INSERT INTO ShoppingCart (CartID, ProductID, Attributes, Quantity, DateAdded)
        VALUES (@CartID, @ProductID, @Attributes, 1, GETDATE())


GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartCountOldCarts]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShoppingCartCountOldCarts]
(@Days smallint)
AS
SELECT COUNT(CartID)
FROM ShoppingCart
WHERE CartID IN
(SELECT CartID
FROM ShoppingCart
GROUP BY CartID
HAVING MIN(DATEDIFF(dd,DateAdded,GETDATE())) >= @Days)


GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartDeleteOldCarts]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShoppingCartDeleteOldCarts]
(@Days smallint)
AS
DELETE FROM ShoppingCart
WHERE CartID IN
(SELECT CartID
FROM ShoppingCart
GROUP BY CartID
HAVING MIN(DATEDIFF(dd,DateAdded,GETDATE())) >= @Days)


GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartGetItems]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShoppingCartGetItems]
(@CartID char(36))
AS
SELECT Product.ProductID, Product.Name, ShoppingCart.Attributes, Product.Price, ShoppingCart.Quantity,Product.Price * ShoppingCart.Quantity AS Subtotal
FROM ShoppingCart INNER JOIN Product
ON ShoppingCart.ProductID = Product.ProductID
WHERE ShoppingCart.CartID = @CartID


GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartGetTotalAmount]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShoppingCartGetTotalAmount]
(@CartID char(36))
AS
SELECT ISNULL(SUM(Product.Price * ShoppingCart.Quantity), 0)
FROM ShoppingCart INNER JOIN Product
ON ShoppingCart.ProductID = Product.ProductID
WHERE ShoppingCart.CartID = @CartID


GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartRemoveItem]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShoppingCartRemoveItem]
(@CartID char(36),
 @ProductID int)
AS
DELETE FROM ShoppingCart
WHERE CartID = @CartID and ProductID = @ProductID


GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartUpdateItem]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[ShoppingCartUpdateItem]
(@CartID char(36),
 @ProductID int,
 @Quantity int)
AS
IF @Quantity <= 0
  EXEC ShoppingCartRemoveItem @CartID, @ProductID
ELSE
  UPDATE ShoppingCart
  SET Quantity = @Quantity, DateAdded = GETDATE()
  WHERE ProductID = @ProductID AND CartID = @CartID


GO
/****** Object:  UserDefinedFunction [dbo].[total]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[total](@sale int)
 returns int 
 as
 begin
 declare @sum int 
 select @sum=
 (
	select sum(Quantity) from OrderDetail where Quantity<@sale
	group by ProductID
 )
 return @sum
 end

GO
/****** Object:  UserDefinedFunction [dbo].[total1]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create function [dbo].[total1](@sale int)
 returns int 
 as
 begin
 declare @sum int 
 select @sum=
 (
	select sum(Quantity) from OrderDetail where Quantity=@sale
	group by ProductID
 )
 return @sum
 end

GO
/****** Object:  Table [dbo].[Attribute]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attribute](
	[AttributeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AttributeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AttributeValue]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeValue](
	[AttributeValueID] [int] IDENTITY(1,1) NOT NULL,
	[AttributeID] [int] NOT NULL,
	[Value] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AttributeValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Category_1] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Department]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitCost] [money] NOT NULL,
	[Subtotal]  AS ([Quantity]*[UnitCost]),
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[DateCreated] [smalldatetime] NOT NULL CONSTRAINT [DF_Orders_DateCreated]  DEFAULT (getdate()),
	[DateShipped] [smalldatetime] NULL,
	[Verified] [bit] NOT NULL CONSTRAINT [DF_Orders_Verified]  DEFAULT ((0)),
	[Completed] [bit] NOT NULL CONSTRAINT [DF_Orders_Completed]  DEFAULT ((0)),
	[Canceled] [bit] NOT NULL CONSTRAINT [DF_Orders_Canceled]  DEFAULT ((0)),
	[Comments] [nvarchar](1000) NULL,
	[CustomerName] [nvarchar](50) NULL,
	[Region] [nvarchar](50) NULL,
	[ShippingAddress] [nvarchar](500) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Price] [money] NOT NULL,
	[Thumbnail] [nvarchar](50) NULL,
	[Image] [nvarchar](50) NULL,
	[PromoFront] [bit] NOT NULL,
	[PromoDept] [bit] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductAttributeValue]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAttributeValue](
	[ProductID] [int] NOT NULL,
	[AttributeValueID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[AttributeValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[ProductID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[CartID] [char](36) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Attributes] [nvarchar](1000) NULL,
	[DateAdded] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_ShoppingCart] PRIMARY KEY CLUSTERED 
(
	[CartID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[anyQuantity]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[anyQuantity](@sale int)
 returns TABLE 
 as
 return
 (
	select ProductID,ProductName,UnitCost,sum(Quantity) as total from OrderDetail where Quantity=@sale
	group by ProductID,productName,UnitCost
 );

GO
/****** Object:  UserDefinedFunction [dbo].[BestSeller]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[BestSeller] (@quantity int)
RETURNS TABLE
AS
RETURN 
(
    SELECT O.ProductName, O.Quantity
    FROM OrderDetail AS O 
    WHERE   O.Quantity  >  @quantity  
  
);

GO
/****** Object:  UserDefinedFunction [dbo].[sales]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[sales](@quantity int)
RETURNS TABLE
AS
RETURN 
(
    SELECT O.ProductName, O.Quantity
    FROM OrderDetail AS O 
    WHERE   O.Quantity  >  @quantity  
);

GO
/****** Object:  View [dbo].[ProdsInCats]    Script Date: 2015-12-17 2:06:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProdsInCats]
AS
SELECT dbo.Product.ProductID, dbo.Product.Name, dbo.Product.Description, dbo.Product.Price, dbo.Product.Thumbnail, dbo.ProductCategory.CategoryID
FROM   dbo.Product INNER JOIN
            dbo.ProductCategory ON dbo.Product.ProductID = dbo.ProductCategory.ProductID


GO
SET IDENTITY_INSERT [dbo].[Attribute] ON 

INSERT [dbo].[Attribute] ([AttributeID], [Name]) VALUES (1, N'Vannila Cake')
INSERT [dbo].[Attribute] ([AttributeID], [Name]) VALUES (2, N'Chocolate Cake')
SET IDENTITY_INSERT [dbo].[Attribute] OFF
SET IDENTITY_INSERT [dbo].[AttributeValue] ON 

INSERT [dbo].[AttributeValue] ([AttributeValueID], [AttributeID], [Value]) VALUES (1, 1, N'Vannila Icing')
INSERT [dbo].[AttributeValue] ([AttributeValueID], [AttributeID], [Value]) VALUES (2, 1, N'Chocolate Lcing')
INSERT [dbo].[AttributeValue] ([AttributeValueID], [AttributeID], [Value]) VALUES (3, 2, N'Vannila Icing')
INSERT [dbo].[AttributeValue] ([AttributeValueID], [AttributeID], [Value]) VALUES (4, 2, N'Chocalate Icing')
SET IDENTITY_INSERT [dbo].[AttributeValue] OFF
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (1, 1, N'Chritmas Cakes', N'')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (2, 1, N'Valentine Cakes', N'')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (3, 1, N'Halloween Cakes', N'')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (4, 2, N'Anniversary Cakes', N'')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (5, 2, N'Birthday Cakes', N'')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (6, 2, N'Baby Cakes', N'')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([DepartmentID], [Name], [Description]) VALUES (1, N'Holiday Cake', N'Cakes specially designed for public Holidays and celebrations (i.e., Chritmas, Thanksgiving, Easter, Halloween, etc.)')
INSERT [dbo].[Department] ([DepartmentID], [Name], [Description]) VALUES (2, N'Personal Cake', N'Cakes specially designed for Birthdays, Weddings, Annivrsaries, etc.')
SET IDENTITY_INSERT [dbo].[Department] OFF
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (1, 4, N'Today, Tomorrow & Forever', 11, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (2, 1, N'I Love You (Simon Elvin)', 3, 12.4900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (2, 12, N'Smiley Heart Red Cake', 5, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (3, 1, N'I Love You (Simon Elvin)', 6, 12.4900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (3, 24, N'Birthday Star Cake', 5, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (4, 1, N'I Love You (Simon Elvin)', 4, 12.4900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (4, 2, N'Elvis Hunka Burning Love', 7, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (4, 4, N'Today, Tomorrow & Forever', 8, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (4, 5, N'Smiley Heart Yellow Cake', 2, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (5, 1, N'I Love You (Simon Elvin)', 9, 12.4900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (5, 4, N'Today, Tomorrow & Forever', 10, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (6, 1, N'I Love You (Simon Elvin)', 15, 12.4900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (6, 24, N'Birthday Star2', 17, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (7, 2, N'Elvis Hunka Burning Love', 12, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (7, 25, N'Tweety Stars', 14, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (7, 40, N'Rugrats Tommy & Chucky', 18, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (8, 14, N'Love Rose', 19, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (8, 22, N'I''m Younger Than You', 20, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (9, 4, N'Today, Tomorrow & Forever', 24, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (10, 1, N'I Love You (Simon Elvin)', 21, 12.4900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (10, 4, N'Today, Tomorrow & Forever', 25, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (10, 10, N'I Can''t Get Enough of You Baby', 22, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (11, 1, N'I Love You (Simon Elvin)', 21, 12.4900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (12, 3, N'Funny Love', 23, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (12, 57, N'Crystal Rose Silver', 26, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (12, 58, N'Crystal Rose Gold', 20, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (13, 1, N'I Love You (Simon Elvin)', 19, 12.4900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (13, 23, N'Birthday Cake', 8, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (14, 2, N'Elvis Hunka Burning Love', 2, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (14, 5, N'Smiley Heart chocolate cake', 31, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (14, 63, N'Baby Girl', 2, 23.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (17, 1, N'I Love You (Simon Elvin)', 1, 12.4900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (17, 7, N'Smiley Kiss Red Cake', 4, 12.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (17, 10, N'I Can''t Get Enough of You Baby', 6, 12.9900)
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (1, CAST(N'2015-11-25 13:48:00' AS SmallDateTime), CAST(N'2015-11-27 17:48:00' AS SmallDateTime), 0, 0, 0, NULL, N'John Bailey', N'Birkdale Community', N'666 Burnhamthorpe Rd')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (2, CAST(N'2015-11-26 12:05:00' AS SmallDateTime), CAST(N'2015-11-27 17:05:00' AS SmallDateTime), 0, 0, 0, NULL, N'Margaret Krol', N'Main Square Community', N'255 Main St. West')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (3, CAST(N'2015-11-26 11:38:00' AS SmallDateTime), CAST(N'2015-11-29 12:38:00' AS SmallDateTime), 0, 0, 0, NULL, N'Craig Karpilow', N'Falstaff Community', N'15 Wilson Center')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (4, CAST(N'2015-11-26 11:59:00' AS SmallDateTime), CAST(N'2015-11-27 16:52:00' AS SmallDateTime), 0, 0, 0, NULL, N'Ruth Ellen', N'Main Square Community', N'Suite 202, 800 Princess Street')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (5, CAST(N'2015-11-30 12:15:00' AS SmallDateTime), CAST(N'2015-12-01 16:23:00' AS SmallDateTime), 0, 0, 0, NULL, N'Daniel Garrett', N'Birkdale Community', N'B106- 751 Victoria St South')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (6, CAST(N'2015-11-29 12:17:00' AS SmallDateTime), CAST(N'2015-11-30 15:27:00' AS SmallDateTime), 0, 0, 0, NULL, N'Margaret Krol', N'Main Square Community', N'255 Main St. West')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (7, CAST(N'2015-11-27 12:21:00' AS SmallDateTime), CAST(N'2015-11-28 16:25:00' AS SmallDateTime), 0, 0, 0, NULL, N'Violet Shadd', N'Birkdale Community', N'125 Consumers Rd')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (8, CAST(N'2015-11-28 11:18:00' AS SmallDateTime), CAST(N'2015-11-29 16:34:00' AS SmallDateTime), 0, 0, 0, NULL, N'Thomas H. McDonagh', N'Driftwood Community', N'163 Commissioners Rd West')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (9, CAST(N'2015-11-24 11:20:00' AS SmallDateTime), CAST(N'2015-11-26 15:55:00' AS SmallDateTime), 0, 0, 0, NULL, N'Ruth Ellen', N'Main Square Community', N'Suite 202, 800 Princess Street')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (10, CAST(N'2015-11-30 11:39:00' AS SmallDateTime), CAST(N'2015-12-01 15:56:00' AS SmallDateTime), 0, 0, 0, NULL, N'Mary McDonagh', N'Birkdale Community', N'460 Springbank Drive')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (11, CAST(N'2015-11-24 15:21:00' AS SmallDateTime), CAST(N'2015-11-26 16:43:00' AS SmallDateTime), 0, 0, 0, NULL, N'Colin F. Saldanha', N'Birkdale Community', N'107-550 Matheson Blvd. West')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (12, CAST(N'2015-11-25 16:23:00' AS SmallDateTime), CAST(N'2015-11-27 16:48:00' AS SmallDateTime), 0, 0, 0, NULL, N'Frederico Hung', N'Main Square Community', N'1425 Dundas St E')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (13, CAST(N'2015-11-25 16:13:00' AS SmallDateTime), CAST(N'2011-11-28 18:34:00' AS SmallDateTime), 0, 0, 0, NULL, N'Margaret Krol', N'Main Square Community', N'255 Main St. West')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (14, CAST(N'2015-11-26 12:39:00' AS SmallDateTime), CAST(N'2015-11-27 16:22:00' AS SmallDateTime), 0, 0, 0, NULL, N'David Arthur', N'Grandravine Community', N'7330 Goreway Dr')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (15, CAST(N'2015-11-23 12:39:00' AS SmallDateTime), CAST(N'2015-11-25 15:59:00' AS SmallDateTime), 0, 0, 0, NULL, N'Margaret Krol', N'Main Square Community', N'255 Main St. West')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (16, CAST(N'2015-11-27 12:40:00' AS SmallDateTime), CAST(N'2015-11-28 16:30:00' AS SmallDateTime), 0, 0, 0, NULL, N'Jason Y.S. Tsai', N'Grandravine Community', N'6530 Goreway Dr')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (17, CAST(N'2015-11-28 12:43:00' AS SmallDateTime), CAST(N'2015-11-29 15:53:00' AS SmallDateTime), 0, 0, 0, NULL, N'Margaret Krol', N'Main Square Community', N'255 Main St. West')
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [Region], [ShippingAddress]) VALUES (18, CAST(N'2015-11-29 15:49:00' AS SmallDateTime), CAST(N'2015-11-30 16:33:00' AS SmallDateTime), 0, 0, 0, NULL, N'Ruth Ellen', N'Main Square Community', N'Suite 202, 800 Princess Street')
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (1, N'Birthday Flowers Cake', N'Personalize this Birthday Flowers cake with your own special message.', 19.9900, N'tbd01.jpg', N'bd01.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (2, N'Birthday Panda Cake', N'''Happy Birthday. Hope you have a wonderful day Joanne. Lots of Love Mum & Dad xxx.'' ', 21.9900, N'tbd02.jpg', N'bd02.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (3, N'Birthday Roses Cake', N'''Happy Birthday Melissa. Love from Mum and Dad xxxx.'' ', 27.9900, N'tbd03.jpg', N'bd03.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (4, N'Birthday Teapot Cake', N'Personalise this beautifully detailed teapot themed Birthday cake with your own message. Perfect for all those tea lovers! ', 24.9900, N'tbd04.jpg', N'bd04.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (5, N'Birthday Ted Teapot Cake', N'Add your own name and special message to this sweet Teddy Teapot cake design. Who could resist?! ', 21.9900, N'tbd05.jpg', N'bd05.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (6, N'Birthday Vintage Flowers Cake', N'A red heart-shaped balloon with "I Love You" in script writing. Gold heart outlines adorn the background.', 19.9900, N'tbd06.jpg', N'bd06.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (7, N'Butterfly Cake', N'Example is: ''Have a lovely day Claire''. ', 24.9900, N'tbd07.jpg', N'bd07.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (8, N'Camper Van Cake', N'
Example shown is ''Happy Birthday, Best wishes on the day Stephanie! All our love xxx''. 
', 19.9900, N'tbd08.jpg', N'bd08.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (9, N'Candy Spots Cake', N'Example: ''Happy, Birthday, Billy Ann''. ', 21.9900, N'tbd09.jpg', N'bd09.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (10, N'Cool Chick! Cake', N'
Send some birthday Cheer to that Cool Chick! Simply personalize the text. 
', 24.9900, N'tbd10.jpg', N'bd10.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (11, N'Giraffe Cake Cake', N'
Example is: ''My Wonderful mum..... Thank you so much for everything! Sarah xxxxxxxx.'' 
', 27.9900, N'tbd11.jpg', N'bd11.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (12, N'Go Nuts! Cake', N'
It''s your birthday so let your hair down and GO NUTS! 
', 19.9900, N'tbd12.jpg', N'bd12.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (13, N'Hearts Collage Cake', N'
Example shown is ''To my Wonderful Friend! You are truly fantastic! xxx''. 
', 24.9900, N'tbd13.jpg', N'bd13.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (14, N'Lady Bird Cake', N'
Example: ''Happy, Birthday, Name''. 
', 21.9900, N'tbd14.jpg', N'bd14.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (15, N'Little Birdie Cake', N'
Example is: ''Wishing you a very special Birthday Charlotte''. 
', 27.9900, N'tbd15.jpg', N'bd15.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (16, N'My Special Friend Cake', N'
Example shown is ''To a Special Friend, Happy Birthday from Louise xxx''. 
', 24.9900, N'tbd16.jpg', N'bd16.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (17, N'Party Spider Cake', N'
Personalize this jolly Birthday spider cake with your own age and message! 
', 21.9900, N'tbd17.jpg', N'bd17.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (18, N'SMILE! Cake', N'
This cake is sure to bring a smile to anyone’s face! Simply personalize with your own message and name. 
', 19.6200, N'tbd18.jpg', N'bd18.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (19, N'Star Cake', N'
Example is: ''Susan''. ''Personalize this cake'' to your own loved ones name. 
', 24.9900, N'tbd19.jpg', N'bd19.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (20, N'Zombie Cake', N'
Example: ''Happy Birthday, 15, Alice''. 
', 21.9900, N'tbd20.jpg', N'bd20.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (21, N'Blue Festive Tree Cake', N'Personalize the text and name on this beautiful and elegant festive tree cake.', 24.9900, N'tc01.jpg', N'c01.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (22, N'Christmas Angels Cake', N'Personalize this beautiful traditional Christmas Angel cake in time for Christmas.', 27.9900, N'tc02.jpg', N'c02.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (23, N'Christmas Carol Singers Cake', N'Personalize all of the text on this bright and cheerful Christmas Carol Singers cake.', 24.9900, N'tc03.jpg', N'c03.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (24, N'Christmas Pudding Ted Cake', N'Personalize the message on this adorable Christmas pudding teddy bear cake.', 24.9900, N'tc04.jpg', N'c04.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (25, N'Christmas Robins and Holly Cake', N'Personalize this simple Christmas Robins cake with your own festive thoughts!', 19.9900, N'tc05.jpg', N'c05.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (26, N'Christmas Stocking Ted Cake', N'Add your own special message to this sweet Christmas Teddy Cake.', 27.9900, N'tc06.jpg', N'c06.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (27, N'Christmas Trooper Cake', N'This cake makes a fantastic Christmas gift for those dedicated fans! Simply add your own message.', 21.9900, N'tc07.jpg', N'c07.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (28, N'Decorative Red Tree Cake', N'Personalize the text on this beautiful traditional red Christmas tree cake. Perfect for friends, family and even colleagues!', 24.9900, N'tc08.jpg', N'c08.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (29, N'Golden Christmas Tree Cake', N'This black and gold Christmas tree is an alternative to the traditional red, but still just as elegant and classy.', 22.9900, N'tc09.jpg', N'c09.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (30, N'International Christma Cake', N'Personalize the message on this international Christmas cake. Perfect for corporate gifts or celebrating with family who are that little further away!', 21.9900, N'tc10.jpg', N'c10.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (31, N'Jolly Christmas Tree Scene Cake', N'Personalize the names on this Traditional snowy Christmas cake.', 19.9900, N'tc11.jpg', N'c11.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (32, N'Red Robin Cake', N'Personalize the wording on this adorable and traditional Christmas Robin cake. A perfect treat for the holidays!', 24.9900, N'tc12.jpg', N'c12.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (33, N'Santa Claus Wishes Cake', N'Send some season’s greetings with this Jolly Santa Claus cake! Just personalize the text.', 24.9900, N'tc13.jpg', N'c13.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (34, N'Seasons Greetings Cake', N'Simple and festive, this cake would be great for anyone and everyone!', 24.9900, N'tc14.jpg', N'c14.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (35, N'Three Wise Men Cake', N'Personalize the text on this traditional yet bold Festive cake.', 25.9900, N'tc15.jpg', N'c15.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (36, N'White Christmas Cake', N'Spread some Christmas cheer with this humorous Santa themed cake. Just personalize the message and name.', 21.9900, N'tc16.jpg', N'c16.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (37, N'Carved Pumpkin Cake', N'Add a name to this pumpkin Halloween cake! Perfect for a delicious Halloween treat or gift!', 24.9900, N'th01.jpg', N'h01.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (38, N'Creepy Spider Web Cake', N'A Creepy Crawly Spider themed cake, covered with spider webs and little critters.', 28.9900, N'th02.jpg', N'h02.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (39, N'Decorative Halloween Cake', N'Decorative Halloween party cake with bunting, polka dots and creepy character cut outs. Personalize with your own spooky message.', 28.9900, N'th03.jpg', N'h03.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (40, N'Ghost Party Cake', N'This cute ghost themed cake makes a great center piece to any Halloween party! Just personalize with your own text!', 27.9900, N'th04.jpg', N'h04.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (41, N'Haunted House Cake', N'This Haunted House Halloween Cake matches perfectly with our cupcakes!', 24.9900, N'th05.jpg', N'h05.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (42, N'Pretty Witch Cake', N'Perfect for any girls Halloween Party, just personalize the text and name!', 24.9900, N'th06.jpg', N'h06.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (43, N'Pumpkin Witch Cake', N'Personalize all of the text on this lovely Halloween cake. Perfect for a gift or the center piece to a Halloween Party.', 19.9900, N'th07.jpg', N'h07.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (44, N'Scary Halloween Face Cake', N'This creepy Halloween face cake would make a spectacular Halloween Party Centre Piece! Just personalize with your own text!', 21.9900, N'th08.jpg', N'h08.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (45, N'Spooky Characters Cake', N'These frightful little characters make this cake extra spooky! Just personalize it with your own message', 22.9900, N'th09.jpg', N'h09.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (46, N'Be My Valentine Gift Cake', N'Example: ''Christopher. Be my Valentine''.', 27.9900, N'tv01.jpg', N'v01.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (47, N'Darling Valentine Cake', N'Add your own special message to this cute Teddy Bear Valentines Cake.', 22.9900, N'tv02.jpg', N'v02.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (48, N'For The One I Love Cake', N'Example: ''For My Valentine. All My Love Richard.', 24.9900, N'tv03.jpg', N'v03.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (49, N'I Heart U Cake', N'Example: ''Lynda. Happy Valentine’s Day.', 28.9900, N'tv04.jpg', N'v04.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (50, N'Love Hearts Valentines Cake', N'Personalize this sweet Love Hearts cake with your own loving message.', 27.9900, N'tv05.jpg', N'v05.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (51, N'Marry Me Cake', N'Add your own special message to this Marry Me Valentines Cake.', 24.9900, N'tv06.jpg', N'v06.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (52, N'Meant to Bee Cake', N'Personalize all of the text on this cute Bumble Bee Valentine’s Day cake!', 28.9900, N'tv07.jpg', N'v07.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (53, N'Nuts About You Cake', N'If you love someone who loves chocolate spread, then this is the cake for you! Just add your own name.', 21.9900, N'tv08.jpg', N'v08.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (54, N'Purr Purr Purrr... Cake', N'Example: ''Purr Purr Purrr... Lots of Love on Valentine’s Day David xxx.', 24.9900, N'tv09.jpg', N'v09.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (55, N'Sporadic Valentines Hearts Cake', N'Add your own special message to this cute Valentines Hearts Cake.', 24.9900, N'tv10.jpg', N'v10.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (56, N'Sweet Heart of Mine Cake', N'Example: ''NAME.... Sweet heart of mine. Be my Valentine? XXXXX', 28.9900, N'tv11.jpg', N'v11.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (57, N'To My Valentine Cake', N'Personalize the valentine’s message on this Be My Valentine cake!', 22.9900, N'tv12.jpg', N'v12.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (58, N'Valentines LOVE Cake', N'Add your own special message to this cute LOVE Valentines Cake.', 24.9900, N'tv13.jpg', N'v13.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (59, N'Valentines Scrabble Cake', N'Personalize the valentine’s message on this sweet and simple word game cake!', 25.9900, N'tv14.jpg', N'v14.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (60, N'Valentines Snowman Cake', N'Send some love this Valentine’s Day with our cute Snowman Hugs cake!', 23.9900, N'tv15.jpg', N'v15.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (61, N'You''ve Toucan my Heart! Cake', N'This simple and sweet Toucan cake makes a great personalized gift or treat for your loved one!', 21.9900, N'tv16.jpg', N'v16.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (62, N'Baby Boy', N'This is a special cake for baby boy', 26.9900, N'tbb01.jpg', N'bb01.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (63, N'Baby Girl', N'This is a special cake for baby girl', 23.9900, N'tbb02.jpg', N'bb02.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (64, N'Double Trouble', N'This is a special cake for baby boy', 24.9900, N'tbb03.jpg', N'bb03.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (65, N'New Baby Boy Pram', N'This is a special cake for baby boy', 28.9900, N'tbb04.jpg', N'bb04.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (66, N'New Baby Boy', N'This is a special cake for baby boy', 21.9900, N'tbb05.jpg', N'bb05.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (67, N'New Baby Girl Pram', N'This is a special cake for baby girl', 24.9900, N'tbb06.jpg', N'bb06.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (68, N'New Baby Girl', N'This is a special cake for baby girl', 24.9900, N'tbb07.jpg', N'bb07.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (69, N'A Simple Anniversary', N'This simple and sweet Toucan cake makes a great personalized gift or treat for your loved one!', 24.9900, N'ta01.jpg', N'a01.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (70, N'An Anniversary Toast', N'This simple and sweet Toucan cake makes a great personalized gift or treat for your loved one!', 24.9900, N'ta02.jpg', N'a02.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (71, N'Anniversary Couple', N'This simple and sweet Toucan cake makes a great personalized gift or treat for your loved one!', 27.9900, N'ta03.jpg', N'a03.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (72, N'Anniversary', N'This simple and sweet Toucan cake makes a great personalized gift or treat for your loved one!', 24.9900, N'ta04.jpg', N'a04.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (73, N'Golden Moments', N'This simple and sweet Toucan cake makes a great personalized gift or treat for your loved one!', 28.9900, N'ta05.jpg', N'a05.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (74, N'Heart Confetti Ted', N'This simple and sweet Toucan cake makes a great personalized gift or treat for your loved one!', 21.9900, N'ta06.jpg', N'a06.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (75, N'Love Hearts Anniversary Cake', N'This simple and sweet Toucan cake makes a great personalized gift or treat for your loved one!', 27.9900, N'ta07.jpg', N'a07.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (76, N'Prince Charming Anniversary Cake', N'This simple and sweet Toucan cake makes a great personalized gift or treat for your loved one!', 21.9900, N'ta08.jpg', N'a08.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (77, N'Silver Anniversary Birds', N'This simple and sweet Toucan cake makes a great personalized gift or treat for your loved one!', 24.9900, N'ta09.jpg', N'a09.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept]) VALUES (78, N'True Love Hearts Cake', N'This simple and sweet Toucan cake makes a great personalized gift or treat for your loved one!', 22.9900, N'ta10.jpg', N'a10.jpg', 0, 0)
SET IDENTITY_INSERT [dbo].[Product] OFF
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (1, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (1, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (2, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (2, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (3, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (3, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (4, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (4, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (5, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (5, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (6, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (6, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (7, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (7, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (8, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (8, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (9, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (9, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (10, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (10, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (11, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (11, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (12, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (12, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (13, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (13, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (14, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (14, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (15, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (15, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (16, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (16, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (17, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (17, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (18, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (18, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (19, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (19, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (20, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (20, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (21, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (21, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (22, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (22, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (23, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (23, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (24, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (24, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (25, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (25, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (26, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (26, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (27, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (27, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (28, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (28, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (29, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (29, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (30, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (30, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (31, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (31, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (32, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (32, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (33, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (33, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (34, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (34, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (35, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (35, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (36, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (36, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (37, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (37, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (38, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (38, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (39, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (39, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (40, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (40, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (41, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (41, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (42, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (42, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (43, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (43, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (44, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (44, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (45, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (45, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (46, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (46, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (47, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (47, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (48, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (48, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (49, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (49, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (50, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (50, 2)
GO
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (51, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (51, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (52, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (52, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (53, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (53, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (54, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (54, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (55, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (55, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (56, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (56, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (57, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (57, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (58, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (58, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (59, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (59, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (60, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (60, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (61, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (61, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (62, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (62, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (63, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (63, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (64, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (64, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (65, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (65, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (66, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (66, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (67, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (67, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (68, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (68, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (69, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (69, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (70, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (70, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (71, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (71, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (72, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (72, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (73, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (73, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (74, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (74, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (75, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (75, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (76, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (76, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (77, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (77, 2)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (78, 1)
INSERT [dbo].[ProductAttributeValue] ([ProductID], [AttributeValueID]) VALUES (78, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (1, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (2, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (3, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (4, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (5, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (6, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (7, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (8, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (9, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (10, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (11, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (12, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (13, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (14, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (15, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (16, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (17, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (18, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (19, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (20, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (21, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (22, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (23, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (24, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (25, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (26, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (27, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (28, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (29, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (30, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (31, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (32, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (33, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (34, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (35, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (36, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (37, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (38, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (39, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (40, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (41, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (42, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (43, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (44, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (45, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (46, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (47, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (48, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (49, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (50, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (51, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (52, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (53, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (54, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (55, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (56, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (57, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (58, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (59, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (60, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (61, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (62, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (63, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (64, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (65, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (66, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (67, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (68, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (69, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (70, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (71, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (72, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (73, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (74, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (75, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (76, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (77, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (78, 4)
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [Attributes], [DateAdded]) VALUES (N'a6ac31fb-ef2a-4e38-b3c1-7904d5d6a7c9', 5, 1, N'attributes', CAST(N'2012-03-15 16:39:00' AS SmallDateTime))
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [Attributes], [DateAdded]) VALUES (N'fe174305-e73c-485b-8bf9-595d5136f235', 22, 2, N'attributes', CAST(N'2015-12-08 09:49:00' AS SmallDateTime))
ALTER TABLE [dbo].[AttributeValue]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValue_Attribute] FOREIGN KEY([AttributeID])
REFERENCES [dbo].[Attribute] ([AttributeID])
GO
ALTER TABLE [dbo].[AttributeValue] CHECK CONSTRAINT [FK_AttributeValue_Attribute]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Department] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Department]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Orders]
GO
ALTER TABLE [dbo].[ProductAttributeValue]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeValue_AttributeValue] FOREIGN KEY([AttributeValueID])
REFERENCES [dbo].[AttributeValue] ([AttributeValueID])
GO
ALTER TABLE [dbo].[ProductAttributeValue] CHECK CONSTRAINT [FK_ProductAttributeValue_AttributeValue]
GO
ALTER TABLE [dbo].[ProductAttributeValue]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeValue_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ProductAttributeValue] CHECK CONSTRAINT [FK_ProductAttributeValue_Product]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_Category]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_Product]
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_Product]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Product"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 156
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "ProductCategory"
            Begin Extent = 
               Top = 9
               Left = 307
               Bottom = 114
               Right = 500
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProdsInCats'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProdsInCats'
GO
USE [master]
GO
ALTER DATABASE [BalloonShop] SET  READ_WRITE 
GO
