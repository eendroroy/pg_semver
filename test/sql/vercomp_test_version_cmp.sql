LOAD 'vercomp';

SELECT VERSION_CMP('0.0.0', '0.0.1');
SELECT VERSION_CMP('0.0.1', '0.0.1');
SELECT VERSION_CMP('0.0.2', '0.0.1');

SELECT VERSION_CMP('1.0.0-alpha.1', '1.0.0-alpha.0');
SELECT VERSION_CMP('1.0.0-alpha.1', '1.0.0-alpha.2');
SELECT VERSION_CMP('1.0.0-alpha.1', '1.0.0-beta.2');
SELECT VERSION_CMP('1.0.0-rc.1', '1.0.0');

SELECT VERSION_CMP('1.0.0-rc.1*', '1.0.0');
SELECT VERSION_CMP('1.0.0-rc.@1', '1.0.0');
SELECT VERSION_CMP('1.0.0-rc.#1', '1.0.0');
