select * from crime_scene_report;
-- Like Clause (%,_)

select * from crime_scene_report
where date like '%20180115%' and city = "SQL City" and type = "murder";

-- '20180115', 'murder', 'Security footage shows that there were 2 witnesses. The first witness 
-- lives at the last house on `Northwestern Dr`. The second witness, named Annabel,
--  lives somewhere on `Franklin Ave`.', 'SQL City'

select * from person where address_street_name like "%Northwestern Dr%"
order by address_number desc;

select * from person where address_street_name = "Franklin Ave"
and  name like  "%Annabel%";

# '14887', 'Morty Schapiro', '118009', '4919', 'Northwestern Dr', '111564949'
#'16371', 'Annabel Miller', '490173', '103', 'Franklin Ave', '318771143'

 select * from interview where person_id = "14887" or person_id = "16371";
 
 #Morty '14887', 'I heard a gunshot and then saw a man run out. He had a `Get Fit Now Gym` bag. 
 #The membership number on the bag started with `48Z`. Only gold members have those bags. 
 #The man got into a car with a plate that included `H42W`.'
 
 #Annabel '16371', 'I saw the murder happen, and I recognized the killer from my gym when 
 #I was working out last week on January the 9th.'
 
select * from get_fit_now_member where id like "%48Z%";
select * from drivers_license where plate_number like "%H42W%";
 select * from get_fit_now_check_in where check_in_date like  "%0109%" and membership_id = 
 "48Z7A" or membership_id = "48Z55";
 
# '28819', 'Joe Germuska', '173289', '111', 'Fisk Rd', '138909730'
#'67318', 'Jeremy Bowers', '423327', '530', 'Washington Pl, Apt 3A', '871539279'


select * from person where name = "Jeremy Bowers" or name = "Joe Germuska";
select * from interview where person_id = "28819" or person_id = "67318";

#'Jeremy Bowers' '67318', 'I was hired by a woman with a lot of money. 
#I don\'t know her name but I know she\'s around 5\'5` (65`) or 5\'7` (67`). 
#She has red hair and she drives a Tesla Model S. 
#I know that she attended the SQL Symphony Concert 3 times in December 2017.\n'

select * from drivers_license where height = "65" and hair_color = "red" and gender = "female"
and car_make = "Tesla";
select * from facebook_event_checkin where date like "%201712%" 
and event_name like "%SQL Symphony Concert%";
select * from person where id like "%99716%" or    "%24556%";
