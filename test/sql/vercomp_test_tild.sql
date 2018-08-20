LOAD 'vercomp';

CREATE TABLE versions(version VERSION);

INSERT INTO versions VALUES ('0.0.1'), ('0.0.4'), ('0.0.5'), ('0.0.10'),
                            ('0.2.1'), ('0.3.4'), ('0.5.5'), ('0.10.10'),
                            ('1.2.1'), ('2.3.4'), ('6.5.5'), ('10.10.10');

SELECT * FROM versions WHERE version ~  '1.1.1';
SELECT * FROM versions WHERE version !~ '1.1.1';

SELECT * FROM versions WHERE version ~  '0.1.1';
SELECT * FROM versions WHERE version !~ '0.1.1';

SELECT * FROM versions WHERE version ~  '0.0.1';
SELECT * FROM versions WHERE version !~ '0.0.1';

DROP TABLE IF EXISTS versions;
