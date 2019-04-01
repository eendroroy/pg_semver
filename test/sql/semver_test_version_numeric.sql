LOAD 'pg_semver';

SELECT PG_SEMVER_TO_INT('0.0.0') AS v_to_i;
SELECT PG_SEMVER_TO_INT('0.0.1') AS v_to_i;
SELECT PG_SEMVER_TO_INT('0.0.2') AS v_to_i;

SELECT '0.0.0'::SEMVER::INT AS v_to_i;
SELECT '0.0.1'::SEMVER::INT AS v_to_i;
SELECT '0.0.2'::SEMVER::INT AS v_to_i;

CREATE TABLE versions(version SEMVER);

INSERT INTO versions VALUES ('0.0.0'), ('0.0.1'), ('0.0.2'), ('0.0.3'), ('1.2.3'), ('1.0.0'), ('1.0.0-alpha.0'),
                            ('1.0.0-alpha.1'), ('1.0.0-alpha.2'), ('1.0.0-beta.0'), ('1.0.0-pre.1'), ('1.0.0-rc.1');

SELECT version, version::INT AS v_to_i FROM versions;

DROP TABLE IF EXISTS versions;
