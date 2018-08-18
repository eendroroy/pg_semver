CREATE TYPE ver;

CREATE FUNCTION ver_in(cstring)   RETURNS ver     AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION ver_out(ver)      RETURNS cstring AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE ver (INPUT = ver_in, OUTPUT = ver_out, LIKE = TEXT);

CREATE CAST (text as ver) WITHOUT FUNCTION AS IMPLICIT;
CREATE CAST (ver as text) WITHOUT FUNCTION AS IMPLICIT;

CREATE FUNCTION ver_cmp(ver, ver) RETURNS int AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;


CREATE FUNCTION ver_eq(ver, ver) RETURNS boolean AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION ver_ne(ver, ver) RETURNS boolean AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION ver_lt(ver, ver) RETURNS boolean AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION ver_le(ver, ver) RETURNS boolean AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION ver_gt(ver, ver) RETURNS boolean AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION ver_ge(ver, ver) RETURNS boolean AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION hash_ver(ver) RETURNS int LANGUAGE internal IMMUTABLE AS 'hashtext';

CREATE OPERATOR = (
  LEFTARG = ver,
  RIGHTARG = ver,
  PROCEDURE = ver_eq,
  COMMUTATOR = '=',
  NEGATOR = '<>',
  RESTRICT = eqsel,
  JOIN = eqjoinsel,
  HASHES, MERGES
);

CREATE OPERATOR <> (
  LEFTARG = ver,
  RIGHTARG = ver,
  PROCEDURE = ver_ne,
  COMMUTATOR = '<>',
  NEGATOR = '=',
  RESTRICT = neqsel,
  JOIN = neqjoinsel
);

CREATE OPERATOR < (
  LEFTARG = ver,
  RIGHTARG = ver,
  PROCEDURE = ver_lt,
  COMMUTATOR = > ,
  NEGATOR = >= ,
  RESTRICT = scalarltsel,
  JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
  LEFTARG = ver,
  RIGHTARG = ver,
  PROCEDURE = ver_le,
  COMMUTATOR = >= ,
  NEGATOR = > ,
  RESTRICT = scalarltsel,
  JOIN = scalarltjoinsel
);

CREATE OPERATOR > (
  LEFTARG = ver,
  RIGHTARG = ver,
  PROCEDURE = ver_gt,
  COMMUTATOR = < ,
  NEGATOR = <= ,
  RESTRICT = scalargtsel,
  JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
  LEFTARG = ver,
  RIGHTARG = ver,
  PROCEDURE = ver_ge,
  COMMUTATOR = <= ,
  NEGATOR = < ,
  RESTRICT = scalargtsel,
  JOIN = scalargtjoinsel
);

CREATE OPERATOR CLASS btree_ver_ops
DEFAULT FOR TYPE ver USING btree
AS
        OPERATOR        1       <  ,
        OPERATOR        2       <= ,
        OPERATOR        3       =  ,
        OPERATOR        4       >= ,
        OPERATOR        5       >  ,
        FUNCTION        1       ver_cmp(ver, ver);

CREATE OPERATOR CLASS hash_ver_ops
    DEFAULT FOR TYPE ver USING hash AS
        OPERATOR        1       = ,
        FUNCTION        1       hash_ver(ver);
