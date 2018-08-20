CREATE TYPE version;

CREATE FUNCTION version_in(cstring)  RETURNS version AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION version_out(version) RETURNS cstring AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE version (INPUT = version_in, OUTPUT = version_out, LIKE = TEXT);

CREATE CAST (text as version) WITHOUT FUNCTION AS IMPLICIT;
CREATE CAST (version as text) WITHOUT FUNCTION AS IMPLICIT;

CREATE FUNCTION version_cmp(version, version) RETURNS int AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;


CREATE FUNCTION version_eq(version, version)   RETURNS boolean AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION version_ne(version, version)   RETURNS boolean AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION version_lt(version, version)   RETURNS boolean AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION version_le(version, version)   RETURNS boolean AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION version_gt(version, version)   RETURNS boolean AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION version_ge(version, version)   RETURNS boolean AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION version_sat(version, version)  RETURNS boolean AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION version_nsat(version, version) RETURNS boolean AS '$libdir/vercomp' LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION hash_ver(version) RETURNS int LANGUAGE internal IMMUTABLE AS 'hashtext';

CREATE OPERATOR = (
  LEFTARG = version,
  RIGHTARG = version,
  PROCEDURE = version_eq,
  COMMUTATOR = '=',
  NEGATOR = '<>',
  RESTRICT = eqsel,
  JOIN = eqjoinsel,
  HASHES, MERGES
);

CREATE OPERATOR <> (
  LEFTARG = version,
  RIGHTARG = version,
  PROCEDURE = version_ne,
  COMMUTATOR = '<>',
  NEGATOR = '=',
  RESTRICT = neqsel,
  JOIN = neqjoinsel
);

CREATE OPERATOR < (
  LEFTARG = version,
  RIGHTARG = version,
  PROCEDURE = version_lt,
  COMMUTATOR = > ,
  NEGATOR = >= ,
  RESTRICT = scalarltsel,
  JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
  LEFTARG = version,
  RIGHTARG = version,
  PROCEDURE = version_le,
  COMMUTATOR = >= ,
  NEGATOR = > ,
  RESTRICT = scalarltsel,
  JOIN = scalarltjoinsel
);

CREATE OPERATOR > (
  LEFTARG = version,
  RIGHTARG = version,
  PROCEDURE = version_gt,
  COMMUTATOR = < ,
  NEGATOR = <= ,
  RESTRICT = scalargtsel,
  JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
  LEFTARG = version,
  RIGHTARG = version,
  PROCEDURE = version_ge,
  COMMUTATOR = <= ,
  NEGATOR = < ,
  RESTRICT = scalargtsel,
  JOIN = scalargtjoinsel
);

CREATE OPERATOR ~ (
  LEFTARG = version,
  RIGHTARG = version,
  PROCEDURE = version_sat,
  COMMUTATOR = ~ ,
  NEGATOR = !~ ,
  RESTRICT = scalargtsel,
  JOIN = scalargtjoinsel
);

CREATE OPERATOR !~ (
  LEFTARG = version,
  RIGHTARG = version,
  PROCEDURE = version_nsat,
  COMMUTATOR = !~ ,
  NEGATOR = ~ ,
  RESTRICT = scalargtsel,
  JOIN = scalargtjoinsel
);

CREATE OPERATOR CLASS btree_ver_ops
DEFAULT FOR TYPE version USING btree
AS
  OPERATOR  1  <  ,
  OPERATOR  2  <= ,
  OPERATOR  3  =  ,
  OPERATOR  4  >= ,
  OPERATOR  5  >  ,
  FUNCTION  1  version_cmp(version, version);

CREATE OPERATOR CLASS hash_ver_ops
  DEFAULT FOR TYPE version USING hash AS
    OPERATOR  1  = ,
    FUNCTION  1  hash_ver(version);
