LOAD 'pg_semver';

SELECT PG_SEMVER_BUMP('1.1.1', 0);
SELECT PG_SEMVER_BUMP('1.1.1', 1);
SELECT PG_SEMVER_BUMP('1.1.1', 2);

SELECT PG_SEMVER_BUMP('1.1.1-alpha.1', 0);
SELECT PG_SEMVER_BUMP('1.1.1-alpha.1', 1);
SELECT PG_SEMVER_BUMP('1.1.1-alpha.1', 2);

SELECT PG_SEMVER_BUMP('1.1.1-rc1*', 1);
SELECT PG_SEMVER_BUMP('1.1.1', -1);
SELECT PG_SEMVER_BUMP('1.1.1', 3);
