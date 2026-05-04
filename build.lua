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

docfiles  = {"DEPENDS.txt", "CHANGELOG.md"}
textfiles = {"README.md"}

typesetdemofiles = {"sduthesis-demo.tex"}

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

tagfiles = {"*.dtx", "CHANGELOG.md"}

function docinit_hook()
  cp("sduthesis-demo.tex", unpackdir, typesetdir)
  cp("*.pdf", "figures", typesetdir)
  cp("*.jpg", "figures", typesetdir)
  return 0
end

function update_tag(file, content, tagname, tagdate)
  local date = string.gsub(tagdate, "%-", "/")
  if string.match(file, "%.dtx$") then
    content = string.gsub(content,
      "Copyright %(C%) (%d%d%d%d) %-%- %d%d%d%d",
      "Copyright (C) %1 -- " .. os.date("%Y"))
    if string.match(content, "%d%d%d%d/%d%d/%d%d v[0-9.]+") then
      content = string.gsub(content,
        "%d%d%d%d/%d%d/%d%d v[0-9.]+[a-z]*",
        date .. " v" .. tagname)
    end
  elseif string.match(file, "CHANGELOG.md") then
    local previous = string.match(content, "/compare/(.*)%.%.%.HEAD")
    local gittag = "v" .. tagname
    if gittag == previous then return content end
    content = string.gsub(content,
      "## %[Unreleased%]",
      "## [Unreleased]\n\n## [" .. gittag .. "] - " .. tagdate)
    content = string.gsub(content,
      previous .. "%.%.%.HEAD",
      gittag .. "...HEAD\n"
      .. string.format("%-14s", "[" .. gittag .. "]:")
      .. "https://github.com/liam0205/sduthesis/compare/"
      .. previous .. "..." .. gittag)
  end
  return content
end
