#!/bin/bash

set -e

source "$HOME/perl5/perlbrew/etc/bashrc"
export PERL_CPANM_OPT="--mirror http://cpan.celogeek.com -v"

perlbrew use 5.16.3
perlbrew install-cpanm -f

cpanm Dist::Zilla

export PERL5LIB=lib
dzil authordeps --missing | cpanm
dzil listdeps --missing | cpanm
dzil clean
AUTHOR_TESTING=1 RELEASE_TESTING=1 dzil cover

git checkout master
git reset --hard origin/master
git checkout devel
git reset --hard origin/devel
git push --mirror git@github.com:celogeek/Dist-Zilla-PluginBundle-GRS.git