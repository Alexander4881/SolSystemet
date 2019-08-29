DROP DATABASE IF EXISTS `SolarSystem`;
CREATE DATABASE `SolarSystem`;

USE `SolarSystem`;

-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;massdircirplanet3dinfo

-- ---
-- Table 'Planet'
-- 
-- ---

DROP TABLE IF EXISTS `Planet`;
		
CREATE TABLE `Planet` (
  `PlanetName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `TypeName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  PRIMARY KEY (`PlanetName`)
);

-- ---
-- Table 'PlanetType'
-- 
-- ---

DROP TABLE IF EXISTS `PlanetType`;
		
CREATE TABLE `PlanetType` (
  `TypeName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `PTDescription` MEDIUMTEXT NOT NULL ,
  PRIMARY KEY (`TypeName`)
);

-- ---
-- Table 'Moons'
-- 
-- ---

DROP TABLE IF EXISTS `Moons`;
		
CREATE TABLE `Moons` (
  `MoonName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `PlanetName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  PRIMARY KEY (`MoonName`)
);

-- ---
-- Table 'MassDirCir'
-- 
-- ---

DROP TABLE IF EXISTS `MassDirCir`;
		
CREATE TABLE `MassDirCir` (
  `PlanetName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `Mass` DOUBLE NOT NULL DEFAULT 0.00,
  `MassName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `Circumference` DOUBLE NOT NULL DEFAULT 0.00,
  `CDistanceName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `Diameter` DOUBLE NOT NULL DEFAULT 0.00,
  `DDistanceName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `MDCDescription` MEDIUMTEXT NOT NULL ,
  PRIMARY KEY (`PlanetName`)
);

-- ---
-- Table 'MassMesurement'
-- 
-- ---

DROP TABLE IF EXISTS `MassMesurement`;
		
CREATE TABLE `MassMesurement` (
  `MassName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `FullMassName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `MMDescription` MEDIUMTEXT NOT NULL ,
  PRIMARY KEY (`MassName`)
);

-- ---
-- Table 'DistanceMesurement'
-- 
-- ---

DROP TABLE IF EXISTS `DistanceMesurement`;
		
CREATE TABLE `DistanceMesurement` (
  `DistanceName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `FullDistanceName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `DMDescription` MEDIUMTEXT NOT NULL ,
  PRIMARY KEY (`DistanceName`)
);

-- ---
-- Added tables
-- Table 'Planet3DInfo'
-- 
-- ---

DROP TABLE IF EXISTS `Planet3DInfo`;
		
CREATE TABLE `Planet3DInfo` (
  `PlanetName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `PlanetTextureSrc` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `PlanetSize` DOUBLE NOT NULL DEFAULT 0.00,
  `DistanceFromCenter` DOUBLE NOT NULL DEFAULT 0.00,
  `OrbitRate` DOUBLE NOT NULL DEFAULT 0.00,
  `RotationRate` DOUBLE NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`PlanetName`)
);

DROP TABLE IF EXISTS `Moon3DInfo`;
CREATE TABLE `Moon3DInfo` (
  `MoonName`  VARCHAR(255) NOT NULL DEFAULT 'NULL', -- 1
  `PlanetName` VARCHAR(255) NOT NULL DEFAULT 'NULL', -- 2
  `MoonTextureSrc` VARCHAR(255) NOT NULL DEFAULT 'NULL', -- 3
  `MoonSize` DOUBLE NOT NULL DEFAULT 0.00, -- 4
  `DistanceFromPlanet` DOUBLE NOT NULL DEFAULT 0.00, -- 5
  `OrbitRate` DOUBLE NOT NULL DEFAULT 0.00, -- 6
  `RotationRate` DOUBLE NOT NULL DEFAULT 0.00, -- 7
  `OrbitSize` DOUBLE NOT NULL DEFAULT 0.00, -- 8
  `InnerSize` DOUBLE NOT NULL DEFAULT 0.00, -- 9
  `FaceRoundness` INT NOT NULL DEFAULT 0, -- 10
  `FaceDigRound` DOUBLE NOT NULL DEFAULT 0, -- 11
  `Color` VARCHAR(8), -- 12
  PRIMARY KEY (`MoonName`)
);

-- ---
-- Table 'MazeData'
-- 
-- ---

DROP TABLE IF EXISTS `MazeData`;
		
CREATE TABLE `MazeData` (
  `PlanetName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `ImgSrc` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  PRIMARY KEY (`PlanetName`)
);

-- ---
-- Table 'MazeQuestionAnswer'
-- 
-- ---

DROP TABLE IF EXISTS `MazeQuestionAnswer`;
		
CREATE TABLE `MazeQuestionAnswer` (
  `PlanetName` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `Question` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `Answer` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  PRIMARY KEY (`PlanetName`, `Question`)
);

-- ---
-- Table 'MazeQuestion'
-- 
-- ---

DROP TABLE IF EXISTS `MazeQuestion`;
		
CREATE TABLE `MazeQuestion` (
  `Question` VARCHAR(255) NOT NULL DEFAULT 'NULL',
  `QuestionText` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`Question`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `Planet` ADD FOREIGN KEY (TypeName) REFERENCES `PlanetType` (`TypeName`);
ALTER TABLE `Moons` ADD FOREIGN KEY (PlanetName) REFERENCES `Planet` (`PlanetName`);
ALTER TABLE `MassDirCir` ADD FOREIGN KEY (PlanetName) REFERENCES `Planet` (`PlanetName`);
ALTER TABLE `MassDirCir` ADD FOREIGN KEY (MassName) REFERENCES `MassMesurement` (`MassName`);
ALTER TABLE `MassDirCir` ADD FOREIGN KEY (CDistanceName) REFERENCES `DistanceMesurement` (`DistanceName`);
ALTER TABLE `MassDirCir` ADD FOREIGN KEY (DDistanceName) REFERENCES `DistanceMesurement` (`DistanceName`);
ALTER TABLE `Moon3DInfo` ADD FOREIGN KEY (PlanetName) REFERENCES `Planet3DInfo` (`PlanetName`);
-- ---
-- Added alter tables
-- ---

ALTER TABLE solarsystem.planet3dinfo ADD FOREIGN KEY (PlanetName) REFERENCES solarsystem.planet (PlanetName);
ALTER TABLE `MazeData` ADD FOREIGN KEY (PlanetName) REFERENCES `Planet` (`PlanetName`);
ALTER TABLE `MazeQuestionAnswer` ADD FOREIGN KEY (PlanetName) REFERENCES `MazeData` (`PlanetName`);
ALTER TABLE `MazeQuestionAnswer` ADD FOREIGN KEY (Question) REFERENCES `MazeQuestion` (`Question`);


-- ---
-- Table Properties
-- ---

-- ALTER TABLE `Planet` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PlanetType` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Moons` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `MassDirCir` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `MassMesurement` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `DistanceMesurement` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `Planet` (`PlanetName`,`TypeName`) VALUES
-- ('','');
-- INSERT INTO `PlanetType` (`TypeName`,`Desciption`) VALUES
-- ('','');
-- INSERT INTO `Moons` (`MoonName`,`PlanetName`) VALUES
-- ('','');
-- INSERT INTO `MassDirCir` (`Name`,`Mass`,`MassName`,`Circumference`,`DistanceName`,`Diameter`,`DistanceName`,`Description`) VALUES
-- ('','','','','','','','');
-- INSERT INTO `MassMesurement` (`MassName`,`FullMassName`,`Description`) VALUES
-- ('','','');
-- INSERT INTO `DistanceMesurement` (`DistanceName`,`FullDistanceName`,`Description`) VALUES
-- ('','','');

INSERT INTO planettype (planettype.TypeName, planettype.PTDescription)
VALUES
('Sol',
'En kæmpe ildkugle som der rotere planeter rundt om, også kendt som en stjerne');

INSERT INTO planettype (planettype.TypeName, planettype.PTDescription)
VALUES
('Gas',
'En planet som består af rent gas, der er ikke nogen fysisk overflade');

INSERT INTO planettype (planettype.TypeName, planettype.PTDescription)
VALUES
('Solid',
'En normal planet som vi kender, ligesom jorden, med solid overflade som man kan gå på');

INSERT INTO planettype (planettype.TypeName, planettype.PTDescription)
VALUES
('Dværgplanet',
'En planet som er meget lille, mindre en mange måner, men som stadig rotere rundt om solen');

INSERT INTO distancemesurement (distancename, fulldistancename, dmdescription)
VALUES ('mm', 'milimeter', '100mm = 1cm');

INSERT INTO distancemesurement (distancename, fulldistancename, dmdescription)
VALUES ('cm', 'centimeter', '100cm = 1m');

INSERT INTO distancemesurement (distancename, fulldistancename, dmdescription)
VALUES ('m', 'meter', '1000m = 1km');

INSERT INTO distancemesurement (distancename, fulldistancename, dmdescription)
VALUES ('km', 'kilometer', '9,5km = 1ly');

INSERT INTO distancemesurement (distancename, fulldistancename, dmdescription)
VALUES ('ly', 'lysår', 'pas');

INSERT INTO massmesurement (massname, fullmassname, mmdescription)
VALUES ('mm3', 'kubikmilimeter', 'milimeter i tredje');

INSERT INTO massmesurement (massname, fullmassname, mmdescription)
VALUES ('cm3', 'kubikcentimeter', 'centimeter i tredje');

INSERT INTO massmesurement (massname, fullmassname, mmdescription)
VALUES ('m3', 'kubikmeter', 'meter i tredje');

INSERT INTO massmesurement (massname, fullmassname, mmdescription)
VALUES ('km3', 'kubikkilometer', 'kilometer i tredje');

INSERT INTO massmesurement (massname, fullmassname, mmdescription)
VALUES ('ly3', 'kubiklysår', 'lysår i tredje');

INSERT INTO planet (planetname, typename)
VALUES ('Solen', 
'Sol');

INSERT INTO planet (planetname, typename)
VALUES ('Merkur',
'Solid');

INSERT INTO planet (planetname, typename)
VALUES ('Venus',
'Solid');

INSERT INTO planet (planetname, typename) 
VALUES ('Jorden', 
'Solid');

INSERT INTO planet (planetname, typename)
VALUES ('Mars',
'Solid');

INSERT INTO planet (planetname, typename)
VALUES ('Jupiter',
'Gas');

INSERT INTO planet (planetname, typename)
VALUES ('Saturn',
'Gas');

INSERT INTO planet (planetname, typename)
VALUES ('Uranus',
'Gas');

INSERT INTO planet (planetname, typename)
VALUES ('Neptun',
'Gas');

INSERT INTO planet (planetname, typename)
VALUES ('Pluto',
'Dværgplanet');

INSERT INTO moons (moonname, planetname)
VALUES ('Månen', 'Jorden');

INSERT INTO moons (moonname, planetname)
VALUES ('Deimos', 'Mars');

INSERT INTO moons (moonname, planetname)
VALUES ('Phobos', 'Mars');

INSERT INTO moons (moonname, planetname)
VALUES ('Adrastea', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Aitne', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Amalthea', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Ananke', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Aoede', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Arche', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Autonoe', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Callisto', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Carme', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Callirrhoe', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Carpo', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Chaldene', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Cyllene', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Elara', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Erinome', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Euanthe', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Eukelade', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Euporie', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Europa', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Eurydome', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Ganymede', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Harpalyke', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Hegemone', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Helike', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Hermippe', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Himalia', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Io', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Iocaste', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Isonoe', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Kale', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Kallichore', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Kalyke', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Kore', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Leda', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Lysithea', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Magaclite', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Metis', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Mneme', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Orthosie', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Pasiphae', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Pasithee', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Praxidike', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Sinope', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Sponde', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2000 J11', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2003 J2', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2003 J3', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2003 J4', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2003 J5', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2003 J9', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2003 J10', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2003 J12', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2003 J15', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2003 J16', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2003 J17', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2003 J18', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2003 J19', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2003 J23', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Taygete', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Thebe', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Thelxinoe', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Themisto', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Thyone', 'Jupiter');

INSERT INTO moons (moonname, planetname)
VALUES ('Aegir', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Albiorix', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Anthe', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Atlas', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Bebhionn', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Bergelmir', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Bestla', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Calypso', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Daphnis', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Dione', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Enceladus', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Epimetheus', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Erriapo', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Farbauti', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Fenrir', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Fornjot', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Greip', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Hati', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Helene', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Hyperion', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Hyrokkin', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Iapetus', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Ijiraq', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Janus', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Jarnsaxa', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Kari', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Kiviuq', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Loge', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Methone', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Mimas', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Mundilfari', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Narvi', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Paaliaq', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Pallene', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Pan', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Pandora', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Phoebe', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Polydeuces', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Prometheus', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Rhea', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Siarnaq', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Skathi', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Skoll', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Surtur', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Suttungr', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2004 S7', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2004 S12', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2004 S13', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2004 S17', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2006 S1', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2006 S3', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2007 S2', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('S/2007 S3', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Tarqeq', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Tarvos', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Telesto', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Tethys', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Thrymr', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Titan', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Ymir', 'Saturn');

INSERT INTO moons (moonname, planetname)
VALUES ('Ariel', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Belinda', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Bianca', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Caliban', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Cordelia', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Cressida', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Cupid', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Desdemona', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Ferdinand', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Francisco', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Juliet', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Mab', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Margaret', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Miranda', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Oberon', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Ophelia', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Perdita', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Portia', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Prospero', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Puck', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Rosalind', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Setebos', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Stephano', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Sycorax', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Titania', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Trinculo', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Umbriel', 'Uranus');

INSERT INTO moons (moonname, planetname)
VALUES ('Despina', 'Neptun');

INSERT INTO moons (moonname, planetname)
VALUES ('Galatea', 'Neptun');

INSERT INTO moons (moonname, planetname)
VALUES ('Halimede', 'Neptun');

INSERT INTO moons (moonname, planetname)
VALUES ('Larissa', 'Neptun');

INSERT INTO moons (moonname, planetname)
VALUES ('Laomedeia', 'Neptun');

INSERT INTO moons (moonname, planetname)
VALUES ('Naiad', 'Neptun');

INSERT INTO moons (moonname, planetname)
VALUES ('Nereid', 'Neptun');

INSERT INTO moons (moonname, planetname)
VALUES ('Neso', 'Neptun');

INSERT INTO moons (moonname, planetname)
VALUES ('Proteus', 'Neptun');

INSERT INTO moons (moonname, planetname)
VALUES ('Psamathe', 'Neptun');

INSERT INTO moons (moonname, planetname)
VALUES ('Sao', 'Neptun');

INSERT INTO moons (moonname, planetname)
VALUES ('Thalassa', 'Neptun');

INSERT INTO moons (moonname, planetname)
VALUES ('Triton', 'Neptun');

INSERT INTO moons (moonname, planetname)
VALUES ('Charon', 'Pluto');

INSERT INTO moons (moonname, planetname)
VALUES ('Nix', 'Pluto');

INSERT INTO moons (moonname, planetname)
VALUES ('Hydra', 'Pluto');

INSERT INTO massdircir (planetname, mass, massname, circumference, cdistancename, diameter, ddistancename, mdcdescription)
VALUES ('Solen',
'1409000000000000000', 'km3',
'4379000', 'km',
'1391000', 'km',
'Hvis man gik lige igennem solen, er der 1.391.000km fra overflade til overflade,
 hvis man gik i en lige linje, hele vejen rundt om månen, så er der 4.379.000km');

INSERT INTO massdircir (planetname, mass, massname, circumference, cdistancename, diameter, ddistancename, mdcdescription)
VALUES ('Merkur',
'60830000000', 'km3',
'15329', 'km',
'4880', 'km',
'Hvis man gik lige igennem merkur, er der 4.880km fra overflade til overflade,
 hvis man gik i en lige linje, hele vejen rundt om månen, så er der 15.329km');
 
INSERT INTO massdircir (planetname, mass, massname, circumference, cdistancename, diameter, ddistancename, mdcdescription)
VALUES ('Venus',
'928430000000', 'km3',
'38025', 'km',
'12104', 'km',
'Hvis man gik lige igennem venus, er der 12.104km fra overflade til overflade,
 hvis man gik i en lige linje, hele vejen rundt om månen, så er der 38.025km');
 
INSERT INTO massdircir (planetname, mass, massname, circumference, cdistancename, diameter, ddistancename, mdcdescription)
VALUES ('Jorden',
'1083210000000', 'km3',
'40075', 'km',
'12742', 'km',
'Hvis man gik lige igennem Jorden, er der 12.742km fra overflade til overflade,
 hvis man gik i en lige linje, hele vejen rundt om månen, så er der 40.075km');
 
INSERT INTO massdircir (planetname, mass, massname, circumference, cdistancename, diameter, ddistancename, mdcdescription)
VALUES ('Mars',
'163180000000', 'km3',
'21344', 'km',
'6779', 'km',
'Hvis man gik lige igennem Mars, er der 6.779km fra overflade til overflade,
 hvis man gik i en lige linje, hele vejen rundt om månen, så er der 21.344km');
 
INSERT INTO massdircir (planetname, mass, massname, circumference, cdistancename, diameter, ddistancename, mdcdescription)
VALUES ('Jupiter',
'1431280000000000', 'km3',
'439264', 'km',
'139820', 'km',
'Hvis man gik lige igennem Jupiter, er der 139.820km fra overflade til overflade,
 hvis man gik i en lige linje, hele vejen rundt om månen, så er der 439.264km');
 
INSERT INTO massdircir (planetname, mass, massname, circumference, cdistancename, diameter, ddistancename, mdcdescription)
VALUES ('Saturn',
'827130000000000', 'km3',
'378675', 'km',
'116460', 'km',
'Hvis man gik lige igennem Saturn, er der 116.460km fra overflade til overflade,
 hvis man gik i en lige linje, hele vejen rundt om månen, så er der 378.675km');
 
INSERT INTO massdircir (planetname, mass, massname, circumference, cdistancename, diameter, ddistancename, mdcdescription)
VALUES ('Uranus',
'68330000000000', 'km3',
'160590', 'km',
'50724', 'km',
'Hvis man gik lige igennem uranus, er der 50.724km fra overflade til overflade,
 hvis man gik i en lige linje, hele vejen rundt om månen, så er der 160.590km');
 
INSERT INTO massdircir (planetname, mass, massname, circumference, cdistancename, diameter, ddistancename, mdcdescription)
VALUES ('Neptun',
'62540000000000', 'km3',
'155600', 'km',
'49244', 'km',
'Hvis man gik lige igennem neptun, er der 49.244km fra overflade til overflade,
 hvis man gik i en lige linje, hele vejen rundt om månen, så er der 155.600km');
 
INSERT INTO massdircir (planetname, mass, massname, circumference, cdistancename, diameter, ddistancename, mdcdescription)
VALUES ('Pluto',
'7150000000', 'km3',
'7232', 'km',
'2376', 'km',
'Hvis man gik lige igennem pluto, er der 2.376km fra overflade til overflade,
 hvis man gik i en lige linje, hele vejen rundt om månen, så er der 7.232km');

INSERT INTO planet3dinfo 
(PlanetName, PlanetTextureSrc, PlanetSize, DistanceFromCenter, OrbitRate, RotationRate) VALUES
('Solen', '/resources//texture/sun.jpg', 50, 0, 1, 0.001),
('Merkur', '/resources/texture/mercury.jpg', 0.38, 57, 80, 0.0015),
('Venus', '/resources/texture/venus.jpg', 0.8, 65, 225, 0.015),
('Jorden', '/resources/texture/earth.jpg', 1, 80, 365, 0.024),
('Mars', '/resources/texture/mars.jpg', 0.5, 90, 687, 0.015),
('Jupiter', '/resources/texture/jupiter.jpg', 8, 110, 4380, 0.015),
('Saturn', '/resources/texture/saturn.jpg', 8, 135, 10585, 0.005),
('Uranus', '/resources/texture/uranus.jpg', 3, 152, 30660, 0.015),
('Neptun', '/resources/texture/neptune.jpg', 3, 160, 60225, 0.015),
('Pluto', '/resources/texture/pluto.jpg', 0.2, 170, 90520, 0.015);

INSERT INTO moon3dinfo 
(moonName,	PlanetName,		moonTextureSrc, 					moonSize, 	DistanceFromPlanet, OrbitRate, 	RotationRate, 	OrbitSize, 	InnerSize, 	FaceRoundness, 	FaceDigRound, 	Color) VALUES
('månen',	'Jorden', 		'/resources/texture/moon.jpg', 		0.5, 		2.8, 				27, 		0.02, 			2.8, 		0.01, 		480, 			480, 			'0x757064'),
('saturnRing','Saturn', 	'null.jpg', 						0, 			0, 					0, 			0, 				11.3, 		2, 			2, 				480, 			'0x8D7E60');

INSERT INTO mazedata (PlanetName, ImgSrc) VALUES
('Merkur', '../Picture/Mercury.png'),
('Venus', '../Picture/Venus.png'),
('Mars', '../Picture/Mars.png'),
('Jupiter', '../Picture/Jupiter.png'),
('Saturn', '../Picture/Saturn.png'),
('Uranus', '../Picture/Uranus.png'),
('Neptun', '../Picture/Neptune.png'),
('Pluto', '../Picture/Pluto.png');


INSERT INTO mazequestion (Question, QuestionText) VALUES
('PlanetNumber', 'Hvad nummer har denne planet i solsystemt, hvis man tæller fra solen af'),
('PlanetMass', 'Hvad for en slags planet er dette');

INSERT INTO mazequestionanswer (PlanetName, Question, Answer) VALUES
('Merkur', 'PlanetNumber', '1'), ('Merkur', 'PlanetMass', 'Solid'),
('Venus', 'PlanetNumber', '2'), ('Venus', 'PlanetMass', 'Solid'),
('Mars', 'PlanetNumber', '4'), ('Mars', 'PlanetMass', 'Solid'),
('Jupiter', 'PlanetNumber', '5'), ('Jupiter', 'PlanetMass', 'Gas'),
('Saturn', 'PlanetNumber', '6'), ('Saturn', 'PlanetMass', 'Gas'),
('Uranus', 'PlanetNumber', '7'), ('Uranus', 'PlanetMass', 'Gas'),
('Neptun', 'PlanetNumber', '8'), ('Neptun', 'PlanetMass', 'Gas'),
('Pluto', 'PlanetNumber', '9'), ('Pluto', 'PlanetMass', 'Dværg');

DROP PROCEDURE IF EXISTS `All3DPlanetInformation`
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `All3DPlanetInformation`()
BEGIN
SELECT
	solarsystem.planet.PlanetName, -- 1 
	solarsystem.planet.TypeName, -- 2
	solarsystem.planettype.PTDescription, -- 3

	solarsystem.massdircir.Mass, -- 4
	solarsystem.massdircir.MassName, -- 5
	solarsystem.massmesurement.FullMassName, -- 6
	solarsystem.massmesurement.MMDescription, -- 7

	solarsystem.massdircir.Circumference, -- 8
	solarsystem.massdircir.CDistanceName, -- 9 
	distancemesurement1.FullDistanceName, -- 10 
	distancemesurement1.DMDescription, -- 11

	solarsystem.massdircir.Diameter, -- 12
	solarsystem.massdircir.DDistanceName, -- 13
	distancemesurement2.FullDistanceName, -- 14
	distancemesurement2.DMDescription, -- 15

	solarsystem.massdircir.MDCDescription, -- 16

	solarsystem.planet3dinfo.PlanetTextureSrc, -- 17
	solarsystem.planet3dinfo.PlanetSize, -- 18
	solarsystem.planet3dinfo.DistanceFromCenter, -- 19
	solarsystem.planet3dinfo.OrbitRate, -- 20
	solarsystem.planet3dinfo.RotationRate -- 21

FROM planet
 
INNER JOIN solarsystem.planettype on solarsystem.planet.TypeName = solarsystem.planettype.TypeName
INNER JOIN solarsystem.massdircir on solarsystem.planet.PlanetName = solarsystem.massdircir.PlanetName
INNER JOIN solarsystem.massmesurement on solarsystem.massdircir.MassName = solarsystem.massmesurement.MassName
INNER JOIN solarsystem.distancemesurement distancemesurement1 on solarsystem.massdircir.CDistanceName = distancemesurement1.DistanceName
INNER JOIN solarsystem.distancemesurement distancemesurement2 on solarsystem.massdircir.DDistanceName = distancemesurement2.DistanceName
INNER JOIN solarsystem.planet3dinfo ON solarsystem.planet.PlanetName = solarsystem.planet3dinfo.PlanetName;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS `3DMoonInformation`
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `3DMoonInformation`(IN `@PlanetName` VARCHAR(255))
BEGIN
	SELECT 
	solarsystem.moon3dinfo.MoonName,
    solarsystem.moon3dinfo.PlanetName,
    solarsystem.moon3dinfo.MoonTextureSrc,
    solarsystem.moon3dinfo.MoonSize,
    solarsystem.moon3dinfo.DistanceFromPlanet,
    solarsystem.moon3dinfo.OrbitRate,
    solarsystem.moon3dinfo.RotationRate,
    solarsystem.moon3dinfo.OrbitSize,
    solarsystem.moon3dinfo.InnerSize,
    solarsystem.moon3dinfo.FaceRoundness,
    solarsystem.moon3dinfo.FaceDigRound,
    solarsystem.moon3dinfo.Color
    
	FROM solarsystem.moon3dinfo 
	WHERE solarsystem.moon3dinfo.PlanetName = `@PlanetName`;
END //
DELIMITER ;