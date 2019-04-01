LOAD 'pg_semver';

CREATE TABLE versions(version SEMVER);

INSERT INTO versions VALUES ('0');
INSERT INTO versions VALUES ('0.0');
INSERT INTO versions VALUES ('0.1');
INSERT INTO versions VALUES ('0.0.0');
INSERT INTO versions VALUES ('0.0.1');
INSERT INTO versions VALUES ('0.0.1-alpha.1');
INSERT INTO versions VALUES ('0.0.1-beta.1');
INSERT INTO versions VALUES ('0.0.1-rc.1');



INSERT INTO versions VALUES ('!0');
INSERT INTO versions VALUES ('@0.0');
INSERT INTO versions VALUES ('0.#1');
INSERT INTO versions VALUES ('0.0.%0');
INSERT INTO versions VALUES ('0.0.1');
INSERT INTO versions VALUES ('0.&0.1-alpha.0');

SELECT * FROM versions;

DROP TABLE IF EXISTS versions;
