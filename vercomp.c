#include "postgres.h"
#include "fmgr.h"
#include "utils/builtins.h"

#include "semver.c/semver.h"
#include "semver.c/semver.c"

PG_MODULE_MAGIC;

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
	char* v1 ;
	text* t = PG_GETARG_TEXT_PP(0);
    v1 = text_to_cstring(t);
    PG_RETURN_CSTRING(v1);
}
