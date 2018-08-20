LOAD 'vercomp';

CREATE TABLE versions(version VERSION);

INSERT INTO versions VALUES ('1.0.0'), ('0.0.0'), ('2.5.0-beta1'), ('2.0.0-rc1'),('2.10.0-beta0'), ('20.2.0-alpha'),
                            ('30.0.0'), ('3.0.0'), ('3.0.0-rc2'), ('3.0.0-rc0'), ('3.0.0-beta2'), ('3.0.0-alpha0');

SELECT * FROM versions WHERE version =  '1.0.0';
SELECT * FROM versions WHERE version >  '1.0.0';
SELECT * FROM versions WHERE version <  '1.0.0';
SELECT * FROM versions WHERE version <> '1.0.0';

SELECT * FROM versions WHERE version =  '2.0.0-alpha';
SELECT * FROM versions WHERE version >  '2.0.0-alpha';
SELECT * FROM versions WHERE version <  '2.0.0-alpha';
SELECT * FROM versions WHERE version <> '2.0.0-alpha';


SELECT * FROM versions WHERE version > '2.9-beta1';

DROP TABLE IF EXISTS versions;
