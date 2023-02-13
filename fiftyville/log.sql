-- Keep a log of any SQL queries you execute as you solve the mystery.

-- find tables
.tables
-- airports, atm_transactions, bakery_security_logs, bank_accounts, crime_Scene_reports, flights,
-- interviews, passengers, people, phone_calls

-- find columns in tables
.schema
/*
CREATE TABLE crime_scene_reports (
    id INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    street TEXT,
    description TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE interviews (
    id INTEGER,
    name TEXT,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    transcript TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE atm_transactions (
    id INTEGER,
    account_number INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    atm_location TEXT,
    transaction_type TEXT,
    amount INTEGER,
    PRIMARY KEY(id)
);
CREATE TABLE bank_accounts (
    account_number INTEGER,
    person_id INTEGER,
    creation_year INTEGER,
    FOREIGN KEY(person_id) REFERENCES people(id)
);
CREATE TABLE airports (
    id INTEGER,
    abbreviation TEXT,
    full_name TEXT,
    city TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE flights (
    id INTEGER,
    origin_airport_id INTEGER,
    destination_airport_id INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    minute INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY(origin_airport_id) REFERENCES airports(id),
    FOREIGN KEY(destination_airport_id) REFERENCES airports(id)
);
CREATE TABLE passengers (
    flight_id INTEGER,
    passport_number INTEGER,
    seat TEXT,
    FOREIGN KEY(flight_id) REFERENCES flights(id)
);
CREATE TABLE phone_calls (
    id INTEGER,
    caller TEXT,
    receiver TEXT,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    duration INTEGER,
    PRIMARY KEY(id)
);
CREATE TABLE people (
    id INTEGER,
    name TEXT,
    phone_number TEXT,
    passport_number INTEGER,
    license_plate TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE bakery_security_logs (
    id INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    minute INTEGER,
    activity TEXT,
    license_plate TEXT,
    PRIMARY KEY(id)
);
*/

-- Find crime scenes from that day; Look for ones where date and location match
SELECT *
FROM crime_scene_reports
WHERE street = "Humphrey Street" AND month = 7 AND day = 28 AND year = 2021;
/*
+-----+------+-------+-----+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| id  | year | month | day |     street      |                                                                                                       description                                                                                                        |
+-----+------+-------+-----+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 295 | 2021 | 7     | 28  | Humphrey Street | Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery. |
| 297 | 2021 | 7     | 28  | Humphrey Street | Littering took place at 16:36. No known witnesses.                                                                                                                                                                       |
+-----+------+-------+-----+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-- Interviews happened same day as theft
*/

-- Look at interviews
SELECT *
FROM interviews
WHERE month = 7 AND day = 28 AND year = 2021;
/*
+-----+---------+------+-------+-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| id  |  name   | year | month | day |                                                                                                                                                     transcript                                                                                                                                                      |
+-----+---------+------+-------+-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 158 | Jose    | 2021 | 7     | 28  | “Ah,” said he, “I forgot that I had not seen you for some weeks. It is a little souvenir from the King of Bohemia in return for my assistance in the case of the Irene Adler papers.”                                                                                                                               |
| 159 | Eugene  | 2021 | 7     | 28  | “I suppose,” said Holmes, “that when Mr. Windibank came back from France he was very annoyed at your having gone to the ball.”                                                                                                                                                                                      |
| 160 | Barbara | 2021 | 7     | 28  | “You had my note?” he asked with a deep harsh voice and a strongly marked German accent. “I told you that I would call.” He looked from one to the other of us, as if uncertain which to address.                                                                                                                   |
| 161 | Ruth    | 2021 | 7     | 28  | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.                                                          |
| 162 | Eugene  | 2021 | 7     | 28  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |
| 163 | Raymond | 2021 | 7     | 28  | As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket. |
| 191 | Lily    | 2021 | 7     | 28  | Our neighboring courthouse has a very annoying rooster that crows loudly at 6am every day. My sons Robert and Patrick took the rooster to a city far, far away, so it may never bother us again. My sons have successfully arrived in Paris.                                                                        |
+-----+---------+------+-------+-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
*/

-- check bakery logs the day of the theft 15 min before or after the crime with names/activity
SELECT bakery_security_logs.license_plate, name, activity
FROM bakery_security_logs
JOIN people ON bakery_security_logs.license_plate = people.license_plate
WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 15 AND minute <=25;
/*
+---------------+---------+----------+
| license_plate |  name   | activity |
+---------------+---------+----------+
| 5P2BI95       | Vanessa | exit     |
| 94KL13X       | Bruce   | exit     |
| 6P58WS2       | Barry   | exit     |
| 4328GD8       | Luca    | exit     |
| G412CB7       | Sofia   | exit     |
| L93JTIZ       | Iman    | exit     |
| 322W7JE       | Diana   | exit     |
| 0NTHK55       | Kelsey  | exit     |
+---------------+---------+----------+

-- find callers, receivers, duration
SELECT caller, people.name AS callern, receiver, people1.name AS receivern
FROM phone_calls
JOIN people ON phone_calls.caller = people.phone_number
JOIN people people1 on phone_calls.receiver = people1.phone_number
WHERE year = 2021 AND day = 28 AND month = 7 AND duration <= 60;
/*
+----------------+---------+----------------+------------+
|     caller     | callern |    receiver    | receivern  |
+----------------+---------+----------------+------------+
| (130) 555-0289 | Sofia   | (996) 555-8899 | Jack       |
| (499) 555-9472 | Kelsey  | (892) 555-8872 | Larry      |
| (367) 555-5533 | Bruce   | (375) 555-8161 | Robin      |
| (609) 555-5876 | Kathryn | (389) 555-5198 | Luca       |
| (499) 555-9472 | Kelsey  | (717) 555-1342 | Melissa    |
| (286) 555-6063 | Taylor  | (676) 555-6554 | James      |
| (770) 555-1861 | Diana   | (725) 555-3243 | Philip     |
| (031) 555-6622 | Carina  | (910) 555-3251 | Jacqueline |
| (826) 555-1652 | Kenny   | (066) 555-9701 | Doris      |
| (338) 555-6650 | Benista | (704) 555-2131 | Anna       |
+----------------+---------+----------------+------------+

-- bank transactions on day of theft
SELECT amount, transaction_type, name
FROM atm_transactions
JOIN bank_accounts ON atm_transactions.account_number = bank_accounts.account_number JOIN people ON bank_accounts.person_id = people.id
WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street";
/*
+--------+------------------+---------+
| amount | transaction_type |  name   |
+--------+------------------+---------+
| 50     | withdraw         | Bruce   |
| 10     | deposit          | Kaelyn  |
| 35     | withdraw         | Diana   |
| 80     | withdraw         | Brooke  |
| 20     | withdraw         | Kenny   |
| 20     | withdraw         | Iman    |
| 48     | withdraw         | Luca    |
| 60     | withdraw         | Taylor  |
| 30     | withdraw         | Benista |
+--------+------------------+---------+
*/

-- check who took flights from Fiftyville on the day of theft and where to
SELECT full_name, city, abbreviation, hour, minute, name
FROM airports JOIN flights on airports.id = flights.destination_airport_id
JOIN passengers ON flights.id = passengers.flight_id
JOIN people on passengers.passport_number = people.passport_number
WHERE flights.origin_airport_id
    IN (SELECT id FROM airports WHERE city = "Fiftyville") AND year = 2021 AND month = 7 AND day = 28;
/*
+-----------------------------------------+---------------+--------------+------+--------+---------+
|                full_name                |     city      | abbreviation | hour | minute |  name   |
+-----------------------------------------+---------------+--------------+------+--------+---------+
| Dubai International Airport             | Dubai         | DXB          | 17   | 50     | Betty   |
| Dubai International Airport             | Dubai         | DXB          | 17   | 50     | Jose    |
| Dubai International Airport             | Dubai         | DXB          | 17   | 50     | Carina  |
| Dubai International Airport             | Dubai         | DXB          | 17   | 50     | Sara    |
| Dallas/Fort Worth International Airport | Dallas        | DFS          | 13   | 49     | Nicole  |
| Dallas/Fort Worth International Airport | Dallas        | DFS          | 13   | 49     | Amanda  |
| Dallas/Fort Worth International Airport | Dallas        | DFS          | 13   | 49     | Joyce   |
| Dallas/Fort Worth International Airport | Dallas        | DFS          | 13   | 49     | Jean    |
| Dallas/Fort Worth International Airport | Dallas        | DFS          | 13   | 49     | Daniel  |
| Dallas/Fort Worth International Airport | Dallas        | DFS          | 13   | 49     | Carol   |
| Dallas/Fort Worth International Airport | Dallas        | DFS          | 13   | 49     | Rebecca |
| Dallas/Fort Worth International Airport | Dallas        | DFS          | 13   | 49     | Sophia  |
| LaGuardia Airport                       | New York City | LGA          | 20   | 16     | Brooke  |
| LaGuardia Airport                       | New York City | LGA          | 20   | 16     | Larry   |
| LaGuardia Airport                       | New York City | LGA          | 20   | 16     | Steven  |
| LaGuardia Airport                       | New York City | LGA          | 20   | 16     | John    |
| LaGuardia Airport                       | New York City | LGA          | 20   | 16     | Pamela  |
| LaGuardia Airport                       | New York City | LGA          | 20   | 16     | Melissa |
| LaGuardia Airport                       | New York City | LGA          | 20   | 16     | Sharon  |
| LaGuardia Airport                       | New York City | LGA          | 20   | 16     | Olivia  |
| Dallas/Fort Worth International Airport | Dallas        | DFS          | 17   | 20     | Pamela  |
| Dallas/Fort Worth International Airport | Dallas        | DFS          | 17   | 20     | Billy   |
| Dallas/Fort Worth International Airport | Dallas        | DFS          | 17   | 20     | Hannah  |
| Dallas/Fort Worth International Airport | Dallas        | DFS          | 17   | 20     | Grace   |
| Dallas/Fort Worth International Airport | Dallas        | DFS          | 17   | 20     | Kathryn |
| LaGuardia Airport                       | New York City | LGA          | 16   | 16     | Jean    |
| LaGuardia Airport                       | New York City | LGA          | 16   | 16     | Judith  |
| LaGuardia Airport                       | New York City | LGA          | 16   | 16     | Natalie |
| LaGuardia Airport                       | New York City | LGA          | 16   | 16     | Olivia  |
| LaGuardia Airport                       | New York City | LGA          | 16   | 16     | Laura   |
| LaGuardia Airport                       | New York City | LGA          | 16   | 16     | Paul    |
| LaGuardia Airport                       | New York City | LGA          | 16   | 16     | Sean    |
| LaGuardia Airport                       | New York City | LGA          | 16   | 16     | Nancy   |
+-----------------------------------------+---------------+--------------+------+--------+---------+
*/

-- check if Robert or Patrick went to Paris
SELECT full_name, city, abbreviation, hour, minute, name
FROM airports
JOIN flights on airports.id = flights.destination_airport_id
JOIN passengers ON flights.id = passengers.flight_id JOIN people on passengers.passport_number = people.passport_number
WHERE name = "Patrick" OR name = "Robert";