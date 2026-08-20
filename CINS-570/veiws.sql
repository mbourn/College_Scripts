CREATE OR REPLACE TRIGGER make_views_after_insert
AFTER INSERT ON users
DECLARE
  v_uid users.id%TYPE;
BEGIN
  BEGIN
    SELECT id INTO v_uid
      FROM users
      WHERE id = (SELECT MAX(id) FROM users);
      dbms_output.put_line(v_uid);
  END;
  BEGIN
    CREATE OR REPLACE VIEW tot_view_user_||v_uid
    AS
    create view coll_enum  (total) as
    select count(b.title) as total
    from books b, collections c, coll_book clb
    where c.id = 2 and c.id = clb.c_id and clb.book_id = b.id
    union all
    select count(cd.title) 
    from cds cd, collections c, coll_cd clcd
    where c.id = 2 and c.id = clcd.c_id and clcd.cd_id = cd.id
    union all
    select count(m.title)
    from movies m, collections c, coll_movie clm
    where c.id = 2 and c.id = clm.c_id and  clm.m_id = m.id;
  END;
END;
/



