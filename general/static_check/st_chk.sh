#!/bin/bash

RESULT_LOG="`basename $0`-$1-$2.`date +%Y%m%d-%H%M%S`.log"

function usage()
{
	echo "Usage:"
	echo "    `basename $0` prepare <build_command> [<build_parameter ...>]"
	echo "    `basename $0` <cppcheck|splint> [<build_log_file>]"
	echo ""
	echo "To skip parse error from splint, use:"
	echo "    #ifndef S_SPLINT_S"
	echo "    #endif /* S_SPLINT_S */"
	echo ""
	echo "Define V=* for verbose"
	echo ""
	echo '    (Ver: $Id: st_chk.sh 10 2013-02-04 05:40:40Z joymarquis $)'
}

function err_exit() { [ "$1" != "" ] && echo "Error: $1"; [ "$2" != "" ] && exit $2 || exit 1; }

#GLOBAL_INC_GHS="-I/cygdrive/c/ghs/multi517D/include/mips -I/cygdrive/c/ghs/multi517D/ansi"
GLOBAL_INC=""

CPPCHECK_PARAM=" \
	-q \
	--enable=style,performance,portability \
	"

## cppcheck params
#       -q \                            (do not display progress for each file)
#       -j 4 \                          (4 threads, incompatible with --enable=missingInclude)
#       --check-config \                Check include files
#       --enable=all \                  (enable all additional check)
#       --enable=style,performance \    (example for enabling multi additional check)
#       --enable=style \                Check coding style
#       --enable=performance \          Enable performance messages
#       --enable=portability \          Enable portability messages
#       --enable=information \          Enable information messages
#       --enable=unusedFunction \       Check for unused functions
#       --enable=missingInclude \       Warn if there are missing includes

SPLINT_PARAM=" \
	-weak \
	+usedef \
	\
	-warnflags \
	+skipsysheaders \
	-showfunc \
	\
	-nestcomment \
	-likelybool \
	-retvalother \
	-type \
	-predboolothers \
	-fixedformalarray \
	\
	-isoreserved \
	-protoparamname \
	-exportfcn \
	-exporttype \
	-exportvar \
	-exportconst \
	-modunconnomods \
	-noeffectuncon \
	-declundef \
	-unrecog \
	-constuse \
	-globs \
	-modnomods \
	-modobserveruncon \
	-sizeoftype \
	+enumindex \
	\
	-paramuse \
	+charindex \
	+charint \
	-predboolint \
	-boolops \
	\
	-bitwisesigned \
	-strictops \
	-typeuse \
	-fcnuse \
	-enummemuse \
	-initallelements \
	-formattype \
	-compdef \
	-exportlocal \
	-incondefs \
	-shiftimplementation \
	-nullassign \
	"

## splint params
#       -linelen 120 \          (output width)
#       -warnflags \            (silent even flag has problem)
#       -weak \                 (do weak check)
#       -standard \             (do standard check)
#       -checks \               (do checks check)
#       -strict \               (do strict check)
#       -sysdirs "/cygdrive/c/ghs/multi517D/ansi" \             ( set directories for system files (default /usr/include))
#       +skipsysheaders \       (do not include header files in system directories)
#       +skipisoheaders \       (dfl:prevent inclusion of header files in a system directory)
#       +skipposixheaders \     (dfl:prevent inclusion of header files in a system directory)
#       -showfunc \             (do not show function name)
##
#       -nestcomment \          A comment open sequence (/*) appears within a comment
#       -likelybool \           Type BOOL is probably meant as a boolean type
#       -retvalother \          Result returned by function call is not used
#       -type \                 Types are incompatible
#       -predboolothers \       Test expression type is not boolean
#       -fixedformalarray \     Function parameter array declared as manifest array
##
#       -isoreserved \          External name is reserved for system use by ISO C99 standard
#       -protoparamname \       A parameter in a function prototype has a name
#       -namechecks \           -isoreserved -protoparamname
#       -exportfcn \            A function is exported, but not specified
#       -exporttype \           A type is exported, but not specified
#       -exportvar \            A variable is exported, but not specified
#       -exportconst \          A constant is exported, but not specified
#       -modunconnomods \       An unconstrained function is called in a function body where modifications are checked
#       -noeffectuncon \        Statement has no visible effect --- no values are modified
#       -declundef \            A function or variable is declared, but not defined in any source code file
#       -unrecog \              Identifier used in code has not been declared
#       -constuse \             A constant is declared but not used
#       -globs \                A checked global variable is used in the function, but not listed in its globals clause
#       -modnomods \            An externally-visible object is modified by a function with no /*@modifies@*/ comment
#       -modobserveruncon \     Storage declared with observer may be modified through a call to an unconstrained function
#       -sizeoftype \           Operand of sizeof operator is a type
#       +enumindex \            To allow enum types to index arrays, use +enumindex
#
##      "-weak" option defaults excluding following rules:
#       -paramuse \             A function parameter is not used in the body of the function
#       +charindex \            To allow char types to index arrays, use +charindex
#       +charint \              To make char and int types equivalent, use +charint
#       -predboolint \          Test expression type is not boolean or int
#       -boolops \              The operand of a boolean operator is not a boolean
##
#       #-fullinitblock \       Initializer does not set every field in the structure
#       #-fielduse \            A field is present in a structure type but never used
#       !-bitwisesigned \       An operand to a bitwise operator is not an unsigned values
#       !-strictops \           A primitive operation does not type check strictly
#       !-typeuse \             A type is declared but not used
#       !-fcnuse \              A function is declared but not used
#       !-enummemuse \          A member of an enum type is never used
#       !-initallelements \     Initializer does not define all elements of a declared array
#       !-formattype \          Type of parameter is not consistent with corresponding code in format string
#

BUILD_LOG="`basename $0`.chk"

case "_$1" in
	_cppcheck)
		CHECK_CMD=cppcheck
		CHECK_PARAM=$CPPCHECK_PARAM
		[ "$2" != "" ] && BUILD_LOG="$2"
		[ -f "$BUILD_LOG" ] || err_exit "log file not found [$BUILD_LOG]"
		;;
	_splint)
		CHECK_CMD=splint
		CHECK_PARAM=$SPLINT_PARAM
		[ "$2" != "" ] && BUILD_LOG="$2"
		[ -f "$BUILD_LOG" ] || err_exit "log file not found [$BUILD_LOG]"
		;;
	_prepare)
		shift
		[ "$*" == "" ] && usage && exit 1
		sh -c "$*" | tee $BUILD_LOG
		exit
		;;
	*)
		usage; exit 1
		;;
esac

R=`cat $BUILD_LOG`


# parse build process file
R=`echo "$R" | sed -e ":a" -e '/\\\\$/N; s/\\\\\n//; ta' -e 's/\\\\/\\//g'`
#echo "R: $R"; exit

# get only "*.c" lines
R=`echo "$R" | grep " [^ -]*\.c" | grep -v " \-M "`
#echo "R: $R"; exit

echo "$R" | while read line; do
L=`echo "$line" | grep -o -e "-D[^ ]*" -e "-I[^ ]* " -e " [^ -]*\.c" | xargs`
L=`echo "$L" | sed 's/\(.\):/\/cygdrive\/\1/g'`
L="$CHECK_CMD $CHECK_PARAM $GLOBAL_INC $L"
[ "$V" != "" ] && echo $L
$L
done 2>&1 | tee $RESULT_LOG

