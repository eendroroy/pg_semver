#include "postgres.h"
#include "fmgr.h"
#include "utils/builtins.h"

#include "semver.c/semver.h"
#include "semver.c/semver.c"

#define ERR_INVALID_PARAMETER "Invalid Version '%s'."
#define ERR_INVALID_PARAMETER_MSG "Version '%s' contains invalid character."
#define ERR_INVALID_PARAMETER_HINT "Did you mean '%s'?"

PG_MODULE_MAGIC;

bool version_op(char *v1, char *v2, char *operator);

bool version_op(char *v1, char *v2, char *operator) {
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


PG_FUNCTION_INFO_V1(version_in);
Datum version_in(PG_FUNCTION_ARGS) {
    char vc[1000];
    char *v1 = PG_GETARG_CSTRING(0);
    text *t = cstring_to_text(v1);
    if (!semver_is_valid(v1)) {
        strcpy(vc, v1);
        semver_clean(vc);
        ereport(ERROR,
            (
                errcode(ERRCODE_INVALID_PARAMETER_VALUE),
                errmsg(ERR_INVALID_PARAMETER , v1),
                errdetail(ERR_INVALID_PARAMETER_MSG, v1),
                errhint(ERR_INVALID_PARAMETER_HINT, vc)
            )
        );
    }
    PG_RETURN_CSTRING(t);
}

PG_FUNCTION_INFO_V1(version_out);
Datum version_out(PG_FUNCTION_ARGS) {
    char *v1, vc[1000];
    text *t = PG_GETARG_TEXT_PP(0);
    v1 = text_to_cstring(t);
    if (!semver_is_valid(v1)) {
        strcpy(vc, v1);
        semver_clean(vc);
        ereport(ERROR,
            (
                errcode(ERRCODE_INVALID_PARAMETER_VALUE),
                errmsg(ERR_INVALID_PARAMETER , v1),
                errdetail(ERR_INVALID_PARAMETER_MSG, v1),
                errhint(ERR_INVALID_PARAMETER_HINT, vc)
            )
        );
    }
    PG_RETURN_CSTRING(v1);
}

PG_FUNCTION_INFO_V1(version_cmp);
Datum version_cmp(PG_FUNCTION_ARGS) {
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
                errmsg(ERR_INVALID_PARAMETER , v1),
                errdetail(ERR_INVALID_PARAMETER_MSG, v1),
                errhint(ERR_INVALID_PARAMETER_HINT, vc1)
            )
        );
    }

    if (!semver_is_valid(v2)) {
        strcpy(vc2, v2);
        semver_clean(vc2);
        ereport(ERROR,
            (
                errcode(ERRCODE_INVALID_PARAMETER_VALUE),
                errmsg(ERR_INVALID_PARAMETER , v2),
                errdetail(ERR_INVALID_PARAMETER_MSG, v2),
                errhint(ERR_INVALID_PARAMETER_HINT, vc2)
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

PG_FUNCTION_INFO_V1(version_eq);
Datum version_eq(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(version_op(v1, v2, "="));
}

PG_FUNCTION_INFO_V1(version_ne);
Datum version_ne(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(!version_op(v1, v2, "="));
}

PG_FUNCTION_INFO_V1(version_lt);
Datum version_lt(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(version_op(v1, v2, "<"));
}

PG_FUNCTION_INFO_V1(version_le);
Datum version_le(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(version_op(v1, v2, "<="));
}

PG_FUNCTION_INFO_V1(version_gt);
Datum version_gt(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(version_op(v1, v2, ">"));
}

PG_FUNCTION_INFO_V1(version_ge);
Datum version_ge(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(version_op(v1, v2, ">="));
}

PG_FUNCTION_INFO_V1(version_sat);
Datum version_sat(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(version_op(v1, v2, "~"));
}

PG_FUNCTION_INFO_V1(version_nsat);
Datum version_nsat(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(!version_op(v1, v2, "~"));
}


PG_FUNCTION_INFO_V1(version_car);
Datum version_car(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(version_op(v2, v1, "^"));
}

PG_FUNCTION_INFO_V1(version_ncar);
Datum version_ncar(PG_FUNCTION_ARGS) {
    char *v1, *v2;
    text *t1 = PG_GETARG_TEXT_PP(0);
    text *t2 = PG_GETARG_TEXT_PP(1);

    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);

    PG_RETURN_BOOL(!version_op(v2, v1, "^"));
}
