#!/usr/bin/env bash
source ../bashunit/bashunit.sh
standardout=true

  echo 1>&2 "usage: git bulk [-g] [-w <ws-name>] <git command>"
  echo 1>&2 "       git bulk --addworkspace <ws-name> <ws-root-directory>"
  echo 1>&2 "       git bulk --removeworkspace <ws-name>"
  echo 1>&2 "       git bulk --addcurrent <ws-name>"
  echo 1>&2 "       git bulk --purge"
  echo 1>&2 "       git bulk --listall"

# --purge und --listall
regexp="'\(\-\-listall$\)\|\(\-\-purge$\)'"
input="--purge"
assertContains "echo $input | sed -e 's/[[:space:]]*$//' | ( grep -o $regexp && echo 'sucess' ) || echo 'fail'" "sucess"
input="--purge  "
assertContains "echo $input | sed -e 's/[[:space:]]*$//' | ( grep -o $regexp && echo 'sucess' ) || echo 'fail'" "sucess"
input="--listall  "
assertContains "echo $input | sed -e 's/[[:space:]]*$//' | ( grep -o $regexp && echo 'sucess' ) || echo 'fail'" "sucess"
input="--listall"
assertContains "echo $input | sed -e 's/[[:space:]]*$//' | ( grep -o $regexp && echo 'sucess' ) || echo 'fail'" "sucess"
input="--listal"
assertContains "echo $input | sed -e 's/[[:space:]]*$//' | ( grep -o $regexp && echo 'sucess' ) || echo 'fail'" "fail"
input="--list all "
assertContains "echo $input | sed -e 's/[[:space:]]*$//' | ( grep -o $regexp && echo 'sucess' ) || echo 'fail'" "fail"
input="--listall undnochwas"
assertContains "echo $input | sed -e 's/[[:space:]]*$//' | ( grep -o $regexp && echo 'sucess' ) || echo 'fail'" "fail"
input="--purge undnochwas"
assertContains "echo $input | sed -e 's/[[:space:]]*$//' | ( grep -o $regexp && echo 'sucess' ) || echo 'fail'" "fail"

# git command
regexp="'\(\-g \)\?\(\-w \<[^ ]\+\>\(\s\)\?\)\?\(\s\)\?\(\<[^ ]\+\>\(\s\)\?\)\{2,\}'"
input="-g -w bla bla"
assertContains "echo $input | sed -e 's/[[:space:]]*$//' | ( grep -o $regexp && echo 'sucess' ) || echo 'fail'" "sucess"
input="-g -w bla"
assertContains "echo $input | sed -e 's/[[:space:]]*$//' | ( grep -o $regexp && echo 'sucess' ) || echo 'fail'" "w bla"
input="-g -w -bla bla"
assertContains "echo $input | sed -e 's/[[:space:]]*$//' | ( grep -o $regexp && echo 'sucess' ) || echo 'fail'" "bla bla"
input="-g bla bla"
assertContains "echo $input | sed -e 's/[[:space:]]*$//' | ( grep -o $regexp && echo 'sucess' ) || echo 'fail'" "sucess"
input="bla bla"
assertContains "echo $input | sed -e 's/[[:space:]]*$//' | ( grep -o $regexp && echo 'sucess' ) || echo 'fail'" "sucess"
input="-w bla bla"
assertContains "echo $input | sed -e 's/[[:space:]]*$//' | ( grep -o $regexp && echo 'sucess' ) || echo 'fail'" "sucess"
