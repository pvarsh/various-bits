
/*----- 1. Find the colors of boats reserved by Lubber. ----- */
SELECT DISTINCT color
FROM boats s, reserves b, sailors r
WHERE s.bid = b.bid AND r.sid = b.sid AND r.sname LIKE 'Lubber';

/*----- 2. Find all IDs of sailors who have a rating of at least 8 or have reserved boat 103 -------*/
/* Incorrect */
SELECT DISTINCT s.sid
FROM sailors s, reserves r
WHERE s.sid = r.sid AND (s.rating >= 8 OR r.bid = 103);

/* Correct with LEFT JOIN */
SELECT DISTINCT s.sid
FROM sailors s LEFT JOIN reserves r ON s.sid = r.sid
WHERE s.rating >= 8 OR r.bid = 103 ORDER BY s.sid;

/* Correct with UNION */
(SELECT sid
	FROM sailors s
	WHERE s.rating >= 8)
UNION (
	SELECT s.sid
	FROM sailors s, reserves r
	WHERE s.sid = r.sid AND r.bid = 103
	)
ORDER BY sid;

/*----- Extra question: Find the names of sailors who have not reserved a boat ------- */
SELECT s.sname
FROM sailors s LEFT JOIN reserves r ON s.sid = r.sid
WHERE r.bid IS NULL
;

/*----- 3. Find the names of sailors who have not reserved a red boat ------- */
/* Sailors who did not rent any boats */
SELECT s.sname
FROM sailors s LEFT JOIN reserves r ON s.sid = r.sid
WHERE r.bid IS NULL
;
/* Reserves of non-red boats */
SELECT sid
FROM reserves r JOIN boats b ON r.bid = b.bid
WHERE b.color LIKE 'red'
;

/* Correct answer */
SELECT sname, sid
FROM sailors
WHERE sid NOT IN (SELECT sid
	FROM reserves r JOIN boats b ON r.bid = b.bid
	WHERE b.color LIKE 'red'
)
ORDER BY sname;

/* Sailors who reserved non-red boats */
SELECT s.sname
FROM sailors s JOIN (
	SELECT sid
	FROM reserves r JOIN boats b ON r.bid = b.bid
	WHERE b.color <> 'red'
	)nonreds
	ON s.sid = nonreds.sid
;

/* Natural join of all three tables by IDs. */
SELECT * FROM sailors s, reserves r, boats b WHERE s.sid = r.sid AND b.bid = r.bid;

/*------ 4. Find the IDs of sailors with age over 20 who have not reserved a red boat ---- */
SELECT s.sname, s.sid, s.age
FROM sailors s
WHERE sid NOT IN (SELECT sid
	FROM reserves r JOIN boats b ON r.bid = b.bid
	WHERE b.color LIKE 'red'
) AND s.age > 20
ORDER BY s.sname;

/*------ 5. Find the names of sailors who have reserved at least two boats ------*/
SELECT s.sname
FROM (reserves r1 JOIN reserves r2 ON r1.sid = r2.sid)
JOIN sailors s ON s.sid = r1.sid
WHERE r1.bid < r2.bid
GROUP BY s.sid
;

/*------ 6. Find the names of sailors who have reserved all boats ------*/
SELECT * FROM boats;
SELECT COUNT(bid) FROM boats UNION boats;

/* Count counts duplicates */
SELECT COUNT(bid) FROM
(SELECT * FROM boats
UNION ALL
SELECT * FROM boats) bb
;

/* List boats a sailor reserved */
SELECT s.sid, r.bid
FROM sailors s JOIN reserves r ON s.sid = r.sid
;
/* Count distinct boats a sailor reserved */
SELECT s.sid, COUNT(DISTINCT r.bid)
FROM sailors s JOIN reserves r ON s.sid = r.sid
GROUP BY s.sid;

/* Insert another reserve for lubber for boat 102 which lubber had already reserved another day */
INSERT INTO reserves (sid, bid, day) VALUES(31, 102, "2004-11-11");
INSERT INTO reserves (sid, bid, day) VALUES(31, 101, "2004-11-11");
/* Delete inserted reserve */
DELETE FROM reserves WHERE bid = 102 AND sid = 31 AND day = "2004-11-11";
DELETE FROM reserves WHERE bid = 101 AND sid = 31 AND day = "2004-11-11";

/* Answer */
SELECT s.sname, s.sid
FROM sailors s JOIN ( SELECT s.sid, COUNT(DISTINCT r.bid) AS cnt
					FROM sailors s JOIN reserves r ON s.sid = r.sid
 					GROUP BY s.sid
 				  ) sr ON s.sid = sr.sid
WHERE sr.cnt = (SELECT COUNT(b.bid) as numboats FROM boats b)
;

/* Using division */
SELECT DISTINCT sname
FROM  
	(SELECT DISTINCT sat_sidbid.sid FROM
		(SELECT DISTINCT sidbid.sid, bids.bid FROM 
			(SELECT s.sid, r.bid
				FROM sailors s JOIN reserves r ON s.sid = r.sid
			) AS sidbid
		CROSS JOIN
			(SELECT b.bid
				FROM boats b
			) AS bids
		) AS sat_sidbid /* saturated sailor id cross boat id */
	LEFT JOIN
		(SELECT s1.sid, r1.bid
			FROM sailors s1
			JOIN reserves r1 ON s1.sid = r1.sid
		) AS qwerty
		ON qwerty.sid = sat_sidbid.sid AND qwerty.bid = sat_sidbid.bid
		WHERE qwerty.sid IS NULL
	) as poiu
	RIGHT JOIN
	(SELECT s3.sid, s3.sname
		FROM sailors s3
		JOIN reserves r3 ON s3.sid = r3.sid
	) as asdf
	ON poiu.sid = asdf.sid WHERE poiu.sid IS NULL
;

SELECT DISTINCT sat_sidbid.sid FROM
		(SELECT DISTINCT sidbid.sid, bids.bid FROM 
			(SELECT s.sid, r.bid
				FROM sailors s JOIN reserves r ON s.sid = r.sid
			) AS sidbid
		CROSS JOIN
			(SELECT b.bid
				FROM boats b
			) AS bids
		) AS sat_sidbid /* saturated sailor id cross boat id */
	LEFT JOIN
		(SELECT s1.sid, r1.bid
			FROM sailors s1
			JOIN reserves r1 ON s1.sid = r1.sid
		) AS qwerty
		ON qwerty.sid = sat_sidbid.sid AND qwerty.bid = sat_sidbid.bid
		WHERE qwerty.sid IS NULL;

SELECT DISTINCT sidbid.sid, bids.bid FROM 
		(SELECT s.sid, r.bid
			FROM sailors s JOIN reserves r ON s.sid = r.sid
		) AS sidbid
		LEFT JOIN
		(SELECT b.bid
			FROM boats b
		) AS bids
		ON bids.bid = sidbid.bid
;





SELECT s.sid
FROM sailors s
JOIN reserves r ON s.sid = r.sid
CROSS boats b


/*------ 7. Find the names of sailors who have reserved all boats called Interlake ------ */
/* Idea: select sailors whose count of boats named "Interlake" is the same as the total count of boats named "Interlake" */

SELECT * FROM boats b, sailors s, reserves r WHERE b.bid = r.bid AND r.sid = s.sid;


/* Boat IDs for name Interlake */
SELECT b.bid FROM boats b WHERE b.bname LIKE "Interlake";

/* Answer */
SELECT * FROM 
	(SELECT s.sname, COUNT(DISTINCT b.bid) AS boatcount
	FROM sailors s, reserves r, boats b
	WHERE s.sid = r.sid AND r.bid = b.bid AND b.bname LIKE 'interlake'
	GROUP BY s.sid) scounts
WHERE scounts.boatcount = (SELECT COUNT(DISTINCT b2.bid) FROM boats b2 WHERE b2.bname LIKE "interlake")
;

/*------ 8. Find the IDs of sailors whose rating is better than some sailor called Bob ------*/
SET @bobmin = (SELECT MIN(s.rating) as mrating FROM sailors s WHERE s.sname LIKE 'bob');

SELECT s.sid FROM sailors s WHERE s.rating > @bobmin;

/*------ 9. Find the IDs of sailors whose rating is better than every sailor called Bob ------*/
SET @bobmax = (SELECT MAX(s.rating) as mrating FROM sailors s WHERE s.sname LIKE 'bob');

SELECT s.sid FROM sailors s WHERE s.rating > @bobmax;

/*------ 10. Find the IDs of sailors with the highest rating ------*/
SELECT s.sid, s.rating, s.sname
FROM sailors s
WHERE s.rating = (SELECT MAX(s.rating) from sailors s);

/* Not using max() */
SELECT s1.sid, s1.sname
FROM (SELECT DISTINCT s1.sid
		FROM sailors s1
		CROSS JOIN
		sailors s2
		WHERE s2.sid <> s1.sid AND s2.rating > s1.rating
     ) AS sailorsailor
RIGHT JOIN sailors s1 ON s1.sid = sailorsailor.sid
WHERE sailorsailor.sid IS NULL
;

/*------ 11. Find the name and age of the oldest sailor ------*/
SELECT s.sname, s.age
FROM sailors s
WHERE s.age = (SELECT MAX(s.age) from sailors s);

/* Not using max() */
SELECT s2.sname, s2.age
FROM
	(SELECT s2.sid, s2.age, s2.sname
		FROM sailors s2
		CROSS JOIN sailors s
		WHERE s.sid <> s2.sid AND s2.age < s.age
	) AS sailorsailor
RIGHT JOIN sailors s2 ON s2.sid = sailorsailor.sid
WHERE sailorsailor.sid IS NULL
;
