CREATE TYPE ver;

CREATE FUNCTION ver_in(cstring)   RETURNS ver     AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION ver_out(ver)      RETURNS cstring AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE ver (INPUT = ver_in, OUTPUT = ver_out, LIKE = TEXT);

CREATE CAST (text as ver) WITHOUT FUNCTION AS IMPLICIT;
CREATE CAST (ver as text) WITHOUT FUNCTION AS IMPLICIT;

CREATE FUNCTION ver_cmp(cstring, cstring) RETURNS int AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
