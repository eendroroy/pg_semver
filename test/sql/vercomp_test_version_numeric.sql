LOAD 'vercomp';

SELECT VERSION_TO_INT('0.0.0') AS v_to_i;
SELECT VERSION_TO_INT('0.0.1') AS v_to_i;
SELECT VERSION_TO_INT('0.0.2') AS v_to_i;

SELECT '0.0.0'::VERSION::INT AS v_to_i;
SELECT '0.0.1'::VERSION::INT AS v_to_i;
SELECT '0.0.2'::VERSION::INT AS v_to_i;

CREATE TABLE versions(version VERSION);

INSERT INTO versions VALUES ('0.0.0'), ('0.0.1'), ('0.0.2'), ('0.0.3'), ('1.2.3'), ('1.0.0'), ('1.0.0-alpha.0'),
                            ('1.0.0-alpha.1'), ('1.0.0-alpha.2'), ('1.0.0-beta'), ('1.0.0-pre'), ('1.0.0-rc');

SELECT version, version::INT AS v_to_i FROM versions;

DROP TABLE IF EXISTS versions;
