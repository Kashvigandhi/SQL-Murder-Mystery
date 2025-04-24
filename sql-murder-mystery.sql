--To fetch details of the crime scene
select * from crime_scene_report where city = 'SQL City' and date = '20180115' and type = 'murder'

--To fetch details of first witness
select * from person where address_street_name = 'Northwestern Dr' and address_number = (select max(address_number) from person)

--To fetch interview of first witness
select * from interview where person_id = (select id from person where address_street_name = 'Northwestern Dr' and address_number = (select max(address_number) from person))

--To fetch interview of second witness
select * from interview where person_id in (select id from person where address_street_name = 'Franklin Ave')

--To fetch name of murderer based on both interviews
select p.name from drivers_license d join person p on d.id = p.license_id where p.id in (select m.person_id from get_fit_now_check_in c inner join get_fit_now_member m on c.membership_id = m.id  where c.check_in_date = '20180109' and m.membership_status = 'gold' and c.membership_id like '48Z%')

--To fetch interview of murderer
select * from interview where person_id = (select p.id from drivers_license d join person p on d.id = p.license_id where p.id in (select m.person_id from get_fit_now_check_in c inner join get_fit_now_member m on c.membership_id = m.id  where c.check_in_date = '20180109' and m.membership_status = 'gold' and c.membership_id like '48Z%'))

--To fetch name of woman who hired the murderer
select name from person where id = (select distinct person_id from facebook_event_checkin where person_id in (select p.id from drivers_license d join person p on p.license_id = d.id where d.car_make = 'Tesla' and d.hair_color = 'red' and d.car_model = 'Model S') and event_name = 'SQL Symphony Concert' and date like '201712%' )
