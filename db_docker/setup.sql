CREATE DATABASE IF NOT EXISTS boat_club;
CREATE USER IF NOT EXISTS 'readonly'@'%' IDENTIFIED BY 'readonly';
GRANT SELECT, SHOW VIEW ON boat_club.* TO 'readonly'@'%';
FLUSH PRIVILEGES;

USE boat_club;

DROP TABLE IF EXISTS events;
CREATE TABLE events (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(128) NOT NULL,
    description VARCHAR(1024),
    rating INTEGER NOT NULL,
    public INTEGER NOT NULL
);

INSERT INTO events (title, description, rating, public)
VALUES
    ('Spring Festival 2022', 'Spring Boat Festival held between 15th April - 18th April 2022. Food, music & entertainment.', 500, 1),
    ('Dinner with Chris', 'Chris Ramsey held a party onboard our yacht and served food & drink to our VIP members.', 100, 0),
    ('Summer Festival 2022', 'Summer Boat Festival held between 11th August - 14th August 2022. Food, music & entertainment.', 2000, 1),
    ('Boat Parade 2022', 'Parade and showcase of our world famous boat collection. Featured in the British Boat Magazine.', 1750, 1),
    ('Meet & Greet', 'Meet & Greet for our VIP members.', 85, 0),
    ('Autumn Festival 2022', 'Autumn Boat Festival held between 11th August - 14th August 2022. Food, music & entertainment.', 1450, 1),
    ('Cook with James', 'James Oliver gave cooking lessons onboard our yacht.', 90, 0),
    ('Winter Festival 2022', 'Winter Boat Festival held between 29th September - 2nd October 2022. Food, music & entertainment.', 400, 1),
    ('Yacht Tours', 'Tours of our yacht collection.', 700, 1),
    ('Christmas Party', 'Christmas Party for our VIP members. Santa was also present.', 45, 0),
    ('New Year 2023 Party', 'Party for our VIP members on our biggest yacht.', 100, 0),
    ('Speed Boat Race', 'Speed boat race held along the Quayside in Newcastle.', 1800, 1),
    ('Cook with Martin', 'Martin James gave cooking lessons onboard our yacht.', 95, 0),
    ('Carp Fishing with Thomas Gerard', 'Thomas Gerard came all the way from Australia to teach our VIP members the best tips for carp fishing.', 110, 0);

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(32) NOT NULL UNIQUE,
    fullname VARCHAR(64) NOT NULL,
    role VARCHAR(32) NOT NULL,
    password VARCHAR(32) NOT NULL
);

INSERT INTO users (username, fullname, role, password)
VALUES
    ('steve', 'Steve Business', 'member', MD5('pizza')),
    ('alex', 'Alex Smith', 'member', MD5('chocolate')),
    ('morgan', 'Morgan Robson', 'member', MD5('beans')),
    ('bob', 'Bob Wilson', 'member', MD5('sausage')),
    ('laura', 'Laura Wilson', 'member', MD5('chips')),
    ('donald', 'Donald Johnson', 'member', MD5('tomato'));


DROP TABLE IF EXISTS boats;
CREATE TABLE boats (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64) NOT NULL,
    img VARCHAR(128),
    secret INTEGER NOT NULL
);

INSERT INTO boats (name, img, secret)
VALUES
    ('Pirate Ship', 'big_ship.jpg', 0),
    ('Sailing Ship', 'sail_ship.jpg', 0),
    ('Destroyer Yacht', NULL, 1),
    ('Destroyer', 'destroyer.jpg', 0),
    ('Raft', 'raft.jpg', 0),
    ('Super Raft', NULL, 1),
    ('Outdoor Motor Boat', 'outdoor_motor.jpg', 0),
    ('Speed Yacht', 'speed_yacht.jpg', 0),
    ('Super Yacht', NULL, 1),
    ('Huge Boat 7000', NULL, 1),
    ('Jet Ski 5000', NULL, 1),
    ('Big Dinghy', NULL, 1),
    ('Small Dinghy', NULL, 1),
    ('Tiny Dinghy', NULL, 1),
    ('Medium Dinghy', NULL, 1),
    ('Blowup Dinghy', NULL, 1),
    ('Quick Dinghy', NULL, 1),
    ('Speed Boat Dinghy', NULL, 1),
    ('Wood Boat', 'wood_boat.jpg', 0);

CREATE DATABASE IF NOT EXISTS geordie_boat_rentals_ltd;
CREATE USER IF NOT EXISTS 'readonly2'@'%' IDENTIFIED BY 'readonly2';
GRANT SELECT, SHOW VIEW ON geordie_boat_rentals_ltd.* TO 'readonly2'@'%';
FLUSH PRIVILEGES;

USE geordie_boat_rentals_ltd;

DROP TABLE IF EXISTS boats;
CREATE TABLE boats (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL,
    category VARCHAR(128) NOT NULL,
    price INTEGER NOT NULL
);

INSERT INTO boats (name, category, price)
VALUES
    ('Super Yacht', 'Yacht', 5000),
    ('Super Yacht 2000', 'Yacht', 10500),
    ('Super British Yacht', 'Yacht', 12500),
    ('Super Cool Yacht', 'Yacht', 8000),
    ('Big Sail Yacht', 'Yacht', 2500),
    ('Fast Sprinter', 'Speed Boat', 2500),
    ('Quick Sprinter', 'Speed Boat', 3000),
    ('Super Fast Sprinter', 'Speed Boat', 6000),
    ('Slow Sprinter', 'Speed Boat', 500),
    ('Shark Ski: Model 2019', 'Jet Ski', 500),
    ('Shark Ski: Model 2020', 'Jet Ski', 600),
    ('Shark Ski: Model 2021', 'Jet Ski', 700),
    ('Shark Ski: Model 2022', 'Jet Ski', 800),
    ('Shark Ski: Model 2023', 'Jet Ski', 900);


DROP TABLE IF EXISTS payments;
CREATE TABLE payments (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    sort_code VARCHAR(8) NOT NULL,
    account_number VARCHAR(8) NOT NULL,
    money VARCHAR(16) NOT NULL
);

INSERT INTO payments (sort_code, account_number, money)
VALUES
	('72-83-71', '82688689', 4412),
	('20-39-67', '38405489', 5985),
	('70-65-78', '28165925', 8609),
	('87-66-82', '68666631', 7271),
	('75-68-54', '68739801', 9082),
	('86-51-81', '36946635', 2365),
	('13-03-31', '54621794', 2481),
	('21-24-97', '61627509', 673),
	('26-97-36', '11971746', 5830),
	('07-53-31', '62598689', 5909),
	('46-21-48', '56513395', 5598),
	('50-63-98', '14706465', 8555),
	('32-51-69', '99934016', 984),
	('38-18-05', '66002719', 2947),
	('56-76-88', '70752813', 5985),
	('40-99-81', '89590631', 9470),
	('65-77-49', '28462566', 796),
	('57-05-74', '87492108', 1957),
	('85-08-82', '57608269', 4978),
	('23-83-36', '79780839', 8879),
	('46-62-57', '20662084', 1766),
	('27-19-59', '87378950', 4375),
	('54-27-97', '31715748', 8016),
	('46-74-67', '44619700', 7283),
	('32-44-85', '37306244', 2034),
	('50-22-47', '58366046', 7429),
	('74-39-82', '51738400', 7885),
	('41-40-13', '93100263', 2319),
	('19-85-71', '35559585', 6676),
	('90-91-05', '43141421', 4937),
	('36-97-06', '68164158', 4305),
	('08-36-52', '55874779', 4065),
	('36-21-38', '83676955', 6262),
	('68-01-77', '19707885', 1670),
	('28-86-80', '82833648', 3286),
	('12-96-39', '53707966', 2849),
	('03-76-71', '28072920', 773),
	('31-33-88', '27242542', 1626),
	('39-21-32', '79177125', 1329),
	('37-70-90', '21103397', 6596),
	('67-24-24', '58404253', 1478),
	('10-67-46', '41144866', 4158),
	('74-03-30', '94787698', 8322),
	('44-25-27', '35020960', 1994),
	('19-61-71', '69847827', 337),
	('12-87-45', '31937944', 4017),
	('45-25-42', '45388841', 7353),
	('60-57-31', '39725240', 1036),
	('83-91-56', '23351951', 4282),
	('26-25-85', '10902374', 9589),
	('36-86-41', '83263709', 8711),
	('49-86-28', '18706938', 1595),
	('19-21-90', '56209306', 3338),
	('27-73-90', '90730117', 8819),
	('86-67-38', '32854663', 1912),
	('07-50-76', '43165840', 1311),
	('13-18-33', '37440017', 3780),
	('50-63-63', '13401371', 1237),
	('20-18-99', '74513865', 431),
	('85-63-74', '34645037', 7012),
	('95-30-33', '54423971', 6318),
	('77-85-27', '13014432', 740),
	('69-46-89', '10313320', 656),
	('40-71-29', '88352789', 485),
	('82-02-27', '76332115', 8316),
	('36-47-43', '41893353', 9428),
	('88-12-40', '15628196', 1746),
	('29-09-07', '40670930', 6191),
	('92-77-49', '95518273', 3248),
	('06-45-29', '73725933', 3249),
	('32-68-54', '96921028', 913),
	('07-24-43', '48277083', 3979),
	('99-17-71', '21689916', 1747),
	('36-83-42', '85037001', 6942),
	('83-43-35', '41305528', 4867),
	('98-83-80', '80264743', 4157),
	('18-39-07', '51972766', 4268),
	('07-44-08', '88286849', 6102),
	('09-64-99', '80913228', 2885),
	('17-06-63', '89048967', 5939),
	('83-76-94', '39693673', 3560),
	('11-19-92', '23493502', 4456),
	('32-57-50', '14374300', 5890),
	('16-64-55', '86901942', 2664),
	('48-72-50', '43049372', 771),
	('91-33-33', '38074845', 532),
	('27-59-49', '33784828', 1834),
	('74-77-04', '88414876', 5837),
	('01-83-94', '79083467', 1498),
	('15-76-62', '99639018', 686),
	('71-83-23', '56461300', 633),
	('22-26-79', '62511450', 4036),
	('92-33-48', '27934323', 4471),
	('30-36-43', '75273495', 1657),
	('07-45-15', '19913067', 8931),
	('93-60-74', '18579851', 2394),
	('53-78-32', '14680542', 2564),
	('83-92-70', '69717986', 323),
	('78-84-16', '13889613', 9062),
	('26-08-38', '25651739', 1472),
	('63-46-41', '78620939', 9310),
	('94-65-66', '99195932', 9883),
	('31-72-66', '16395767', 5059),
	('52-85-49', '36676948', 3239),
	('44-26-13', '56764093', 5731),
	('29-62-37', '91747647', 5956),
	('69-79-49', '99245242', 2388),
	('69-32-81', '80015490', 172),
	('68-55-58', '32411638', 9770),
	('16-29-28', '96228138', 5175),
	('22-72-34', '98935393', 9643),
	('50-81-55', '26650483', 4093),
	('64-26-62', '37550291', 9245),
	('57-40-14', '63156029', 6053),
	('25-83-59', '15624338', 4555),
	('35-37-25', '85573485', 5374),
	('61-49-62', '56662826', 6576),
	('83-67-81', '96569191', 6509),
	('91-18-54', '65582970', 7624),
	('65-61-23', '28298874', 6917),
	('24-65-94', '10326203', 1962),
	('77-63-48', '93586838', 7979),
	('51-10-06', '10545923', 3907),
	('79-23-61', '40267528', 6745),
	('65-56-53', '24723605', 3091),
	('55-77-11', '58620199', 7859);


