CREATE DATABASE KruzeAutoDB;
GO

USE KruzeAutoDB;

CREATE TABLE [Users](
	[UserID] uniqueidentifier NOT NULL,
	[Email] nvarchar(50) NOT NULL,
	[UserName] nvarchar(50) NOT NULL,
	[Password] nvarchar(50) NOT NULL,
	[PhoneNumber] nvarchar(50) NOT NULL,
	[CreationDate] datetime NOT NULL,
	[Subscribed] bit,
CONSTRAINT [PK_Users] PRIMARY KEY ([UserID]));

CREATE TABLE [UserLocation](
	[UserID] uniqueidentifier NOT NULL,
	[Country] nvarchar(50) NOT NULL,
	[County] nvarchar(50) NOT NULL,
	[City] nvarchar(50) NOT NULL,
CONSTRAINT [PK_UserLocation] PRIMARY KEY ([UserID]),
CONSTRAINT [FK_UserLocation_Users] FOREIGN KEY ([UserID])
	REFERENCES [Users]([UserID]) ON DELETE CASCADE);

--cars, motorcycles, motorhomes, vans, Truks, Trailers, Semitrailers, Buses, ConstructionMachines, AgriculturalVehicles, ForkliftTruks
CREATE TABLE [Announcements](
	[AnnoucementID] uniqueidentifier NOT NULL,
	[UserID] uniqueidentifier NOT NULL,
	[VehicleType] int NOT NULL,
	[Views] int NOT NULL,
	[Promoted] bit,
	[Active] bit,
	[CreationDate] datetime NOT NULL,
	[Update] datetime,
	[Condition] nvarchar(15) NOT NULL,
	[Title] nvarchar(50) NOT NULL,
	[Brand] nvarchar(50) NOT NULL,
	[Model] nvarchar(50) NOT NULL,
	[Type] nvarchar(50) NOT NULL,
	[Kilometer] int,
	[FabricationYear] int NOT NULL,
	[VIN] nvarchar(50),
	[FuelType] nvarchar(25) NOT NULL,
	[Price] int NOT NULL,
	[NegociablePrice] bit,
	[Currency] nvarchar(3) NOT NULL,
	[Color] nvarchar(15),
	[ColorType] nvarchar(15),
	[Power] int,
	[Transmission] nvarchar(25),
	[CubicCapacity] int,
	[EmissionClass] nvarchar(15),
	[NumberOfSeats] int,
	[GVW] int,
	[LoadCapacity] int,
	[OperatingHours] int,
	[Description] text,
CONSTRAINT [PK_Announcements] PRIMARY KEY ([AnnoucementID]),
CONSTRAINT [FK_Announcements_Users] FOREIGN KEY ([UserID])
	REFERENCES [Users]([UserID]) ON DELETE CASCADE);

CREATE TABLE [Options](
	[OptionID] uniqueidentifier NOT NULL,
	[Name] nvarchar(50) NOT NULL
CONSTRAINT [PK_Options] PRIMARY KEY ([OptionID]));

CREATE TABLE [AnnouncementsOptions](
	[AnnoucementID] uniqueidentifier NOT NULL,
	[OptionID] uniqueidentifier NOT NULL,
CONSTRAINT [PK_AnnouncementsOptions] PRIMARY KEY ([AnnoucementID],[OptionID]),
CONSTRAINT [FK_AnnouncementsOptions_Announcements] FOREIGN KEY ([AnnoucementID])
	REFERENCES [Announcements]([AnnoucementID]) ON DELETE CASCADE,
CONSTRAINT [FK_AnnouncementsOptions_Options] FOREIGN KEY ([OptionID])
	REFERENCES [Options]([OptionID]) ON DELETE CASCADE);

CREATE TABLE [MessageInbox](
	[MessageID] uniqueidentifier NOT NULL,
	[UserID] uniqueidentifier NOT NULL,
	[AnnoucementID] uniqueidentifier,
	[CreationDate] datetime NOT NULL,
	[Read] bit,
	[MesageContent] text NOT NULL,
CONSTRAINT [PK_MesageImbox] PRIMARY KEY ([MessageID]),
CONSTRAINT [FK_MesageImbox_Users] FOREIGN KEY ([UserID])
	REFERENCES [Users]([UserID]) ON DELETE CASCADE,
CONSTRAINT [FK_MessageInbox_Announcements]  FOREIGN KEY ([AnnoucementID])
	REFERENCES [Announcements]([AnnoucementID]) ON DELETE NO ACTION);

ALTER TABLE [MessageInbox] NOCHECK CONSTRAINT [FK_MessageInbox_Announcements];

CREATE TABLE [Pictures](
	[PictureID] uniqueidentifier NOT NULL,
	[Image] image,
CONSTRAINT [PK_Pictures] PRIMARY KEY ([PictureID]));

CREATE TABLE [UsersPictures](
	[UserID] uniqueidentifier NOT NULL,
	[PictureID] uniqueidentifier NOT NULL,
CONSTRAINT [PK_UsersPictures] PRIMARY KEY ([UserID]),
CONSTRAINT [FK_UsersPictures_Users] FOREIGN KEY ([UserID])
	REFERENCES [Users]([UserID]) ON DELETE CASCADE,
CONSTRAINT [FK_UsersPictures_Pictures] FOREIGN KEY ([PictureID])
	REFERENCES [Pictures]([PictureID]) ON DELETE CASCADE);

CREATE TABLE [AnnouncementsPictures](
	[PictureID] uniqueidentifier NOT NULL,
	[AnnoucementID] uniqueidentifier NOT NULL,
	[PrimaryPicture] bit,
CONSTRAINT [PK_AnnouncementsPictures] PRIMARY KEY ([PictureID]),
CONSTRAINT [FK_AnnouncementsPictures_Pictures] FOREIGN KEY ([PictureID])
	REFERENCES [Pictures]([PictureID]) ON DELETE CASCADE,
CONSTRAINT [FK_AnnouncementsPictures_Announcements] FOREIGN KEY ([AnnoucementID])
	REFERENCES [Announcements]([AnnoucementID]) ON DELETE CASCADE);
GO

--STORED PROCEDURES INSERT

CREATE PROCEDURE dbo.Users_Insert
(
	@UserID uniqueidentifier,
	@Email nvarchar(50),
	@UserName nvarchar(50),
	@Password nvarchar(50),
	@PhoneNumber nvarchar(50),
	@CreationDate datetime,
	@Subscribed bit
)
AS
BEGIN
	INSERT INTO [Users]([UserID],[Email],[UserName],[Password],[PhoneNumber],[CreationDate],[Subscribed])
	VALUES(@UserID,@Email,@UserName,@Password,@PhoneNumber,@CreationDate,@Subscribed)
END
GO

CREATE PROCEDURE dbo.UserLocation_Insert
(
	@UserID uniqueidentifier,
	@Country nvarchar(50),
	@County nvarchar(50),
	@City nvarchar(50)
)
AS
BEGIN
	INSERT INTO [UserLocation]([UserID],[Country],[County],[City])
	VALUES(@UserID,@Country,@County,@City)
END
GO

CREATE PROCEDURE dbo.Announcements_Insert
(
	@AnnoucementID uniqueidentifier,
	@UserID uniqueidentifier,
	@VehicleType int,
	@Views int,
	@Promoted bit,
	@Active bit,
	@CreationDate datetime,
	@Update datetime,
	@Condition nvarchar(15),
	@Title nvarchar(50),
	@Brand nvarchar(50),
	@Model nvarchar(50),
	@Type nvarchar(50),
	@Kilometer int,
	@FabricationYear int,
	@VIN nvarchar(50),
	@FuelType nvarchar(25),
	@Price int,
	@NegociablePrice bit,
	@Currency nvarchar(3),
	@Color nvarchar(15),
	@ColorType nvarchar(15),
	@Power int,
	@Transmission nvarchar(25),
	@CubicCapacity int,
	@EmissionClass nvarchar(15),
	@NumberOfSeats int,
	@GVW int,
	@LoadCapacity int,
	@OperatingHours int,
	@Description text
)
AS
BEGIN
	INSERT INTO [Announcements]([AnnoucementID],[UserID],[VehicleType],[Views],[Promoted],[Active],[CreationDate],
	[Update],[Condition],[Title],[Brand],[Model],[Type],[Kilometer],[FabricationYear],[VIN],[FuelType],[Price],
	[NegociablePrice],[Currency],[Color],[ColorType],[Power],[Transmission],[CubicCapacity],[EmissionClass],
	[NumberOfSeats],[GVW],[LoadCapacity],[OperatingHours],[Description])
	VALUES(@AnnoucementID ,@UserID ,@VehicleType ,@Views ,@Promoted ,@Active ,@CreationDate ,@Update ,@Condition ,
	@Title ,@Brand ,@Model ,@Type ,@Kilometer ,@FabricationYear ,@VIN ,@FuelType ,@Price ,@NegociablePrice ,
	@Currency ,@Color ,@ColorType ,@Power ,@Transmission ,@CubicCapacity ,@EmissionClass ,@NumberOfSeats ,@GVW ,
	@LoadCapacity ,@OperatingHours ,@Description)
END
GO


CREATE PROCEDURE dbo.Options_Insert
(
	@OptionID uniqueidentifier,
	@Name nvarchar(50)
)
AS
BEGIN
	INSERT INTO [Options]([OptionID],[Name])
	VALUES(@OptionID,@Name)
END
GO

CREATE PROCEDURE dbo.AnnouncementsOptions_Insert
(
	@AnnoucementID uniqueidentifier,
	@OptionID uniqueidentifier
)
AS
BEGIN
	INSERT INTO [AnnouncementsOptions]([AnnoucementID],[OptionID])
	VALUES(@AnnoucementID,@OptionID)
END
GO

CREATE PROCEDURE dbo.MessageInbox_Insert
(
	@MessageID uniqueidentifier,
	@UserID uniqueidentifier,
	@AnnoucementID uniqueidentifier,
	@CreationDate datetime,
	@Read bit,
	@MesageContent text
)
AS
BEGIN
	INSERT INTO [MessageInbox]([MessageID],[UserID],[AnnoucementID],[CreationDate],[Read],[MesageContent])
	VALUES(@MessageID,@UserID,@AnnoucementID,@CreationDate,@Read,@MesageContent)
END
GO

CREATE PROCEDURE dbo.Pictures_Insert
(
	@PictureID uniqueidentifier,
	@Image image
)
AS
BEGIN
	INSERT INTO [Pictures]([PictureID],[Image])
	VALUES(@PictureID,@Image)
END
GO

CREATE PROCEDURE dbo.UsersPictures_Insert
(
	@UserID uniqueidentifier,
	@PictureID uniqueidentifier
)
AS
BEGIN
	INSERT INTO [UsersPictures]([UserID],[PictureID])
	VALUES(@UserID,@PictureID)
END
GO

CREATE PROCEDURE dbo.AnnouncementsPictures_Insert
(
	@PictureID uniqueidentifier,
	@AnnoucementID uniqueidentifier,
	@PrimaryPicture bit
)
AS
BEGIN
	INSERT INTO [AnnouncementsPictures]([PictureID],[AnnoucementID],[PrimaryPicture])
	VALUES(@PictureID,@AnnoucementID,@PrimaryPicture)
END
GO

--STORED PROCEDURES UPDATE

CREATE PROCEDURE dbo.Users_UpdateByID
(
	@UserID uniqueidentifier,
	@Email nvarchar(50),
	@UserName nvarchar(50),
	@Password nvarchar(50),
	@PhoneNumber nvarchar(50),
	@Subscribed bit
)
AS
BEGIN
	UPDATE [Users] SET
	[Email] = @Email,
	[UserName] =@UserName,
	[Password] =  @Password,
	[PhoneNumber] = @PhoneNumber,
	[Subscribed] = @Subscribed
	WHERE [UserID] = @UserID
END
GO

CREATE PROCEDURE dbo.UserLocation_UpdateByID
(
	@UserID uniqueidentifier,
	@Country nvarchar(50),
	@County nvarchar(50),
	@City nvarchar(50)
)
AS
BEGIN
	UPDATE [UserLocation] SET
	[Country] = @Country,
	[County] = @County,
	[City] = @City
	WHERE [UserID] = @UserID
END
GO

CREATE PROCEDURE dbo.Announcements_UpdateByID
(
	@AnnoucementID uniqueidentifier,
	@VehicleType int,
	@Views int,
	@Promoted bit,
	@Active bit,
	@CreationDate datetime,
	@Update datetime,
	@Condition nvarchar(15),
	@Title nvarchar(50),
	@Brand nvarchar(50),
	@Model nvarchar(50),
	@Type nvarchar(50),
	@Kilometer int,
	@FabricationYear int,
	@VIN nvarchar(50),
	@FuelType nvarchar(25),
	@Price int,
	@NegociablePrice bit,
	@Currency nvarchar(3),
	@Color nvarchar(15),
	@ColorType nvarchar(15),
	@Power int,
	@Transmission nvarchar(25),
	@CubicCapacity int,
	@EmissionClass nvarchar(15),
	@NumberOfSeats int,
	@GVW int,
	@LoadCapacity int,
	@OperatingHours int,
	@Description text
)
AS
BEGIN
	UPDATE [Announcements] SET
	[VehicleType] = @VehicleType,
	[Views] = @Views,
	[Promoted] = @Promoted,
	[Active] = @Active,
	[CreationDate] = @CreationDate,
	[Update] = @Update,
	[Condition] = @Condition,
	[Title] = @Title,
	[Brand] = @Brand,
	[Model] = @Model,
	[Type] = @Type,
	[Kilometer] = @Kilometer,
	[FabricationYear] = @FabricationYear,
	[VIN] = @VIN,
	[FuelType] = @FuelType,
	[Price] = @Price,
	[NegociablePrice] = @NegociablePrice,
	[Currency] = @Currency,
	[Color] = @Color,
	[ColorType] = @ColorType,
	[Power] = @Power,
	[Transmission] = @Transmission,
	[CubicCapacity] = @CubicCapacity,
	[EmissionClass] = @EmissionClass,
	[NumberOfSeats] = @NumberOfSeats,
	[GVW] = @GVW,
	[LoadCapacity] = @LoadCapacity,
	[OperatingHours] = @OperatingHours,
	[Description] =  @Description
	WHERE [AnnoucementID] = @AnnoucementID
END
GO


CREATE PROCEDURE dbo.Options_UpdateByID
(
	@OptionID uniqueidentifier,
	@Name nvarchar(50)
)
AS
BEGIN
	UPDATE [Options] SET
	[Name] = @Name
	WHERE [OptionID] = @OptionID
END
GO

CREATE PROCEDURE dbo.AnnouncementsOptions_UpdateByID
(
	@AnnoucementID uniqueidentifier,
	@OptionID nvarchar(50)
)
AS
BEGIN
	UPDATE [AnnouncementsOptions] SET
	[OptionID] = @OptionID
	WHERE [AnnoucementID] = @AnnoucementID
END
GO

CREATE PROCEDURE dbo.MessageInbox_UpdateByID
(
	@MessageID uniqueidentifier,
	@Read bit,
	@MesageContent text
)
AS
BEGIN
	UPDATE [MessageInbox] SET
	[Read] = @Read,
	[MesageContent] = @MesageContent
	WHERE [MessageID] = @MessageID
END
GO

CREATE PROCEDURE dbo.Pictures_UpdateByID
(
	@PictureID uniqueidentifier,
	@Image image
)
AS
BEGIN
	UPDATE [Pictures] SET
	[Image] = @Image
	WHERE [PictureID] = @PictureID
END
GO

CREATE PROCEDURE dbo.UsersPictures_UpdateByID
(
	@UserID uniqueidentifier,
	@PictureID uniqueidentifier
)
AS
BEGIN
	UPDATE [UsersPictures] SET
	[PictureID] = @PictureID
	WHERE [UserID] = @UserID
END
GO

CREATE PROCEDURE dbo.AnnouncementsPictures_UpdateByID
(
	@PictureID uniqueidentifier,
	@PrimaryPicture bit
)
AS
BEGIN
	UPDATE [AnnouncementsPictures] SET
	[PrimaryPicture] = @PrimaryPicture
	WHERE [PictureID] = @PictureID
END
GO

--STORED PROCEDURES DELETE

CREATE PROCEDURE dbo.Users_DeleteByID
(
	@UserID uniqueidentifier
)
AS
BEGIN

	DELETE FROM [Users]
	WHERE [UserID] = @UserID
END
GO

CREATE PROCEDURE dbo.UserLocation_DeleteByID
(
	@UserID uniqueidentifier
)
AS
BEGIN
	DELETE  FROM [UserLocation]
	WHERE [UserID] = @UserID
END
GO

CREATE PROCEDURE dbo.Announcements_DeleteByID
(
	@AnnoucementID uniqueidentifier
)
AS
BEGIN
	DELETE  FROM [Announcements]
	WHERE [AnnoucementID] = @AnnoucementID
END
GO

CREATE PROCEDURE dbo.Options_DeleteByID
(
	@OptionID uniqueidentifier
)
AS
BEGIN
	DELETE  FROM [Options]
	WHERE [OptionID] = @OptionID
END
GO

CREATE PROCEDURE dbo.AnnouncementsOptions_DeleteByID
(
	@AnnoucementID uniqueidentifier,
	@OptionID uniqueidentifier
)
AS
BEGIN
	DELETE  FROM [AnnouncementsOptions]
	WHERE [AnnoucementID] = @AnnoucementID AND [OptionID] = @OptionID
END
GO
----

CREATE PROCEDURE dbo.MessageInbox_DeleteByID
(
	@MessageID uniqueidentifier
)
AS
BEGIN
	DELETE  FROM [MessageInbox]
	WHERE [MessageID] = @MessageID
END
GO

CREATE PROCEDURE dbo.Pictures_DeleteByID
(
	@PictureID uniqueidentifier
)
AS
BEGIN
	DELETE  FROM [Pictures]
	WHERE [PictureID] = @PictureID
END
GO

CREATE PROCEDURE dbo.UsersPictures_DeleteByID
(
	@UserID uniqueidentifier
)
AS
BEGIN
	DELETE  FROM [UsersPictures]
	WHERE [UserID] = @UserID
END
GO

CREATE PROCEDURE dbo.AnnouncementsPictures_DeleteByID
(
	@PictureID uniqueidentifier
)
AS
BEGIN
	DELETE  FROM [AnnouncementsPictures]
	WHERE [PictureID] = @PictureID
END
GO

-- STORED PROCEDURE READ

CREATE PROCEDURE dbo.Users_ReadAll
AS
BEGIN
	SELECT  [UserID],
			[Email],
			[UserName],
			[Password],
			[PhoneNumber],
			[CreationDate],
			[Subscribed]
	FROM	[Users]
END
GO



CREATE PROCEDURE dbo.Users_ReadByID
(
@UserID uniqueidentifier
)
AS
BEGIN
	SELECT  [UserID],
			[Email],
			[UserName],
			[Password],
			[PhoneNumber],
			[CreationDate],
			[Subscribed]
	FROM	[Users]
	WHERE	[UserID] = @UserID
END
GO

CREATE PROCEDURE dbo.Users_Read_SingIn
(
@Email nvarchar(50),
@UserName nvarchar(50),
@PhoneNumber nvarchar(50)
)
AS
BEGIN
	SELECT  [Email],
			[UserName],
			[PhoneNumber]
	FROM	[Users]
	WHERE	[Email] = @Email OR
			[UserName] = @UserName OR
			[PhoneNumber] = @PhoneNumber
END
GO

CREATE PROCEDURE dbo.Users_Read_LogIn
(
@Email nvarchar(50),
@Password nvarchar(50)
)
AS
BEGIN
	SELECT  UserID			
	FROM	[Users]
	WHERE	[Email] = @Email AND
			[Password] = @Password
END
GO

CREATE PROCEDURE dbo.UserLocation_ReadAll
AS
BEGIN
	SELECT  [UserID],
			[Country],
			[County],
			[City]
	FROM	[UserLocation]
END
GO

CREATE PROCEDURE dbo.UserLocation_ReadByID
(
@UserID uniqueidentifier
)
AS
BEGIN
	SELECT  [UserID],
			[Country],
			[County],
			[City]
	FROM	[UserLocation]
	WHERE	[UserID] = @UserID
END
GO

CREATE PROCEDURE dbo.Users_UserLocation_ReadByID
(
@UserID uniqueidentifier
)
AS
BEGIN
	SELECT  u.UserID,
			u.Email,
			u.UserName,
			u.PhoneNumber,
			l.Country,
			l.County,
			l.City
	FROM [Users] u
		INNER JOIN [UserLocation] l ON l.[UserID] = u.[UserID]
	WHERE u.[UserID] = @UserID
END
GO

CREATE PROCEDURE dbo.Users_MessageInbox_ReadByID
(
@UserID uniqueidentifier
)
AS
BEGIN
	SELECT  u.UserID,
			u.UserName,
			m.MessageID,
			m.AnnoucementID,
			m.CreationDate,
			m.[Read],
			m.MesageContent
	FROM [Users] u
		INNER JOIN MessageInbox m ON m.[UserID] = u.[UserID]
	WHERE u.[UserID] = @UserID
END
GO

CREATE PROCEDURE dbo.MessageInbox_ReadByUserID
(
@UserID uniqueidentifier
)
AS
BEGIN
	SELECT  MessageID,
			AnnoucementID,
			CreationDate,
			[Read],
			MesageContent
	FROM MessageInbox
	WHERE [UserID] = @UserID
END
GO

CREATE PROCEDURE dbo.MessageInbox_ReadByAnnouncementsID
(
@AnnoucementID uniqueidentifier
)
AS
BEGIN
	SELECT  MessageID,
			UserID,
			AnnoucementID,
			CreationDate,
			[Read],
			MesageContent
	FROM MessageInbox
	WHERE AnnoucementID = @AnnoucementID
END
GO

CREATE PROCEDURE dbo.Announcements_ReadAll
AS
BEGIN
	SELECT  [AnnoucementID],
			[UserID],
			[VehicleType],
			[Views],
			[Promoted],
			[Active],
			[CreationDate],
			[Update],
			[Condition],
			[Title],
			[Brand],
			[Model],
			[Type],
			[Kilometer],
			[FabricationYear],
			[VIN],
			[FuelType],
			[Price],
			[NegociablePrice],
			[Currency],
			[Color],
			[ColorType],
			[Power],
			[Transmission],
			[CubicCapacity],
			[EmissionClass],
			[NumberOfSeats],
			[GVW],
			[LoadCapacity],
			[OperatingHours],
			[Description]
	FROM	[Announcements]
END
GO

CREATE PROCEDURE dbo.Announcements_ReadByID
(
@AnnoucementID uniqueidentifier
)
AS
BEGIN
	SELECT  [AnnoucementID],
			[UserID],
			[VehicleType],
			[Views],
			[Promoted],
			[Active],
			[CreationDate],
			[Update],
			[Condition],
			[Title],
			[Brand],
			[Model],
			[Type],
			[Kilometer],
			[FabricationYear],
			[VIN],
			[FuelType],
			[Price],
			[NegociablePrice],
			[Currency],
			[Color],
			[ColorType],
			[Power],
			[Transmission],
			[CubicCapacity],
			[EmissionClass],
			[NumberOfSeats],
			[GVW],
			[LoadCapacity],
			[OperatingHours],
			[Description]
	FROM	[Announcements]
	WHERE	[AnnoucementID] = @AnnoucementID
END
GO

CREATE PROCEDURE dbo.Announcements_Users_ReadByID
(
@UserID uniqueidentifier
)
AS
BEGIN
	SELECT  [AnnoucementID],
			[UserID],
			[VehicleType],
			[Views],
			[Promoted],
			[Active],
			[CreationDate],
			[Update],
			[Condition],
			[Title],
			[Brand],
			[Model],
			[Type],
			[Kilometer],
			[FabricationYear],
			[VIN],
			[FuelType],
			[Price],
			[NegociablePrice],
			[Currency],
			[Color],
			[ColorType],
			[Power],
			[Transmission],
			[CubicCapacity],
			[EmissionClass],
			[NumberOfSeats],
			[GVW],
			[LoadCapacity],
			[OperatingHours],
			[Description]
	FROM	[Announcements]
	WHERE	[UserID] = @UserID
END
GO

CREATE PROCEDURE dbo.Announcements_MainSearch
(
@VehicleType int,
@Condition nvarchar(15),
@Brand nvarchar(50),
@Model nvarchar(50),
@Kilometer int,
@FabricationYear int,
@FuelType1 nvarchar(25),
@FuelType2 nvarchar(25),
@FuelType3 nvarchar(25),
@FuelType4 nvarchar(25),
@FuelType5 nvarchar(25),
@FuelType6 nvarchar(25),
@FuelType7 nvarchar(25),
@Price int
)
AS
BEGIN
	SELECT  a.[AnnoucementID],
			a.[UserID],
			a.[Promoted],			
			a.[Title],
			a.[Brand],
			a.[Model],
			a.[Kilometer],
			a.[FabricationYear],
			a.[FuelType],
			a.[Price],
			a.[Power],
			u.UserName,
			l.Country,
			l.County
	FROM	Announcements a
		INNER JOIN Users u ON u.[UserID] = a.[UserID]
		LEFT JOIN [UserLocation] l ON l.[UserID] = u.[UserID]
	WHERE	Active = 1 AND 
			[VehicleType] = @VehicleType AND 
			(Condition = @Condition OR @Condition = 'All') AND
			(@Brand = 'Any' OR [Brand] = @Brand) AND
			(@Model = 'Any' OR [Model] = @Model) AND
			[Kilometer] <= @Kilometer AND
			[FabricationYear] >= @FabricationYear AND
			([FuelType] = @FuelType1 OR [FuelType] = @FuelType2 OR 
			[FuelType] = @FuelType3 OR [FuelType] = @FuelType4 OR 
			[FuelType] = @FuelType5 OR [FuelType] = @FuelType6 OR 
			[FuelType] = @FuelType7) AND
			[Price] <= @Price
		
END
GO

CREATE PROCEDURE dbo.Options_ReadAll
AS
BEGIN
	SELECT  [OptionID],
			[Name]
	FROM	[Options]
END
GO

CREATE PROCEDURE dbo.Options_ReadByID
(
@OptionID uniqueidentifier
)
AS
BEGIN
	SELECT  [OptionID],
			[Name]
	FROM	[Options]
	WHERE	[OptionID] = @OptionID
END
GO

CREATE PROCEDURE dbo.AnnouncementsOptions_ReadByID
(
@AnnoucementID uniqueidentifier
)
AS
BEGIN
	SELECT  [AnnoucementID],
			[OptionID]
	FROM	[AnnouncementsOptions]
	WHERE	[AnnoucementID] = @AnnoucementID
END
GO

CREATE PROCEDURE dbo.MessageInbox_ReadByID
(
@MessageID uniqueidentifier
)
AS
BEGIN
	SELECT  [MessageID],
			[UserID],
			[AnnoucementID],
			[CreationDate],
			[Read],
			[MesageContent]
	FROM	[MessageInbox]
	WHERE	[MessageID] = @MessageID
END
GO

CREATE PROCEDURE dbo.Pictures_ReadByID
(
@PictureID uniqueidentifier
)
AS
BEGIN
	SELECT  [PictureID],
			[Image]
	FROM	[Pictures]
	WHERE	[PictureID] = @PictureID
END
GO

CREATE PROCEDURE dbo.Pictures_ReadAll
AS
BEGIN
	SELECT  [PictureID],
			[Image]
	FROM	[Pictures]
END
GO

CREATE PROCEDURE dbo.UsersPictures_ReadAll
AS
BEGIN
	SELECT  [UserID],
			[PictureID]
	FROM	[UsersPictures]
END
GO

CREATE PROCEDURE dbo.UsersPictures_ReadByID
(
@UserID uniqueidentifier
)
AS
BEGIN
	SELECT  [UserID],
			[PictureID]
	FROM	[UsersPictures]
	WHERE	[UserID] = @UserID
END
GO

CREATE PROCEDURE dbo.AnnouncementsPictures_ReadAllPicturesByID
(
@AnnoucementID uniqueidentifier
)
AS
BEGIN
	SELECT  [PictureID],
			[AnnoucementID],
			[PrimaryPicture]
	FROM	[AnnouncementsPictures]
	WHERE	[AnnoucementID] = @AnnoucementID
END
GO

-- CREATE NONCLUSTERED INDEX index_clustered ON Users(UserId asc)