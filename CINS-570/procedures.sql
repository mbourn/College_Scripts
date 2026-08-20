
--Procedure to drop all views from DB
CREATE OR REPLACE PROCEDURE DROP_ALL_VIEWS AS 
BEGIN
  FOR i IN (SELECT view_name FROM user_views) 
  LOOP 
    EXECUTE IMMEDIATE('DROP VIEW ' || user || '.' || i.view_name); 
  END LOOP;
END DROP_ALL_VIEWS;


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


-- remove all references to the collection whose id is passed as a parameter
CREATE OR REPLACE PROCEDURE PROC_DEL_COL_REFS 
(
  V_C_ID IN VARCHAR2 
) AS 
BEGIN
  DELETE FROM coll_book 
    WHERE c_id = v_c_id;
  DELETE FROM coll_cd
    WHERE c_id = v_c_id;
  DELETE FROM coll_movie
    WHERE c_id = v_c_id;
END PROC_DEL_COL_REFS;