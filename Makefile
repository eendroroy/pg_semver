EXTENSION = vercomp
MODULE_big = vercomp
OBJS = vercomp.o $(WIN32RES)
PGFILEDESC = "vercomp - strengthen user password checks"

DATA = vercomp--0.0.2.sql
TESTS = $(wildcard test/sql/*.sql)

REGRESS_OPTS  = --inputdir=test --outputdir=test --load-extension=vercomp --user=postgres
REGRESS = vercomp_test_select_where

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
