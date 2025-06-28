-- --------------------------------------------------------------------------------------
-- GRUVDARK THEMES
-- --------------------------------------------------------------------------------------
return {
   {
      "navarasu/onedark.nvim",
      event = "UIEnter",
      enabled = true,
      config = function()
         local themes = {
            dark = {
               code_style = { comments = "none" },
               colors = {
                  fg = "#CDC5B8",
                  black = "#1B1B1B",
                  blue = "#5b98c9",
                  red = "#DB6A6A",
                  green = "#76B568",
                  purple = "#CD60B9",
                  grey = "#595959",
                  lightGrey = "#8D8A85",
                  aqua = "#00aa9c",
                  cyan = "#00aa9c",
                  orange = "#D19F66",
                  yellow = "#D19F66",
                  bg2 = "#313131",
                  bg1 = "#303030",
                  bg_blue = "#5b98c9",
               },
               highlights = {
                  -- Interface
                  Normal = { fg = "$fg", bg = "#1E1E1E" },
                  NormalFloat = { fg = "$fg", bg = "#1E1E1E" },
                  FloatBorder = { fg = "$fg", bg = "#1E1E1E" },
                  MsgArea = { fg = "$fg", bg = "#232323" },
                  StatusLine = { fg = "$fg", bg = "#2B2B2B" },
                  FloatermBorder = { fg = "NONE", bg = "#1E1E1E" },
                  FloatTitle = { fg = "$red" },
                  SignColumn = { bg = "#1E1E1E" },
                  YankHighlight = { fg = "#e6e3de", bg = "#2b2b2b" },

                  Search = { fg = "$fg", bg = "#283946" },
                  FlashCurrent = { fg = "$fg", bg = "#283946" },
                  FlashLabel = { fg = "$black", bg = "#BF5959", fmt = "bold" },
                  IncSearch = { fg = "$black", bg = "#BF5959", fmt = "bold" },

                  MatchParen = { bg = "#343434" },
                  Folded = { fg = "$fg", bg = "#282828" },
                  CursorLine = { bg = "NONE" },
                  CursorLineNr = { fg = "$lightGrey" },
                  Cursor = { fg = "#1E1E1E", bg = "#CDC5B8", fmt = "bold" },
                  Cursor2 = { fg = "#1E1E1E", bg = "#BF5959" },
                  LineNr = { fg = "#555555" },
                  ColorColumn = { bg = "#222222" },
                  EndOfBuffer = { fg = "#303030", bg = "NONE" },
                  IblIndent = { fg = "#323232" },
                  WinSeparator = { fg = "#2F2F2F" },
                  Visual = { bg = "#2C2C2C" },

                  TelescopeSelection = { fg = "#E1DCD6", bg = "#303030" },
                  TelescopeSelectionCaret = { fg = "$fg" },
                  TelescopeMatching = { fg = "$green" },
                  TelescopePromptBorder = { fg = "$fg" },
                  TelescopePromptPrefix = { fg = "$fg" },
                  TelescopeResultsBorder = { fg = "$fg" },
                  TelescopePreviewBorder = { fg = "$fg" },

                  CmpItemAbbrMatch = { fg = "$green" },
                  CmpItemAbbrMatchFuzzy = { fg = "$green", fmt = "none" },
                  CmpItemKindText = { fg = "$lightGrey" },
                  CmpItemMenu = { fg = "$lightGrey" },
                  PmenuSel = { fg = "#E1DCD6", bg = "#444444" },

                  TSParameter = { fg = "$fg" },
                  TSParameterReference = { fg = "$fg" },

                  -- General
                  ["@none"] = { fg = "NONE" },
                  ["@spell"] = { fg = "NONE" },
                  ["@variable.parameter"] = { fg = "$fg" },
                  ["@lsp.type.parameter"] = { fg = "$fg" },
                  ["@keyword.function"] = { fg = "$blue" },
                  ["@keyword"] = { fg = "$blue" },
                  ["@keyword.conditional.ternary"] = { fg = "$blue" },
                  ["@keyword.return"] = { fg = "$purple" },
                  ["@keyword.conditional"] = { fg = "$purple" },
                  ["@keyword.repeat"] = { fg = "$purple" },
                  ["@keyword.import"] = { fg = "$purple" },
                  ["@keyword.export"] = { fg = "$purple" },
                  ["@function"] = { fg = "$red" },
                  ["@function.builtin"] = { fg = "$red" },
                  ["@function.method"] = { fg = "$red" },
                  ["@variable.builtin"] = { fg = "$orange" },
                  ["@string"] = { fg = "$green" },
                  ["@lsp.type.namespace"] = { fg = "$aqua" },
                  ["@constructor"] = { fg = "$aqua" },
                  ["@variable.member"] = { fg = "$fg" },
                  ["@lsp.type.class.javascript"] = { fg = "$aqua" },

                  -- Symbols
                  ["@comment"] = { fg = "#555555" },
                  ["@operator"] = { fg = "$blue" },
                  ["@punctuation"] = { fg = "$fg" },
                  ["@punctuation.bracket"] = { fg = "$fg" },
                  ["@punctuation.delimiter"] = { fg = "$lightGrey" },

                  -- Html
                  ["@tag"] = { fg = "$red" },
                  ["@tag.delimiter"] = { fg = "$red" },
                  ["@tag.attribute"] = { fg = "#9266DA" },
                  ["@markup.heading.1.html"] = { fg = "$fg", fmt = "none" },
                  ["@markup.heading.html"] = { fg = "$fg", fmt = "none" },

                  -- Css
                  ["@property.css"] = { fg = "$blue" },
                  ["@string.css"] = { fg = "$orange" },
                  ["@string.plain.css"] = { fg = "$fg" },
                  ["@tag.css"] = { fg = "$red" },
                  ["@constant.css"] = { fg = "$red" },
                  ["@property.id.css"] = { fg = "$red" },
                  ["@property.class.css"] = { fg = "$red" },
                  ["@tag.attribute.css"] = { fg = "$fg" },
                  ["@type.css"] = { fg = "$red" },
                  ["@type.tag.css"] = { fg = "$red" },
                  ["@operator.css"] = { fg = "$fg" },
                  ["@attribute.css"] = { fg = "$red" },
                  ["@keyword.modifier.css"] = { fg = "$purple" },

                  -- Lua
                  ["@constructor.lua"] = { fg = "$fg" },
                  ["@keyword.operator.lua"] = { fg = "$blue" },
                  ["@module.builtin.lua"] = { fg = "$aqua" },
                  ["@property.lua"] = { fg = "$fg" },

                  -- Json
                  ["@property.json"] = { fg = "$red" },

                  -- Markdown
                  htmlTag = { fg = "$red" },
                  htmlTagName = { fg = "$red" },
                  markdownCodeDelimiter = { fg = "$green" },
                  markdownLinkText = { fg = "$blue" },
                  markdownUrl = { fg = "$green" },
                  markdownCode = { fg = "$green" },
                  markdownListMarker = { fg = "$blue" },
                  ["@label.markdown"] = { fg = "$red" },
                  ["@markup.raw.block.markdown"] = { fg = "$red" },
                  ["@markup.heading.1.html"] = { fg = "$orange" },
                  ["@markup.heading.html"] = { fg = "$orange" },

                  -- Typescript
                  ["@tag.tsx"] = { fg = "$aqua" },
                  ["@type.tsx"] = { fg = "$fg" },
                  ["@constant.tsx"] = { fg = "$fg" },
                  ["@keyword.directive.typescript"] = { fg = "$green" },

                  -- Javascript
                  ["@tag.javascript"] = { fg = "$aqua" },
                  ["@type.javascript"] = { fg = "$fg" },
                  ["@constant.javascript"] = { fg = "$fg" },

                  ["@lsp.typemod.property.declaration.javascript"] = { fg = "$fg" },
                  ["@lsp.typemod.property.defaultLibrary.javascript"] = { fg = "$orange" },
                  ["@lsp.typemod.variable.defaultLibrary.javascript"] = { fg = "$orange" },
                  ["@lsp.typemod.variable.defaultLibrary.javascriptreact"] = { fg = "$orange" },
                  ["@lsp.typemod.function.defaultLibrary"] = { fg = "$red" },

                  ["@markup.raw.javascript"] = { fg = "$fg" },
                  ["@markup.heading.1.javascript"] = { fg = "$orange", fmt = "none" },
               },
            },
            light = {
               code_style = { comments = "none" },
               colors = {
                  fg = "#111111",
                  black = "#1B1B1B",
                  blue = "#1e5a8b",
                  red = "#9f0202",
                  green = "#006c00",
                  purple = "#910e79",
                  grey = "#707070",
                  lightGrey = "#8D8A85",
                  aqua = "#008b7f",
                  cyan = "#008b7f",
                  orange = "#ae5f05",
                  yellow = "#ae5f05",
                  bg2 = "#e9e8dd",
                  bg1 = "#b0b0a6",
                  bg_blue = "#1e5a8b",
               },
               highlights = {
                  -- Interface
                  Normal = { fg = "$fg", bg = "#f7f5ea" },
                  NormalFloat = { fg = "$fg", bg = "#f7f5ea" },
                  FloatBorder = { fg = "$fg", bg = "#f7f5ea" },
                  MsgArea = { fg = "$fg", bg = "#e9e8dd" },
                  StatusLine = { fg = "$fg", bg = "#cececa" },
                  FloatermBorder = { fg = "NONE", bg = "#f7f5ea" },
                  FloatTitle = { fg = "$red" },
                  SignColumn = { bg = "#f7f5ea" },
                  YankHighlight = { fg = "$fg", bg = "#cececa" },

                  Search = { fg = "$fg", bg = "#ebd09c" },
                  FlashCurrent = { fg = "$fg", bg = "#ebd09c" },
                  FlashLabel = { fg = "$fg", bg = "#df7474" },
                  IncSearch = { fg = "$fg", bg = "#df7474" },

                  MatchParen = { bg = "#b0b0a6" },
                  Folded = { fg = "$fg", bg = "#b0b0a6" },
                  CursorLine = { bg = "NONE" },
                  CursorLineNr = { fg = "#404040" },

                  Cursor = { fg = "#f7f5ea", bg = "#404040", fmt = "bold" },
                  Cursor2 = { fg = "#f7f5ea", bg = "#BF5959" },

                  LineNr = { fg = "#828282" },
                  ColorColumn = { bg = "#f0efe4" },
                  EndOfBuffer = { fg = "#303030", bg = "NONE" },
                  Visual = { bg = "#e9e8dd" },

                  TelescopeSelection = { fg = "#000000", bg = "#e9e8dd" },
                  TelescopeSelectionCaret = { fg = "$fg" },
                  TelescopeMatching = { fg = "$green" },
                  TelescopePromptBorder = { fg = "$fg" },
                  TelescopePromptPrefix = { fg = "$fg" },
                  TelescopeResultsBorder = { fg = "$fg" },
                  TelescopePreviewBorder = { fg = "$fg" },

                  CmpItemAbbrMatch = { fg = "$green" },
                  CmpItemAbbrMatchFuzzy = { fg = "$green", fmt = "none" },
                  CmpItemKindText = { fg = "$lightGrey" },
                  CmpItemMenu = { fg = "$lightGrey" },
                  Pmenu = { fg = "$fg", bg = "$bg2" },
                  PmenuSel = { fg = "$fg", bg = "$bg1" },

                  TSParameter = { fg = "$fg" },
                  TSParameterReference = { fg = "$fg" },

                  -- General
                  ["@none"] = { fg = "NONE" },
                  ["@spell"] = { fg = "NONE" },
                  ["@variable.parameter"] = { fg = "$fg" },
                  ["@lsp.type.parameter"] = { fg = "$fg" },
                  ["@keyword.function"] = { fg = "$blue" },
                  ["@keyword"] = { fg = "$blue" },
                  ["@keyword.conditional.ternary"] = { fg = "$blue" },
                  ["@keyword.return"] = { fg = "$purple" },
                  ["@keyword.conditional"] = { fg = "$purple" },
                  ["@keyword.repeat"] = { fg = "$purple" },
                  ["@keyword.import"] = { fg = "$purple" },
                  ["@keyword.export"] = { fg = "$purple" },
                  ["@function"] = { fg = "$red" },
                  ["@function.builtin"] = { fg = "$red" },
                  ["@function.method"] = { fg = "$red" },
                  ["@variable.builtin"] = { fg = "$orange" },
                  ["@string"] = { fg = "$green" },
                  ["@lsp.type.namespace"] = { fg = "$aqua" },
                  ["@constructor"] = { fg = "$aqua" },
                  ["@variable.member"] = { fg = "$fg" },
                  ["@lsp.type.class.javascript"] = { fg = "$aqua" },

                  -- Symbols
                  ["@comment"] = { fg = "#828282" },
                  ["@operator"] = { fg = "$blue" },
                  ["@punctuation"] = { fg = "$fg" },
                  ["@punctuation.bracket"] = { fg = "$fg" },
                  ["@punctuation.delimiter"] = { fg = "$lightGrey" },

                  -- Html
                  ["@tag"] = { fg = "$red" },
                  ["@tag.delimiter"] = { fg = "$red" },
                  ["@tag.attribute"] = { fg = "#480AAB" },
                  ["@markup.heading.1.html"] = { fg = "$fg", fmt = "none" },
                  ["@markup.heading.html"] = { fg = "$fg", fmt = "none" },

                  -- Css
                  ["@property.css"] = { fg = "$blue" },
                  ["@string.css"] = { fg = "$orange" },
                  ["@string.plain.css"] = { fg = "$fg" },
                  ["@tag.css"] = { fg = "$red" },
                  ["@constant.css"] = { fg = "$red" },
                  ["@property.id.css"] = { fg = "$red" },
                  ["@property.class.css"] = { fg = "$red" },
                  ["@tag.attribute.css"] = { fg = "$fg" },
                  ["@type.css"] = { fg = "$red" },
                  ["@type.tag.css"] = { fg = "$red" },
                  ["@operator.css"] = { fg = "$fg" },
                  ["@attribute.css"] = { fg = "$red" },
                  ["@keyword.modifier.css"] = { fg = "$purple" },

                  -- Lua
                  ["@constructor.lua"] = { fg = "$fg" },
                  ["@keyword.operator.lua"] = { fg = "$blue" },
                  ["@module.builtin.lua"] = { fg = "$aqua" },
                  ["@property.lua"] = { fg = "$fg" },

                  -- Json
                  ["@property.json"] = { fg = "$red" },

                  -- Markdown
                  htmlTag = { fg = "$red" },
                  htmlTagName = { fg = "$red" },
                  markdownCodeDelimiter = { fg = "$green" },
                  markdownLinkText = { fg = "$blue" },
                  markdownUrl = { fg = "$green" },
                  markdownCode = { fg = "$green" },
                  markdownListMarker = { fg = "$blue" },
                  ["@label.markdown"] = { fg = "$red" },
                  ["@markup.raw.block.markdown"] = { fg = "$red" },
                  ["@markup.heading.1.html"] = { fg = "$orange" },
                  ["@markup.heading.html"] = { fg = "$orange" },

                  -- Typescript
                  ["@tag.tsx"] = { fg = "$aqua" },
                  ["@type.tsx"] = { fg = "$fg" },
                  ["@constant.tsx"] = { fg = "$fg" },
                  ["@keyword.directive.typescript"] = { fg = "$green" },

                  -- Javascript
                  ["@tag.javascript"] = { fg = "$aqua" },
                  ["@type.javascript"] = { fg = "$fg" },
                  ["@constant.javascript"] = { fg = "$fg" },

                  ["@lsp.typemod.property.declaration.javascript"] = { fg = "$fg" },
                  ["@lsp.typemod.property.defaultLibrary.javascript"] = { fg = "$orange" },
                  ["@lsp.typemod.variable.defaultLibrary.javascript"] = { fg = "$orange" },
                  ["@lsp.typemod.variable.defaultLibrary.javascriptreact"] = { fg = "$orange" },
                  ["@lsp.typemod.function.defaultLibrary"] = { fg = "$red" },

                  ["@markup.raw.javascript"] = { fg = "$fg" },
                  ["@markup.heading.1.javascript"] = { fg = "$orange", fmt = "none" },
               },
            },
         }

         local file = io.open("/home/darianmorat/.theme", "r")
         local theme = file and file:read("*l"):match("%S+") or "dark"
         if file then
            file:close()
         end

         require("onedark").setup(themes[theme] or themes.dark)
         require("onedark").load()
      end,
   },
}
