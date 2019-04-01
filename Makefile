EXTENSION  = pg_semver
MODULE_big = ${EXTENSION}
OBJS       = pg_semver.o $(WIN32RES)
PGFILEDESC = "pg_semver - add SEMVER data type to postgresql"

DATA  = $(wildcard *--*.sql)
TESTS = $(wildcard test/sql/*.sql)

REGRESS_OPTS  = --inputdir=test --outputdir=test --load-extension=pg_semver --user=postgres
REGRESS       = $(patsubst test/sql/%.sql,%,$(TESTS))

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

pg_regress_clean_files = test/results/ test/regression.diffs test/regression.out