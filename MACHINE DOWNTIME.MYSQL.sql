SELECT * FROM kammary.`machine downtime-dataset`;
create database machine_downtime1;
use kammary;
 
CREATE TABLE kammary.`machine downtime-dataset` (
  `Date` TEXT NOT NULL,
  `Machine_ID` TEXT NOT NULL,
  `Assembly_Line_No` TEXT NOT NULL,
  `Hydraulic_Pressure(bar)` DOUBLE NOT NULL,
  `Coolant_Pressure(bar)` DOUBLE NOT NULL,
  `Air_System_Pressure(bar)` DOUBLE NOT NULL,
  `Coolant_Temperature` DOUBLE NOT NULL,
  `Hydraulic_Oil_Temperature(°C)` DOUBLE NOT NULL,
  `Spindle_Bearing_Temperature(°C)` DOUBLE NOT NULL,
  `Spindle_Vibration(µm)` DOUBLE NOT NULL,
  `Tool_Vibration(µm)` DOUBLE NOT NULL,
  `Spindle_Speed(RPM)` INT NOT NULL,
  `Voltage(volts)` INT NOT NULL,
  `Torque(Nm)` DOUBLE NOT NULL,
  `Cutting(kN)` DOUBLE NOT NULL,
  `Downtime` TEXT NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
);

desc kammary.`machine downtime-dataset`;
SELECT * FROM kammary.`machine downtime-dataset`;

-- Disable safe updates
SET SQL_SAFE_UPDATES = 0;

-- Remove duplicate rows
DELETE t1
FROM kammary.`machine downtime-dataset` t1
JOIN (
    SELECT 
        MIN(`Machine_ID`) AS id,
        `Hydraulic_Pressure(bar)`,
        `Coolant_Pressure(bar)`,
        `Air_System_Pressure(bar)`,
        `Coolant_Temperature`,
        `Hydraulic_Oil_Temperature(Â°C)`,
        `Spindle_Bearing_Temperature(Â°C)`,
        `Spindle_Vibration(Âµm)`,
        `Tool_Vibration(Âµm)`,
        `Spindle_Speed(RPM)`,
        `Voltage(volts)`,
        `Torque(Nm)`,
        `Cutting(kN)`
    FROM kammary.`machine downtime-dataset`
    GROUP BY 
        `Hydraulic_Pressure(bar)`,
        `Coolant_Pressure(bar)`,
        `Air_System_Pressure(bar)`,
        `Coolant_Temperature`,
        `Hydraulic_Oil_Temperature(Â°C)`,
        `Spindle_Bearing_Temperature(Â°C)`,
        `Spindle_Vibration(Âµm)`,
        `Tool_Vibration(Âµm)`,
        `Spindle_Speed(RPM)`,
        `Voltage(volts)`,
        `Torque(Nm)`,
        `Cutting(kN)`
) AS duplicates
ON 
    t1.`Machine_ID` != duplicates.id
    AND t1.`Hydraulic_Pressure(bar)` = duplicates.`Hydraulic_Pressure(bar)`
    AND t1.`Coolant_Pressure(bar)` = duplicates.`Coolant_Pressure(bar)`
    AND t1.`Air_System_Pressure(bar)` = duplicates.`Air_System_Pressure(bar)`
    AND t1.`Coolant_Temperature` = duplicates.`Coolant_Temperature`
    AND t1.`Hydraulic_Oil_Temperature(Â°C)` = duplicates.`Hydraulic_Oil_Temperature(Â°C)`
    AND t1.`Spindle_Bearing_Temperature(Â°C)` = duplicates.`Spindle_Bearing_Temperature(Â°C)`
    AND t1.`Spindle_Vibration(Âµm)` = duplicates.`Spindle_Vibration(Âµm)`
    AND t1.`Tool_Vibration(Âµm)` = duplicates.`Tool_Vibration(Âµm)`
    AND t1.`Spindle_Speed(RPM)` = duplicates.`Spindle_Speed(RPM)`
    AND t1.`Voltage(volts)` = duplicates.`Voltage(volts)`
    AND t1.`Torque(Nm)` = duplicates.`Torque(Nm)`
    AND t1.`Cutting(kN)` = duplicates.`Cutting(kN)`;
    
SET SQL_SAFE_UPDATES = 0;

DELETE FROM kammary.`machine downtime-dataset`
WHERE `Hydraulic_Pressure(bar)` IS NULL
OR `Coolant_Pressure(bar)` IS NULL
OR `Air_System_Pressure(bar)` IS NULL
OR `Coolant_Temperature` IS NULL
OR `Hydraulic_Oil_Temperature(Â°C)` IS NULL
OR `Spindle_Bearing_Temperature(Â°C)` IS NULL
OR `Spindle_Vibration(Âµm)` IS NULL
OR `Tool_Vibration(Âµm)` IS NULL
OR `Spindle_Speed(RPM)` IS NULL
OR `Voltage(volts)` IS NULL
OR `Torque(Nm)` IS NULL
OR `Cutting(kN)` IS NULL;

-- REMOVE ROWS WITH MISSING VALUES 
SET SQL_SAFE_UPDATES = 0;

DELETE FROM kammary.`machine downtime-dataset`
WHERE `Hydraulic_Pressure(bar)` IS NULL
OR `Coolant_Pressure(bar)` IS NULL
OR `Air_System_Pressure(bar)` IS NULL
OR `Coolant_Temperature` IS NULL
OR `Hydraulic_Oil_Temperature(Â°C)` IS NULL
OR `Spindle_Bearing_Temperature(Â°C)` IS NULL
OR `Spindle_Vibration(Âµm)` IS NULL
OR `Tool_Vibration(Âµm)` IS NULL
OR `Spindle_Speed(RPM)` IS NULL
OR `Voltage(volts)` IS NULL
OR `Torque(Nm)` IS NULL
OR `Cutting(kN)` IS NULL;

-- REPLACE MISSING VALUES WITH MEAN (OR ANOTHER STATISTIC)

-- Replace missing values with mean for Hydraulic_Pressure(bar)
UPDATE kammary.`machine downtime-dataset`
SET `Hydraulic_Pressure(bar)` = (
    SELECT AVG(`Hydraulic_Pressure(bar)`)
    FROM kammary.`machine downtime-dataset`
)
WHERE `Hydraulic_Pressure(bar)` IS NULL;

-- Replace missing values with mean for Coolant_Pressure(bar)
UPDATE kammary.`machine downtime-dataset`
SET `Coolant_Pressure(bar)` = (
    SELECT AVG(`Coolant_Pressure(bar)`)
    FROM kammary.`machine downtime-dataset`
)
WHERE `Coolant_Pressure(bar)` IS NULL;

-- Replace missing values with mean for Air_System_Pressure(bar)
UPDATE `machine_downtime`.`mac_downtime_ds1`
SET `Air_System_Pressure(bar)` = (
    SELECT AVG(`Air_System_Pressure(bar)`)
    FROM `machine_downtime`.`mac_downtime_ds1`
)
WHERE `Air_System_Pressure(bar)` IS NULL;

DESC kammary.`machine downtime-dataset`
