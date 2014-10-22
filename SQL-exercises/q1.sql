
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

/*------ 7. Find the names of sailors who have reserved all boats called BigBoat ------ */