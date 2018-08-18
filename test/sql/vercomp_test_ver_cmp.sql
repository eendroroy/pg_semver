LOAD 'vercomp';

SELECT VER_CMP('0.0.0'::VER, '0.0.1'::VER);
SELECT VER_CMP('0.0.1'::VER, '0.0.1'::VER);
SELECT VER_CMP('0.0.2'::VER, '0.0.1'::VER);

SELECT VER_CMP('1.0.0-alpha1'::VER, '1.0.0-alpha0'::VER);
SELECT VER_CMP('1.0.0-alpha1'::VER, '1.0.0-alpha2'::VER);
SELECT VER_CMP('1.0.0-alpha1'::VER, '1.0.0-beta2'::VER);
SELECT VER_CMP('1.0.0-rc1'::VER, '1.0.0'::VER);