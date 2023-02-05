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


