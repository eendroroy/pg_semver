LOAD 'vercomp';

CREATE TABLE versions(version VERSION);

INSERT INTO versions VALUES ('0');
INSERT INTO versions VALUES ('0.0');
INSERT INTO versions VALUES ('0.1');
INSERT INTO versions VALUES ('0.0.0');
INSERT INTO versions VALUES ('0.0.1');
INSERT INTO versions VALUES ('0.0.1-a');
INSERT INTO versions VALUES ('0.0.1-alpha');
INSERT INTO versions VALUES ('0.0.1-a.0');
INSERT INTO versions VALUES ('0.0.1-a.0.1');
INSERT INTO versions VALUES ('0.0.1-alpha.0');
INSERT INTO versions VALUES ('0.0.1-alpha.0.1');
INSERT INTO versions VALUES ('0.0.1-b');
INSERT INTO versions VALUES ('0.0.1-beta');
INSERT INTO versions VALUES ('0.0.1-b.0');
INSERT INTO versions VALUES ('0.0.1-b.0.1');
INSERT INTO versions VALUES ('0.0.1-beta.0');
INSERT INTO versions VALUES ('0.0.1-beta.0.1');
INSERT INTO versions VALUES ('0.0.1-rc');
INSERT INTO versions VALUES ('0.0.1-rc.0');
INSERT INTO versions VALUES ('0.0.1-rc.0.1');



INSERT INTO versions VALUES ('!0');
INSERT INTO versions VALUES ('@0.0');
INSERT INTO versions VALUES ('0.#1');
INSERT INTO versions VALUES ('0.0.%0');
INSERT INTO versions VALUES ('0.0.1');
INSERT INTO versions VALUES ('0.0^.1-a');
INSERT INTO versions VALUES ('0.&0.1-alpha');
INSERT INTO versions VALUES ('0.0.*1-a.0');

SELECT * FROM versions;

DROP TABLE IF EXISTS versions;
