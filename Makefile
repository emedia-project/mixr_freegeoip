PROJECT = mixr_freegeoip

DEPS = lager eutils 

dep_lager = git https://github.com/basho/lager.git master
dep_eutils = git https://github.com/emedia-project/eutils.git master

include erlang.mk

