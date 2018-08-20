LOAD 'vercomp';

SELECT VER_CMP('0.0.0', '0.0.1');
SELECT VER_CMP('0.0.1', '0.0.1');
SELECT VER_CMP('0.0.2', '0.0.1');

SELECT VER_CMP('1.0.0-alpha1', '1.0.0-alpha0');
SELECT VER_CMP('1.0.0-alpha1', '1.0.0-alpha2');
SELECT VER_CMP('1.0.0-alpha1', '1.0.0-beta2');
SELECT VER_CMP('1.0.0-rc1', '1.0.0');

SELECT VER_CMP('1.0.0-rc1*', '1.0.0');
SELECT VER_CMP('1.0.0-rc@1', '1.0.0');
SELECT VER_CMP('1.0.0-rc#1', '1.0.0');
