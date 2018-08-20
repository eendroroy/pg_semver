LOAD 'vercomp';

CREATE TABLE versions(version VERSION);

INSERT INTO versions VALUES ('1.0.0'), ('0.0.0'), ('2.5.0-beta1'), ('2.0.0-rc1'),('2.10.0-beta0'), ('20.2.0-alpha'),
                            ('30.0.0'),  ('3.0.0'),  ('3.0.0-rc.2'),  ('3.0.0-rc.0'),  ('3.0.0-b.2'),  ('3.0.0-a.0');


SELECT * FROM versions;
SELECT * FROM versions ORDER BY version;
SELECT * FROM versions ORDER BY version DESC;

DROP TABLE IF EXISTS versions;
