#!/bin/sh

set -e

TDIR="`dirname "${0}"`"
. "${TDIR}/genfincode.sub"

gen_fin_c() {
  echo "/* Auto-generated by ${GENRNAME} - DO NOT EDIT! */"
  echo "#include <stdio.h>"
  echo "#include <stdint.h>"
  echo "#include <stdlib.h>"
  echo "#include \"rtpp_types.h\""
  echo "#include \"rtpp_debug.h\""
  echo "#include \"${1}\""
  echo "#include \"${2}\""

  for mname in ${MNAMES_ALL}
  do
    epname=`get_epname "${1}" "${mname}"`
    emit_finfunction "${mname}" "${epname}"
  done

  for oname in ${ONAMES}
  do
    echo "static const struct ${oname}_smethods ${oname}_smethods_fin = {"
    MNAMES=`grep ^DEFINE_METHOD "${1}" | sed 's|^DEFINE_METHOD[(]||' | grep "${oname}," | \
     awk -F ',' '{print $2}' | sed 's|^[ ]*||' | LC_ALL=C sort`
    for mname in ${MNAMES}
    do
      epname=`get_epname "${1}" "${mname}"`
      echo "    .${epname} = (${mname}_t)&${mname}_fin,"
    done
    echo "};"
  done

  epname=smethods
  for oname in ${ONAMES}
  do
    echo "void ${oname}_fin(struct ${oname} *pub) {"
    echo "    RTPP_DBG_ASSERT(pub->${epname} != &${oname}_${epname}_fin &&"
    echo "      pub->${epname} != NULL);"
    echo "    pub->${epname} = &${oname}_${epname}_fin;"
    echo "}"
  done
}

hname=`basename "${2}"`
emit_fin_h "${1}" "${hname}" > "${2}"
gen_fin_c "${1}" "${hname}" > "${3}"
