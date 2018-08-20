EXTENSION  = vercomp
MODULE_big = ${EXTENSION}
OBJS       = vercomp.o $(WIN32RES)
PGFILEDESC = "vercomp - strengthen user password checks"

DATA  = $(wildcard *--*.sql)
TESTS = $(wildcard test/sql/*.sql)

REGRESS_OPTS  = --inputdir=test --outputdir=test --load-extension=vercomp --user=postgres
REGRESS       = $(patsubst test/sql/%.sql,%,$(TESTS))

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

pg_regress_clean_files = test/results/ test/regression.diffs test/regression.out