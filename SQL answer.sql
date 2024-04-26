--Part I: Simple queries------------------------------------------


--I.1: 459 rows
SELECT
	EventName ,
	EventDate
FROM
	tblEvent te
order by
	EventDate DESC;
	

--I.2
SELECT
	top 5 EventName as What,
	EventDate as Details
FROM
	tblEvent te
order by
	EventDate DESC;


--I.3
SELECT
	TOP 3 CategoryID ,
	CategoryName
FROM
	tblCategory tc
order by
	CategoryName DESC;


--I.4: Click on the Text instead of Grid to switch
--Ascending order
SELECT
	TOP 2 EventName ,
	EventDate
FROM
	tblEvent te
order by
	EventDate ;
--Descending order
SELECT
	TOP 2 EventName ,
	EventDate
FROM
	tblEvent te
order by
	EventDate DESC ;





--Part II: Use WHERE----------------------------------------------------


--II.1: 3 rows
SELECT
	*
FROM
	tblEvent te
WHERE
	CategoryID = 11;


--II.2: 2 rows
SELECT
	*
FROM
	tblEvent te
WHERE
	EventDate LIKE '2005-02%';


--II.3: 2 rows
SELECT
	*
FROM
	tblEvent te
WHERE
	EventName
	LIKE '%Teletubbies%'
	OR EventName LIKE '%Pandy%';


--II.4
---13 rows
SELECT
	*
FROM
	tblEvent te
WHERE
	CountryID IN (8, 22, 30, 35)
	or EventDetails LIKE '%Water%'
	or CategoryID = 4;

---Adding >=1970 filter: 5 rows
SELECT
	*
FROM
	tblEvent te
WHERE
	(CountryID IN (8, 22, 30, 35)
	or EventDetails LIKE '% Water %'
	or CategoryID = 4)
	AND YEAR (EventDate) >= 1970;


--II.5: 4 rows
SELECT
	*
FROM
	tblEvent te
WHERE
	CategoryID <> 14
	AND EventDetails LIKE '%Train%';


--II.6: 6 rows
SELECT
	*
FROM
	tblEvent te
WHERE
	 EventName NOT LIKE '%space%'
	AND EventDetails not LIKE '%space%'
	AND CountryID = 13;


--II.7: 91 rows
SELECT
	*
FROM
	tblEvent te
WHERE
	CategoryID IN (5, 6)
	AND EventDetails NOT LIKE '%War%'
	AND EventDetails NOT LIKE '%Death%';





--Part III: Basic joins---------------------------------------------------


--III.1: 13 rows
SELECT
	te.Title ,
	te.EpisodeType, 
	ta.AuthorName
FROM
	tblEpisode te
left join tblAuthor ta 
on
	te.AuthorId = ta.AuthorId
WHERE 
	te.EpisodeType LIKE '%special%';


--III.2: 15 rows
SELECT
	te.EpisodeId ,
	te.EpisodeDate ,
	td.DoctorName
FROM
	tblEpisode te
left join tblDoctor td on
	te.DoctorId = td.DoctorId
WHERE
	te.EpisodeDate LIKE '2010%';


--III.3: 459 rows
SELECT
	te.EventName ,
	te.EventDate ,
	tc.CountryName
FROM
	tblEvent te
left join tblCountry tc on
	te.CountryID = tc.CountryID;


--III.4: 5 rows
SELECT
	te.EventName ,
	tc.CountryName ,
	tc2.ContinentName
FROM
	tblEvent te
left join tblCountry tc on
	te.CountryID = tc.CountryID
left join tblContinent tc2 on
	tc.ContinentID = tc2.ContinentID
WHERE
	tc.CountryName = 'Russia'
	OR tc2.ContinentName = 'Antarctic';


--III.5: 459, 461, 2
---Inner join: 459 rows
SELECT
	te.CategoryID ,
	tc.CategoryName
FROM
	tblEvent te
inner join tblCategory tc on
	te.CategoryID = tc.CategoryID;

---Outer join: 461 rows
SELECT
	te.CategoryID ,
	tc.CategoryName
FROM
	tblEvent te
full outer join tblCategory tc on
	te.CategoryID = tc.CategoryID;

---Filter by category without corresponding events: 2 rows
SELECT
	te.CategoryID ,
	tc.CategoryName,
	te.EventID ,
	te.EventName
FROM
	tblEvent te
full outer join tblCategory tc on
	te.CategoryID = tc.CategoryID
WHERE
	te.EventID IS NULL;


--III.6: 16 rows
SELECT
	te.EpisodeId ,
	ta.AuthorName ,
	tee.EnemyId,
	te2.EnemyName
FROM
	tblEpisode te
inner join tblAuthor ta on
	te.AuthorId = ta.AuthorId
INNER JOIN tblEpisodeEnemy tee on
	te.EpisodeId = tee.EpisodeId
INNER JOIN tblEnemy te2 on
	tee.EnemyId = te2.EnemyId
WHERE
	te2.EnemyName = 'Daleks';


--III.7: 2 rows
SELECT
	ta.AuthorName ,
	te.Title ,
	td.DoctorName ,
	te2.EnemyName ,
	len(ta.AuthorName)as AuthorNameLength ,
	len(te.Title) as TitleLength,
	len(td.DoctorName)as DoctorNameLength,
	len(te2.EnemyName)as EnemyNameLength,
	len(ta.AuthorName)+ len(te.Title)+ len(td.DoctorName)+ len(te2.EnemyName) as SumLength
FROM
	tblEpisode te
inner join tblAuthor ta on
	te.AuthorId = ta.AuthorId
INNER JOIN tblEpisodeEnemy tee on
	te.EpisodeId = tee.EpisodeId
INNER JOIN tblEnemy te2 on
	tee.EnemyId = te2.EnemyId
INNER JOIN tblDoctor td on
	te.DoctorId = td.DoctorId
WHERE
	len(ta.AuthorName)+ len(te.Title)+ len(td.DoctorName)+ len(te2.EnemyName) <40;


--III.8: 1 rows
SELECT
	*
FROM
	tblCountry tc
full outer join tblEvent te on
	tc.CountryID = te.CountryID
WHERE
	te.EventID IS NULL;





--Part IV: Aggregation and grouping--------------------------------------------


--IV.1: 25 rows
SELECT
	ta.AuthorName ,
	count(DISTINCT te.EpisodeId)as NumberOfEpisode,
	min(EpisodeDate) as EarliestDate,
	max(EpisodeDate) as LatestDate
FROM
	tblAuthor ta
left join tblEpisode te on
	ta.AuthorId = te.AuthorId
GROUP BY
	ta.AuthorName
ORDER BY
	count(DISTINCT te.EpisodeId) DESC;


--IV.2: 18 rows
SELECT
	tc.CategoryName ,
	COUNT(DISTINCT te.EventID) as NumberOfEvents
FROM
	tblCategory tc
inner join tblEvent te on
	tc.CategoryID = te.CategoryID
GROUP BY
	tc.CategoryName
ORDER BY
	NumberOfEvents DESC;


--IV.3
SELECT
	COUNT(DISTINCT EventID) as NumberOfEvents,
	MIN(EventDate) as EarliestDate,
	MAX(EventDate) as LatestDate
FROM
	tblEvent te2;


--IV.4: 42 rows
SELECT
	tc2.ContinentName ,
	tc.CountryName ,
	count(DISTINCT te.EventID) as NumberOfEvents
FROM
	tblEvent te
left join tblCountry tc on
	tc.CountryID = te.CountryID
left JOIN tblContinent tc2 on
	tc.ContinentID = tc2.ContinentID
GROUP BY
	tc2.ContinentName,
	tc.CountryName 
ORDER BY
	NumberOfEvents DESC;


--IV.5: 4 rows
SELECT
	ta.AuthorName ,
	td.DoctorName ,
	count(DISTINCT te.EpisodeId)as NumberOfEpisode
FROM
	tblEpisode te
right join tblAuthor ta  on
	ta.AuthorId = te.AuthorId
RIGHT  JOIN tblDoctor td on
	te.DoctorId = td.DoctorId
GROUP BY
	ta.AuthorName,
	td.DoctorName
HAVING 
	COUNT(DISTINCT te.EpisodeId)>5
ORDER BY
	NumberOfEpisode DESC;


--IV.6: 4 rows
SELECT
	YEAR (te2.EpisodeDate) As YOE,
	te.EnemyName ,
	count(DISTINCT te2.EpisodeId) as NOE,
	YEAR (td.BirthDate) as YOB
FROM
	tblEnemy te
left join tblEpisodeEnemy tee on
	te.EnemyId = tee.EnemyId
left join tblEpisode te2 on
	tee.EpisodeId = te2.EpisodeId
LEFT JOIN tblDoctor td on
	te2.DoctorId = td.DoctorId
WHERE
	YEAR (td.BirthDate)<1970
GROUP BY
	YEAR (te2.EpisodeDate),
	te.EnemyName,
	YEAR (td.BirthDate)
HAVING
	COUNT(DISTINCT te2.EpisodeId)>1 ;


--IV.7: 14 rows
SELECT 
	Left(tc.CategoryName,
	1) as Initial,
	COUNT(DISTINCT te.EventID ) as NumberOfEvents,
	avg(len(te.EventName))as avgEventNameLength
FROM
	tblCategory tc
Left join tblEvent te on
	tc.CategoryID = te.CategoryID
GROUP BY
	Left(tc.CategoryName,
	1)
ORDER BY
	NumberOfEvents DESC ;


--IV.8: 4 rows
SELECT
	1 + ABS(YEAR(te.EventDate)-1)/ 100 as century_shortform,
	CONCAT((1 + ABS(YEAR(te.EventDate)-1)/ 100), 
CASE 
	when right((1 + ABS(YEAR(te.EventDate)-1)/ 100), 1)= 1
	then 'st'
	when right((1 + ABS(YEAR(te.EventDate)-1)/ 100), 1)= 2
	then 'nd'
	when right((1 + ABS(YEAR(te.EventDate)-1)/ 100), 1)= 3
	then 'rd'
	ELSE 'th'
END,
' century') as Century_fullform,
	COUNT(DISTINCT te.EventID) as NumberOfEvents
FROM
	tblEvent te
group by
	1 + abs(YEAR (te.EventDate)-1)/ 100;





--Part V: Calculations---------------------------------------------------


--V.1
SELECT
	EventName ,
	LEN(EventName) as NameLength
FROM
	tblEvent te
order by
	NameLength DESC ;


--V.2
SELECT
	te.CategoryID ,
	te.EventName ,
	CONCAT(EventName, ' ', CategoryID) as event_and_category
FROM
	tblEvent te ;


--V.3
--Use ISNULL
SELECT
	tc.ContinentID ,
	tc.ContinentName ,
	tc.Summary ,
	isnull(tc.Summary,
	'No summary')
FROM
	tblContinent tc;

--Use COALESCE
SELECT
	tc.ContinentID ,
	tc.ContinentName ,
	tc.Summary ,
	COALESCE (tc.Summary,
	'No summary')
FROM
	tblContinent tc;

--Use CASE WHEN
SELECT
	tc.Summary ,
	CASE
		when tc.Summary is null then 'No summary'
		ELSE tc.Summary
		end 
FROM
		tblContinent tc;

--Combine ISNULL, COALESCE and CASE WHEN-------------------------------------
SELECT
	tc.Summary,
	isnull(tc.Summary,
	'No summary') as isnull,
	COALESCE (tc.Summary,
	'No summary') as 'coalesce',
	CASE
		when tc.Summary is null then 'No summary'
		else tc.Summary
	end as 'case'
FROM
	tblContinent tc ;


--V.4
SELECT
	ContinentID ,
	ContinentName,
	case
		when ContinentID in (1, 3) then 'Eurasia'
		WHEN ContinentID in (5, 6) then 'Americas'
		WHEN continentID in (2, 4) then 'Somewhere hot'
		WHEN continentID = 7 then 'Somewhere cold'
		ELSE 'Somewhere else'
	END as 'Belongs to'
FROM
	tblContinent tc ;


--V.5
SELECT
	*,
	KmSquared%20761  as AreaLeftOver,
	ROUND( KmSquared/20761,0) as WalesUnits,
	ABS(20761-KmSquared) as sizediff,
	concat('Wales area',' ','x',ROUND(KmSquared/20761,0) ,' ','times',' ','+',' ',KmSquared%20761,' ','squared kilometres')
FROM
	CountriesByArea cba
order by ABS(20761-KmSquared)   ;


--V.6: 7 rows
SELECT
	EventID ,
	EventName
FROM
	tblEvent te
WHERE
	LEFT (EventName,1)IN ('u', 'e', 'o', 'a', 'i')
	AND RIGHT (EventName,1) IN ('u','e','o','a','i');


--V.7: 21 rows
SELECT
	te.EventID ,
	te.EventName
FROM
	tblEvent te
WHERE 
	LEFT (EventName,1) = RIGHT (te.EventName,1);





--Part VI: Calculations using dates------------------------------------------


--VI.1
SELECT
	EventID ,
	te.EventDate,
	format(EventDate,'dd/MM/yyyy') as EventDate_DDMMYYYY
FROM
	tblEvent te
WHERE
	YEAR (EventDate)= 1998;


--VI.2: 60 rows, taking the date of 13/04/1998
SELECT
	te.EventID,
	EventDate ,
	ABS( DATEDIFF(DAY , '1998-04-13', EventDate)) as datediff
FROM
	tblEvent te
WHERE
	EventID is not NULL
	AND 
	te.EventDate > '1998-04-13'
ORDER BY
	ABS(DATEDIFF(DAY , '1998-04-13', EventDate));


--VI.3
SELECT
	EventName ,
	EventDate,
	CONCAT(DATENAME(weekday, EventDate) ,
		' ',
		DAY (EventDate),
		CASE 
			when Day(EventDate) in (11,12,13) then 'th'
			WHEN Day(EventDate)not in (11,12,13) then 
				case
					when Right(DAY (EventDate), 1)= 1 then 'st'
					WHEN Right(DAY(EventDate), 1)= 2 then 'nd'
					WHEN Right(DAY(EventDate), 1)= 3 then 'rd'
					ELSE 'th' 
				end
		end)
FROM
	tblEvent te 
WHERE 
	(DATENAME(weekday, EventDate)= 'Friday'
	AND 
	DAY (EventDate)= 13)
OR 
	(DATENAME(weekday, EventDate)= 'Thursday'
	AND
	DAY(te.EventDate)= 12)
OR 
	(DATENAME(weekday, EventDate)= 'Saturday'
	AND
	DAY(EventDate)= 14);


--VI.4
SELECT 
EventName ,
EventDate ,
CONCAT(DATENAME(weekday,EventDate),
' ',
DAY(EventDate),
CASE
	when day(EventDate)in (1,21,31)then 'st'
	WHEN day(EventDate)in (2,22) then 'nd'
	when day(EventDate) =3 then 'rd'
	ELSE 'th'
END,
' ',
DATENAME(MONTH,EventDate),
' ',
YEAR(EventDate))
FROM 
tblEvent te ;





--Part VII: Subqueries-----------------------------------------------


--VII.1: 4 rows
SELECT
	EventName,
	EventDate 
FROM
	tblEvent te
WHERE
	EventDate > (
	SELECT
		MAX(EventDate)
	from
		tblEvent te
	WHERE
		te.CountryID = 21);

	
--VII.2: 204 rows
SELECT
	EventName ,
	len(EventName)as namelength
FROM
	tblEvent te
WHERE
	len(EventName)> 
(
	SELECT
		AVG(LEN(EventName))
	from
		tblEvent te2 )
Order by
	len(EventName);
	

--VII.3: 8 rows
SELECT
	te.EventName ,
	tc.ContinentName
FROM
	tblEvent te
left join tblCountry tc2 on
	te.CountryID = tc2.CountryID
left join tblContinent tc on
	tc2.ContinentID = tc.ContinentID
WHERE
	tc.ContinentName  in 
	(SELECT
		top 3 tc.ContinentName
	from
		tblEvent te
	left join tblCountry tc2 on
		te.CountryID = tc2.CountryID
	left join tblContinent tc on
		tc2.ContinentID = tc.ContinentID 
	group by tc.ContinentName 
	order by 
COUNT(DISTINCT te.EventName)) ;


--VII.4: 5 rows
---With sub query
SELECT
	tc.CountryName
FROM
	tblCountry tc
inner join
(
	select
		te.CountryID,
		count(DISTINCT te.eventid) as numberofevent
	FROM
		tblEvent te
	group by
		te.countryid
	HAVING
		COUNT(DISTINCT te.eventid)>8) b 
on
	tc.CountryID = b.CountryID;


---With HAVING clause - additional, no need for the answer
SELECT
	te.CountryID ,
	tc.CountryName ,
	COUNT(te.EventID) as numberofevent
FROM
	tblEvent te
inner join tblCountry tc on
	te.CountryID = tc.CountryID
GROUP BY
	te.CountryID,
	tc.CountryName
HAVING  
	COUNT(te.EventID)>8; 

---with CTE - additional, no need for the answer
with eventcount as 
(
SELECT 
	te.CountryID ,
	tc.CountryName ,
	COUNT(te.EventID) as numberofevent
FROM
	tblEvent te
inner join tblCountry tc on
	te.CountryID = tc.CountryID
GROUP BY
	te.CountryID,
	tc.CountryName)
SELECT
	*
FROM
	eventcount
WHERE
	numberofevent>8;


--VII.5: 8 rows
SELECT
	te.EventName ,
	tc.CountryName,
	CategoryName 
FROM
	tblEvent te
inner join tblCountry tc on
	te.CountryID = tc.CountryID
INNER JOIN tblCategory tc2 on
	te.CategoryID = tc2.CategoryID
WHERE
	tc.CountryID  NOT in 
(
	SELECT
		top 30 tc2.countryID
	FROM
		tblCountry tc2
	order by
		CountryName DESC)
	AND 
	tc2.CategoryID  NOT in 
(
	SELECT
		TOP 15 tc3.categoryID
	from
		tblCategory tc3
	order by
		CategoryName DESC)
	;





--Part VIII: CTEs-----------------------------------------------------------


--VIII.1
---(1)create CTE
	with 
		thisandthat as
			(
			SELECT
				te.eventid,
				CASE 
					when te.eventdetails like '%this%' then 1
					else 0
				END as ifthis,
				CASE 
					when te.eventdetails like '%that%' then 1
					else 0
				END as ifthat
			FROM
				tblEvent te),
---(2)show results as table
		fullcase as 
			(
			select
				tt.ifthis,
				tt.ifthat,
				count(tt.eventid)as numberofevents
			FROM
				thisandthat tt
			group by
				tt.ifthis,
				tt.ifthat)
--ifthis=1 and ifthat=1
SELECT
	te.eventid,
	te.eventname,
	te.EventDetails 
FROM
	tblEvent te
inner join thisandthat tt on
	te.EventID = tt.eventid
WHERE
	ifthis = 1
	AND 
	ifthat = 1
;


--VIII.2: 230 rows
---without CTE (additional)
SELECT
	te.EventName ,
	te.CountryID ,
	tc.CountryName
FROM
	tblEvent te
left join tblCountry tc on
	te.CountryID = tc.CountryID
WHERE
	te.EventName LIKE '%[N-Z]'
;

---With CTE
with event_endwith_NtoZ as
(
SELECT
	te.eventname,
	te.countryid
FROM
	tblEvent te
WHERE
	te.eventname like '%[N-Z]'
)
SELECT
	tc.CountryName ,
	ee.eventname
FROM
	event_endwith_NtoZ ee
left join tblcountry tc on
	tc.CountryID = ee.CountryID ;


--VIII.3: 4 rows
---1. Get a list of all of the episodes written by authors with MP in their names.
with author_mp as
(
SELECT
	*
FROM
	tblAuthor ta
WHERE
	AuthorName LIKE '%MP%')
SELECT
	te.EpisodeId
from
	tblEpisode te
inner join author_mp am on
	am.authorid = te.AuthorId ;

---2.Get a list of the companions featuring in these episodes.
with event_author_mp as
(
SELECT
	te.EpisodeId
from
	tblEpisode te
inner join tblAuthor ta on
	ta.authorid = te.AuthorId
WHERE
	ta.AuthorName LIKE '%MP%')
SELECT
	DISTINCT tc.CompanionName
FROM
	tblepisodecompanion tec
right join
event_author_mp em on
	em.episodeid = tec.EpisodeId
inner join tblcompanion tc on
	tec.CompanionId = tc.CompanionId ;


--VIII.4: 116 rows
with
---list1: Get list of events which contain none of lettets in 'OWL'
	eventname_excludeowl as
		(
		SELECT
			*
		FROM
			tblEvent te
		WHERE
			te.EventDetails not like '%O%'
		AND  
			te.EventDetails not like '%W%'
		AND 
			te.EventDetails not like '%L%'),
---list2: Get events took place in the countries in #list1
	eventincountry_nameexcludeowl AS 
		(
		SELECT
			DISTINCT tc.CountryName,
			te.CountryID as CountryID,
			te.EventName,
			te.CategoryID
		FROM
			eventname_excludeowl as eneo
		inner join tblEvent te on
			eneo.CountryID = te.CountryID
		LEFT join tblCountry tc on
			eneo.CountryID = tc.CountryID),
---list3: Get events shared the same categories as ones in #list2
	eventwithcategory_eventincountry_nameexcludeowl AS 
		(
		SELECT
			DISTINCT tc.CategoryName,
			te.CategoryID,
			te.EventName
		From
			eventincountry_nameexcludeowl as eicneo
		inner join tblEvent te on
			te.CategoryID = eicneo.CategoryID
		LEFT JOIN tblCategory tc on
			tc.CategoryID = eicneo.CategoryID)
SELECT
	*
FROM
	eventwithcategory_eventincountry_nameexcludeowl
order by
	CategoryID;
		

--VIII.5: 3 rows
with eventandera as 
	(SELECT
		CASE
			when year(te.eventdate)<1900 then '19th century and earlier'
			when year(te.eventdate)<2000 then '20th century'
			ELSE '21st century'
		END as era,
		te.eventid
	from
		tblEvent te)
select
	era,
	count(*) as numberofevents
FROM
	eventandera ee
group by
ee.era;
