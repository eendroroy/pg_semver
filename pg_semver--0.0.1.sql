CREATE TYPE semver;

CREATE FUNCTION pg_semver_in(cstring)    RETURNS semver  AS '$libdir/pg_semver' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION pg_semver_out(semver)    RETURNS cstring AS '$libdir/pg_semver' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION pg_semver_to_int(semver) RETURNS int     AS '$libdir/pg_semver' LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE semver (INPUT = pg_semver_in, OUTPUT = pg_semver_out, LIKE = TEXT);

CREATE CAST (text as semver) WITHOUT FUNCTION                  AS IMPLICIT;
CREATE CAST (semver as text) WITHOUT FUNCTION                  AS IMPLICIT;
CREATE CAST (semver as int)  WITH    FUNCTION pg_semver_to_int AS IMPLICIT;

CREATE FUNCTION pg_semver_cmp(semver, semver) RETURNS int     AS '$libdir/pg_semver' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION pg_semver_bump(semver, int)   RETURNS semver  AS '$libdir/pg_semver' LANGUAGE C IMMUTABLE STRICT;


CREATE FUNCTION pg_semver_eq(semver, semver)   RETURNS boolean AS '$libdir/pg_semver' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION pg_semver_ne(semver, semver)   RETURNS boolean AS '$libdir/pg_semver' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION pg_semver_lt(semver, semver)   RETURNS boolean AS '$libdir/pg_semver' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION pg_semver_le(semver, semver)   RETURNS boolean AS '$libdir/pg_semver' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION pg_semver_gt(semver, semver)   RETURNS boolean AS '$libdir/pg_semver' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION pg_semver_ge(semver, semver)   RETURNS boolean AS '$libdir/pg_semver' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION pg_semver_sat(semver, semver)  RETURNS boolean AS '$libdir/pg_semver' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION pg_semver_nsat(semver, semver) RETURNS boolean AS '$libdir/pg_semver' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION pg_semver_car(semver, semver)  RETURNS boolean AS '$libdir/pg_semver' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION pg_semver_ncar(semver, semver) RETURNS boolean AS '$libdir/pg_semver' LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION hash_ver(semver) RETURNS int LANGUAGE internal IMMUTABLE AS 'hashtext';

CREATE OPERATOR = (
  LEFTARG = semver, RIGHTARG = semver, PROCEDURE = pg_semver_eq,   COMMUTATOR = =,  NEGATOR = <>,
  RESTRICT = eqsel, JOIN = eqjoinsel, HASHES, MERGES
);

CREATE OPERATOR <> (
  LEFTARG = semver, RIGHTARG = semver, PROCEDURE = pg_semver_ne,   COMMUTATOR = <>, NEGATOR = =,
  RESTRICT = neqsel, JOIN = neqjoinsel
);

CREATE OPERATOR < (
  LEFTARG = semver, RIGHTARG = semver, PROCEDURE = pg_semver_lt,   COMMUTATOR = > ,   NEGATOR = >= ,
  RESTRICT = scalarltsel, JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
  LEFTARG = semver, RIGHTARG = semver, PROCEDURE = pg_semver_le,   COMMUTATOR = >= ,  NEGATOR = > ,
  RESTRICT = scalarltsel, JOIN = scalarltjoinsel
);

CREATE OPERATOR > (
  LEFTARG = semver, RIGHTARG = semver, PROCEDURE = pg_semver_gt,   COMMUTATOR = < ,   NEGATOR = <= ,
  RESTRICT = scalargtsel, JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
  LEFTARG = semver, RIGHTARG = semver, PROCEDURE = pg_semver_ge,   COMMUTATOR = <= ,  NEGATOR = < ,
  RESTRICT = scalargtsel, JOIN = scalargtjoinsel
);

CREATE OPERATOR ~ (
  LEFTARG = semver, RIGHTARG = semver, PROCEDURE = pg_semver_sat,  COMMUTATOR = ~ ,   NEGATOR = !~ ,
  RESTRICT = scalargtsel, JOIN = scalargtjoinsel
);

CREATE OPERATOR !~ (
  LEFTARG = semver, RIGHTARG = semver, PROCEDURE = pg_semver_nsat, COMMUTATOR = !~ ,  NEGATOR = ~ ,
  RESTRICT = scalargtsel, JOIN = scalargtjoinsel
);

CREATE OPERATOR ^ (
  LEFTARG = semver, RIGHTARG = semver, PROCEDURE = pg_semver_car,  COMMUTATOR = ^ ,   NEGATOR = !^ ,
  RESTRICT = scalargtsel, JOIN = scalargtjoinsel
);

CREATE OPERATOR !^ (
  LEFTARG = semver, RIGHTARG = semver, PROCEDURE = pg_semver_ncar, COMMUTATOR = !^ ,  NEGATOR = ^ ,
  RESTRICT = scalargtsel, JOIN = scalargtjoinsel
);

CREATE OPERATOR CLASS btree_ver_ops
DEFAULT FOR TYPE semver USING btree
AS
  OPERATOR  1  <  ,
  OPERATOR  2  <= ,
  OPERATOR  3  =  ,
  OPERATOR  4  >= ,
  OPERATOR  5  >  ,
  FUNCTION  1  pg_semver_cmp(semver, semver);

CREATE OPERATOR CLASS hash_ver_ops
  DEFAULT FOR TYPE semver USING hash AS
    OPERATOR  1  = ,
    FUNCTION  1  hash_ver(semver);
