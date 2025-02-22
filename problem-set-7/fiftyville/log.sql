-- Keep a log of any SQL queries you execute as you solve the mystery.

-- Date of crime 28/07/2024, place is Humphrey Street

----- checking the crime scene reports on the day the theft ook place
select
    id,
    description
from
    crime_scene_reports
where
    month = '07'
    and day = '28'
    and year = '2024'
    and street = 'Humphrey Street';
    -- id 295, theft at 10:15 am, Humphrey Street Bakery, three witnesses, transcripts mention the bakery

----- checking the interviews
select
    id,
    name,
    transcript
from
    interviews
where
    month = '07'
    and day = '28'
    and year = '2024'
    and transcript like '%bakery%';
    /*
        161 Ruth : theift got into a car, security footage of bakery parking lot
        162 Eugene : theif looked familiar, saw withdrawing money at ATM on Leggett Street
        163 Raymond : thief called & talked for approax less than a min, heared planning to take earliest flight from fiftyville next day of theft, asked someone to purchase flight ticket
    */

----- Let's dive deep with Ruth's transcript
select
    id,
    license_plate,
    activity,
    hour,
    minute
from
    bakery_security_logs
where
    month = '07'
    and day = '28'
    and year = '2024'
    and activity = 'exit'
    and hour between '10' and '11'
    and minute between '15' and '20'
order by
    minute asc;
    -- 5 cars count, ids & license plates are
    /*
        260 - 5P2BI95
        261 - 94KL13X
        262 - 6P58WS2
        263 - 4328GD8
        264 - G412CB7
    */
    -- let's check who these cars belong to
select
    id,
    name,
    license_plate
from
    people
where
    license_plate in(select
                            license_plate
                        from
                            bakery_security_logs
                        where
                            month = '07'
                            and day = '28'
                            and year = '2024'
                            and activity = 'exit'
                            and hour between '10' and '11'
                            and minute between '15' and '20');
                            -- list of name
                            /*
                                221103  - Vanessa
                                243696 - Barry
                                398010 - Sofia
                                467400 - Luca
                                686048 - Bruce
                            */
-----x-----x-----x-----x-----x-----x-----x-----x-----x-----x-----x-----
----- Let's dive deep with Eugene's transcript
-- atm_transactions
select
    id,
    account_number,
    amount
from
    atm_transactions
where
    month = '07'
    and day = '28'
    and year = '2024'
    and atm_location = 'Leggett Street'
    and transaction_type = 'withdraw';
    -- list of id and account_number
    /*
        246 - 28500762
        264 - 28296815
        266 - 76054385
        267 - 49610011
        269 - 16153065
        288 - 25506511
        313 - 81061156
        336 - 26013199
    */
-- let's see who the account holders are
-- bank_accounts
select
    account_number,
    person_id,
    creation_year
from
    bank_accounts
where
    account_number in
                    (select
                        account_number
                    from
                        atm_transactions
                    where
                        month = '07'
                        and day = '28'
                        and year = '2024'
                        and atm_location = 'Leggett Street'
                        and transaction_type = 'withdraw');
    -- list of account_number, person_id
    /*
        49610011 - 686048
        26013199 - 514354
        16153065 - 458378
        28296815 - 395717
        25506511 - 396669
        28500762 - 467400
        76054385 - 449774
        81061156 - 438727
    */
-- can we check who the account number belongs to?
select
    id,
    name
from
    people
where
    id in(
            select
                person_id
            from
                bank_accounts
            where
                account_number in
                                (select
                                    account_number
                                from
                                    atm_transactions
                                where
                                    month = '07'
                                    and day = '28'
                                    and year = '2024'
                                    and atm_location = 'Leggett Street'
                                    and transaction_type = 'withdraw')
    );
    -- list of account holder names
    /*
        Kenny,
        Iman,
        Benista,
        Taylor,
        Brooke,
        Luca,
        Diana,
        Brunce
    */
-----x-----x-----x-----x-----x-----x-----x-----x-----x-----x-----x-----
----- Let's dive deep with Raymond's transcript
select
    id,
    caller,
    receiver,
    duration
from
    phone_calls
where
    year = '2024'
    and month = '07'
    and day = '28'
    and duration <= 70;

-- let's see the name of caller, receiver along with their number
select
    b.id,
    a.name as caller_name,
    b.caller as caller_no,
    c.name as receiver_name,
    b.receiver as receiver_no,
    b.duration as in_secs
from
    people a,
    phone_calls b,
    people c
where
    b.caller = a.phone_number
    and b.receiver = c.phone_number
    and b.year = '2024'
    and b.month = '07'
    and b.day = '28'
    and b.duration <= '70';
    -- who made calls to whom
    /*
        Sofia to Jack
        Kelsey to Larry
        Bruce to Robin
        Kathryn to Luca
        Jason to Amy
        Kelsey to Melissa
        Taylor to James
        Diana to Philip
        Harold to Daniel
        Carina to Jacqueline
        Peter to Ethan
        Kenny to Doris
        Benista to Anna
    */
-- heared planning to take earliest flight from fiftyville next day of theft
-- flights on 29/07/2024 from Fiftyville
select
    id,
    abbreviation,
    full_name,
    city
from
    airports
where
    city = 'Fiftyville'; -- id is 8
    -- getting the full flight details, order by earliest
    select
        a.id,
        a.origin_airport_id,
        c.full_name as origin_airport_name,
        c.city,
        a.destination_airport_id,
        b.full_name as destination_airport_name,
        b.city,
        a.hour,
        a.minute
    from
        flights a,
        airports b,
        airports c
    where
        a.destination_airport_id = b.id
        and a.origin_airport_id = c.id
        and a.origin_airport_id = '8'
        and a.year = '2024'
        and a.month = '07'
        and a.day = '29'
    order by
        a.hour asc;
        -- List of flights from Fiftyville to (order from earliest)
        /*
            New York City,
            Chicago,
            San Francisco,
            Tokyo
            Boston
        */
-- since flight to New York City was the earliest, let's see the passenger list
-- flight id from Fiftyville to New York City is 36

select
    a.flight_id,
    a.passport_number,
    b.name as passenger_name,
    a.seat
from
    passengers a,
    people b
where
    a.passport_number = b.passport_number
    and a.flight_id = '36'
order by
    b.name;
    -- list of passenger
    /*
        Bruce,
        Doris,
        Edward,
        Kelsey,
        Kenny,
        Luca,
        Sofia,
        Taylor
    */
-----x-----x-----x-----x-----x-----x-----x-----x-----x-----x-----x-----
