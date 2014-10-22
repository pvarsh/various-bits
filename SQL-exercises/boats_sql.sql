

CREATE TABLE sailors
	(`sid` int, `sname` varchar(7), `rating` int, `age` int)
;
	
INSERT INTO sailors
	(`sid`, `sname`, `rating`, `age`)
VALUES
	(22, 'Dustin', 7, 45.0),
	(29, 'Brutus', 1, 33.0),
	(31, 'Lubber', 8, 55.5),
	(32, 'Andy', 8, 25.5),
	(58, 'Rusty', 10, 35.0),
	(64, 'Horatio', 7, 35.0),
	(71, 'Zorba', 10, 16.0),
	(74, 'Horatio', 9, 35.0),
	(85, 'Art', 3, 25.5),
	(95, 'Bob', 3, 63.5)
;



CREATE TABLE reserves
	(`sid` int, `bid` int, `day` datetime)
;
	
INSERT INTO reserves
	(`sid`, `bid`, `day`)
VALUES
	(22, 101, '2004-10-10 00:00:00'),
	(22, 102, '2004-10-10 00:00:00'),
	(22, 103, '2004-10-08 00:00:00'),
	(22, 104, '2004-10-07 00:00:00'),
	(31, 102, '2004-11-10 00:00:00'),
	(31, 103, '2004-11-06 00:00:00'),
	(31, 104, '2004-11-12 00:00:00'),
	(64, 101, '2004-09-05 00:00:00'),
	(64, 102, '2004-09-08 00:00:00'),
	(74, 103, '2004-09-08 00:00:00')
;





CREATE TABLE boats
	(`bid` int, `bname` varchar(9), `Color` varchar(5))
;
	
INSERT INTO boats
	(`bid`, `bname`, `Color`)
VALUES
	(101, 'Interlake', 'blue'),
	(102, 'Interlake', 'red'),
	(103, 'Clipper', 'green'),
	(104, 'Marine', 'red')
;