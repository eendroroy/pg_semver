LOAD 'vercomp';

CREATE TABLE versions(version VERSION);

INSERT INTO versions VALUES ('0');
INSERT INTO versions VALUES ('0.0');
INSERT INTO versions VALUES ('0.1');
INSERT INTO versions VALUES ('0.0.0');
INSERT INTO versions VALUES ('0.0.1');
INSERT INTO versions VALUES ('0.0.1-alpha1');
INSERT INTO versions VALUES ('0.0.1-beta1');
INSERT INTO versions VALUES ('0.0.1-rc1');



INSERT INTO versions VALUES ('!0');
INSERT INTO versions VALUES ('@0.0');
INSERT INTO versions VALUES ('0.#1');
INSERT INTO versions VALUES ('0.0.%0');
INSERT INTO versions VALUES ('0.0.1');
INSERT INTO versions VALUES ('0.&0.1-alpha');

SELECT * FROM versions;

DROP TABLE IF EXISTS versions;
