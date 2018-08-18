LOAD 'vercomp';

CREATE TABLE ver_test(version VER);

INSERT INTO ver_test VALUES ('0');
INSERT INTO ver_test VALUES ('0.0');
INSERT INTO ver_test VALUES ('0.1');
INSERT INTO ver_test VALUES ('0.0.0');
INSERT INTO ver_test VALUES ('0.0.1');
INSERT INTO ver_test VALUES ('0.0.1-a');
INSERT INTO ver_test VALUES ('0.0.1-alpha');
INSERT INTO ver_test VALUES ('0.0.1-a.0');
INSERT INTO ver_test VALUES ('0.0.1-a.0.1');
INSERT INTO ver_test VALUES ('0.0.1-alpha.0');
INSERT INTO ver_test VALUES ('0.0.1-alpha.0.1');
INSERT INTO ver_test VALUES ('0.0.1-b');
INSERT INTO ver_test VALUES ('0.0.1-beta');
INSERT INTO ver_test VALUES ('0.0.1-b.0');
INSERT INTO ver_test VALUES ('0.0.1-b.0.1');
INSERT INTO ver_test VALUES ('0.0.1-beta.0');
INSERT INTO ver_test VALUES ('0.0.1-beta.0.1');
INSERT INTO ver_test VALUES ('0.0.1-rc');
INSERT INTO ver_test VALUES ('0.0.1-rc.0');
INSERT INTO ver_test VALUES ('0.0.1-rc.0.1');



INSERT INTO ver_test VALUES ('!0');
INSERT INTO ver_test VALUES ('@0.0');
INSERT INTO ver_test VALUES ('0.#1');
INSERT INTO ver_test VALUES ('0.0.%0');
INSERT INTO ver_test VALUES ('0.0.1');
INSERT INTO ver_test VALUES ('0.0^.1-a');
INSERT INTO ver_test VALUES ('0.&0.1-alpha');
INSERT INTO ver_test VALUES ('0.0.*1-a.0');

SELECT * FROM ver_test;

DROP TABLE IF EXISTS ver_test;
