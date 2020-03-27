CREATE DATABASE [scheduler]
 CONTAINMENT = NONE
 ON  PRIMARY
( NAME = N'scheduler', FILENAME = N'C:\SQLData\scheduler.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON
( NAME = N'scheduler_log', FILENAME = N'C:\SQLData\scheduler_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO
CREATE DATABASE [kapplets]
 CONTAINMENT = NONE
 ON  PRIMARY
( NAME = N'kapplets', FILENAME = N'C:\SQLData\kapplets.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON
( NAME = N'kapplets_log', FILENAME = N'C:\SQLData\kapplets_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO
