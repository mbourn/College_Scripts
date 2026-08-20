create or replace TRIGGER trg_books
BEFORE INSERT ON books
FOR EACH ROW
BEGIN
	SELECT sq_books.nextval 
	INTO :new.id 
	FROM dual;
END;

create or replace TRIGGER trg_cds
BEFORE INSERT ON cds
FOR EACH ROW
BEGIN
	SELECT sq_cds.nextval 
	INTO :new.id 
	FROM dual;
END;

create or replace TRIGGER trg_coll_book
BEFORE INSERT ON coll_book
FOR EACH ROW
BEGIN
	SELECT sq_coll_book.nextval 
	INTO :new.id 
	FROM dual;
END;

create or replace TRIGGER trg_coll_cd
BEFORE INSERT ON coll_cd
FOR EACH ROW
BEGIN
	SELECT sq_coll_cd.nextval 
	INTO :new.id 
	FROM dual;
END;

create or replace TRIGGER trg_coll_movie
BEFORE INSERT ON coll_movie
FOR EACH ROW
BEGIN
	SELECT sq_coll_movie.nextval 
	INTO :new.id 
	FROM dual;
END;

create or replace TRIGGER trg_collections
BEFORE INSERT ON collections
FOR EACH ROW
BEGIN
	SELECT sq_collections.nextval 
	INTO :new.id 
	FROM dual;
END;


create or replace TRIGGER trg_movies
BEFORE INSERT ON movies
FOR EACH ROW
BEGIN
	SELECT sq_movies.nextval 
	INTO :new.id 
	FROM dual;
END;

create or replace TRIGGER trg_users
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
	SELECT sq_users.nextval 
	INTO :new.id 
	FROM dual;
END;

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


-- When a collection is deleted, this calls a procedure to first 
-- remove all references to that collection from the collection
-- subtables
CREATE OR REPLACE TRIGGER TRG_RMV_COLL_ITMS 
BEFORE DELETE ON COLLECTIONS 
FOR EACH ROW
DECLARE
    v_c_id number;
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    v_c_id := :old.id;
  proc_del_col_refs(v_c_id);
  COMMIT;
END;