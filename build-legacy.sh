#!/bin/bash

function clean_extract {
  echo "clean extract..."
  for fname in *.def *.cls *.tex; do
    /bin/rm -rf ${fname}
  done
}

function clean_aux {
  echo "clean aux..."
  for fname in *.aux *.lof *.log *.out *.toc *.glo *.hd *.idx; do
    /bin/rm -rf ${fname}
  done
  /bin/rm -rf _minted*
}

function clean_pdf {
  echo "clean pdf..."
  for fname in *.pdf; do
    /bin/rm -rf ${fname}
  done
}

function clean_all {
  clean_extract
  clean_aux
  clean_pdf
}

function extract {
  echo "extracting..."
  xelatex sduthesis.ins
  for fname in *.md; do
    mv ${fname} ${fname%.*}
  done
}

function build_document {
  echo "building documents..."
  mode="-interaction=batchmode"
  xelatex ${mode} sduthesis.dtx
  xelatex ${mode} sduthesis.dtx
  xelatex ${mode} sduthesis-demo.tex
  xelatex ${mode} sduthesis-demo.tex
}

flag=$1
flag=${flag:-"all"}

if [ ${flag}x == "all"x ]; then
  clean_all
  extract
  build_document
  clean_aux
fi
if [ ${flag}x == "clean"x ]; then
  clean_all
fi
if [ ${flag}x == "extract"x ]; then
  clean_extract
  extract
fi
if [ ${flag}x == "doc"x ]; then
  build_document
fi
if [ ${flag}x == "cleanaux"x ]; then
  clean_aux
fi
if [ ${flag}x == "cleanext"x ]; then
  clean_extract
fi
if [ ${flag}x == "help"x ]; then
  clear
  echo "This is the build script for SDUThesis."
  echo ""
  echo "USAGE: "
  echo "       build [param]"
  echo ""
  echo "param:"
  echo "  help      Display this help text."
  echo "  all       Do all tasks."
  echo "  clean     Clean all extracted files, aux files and pdf files."
  echo "  cleanaux  Clean aux files."
  echo "  cleanext  Clean extracted files."
  echo "  extract   Extract the Thesis Template from .ins and .dtx files."
  echo "  doc       Build documentations."
fi

