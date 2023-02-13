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

-- find callers and their names day of theft
SELECT caller, name
FROM phone_calls
JOIN people on phone_calls.caller = people.phone_number
WHERE year = 2021 AND day = 28 AND month = 7;
/*
+----------------+-----------+
|     caller     |   name    |
+----------------+-----------+
| (336) 555-0077 | Rose      |
| (918) 555-5327 | Judy      |
| (491) 555-2505 | Douglas   |
| (996) 555-8899 | Jack      |
| (704) 555-5790 | Carl      |
| (984) 555-5921 | Randy     |
| (579) 555-5030 | Andrew    |
| (233) 555-0473 | Betty     |
| (293) 555-1469 | Nathan    |
| (450) 555-8297 | Cheryl    |
| (130) 555-0289 | Sofia     |
| (209) 555-7806 | Keith     |
| (918) 555-2946 | Kristina  |
| (499) 555-9472 | Kelsey    |
| (669) 555-6918 | Harold    |
| (547) 555-8781 | Christina |
| (544) 555-8087 | Walter    |
| (666) 555-5774 | Eugene    |
| (047) 555-0577 | Dorothy   |
| (301) 555-4174 | Barry     |
| (801) 555-9266 | Alexander |
| (971) 555-6468 | Daniel    |
| (367) 555-5533 | Bruce     |
| (609) 555-5876 | Kathryn   |
| (357) 555-0246 | Paul      |
| (367) 555-5533 | Bruce     |
| (394) 555-3247 | Arthur    |
| (839) 555-1757 | Zachary   |
| (770) 555-1196 | Ashley    |
| (636) 555-4198 | Jason     |
| (068) 555-0183 | Margaret  |
| (711) 555-3007 | Joan      |
| (060) 555-2489 | Billy     |
| (704) 555-2131 | Anna      |
| (367) 555-5533 | Bruce     |
| (873) 555-3868 | Mark      |
| (867) 555-9103 | Sean      |
| (608) 555-9302 | Christine |
| (901) 555-8732 | Ryan      |
| (478) 555-1565 | Virginia  |
| (499) 555-9472 | Kelsey    |
| (695) 555-0348 | Jean      |
| (696) 555-9195 | Bryan     |
| (286) 555-6063 | Taylor    |
| (770) 555-1861 | Diana     |
| (711) 555-3007 | Joan      |
| (725) 555-4692 | Vanessa   |
| (324) 555-0416 | William   |
| (234) 555-1294 | Carolyn   |
| (669) 555-6918 | Harold    |
| (031) 555-6622 | Carina    |
| (342) 555-9260 | Beverly   |
| (342) 555-9260 | Beverly   |
| (801) 555-9266 | Alexander |
| (398) 555-1013 | Brittany  |
| (016) 555-9166 | John      |
| (594) 555-2863 | Patricia  |
| (122) 555-4581 | Brooke    |
| (914) 555-5994 | Jose      |
| (258) 555-5627 | Olivia    |
| (751) 555-6567 | Peter     |
| (771) 555-7880 | Ralph     |
| (219) 555-0139 | Logan     |
| (676) 555-6554 | James     |
| (749) 555-4874 | Louis     |
| (328) 555-9658 | Jordan    |
| (219) 555-0139 | Logan     |
| (380) 555-4380 | Dylan     |
| (826) 555-1652 | Kenny     |
| (594) 555-6254 | Ethan     |
| (338) 555-6650 | Benista   |
| (971) 555-6468 | Daniel    |
| (730) 555-5115 | Terry     |
| (286) 555-6063 | Taylor    |
| (367) 555-5533 | Bruce     |
| (041) 555-4011 | Teresa    |
| (478) 555-1565 | Virginia  |
+----------------+-----------+
*/

-- find receivers of calls the day of the theft
SELECT receiver, name, duration
FROM phone_calls
JOIN people on phone_calls.receiver = people.phone_number
WHERE year = 2021 AND day = 28 AND month = 7;
/*
+----------------+-------------+----------+
|    receiver    |    name     | duration |
+----------------+-------------+----------+
| (098) 555-1164 | Kaelyn      | 318      |
| (060) 555-2489 | Billy       | 146      |
| (478) 555-1565 | Virginia    | 241      |
| (059) 555-4698 | Frances     | 142      |
| (772) 555-5770 | Ruth        | 200      |
| (618) 555-9856 | Kevin       | 546      |
| (971) 555-6468 | Daniel      | 421      |
| (831) 555-0973 | Brenda      | 113      |
| (749) 555-4874 | Louis       | 195      |
| (771) 555-7880 | Ralph       | 298      |
| (996) 555-8899 | Jack        | 51       |
| (693) 555-7986 | Jesse       | 487      |
| (006) 555-0505 | Rachel      | 359      |
| (892) 555-8872 | Larry       | 36       |
| (914) 555-5994 | Jose        | 233      |
| (398) 555-1013 | Brittany    | 272      |
| (389) 555-5198 | Luca        | 595      |
| (125) 555-8030 | Raymond     | 326      |
| (059) 555-4698 | Frances     | 379      |
| (711) 555-3007 | Joan        | 583      |
| (984) 555-5921 | Randy       | 148      |
| (267) 555-2761 | Joshua      | 149      |
| (375) 555-8161 | Robin       | 45       |
| (389) 555-5198 | Luca        | 60       |
| (502) 555-6712 | Heather     | 305      |
| (344) 555-9601 | Deborah     | 120      |
| (035) 555-2997 | Kyle        | 111      |
| (487) 555-5865 | Kayla       | 278      |
| (324) 555-0416 | William     | 527      |
| (670) 555-8598 | Amy         | 69       |
| (770) 555-1861 | Diana       | 371      |
| (113) 555-7544 | Pamela      | 157      |
| (204) 555-4136 | Stephanie   | 510      |
| (891) 555-5672 | Rebecca     | 103      |
| (022) 555-4052 | Gregory     | 241      |
| (047) 555-0577 | Dorothy     | 109      |
| (068) 555-0183 | Margaret    | 116      |
| (725) 555-3243 | Philip      | 280      |
| (491) 555-2505 | Douglas     | 451      |
| (717) 555-1342 | Melissa     | 573      |
| (717) 555-1342 | Melissa     | 50       |
| (338) 555-6650 | Benista     | 383      |
| (258) 555-5627 | Olivia      | 525      |
| (676) 555-6554 | James       | 43       |
| (725) 555-3243 | Philip      | 49       |
| (147) 555-6818 | Diane       | 358      |
| (821) 555-5262 | Amanda      | 456      |
| (452) 555-8550 | Joe         | 328      |
| (772) 555-5770 | Ruth        | 573      |
| (971) 555-6468 | Daniel      | 67       |
| (910) 555-3251 | Jacqueline  | 38       |
| (219) 555-0139 | Logan       | 404      |
| (487) 555-5865 | Kayla       | 560      |
| (608) 555-9302 | Christine   | 425      |
| (329) 555-5870 | Emma        | 237      |
| (336) 555-0077 | Rose        | 88       |
| (491) 555-2505 | Douglas     | 361      |
| (831) 555-0973 | Brenda      | 491      |
| (973) 555-3809 | Gloria      | 320      |
| (695) 555-0348 | Jean        | 368      |
| (594) 555-6254 | Ethan       | 61       |
| (711) 555-3007 | Joan        | 288      |
| (867) 555-9103 | Sean        | 514      |
| (328) 555-9658 | Jordan      | 153      |
| (492) 555-5484 | Maria       | 575      |
| (775) 555-7584 | Christopher | 579      |
| (910) 555-3251 | Jacqueline  | 121      |
| (680) 555-4935 | Benjamin    | 550      |
| (066) 555-9701 | Doris       | 55       |
| (123) 555-5144 | Nicole      | 346      |
| (704) 555-2131 | Anna        | 54       |
| (258) 555-5627 | Olivia      | 441      |
| (343) 555-0167 | Sharon      | 101      |
| (310) 555-8568 | Angela      | 235      |
| (704) 555-5790 | Carl        | 75       |
| (609) 555-5876 | Kathryn     | 565      |
| (031) 555-6622 | Carina      | 398      |
+----------------+-------------+----------+
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
