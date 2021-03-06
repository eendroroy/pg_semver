LOAD 'pg_semver';

CREATE TABLE versions(version SEMVER);

INSERT INTO versions VALUES ('1.0.0'), ('0.0.0'), ('1.1.0'), ('1.2.0'), ('1.23.0'), ('1.23.9'), ('2.9.0'), ('2.0.12'),
                            ('2.0.0-alpha.0'), ('3.0.1'), ('3.0.2'), ('3.0.4-beta.2'), ('3.0.4-alpha.0'),
                            ('3.0.4-rc.1'), ('1.5.0'), ('1.05.0'), ('1.005.0');


SELECT * FROM versions;
SELECT * FROM versions ORDER BY version;
SELECT * FROM versions ORDER BY version DESC;

DROP TABLE IF EXISTS versions;
