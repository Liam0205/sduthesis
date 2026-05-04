module = "sduthesis"

checkengines = {"xetex"}
stdengine    = "xetex"
typesetexe   = "xelatex"
unpackexe    = "xetex"

sourcefiles  = {"*.dtx", "figures/*.pdf", "figures/*.jpg"}
installfiles = {"*.cls", "*.def", "SDU.pdf", "SDULogo.pdf", "SDUWords.jpg", "sduthesis-*.jpg"}
unpackfiles  = {"*.dtx"}

typesetsourcefiles = {"*.dtx"}
typesetfiles       = {"*.dtx"}

docfiles  = {"DEPENDS.txt"}
textfiles = {"README.md"}

excludefiles = {
  "AGENTS.md", "CLAUDE.md",
  "build-legacy.*",
}

tdslocations = {
  "tex/latex/sduthesis/figures/SDU.pdf",
  "tex/latex/sduthesis/figures/SDULogo.pdf",
  "tex/latex/sduthesis/figures/SDUWords.jpg",
  "tex/latex/sduthesis/figures/sduthesis-*.jpg",
}

packtdszip = true
