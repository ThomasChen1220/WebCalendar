CREATE DATABASE  IF NOT EXISTS `A3`;
USE `A3`;

DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `userEmail` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `img_link` varchar(150) NOT NULL,
  PRIMARY KEY (`userEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Events`;
CREATE TABLE `Events` (
  `eventID` int(11) NOT NULL AUTO_INCREMENT,
  `dateTime` varchar(30) NOT NULL,
  `summary` varchar(200) NOT NULL,
  `userEmail`  varchar(50) NOT NULL,
  PRIMARY KEY (`eventID`),
  FOREIGN KEY (`userEmail`) REFERENCES `Users` (`userEmail`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Following`;
CREATE TABLE `Following` (
  `followingID` int(11) NOT NULL AUTO_INCREMENT,
  `followerEmail` varchar(50) NOT NULL,
  `followedEmail` varchar(50) NOT NULL,
  PRIMARY KEY (`followingID`),
  FOREIGN KEY (`followerEmail`) REFERENCES `Users` (`userEmail`),
  FOREIGN KEY (`followedEmail`) REFERENCES `Users` (`userEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;