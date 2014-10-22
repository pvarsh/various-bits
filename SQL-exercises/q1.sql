
/*----- 1. Find the colors of boats reserved by Lubber. ----- */
SELECT DISTINCT color
FROM boats s, reserves b, sailors r
WHERE s.bid = b.bid AND r.sid = b.sid AND r.sname LIKE 'Lubber';

/*----- 2. Find all IDs of sailors who have a rating of at least 8 or have reserved boat 103 -------*/
SELECT DISTINCT *
FROM sailors s, reserves r
WHERE s.sid = r.sid AND (s.rating >= 8 OR r.bid = 103);

SELECT DISTINCT *
FROM sailors s LEFT JOIN reserves r ON s.sid = r.sid
WHERE s.rating >= 8 OR r.bid = 103;