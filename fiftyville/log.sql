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
SELECT caller, people.name AS callern, receiver, people1.name AS receivern, duration
FROM phone_calls
JOIN people ON phone_calls.caller = people.phone_number
JOIN people people1 on phone_calls.receiver = people1.phone_number
WHERE year = 2021 AND day = 28 AND month = 7;
/*
+----------------+-----------+----------------+-------------+----------+
|     caller     |  callern  |    receiver    |  receivern  | duration |
+----------------+-----------+----------------+-------------+----------+
| (336) 555-0077 | Rose      | (098) 555-1164 | Kaelyn      | 318      |
| (918) 555-5327 | Judy      | (060) 555-2489 | Billy       | 146      |
| (491) 555-2505 | Douglas   | (478) 555-1565 | Virginia    | 241      |
| (996) 555-8899 | Jack      | (059) 555-4698 | Frances     | 142      |
| (704) 555-5790 | Carl      | (772) 555-5770 | Ruth        | 200      |
| (984) 555-5921 | Randy     | (618) 555-9856 | Kevin       | 546      |
| (579) 555-5030 | Andrew    | (971) 555-6468 | Daniel      | 421      |
| (233) 555-0473 | Betty     | (831) 555-0973 | Brenda      | 113      |
| (293) 555-1469 | Nathan    | (749) 555-4874 | Louis       | 195      |
| (450) 555-8297 | Cheryl    | (771) 555-7880 | Ralph       | 298      |
| (130) 555-0289 | Sofia     | (996) 555-8899 | Jack        | 51       |
| (209) 555-7806 | Keith     | (693) 555-7986 | Jesse       | 487      |
| (918) 555-2946 | Kristina  | (006) 555-0505 | Rachel      | 359      |
| (499) 555-9472 | Kelsey    | (892) 555-8872 | Larry       | 36       |
| (669) 555-6918 | Harold    | (914) 555-5994 | Jose        | 233      |
| (547) 555-8781 | Christina | (398) 555-1013 | Brittany    | 272      |
| (544) 555-8087 | Walter    | (389) 555-5198 | Luca        | 595      |
| (666) 555-5774 | Eugene    | (125) 555-8030 | Raymond     | 326      |
| (047) 555-0577 | Dorothy   | (059) 555-4698 | Frances     | 379      |
| (301) 555-4174 | Barry     | (711) 555-3007 | Joan        | 583      |
| (801) 555-9266 | Alexander | (984) 555-5921 | Randy       | 148      |
| (971) 555-6468 | Daniel    | (267) 555-2761 | Joshua      | 149      |
| (367) 555-5533 | Bruce     | (375) 555-8161 | Robin       | 45       |
| (609) 555-5876 | Kathryn   | (389) 555-5198 | Luca        | 60       |
| (357) 555-0246 | Paul      | (502) 555-6712 | Heather     | 305      |
| (367) 555-5533 | Bruce     | (344) 555-9601 | Deborah     | 120      |
| (394) 555-3247 | Arthur    | (035) 555-2997 | Kyle        | 111      |
| (839) 555-1757 | Zachary   | (487) 555-5865 | Kayla       | 278      |
| (770) 555-1196 | Ashley    | (324) 555-0416 | William     | 527      |
| (636) 555-4198 | Jason     | (670) 555-8598 | Amy         | 69       |
| (068) 555-0183 | Margaret  | (770) 555-1861 | Diana       | 371      |
| (711) 555-3007 | Joan      | (113) 555-7544 | Pamela      | 157      |
| (060) 555-2489 | Billy     | (204) 555-4136 | Stephanie   | 510      |
| (704) 555-2131 | Anna      | (891) 555-5672 | Rebecca     | 103      |
| (367) 555-5533 | Bruce     | (022) 555-4052 | Gregory     | 241      |
| (873) 555-3868 | Mark      | (047) 555-0577 | Dorothy     | 109      |
| (867) 555-9103 | Sean      | (068) 555-0183 | Margaret    | 116      |
| (608) 555-9302 | Christine | (725) 555-3243 | Philip      | 280      |
| (901) 555-8732 | Ryan      | (491) 555-2505 | Douglas     | 451      |
| (478) 555-1565 | Virginia  | (717) 555-1342 | Melissa     | 573      |
| (499) 555-9472 | Kelsey    | (717) 555-1342 | Melissa     | 50       |
| (695) 555-0348 | Jean      | (338) 555-6650 | Benista     | 383      |
| (696) 555-9195 | Bryan     | (258) 555-5627 | Olivia      | 525      |
| (286) 555-6063 | Taylor    | (676) 555-6554 | James       | 43       |
| (770) 555-1861 | Diana     | (725) 555-3243 | Philip      | 49       |
| (711) 555-3007 | Joan      | (147) 555-6818 | Diane       | 358      |
| (725) 555-4692 | Vanessa   | (821) 555-5262 | Amanda      | 456      |
| (324) 555-0416 | William   | (452) 555-8550 | Joe         | 328      |
| (234) 555-1294 | Carolyn   | (772) 555-5770 | Ruth        | 573      |
| (669) 555-6918 | Harold    | (971) 555-6468 | Daniel      | 67       |
| (031) 555-6622 | Carina    | (910) 555-3251 | Jacqueline  | 38       |
| (342) 555-9260 | Beverly   | (219) 555-0139 | Logan       | 404      |
| (342) 555-9260 | Beverly   | (487) 555-5865 | Kayla       | 560      |
| (801) 555-9266 | Alexander | (608) 555-9302 | Christine   | 425      |
| (398) 555-1013 | Brittany  | (329) 555-5870 | Emma        | 237      |
| (016) 555-9166 | John      | (336) 555-0077 | Rose        | 88       |
| (594) 555-2863 | Patricia  | (491) 555-2505 | Douglas     | 361      |
| (122) 555-4581 | Brooke    | (831) 555-0973 | Brenda      | 491      |
| (914) 555-5994 | Jose      | (973) 555-3809 | Gloria      | 320      |
| (258) 555-5627 | Olivia    | (695) 555-0348 | Jean        | 368      |
| (751) 555-6567 | Peter     | (594) 555-6254 | Ethan       | 61       |
| (771) 555-7880 | Ralph     | (711) 555-3007 | Joan        | 288      |
| (219) 555-0139 | Logan     | (867) 555-9103 | Sean        | 514      |
| (676) 555-6554 | James     | (328) 555-9658 | Jordan      | 153      |
| (749) 555-4874 | Louis     | (492) 555-5484 | Maria       | 575      |
| (328) 555-9658 | Jordan    | (775) 555-7584 | Christopher | 579      |
| (219) 555-0139 | Logan     | (910) 555-3251 | Jacqueline  | 121      |
| (380) 555-4380 | Dylan     | (680) 555-4935 | Benjamin    | 550      |
| (826) 555-1652 | Kenny     | (066) 555-9701 | Doris       | 55       |
| (594) 555-6254 | Ethan     | (123) 555-5144 | Nicole      | 346      |
| (338) 555-6650 | Benista   | (704) 555-2131 | Anna        | 54       |
| (971) 555-6468 | Daniel    | (258) 555-5627 | Olivia      | 441      |
| (730) 555-5115 | Terry     | (343) 555-0167 | Sharon      | 101      |
| (286) 555-6063 | Taylor    | (310) 555-8568 | Angela      | 235      |
| (367) 555-5533 | Bruce     | (704) 555-5790 | Carl        | 75       |
| (041) 555-4011 | Teresa    | (609) 555-5876 | Kathryn     | 565      |
| (478) 555-1565 | Virginia  | (031) 555-6622 | Carina      | 398      |
+----------------+-----------+----------------+-------------+----------+
*/

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