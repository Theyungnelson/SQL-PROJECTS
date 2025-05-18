#1. What is the total number of confirmed cases, deaths, and recoveries globally?
select * from covid_19;
create view Total_CDR as SELECT 
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths,
    SUM(recovered) AS total_recoveries
FROM covid_19;

#2. What is the global death rate and recovery rate?
     create view Total_DR as SELECT 
    (SUM(deaths) * 100.0 / SUM(confirmed)) AS death_rate_percentage,
    (SUM(recovered) * 100.0 / SUM(confirmed)) AS recovery_rate_percentage
FROM covid_19;


#3 Which 10 countries have the most confirmed cases?
  create view Most_CC as SELECT `Country/Region`, confirmed
FROM covid_19
ORDER BY confirmed DESC 
LIMIT 10;


#4. Which 10 countries have the highest death rates?
create view Highest_Dr as SELECT `Country/Region`, (deaths * 100.0 / confirmed) AS death_rate_percentage 
FROM covid_19 
ORDER BY death_rate_percentage DESC 
LIMIT 10;


#5. Which 10 countries have the most active cases?
create view Most_AC as SELECT `Country/Region`, (confirmed - deaths - recovered) AS active_cases 
FROM covid_19 
ORDER BY active_cases DESC 
LIMIT 10;

#6 What are the total cases, deaths, and recoveries for each continent?
 create view Total_CDR_Continent as SELECT `WHO Region`, 
       SUM(confirmed) AS total_cases, 
       SUM(deaths) AS total_deaths, 
       SUM(recovered) AS total_recoveries
FROM covid_19
GROUP BY `WHO Region`;


#7 Which continent has the highest death rate?
 create view Continent_HDR as SELECT `WHO Region`, 
       (SUM(deaths) * 100.0 / SUM(confirmed)) AS death_rate_percentage
FROM covid_19
GROUP BY `WHO Region`
ORDER BY death_rate_percentage DESC
LIMIT 1;

#8 Which 10 countries have the highest recovery rates?
create view Countries_HRR as SELECT `Country/Region`, 
       (SUM(recovered) * 100.0 / SUM(confirmed)) AS recovery_rate_percentage 
FROM covid_19 
GROUP BY `Country/Region`
ORDER BY recovery_rate_percentage DESC 
LIMIT 10;


#9 Which 10 countries have the lowest recovery rates?
 create view Countries_LRR as SELECT `Country/Region`,
       (SUM(recovered) * 100.0 / SUM(confirmed)) AS recovery_rate_percentage 
FROM covid_19
GROUP BY `Country/Region`
ORDER BY recovery_rate_percentage ASC 
LIMIT 10;

#10 Which 10 countries have the most active cases?
create view Countries_MAC as SELECT `Country/Region`, 
       (confirmed - deaths - recovered) AS active_cases 
FROM covid_19
ORDER BY active_cases DESC 
LIMIT 10;

#11 How do two specific countries compare in terms of total cases, deaths, and recoveries?
create view Countries_Comparism as SELECT `Country/Region`, 
       SUM(confirmed) AS total_cases, 
       SUM(deaths) AS total_deaths, 
       SUM(recovered) AS total_recoveries
FROM covid_19
WHERE `Country/Region` IN ('China', 'Us')
GROUP BY `Country/Region`;

#12 How do continents compare in terms of total cases, deaths, and recoveries?
 create view Continents_Comparism as SELECT `WHO Region`, 
       SUM(confirmed) AS total_cases, 
       SUM(deaths) AS total_deaths, 
       SUM(recovered) AS total_recoveries
FROM covid_19
GROUP BY `WHO Region`;



 





