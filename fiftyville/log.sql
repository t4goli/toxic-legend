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

-- find suspects
SELECT * FROM people;
/*
+--------+-------------+----------------+-----------------+---------------+
|   id   |    name     |  phone_number  | passport_number | license_plate |
+--------+-------------+----------------+-----------------+---------------+
| 205082 | Pamela      | (113) 555-7544 | 1050247273      | 5CIO816       |
| 210245 | Jordan      | (328) 555-9658 | 7951366683      | HW0488P       |
| 210641 | Heather     | (502) 555-6712 | 4356447308      |               |
| 221103 | Vanessa     | (725) 555-4692 | 2963008352      | 5P2BI95       |
| 222194 | Ronald      | (321) 555-6083 | 4959515588      | 9XPY28H       |
| 223936 | Natalie     |                | 6627121233      | F494C29       |
| 225259 | Sean        | (867) 555-9103 | 4377966420      |               |
| 229076 | Aaron       | (420) 555-5821 | 9852889341      |               |
| 229572 | Ernest      | (789) 555-8833 | 6216255522      | C3S4W87       |
| 230917 | Karen       | (841) 555-3728 | 5031682798      | IH61GO8       |
| 231387 | Margaret    | (068) 555-0183 | 1782675901      | 60563QT       |
| 233575 | Gabriel     | (243) 555-7229 | 9747563214      | B49OR81       |
| 242207 | Louis       | (749) 555-4874 | 5361280978      |               |
| 243696 | Barry       | (301) 555-4174 | 7526138472      | 6P58WS2       |
| 250185 | Abigail     | (183) 555-7322 |                 | Q98UB5W       |
| 250277 | James       | (676) 555-6554 | 2438825627      | Q13SVG6       |
| 251693 | Larry       | (892) 555-8872 | 2312901747      | O268ZZ0       |
| 253397 | Kristina    | (918) 555-2946 | 6131360461      | P743G7C       |
| 255860 | Virginia    | (478) 555-1565 | 3866596772      |               |
| 260099 | Austin      |                | 5140313594      | P160306       |
| 265512 | Juan        | (337) 555-9411 | 7020183712      | 8BB36NX       |
| 267176 | Cynthia     | (458) 555-8396 | 2169423415      |               |
| 271242 | Albert      | (042) 555-1772 |                 | 673020C       |
| 274388 | Laura       | (067) 555-4133 | 1801324150      | 4406M71       |
| 274893 | Christina   | (547) 555-8781 | 4322787338      | 79X5400       |
| 279793 | Cheryl      | (450) 555-8297 |                 | VWJ25E5       |
| 280744 | Eugene      | (666) 555-5774 | 9584465633      | 47592FJ       |
| 282425 | Martha      | (007) 555-2874 |                 | O784M2U       |
| 293512 | Gerald      |                | 8932594930      | X0Q6908       |
| 293753 | Ryan        | (901) 555-8732 |                 | 0WZS77X       |
| 313696 | Megan       | (222) 555-8026 | 4879021885      |               |
| 313837 | Tyler       | (660) 555-3095 | 8613298074      | 3H26E71       |
| 315221 | Gregory     | (022) 555-4052 | 3355598951      | V4C670D       |
| 316531 | Eric        | (869) 555-6696 |                 | X8T96JM       |
| 319800 | Jacob       | (037) 555-8455 | 5584283945      | P45A66L       |
| 325548 | Brandon     | (771) 555-6667 | 7874488539      | R3G7486       |
| 331126 | Brenda      | (831) 555-0973 | 1139561952      | N7M42GP       |
| 331484 | Judy        | (918) 555-5327 | 1236213682      | KGG82IR       |
| 336397 | Joan        | (711) 555-3007 |                 | L476K20       |
| 337221 | Christine   | (608) 555-9302 |                 | XE95071       |
| 341739 | Rebecca     | (891) 555-5672 | 6264773605      |               |
| 343408 | Grace       | (932) 555-1504 | 9826028703      | HXA8903       |
| 343881 | Helen       |                | 8810489487      | G3QW7I4       |
| 354903 | Marilyn     | (568) 555-3190 | 7441135547      | 0R0FW39       |
| 358382 | Walter      | (544) 555-8087 | 4223654265      | 82456Y8       |
| 360948 | Carolyn     | (234) 555-1294 | 3925120216      | P14PE2Q       |
| 363991 | Christopher | (775) 555-7584 | 3249120117      | 91UQ3NC       |
| 368533 | Kayla       | (487) 555-5865 | 4674590724      | 2729MD0       |
| 372684 | Alexander   | (801) 555-9266 |                 | 8P9NEU9       |
| 375525 | Noah        | (959) 555-4871 | 1095374669      | 11J91FW       |
| 379932 | Joshua      | (267) 555-2761 | 3761239013      | 1FBL6TH       |
| 384013 | Debra       |                | 2750542732      | 47MEFVA       |
| 384637 | Kelly       | (496) 555-2096 | 4041498045      |               |
| 395717 | Kenny       | (826) 555-1652 | 9878712108      | 30G67EN       |
| 396669 | Iman        | (829) 555-5269 | 7049073643      | L93JTIZ       |
| 398010 | Sofia       | (130) 555-0289 | 1695452385      | G412CB7       |
| 402368 | Lauren      | (707) 555-7535 | 5551547908      | 3899SY4       |
| 404704 | Catherine   | (020) 555-6715 |                 | NA31S0K       |
| 419774 | Teresa      | (041) 555-4011 | 8699553201      | HW0BF87       |
| 423393 | Carol       | (168) 555-6126 | 6128131458      | 81MNC9R       |
| 430845 | Ruth        | (772) 555-5770 |                 | HZB4129       |
| 438727 | Benista     | (338) 555-6650 | 9586786673      | 8X428L0       |
| 440007 | Sara        | (340) 555-8872 | 3412604728      | 99A843C       |
| 447494 | Dennis      |                | 4149859587      |               |
| 449774 | Taylor      | (286) 555-6063 | 1988161715      | 1106N58       |
| 458378 | Brooke      | (122) 555-4581 | 4408372428      | QX4YZN3       |
| 467400 | Luca        | (389) 555-5198 | 8496433585      | 4328GD8       |
| 477251 | Billy       | (060) 555-2489 | 9290922261      | 2HB7G9N       |
| 484375 | Anna        | (704) 555-2131 |                 |               |
| 485785 | Barbara     | (367) 555-0409 | 1165086731      | HN8I106       |
| 486361 | Wayne       | (056) 555-0309 |                 | D965M59       |
| 490439 | Jesse       | (693) 555-7986 |                 | 608027W       |
| 495558 | Stephanie   | (204) 555-4136 | 7712200330      | 2001OV9       |
| 502920 | Susan       |                | 8623763125      |               |
| 504758 | Samantha    | (956) 555-1395 | 6720918005      | E9PF99X       |
| 505688 | Jean        | (695) 555-0348 | 1682575122      | JN7K44M       |
| 506435 | Zachary     | (839) 555-1757 |                 | 5810O6V       |
| 514354 | Diana       | (770) 555-1861 | 3592750733      | 322W7JE       |
| 518594 | Randy       | (984) 555-5921 | 7538263720      | 106OW2W       |
| 520840 | Jeffrey     |                | 2041495124      | EH6V12Q       |
| 526940 | Hannah      | (877) 555-0523 | 3366196639      | 88CEO92       |
| 534459 | Olivia      | (258) 555-5627 | 6632213958      | X273ZK9       |
| 537582 | Bradley     | (873) 555-8470 | 1526109096      | 9Y0JT4U       |
| 539107 | Joseph      | (238) 555-5554 | 4328444220      |               |
| 539330 | Marie       |                |                 | C4559Y9       |
| 539960 | Theresa     | (190) 555-4928 | 1833124350      | 668A8SL       |
| 542503 | Michael     | (529) 555-7276 | 6117294637      | HOD8639       |
| 545303 | Nicholas    | (095) 555-3639 | 2581746522      | 5840J5X       |
| 548858 | Kathleen    | (960) 555-2044 | 2628207874      | PF37ZVK       |
| 559765 | William     | (324) 555-0416 |                 | FA63H32       |
| 560886 | Kelsey      | (499) 555-9472 | 8294398571      | 0NTHK55       |
| 561160 | Kathryn     | (609) 555-5876 | 6121106406      | 4ZY7I8T       |
| 565511 | Vincent     |                | 3011089587      | 94MV71O       |
| 567218 | Jack        | (996) 555-8899 | 9029462229      | 52R0Y8U       |
| 572028 | Paul        | (357) 555-0246 | 9143726159      | R64E41W       |
| 579698 | Mary        | (188) 555-4719 |                 | C194752       |
| 580086 | Betty       | (233) 555-0473 | 2400516856      | 47KK91C       |
| 585903 | Arthur      | (394) 555-3247 | 7884829354      | 64I1286       |
| 586942 | Justin      | (721) 555-1131 | 9608210024      |               |
| 591369 | Dylan       | (380) 555-4380 | 5776544886      | DN6Z7FH       |
| 600230 | Isabella    |                | 9893853348      |               |
| 600585 | Bryan       | (696) 555-9195 | 3833243751      | 8911U63       |
| 604497 | Ralph       | (771) 555-7880 | 6464352048      | 3933NUH       |
| 606219 | Jessica     | (786) 555-5321 | 7118667746      | ET017P4       |
| 612949 | Benjamin    | (680) 555-4935 |                 | I8S932C       |
| 617509 | Jerry       | (558) 555-9741 | 3816396248      | 4DD691O       |
| 619074 | Matthew     |                | 4195341387      | 31GVT84       |
| 620295 | Janet       | (464) 555-2162 | 2160709651      | P72XP87       |
| 620297 | Peter       | (751) 555-6567 | 9224308981      | N507616       |
| 622544 | Joe         | (452) 555-8550 |                 | 24X1AQM       |
| 623724 | Julia       |                | 5380305521      | L605IHS       |
| 626361 | Melissa     | (717) 555-1342 | 7834357192      |               |
| 630782 | Alexis      | (814) 555-5180 | 5310124622      | X4G3938       |
| 632023 | Amanda      | (821) 555-5262 | 1618186613      | RS7I6A0       |
| 634238 | Sandra      | (604) 555-0153 |                 | 2BDU20B       |
| 637069 | Michelle    | (738) 555-2050 | 4590049635      | 52E25A9       |
| 639344 | Charlotte   | (455) 555-5315 | 7226911797      | Z5FH038       |
| 650560 | Rose        | (336) 555-0077 | 8909375052      | O7JQ1SA       |
| 651217 | Alan        |                | 2884243902      | JUP02H1       |
| 651714 | Edward      | (328) 555-1152 | 1540955065      | 130LD9Z       |
| 652398 | Carl        | (704) 555-5790 | 7771405611      | 81MZ921       |
| 652412 | Denise      | (994) 555-3373 | 4001449165      | NRYN856       |
| 658630 | Brittany    | (398) 555-1013 |                 | 6T124Q8       |
| 660982 | Thomas      | (286) 555-0131 | 6034823042      | WD5M8I6       |
| 676919 | Steven      | (195) 555-4173 | 1151340634      | 5VFD6G0       |
| 677560 | Samuel      |                | 2180939853      | 10J5R8P       |
| 677698 | John        | (016) 555-9166 | 8174538026      | 4468KVT       |
| 681821 | David       | (260) 555-0610 | 8834222028      | SF5001S       |
| 682699 | Linda       |                | 4120608613      |               |
| 682850 | Ethan       | (594) 555-6254 | 2996517496      | NAW9653       |
| 685894 | Donald      | (971) 555-2231 |                 | R964VP9       |
| 686048 | Bruce       | (367) 555-5533 | 5773159633      | 94KL13X       |
| 692353 | Jonathan    | (211) 555-3762 | 2047409662      | 7627B71       |
| 697106 | Henry       | (645) 555-8082 | 3699913849      | 6590Q1M       |
| 704850 | Rachel      | (006) 555-0505 |                 | 7Z8B130       |
| 710572 | Richard     |                | 7894166154      | 20Q418R       |
| 712712 | Jacqueline  | (910) 555-3251 |                 | 43V0R5D       |
| 713341 | Donna       |                |                 | 8LLB02B       |
| 717401 | Terry       | (730) 555-5115 | 3564659888      | 5209A97       |
| 718152 | Jason       | (636) 555-4198 | 2818150870      | 8666X39       |
| 719061 | Ashley      | (770) 555-1196 | 1038053449      |               |
| 720244 | Dorothy     | (047) 555-0577 | 9135709773      | 7T807V5       |
| 730171 | Ann         | (601) 555-6795 | 4215752756      | 84869TJ       |
| 734908 | Maria       | (492) 555-5484 |                 | 3N39WQN       |
| 743806 | Sharon      | (343) 555-0167 | 9687940003      | 9N79I17       |
| 745650 | Sophia      | (027) 555-1068 | 3642612721      | 13FNH73       |
| 747078 | Judith      |                | 8284363264      | 4963D92       |
| 748674 | Jeremy      | (194) 555-5027 | 1207566299      | V47T75I       |
| 750165 | Daniel      | (971) 555-6468 | 7597790505      | FLFN3W0       |
| 753885 | Jennifer    | (911) 555-0229 | 7378796210      | 1K44SN8       |
| 754943 | Nathan      | (293) 555-1469 | 8914039923      | 11WB3I6       |
| 757606 | Douglas     | (491) 555-2505 | 3231999695      | 1FW4EUJ       |
| 762248 | Kyle        | (035) 555-2997 |                 | 2M2Y681       |
| 764352 | Scott       | (801) 555-8906 | 6264781665      | 68K1239       |
| 764823 | Keith       | (209) 555-7806 | 9698118788      | 630U2R7       |
| 768035 | Diane       | (147) 555-6818 | 6099879058      | WR2G758       |
| 768248 | George      |                | 4977790793      | L68E5I0       |
| 769190 | Charles     | (427) 555-0556 | 3915621712      | R12SA4D       |
| 779942 | Harold      | (669) 555-6918 |                 | DVS39US       |
| 780088 | Nicole      | (123) 555-5144 | 3835860232      | 91S1K32       |
| 788213 | Emily       | (406) 555-4440 | 6263461050      | Y340743       |
| 788911 | Gloria      | (973) 555-3809 | 2835165196      | O010420       |
| 795190 | Frances     | (059) 555-4698 | 5138876283      | 97O6H62       |
| 801296 | Anthony     |                | 8639149598      | 50U175Y       |
| 804716 | Kevin       | (618) 555-9856 |                 | QDS31M6       |
| 809194 | Alice       | (031) 555-9915 | 1679711307      | 1M92998       |
| 809265 | Jose        | (914) 555-5994 | 9183348466      |               |
| 810563 | Gary        |                | 6038029185      | S5EI3B0       |
| 818095 | Patricia    | (594) 555-2863 | 5806941094      | R059OD5       |
| 821978 | Beverly     | (342) 555-9260 | 2793107431      |               |
| 828675 | Nancy       | (998) 555-1979 | 7021171868      | 878Z799       |
| 832111 | Emma        | (329) 555-5870 | 7968707324      | 1628C65       |
| 834626 | Shirley     |                | 4754635619      | 3S8505X       |
| 837455 | Andrew      | (579) 555-5030 |                 | W2CT78U       |
| 847116 | Philip      | (725) 555-3243 | 3391710505      | GW362R6       |
| 850016 | Mark        | (873) 555-3868 | 4631067354      | YD7376W       |
| 857325 | Timothy     | (962) 555-5827 | 7178034193      | 3AML2V7       |
| 864400 | Robin       | (375) 555-8161 |                 | 4V16VO0       |
| 872102 | Joyce       |                | 7179245843      | 594IBK6       |
| 893762 | Janice      | (033) 555-9033 |                 | 61226BT       |
| 907148 | Carina      | (031) 555-6622 | 9628244268      | Q12B3Z3       |
| 910162 | Brian       | (636) 555-3370 | 2329158653      | Y46HW88       |
| 912825 | Katherine   |                |                 |               |
| 920334 | Stephen     | (247) 555-7205 |                 | 99N25L1       |
| 926715 | Frank       | (356) 555-6641 | 8336437534      | 207W38T       |
| 929343 | Andrea      | (368) 555-3561 | 7954314541      | 245THL6       |
| 937274 | Raymond     | (125) 555-8030 |                 | Y18DLY3       |
| 948985 | Kaelyn      | (098) 555-1164 | 8304650265      | I449449       |
| 952462 | Christian   |                | 2626335085      | 6CV51G1       |
| 953420 | Amy         | (670) 555-8598 | 9355133130      |               |
| 953679 | Doris       | (066) 555-9701 | 7214083635      | M51FA04       |
| 955017 | Sarah       | (505) 555-5698 | 9172951504      | 47602K4       |
| 962494 | Johnny      | (117) 555-6630 | 7918203533      | 3JC5R39       |
| 966408 | Adam        |                |                 | FQUFJ16       |
| 969163 | Willie      | (741) 555-1748 | 4158550933      |               |
| 975354 | Logan       | (219) 555-0139 | 9692634019      | 6866W0M       |
| 985497 | Deborah     | (344) 555-9601 | 8714200946      | 10I5658       |
| 985539 | Lisa        | (118) 555-8106 |                 | B3VSJVF       |
| 992589 | Lawrence    |                | 2290269570      | TWA51P1       |
| 994229 | Angela      | (310) 555-8568 | 9920757687      | SS458D7       |
+--------+-------------+----------------+-----------------+---------------+
*/

-- Find crime scenes from that day
SELECT * FROM crime_scene_reports;
/*
+-----+------+-------+-----+----------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| id  | year | month | day |        street        |                                                                                                       description                                                                                                        |
+-----+------+-------+-----+----------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 1   | 2021 | 1     | 1   | Chamberlin Street    | Credit card fraud took place at 00:53. Two people witnessed the event.                                                                                                                                                   |
| 2   | 2021 | 1     | 1   | Zlatkova Street      | Burglary took place at 05:23. Two people witnessed the event.                                                                                                                                                            |
| 3   | 2021 | 1     | 1   | Bowden Boulevard     | Shoplifting took place at 20:48. Two people witnessed the event.                                                                                                                                                         |
| 4   | 2021 | 1     | 1   | Boyce Avenue         | Jaywalking took place at 23:37. Two people witnessed the event.                                                                                                                                                          |
| 5   | 2021 | 1     | 2   | Widenius Street      | Jaywalking took place at 20:33. One person witnessed the incident.                                                                                                                                                       |
| 6   | 2021 | 1     | 3   | Chartier Road        | Insider trading took place at 19:32. Two people witnessed the event.                                                                                                                                                     |
| 7   | 2021 | 1     | 3   | Blumberg Boulevard   | Theft took place at 20:49. No known witnesses.                                                                                                                                                                           |
| 8   | 2021 | 1     | 4   | Fifer Street         | Bank robbery took place at 10:32. No known witnesses.                                                                                                                                                                    |
| 9   | 2021 | 1     | 4   | Blumberg Boulevard   | Money laundering took place at 05:26. No known witnesses.                                                                                                                                                                |
| 10  | 2021 | 1     | 5   | Widenius Street      | Insider trading took place at 05:13. Two people witnessed the event.                                                                                                                                                     |
| 11  | 2021 | 1     | 5   | Carreiro Avenue      | Credit card fraud took place at 21:35. Two people witnessed the event.                                                                                                                                                   |
| 12  | 2021 | 1     | 5   | MacWilliam Road      | Littering took place at 04:18. No known witnesses.                                                                                                                                                                       |
| 13  | 2021 | 1     | 6   | Aydede Lane          | Reckless driving took place at 07:18. No known witnesses.                                                                                                                                                                |
| 14  | 2021 | 1     | 6   | Fifer Street         | Insider trading took place at 11:35. No known witnesses.                                                                                                                                                                 |
| 15  | 2021 | 1     | 7   | Humphrey Lane        | Shoplifting took place at 11:42. One person witnessed the incident.                                                                                                                                                      |
| 16  | 2021 | 1     | 7   | Zlatkova Street      | Credit card fraud took place at 14:47. Two people witnessed the event.                                                                                                                                                   |
| 17  | 2021 | 1     | 7   | Hipp Boulevard       | Credit card fraud took place at 03:14. Two people witnessed the event.                                                                                                                                                   |
| 18  | 2021 | 1     | 8   | Aydede Lane          | Jaywalking took place at 10:04. Two people witnessed the event.                                                                                                                                                          |
| 19  | 2021 | 1     | 8   | Carvalho Road        | Bank robbery took place at 15:30. Two people witnessed the event.                                                                                                                                                        |
| 20  | 2021 | 1     | 8   | Larsson Lane         | Credit card fraud took place at 13:40. No known witnesses.                                                                                                                                                               |
| 21  | 2021 | 1     | 9   | Boyce Avenue         | Expired parking meter took place at 01:53. No known witnesses.                                                                                                                                                           |
| 22  | 2021 | 1     | 10  | Yamashita Avenue     | Theft took place at 16:16. One person witnessed the incident.                                                                                                                                                            |
| 23  | 2021 | 1     | 10  | Carvalho Road        | Theft took place at 01:15. Two people witnessed the event.                                                                                                                                                               |
| 24  | 2021 | 1     | 11  | Stonebraker Road     | Shoplifting took place at 13:23. No known witnesses.                                                                                                                                                                     |
| 25  | 2021 | 1     | 11  | Lloyd Lane           | Wire fraud took place at 10:38. One person witnessed the incident.                                                                                                                                                       |
| 26  | 2021 | 1     | 11  | Carvalho Road        | Forgery took place at 23:28. Two people witnessed the event.                                                                                                                                                             |
| 27  | 2021 | 1     | 12  | Boyce Avenue         | Theft took place at 16:51. Two people witnessed the event.                                                                                                                                                               |
| 28  | 2021 | 1     | 12  | Chartier Road        | Burglary took place at 12:57. One person witnessed the incident.                                                                                                                                                         |
| 29  | 2021 | 1     | 13  | Carvalho Road        | Credit card fraud took place at 11:12. No known witnesses.                                                                                                                                                               |
| 30  | 2021 | 1     | 13  | Aydede Lane          | Expired parking meter took place at 22:55. One person witnessed the incident.                                                                                                                                            |
| 31  | 2021 | 1     | 16  | Axmark Road          | Vandalism took place at 16:41. No known witnesses.                                                                                                                                                                       |
| 32  | 2021 | 1     | 17  | Stonebraker Road     | Insider trading took place at 23:24. Two people witnessed the event.                                                                                                                                                     |
| 33  | 2021 | 1     | 17  | Chamberlin Street    | Littering took place at 05:46. One person witnessed the incident.                                                                                                                                                        |
| 34  | 2021 | 1     | 17  | Codd Street          | Reckless driving took place at 00:52. One person witnessed the incident.                                                                                                                                                 |
| 35  | 2021 | 1     | 17  | Codd Street          | Money laundering took place at 22:49. Two people witnessed the event.                                                                                                                                                    |
| 36  | 2021 | 1     | 17  | Larsson Lane         | Jaywalking took place at 21:38. One person witnessed the incident.                                                                                                                                                       |
| 37  | 2021 | 1     | 17  | Bowden Boulevard     | Vandalism took place at 04:51. One person witnessed the incident.                                                                                                                                                        |
| 38  | 2021 | 1     | 20  | Lloyd Lane           | Wire fraud took place at 10:31. One person witnessed the incident.                                                                                                                                                       |
| 39  | 2021 | 1     | 20  | Axmark Road          | Burglary took place at 02:22. Two people witnessed the event.                                                                                                                                                            |
| 40  | 2021 | 1     | 21  | Humphrey Lane        | Shoplifting took place at 22:02. Two people witnessed the event.                                                                                                                                                         |
| 41  | 2021 | 1     | 22  | Fifer Street         | Wire fraud took place at 15:42. One person witnessed the incident.                                                                                                                                                       |
| 42  | 2021 | 1     | 23  | Humphrey Lane        | Expired parking meter took place at 09:47. One person witnessed the incident.                                                                                                                                            |
| 43  | 2021 | 1     | 24  | Guimaraes Drive      | Burglary took place at 10:53. Two people witnessed the event.                                                                                                                                                            |
| 44  | 2021 | 1     | 25  | Aydede Lane          | Jaywalking took place at 08:53. Two people witnessed the event.                                                                                                                                                          |
| 45  | 2021 | 1     | 27  | Fifer Street         | Money laundering took place at 19:53. One person witnessed the incident.                                                                                                                                                 |
| 46  | 2021 | 1     | 27  | Axmark Road          | Forgery took place at 05:50. One person witnessed the incident.                                                                                                                                                          |
| 47  | 2021 | 1     | 28  | Widenius Street      | Bank robbery took place at 09:43. One person witnessed the incident.                                                                                                                                                     |
| 48  | 2021 | 1     | 28  | Blumberg Boulevard   | Bank robbery took place at 09:13. No known witnesses.                                                                                                                                                                    |
| 49  | 2021 | 2     | 1   | Zlatkova Street      | Theft took place at 03:25. No known witnesses.                                                                                                                                                                           |
| 50  | 2021 | 2     | 1   | Carreiro Avenue      | Money laundering took place at 15:48. One person witnessed the incident.                                                                                                                                                 |
| 51  | 2021 | 2     | 2   | Hipp Boulevard       | Insider trading took place at 08:46. Two people witnessed the event.                                                                                                                                                     |
| 52  | 2021 | 2     | 4   | Chamberlin Street    | Wire fraud took place at 23:32. One person witnessed the incident.                                                                                                                                                       |
| 53  | 2021 | 2     | 4   | Fifer Street         | Vandalism took place at 07:57. One person witnessed the incident.                                                                                                                                                        |
| 54  | 2021 | 2     | 4   | Lloyd Lane           | Credit card fraud took place at 07:43. One person witnessed the incident.                                                                                                                                                |
| 55  | 2021 | 2     | 4   | Daboin Sanchez Drive | Expired parking meter took place at 02:26. Two people witnessed the event.                                                                                                                                               |
| 56  | 2021 | 2     | 4   | MacWilliam Road      | Money laundering took place at 23:18. No known witnesses.                                                                                                                                                                |
| 57  | 2021 | 2     | 5   | Zlatkova Street      | Jaywalking took place at 21:43. One person witnessed the incident.                                                                                                                                                       |
| 58  | 2021 | 2     | 5   | Axmark Road          | Expired parking meter took place at 03:21. One person witnessed the incident.                                                                                                                                            |
| 59  | 2021 | 2     | 6   | Bowden Boulevard     | Littering took place at 20:58. No known witnesses.                                                                                                                                                                       |
| 60  | 2021 | 2     | 6   | Yamashita Avenue     | Forgery took place at 12:24. One person witnessed the incident.                                                                                                                                                          |
| 61  | 2021 | 2     | 7   | Larsson Lane         | Expired parking meter took place at 06:30. No known witnesses.                                                                                                                                                           |
| 62  | 2021 | 2     | 8   | Hipp Boulevard       | Insider trading took place at 05:43. Two people witnessed the event.                                                                                                                                                     |
| 63  | 2021 | 2     | 8   | Codd Street          | Littering took place at 05:09. One person witnessed the incident.                                                                                                                                                        |
| 64  | 2021 | 2     | 9   | Widenius Street      | Vandalism took place at 18:19. No known witnesses.                                                                                                                                                                       |
| 65  | 2021 | 2     | 11  | Larsson Lane         | Insider trading took place at 13:14. No known witnesses.                                                                                                                                                                 |
| 66  | 2021 | 2     | 12  | Blumberg Boulevard   | Vandalism took place at 18:15. Two people witnessed the event.                                                                                                                                                           |
| 67  | 2021 | 2     | 14  | Axmark Road          | Money laundering took place at 12:35. One person witnessed the incident.                                                                                                                                                 |
| 68  | 2021 | 2     | 15  | Guimaraes Drive      | Bank robbery took place at 08:49. Two people witnessed the event.                                                                                                                                                        |
| 69  | 2021 | 2     | 16  | Blumberg Boulevard   | Bank robbery took place at 21:41. No known witnesses.                                                                                                                                                                    |
| 70  | 2021 | 2     | 17  | Hipp Boulevard       | Shoplifting took place at 10:27. Two people witnessed the event.                                                                                                                                                         |
| 71  | 2021 | 2     | 19  | Stonebraker Road     | Theft took place at 11:54. Two people witnessed the event.                                                                                                                                                               |
| 72  | 2021 | 2     | 19  | Fifer Street         | Jaywalking took place at 01:40. Two people witnessed the event.                                                                                                                                                          |
| 73  | 2021 | 2     | 20  | Codd Street          | Wire fraud took place at 04:55. No known witnesses.                                                                                                                                                                      |
| 74  | 2021 | 2     | 20  | Boyce Avenue         | Wire fraud took place at 18:37. No known witnesses.                                                                                                                                                                      |
| 75  | 2021 | 2     | 22  | Guimaraes Drive      | Credit card fraud took place at 01:32. Two people witnessed the event.                                                                                                                                                   |
| 76  | 2021 | 2     | 22  | Humphrey Lane        | Shoplifting took place at 06:11. Two people witnessed the event.                                                                                                                                                         |
| 77  | 2021 | 2     | 22  | Daboin Sanchez Drive | Credit card fraud took place at 12:26. No known witnesses.                                                                                                                                                               |
| 78  | 2021 | 2     | 25  | Aydede Lane          | Burglary took place at 13:08. Two people witnessed the event.                                                                                                                                                            |
| 79  | 2021 | 2     | 25  | Stonebraker Road     | Bank robbery took place at 04:05. One person witnessed the incident.                                                                                                                                                     |
| 80  | 2021 | 2     | 26  | Humphrey Street      | Theft took place at 03:11. Two people witnessed the event.                                                                                                                                                               |
| 81  | 2021 | 2     | 26  | Daboin Sanchez Drive | Insider trading took place at 14:06. One person witnessed the incident.                                                                                                                                                  |
| 82  | 2021 | 2     | 27  | Carreiro Avenue      | Money laundering took place at 17:54. Two people witnessed the event.                                                                                                                                                    |
| 83  | 2021 | 2     | 28  | Larsson Lane         | Reckless driving took place at 22:02. No known witnesses.                                                                                                                                                                |
| 84  | 2021 | 2     | 28  | Daboin Sanchez Drive | Forgery took place at 21:34. One person witnessed the incident.                                                                                                                                                          |
| 85  | 2021 | 2     | 28  | Carreiro Avenue      | Wire fraud took place at 01:22. No known witnesses.                                                                                                                                                                      |
| 86  | 2021 | 3     | 1   | Guimaraes Drive      | Insider trading took place at 17:19. One person witnessed the incident.                                                                                                                                                  |
| 87  | 2021 | 3     | 2   | Bowden Boulevard     | Littering took place at 07:40. One person witnessed the incident.                                                                                                                                                        |
| 88  | 2021 | 3     | 2   | Hipp Boulevard       | Credit card fraud took place at 22:11. No known witnesses.                                                                                                                                                               |
| 89  | 2021 | 3     | 4   | Widenius Street      | Reckless driving took place at 21:04. No known witnesses.                                                                                                                                                                |
| 90  | 2021 | 3     | 4   | Chamberlin Street    | Wire fraud took place at 11:48. Two people witnessed the event.                                                                                                                                                          |
| 91  | 2021 | 3     | 5   | Bowden Boulevard     | Bank robbery took place at 07:46. One person witnessed the incident.                                                                                                                                                     |
| 92  | 2021 | 3     | 5   | Stonebraker Road     | Forgery took place at 21:10. No known witnesses.                                                                                                                                                                         |
| 93  | 2021 | 3     | 5   | Chartier Road        | Jaywalking took place at 08:07. One person witnessed the incident.                                                                                                                                                       |
| 94  | 2021 | 3     | 5   | Zlatkova Street      | Forgery took place at 06:31. Two people witnessed the event.                                                                                                                                                             |
| 95  | 2021 | 3     | 8   | Aydede Lane          | Burglary took place at 20:14. Two people witnessed the event.                                                                                                                                                            |
| 96  | 2021 | 3     | 8   | Fifer Street         | Burglary took place at 23:15. No known witnesses.                                                                                                                                                                        |
| 97  | 2021 | 3     | 10  | Bowden Boulevard     | Theft took place at 14:39. No known witnesses.                                                                                                                                                                           |
| 98  | 2021 | 3     | 10  | Chamberlin Street    | Littering took place at 16:46. Two people witnessed the event.                                                                                                                                                           |
| 99  | 2021 | 3     | 11  | MacWilliam Road      | Jaywalking took place at 11:51. Two people witnessed the event.                                                                                                                                                          |
| 100 | 2021 | 3     | 11  | Hipp Boulevard       | Vandalism took place at 14:47. One person witnessed the incident.                                                                                                                                                        |
| 101 | 2021 | 3     | 12  | Yamashita Avenue     | Theft took place at 18:55. One person witnessed the incident.                                                                                                                                                            |
| 102 | 2021 | 3     | 13  | Axmark Road          | Theft took place at 09:36. Two people witnessed the event.                                                                                                                                                               |
| 103 | 2021 | 3     | 14  | Stonebraker Road     | Wire fraud took place at 15:08. No known witnesses.                                                                                                                                                                      |
| 104 | 2021 | 3     | 15  | Chamberlin Street    | Bank robbery took place at 12:38. One person witnessed the incident.                                                                                                                                                     |
| 105 | 2021 | 3     | 16  | Zlatkova Street      | Insider trading took place at 23:10. Two people witnessed the event.                                                                                                                                                     |
| 106 | 2021 | 3     | 16  | Carvalho Road        | Jaywalking took place at 20:07. Two people witnessed the event.                                                                                                                                                          |
| 107 | 2021 | 3     | 16  | Lloyd Lane           | Jaywalking took place at 01:49. Two people witnessed the event.                                                                                                                                                          |
| 108 | 2021 | 3     | 17  | Codd Street          | Bank robbery took place at 22:39. One person witnessed the incident.                                                                                                                                                     |
| 109 | 2021 | 3     | 18  | Hipp Boulevard       | Jaywalking took place at 09:21. Two people witnessed the event.                                                                                                                                                          |
| 110 | 2021 | 3     | 18  | Widenius Street      | Littering took place at 02:17. No known witnesses.                                                                                                                                                                       |
| 111 | 2021 | 3     | 20  | MacWilliam Road      | Credit card fraud took place at 23:37. One person witnessed the incident.                                                                                                                                                |
| 112 | 2021 | 3     | 20  | Carreiro Avenue      | Vandalism took place at 08:39. No known witnesses.                                                                                                                                                                       |
| 113 | 2021 | 3     | 20  | Humphrey Street      | Credit card fraud took place at 08:41. One person witnessed the incident.                                                                                                                                                |
| 114 | 2021 | 3     | 21  | Humphrey Lane        | Theft took place at 12:14. No known witnesses.                                                                                                                                                                           |
| 115 | 2021 | 3     | 22  | Guimaraes Drive      | Expired parking meter took place at 22:17. No known witnesses.                                                                                                                                                           |
| 116 | 2021 | 3     | 23  | Chartier Road        | Money laundering took place at 13:05. No known witnesses.                                                                                                                                                                |
| 117 | 2021 | 3     | 23  | Stonebraker Road     | Littering took place at 05:09. One person witnessed the incident.                                                                                                                                                        |
| 118 | 2021 | 3     | 24  | Larsson Lane         | Burglary took place at 02:13. No known witnesses.                                                                                                                                                                        |
| 119 | 2021 | 3     | 24  | Blumberg Boulevard   | Jaywalking took place at 13:18. No known witnesses.                                                                                                                                                                      |
| 120 | 2021 | 3     | 25  | Chamberlin Street    | Burglary took place at 07:21. One person witnessed the incident.                                                                                                                                                         |
| 121 | 2021 | 3     | 25  | Carreiro Avenue      | Theft took place at 23:17. No known witnesses.                                                                                                                                                                           |
| 122 | 2021 | 3     | 27  | Yamashita Avenue     | Burglary took place at 09:25. No known witnesses.                                                                                                                                                                        |
| 123 | 2021 | 3     | 28  | Widenius Street      | Burglary took place at 09:19. No known witnesses.                                                                                                                                                                        |
| 124 | 2021 | 4     | 1   | Boyce Avenue         | Theft took place at 01:06. No known witnesses.                                                                                                                                                                           |
| 125 | 2021 | 4     | 2   | Yamashita Avenue     | Credit card fraud took place at 08:24. One person witnessed the incident.                                                                                                                                                |
| 126 | 2021 | 4     | 3   | Chartier Road        | Jaywalking took place at 03:54. No known witnesses.                                                                                                                                                                      |
| 127 | 2021 | 4     | 3   | Chamberlin Street    | Money laundering took place at 10:24. Two people witnessed the event.                                                                                                                                                    |
| 128 | 2021 | 4     | 4   | Humphrey Street      | Expired parking meter took place at 03:17. Two people witnessed the event.                                                                                                                                               |
| 129 | 2021 | 4     | 4   | Codd Street          | Vandalism took place at 21:22. One person witnessed the incident.                                                                                                                                                        |
| 130 | 2021 | 4     | 6   | Guimaraes Drive      | Vandalism took place at 11:49. No known witnesses.                                                                                                                                                                       |
| 131 | 2021 | 4     | 12  | Larsson Lane         | Burglary took place at 08:27. Two people witnessed the event.                                                                                                                                                            |
| 132 | 2021 | 4     | 12  | Stonebraker Road     | Credit card fraud took place at 18:03. Two people witnessed the event.                                                                                                                                                   |
| 133 | 2021 | 4     | 13  | Hipp Boulevard       | Insider trading took place at 01:41. One person witnessed the incident.                                                                                                                                                  |
| 134 | 2021 | 4     | 13  | Aydede Lane          | Insider trading took place at 04:28. Two people witnessed the event.                                                                                                                                                     |
| 135 | 2021 | 4     | 14  | Codd Street          | Money laundering took place at 02:27. Two people witnessed the event.                                                                                                                                                    |
| 136 | 2021 | 4     | 14  | Guimaraes Drive      | Littering took place at 21:47. Two people witnessed the event.                                                                                                                                                           |
| 137 | 2021 | 4     | 17  | Axmark Road          | Insider trading took place at 12:58. No known witnesses.                                                                                                                                                                 |
| 138 | 2021 | 4     | 19  | Daboin Sanchez Drive | Expired parking meter took place at 13:25. One person witnessed the incident.                                                                                                                                            |
| 139 | 2021 | 4     | 20  | Lloyd Lane           | Expired parking meter took place at 11:05. One person witnessed the incident.                                                                                                                                            |
| 140 | 2021 | 4     | 20  | Widenius Street      | Burglary took place at 10:14. No known witnesses.                                                                                                                                                                        |
| 141 | 2021 | 4     | 21  | Blumberg Boulevard   | Forgery took place at 04:54. One person witnessed the incident.                                                                                                                                                          |
| 142 | 2021 | 4     | 22  | Hipp Boulevard       | Reckless driving took place at 15:51. One person witnessed the incident.                                                                                                                                                 |
| 143 | 2021 | 4     | 24  | Fifer Street         | Bank robbery took place at 07:40. One person witnessed the incident.                                                                                                                                                     |
| 144 | 2021 | 4     | 24  | Guimaraes Drive      | Bank robbery took place at 00:13. Two people witnessed the event.                                                                                                                                                        |
| 145 | 2021 | 4     | 26  | Carvalho Road        | Reckless driving took place at 15:56. Two people witnessed the event.                                                                                                                                                    |
| 146 | 2021 | 4     | 27  | Daboin Sanchez Drive | Bank robbery took place at 17:43. One person witnessed the incident.                                                                                                                                                     |
| 147 | 2021 | 4     | 27  | Codd Street          | Insider trading took place at 23:06. No known witnesses.                                                                                                                                                                 |
| 148 | 2021 | 4     | 27  | Chartier Road        | Shoplifting took place at 16:40. No known witnesses.                                                                                                                                                                     |
| 149 | 2021 | 4     | 28  | Zlatkova Street      | Forgery took place at 08:13. One person witnessed the incident.                                                                                                                                                          |
| 150 | 2021 | 5     | 1   | Fifer Street         | Jaywalking took place at 23:21. One person witnessed the incident.                                                                                                                                                       |
| 151 | 2021 | 5     | 1   | Yamashita Avenue     | Reckless driving took place at 03:03. No known witnesses.                                                                                                                                                                |
| 152 | 2021 | 5     | 1   | Stonebraker Road     | Shoplifting took place at 04:38. Two people witnessed the event.                                                                                                                                                         |
| 153 | 2021 | 5     | 2   | Hipp Boulevard       | Expired parking meter took place at 06:13. No known witnesses.                                                                                                                                                           |
| 154 | 2021 | 5     | 3   | Carreiro Avenue      | Expired parking meter took place at 01:42. No known witnesses.                                                                                                                                                           |
| 155 | 2021 | 5     | 3   | Carvalho Road        | Theft took place at 06:38. Two people witnessed the event.                                                                                                                                                               |
| 156 | 2021 | 5     | 5   | Hipp Boulevard       | Reckless driving took place at 20:00. No known witnesses.                                                                                                                                                                |
| 157 | 2021 | 5     | 6   | Chamberlin Street    | Jaywalking took place at 06:52. Two people witnessed the event.                                                                                                                                                          |
| 158 | 2021 | 5     | 7   | Axmark Road          | Credit card fraud took place at 05:46. No known witnesses.                                                                                                                                                               |
| 159 | 2021 | 5     | 8   | Guimaraes Drive      | Vandalism took place at 13:08. No known witnesses.                                                                                                                                                                       |
| 160 | 2021 | 5     | 9   | Guimaraes Drive      | Littering took place at 15:40. No known witnesses.                                                                                                                                                                       |
| 161 | 2021 | 5     | 9   | Carreiro Avenue      | Expired parking meter took place at 08:03. No known witnesses.                                                                                                                                                           |
| 162 | 2021 | 5     | 10  | Chamberlin Street    | Vandalism took place at 12:37. One person witnessed the incident.                                                                                                                                                        |
| 163 | 2021 | 5     | 10  | Widenius Street      | Money laundering took place at 18:24. No known witnesses.                                                                                                                                                                |
| 164 | 2021 | 5     | 11  | Stonebraker Road     | Reckless driving took place at 05:43. One person witnessed the incident.                                                                                                                                                 |
| 165 | 2021 | 5     | 12  | Blumberg Boulevard   | Shoplifting took place at 04:15. No known witnesses.                                                                                                                                                                     |
| 166 | 2021 | 5     | 13  | Carvalho Road        | Reckless driving took place at 11:29. One person witnessed the incident.                                                                                                                                                 |
| 167 | 2021 | 5     | 13  | Lloyd Lane           | Reckless driving took place at 07:46. Two people witnessed the event.                                                                                                                                                    |
| 168 | 2021 | 5     | 14  | Codd Street          | Credit card fraud took place at 21:14. Two people witnessed the event.                                                                                                                                                   |
| 169 | 2021 | 5     | 14  | Stonebraker Road     | Jaywalking took place at 21:07. No known witnesses.                                                                                                                                                                      |
| 170 | 2021 | 5     | 16  | Codd Street          | Forgery took place at 15:22. One person witnessed the incident.                                                                                                                                                          |
| 171 | 2021 | 5     | 16  | Aydede Lane          | Expired parking meter took place at 12:04. Two people witnessed the event.                                                                                                                                               |
| 172 | 2021 | 5     | 17  | Stonebraker Road     | Insider trading took place at 01:40. No known witnesses.                                                                                                                                                                 |
| 173 | 2021 | 5     | 17  | Boyce Avenue         | Jaywalking took place at 08:03. Two people witnessed the event.                                                                                                                                                          |
| 174 | 2021 | 5     | 17  | Boyce Avenue         | Vandalism took place at 15:17. Two people witnessed the event.                                                                                                                                                           |
| 175 | 2021 | 5     | 19  | MacWilliam Road      | Wire fraud took place at 13:56. One person witnessed the incident.                                                                                                                                                       |
| 176 | 2021 | 5     | 20  | Chartier Road        | Credit card fraud took place at 07:59. Two people witnessed the event.                                                                                                                                                   |
| 177 | 2021 | 5     | 20  | Lloyd Lane           | Insider trading took place at 06:41. One person witnessed the incident.                                                                                                                                                  |
| 178 | 2021 | 5     | 21  | Humphrey Lane        | Shoplifting took place at 17:39. Two people witnessed the event.                                                                                                                                                         |
| 179 | 2021 | 5     | 22  | Guimaraes Drive      | Jaywalking took place at 09:14. One person witnessed the incident.                                                                                                                                                       |
| 180 | 2021 | 5     | 22  | Chartier Road        | Burglary took place at 01:54. Two people witnessed the event.                                                                                                                                                            |
| 181 | 2021 | 5     | 22  | Humphrey Lane        | Bank robbery took place at 18:53. Two people witnessed the event.                                                                                                                                                        |
| 182 | 2021 | 5     | 23  | Hipp Boulevard       | Theft took place at 10:46. One person witnessed the incident.                                                                                                                                                            |
| 183 | 2021 | 5     | 24  | Boyce Avenue         | Littering took place at 11:32. One person witnessed the incident.                                                                                                                                                        |
| 184 | 2021 | 5     | 24  | Larsson Lane         | Burglary took place at 19:01. No known witnesses.                                                                                                                                                                        |
| 185 | 2021 | 5     | 27  | MacWilliam Road      | Shoplifting took place at 06:55. Two people witnessed the event.                                                                                                                                                         |
| 186 | 2021 | 5     | 27  | Chamberlin Street    | Insider trading took place at 14:36. One person witnessed the incident.                                                                                                                                                  |
| 187 | 2021 | 5     | 28  | MacWilliam Road      | Theft took place at 23:50. No known witnesses.                                                                                                                                                                           |
| 188 | 2021 | 5     | 28  | Carvalho Road        | Theft took place at 22:40. One person witnessed the incident.                                                                                                                                                            |
| 189 | 2021 | 5     | 28  | Widenius Street      | Theft took place at 10:02. No known witnesses.                                                                                                                                                                           |
| 190 | 2021 | 6     | 1   | Guimaraes Drive      | Littering took place at 13:27. Two people witnessed the event.                                                                                                                                                           |
| 191 | 2021 | 6     | 1   | Yamashita Avenue     | Wire fraud took place at 17:10. One person witnessed the incident.                                                                                                                                                       |
| 192 | 2021 | 6     | 1   | Aydede Lane          | Theft took place at 15:04. One person witnessed the incident.                                                                                                                                                            |
| 193 | 2021 | 6     | 1   | Axmark Road          | Vandalism took place at 20:09. No known witnesses.                                                                                                                                                                       |
| 194 | 2021 | 6     | 1   | Zlatkova Street      | Money laundering took place at 06:41. One person witnessed the incident.                                                                                                                                                 |
| 195 | 2021 | 6     | 2   | Aydede Lane          | Reckless driving took place at 14:28. No known witnesses.                                                                                                                                                                |
| 196 | 2021 | 6     | 4   | Daboin Sanchez Drive | Burglary took place at 20:26. No known witnesses.                                                                                                                                                                        |
| 197 | 2021 | 6     | 5   | Carvalho Road        | Reckless driving took place at 07:33. One person witnessed the incident.                                                                                                                                                 |
| 198 | 2021 | 6     | 5   | Zlatkova Street      | Insider trading took place at 02:14. Two people witnessed the event.                                                                                                                                                     |
| 199 | 2021 | 6     | 5   | MacWilliam Road      | Littering took place at 05:40. No known witnesses.                                                                                                                                                                       |
| 200 | 2021 | 6     | 5   | Larsson Lane         | Reckless driving took place at 23:18. No known witnesses.                                                                                                                                                                |
| 201 | 2021 | 6     | 6   | Yamashita Avenue     | Burglary took place at 01:31. No known witnesses.                                                                                                                                                                        |
| 202 | 2021 | 6     | 8   | Widenius Street      | Forgery took place at 07:27. No known witnesses.                                                                                                                                                                         |
| 203 | 2021 | 6     | 8   | MacWilliam Road      | Insider trading took place at 00:18. Two people witnessed the event.                                                                                                                                                     |
| 204 | 2021 | 6     | 8   | Chamberlin Street    | Jaywalking took place at 01:39. Two people witnessed the event.                                                                                                                                                          |
| 205 | 2021 | 6     | 9   | Codd Street          | Vandalism took place at 08:25. One person witnessed the incident.                                                                                                                                                        |
| 206 | 2021 | 6     | 11  | MacWilliam Road      | Shoplifting took place at 01:48. One person witnessed the incident.                                                                                                                                                      |
| 207 | 2021 | 6     | 11  | MacWilliam Road      | Littering took place at 18:16. Two people witnessed the event.                                                                                                                                                           |
| 208 | 2021 | 6     | 12  | Yamashita Avenue     | Reckless driving took place at 18:32. No known witnesses.                                                                                                                                                                |
| 209 | 2021 | 6     | 12  | Blumberg Boulevard   | Credit card fraud took place at 04:31. No known witnesses.                                                                                                                                                               |
| 210 | 2021 | 6     | 13  | Blumberg Boulevard   | Reckless driving took place at 09:34. One person witnessed the incident.                                                                                                                                                 |
| 211 | 2021 | 6     | 13  | Yamashita Avenue     | Reckless driving took place at 09:00. No known witnesses.                                                                                                                                                                |
| 212 | 2021 | 6     | 14  | Larsson Lane         | Credit card fraud took place at 14:17. Two people witnessed the event.                                                                                                                                                   |
| 213 | 2021 | 6     | 14  | Carreiro Avenue      | Shoplifting took place at 17:05. Two people witnessed the event.                                                                                                                                                         |
| 214 | 2021 | 6     | 16  | Hipp Boulevard       | Littering took place at 18:33. Two people witnessed the event.                                                                                                                                                           |
| 215 | 2021 | 6     | 16  | Bowden Boulevard     | Jaywalking took place at 14:08. Two people witnessed the event.                                                                                                                                                          |
| 216 | 2021 | 6     | 16  | Blumberg Boulevard   | Credit card fraud took place at 16:09. Two people witnessed the event.                                                                                                                                                   |
| 217 | 2021 | 6     | 18  | Larsson Lane         | Shoplifting took place at 03:02. One person witnessed the incident.                                                                                                                                                      |
| 218 | 2021 | 6     | 18  | Aydede Lane          | Expired parking meter took place at 14:03. No known witnesses.                                                                                                                                                           |
| 219 | 2021 | 6     | 19  | Fifer Street         | Wire fraud took place at 02:57. No known witnesses.                                                                                                                                                                      |
| 220 | 2021 | 6     | 19  | Fifer Street         | Forgery took place at 09:37. No known witnesses.                                                                                                                                                                         |
| 221 | 2021 | 6     | 20  | Boyce Avenue         | Vandalism took place at 22:08. Two people witnessed the event.                                                                                                                                                           |
| 222 | 2021 | 6     | 20  | Widenius Street      | Shoplifting took place at 21:01. Two people witnessed the event.                                                                                                                                                         |
| 223 | 2021 | 6     | 20  | Bowden Boulevard     | Credit card fraud took place at 05:16. No known witnesses.                                                                                                                                                               |
| 224 | 2021 | 6     | 20  | Zlatkova Street      | Burglary took place at 09:09. No known witnesses.                                                                                                                                                                        |
| 225 | 2021 | 6     | 20  | Chartier Road        | Bank robbery took place at 23:14. One person witnessed the incident.                                                                                                                                                     |
| 226 | 2021 | 6     | 20  | Widenius Street      | Expired parking meter took place at 14:06. No known witnesses.                                                                                                                                                           |
| 227 | 2021 | 6     | 21  | Codd Street          | Money laundering took place at 00:25. No known witnesses.                                                                                                                                                                |
| 228 | 2021 | 6     | 22  | Lloyd Lane           | Forgery took place at 08:14. No known witnesses.                                                                                                                                                                         |
| 229 | 2021 | 6     | 22  | Boyce Avenue         | Bank robbery took place at 01:09. One person witnessed the incident.                                                                                                                                                     |
| 230 | 2021 | 6     | 22  | Boyce Avenue         | Wire fraud took place at 18:41. Two people witnessed the event.                                                                                                                                                          |
| 231 | 2021 | 6     | 22  | Bowden Boulevard     | Burglary took place at 23:48. No known witnesses.                                                                                                                                                                        |
| 232 | 2021 | 6     | 23  | Boyce Avenue         | Littering took place at 17:48. Two people witnessed the event.                                                                                                                                                           |
| 233 | 2021 | 6     | 24  | Codd Street          | Reckless driving took place at 20:55. Two people witnessed the event.                                                                                                                                                    |
| 234 | 2021 | 6     | 25  | Aydede Lane          | Burglary took place at 20:25. No known witnesses.                                                                                                                                                                        |
| 235 | 2021 | 6     | 25  | Humphrey Lane        | Shoplifting took place at 19:17. No known witnesses.                                                                                                                                                                     |
| 236 | 2021 | 6     | 26  | Boyce Avenue         | Reckless driving took place at 01:45. Two people witnessed the event.                                                                                                                                                    |
| 237 | 2021 | 6     | 26  | Blumberg Boulevard   | Jaywalking took place at 17:02. One person witnessed the incident.                                                                                                                                                       |
| 238 | 2021 | 6     | 27  | Carreiro Avenue      | Vandalism took place at 06:37. No known witnesses.                                                                                                                                                                       |
| 239 | 2021 | 6     | 28  | MacWilliam Road      | Vandalism took place at 09:45. One person witnessed the incident.                                                                                                                                                        |
| 240 | 2021 | 6     | 28  | Larsson Lane         | Expired parking meter took place at 13:44. One person witnessed the incident.                                                                                                                                            |
| 241 | 2021 | 7     | 1   | Chamberlin Street    | Vandalism took place at 18:46. Two people witnessed the event.                                                                                                                                                           |
| 242 | 2021 | 7     | 1   | Bowden Boulevard     | Insider trading took place at 15:44. One person witnessed the incident.                                                                                                                                                  |
| 243 | 2021 | 7     | 1   | Yamashita Avenue     | Wire fraud took place at 07:41. Two people witnessed the event.                                                                                                                                                          |
| 244 | 2021 | 7     | 1   | Blumberg Boulevard   | Shoplifting took place at 12:04. Two people witnessed the event.                                                                                                                                                         |
| 245 | 2021 | 7     | 2   | Daboin Sanchez Drive | Bank robbery took place at 04:36. Two people witnessed the event.                                                                                                                                                        |
| 246 | 2021 | 7     | 2   | Lloyd Lane           | Credit card fraud took place at 10:54. Two people witnessed the event.                                                                                                                                                   |
| 247 | 2021 | 7     | 3   | Zlatkova Street      | Credit card fraud took place at 02:10. Two people witnessed the event.                                                                                                                                                   |
| 248 | 2021 | 7     | 3   | Chamberlin Street    | Bank robbery took place at 15:10. No known witnesses.                                                                                                                                                                    |
| 249 | 2021 | 7     | 4   | Codd Street          | Expired parking meter took place at 11:46. No known witnesses.                                                                                                                                                           |
| 250 | 2021 | 7     | 4   | Hipp Boulevard       | Theft took place at 17:00. Two people witnessed the event.                                                                                                                                                               |
| 251 | 2021 | 7     | 4   | Larsson Lane         | Jaywalking took place at 18:14. Two people witnessed the event.                                                                                                                                                          |
| 252 | 2021 | 7     | 4   | Chartier Road        | Forgery took place at 19:46. No known witnesses.                                                                                                                                                                         |
| 253 | 2021 | 7     | 5   | Carvalho Road        | Bank robbery took place at 01:34. No known witnesses.                                                                                                                                                                    |
| 254 | 2021 | 7     | 6   | Humphrey Street      | Shoplifting took place at 04:45. Two people witnessed the event.                                                                                                                                                         |
| 255 | 2021 | 7     | 6   | Chartier Road        | Bank robbery took place at 06:30. Two people witnessed the event.                                                                                                                                                        |
| 256 | 2021 | 7     | 8   | Lloyd Lane           | Vandalism took place at 14:48. No known witnesses.                                                                                                                                                                       |
| 257 | 2021 | 7     | 8   | Widenius Street      | Insider trading took place at 22:18. No known witnesses.                                                                                                                                                                 |
| 258 | 2021 | 7     | 8   | Bowden Boulevard     | Jaywalking took place at 10:35. One person witnessed the incident.                                                                                                                                                       |
| 259 | 2021 | 7     | 8   | Bowden Boulevard     | Theft took place at 01:44. One person witnessed the incident.                                                                                                                                                            |
| 260 | 2021 | 7     | 10  | Carreiro Avenue      | Vandalism took place at 09:20. Two people witnessed the event.                                                                                                                                                           |
| 261 | 2021 | 7     | 10  | Axmark Road          | Insider trading took place at 01:07. One person witnessed the incident.                                                                                                                                                  |
| 262 | 2021 | 7     | 10  | Zlatkova Street      | Expired parking meter took place at 10:04. No known witnesses.                                                                                                                                                           |
| 263 | 2021 | 7     | 10  | Carreiro Avenue      | Reckless driving took place at 20:43. Two people witnessed the event.                                                                                                                                                    |
| 264 | 2021 | 7     | 10  | Boyce Avenue         | Wire fraud took place at 14:36. Two people witnessed the event.                                                                                                                                                          |
| 265 | 2021 | 7     | 12  | Daboin Sanchez Drive | Littering took place at 08:31. No known witnesses.                                                                                                                                                                       |
| 266 | 2021 | 7     | 13  | Daboin Sanchez Drive | Jaywalking took place at 13:33. No known witnesses.                                                                                                                                                                      |
| 267 | 2021 | 7     | 13  | Axmark Road          | Jaywalking took place at 07:51. Two people witnessed the event.                                                                                                                                                          |
| 268 | 2021 | 7     | 14  | MacWilliam Road      | Wire fraud took place at 10:20. No known witnesses.                                                                                                                                                                      |
| 269 | 2021 | 7     | 15  | Yamashita Avenue     | Burglary took place at 07:18. One person witnessed the incident.                                                                                                                                                         |
| 270 | 2021 | 7     | 15  | Fifer Street         | Jaywalking took place at 07:03. One person witnessed the incident.                                                                                                                                                       |
| 271 | 2021 | 7     | 16  | Lloyd Lane           | Reckless driving took place at 20:31. One person witnessed the incident.                                                                                                                                                 |
| 272 | 2021 | 7     | 16  | Larsson Lane         | Credit card fraud took place at 10:46. Two people witnessed the event.                                                                                                                                                   |
| 273 | 2021 | 7     | 17  | Zlatkova Street      | Burglary took place at 11:43. Two people witnessed the event.                                                                                                                                                            |
| 274 | 2021 | 7     | 17  | Aydede Lane          | Expired parking meter took place at 15:55. No known witnesses.                                                                                                                                                           |
| 275 | 2021 | 7     | 17  | Stonebraker Road     | Wire fraud took place at 17:16. No known witnesses.                                                                                                                                                                      |
| 276 | 2021 | 7     | 18  | Lloyd Lane           | Vandalism took place at 21:09. No known witnesses.                                                                                                                                                                       |
| 277 | 2021 | 7     | 18  | MacWilliam Road      | Bank robbery took place at 22:33. Two people witnessed the event.                                                                                                                                                        |
| 278 | 2021 | 7     | 19  | Bowden Boulevard     | Theft took place at 21:21. One person witnessed the incident.                                                                                                                                                            |
| 279 | 2021 | 7     | 19  | Yamashita Avenue     | Expired parking meter took place at 19:39. Two people witnessed the event.                                                                                                                                               |
| 280 | 2021 | 7     | 21  | Daboin Sanchez Drive | Burglary took place at 21:54. One person witnessed the incident.                                                                                                                                                         |
| 281 | 2021 | 7     | 21  | Carreiro Avenue      | Expired parking meter took place at 14:59. One person witnessed the incident.                                                                                                                                            |
| 282 | 2021 | 7     | 22  | Bowden Boulevard     | Bank robbery took place at 07:16. One person witnessed the incident.                                                                                                                                                     |
| 283 | 2021 | 7     | 22  | Daboin Sanchez Drive | Insider trading took place at 18:58. No known witnesses.                                                                                                                                                                 |
| 284 | 2021 | 7     | 23  | Daboin Sanchez Drive | Burglary took place at 12:03. No known witnesses.                                                                                                                                                                        |
| 285 | 2021 | 7     | 23  | Guimaraes Drive      | Money laundering took place at 10:30. One person witnessed the incident.                                                                                                                                                 |
| 286 | 2021 | 7     | 25  | Axmark Road          | Expired parking meter took place at 06:24. Two people witnessed the event.                                                                                                                                               |
| 287 | 2021 | 7     | 25  | Carvalho Road        | Credit card fraud took place at 18:10. No known witnesses.                                                                                                                                                               |
| 288 | 2021 | 7     | 26  | Chartier Road        | Jaywalking took place at 05:27. One person witnessed the incident.                                                                                                                                                       |
| 289 | 2021 | 7     | 26  | Chartier Road        | Expired parking meter took place at 10:36. One person witnessed the incident.                                                                                                                                            |
| 290 | 2021 | 7     | 27  | Axmark Road          | Money laundering took place at 17:47. Two people witnessed the event.                                                                                                                                                    |
| 291 | 2021 | 7     | 27  | Stonebraker Road     | Wire fraud took place at 23:58. Two people witnessed the event.                                                                                                                                                          |
| 292 | 2021 | 7     | 27  | Fifer Street         | Shoplifting took place at 05:51. No known witnesses.                                                                                                                                                                     |
| 293 | 2021 | 7     | 28  | Axmark Road          | Vandalism took place at 12:04. No known witnesses.                                                                                                                                                                       |
| 294 | 2021 | 7     | 28  | Boyce Avenue         | Shoplifting took place at 03:01. Two people witnessed the event.                                                                                                                                                         |
| 295 | 2021 | 7     | 28  | Humphrey Street      | Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery. |
| 296 | 2021 | 7     | 28  | Widenius Street      | Money laundering took place at 20:30. No known witnesses.                                                                                                                                                                |
| 297 | 2021 | 7     | 28  | Humphrey Street      | Littering took place at 16:36. No known witnesses.                                                                                                                                                                       |
| 298 | 2021 | 7     | 29  | Lloyd Lane           | Insider trading took place at 06:35. One person witnessed the incident.                                                                                                                                                  |
| 299 | 2021 | 7     | 30  | Humphrey Street      | Littering took place at 17:49. Two people witnessed the event.                                                                                                                                                           |
| 300 | 2021 | 7     | 31  | Zlatkova Street      | Bank robbery took place at 12:24. No known witnesses.                                                                                                                                                                    |
| 301 | 2021 | 8     | 1   | Carvalho Road        | Vandalism took place at 13:52. One person witnessed the incident.                                                                                                                                                        |
+-----+------+-------+-----+----------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+