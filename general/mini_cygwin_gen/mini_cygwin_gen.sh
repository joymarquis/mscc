#!/bin/bash

usage()
{
	echo "Usage: `basename $0` <exec_name> [<exec_name> ...]"
	echo "   check [bin/] directory for generated files"
	echo
	echo '    (Ver: $id: $)'
}

CYGWIN_EXEC_LIST=$*
GEN_DIR="./bin"

if [ "$*" == "" ]; then
	usage; exit 1
fi

mkdir -p $GEN_DIR

for i in $CYGWIN_EXEC_LIST; do
	which $i >/dev/null 2>&1 && cp -a `which $i` $GEN_DIR
done
for i in `cygcheck $CYGWIN_EXEC_LIST | grep "cyg.*\.dll$"`; do
	tmp=`cygpath -ua $i`
	[ -f "`basename $tmp`" ] && continue
	cp -a $tmp $GEN_DIR
done
