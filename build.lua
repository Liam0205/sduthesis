module = "sduthesis"

checkengines = {"xetex"}
stdengine    = "xetex"
typesetexe   = "xelatex"
unpackexe    = "xetex"

sourcefiles  = {"*.dtx"}
installfiles = {"*.cls", "*.def"}
unpackfiles  = {"*.dtx"}

typesetsourcefiles = {"*.dtx"}

tdslocations = {
  "tex/latex/sduthesis/figures/*",
}

packtdszip = true
