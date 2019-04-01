#include "postgres.h"
#include "fmgr.h"
#include "utils/builtins.h"

#include "semver.c/semver.h"
#include "semver.c/semver.c"

#define ERR_INVALID_VERSION "Invalid Semver '%s'."
#define ERR_INVALID_VERSION_MSG "Semver '%s' contains invalid character."
#define ERR_INVALID_VERSION_HINT "Did you mean '%s'?"

#define ERR_INVALID_BUMP "Invalid bump number '%d'."
#define ERR_INVALID_BUMP_MSG "Bump number should be between 0 and 2."
#define ERR_INVALID_BUMP_HINT "Use bump number between 0 and 2."

PG_MODULE_MAGIC;

bool pg_semver_op(char *v1, char *v2, char *operator);

bool pg_semver_op(char *v1, char *v2, char *operator) {
    bool resolution;
    semver_t v_1 = {};
    semver_t v_2 = {};
    semver_parse(v1, &v_1);
    semver_parse(v2, &v_2);
    resolution = semver_satisfies(v_1, v_2, operator);
    semver_free(&v_1);
    semver_free(&v_2);
    return resolution;
}


PG_FUNCTION_INFO_V1(pg_semver_in);
Datum pg_semver_in(PG_FUNCTION_ARGS) {
    char vc[1000];
    char *v1 = PG_GETARG_CSTRING(0);
    text *t = cstring_to_text(v1);
    if (!semver_is_valid(v1)) {
        strcpy(vc, v1);
        semver_clean(vc);
        ereport(ERROR,
            (
                errcode(ERRCODE_INVALID_PARAMETER_VALUE),
                errmsg(ERR_INVALID_VERSION , v1),
                errdetail(ERR_INVALID_VERSION_MSG, v1),
                errhint(ERR_INVALID_VERSION_HINT, vc)
            )
        );
    }
    PG_RETURN_CSTRING(t);
}

PG_FUNCTION_INFO_V1(pg_semver_out);
Datum pg_semver_out(PG_FUNCTION_ARGS) {
    char *v1, vc[1000];
    text *t = PG_GETARG_TEXT_PP(0);
    v1 = text_to_cstring(t);
    if (!semver_is_valid(v1)) {
        strcpy(vc, v1);
        semver_clean(vc);
        ereport(ERROR,
            (
                errcode(ERRCODE_INVALID_PARAMETER_VALUE),
                errmsg(ERR_INVALID_VERSION , v1),
                errdetail(ERR_INVALID_VERSION_MSG, v1),
                errhint(ERR_INVALID_VERSION_HINT, vc)
            )
        );
    }
    PG_RETURN_CSTRING(v1);
}

PG_FUNCTION_INFO_V1(pg_semver_cmp);
Datum pg_semver_cmp(PG_FUNCTION_ARGS) {
    int resolution;
    char *v1, *v2, vc1[1000], vc2[1000];
    semver_t v_1 = {};
    semver_t v_2 = {};
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    if (!semver_is_valid(v1)) {
        strcpy(vc1, v1);
        semver_clean(vc1);
        ereport(ERROR,
            (
                errcode(ERRCODE_INVALID_PARAMETER_VALUE),
                errmsg(ERR_INVALID_VERSION , v1),
                errdetail(ERR_INVALID_VERSION_MSG, v1),
                errhint(ERR_INVALID_VERSION_HINT, vc1)
            )
        );
    }

    if (!semver_is_valid(v2)) {
        strcpy(vc2, v2);
        semver_clean(vc2);
        ereport(ERROR,
            (
                errcode(ERRCODE_INVALID_PARAMETER_VALUE),
                errmsg(ERR_INVALID_VERSION , v2),
                errdetail(ERR_INVALID_VERSION_MSG, v2),
                errhint(ERR_INVALID_VERSION_HINT, vc2)
            )
        );
    }

    semver_parse(v1, &v_1);
    semver_parse(v2, &v_2);
    resolution = semver_compare(v_1, v_2);
    semver_free(&v_1);
    semver_free(&v_2);

    PG_RETURN_INT32((int32)resolution);
}

PG_FUNCTION_INFO_V1(pg_semver_bump);
Datum pg_semver_bump(PG_FUNCTION_ARGS) {
    char *v1, vc[1000], v2[1000] = {0};
    semver_t v_1 = {};
    text *t1 = PG_GETARG_TEXT_PP(0);
    int32 type = PG_GETARG_INT32(1);

    v1 = text_to_cstring(t1);

    if (!semver_is_valid(v1)) {
        strcpy(vc, v1);
        semver_clean(vc);
        ereport(ERROR,
            (
                errcode(ERRCODE_INVALID_PARAMETER_VALUE),
                errmsg(ERR_INVALID_VERSION , v1),
                errdetail(ERR_INVALID_VERSION_MSG, v1),
                errhint(ERR_INVALID_VERSION_HINT, vc)
            )
        );
    }

    semver_parse(v1, &v_1);
    if (type == 0) {
        semver_bump(&v_1);
        semver_render(&v_1, v2);
        semver_free(&v_1);
    } else if (type == 1) {
        semver_bump_minor(&v_1);
        semver_render(&v_1, v2);
        semver_free(&v_1);
    } else if (type == 2) {
        semver_bump_patch(&v_1);
        semver_render(&v_1, v2);
        semver_free(&v_1);
    } else {
        ereport(ERROR,
            (
                errcode(ERRCODE_INVALID_PARAMETER_VALUE),
                errmsg(ERR_INVALID_BUMP , type),
                errdetail(ERR_INVALID_BUMP_MSG),
                errhint(ERR_INVALID_BUMP_HINT)
            )
        );
    }

    PG_RETURN_CSTRING(cstring_to_text(v2));
}
PG_FUNCTION_INFO_V1(pg_semver_to_int);
Datum pg_semver_to_int(PG_FUNCTION_ARGS) {
    int numeric;
    char *v1, vc[1000];
    semver_t v_1 = {};
    text *t1 = PG_GETARG_TEXT_PP(0);

    v1 = text_to_cstring(t1);

    if (!semver_is_valid(v1)) {
        strcpy(vc, v1);
        semver_clean(vc);
        ereport(ERROR,
            (
                errcode(ERRCODE_INVALID_PARAMETER_VALUE),
                errmsg(ERR_INVALID_VERSION , v1),
                errdetail(ERR_INVALID_VERSION_MSG, v1),
                errhint(ERR_INVALID_VERSION_HINT, vc)
            )
        );
    }

    semver_parse(v1, &v_1);
    numeric = semver_numeric(&v_1);
    semver_free(&v_1);

    PG_RETURN_INT32((int32)numeric);
}

PG_FUNCTION_INFO_V1(pg_semver_eq);
Datum pg_semver_eq(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(pg_semver_op(v1, v2, "="));
}

PG_FUNCTION_INFO_V1(pg_semver_ne);
Datum pg_semver_ne(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(!pg_semver_op(v1, v2, "="));
}

PG_FUNCTION_INFO_V1(pg_semver_lt);
Datum pg_semver_lt(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(pg_semver_op(v1, v2, "<"));
}

PG_FUNCTION_INFO_V1(pg_semver_le);
Datum pg_semver_le(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(pg_semver_op(v1, v2, "<="));
}

PG_FUNCTION_INFO_V1(pg_semver_gt);
Datum pg_semver_gt(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(pg_semver_op(v1, v2, ">"));
}

PG_FUNCTION_INFO_V1(pg_semver_ge);
Datum pg_semver_ge(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(pg_semver_op(v1, v2, ">="));
}

PG_FUNCTION_INFO_V1(pg_semver_sat);
Datum pg_semver_sat(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(pg_semver_op(v1, v2, "~"));
}

PG_FUNCTION_INFO_V1(pg_semver_nsat);
Datum pg_semver_nsat(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(!pg_semver_op(v1, v2, "~"));
}


PG_FUNCTION_INFO_V1(pg_semver_car);
Datum pg_semver_car(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(pg_semver_op(v2, v1, "^"));
}

PG_FUNCTION_INFO_V1(pg_semver_ncar);
Datum pg_semver_ncar(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(!pg_semver_op(v2, v1, "^"));
}
