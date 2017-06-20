/* SQL Manager Lite for MySQL                              5.6.3.49012 */
/* ------------------------------------------------------------------- */
/* Host     : localhost                                                */
/* Port     : 3306                                                     */
/* Database : MOTOBIKE                                                 */


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES 'utf8' */;

SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE `MOTOBIKE`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `motobike`;

/* Структура для таблицы `product`:  */

CREATE TABLE `product` (
  `Product_id` INTEGER(11) NOT NULL,
  `Price` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`Product_id`),
  UNIQUE KEY `XPKCheckk_Equipment` USING BTREE (`Product_id`),
  KEY `XIF1Checkk_Equipment` USING BTREE (`Product_id`),
  KEY `pr_product` USING BTREE (`Product_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Структура для таблицы `client`:  */

CREATE TABLE `client` (
  `Client_id` INTEGER(11) NOT NULL DEFAULT 0,
  `Name` VARCHAR(200) COLLATE utf8_general_ci DEFAULT NULL,
  `Surname` VARCHAR(200) COLLATE utf8_general_ci DEFAULT NULL,
  `Discount` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`Client_id`),
  UNIQUE KEY `XPKClient` USING BTREE (`Client_id`),
  KEY `client_name` USING BTREE (`Name`, `Surname`, `Discount`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Структура для таблицы `staff`:  */

CREATE TABLE `staff` (
  `Staff_id` INTEGER(11) NOT NULL DEFAULT 0,
  `Name` VARCHAR(200) COLLATE utf8_general_ci DEFAULT NULL,
  `Surname` VARCHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  `Patronymic` VARCHAR(200) COLLATE utf8_general_ci DEFAULT NULL,
  `Appointment` TEXT COLLATE utf8_general_ci,
  PRIMARY KEY USING BTREE (`Staff_id`),
  UNIQUE KEY `XPKStaff` USING BTREE (`Staff_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Структура для таблицы `checkk`:  */

CREATE TABLE `checkk` (
  `Check_id` INTEGER(11) NOT NULL DEFAULT 0,
  `TotalPrice` FLOAT DEFAULT NULL,
  `Client_id` INTEGER(11) NOT NULL,
  `Staff_id` INTEGER(11) NOT NULL,
  `DateCheck` DATE DEFAULT NULL,
  `TotalPrice_discount` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`Check_id`),
  UNIQUE KEY `XPKCheckk` USING BTREE (`Check_id`),
  KEY `XIF1Checkk` USING BTREE (`Client_id`),
  KEY `XIF2Checkk` USING BTREE (`Staff_id`),
  KEY `ch_date` USING BTREE (`DateCheck`),
  KEY `checkk_total` USING BTREE (`DateCheck`, `TotalPrice`, `TotalPrice_discount`),
  CONSTRAINT `checkk_ibfk_1` FOREIGN KEY (`Client_id`) REFERENCES `client` (`Client_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `checkk_ibfk_2` FOREIGN KEY (`Staff_id`) REFERENCES `staff` (`Staff_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Структура для таблицы `check_product`:  */

CREATE TABLE `check_product` (
  `Check_id` INTEGER(11) NOT NULL,
  `Product_id` INTEGER(11) NOT NULL,
  `Amount` INTEGER(11) DEFAULT NULL,
  UNIQUE KEY `Check_id` USING BTREE (`Check_id`),
  KEY `Product_id` USING BTREE (`Product_id`),
  KEY `check_product_idx1` USING BTREE (`Amount`),
  KEY `ch_product` USING BTREE (`Product_id`, `Check_id`, `Amount`),
  CONSTRAINT `check_product_fk1` FOREIGN KEY (`Product_id`) REFERENCES `product` (`Product_id`) ON DELETE CASCADE,
  CONSTRAINT `check_product_fk2` FOREIGN KEY (`Check_id`) REFERENCES `checkk` (`Check_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Структура для таблицы `cooling_type`:  */

CREATE TABLE `cooling_type` (
  `Cooling_id` INTEGER(11) NOT NULL DEFAULT 0,
  `NameCooling` VARCHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`Cooling_id`),
  UNIQUE KEY `XPKCooling_type` USING BTREE (`Cooling_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Структура для таблицы `engine_displacement`:  */

CREATE TABLE `engine_displacement` (
  `Engine_id` INTEGER(11) NOT NULL DEFAULT 0,
  `Power_ranger` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`Engine_id`),
  UNIQUE KEY `XPKEngine_displacement` USING BTREE (`Engine_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Структура для таблицы `type_equipment`:  */

CREATE TABLE `type_equipment` (
  `Type_id` INTEGER(11) NOT NULL DEFAULT 0,
  `NameType` VARCHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`Type_id`),
  UNIQUE KEY `XPKType_equipment` USING BTREE (`Type_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Структура для таблицы `equipment`:  */

CREATE TABLE `equipment` (
  `Product_id` INTEGER(11) NOT NULL DEFAULT 0,
  `Model` VARCHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  `Type_id` INTEGER(11) NOT NULL,
  PRIMARY KEY USING BTREE (`Product_id`),
  UNIQUE KEY `XPKEquipment` USING BTREE (`Product_id`),
  KEY `XIF1Equipment` USING BTREE (`Type_id`),
  CONSTRAINT `equipment_fk1` FOREIGN KEY (`Product_id`) REFERENCES `product` (`Product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `equipment_ibfk_1` FOREIGN KEY (`Type_id`) REFERENCES `type_equipment` (`Type_id`) ON UPDATE CASCADE
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Структура для таблицы `manufacturer`:  */

CREATE TABLE `manufacturer` (
  `Manufacturer_id` INTEGER(11) NOT NULL DEFAULT 0,
  `NameManufacturer` VARCHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`Manufacturer_id`),
  UNIQUE KEY `XPKManufacturer` USING BTREE (`Manufacturer_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Структура для таблицы `producer`:  */

CREATE TABLE `producer` (
  `Producer_id` INTEGER(11) NOT NULL DEFAULT 0,
  `NameCountry` VARCHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`Producer_id`),
  UNIQUE KEY `XPKProducer` USING BTREE (`Producer_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Структура для таблицы `test_drive`:  */

CREATE TABLE `test_drive` (
  `Drive_id` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
  `Driving_exp` INTEGER(11) DEFAULT NULL,
  `Client_id` INTEGER(11) DEFAULT NULL,
  `Staff_id` INTEGER(11) DEFAULT NULL,
  `DataDriveng` DATE DEFAULT NULL,
  PRIMARY KEY USING BTREE (`Drive_id`),
  KEY `Client_id` USING BTREE (`Client_id`),
  KEY `Staff_id` USING BTREE (`Staff_id`),
  CONSTRAINT `test_drive_fk1` FOREIGN KEY (`Client_id`) REFERENCES `checkk` (`Client_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `test_drive_fk2` FOREIGN KEY (`Staff_id`) REFERENCES `checkk` (`Staff_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB
AUTO_INCREMENT=13 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Структура для таблицы `test_drive_backup`:  */

CREATE TABLE `test_drive_backup` (
  `Drive_id` INTEGER(11) NOT NULL,
  `Driving_exp` INTEGER(11) NOT NULL,
  `Client_id` INTEGER(11) NOT NULL,
  `Staff_id` INTEGER(11) NOT NULL,
  `DataDriveng` DATE NOT NULL,
  KEY `test_dr` USING BTREE (`DataDriveng`, `Driving_exp`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Структура для таблицы `type_vehicle`:  */

CREATE TABLE `type_vehicle` (
  `Type_id` INTEGER(11) NOT NULL,
  `Type_name` VARCHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`Type_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Структура для таблицы `vehicle`:  */

CREATE TABLE `vehicle` (
  `Product_id` INTEGER(11) NOT NULL DEFAULT 0,
  `NameVehicle` VARCHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  `Engine_id` INTEGER(11) NOT NULL,
  `Cooling_id` INTEGER(11) NOT NULL,
  `Manufactured_id` INTEGER(11) DEFAULT NULL,
  `Producer_id` INTEGER(11) DEFAULT NULL,
  `Type_id` INTEGER(11) NOT NULL,
  PRIMARY KEY USING BTREE (`Product_id`),
  UNIQUE KEY `XPKVehicle` USING BTREE (`Product_id`),
  KEY `XIF1Vehicle` USING BTREE (`Engine_id`),
  KEY `XIF2Vehicle` USING BTREE (`Cooling_id`),
  KEY `Manufactured_id` USING BTREE (`Manufactured_id`),
  KEY `Producer_id` USING BTREE (`Producer_id`),
  KEY `Type_id` USING BTREE (`Type_id`),
  KEY `vh_cooling` USING BTREE (`Cooling_id`),
  CONSTRAINT `vehicle_fk1` FOREIGN KEY (`Manufactured_id`) REFERENCES `manufacturer` (`Manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vehicle_fk2` FOREIGN KEY (`Producer_id`) REFERENCES `producer` (`Producer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vehicle_fk3` FOREIGN KEY (`Product_id`) REFERENCES `product` (`Product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vehicle_fk4` FOREIGN KEY (`Type_id`) REFERENCES `type_vehicle` (`Type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`Engine_id`) REFERENCES `engine_displacement` (`Engine_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vehicle_ibfk_2` FOREIGN KEY (`Cooling_id`) REFERENCES `cooling_type` (`Cooling_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Определение для процедуры `DELETE_type_equipment`:  */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `DELETE_type_equipment`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
  END;

  START TRANSACTION;
    DELETE FROM `type_equipment` WHERE Type_id = '205';
    DELETE FROM `type_equipment` WHERE Type_id = '206';
    DELETE FROM `type_equipment` WHERE Type_id = '207';
    -- fail --
    DELETE FROM `type_equipment` WHERE Type_id = '208';    
  COMMIT;
END$$

DELIMITER ;

/* Определение для процедуры `equipment_bogatui`:  */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `equipment_bogatui`(
        IN `price` INTEGER
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
IF (price=1)THEN
	SELECT `type_equipment`.`NameType`,`equipment`.`Model`, `product`.`Price`
	FROM `equipment`	
	LEFT JOIN product ON (equipment.Product_id = product.Product_id)
	JOIN type_equipment ON (equipment.`Type_id` = `type_equipment`.`Type_id`)
	WHERE product.Price < 700;
ELSE
	SELECT `type_equipment`.`NameType`,`equipment`.`Model`, `product`.`Price`
	FROM `equipment`
	LEFT JOIN product ON (equipment.Product_id = product.Product_id)
	JOIN type_equipment ON (equipment.`Type_id` = `type_equipment`.`Type_id`)
	WHERE product.Price > 700;
END IF;
END$$

DELIMITER ;

/* Определение для процедуры `even_odd`:  */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `even_odd`(
        IN `i` INTEGER
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
IF(i=1)THEN 
	SELECT * 
    FROM product 
    WHERE Product_id mod 2 != 0;
 ELSE 
 	SELECT * 
    FROM product 
    WHERE Product_id mod 2 = 0;
 END IF;
END$$

DELIMITER ;

/* Определение для процедуры `INSERT_type_equipment`:  */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `INSERT_type_equipment`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
  END;

  START TRANSACTION;
	INSERT INTO `type_equipment` VALUES(200, 'Именной шлем');
	INSERT INTO `type_equipment` VALUES(201, 'Именной шлем');
  	INSERT INTO `type_equipment` VALUES(202, 'Именной шлем');
	INSERT INTO `type_equipment` VALUES(203, 'Именной шлем');
  COMMIT;
END$$

DELIMITER ;

/* Определение для процедуры `manufacturer`:  */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `manufacturer`(
        IN `temp` VARCHAR(25)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
SELECT manufacturer.NameManufacturer, vehicle.NameVehicle, `engine_displacement`.`Power_ranger`, `product`.`Price`
FROM `vehicle`
LEFT JOIN product ON (vehicle.`Product_id` = `product`.`Product_id`)
JOIN `engine_displacement` ON (vehicle.`Engine_id` = `engine_displacement`.`Engine_id`)
JOIN `manufacturer` ON (vehicle.`Manufactured_id` = `manufacturer`.`Manufacturer_id`)
WHERE manufacturer.NameManufacturer = temp;
END$$

DELIMITER ;

/* Определение для процедуры `Price_all`:  */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `Price_all`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
select
  `check_product`.`Check_id`,
  `product`.`Product_id`,
  `product`.`Price`,
  `check_product`.`Amount`,
  `product`.`Price` * `check_product`.`Amount` AS `PriceAll`,
  `client`.`Discount`,
  (`product`.`Price` * `check_product`.`Amount`) - ((`product`.`Price` * `check_product`.`Amount` * `client`.`Discount`) / 100) AS
    `PriceOnDiscount`
from
  `product`
  left join `check_product` on (`product`.`Product_id` = `check_product`.`Product_id`)
  join `checkk` on (`check_product`.`Check_id` = `checkk`.`Check_id`)
  join `client` on (`checkk`.`Client_id` = `client`.`Client_id`)
where
  `check_product`.`Check_id` is not null;
END$$

DELIMITER ;

/* Определение для процедуры `ROLLBACK_TO_SAVEPOINT_temp_equipment`:  */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `ROLLBACK_TO_SAVEPOINT_temp_equipment`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN

 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
  SET @lastID := (COUNT(type_equipment)+1);
   ROLLBACK TO SAVEPOINT temp_equipment;
   INSERT INTO `type_equipment` VALUES( @lastID, 'error'); -- AUTO_INCREMENT  --
  END;
  
START TRANSACTION;
SAVEPOINT temp_equipment;
INSERT INTO `type_equipment` VALUES(200, 'Именной шлем');
SAVEPOINT temp_equipment;
INSERT INTO `type_equipment` VALUES(201, 'Именной шлем');
SAVEPOINT temp_equipment;
INSERT INTO `type_equipment` VALUES(201, 'Именной шлем');
SAVEPOINT temp_equipment;
INSERT INTO `type_equipment` VALUES(200, 'Именной шлем');
SAVEPOINT temp_equipment;
INSERT INTO `type_equipment` VALUES(202, 'Именной шлем');
SAVEPOINT temp_equipment;
INSERT INTO `type_equipment` VALUES(200, 'Именной шлем');
SAVEPOINT temp_equipment;
INSERT INTO `type_equipment` VALUES(203, 'Именной шлем');
SAVEPOINT temp_equipment;
COMMIT;

END$$

DELIMITER ;

/* Определение для процедуры `TotalPrice_discount_UP`:  */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `TotalPrice_discount_UP`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
UPDATE 
checkk AS ch INNER JOIN 
(SELECT ch_1.Client_id,`TotalPrice` - (`TotalPrice` * `Discount` / 100) AS PriceOnDiscount
FROM
checkk AS ch_1 INNER JOIN client as cl ON ch_1.`Client_id` = cl.Client_id
GROUP BY ch_1.Client_id) AS new_check
ON ch.Client_id = new_check.Client_id

SET
ch.TotalPrice_discount = IFNULL(new_check.PriceOnDiscount,0)
WHERE `ch`.`TotalPrice_discount` IS NULL OR `ch`.`TotalPrice_discount` != IFNULL(new_check.PriceOnDiscount,0);

END$$

DELIMITER ;

/* Определение для процедуры `TotalPrice_up`:  */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `TotalPrice_up`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
UPDATE 
checkk AS ch LEFT JOIN 
(SELECT
check_id,
SUM(Amount*Price) AS Total
FROM
check_product AS ch_pr INNER JOIN product AS pr ON ch_pr.product_id = pr.product_id
GROUP BY check_id) AS new_check
ON ch.Check_id = new_check.Check_id

SET
ch.TotalPrice = IFNULL(new_check.total,0)
WHERE `ch`.`TotalPrice` IS NULL OR `ch`.`TotalPrice` != IFNULL(new_check.total,0);
END$$

DELIMITER ;

/* Определение для процедуры `TotalPrice_up_v2`:  */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `TotalPrice_up_v2`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
UPDATE 
checkk AS ch LEFT JOIN 
(SELECT
check_id,
SUM(Amount*Price) AS Total
FROM
check_product AS ch_pr INNER JOIN product AS pr ON ch_pr.product_id = pr.product_id
GROUP BY check_id) AS new_check
ON ch.Check_id = new_check.Check_id

SET
ch.TotalPrice = IFNULL(new_check.total,0)
WHERE `ch`.`TotalPrice` IS NULL OR `ch`.`TotalPrice` != IFNULL(new_check.total,0);

UPDATE 
checkk AS ch INNER JOIN 
(SELECT ch_1.Client_id,`TotalPrice` - (`TotalPrice` * `Discount` / 100) AS PriceOnDiscount
FROM
checkk AS ch_1 INNER JOIN client as cl ON ch_1.`Client_id` = cl.Client_id
GROUP BY ch_1.Client_id) AS new_check
ON ch.Client_id = new_check.Client_id

SET
ch.TotalPrice_discount = IFNULL(new_check.PriceOnDiscount,0)
WHERE `ch`.`TotalPrice_discount` IS NULL OR `ch`.`TotalPrice_discount` != IFNULL(new_check.PriceOnDiscount,0);


END$$

DELIMITER ;

/* Определение для процедуры `Total_All`:  */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `Total_All`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
UPDATE `checkk`
SET TotalPrice = ( SELECT `product`.`Price`*`check_product`.`Amount` 
FROM product, check_product 
WHERE check_product.`Product_id`= product.`Product_id` AND `checkk`.`Check_id`= `check_product`.`Check_id` );
END$$

DELIMITER ;

/* Определение для процедуры `Total_dicount`:  */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `Total_dicount`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
UPDATE `checkk`
SET TotalPrice = ( SELECT checkk.`TotalPrice` - (checkk.TotalPrice * `client`.`Discount` / 100)
FROM `client`
WHERE `client`.`Client_id` = checkk.Client_id );
END$$

DELIMITER ;

/* Определение для процедуры `UPDATE_type_equipment`:  */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `UPDATE_type_equipment`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
  END;

  START TRANSACTION;
    UPDATE `type_equipment` set `Type_id`=205 WHERE `Type_id`=200 ;
    UPDATE `type_equipment` set `Type_id`=206 WHERE `Type_id`=201 ;
    UPDATE `type_equipment` set `Type_id`=207 WHERE `Type_id`=202 ;
    -- fail --
    UPDATE `type_equipment` set `Type_id`=208 WHERE `Type_id`=203 ;
  COMMIT;
END$$

DELIMITER ;

/* Определение для процедуры `vehicle_bednui`:  */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `vehicle_bednui`(
        IN `price` INTEGER
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
IF (price=1)THEN
	SELECT `manufacturer`.`NameManufacturer`, `vehicle`.`NameVehicle`, `engine_displacement`.`Power_ranger`, `product`.`Price`
	FROM vehicle 
	LEFT JOIN product ON (vehicle.Product_id = product.Product_id)
	JOIN  manufacturer ON (vehicle.Manufactured_id = manufacturer.Manufacturer_id)
	JOIN engine_displacement ON (vehicle.Engine_id = engine_displacement.Engine_id)
    WHERE product.Price < 10000;
ELSE
	SELECT `manufacturer`.`NameManufacturer`, `vehicle`.`NameVehicle`, `engine_displacement`.`Power_ranger`, `product`.`Price`
	FROM vehicle 
	LEFT JOIN product ON (vehicle.Product_id = product.Product_id)
	JOIN  manufacturer ON (vehicle.Manufactured_id = manufacturer.Manufacturer_id)
	JOIN engine_displacement ON (vehicle.Engine_id = engine_displacement.Engine_id)
    WHERE product.Price > 10000;
END IF;
END$$

DELIMITER ;

/* Определение для представления `badge`:  */

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `badge`
AS
select
  `staff`.`Appointment` AS `Appointment`,
  `staff`.`Name` AS `Name`,
  `staff`.`Patronymic` AS `Patronymic`
from
  `staff`;

/* Определение для представления `price_all`:  */

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `price_all`
AS
select
  `check_product`.`Check_id` AS `Check_id`,
  `product`.`Product_id` AS `Product_id`,
  `product`.`Price` AS `Price`,
  `check_product`.`Amount` AS `Amount`,
  (`product`.`Price` * `check_product`.`Amount`) AS `PriceAll`,
  `client`.`Discount` AS `Discount`,
  ((`product`.`Price` * `check_product`.`Amount`) -(((`product`.`Price` * `check_product`.`Amount`) * `client`.`Discount`) / 100)) AS
    `PriceOnDiscount`
from
  (((`product`
  left join `check_product` on ((`product`.`Product_id` = `check_product`.`Product_id`)))
  join `checkk` on ((`check_product`.`Check_id` = `checkk`.`Check_id`)))
  join `client` on ((`checkk`.`Client_id` = `client`.`Client_id`)))
where
  (`check_product`.`Check_id` is not null);

/* Определение для представления `transactions`:  */

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `transactions`
AS
select
  `checkk`.`Check_id` AS `Check_id`,
  concat(`client`.`Name`, ' ', `client`.`Surname`) AS `Клиент`,
  `staff`.`Appointment` AS `Обслуживает`,
  concat(`staff`.`Name`, ' ', `staff`.`Surname`) AS `Персонал`
from
  ((`checkk`
  join `client`)
  join `staff`)
where
  ((`checkk`.`Client_id` = `client`.`Client_id`) and
  (`checkk`.`Staff_id` = `staff`.`Staff_id`));

/* Data for the `product` table  (LIMIT 0,500) */

INSERT INTO `product` (`Product_id`, `Price`) VALUES
  (1,21135),
  (2,16980),
  (3,15360),
  (4,31035),
  (5,39226),
  (6,3000),
  (7,7500),
  (8,5767),
  (9,8990),
  (10,16730),
  (11,21279),
  (12,14000),
  (13,10053),
  (14,24971),
  (15,11400),
  (16,4000),
  (17,4189),
  (18,20524),
  (19,6954),
  (20,10686),
  (21,16235),
  (22,9293),
  (23,10000),
  (24,17652),
  (25,9327),
  (26,6589),
  (27,31806),
  (28,18200),
  (29,20000),
  (30,23220),
  (31,10000),
  (32,9300),
  (33,11000),
  (34,9700),
  (35,8800),
  (36,11841),
  (37,16916),
  (38,21751),
  (39,23112),
  (40,12000),
  (41,10854),
  (42,7400),
  (43,12207),
  (44,22983),
  (45,20110),
  (46,5000),
  (47,12674),
  (48,25233),
  (49,42485),
  (50,27783),
  (51,15978),
  (52,23552),
  (53,14618),
  (54,20533),
  (55,20195),
  (56,23575),
  (57,21124),
  (58,21838),
  (59,18589),
  (60,15209),
  (61,3000),
  (62,2800),
  (63,2300),
  (64,2700),
  (65,1200),
  (66,1800),
  (67,17660),
  (68,14314),
  (69,26870),
  (70,20127),
  (71,14246),
  (101,60),
  (102,85),
  (103,110),
  (104,175),
  (105,205),
  (106,220),
  (107,535),
  (108,530),
  (109,560),
  (110,370),
  (111,810),
  (112,830),
  (113,1200),
  (114,8),
  (115,25),
  (116,33),
  (117,45),
  (118,62),
  (119,83),
  (120,87),
  (121,112),
  (122,170),
  (123,285),
  (124,430),
  (125,31),
  (126,72),
  (127,167),
  (128,173),
  (129,220),
  (130,186),
  (131,215),
  (132,237),
  (133,259),
  (134,355),
  (135,363),
  (136,373),
  (137,390),
  (138,550),
  (139,829),
  (140,500),
  (141,586),
  (142,703),
  (143,810),
  (144,965),
  (145,1412),
  (146,1761),
  (147,4),
  (148,9),
  (149,14),
  (150,35),
  (151,55),
  (152,200),
  (153,50),
  (154,60),
  (155,70),
  (156,71),
  (157,72),
  (158,134),
  (159,135),
  (160,149),
  (161,190),
  (162,205),
  (163,559),
  (164,745),
  (165,1125),
  (166,90),
  (167,106),
  (168,186),
  (169,222),
  (170,227),
  (171,289),
  (172,455),
  (173,465),
  (174,607),
  (175,218),
  (176,232),
  (177,64),
  (178,83),
  (179,100),
  (180,465),
  (181,99),
  (182,102),
  (183,428),
  (184,785),
  (185,25),
  (186,50),
  (187,60),
  (188,80),
  (189,40),
  (190,530),
  (191,280),
  (200,1850);
COMMIT;

/* Data for the `client` table  (LIMIT 0,500) */

INSERT INTO `client` (`Client_id`, `Name`, `Surname`, `Discount`) VALUES
  (1,'Анна','Егорченко',10),
  (2,'Сергей','Коротнев',5),
  (3,'Алина','Куликова',5),
  (4,'Артур','Мищанов',5),
  (5,'Владислав','Некрасов',5),
  (6,'Андрей','Овсяник',5),
  (7,'Антон','Остапов',5),
  (8,'Игорь','Просяник',0),
  (9,'Игорь','Руднев',5),
  (10,'Родион','Чебаненко',5),
  (11,'Владислав','Швачко',5),
  (12,'Росица','Манева',30);
COMMIT;

/* Data for the `staff` table  (LIMIT 0,500) */

INSERT INTO `staff` (`Staff_id`, `Name`, `Surname`, `Patronymic`, `Appointment`) VALUES
  (1,'Даниил','Шворак','Андреевич','Директор'),
  (2,'Мойша','Винницкий','Вольфович','Заместитель директора'),
  (3,'Циля ','Аверман','Яковлевна','Бухгалтер'),
  (4,'Сергей ','Брин','Михаайлович ','Менеджер по продажам'),
  (5,'Максимилиан','Левчин ','Рафаэльевич ','Оператор call-центра'),
  (6,'Михаил ','Прохоров','Дмитриевич ','Менеджер по продажам'),
  (7,'Шимон ','Перес','Исаакович ','Администратор'),
  (8,'Эстер ','Либерман','Марковна','Консультант по мотоэкиперовке'),
  (9,'Вячеслав ','Кантор','Владимирович ','Менеджер-Консультант'),
  (10,'Марк ','Цукерберг','Эдвардович','Консультант'),
  (11,'Гадя ','Хренова','Петрович','Уборщица торгового зала'),
  (12,'Титал','Мкртычан','Авдеевич','Сторож'),
  (13,'Валентина','Бедная','Леапольдовна','Уборщица ');
COMMIT;

/* Data for the `checkk` table  (LIMIT 0,500) */

INSERT INTO `checkk` (`Check_id`, `TotalPrice`, `Client_id`, `Staff_id`, `DateCheck`, `TotalPrice_discount`) VALUES
  (1,21135,1,4,'2017-02-10',19022),
  (2,16730,2,6,'2017-03-23',15894),
  (3,220,3,8,'2017-01-01',209),
  (4,72,4,10,'2016-12-25',68),
  (5,289,5,6,'2017-01-07',275),
  (6,43676,6,4,'2107-03-08',41492),
  (7,25,7,4,'2017-02-11',24),
  (8,31806,8,8,'2016-12-30',31806),
  (9,66,9,10,'2016-12-20',63),
  (10,740,10,4,'2017-03-24',703),
  (11,558,11,8,'2017-03-17',530),
  (12,2400,12,1,'2017-04-01',1680);
COMMIT;

/* Data for the `check_product` table  (LIMIT 0,500) */

INSERT INTO `check_product` (`Check_id`, `Product_id`, `Amount`) VALUES
  (1,1,1),
  (2,10,1),
  (3,103,2),
  (4,157,1),
  (5,171,1),
  (6,58,2),
  (7,185,1),
  (8,27,1),
  (9,116,2),
  (10,110,2),
  (11,168,3),
  (12,65,2);
COMMIT;

/* Data for the `cooling_type` table  (LIMIT 0,500) */

INSERT INTO `cooling_type` (`Cooling_id`, `NameCooling`) VALUES
  (1,'Воздушное'),
  (2,'Жидкостное');
COMMIT;

/* Data for the `engine_displacement` table  (LIMIT 0,500) */

INSERT INTO `engine_displacement` (`Engine_id`, `Power_ranger`) VALUES
  (1,110),
  (2,125),
  (3,150),
  (4,200),
  (5,250),
  (6,300),
  (7,400),
  (8,600),
  (9,650),
  (10,800),
  (11,1000),
  (12,1100),
  (13,1200),
  (14,1800),
  (15,750),
  (16,850),
  (17,700),
  (18,450),
  (19,1300),
  (20,1900),
  (21,900),
  (22,950),
  (23,500),
  (24,550),
  (25,1350),
  (26,1400),
  (27,2300);
COMMIT;

/* Data for the `type_equipment` table  (LIMIT 0,500) */

INSERT INTO `type_equipment` (`Type_id`, `NameType`) VALUES
  (0,'error'),
  (1,'Мотокуртки'),
  (2,'Мотоперчатки'),
  (3,'Мотоштаны'),
  (4,'Костюмы'),
  (5,'Подшлемники'),
  (6,'Мотошлемы'),
  (7,'Мотоботы'),
  (8,'Защита');
COMMIT;

/* Data for the `equipment` table  (LIMIT 0,500) */

INSERT INTO `equipment` (`Product_id`, `Model`, `Type_id`) VALUES
  (101,'Bering Maniwata',1),
  (102,'ProGrip 9011',1),
  (103,'IXS RIO',1),
  (104,'Held Tropic 2',1),
  (105,'Spidi Netstream Tex',1),
  (106,'Dainese Veloster Tex',1),
  (107,'Segura Retro',1),
  (108,'Icon HELLA LEA',1),
  (109,'Dainese Nikita',1),
  (110,' Spidi Voyager Lady',1),
  (111,'Dainese Avro',1),
  (112,'ALPINESTARS GP TECH',1),
  (113,'Alpinestars Phantom',1),
  (114,'Scoyco MC08',2),
  (115,'Oneal Element',2),
  (116,'EVS Valencia',2),
  (117,'Nitro Sport Max',2),
  (118,'Shima Caldera',2),
  (119,'Alpinestars SMX-1Air',2),
  (120,' RST Blade',2),
  (121,'RST Tractech Evo',2),
  (122,'RS-Taichi High Prote',2),
  (123,'Knox Hand Armour',2),
  (124,'Alpinestars GP Tech',2),
  (125,'Spidi Matcher U47',3),
  (126,'Alpinestars Drifter',3),
  (127,'Spidi Mesh Leg',3),
  (128,'RST Blade Sport',3),
  (129,'Dainese P.Firefly ',3),
  (130,'Speed & Strength Run',3),
  (131,'Spidi J&Racing Blue',3),
  (132,'Alpinestars A-10 AIR',3),
  (133,'Promo Legend Blue',3),
  (134,'Revit Tornado 2',3),
  (135,'Alpinestars StellaGP',3),
  (136,'Promo Titanium ',3),
  (137,'Segura S Race',3),
  (138,'RS Taichi GMX Motion',3),
  (139,'Rukka Argonault C2',3),
  (140,'Alpinestars MONZA',4),
  (141,'Hy FlyX8 Racing Suit',4),
  (142,'Alpinestars GP-plus',4),
  (143,'Dainese Stripes P.E',4),
  (144,'RST Pro Series CPXC',4),
  (145,'Alpinestars Gp Pro',4),
  (146,'RS-Taichi GP-WRX',4),
  (147,'Boro ',5),
  (148,'Oxford Ultra Thin',5),
  (149,'Oxford Clava',5),
  (150,' Knox Cold Killers ',5),
  (151,'Ixon Fit Face ',5),
  (152,'Akito Balaclava',5),
  (153,'IXS HX 83 RUNE',6),
  (154,'MT Imola 2',6),
  (155,' LS2 FF352 Rookie',6),
  (156,'HJC CS-14 Lola',6),
  (157,'MT Thunder Solid',6),
  (158,'MT Flux Matt',6),
  (159,'Nitro Np-1100f Dvs',6),
  (160,'MDS MD200',6),
  (161,'Caberg Stunt ',6),
  (162,' Nolan N87 Special',6),
  (163,'Shoei Neotec',6),
  (164,' AGV Pista GP',6),
  (165,' IXS Fury 2',7),
  (166,'IXS BAMBO',7),
  (167,'Oxford Cherokee',7),
  (168,'Sidi Agueda',7),
  (169,'FOX Comp 5',7),
  (170,'Held Thundersport',7),
  (171,'Sidi VERTIGO',7),
  (172,'Fox Instinct',7),
  (173,'Sidi CROSSFIRE',7),
  (174,'Alpinestars Tech 10',7),
  (175,' Fox Raptor Vest',8),
  (176,'Alpinestars A-8',8),
  (177,'ProGrip 5501',8),
  (178,'VEGA NM-607',8),
  (179,'EVS Sport Back',8),
  (180,'Dainese Manis D1',8),
  (181,'Alpinestars BIONIC M',8),
  (182,'FOX Titan Pro Knee',8),
  (183,'EVS Axis Pro',8),
  (184,'EVS Axis Pro Carbon',8),
  (185,'ProGrip',8),
  (186,' EVS Epic Black',8),
  (187,'Alpinestars VAPOR ',8),
  (188,'Dainese V E1',8),
  (189,' EVS Impact',8),
  (190,'Akito Strike Kidney',8),
  (191,'Knox Hand Armour',8);
COMMIT;

/* Data for the `manufacturer` table  (LIMIT 0,500) */

INSERT INTO `manufacturer` (`Manufacturer_id`, `NameManufacturer`) VALUES
  (1,'Honda'),
  (2,'Yamaha'),
  (3,'Suzuki'),
  (4,'Kawasaki'),
  (5,'Harley-Davidson'),
  (6,'КТМ'),
  (7,'Aprilia'),
  (8,'Ducati '),
  (9,'BMW '),
  (10,'Zongshen '),
  (11,'Lifan '),
  (12,'Triumph');
COMMIT;

/* Data for the `producer` table  (LIMIT 0,500) */

INSERT INTO `producer` (`Producer_id`, `NameCountry`) VALUES
  (1,'Италия'),
  (2,'Япония'),
  (3,'Австрия'),
  (4,'Германия'),
  (5,'США'),
  (6,'Китай'),
  (7,'Великобритания');
COMMIT;

/* Data for the `test_drive` table  (LIMIT 0,500) */

INSERT INTO `test_drive` (`Drive_id`, `Driving_exp`, `Client_id`, `Staff_id`, `DataDriveng`) VALUES
  (1,1,1,4,'2017-02-10'),
  (2,5,2,6,'2017-03-23'),
  (3,4,3,8,'2017-01-01'),
  (4,2,4,10,'2016-12-25'),
  (5,1,5,6,'2017-01-07'),
  (6,3,6,4,'2107-03-08'),
  (7,8,7,4,'2017-02-11'),
  (8,5,8,8,'2016-12-30'),
  (9,3,9,10,'2016-12-20'),
  (10,4,10,4,'2017-03-24'),
  (12,5,12,1,'2017-04-01');
COMMIT;

/* Data for the `test_drive_backup` table  (LIMIT 0,500) */

INSERT INTO `test_drive_backup` (`Drive_id`, `Driving_exp`, `Client_id`, `Staff_id`, `DataDriveng`) VALUES
  (11,1,11,8,'2017-03-17');
COMMIT;

/* Data for the `type_vehicle` table  (LIMIT 0,500) */

INSERT INTO `type_vehicle` (`Type_id`, `Type_name`) VALUES
  (1,'Супер спорт'),
  (2,'Туризм'),
  (3,'Круизеры'),
  (4,'Классика'),
  (5,'Кросс'),
  (6,'Спорт');
COMMIT;

/* Data for the `vehicle` table  (LIMIT 0,500) */

INSERT INTO `vehicle` (`Product_id`, `NameVehicle`, `Engine_id`, `Cooling_id`, `Manufactured_id`, `Producer_id`, `Type_id`) VALUES
  (1,'CBR1000RR',12,2,1,2,1),
  (2,'CBR 600 RR',8,2,1,2,6),
  (3,'CBR650 F',9,2,1,2,6),
  (4,'GoldWing  GL1800 F6C',14,2,1,2,3),
  (5,'GL 1800 ABS GOLD WIN',14,2,1,2,2),
  (6,'VT750 C2B',15,2,1,2,2),
  (7,'CB1100',12,2,1,2,4),
  (8,'CRF250R',5,1,1,2,5),
  (9,'CRF450X',18,1,1,2,5),
  (10,'YZF-R6',8,2,2,2,1),
  (11,'YZF-R1M',11,2,2,2,1),
  (12,'FJR 1300 A',19,2,2,2,2),
  (13,'Tracer 700',17,2,2,2,2),
  (14,'XVS1900A ',20,2,2,2,3),
  (15,'XV950',22,2,2,2,3),
  (16,'Yamaha SR500',23,2,2,2,4),
  (17,'TT-R110E',1,1,2,2,5),
  (18,'GSX-R1000',11,2,3,2,1),
  (19,'GSX-R750',15,2,3,2,1),
  (20,'GSX1300R',19,2,3,2,2),
  (21,'INTRUDER M1800R',14,2,3,2,3),
  (22,'Intruder VL800',10,2,3,2,3),
  (23,'GSR750A',15,2,3,2,4),
  (24,'GSX1250FA',13,2,3,2,4),
  (25,'V-STROM 650',9,1,3,2,5),
  (26,'RM-Z450',18,1,3,2,5),
  (27,'Ninja H2',11,2,4,2,1),
  (28,'Ninja ZX-10R',11,2,4,2,1),
  (29,'1400GTR',26,2,4,2,2),
  (30,'ZZR1400',26,2,4,2,2),
  (31,'Vulcan 900',21,2,4,2,3),
  (32,'Vulcan S',9,2,4,2,3),
  (33,'W800',10,2,4,2,4),
  (34,'KX450F',18,2,4,2,5),
  (35,'KLX450R',18,2,4,2,5),
  (36,'Street 750',15,2,5,5,3),
  (37,'Roadster 1200',13,2,5,5,4),
  (38,'1190 RC8 R',13,2,6,3,1),
  (39,'1290 Super Adventure',19,2,6,3,2),
  (40,'990 Superduke R',11,2,6,3,4),
  (41,'690 DUKE R',17,2,6,3,4),
  (42,'300 EXC Six Days',6,1,6,3,5),
  (43,'500 EXC Six Days',23,1,6,3,5),
  (44,'RSV4',11,2,7,1,1),
  (45,'Tuono V4 R',11,2,7,1,1),
  (46,'RST 1000 Futura',11,2,7,1,2),
  (47,'Shiver 750 GT',15,2,7,1,4),
  (48,'Dorsoduro 900',21,2,7,1,5),
  (49,'1199 Panigale R',13,2,8,1,1),
  (50,'1299 Panigale',19,2,8,1,1),
  (51,'Multistrada 1200',13,2,8,1,2),
  (52,'XDiavel ',19,2,8,1,3),
  (53,'Urban Enduro',10,2,8,1,4),
  (54,'Monster 1200',13,2,8,1,4),
  (55,'Diavel Carbon',13,2,8,1,4),
  (56,'Hypermotard 939 SP',21,2,8,1,5),
  (57,'S 1000 RR',11,2,9,4,1),
  (58,'R 1200 RT',13,2,9,4,2),
  (59,'R nineT',13,2,9,4,4),
  (60,'F 800 GS Adventure',10,2,9,4,5),
  (61,'ZS250GS',5,1,10,6,1),
  (62,'ZS200GY-A',4,1,10,6,5),
  (63,'ZS250-5 Cruiser',5,2,10,6,3),
  (64,'LF400',7,1,11,6,3),
  (65,'LF200 GY-5',4,1,11,6,5),
  (66,'Dakota LF250-19P',5,1,11,6,1),
  (67,'Speed Triple S',11,2,12,7,1),
  (68,'BONNEVILLE T120',13,2,12,7,4),
  (69,'ROCKET III ROADSTER',27,2,12,7,3),
  (70,'EXPLORER XCX',13,2,12,7,2),
  (71,'TIGER 800 XС X',10,2,12,7,5);
COMMIT;

/* Definition for the `check_product_ins` trigger : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' TRIGGER `check_product_ins` AFTER INSERT ON `check_product`
  FOR EACH ROW
BEGIN
call TotalPrice_up_v2();
END$$

DELIMITER ;

/* Definition for the `check_product_up` trigger : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' TRIGGER `check_product_up` AFTER UPDATE ON `check_product`
  FOR EACH ROW
BEGIN
call TotalPrice_up_v2();
END$$

DELIMITER ;

/* Definition for the `check_product_del` trigger : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' TRIGGER `check_product_del` AFTER DELETE ON `check_product`
  FOR EACH ROW
BEGIN
call TotalPrice_up_v2();
END$$

DELIMITER ;

/* Definition for the `product_ins` trigger : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' TRIGGER `product_ins` AFTER INSERT ON `product`
  FOR EACH ROW
BEGIN
call TotalPrice_up_v2();
END$$

DELIMITER ;

/* Definition for the `product_up` trigger : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' TRIGGER `product_up` AFTER UPDATE ON `product`
  FOR EACH ROW
BEGIN
call TotalPrice_up_v2();
END$$

DELIMITER ;

/* Definition for the `test_drive_up` trigger : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' TRIGGER `test_drive_up` BEFORE UPDATE ON `test_drive`
  FOR EACH ROW
BEGIN
INSERT INTO `test_drive_backup` 
Set
Drive_id = OLD.Drive_id,
Driving_exp = OLD.Driving_exp,
Client_id = OLD.Client_id,
Staff_id = OLD.Staff_id,
DataDriveng = OLD.DataDriveng;
END$$

DELIMITER ;

/* Definition for the `test_drive_del` trigger : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' TRIGGER `test_drive_del` BEFORE DELETE ON `test_drive`
  FOR EACH ROW
BEGIN
INSERT INTO `test_drive_backup` 
Set
Drive_id = OLD.Drive_id,
Driving_exp = OLD.Driving_exp,
Client_id = OLD.Client_id,
Staff_id = OLD.Staff_id,
DataDriveng = OLD.DataDriveng;
END$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;