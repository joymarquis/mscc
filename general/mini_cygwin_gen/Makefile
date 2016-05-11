CYGWIN_TOOL_LIST=bash sed xxd

all:
	echo "Generate binary for log converter"
	cygcheck -V >/dev/null 2>&1	\
		|| { echo "===="; echo "You need to run in Cygwin environment"; echo "===="; false; }
	list='$(CYGWIN_TOOL_LIST)'; for i in $$list; do	\
	     which $$i >/dev/null 2>&1 && cp -a `which $$i` .;	\
	     done;
	list=`cygcheck $(CYGWIN_TOOL_LIST) | grep "cyg.*dll$$"`; for i in $$list; do	\
	     tmp=`cygpath -ua $$i`;	\
	     if [ -f `basename $$tmp` ]; then continue; fi;	\
	     cp -a "$$tmp" .;	\
	     done;
	echo $$list

clean:
	echo "Cleanup binary for log converter"
	cygcheck -V >/dev/null 2>&1	\
		|| { echo "===="; echo "You need to run in Cygwin environment"; echo "===="; false; }
	list='$(CYGWIN_TOOL_LIST)'; for i in $$list; do	\
	     rm -f $$i;	\
	     done;
	list=`cygcheck $(CYGWIN_TOOL_LIST) | grep "cyg.*dll$$"`; for i in $$list; do	\
	     tmp=`cygpath -ua $$i`;	\
	     rm -f `basename $$tmp`;	\
	     done;
