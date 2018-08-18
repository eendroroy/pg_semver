#include "postgres.h"
#include "fmgr.h"
#include "utils/builtins.h"

#include "semver.c/semver.h"
#include "semver.c/semver.c"

PG_MODULE_MAGIC;

bool ver_op(char* v1, char* v2, char* operator);

bool ver_op(char* v1, char* v2, char* operator) {
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


PG_FUNCTION_INFO_V1(ver_in);
Datum ver_in(PG_FUNCTION_ARGS)
{
    char* v1 = PG_GETARG_CSTRING(0);
	text* t = cstring_to_text(v1);
    PG_RETURN_CSTRING(t);
}

PG_FUNCTION_INFO_V1(ver_out);
Datum ver_out(PG_FUNCTION_ARGS)
{
	char *v1 ;
	text *t = PG_GETARG_TEXT_PP(0);
    v1 = text_to_cstring(t);
    PG_RETURN_CSTRING(v1);
}

PG_FUNCTION_INFO_V1(ver_cmp);
Datum ver_cmp(PG_FUNCTION_ARGS)
{
	int resolution;
	char *v1, *v2;
	semver_t v_1 = {};
	semver_t v_2 = {};
	text *t1 = PG_GETARG_TEXT_PP(0);
	text *t2 = PG_GETARG_TEXT_PP(1);
	
    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);
	
    semver_parse(v1, &v_1);
    semver_parse(v2, &v_2);
	resolution = semver_compare(v_1, v_2);
	semver_free(&v_1);
	semver_free(&v_2);
	
    PG_RETURN_INT32((int32)resolution);
}

PG_FUNCTION_INFO_V1(ver_eq);
Datum ver_eq(PG_FUNCTION_ARGS)
{
	char *v1, *v2;
	text *t1 = PG_GETARG_TEXT_PP(0);
	text *t2 = PG_GETARG_TEXT_PP(1);
	
    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);
	
	PG_RETURN_BOOL(ver_op(v1, v2, "="));
}

PG_FUNCTION_INFO_V1(ver_ne);
Datum ver_ne(PG_FUNCTION_ARGS)
{
	char *v1, *v2;
	text *t1 = PG_GETARG_TEXT_PP(0);
	text *t2 = PG_GETARG_TEXT_PP(1);
	
    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);
	
	PG_RETURN_BOOL(!ver_op(v1, v2, "="));
}

PG_FUNCTION_INFO_V1(ver_lt);
Datum ver_lt(PG_FUNCTION_ARGS)
{
	char *v1, *v2;
	text *t1 = PG_GETARG_TEXT_PP(0);
	text *t2 = PG_GETARG_TEXT_PP(1);
	
    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);
	
	PG_RETURN_BOOL(ver_op(v1, v2, "<"));
}

PG_FUNCTION_INFO_V1(ver_le);
Datum ver_le(PG_FUNCTION_ARGS)
{
	char *v1, *v2;
	text *t1 = PG_GETARG_TEXT_PP(0);
	text *t2 = PG_GETARG_TEXT_PP(1);
	
    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);
	
	PG_RETURN_BOOL(ver_op(v1, v2, "<="));
}

PG_FUNCTION_INFO_V1(ver_gt);
Datum ver_gt(PG_FUNCTION_ARGS)
{
	char *v1, *v2;
	text *t1 = PG_GETARG_TEXT_PP(0);
	text *t2 = PG_GETARG_TEXT_PP(1);
	
    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);
	
	PG_RETURN_BOOL(ver_op(v1, v2, ">"));
}

PG_FUNCTION_INFO_V1(ver_ge);
Datum ver_ge(PG_FUNCTION_ARGS)
{
	char *v1, *v2;
	text *t1 = PG_GETARG_TEXT_PP(0);
	text *t2 = PG_GETARG_TEXT_PP(1);
	
    v1 = text_to_cstring(t1);
    v2 = text_to_cstring(t2);
	
	PG_RETURN_BOOL(ver_op(v1, v2, ">="));
}
