EXTENSION = vercomp
MODULE_big = vercomp
OBJS = vercomp.o $(WIN32RES)
PGFILEDESC = "vercomp - strengthen user password checks"

DATA = vercomp--1.0.0.sql

REGRESS_OPTS  = --inputdir=test --outputdir=test --load-extension=vercomp --user=postgres
REGRESS = vercomp_test

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)