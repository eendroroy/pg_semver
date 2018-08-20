LOAD 'vercomp';

CREATE TABLE versions(version VERSION);

INSERT INTO versions VALUES ('1.0.0'), ('0.0.0'), ('1.1.0'), ('1.2.0'), ('1.23.0'), ('1.23.9'), ('2.9.0'), ('2.0.12'),
                            ('2.0.0-alpha'), ('3.0.1'), ('3.0.2'), ('3.0.4-beta2'), ('3.0.4-alpha'), ('3.0.4-rc1'),
                            ('1.5.0'), ('1.05.0'), ('1.005.0');

SELECT * FROM versions;

DROP TABLE IF EXISTS versions;
