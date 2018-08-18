LOAD 'vercomp';

CREATE TABLE ver_test(version VER);

INSERT INTO ver_test VALUES ('0.0.0'), ('1.0.0'), ('2.0.0-beta1'), ('2.0.0-rc1'),('2.10.0-beta0'), ('2.2.0-alpha'),  ('3.0.0');

SELECT * FROM ver_test WHERE version =  '1.0.0'::VER;
SELECT * FROM ver_test WHERE version >  '1.0.0'::VER;
SELECT * FROM ver_test WHERE version <  '1.0.0'::VER;
SELECT * FROM ver_test WHERE version <> '1.0.0'::VER;

SELECT * FROM ver_test WHERE version =  '2.0.0-alpha'::VER;
SELECT * FROM ver_test WHERE version >  '2.0.0-alpha'::VER;
SELECT * FROM ver_test WHERE version <  '2.0.0-alpha'::VER;
SELECT * FROM ver_test WHERE version <> '2.0.0-alpha'::VER;


SELECT * FROM ver_test WHERE version > '2.9-beta1'::VER;

DROP TABLE IF EXISTS ver_test;