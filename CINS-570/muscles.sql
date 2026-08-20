--script to create the tables

-- Drop everything
EXECUTE DROP_ALL_VIEWS;

DROP TABLE coll_movie;
DROP TRIGGER trg_coll_movie;
DROP SEQUENCE sq_coll_movie;

DROP TABLE coll_cd;
DROP SEQUENCE sq_coll_cd;
DROP TRIGGER trg_coll_cd;

DROP TABLE coll_book;
DROP SEQUENCE sq_coll_book;
DROP TRIGGER trg_coll_book;

DROP TABLE collections;
DROP SEQUENCE sq_collections;
DROP TRIGGER trg_collections;

DROP TABLE users; 
DROP SEQUENCE sq_users;
DROP TRIGGER trg_users;

DROP TABLE books;
DROP SEQUENCE sq_books;
DROP TRIGGER trg_books;

DROP TABLE cds;
DROP SEQUENCE sq_cds;
DROP TRIGGER trg_cds;

DROP TABLE movies;
DROP SEQUENCE sq_movies;
DROP TRIGGER trg_movies;

----------------------------------------------------------------------
--Create Procedures and Triggers
--Procedure to drop all views from DB
CREATE OR REPLACE PROCEDURE DROP_ALL_VIEWS AS 
BEGIN
  FOR i IN (SELECT view_name FROM user_views) 
  LOOP 
    EXECUTE IMMEDIATE('DROP VIEW ' || user || '.' || i.view_name); 
  END LOOP;
END DROP_ALL_VIEWS;
/


-- dynamicall creates a view displaying the total number of books, cds,
-- and movies in a given collection.  The parameter is the id of the collection
CREATE OR REPLACE PROCEDURE PROC_MAKE_TOT_VIEW 
(
  PARAM1 IN NUMBER 
) AS 
    sql_stmt VARCHAR2(1000);
  BEGIN
  sql_stmt := 'CREATE OR REPLACE VIEW coll_enum_'||PARAM1||' (total) AS
               SELECT COUNT(b.title) AS total
               FROM books b, collections c, coll_book clb
               WHERE c.id = ' || PARAM1 || 'AND c.id = clb.c_id AND
                     clb.book_id = b.id
               UNION ALL
               SELECT COUNT(cd.title) 
               FROM cds cd, collections c, coll_cd clcd
               WHERE c.id = ' || PARAM1 || ' AND c.id = clcd.c_id AND
                     clcd.cd_id = cd.id
               UNION ALL
               SELECT COUNT(m.title)
               FROM movies m, collections c, coll_movie clm
               WHERE c.id = ' || PARAM1 || ' AND c.id = clm.c_id AND
                     clm.m_id = m.id';
    EXECUTE IMMEDIATE sql_stmt;
END PROC_MAKE_TOT_VIEW;
/

--Trigger to create a view every time a new collection is created
CREATE OR REPLACE TRIGGER TRG_MAKE_TOT_VIEW_COLL 
AFTER INSERT ON COLLECTIONS 
DECLARE 
  v_cid collections.id%TYPE;
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  SELECT id INTO v_cid FROM collections
  WHERE id = ( SELECT MAX(id) FROM collections);
  proc_make_tot_view(v_cid);
  COMMIT;
END;
/

--------------------------------------------------------------------------
-- Create the tables, sequences, and triggers
CREATE TABLE users(
	id number(10) PRIMARY KEY, 
	fname varchar2(255) NOT NULL,
	lname varchar2(255) NOT NULL,
	u_name varchar2(255) not null,
  	p_word varchar2(255) not null,
  	email varchar2(255),
	age number(2) NOT NULL,
	quote varchar2(255)
);

CREATE SEQUENCE sq_users START WITH 1 INCREMENT BY 1 NOMAXVALUE;

CREATE OR REPLACE TRIGGER trg_users
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
	SELECT sq_users.nextval 
	INTO :new.id 
	FROM dual;
END;
/



----------------------------------------------------------------------
CREATE TABLE collections(
	id number(10) PRIMARY KEY, 
	u_id number REFERENCES users (id),
	c_name varchar2(255) NOT NULL,
	c_desc varchar2(255),	
	adult char check (adult in (0,1)) NOT NULL
);

CREATE SEQUENCE sq_collections START WITH 1 INCREMENT BY 1 NOMAXVALUE;

CREATE OR REPLACE TRIGGER trg_collections
BEFORE INSERT ON collections
FOR EACH ROW
BEGIN
	SELECT sq_collections.nextval 
	INTO :new.id 
	FROM dual;
END;
/


----------------------------------------------------------------------
CREATE TABLE books(
	id number(10) PRIMARY KEY,
	title varchar2(255) NOT NULL,
	auth varchar2(255) NOT NULL,
	isbn varchar2(255),
	adult char check (adult in (0,1)) NOT NULL
);


CREATE SEQUENCE sq_books START WITH 1 INCREMENT BY 1 NOMAXVALUE;

CREATE OR REPLACE TRIGGER trg_books
BEFORE INSERT ON books
FOR EACH ROW
BEGIN
	SELECT sq_books.nextval 
	INTO :new.id 
	FROM dual;
END;
/



-----------------------------------------------------------------------
CREATE TABLE coll_book(
	id number(10) PRIMARY KEY,
	book_id REFERENCES books (id),
	c_id REFERENCES collections (id)
);

CREATE SEQUENCE sq_coll_book START WITH 1 INCREMENT BY 1 NOMAXVALUE;

CREATE OR REPLACE TRIGGER trg_coll_book
BEFORE INSERT ON coll_book
FOR EACH ROW
BEGIN
	SELECT sq_coll_book.nextval 
	INTO :new.id 
	FROM dual;
END;
/




-----------------------------------------------------------------------
CREATE TABLE movies(
	id number(10) PRIMARY KEY,
	title varchar2(255) NOT NULL,
	rating varchar(5) NOT NULL,
	format varchar2(255) NOT NULL,
	sumry varchar2(255),
	adult char check (adult in (0,1)) NOT NULL
);

CREATE SEQUENCE sq_movies START WITH 1 INCREMENT BY 1 NOMAXVALUE;

CREATE OR REPLACE TRIGGER trg_movies
BEFORE INSERT ON movies
FOR EACH ROW
BEGIN
	SELECT sq_movies.nextval 
	INTO :new.id 
	FROM dual;
END;
/


-----------------------------------------------------------------------
CREATE TABLE coll_movie(
	id number(10) PRIMARY KEY,
	m_id REFERENCES movies (id),
	c_id REFERENCES collections (id)
);

CREATE SEQUENCE sq_coll_movie START WITH 1 INCREMENT BY 1 NOMAXVALUE;

CREATE OR REPLACE TRIGGER trg_coll_movie
BEFORE INSERT ON coll_movie
FOR EACH ROW
BEGIN
	SELECT sq_coll_movie.nextval 
	INTO :new.id 
	FROM dual;
END;
/


------------------------------------------------------------------------
CREATE TABLE cds(
	id number(10) PRIMARY KEY,
	title varchar2(255) NOT NULL,
	artist varchar2(255) NOT NULL,
	genre varchar2(255),
	adult char check (adult in (0,1)) NOT NULL
);

CREATE SEQUENCE sq_cds START WITH 1 INCREMENT BY 1 NOMAXVALUE;

CREATE OR REPLACE TRIGGER trg_cds
BEFORE INSERT ON cds
FOR EACH ROW
BEGIN
	SELECT sq_cds.nextval 
	INTO :new.id 
	FROM dual;
END;
/


------------------------------------------------------------------------
CREATE TABLE coll_cd(
	id number(10) PRIMARY KEY,
	cd_id REFERENCES cds (id),
	c_id REFERENCES collections (id)
);

CREATE SEQUENCE sq_coll_cd START WITH 1 INCREMENT BY 1 NOMAXVALUE;

CREATE OR REPLACE TRIGGER trg_coll_cd
BEFORE INSERT ON coll_cd
FOR EACH ROW
BEGIN
	SELECT sq_coll_cd.nextval 
	INTO :new.id 
	FROM dual;
END;
/

-- This is important
COMMIT;