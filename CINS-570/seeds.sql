-- Seed data for 570 Project

-- Seed the user table
INSERT ALL
	INTO users (fname, lname,u_name, p_word, email, age, quote) VALUES ('test', '1', 'test1', 'a', 'test1@test.test', 21, 'Fuck Oracle')
	INTO users (fname, lname,u_name, p_word, email, age, quote) VALUES ('test', '2', 'test2', 'a', 'test2@test.test', 16, 'FUCK ORACLE')
	INTO users (fname, lname,u_name, p_word, email, age, quote) VALUES ('test', '3', 'test3', 'a', 'test3@test.test', 77, 'Motherfuck Oracle')
SELECT * FROM dual;

-- Seed the collections table
INSERT ALL
	INTO collections (u_id, c_name, c_desc, adult) VALUES(1, 'Sports', 'Stuff about sports', '0')
	INTO collections (u_id, c_name, c_desc, adult) VALUES(1, 'Cars', 'Stuff about cars', '0' )
	INTO collections (u_id, c_name, c_desc, adult) VALUES(3, 'Porno', 'Stuff about naked chicks', '1' )
	INTO collections (u_id, c_name, c_desc, adult) VALUES(2, 'Beiber', 'Stuff about my Lord and God, Justin Beiber', '0' )
SELECT * FROM dual;

-- Seed the books table
INSERT ALL
	INTO books (title, auth, isbn, adult) VALUES ('Vroom Vroom', 'Jeremy Clarkson', 'asdfasdfasdfasdfasdf', '0')
	INTO books (title, auth, isbn, adult) VALUES ('How to Sport Harder!', 'Joe Jockstrap', 'asdfasdfasdfasdf', '0')
	INTO books (title, auth, isbn, adult) VALUES ('5,000,000 Shades of Grey', 'Randy Damsel', 'asdfasdfasdfasdfasdfasdf', '1')
	INTO books (title, auth, isbn, adult) VALUES ('How I Turned Obnoxious Arrogance Into A Fortune', 'Justin Beiber', 'asdfasdfsdfas', '0')
	INTO books (title, auth, isbn, adult) VALUES ('I Just Didn''t Sport Hard Enough to Win', 'Mike "Second Place" Hardnose', 'adsffdsadf', '0')
SELECT * FROM dual;

-- Seed the cds table
INSERT ALL
	INTO cds (title, artist, genre, adult) VALUES('Rocky I Soundtrack', 'Various', '80''s Rock', '0')
	INTO cds (title, artist, genre, adult) VALUES('Remember The Titans Soundtrack', 'Various', 'Sound Track', '0')
	INTO cds (title, artist, genre, adult) VALUES('Appetite For Destruction', 'Guns and Roses', 'Rock', '1')
	INTO cds (title, artist, genre, adult) VALUES('Cop Killah', 'IceT', 'Rap', '1')
	INTO cds (title, artist, genre, adult) VALUES('Greates Hits', 'Michael Bolton', 'Audible Valium', '0')
SELECT * FROM dual;

-- Seed the movies table
INSERT ALL
	INTO movies (title, rating, format, sumry, adult) VALUES ('Bad Taste', 'R', 'VHS', 'Aliens invade New Zealand in Peter Jackson''s first movie', '1')
	INTO movies (title, rating, format, sumry, adult) VALUES ('Guardians of the Galaxy', 'PG-13', 'Blue-Ray', 'It''s awesome, just go watch it', '0')
	INTO movies (title, rating, format, sumry, adult) VALUES ('Teletubbies in Hugland', 'G', 'DVD', 'The teletubbies hug and shit', '0')
	INTO movies (title, rating, format, sumry, adult) VALUES ('ROBOCOP', 'R', 'Laser Disc', 'Possible the most structurally perfect movie ever made', '1')
	INTO movies (title, rating, format, sumry, adult) VALUES ('Debbie Does Hong Kong', 'X', 'Betamax', 'Debbie Kicks is up a notch and takes on 7,000,000 guys', '1')
SELECT * FROM dual;

-- Seed the coll_book table
INSERT ALL
	INTO coll_book (book_id, c_id) VALUES (1,1)
	INTO coll_book (book_id, c_id) VALUES (2,1)
	INTO coll_book (book_id, c_id) VALUES (2,2)
	INTO coll_book (book_id, c_id) VALUES (3,3)
	INTO coll_book (book_id, c_id) VALUES (4,3)
	INTO coll_book (book_id, c_id) VALUES (4,4)
	INTO coll_book (book_id, c_id) VALUES (5,1)
SELECT * FROM dual;

-- Seed the coll_cd table
INSERT ALL
	INTO coll_cd (cd_id, c_id) VALUES(1,1)
	INTO coll_cd (cd_id, c_id) VALUES(2,1)
	INTO coll_cd (cd_id, c_id) VALUES(1,2)
	INTO coll_cd (cd_id, c_id) VALUES(3,2)
	INTO coll_cd (cd_id, c_id) VALUES(5,3)
	INTO coll_cd (cd_id, c_id) VALUES(4,3)
	INTO coll_cd (cd_id, c_id) VALUES(5,4)
SELECT * FROM dual;

INSERT ALL
	INTO coll_movie (m_id, c_id) VALUES(1,1)
	INTO coll_movie (m_id, c_id) VALUES(4,1)
	INTO coll_movie (m_id, c_id) VALUES(2,2)
	INTO coll_movie (m_id, c_id) VALUES(1,2)
	INTO coll_movie (m_id, c_id) VALUES(5,3)
	INTO coll_movie (m_id, c_id) VALUES(3,3)
	INTO coll_movie (m_id, c_id) VALUES(1,4)
	INTO coll_movie (m_id, c_id) VALUES(2,4)
	INTO coll_movie (m_id, c_id) VALUES(3,4)
SELECT * FROM dual;

COMMIT;


select c.c_name, b.title, cd.title, m.title
from collections c, books b, cds cd, movies m, coll_book colb, coll_cd colc, coll_movie colm
where c.id = 1 and
      c.id = colb.c_id and colb.book_id = b.id and
      c.id = colc.c_id and colc.cd_id = cd.id and
      c.id = colm.m_id and colm.m_id = m.id; 


select c.c_name, b.title
from collections c, books b, coll_book colb
where c.id = 1 and c.id = colb.c_id and colb.book_id = b.id;