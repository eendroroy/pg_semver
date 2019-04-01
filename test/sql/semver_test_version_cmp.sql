LOAD 'pg_semver';

SELECT PG_SEMVER_CMP('0.0.0', '0.0.1');
SELECT PG_SEMVER_CMP('0.0.1', '0.0.1');
SELECT PG_SEMVER_CMP('0.0.2', '0.0.1');

SELECT PG_SEMVER_CMP('1.0.0-alpha.1', '1.0.0-alpha.0');
SELECT PG_SEMVER_CMP('1.0.0-alpha.1', '1.0.0-alpha.2');
SELECT PG_SEMVER_CMP('1.0.0-alpha.1', '1.0.0-beta.2');
SELECT PG_SEMVER_CMP('1.0.0-rc.1', '1.0.0');

SELECT PG_SEMVER_CMP('1.0.0-rc.1*', '1.0.0');
SELECT PG_SEMVER_CMP('1.0.0-rc.@1', '1.0.0');
SELECT PG_SEMVER_CMP('1.0.0-rc.#1', '1.0.0');
