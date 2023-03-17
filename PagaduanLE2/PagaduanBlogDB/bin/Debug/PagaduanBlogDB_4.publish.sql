﻿/*
Deployment script for BlogDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BlogDB"
:setvar DefaultFilePrefix "BlogDB"
:setvar DefaultDataPath "C:\Users\CARLOS PAGADUAN\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\CARLOS PAGADUAN\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Altering Procedure [dbo].[spPosts_Insert]...';


GO
ALTER PROCEDURE [dbo].[spPosts_Insert]
	@userId int,
	@title nvarchar(150),
	@body text,
	@dateCreated datetime2
AS
begin
	INSERT INTO dbo.Posts
	(UserId, Title, Body, DateCreated)
	VALUES
	(@userId, @title, @body, 
@dateCreated)
end
GO
PRINT N'Update complete.';


GO
