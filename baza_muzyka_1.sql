/* Tworzenie bazy*/
CREATE OR REPLACE DATABASE muzyka_1;
USE muzyka_1;
/* Tworzenie tabel*/
CREATE TABLE artysta
(
	id_artysty INT UNSIGNED NOT NULL AUTO_INCREMENT,
	nazwa_artysty TINYTEXT NOT NULL,
	rodzaj_artysty ENUM('Solista', 'Zespół') NOT NULL,
		PRIMARY KEY (id_artysty)
)
Engine=InnoDB DEFAULT CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci';
	CREATE INDEX artysta_idx1 ON nazwa_artysty;

CREATE TABLE wydawca
(
	id_wydawcy INT UNSIGNED AUTO_INCREMENT,
	nazwa_wydawcy TINYTEXT NOT NULL,
	adres_wydawcy VARCHAR(50) NOT NULL,
	miasto_wydawcy VARCHAR(45) NOT NULL,
	kraj_wydawcy VARCHAR(25) NOT NULL,
	telefon_wydawcy VARCHAR(15) UNIQUE NOT NULL,
	email_wydawcy varchar(45) UNIQUE NOT NULL,
	www_wydawcy varchar(50) UNIQUE NOT NULL,
		PRIMARY KEY (id_wydawcy)
)
Engine=InnoDB DEFAULT CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci';
	CREATE INDEX wydawca_idx1 ON nazwa_wydawcy;

CREATE TABLE plyta
(
	id_plyty INT UNSIGNED AUTO_INCREMENT,
	tytul VARCHAR(45) NOT NULL,
	stan INT UNSIGNED NOT NULL,
	data_wyd_org DATE NOT NULL,
	data_wyd_ree DATE,
	nr_reedycji INT UNSIGNED NULL,
	rodzaj ENUM('Dance', 'Rock', 'Blues', 'Pop', 'Jazz', 'Metal', 'Punk', 'Mix', 'Rap') NOT NULL,
	opinia ENUM('Super', 'Bardzo dobra', 'Dobra', 'Przeciętna', 'Mierna', 'Beznadziejna') NOT NULL,
	nosnik ENUM('CD', 'DVD', 'Vinyl', 'Blu-Ray', 'Dystrybucja Cyfrowa') NOT NULL,
	l_nosnikow INT UNSIGNED NOT NULL DEFAULT 1,
	typ_nosnika VARCHAR(16) NOT NULL,
	cena DECIMAL(5,2) NOT NULL DEFAULT 0.00,
	rabat DECIMAL(4,2) NULL,
		PRIMARY KEY (id_plyty),
			id_wydawcy INT UNSIGNED NOT NULL,
				CONSTRAINT plyta_id_wydawcy_fk
				FOREIGN KEY (id_wydawcy)
				REFERENCES wydawca(id_wydawcy)
					ON UPDATE CASCADE
					ON DELETE CASCADE,
			id_artysty INT UNSIGNED NOT NULL,
				CONSTRAINT plyta_id_artysty_fk
				FOREIGN KEY (id_artysty)
				REFERENCES artysta(id_artysty)
					ON UPDATE CASCADE
					ON DELETE CASCADE
)
Engine=InnoDB DEFAULT CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci';

CREATE INDEX plyta_idx1 ON tytul;
CREATE INDEX plyta_idx2 ON rodzaj;
CREATE INDEX plyta_idx3 ON cena;

CREATE TABLE utwor
(
	id_utworu INT UNSIGNED AUTO_INCREMENT,
	tytul_utworu TINYTEXT NOT NULL,
	czas_utworu TIME NOT NULL, 
		PRIMARY KEY (id_utworu),
		id_plyty INT UNSIGNED NOT NULL,
			CONSTRAINT utwor_id_plyty_fk
			FOREIGN KEY (id_plyty)
			REFERENCES plyta(id_plyty)
)
Engine=InnoDB DEFAULT CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci';
CREATE INDEX utwor_idx1 ON tytul_utworu;



/* Wprowadzenie danych*/

INSERT INTO wydawca VALUES (null, 'EMI Music Poland', 'ul. Osmańska 11', '02-823 Warszawa', 'Polska', '(22) 549 18 00', 'kontakt@emimusic.pl','www.emimusic.pl');
INSERT INTO wydawca VALUES (null, 'Sony Music Poland','ul. Chóralna 14', '02-879 Warszawa', 'Polska', '(22) 336 60 00', 'pl_kontakt@sonymusic.com','www.sonymusic.pl');
INSERT INTO wydawca VALUES (null, 'Universal Music Polska','ul. Włodarzewska 69','02-384 Warszawa','Polska','(22) 592 82 00','universal@universalmusic.pl','https://universalmusic.pl');
INSERT INTO wydawca VALUES (null, 'Magic Records', 'ul. Włodarzewska 69', '02-384 Warszawa', 'Polska', '(22) 668 66 00', 'kontakt@magicrecords.pl','www.magicrecords.pl');
INSERT INTO wydawca VALUES (null, 'Warner Music Poland','ul. Osmańska 11','02-823 Warszawa', 'Polska', '(22) 549 18 10','kontakt@warnermusic.pl','https://www.warnermusic.pl');

INSERT INTO artysta VALUES (null, 'Bob Dylan', 'Solista');
INSERT INTO artysta VALUES (null, 'Metallica', 'Zespół');
INSERT INTO artysta VALUES (null, 'Linkin Park', 'Zespół');
INSERT INTO artysta VALUES (null, 'Lana DelRey', 'Solista');
INSERT INTO artysta VALUES (null, 'Kortez', 'Solista');
INSERT INTO artysta VALUES (null, 'Sting', 'Solista');
INSERT INTO artysta VALUES (null, 'Sade', 'Solista');
INSERT INTO artysta VALUES (null, 'Massive Attack', 'Zespół');
INSERT INTO artysta VALUES (null, 'George Michael', 'Solista');

INSERT INTO plyta VALUES (null, 'Nashville Skyline', 17, '1969-04-09', '2005-12-01', null, 'Pop', 'Dobra', 'CD', 1,'JevelCase', 49.75, 4.99, 1, 1);
INSERT INTO plyta VALUES (null, 'Down in the Groove', 12, '1988-06-15','1992-04-06',null, 'Pop', 'Przecietna', 'CD', 1,'JevelCase', 39.00, null, 1, 2);
INSERT INTO plyta VALUES (null, 'MTV Unplugged', 14,'1995-04-18',null,null, 'Jazz','Super', 'DVD',1,'JevelCase/Album', 75.49, 5.99, 2, 2);
INSERT INTO plyta VALUES (null, '...And Justice for All', 11, '1988-10-09','2018-11-02',2, 'Metal', 'Dobra', 'CD',1, 'JevelCase',36.00, 4.99, 4, 2);
INSERT INTO plyta VALUES (null, 'Garage Inc.', 14,'1998-11-20',null, null, 'Metal', 'Super','CD',2,'JevelCase',43.20,null, 2, 2);
INSERT INTO plyta VALUES (null, 'Black Album', 2,'1991-02-21',null, null, 'Metal','Super','CD',1, 'JevelCase',59.00, 10.00,2,2);
INSERT INTO plyta VALUES (null, 'Modern Times', 15, '2006-07-29',null,null, 'Blues','Dobra','CD',1, 'JevelCase/Album', 39.99, 4.50,3, 1);
INSERT INTO plyta VALUES (null, 'Hybrid Theory', 24, '2000-10-24','2020-08-16',2, 'Rock','Dobra','DVD',1,'JevelCase/Album', 65.90,null, 3, 3);
INSERT INTO plyta VALUES (null, 'Meteora', 19, '2003-03-25','2009-01-01',null,'Rock','Super','CD',1,'JevelCase',50.00,3.99,4,3);
INSERT INTO plyta VALUES (null, 'Minutes to Midnight', 21, '2007-05-15',null, null, 'Rock', 'Super','CD',1,'JevelCase',49.50, null, 4, 3);
INSERT INTO plyta VALUES (null, 'A Thousand Suns', 33, '2010-09-13',null, null, 'Rock', 'Super','DVD',1,'JevelCase/Album',89.90,10.99, 1,3);
INSERT INTO plyta VALUES (null, 'Ride The Lightning', 13, '1984-07-27','2016-04-15',2, 'Metal', 'Mierna','Vinyl',1,'Standard', 96.40, null, 2, 1);
INSERT INTO plyta VALUES (null, 'Master of Puppets', 21, '1986-03-03','2017-11-17',1, 'Metal', 'Super','CD',1,'JevelCase', 49.99,null, 1,1);
INSERT INTO plyta VALUES (null, '...And Justice for All', 7, '1988-08-25','2018-11-02',1, 'Metal', 'Super','CD',1,'Digipack', 39.99, 5.00,3, 1);
INSERT INTO plyta VALUES (null, 'Load', 21, '1996-06-04',null,null, 'Metal', 'Super','CD',1, 'Digipack',44.75, null, 3,1);
INSERT INTO plyta VALUES (null, 'Reload', 17, '1997-11-18',null, null, 'Metal', 'Mierna','Vinyl',1,'Standard', 50.75,9.50,2,1);
INSERT INTO plyta VALUES (null, 'Mezzanine', 14, '1998-04-20','2019-08-23', 2, 'Mix', 'dobra','CD',2,'JevelCase',37.45,null,4,8);
INSERT INTO plyta VALUES (null, 'Protection', 10, '1994-09-26','2016-12-02',3, 'Mix', 'dobra','Vinyl',1,'Standard/Album',79.99,2.50,4,8);
INSERT INTO plyta VALUES (null, 'Older', 11, '1996-04-17',null,null, 'Pop', 'Bardzo dobra','CD',1,'JevelCase',35.00,null,2,9);

INSERT INTO utwor VALUES (null, 'Girl From The North Country', '00:03:41', 1);
INSERT INTO utwor VALUES (null, 'Nashville Skyline Rag', '00:03:12', 1);
INSERT INTO utwor VALUES (null, 'To Be Alone With You', '00:02:05', 1);
INSERT INTO utwor VALUES (null, 'I Threw It All Away', '00:02:23', 1);
INSERT INTO utwor VALUES (null, 'Peggy Day', '00:01:59', 1);
INSERT INTO utwor VALUES (null, 'Lay Lady Lay', '00:03:20', 1);
INSERT INTO utwor VALUES (null, 'One More Night', '00:02:25', 1);
INSERT INTO utwor VALUES (null, 'Tell Me That It Isnt True', '00:02:45', 1);
INSERT INTO utwor VALUES (null, 'Country Pie', '00:01:35', 1);
INSERT INTO utwor VALUES (null, 'Tonight I\ll Be Staying Here With You', '00:03:23', 1);
INSERT INTO utwor VALUES (null, 'Let\s Stick Together', '00:03:09', 2);
INSERT INTO utwor VALUES (null, 'Somewhere I Belong', '00:03:33', 9);
INSERT INTO utwor VALUES (null, 'Lying from You', '00:02:54', 9);
INSERT INTO utwor VALUES (null, 'Hit the Floor', '00:02:44', 9);
INSERT INTO utwor VALUES (null, 'Easier to Run', '00:03:24', 9);
INSERT INTO utwor VALUES (null, 'Faint', '00:02:42', 9);
INSERT INTO utwor VALUES (null, 'Figure.09', '00:03:17', 9);
INSERT INTO utwor VALUES (null, 'Breaking the Habit', '00:03:16', 9);
INSERT INTO utwor VALUES (null, 'From the Inside', '00:02:55', 9);
INSERT INTO utwor VALUES (null, 'Nobody\s Listening', '00:02:58', 9);
INSERT INTO utwor VALUES (null, 'Session', '00:02:24', 9);
INSERT INTO utwor VALUES (null, 'Numb', '00:03:07', 9);
INSERT INTO utwor VALUES (null, 'Wake', '00:01:43', 10);
INSERT INTO utwor VALUES (null, 'Given Up', '00:03:11', 10);
INSERT INTO utwor VALUES (null, 'Leave Out All the Rest', '00:03:31', 10);
INSERT INTO utwor VALUES (null, 'Bleed It Out', '00:02:46', 10);
INSERT INTO utwor VALUES (null, 'Shadow of the Day', '00:04:52', 10);
INSERT INTO utwor VALUES (null, 'What I\ve Done', '00:03:28', 10);
INSERT INTO utwor VALUES (null, 'Hands Held High', '00:03:55', 10);
INSERT INTO utwor VALUES (null, 'No More Sorrowh', '00:03:43', 10);
INSERT INTO utwor VALUES (null, 'Valentine\s Day', '00:03:18', 10);
