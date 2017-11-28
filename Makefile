# rebar variables
REBAR3 := $(CURDIR)/rebar3
REBAR_CONFIG := rebar.config
VERSION := $(shell $(REBAR3) relv | tail -1 | cut -f2 -d'"')
APP_VERSION := $(shell erl -eval \
	"{ok, [{application, advent_of_code, Info}]} =\
		file:consult(\"$(PWD)/apps/advent_of_code/src/advent_of_code.app.src\"),\
	io:fwrite(proplists:get_value(vsn, Info)), halt()." -noshell)
CLUSTER := $(CLUSTER)
DOCKER_TAG := $(VERSION)-$(CLUSTER)
BUILD_DIR := _build
RELEASE_TARBALL := $(BUILD_DIR)/$(CLUSTER)/rel/advent_of_code/advent_of_code-$(VERSION).tar.gz
ELVIS := _build/elvis/lib/elvis/_build/default/bin/elvis

##################
# advent_of_code make targets
##################
.PHONY: all
all: compile elvis test check

.PHONY: compile
compile:
	$(REBAR3) compile

.PHONY: doc
doc:
	$(REBAR3) edoc

.PHONY: check
check: xref dialyzer

.PHONY: dialyzer
dialyzer:
	$(REBAR3) dialyzer

.PHONY: xref
xref:
	$(REBAR3) xref

.PHONY: test
test: eunit ct

.PHONY: eunit
eunit:
	$(REBAR3) eunit

.PHONY: ct
ct:
	$(REBAR3) ct

.PHONY: clean
clean:
	$(REBAR3) clean
	rm -f rebar.lock
	rm -rf $(BUILD_DIR)

.PHONY: release
release: $(RELEASE_TARBALL)

$(RELEASE_TARBALL): UID=$(shell id -u)
$(RELEASE_TARBALL):
	$(REBAR3) clean
	$(REBAR3) as prod tar

.PHONY: elvis
elvis: $(ELVIS)
	$(ELVIS) rock

$(ELVIS):
	$(REBAR3) as elvis compile
	cd _build/elvis/lib/elvis && $(REBAR3) escriptize

.PHONY: relv
relv:
	@echo $(VERSION)
