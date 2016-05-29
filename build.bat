@echo off

set flag=%1
if %flag%x == x (
  set flag=all
)

if %flag%x == allx (
  call:clean_all
  call:extract
  call:document
  call:cleanaux
  goto:EOF
)
if %flag%x == cleanauxx (
  call:cleanaux
  goto:EOF
)
if %flag%x == cleanextx (
  call:cleanextract
  goto:EOF
)
if %flag%x == cleanx (
  call:clean_all
  goto:EOF
)
if %flag%x == extractx (
  call:extract
  goto:EOF
)
if %flag%x == docx (
  call:document
  goto:EOF
)

:help
  echo This is the build script for SDUThesis.
  echo USAGE:
  echo        build.bat [param]
  echo param:
  echo   help      Display this help text.
  echo   all       Do all tasks.
  echo   clean     Clean all extracted files, aux files and pdf files.
  echo   cleanaux  Clean aux files.
  echo   cleanext  Clean extracted files.
  echo   extract   Extract the Thesis Template from .ins and .dtx files.
  echo   doc       Build documentations.
goto:EOF

:cleanextract
  echo clean extract...
  for %%i in (*.def *.cls *.tex) do (
    del %%i
  )
goto:EOF

:cleanaux
  echo clean aux...
  for %%i in (*.aux *.lof *.log *.out *.toc *.glo *.hd *.idx) do (
    del %%i
  )
  for /f %%D in (';dir /ad/b _minted*';) do (
    rd /s /q %%D
  )
goto:EOF

:cleanpdf
  echo clean pdf...
  for %%i in (*.pdf) do (
    del %%i
  )
goto:EOF

:clean_all
  call:cleanextract
  call:cleanaux
  call:cleanpdf
goto:EOF

:extract
  echo extracting...
  xelatex sduthesis.ins
  for %%i in (*.md) do (
    del %%~ni
    ren %%i %%~ni
  )
goto:EOF

:document
  echo building documents...
  set cmode=-interaction=batchmode
  xelatex %cmode% sduthesis.dtx
  xelatex %cmode% sduthesis.dtx
  xelatex %cmode% sduthesis-demo.tex
  xelatex %cmode% sduthesis-demo.tex
goto:EOF
