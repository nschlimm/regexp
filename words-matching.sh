#!/usr/bin/env bash

source ../bashunit/bashunit.sh
standardout=true
clear

regexp="'\<.*\>'"
echo "***************** $regexp ****************"
assertContains "echo 'bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "success"

regexp="'\(\<.*\>\)'"
echo "***************** $regexp ****************"
assertContains "echo 'bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla"

regexp="'\(\<.*\>\)$'"
echo "***************** $regexp ****************"
assertContains "echo 'bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "success"

regexp="'\(\<.*\>\)\{1\}$'"
echo "***************** $regexp ****************"
assertContains "echo 'bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla"

regexp="'\<[^ ]\+\>'"
echo "***************** $regexp ****************"
assertContains "echo 'bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla" # matched zweimal bla

regexp="'\(\<[^ ]\+\>\)'"
echo "***************** $regexp ****************"
assertContains "echo 'bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla" # matched zweimal bla

regexp="'\(\<[^ ]\+\>\)$'"
echo "***************** $regexp ****************"
assertContains "echo 'bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla" # matched einmal bla am Ende

regexp="'\(\<[^ ]\+\>\)\{1\}'"
echo "***************** $regexp ****************"
assertContains "echo 'bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla" # matched zwei mal bla 

regexp="'\(\<[^ ]\+\>\)\{2\}'"
echo "***************** $regexp ****************"
assertContains "echo 'bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "fail" # zwei wörter direkt nacheinander werden nicht gefunden 

regexp="'\(\<[a\-z]\+\>\)\{2\}'"
echo "***************** $regexp ****************"
assertContains "echo 'bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "fail" # zwei wörter direkt nacheinander werden nicht gefunden 

regexp="'\<[a\-z]\+\>\{2\}'"
echo "***************** $regexp ****************"
assertContains "echo 'bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "repetition-operator operand invalid"

regexp="'\(\<[a\-z]\+\> \)\{2\}'"
echo "***************** $regexp ****************"
assertContains "echo 'bla bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla" 
assertContains "echo 'bla bla ' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla"  

regexp="'\(\<[a\-z]\+\>\s\)\{2\}'"
echo "***************** $regexp ****************"
assertContains "echo 'bla bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla" 
assertContains "echo 'bla bla ' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla" 
assertContains "echo 'bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "fail" 

regexp="'\(\<[a\-z]\+\>\(\s\)\)\{2\}'"
echo "***************** $regexp ****************"
assertContains "echo 'bla bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla" 
assertContains "echo 'bla bla ' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla" 
assertContains "echo 'bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "fail" 

regexp="'\(\<[a\-z]\+\>\(\s\)\?\)\{2\}'"
echo "***************** $regexp ****************"
assertContains "echo 'bla bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla" 
assertContains "echo 'bla bla ' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla" 
assertContains "echo 'bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla" 
assertContains "echo 'bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "fail" 

regexp="'\(\<[a-z]\+\>\(\s\)\?\)\{3\}'" # versteht in der character class das \ vor dem - als Optional, muss man nicht macxhen, stört aber auch nicht !
echo "***************** $regexp ****************"
assertContains "echo 'blu blu blu blu' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "blu blu blu" 
assertContains "echo 'blu blu blu ' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "blu blu blu" 
assertContains "echo 'blu blu blu' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "blu blu blu" 
assertContains "echo 'blu blu -blu' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "fail" 
assertContains "echo 'blu blu' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "fail" 

regexp="'\(\<[a\-z]\+\>\(\s\)\?\)\{3\}'"
echo "***************** $regexp ****************"
assertContains "echo 'blu blu blu blu' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "blu blu blu" 
assertContains "echo 'blu blu blu ' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "blu blu blu" 
assertContains "echo 'blu blu blu' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "blu blu blu" 
assertContains "echo 'blu blu -blu' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "fail" 
assertContains "echo 'blu blu' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "fail" 

regexp="'\(\<[^ ]\+\>\(\s\)\?\)\{3\}'" # -> '-' zählt nicht zum Wort dazu
echo "***************** $regexp ****************"
assertContains "echo 'bla bla bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla bla" # -> quantifier ist nicht 'zwingend' -> matched auch bei vier mal
assertContains "echo 'bla bla bla ' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla bla" 
assertContains "echo 'bla bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla bla" 
assertContains "echo '-bla bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla bla" # -> zählt '-' am Anfang der Wörter nicht mit 
assertContains "echo 'bla bla -bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "fail" # -> zählt '-' am wortbeginn nicht als wort 
assertContains "echo 'bla bla -bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "fail" # -> zählt '-'' am wortbeginn nicht als wort & 'bla' muss drei mal nacheinander kommen !
assertContains "echo 'bla bla bla-bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla bla-bla" # zählt '-' mitten drin als wort 
assertContains "echo 'bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "fail" 

regexp="'\(\<.*\>\(\s\)\?\)\{3\}'" # -> '-' zählt nicht zum Wort dazu
echo "***************** $regexp ****************"
assertContains "echo '-bla bla bla' | ( grep -o $regexp && echo 'success' ) || echo 'fail'" "bla bla bla" # -> zählt '-' am Anfang der Wörter nicht mit 
