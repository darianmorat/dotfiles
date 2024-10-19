-- -------------------------------------------------------------------------------------------
-- GRUVDARK THEME - Use :Inspect
-- -------------------------------------------------------------------------------------------

local gruvdark = {
   {
      "navarasu/onedark.nvim",
      config = function()
         require("onedark").setup({

            -- -----------------------
            -- GRUVDARK
            -- -----------------------
            colors = {
               fg         = "#CDC5B8",
               cyan       = "#CDC5B8",
               black      = "#1B1B1B",
               blue       = "#5b98c9",
               red        = "#DB6A6A",
               green      = "#76B568",
               orange     = "#D19F66",
               purple     = "#CD60B9",
               yellow     = "#00aa9c",
               aqua       = "#00aa9c",
               grey       = "#595959",
               lightGrey  = "#8D8A85",

               bg2 = "#313131",
               bg1 = "#2F2F2F",
               bg_blue = "#5b98c9",
            },
            highlights = {
               Folded                         = { fg = "$fg", bg = "#282828" },
               FloatBorder                    = { fg = "$fg", bg = "#1E1E1E" }, -- Avoid :Lazy & :Mason
               NormalFloat                    = { fg = "$fg", bg = "#1E1E1E" }, -- Just change the Harpoon UI
               Search                         = { fg = "$fg", bg = "#2D4151" },
               Normal                         = { bg = "#1E1E1E" },
               CursorLine                     = { bg = "#303030" },
               TelescopeSelection             = { bg = "#303030"},
               Visual                         = { bg = "#2C2C2C" },
               TSParameter                    = { fg = "$fg" },
               TSParameterReference           = { fg = "$fg" }, 
               LineNr                         = { fg = "#555555" },
               ColorColumn                    = { bg = "#222222" },
               EndOfBuffer                    = { bg = "#1E1E1E" },
               SignColumn                     = { bg = "#1E1E1E" },
               IblIndent                      = { fg = "#2F2F2F" },
               WinSeparator                   = { fg = "#2F2F2F" },

               -- General
               ["@none"]                      = { fg = "NONE" },
               ["@spell"]                     = { fg = "NONE" },

               -- Symbols
               ["@comment"]                   = { fg = "#555555" },
               ["@operator"]                  = { fg = "$blue" },
               ["@punctuation"]               = { fg = "$fg" },
               ["@punctuation.bracket"]       = { fg = "$fg" },
               ["@punctuation.delimiter"]     = { fg = "$lightGrey" },

               -- Html
               ["@tag"]                       = { fg = "$red" },
               ["@tag.delimiter"]             = { fg = "$red" },
               ["@operator.html"]             = { fg = "#9266DA" },
               ["@tag.attribute"]             = { fg = "#9266DA" },
               ["@markup.heading.html"]       = { fg = "$fg", fmt = "none" },
               ["@markup.link.label.html"]    = { fg = "$fg", fmt = "none" },

               -- Css
               ["@property.css"]              = { fg = "$blue" },  
               ["@string.css"]                = { fg = "$orange" },  
               ["@tag.css"]                   = { fg = "$red" },  
               ["@constant.css"]              = { fg = "$red" },  
               ["@tag.attribute.css"]         = { fg = "$fg" },  
               ["@type.css"]                  = { fg = "$red" },  
               ["@operator.css"]              = { fg = "$fg" },  
               ["@attribute.css"]             = { fg = "$red" },  

               -- Lua
               ["@constructor.lua"]           = { fg = "$fg" },

               -- Json
               ["@property.json"]             = { fg = "$red" },

               -- Markdown
               htmlTag                        = { fg = "$red" },
               htmlTagName                    = { fg = "$red" },
               markdownCodeDelimiter          = { fg = "$green" },
               markdownLinkText               = { fg = "$blue" },
               markdownUrl                    = { fg = "$green" },
               markdownCode                   = { fg = "$green" },
               markdownListMarker             = { fg = "$blue" },
               ["@label.markdown"]            = { fg = "$red" },
               ["@markup.raw.block.markdown"] = { fg = "$red" },

               -- Javascript
               ["@function"]                  = { fg = "$red" },
               ["@function.method"]           = { fg = "$red" },
               ["@keyword"]                   = { fg = "$blue" },
               ["@variable.parameter"]        = { fg = "$fg" },
               ["@lsp.type.parameter"]        = { fg = "$fg" },
               ["@variable.builtin"]          = { fg = "$orange" },
               ["@string"]                    = { fg = "$green" },
               ["@tag.javascript"]            = { fg = "$aqua" },
               ["@type.javascript"]           = { fg = "$fg" },  
               ["@constant.javascript"]       = { fg = "$fg" },  

               ["@markup.heading.1.javascript"]                         = { fg = "$fg", fmt = "none" },
               ["@keyword.conditional.ternary.javascript"]              = { fg = "$blue" },
               ["@lsp.typemod.property.declaration.javascript"]         = { fg = "$fg" },
               ["@lsp.typemod.property.defaultLibrary.javascript"]      = { fg = "$orange"},
               ["@lsp.typemod.variable.defaultLibrary.javascript"]      = { fg = "$orange"},
               ["@lsp.typemod.variable.defaultLibrary.javascriptreact"] = { fg = "$orange"},
            }

            -- -----------------------
            -- LIGHT GRUVDARK
            -- -----------------------
            -- Colors look different in terminal - compared to vscode
            -- colors = {
            --    fg         = "#111111",
            --    cyan       = "#111111",
            --    black      = "#1B1B1B",
            --    blue       = "#1e5a8b",
            --    red        = "#9f0202",
            --    green      = "#006c00",
            --    orange     = "#ae5f05",
            --    purple     = "#910e79",
            --    yellow     = "#008b7f",
            --    aqua       = "#008b7f",
            --    grey       = "#8f8f85",
            --    lightGrey  = "#8D8A85",
            --
            --    bg2 = "#d4d2c7",
            --    bg1 = "#b0b0a6",
            --    bg_blue = "#5b98c9",
            -- },
            -- highlights = {
            --    Folded                         = { fg = "$fg", bg = "#282828" },
            --    FloatBorder                    = { fg = "$fg", bg = "#f9f6e4" }, -- Avoid :Lazy & :Mason
            --    NormalFloat                    = { fg = "$fg", bg = "#f9f6e4" }, -- Just change the Harpoon UI
            --    Search                         = { fg = "$fg", bg = "#8bacc7" },
            --    Normal                         = { bg = "#f9f6e4" },
            --    CursorLine                     = { bg = "#303030" },
            --    TelescopeSelection             = { bg = "#303030"},
            --    Visual                         = { bg = "#dddcce" },
            --    TSParameter                    = { fg = "$fg" },
            --    TSParameterReference           = { fg = "$fg" }, 
            --    LineNr                         = { fg = "#555555" },
            --    ColorColumn                    = { bg = "#f1eedd" },
            --    EndOfBuffer                    = { bg = "#f9f6e4" },
            --    SignColumn                     = { bg = "#f9f6e4" },
            --    IblIndent                      = { fg = "#bebdb0" },
            --    WinSeparator                   = { fg = "#2F2F2F" },
            --
            --    -- General
            --    ["@none"]                      = { fg = "NONE" },
            --    ["@spell"]                     = { fg = "NONE" },
            --
            --    -- Symbols
            --    ["@comment"]                   = { fg = "#555555" },
            --    ["@operator"]                  = { fg = "$blue" },
            --    ["@punctuation"]               = { fg = "$fg" },
            --    ["@punctuation.bracket"]       = { fg = "$fg" },
            --    ["@punctuation.delimiter"]     = { fg = "$lightGrey" },
            --
            --    -- Html
            --    ["@tag"]                       = { fg = "$red" },
            --    ["@tag.delimiter"]             = { fg = "$red" },
            --    ["@operator.html"]             = { fg = "#9266DA" },
            --    ["@tag.attribute"]             = { fg = "#9266DA" },
            --    ["@markup.heading.html"]       = { fg = "$fg", fmt = "none" },
            --    ["@markup.link.label.html"]    = { fg = "$fg", fmt = "none" },
            --
            --    -- Css
            --    ["@property.css"]              = { fg = "$blue" },  
            --    ["@string.css"]                = { fg = "$orange" },  
            --    ["@tag.css"]                   = { fg = "$red" },  
            --    ["@constant.css"]              = { fg = "$red" },  
            --    ["@tag.attribute.css"]         = { fg = "$fg" },  
            --    ["@type.css"]                  = { fg = "$red" },  
            --    ["@operator.css"]              = { fg = "$fg" },  
            --    ["@attribute.css"]             = { fg = "$red" },  
            --
            --    -- Lua
            --    ["@constructor.lua"]           = { fg = "$fg" },
            --
            --    -- Json
            --    ["@property.json"]             = { fg = "$red" },
            --
            --    -- Markdown
            --    htmlTag                        = { fg = "$red" },
            --    htmlTagName                    = { fg = "$red" },
            --    markdownCodeDelimiter          = { fg = "$green" },
            --    markdownLinkText               = { fg = "$blue" },
            --    markdownUrl                    = { fg = "$green" },
            --    markdownCode                   = { fg = "$green" },
            --    markdownListMarker             = { fg = "$blue" },
            --    ["@label.markdown"]            = { fg = "$red" },
            --    ["@markup.raw.block.markdown"] = { fg = "$red" },
            --
            --    -- Javascript
            --    ["@function"]                  = { fg = "$red" },
            --    ["@function.method"]           = { fg = "$red" },
            --    ["@keyword"]                   = { fg = "$blue" },
            --    ["@variable.parameter"]        = { fg = "$fg" },
            --    ["@lsp.type.parameter"]        = { fg = "$fg" },
            --    ["@variable.builtin"]          = { fg = "$orange" },
            --    ["@string"]                    = { fg = "$green" },
            --    ["@tag.javascript"]            = { fg = "$aqua" },
            --    ["@type.javascript"]           = { fg = "$fg" },  
            --    ["@constant.javascript"]       = { fg = "$fg" },  
            --
            --    ["@markup.heading.1.javascript"]                         = { fg = "$fg", fmt = "none" },
            --    ["@keyword.conditional.ternary.javascript"]              = { fg = "$blue" },
            --    ["@lsp.typemod.property.declaration.javascript"]         = { fg = "$fg" },
            --    ["@lsp.typemod.property.defaultLibrary.javascript"]      = { fg = "$orange"},
            --    ["@lsp.typemod.variable.defaultLibrary.javascript"]      = { fg = "$orange"},
            --    ["@lsp.typemod.variable.defaultLibrary.javascriptreact"] = { fg = "$orange"},
            -- }
         })
         require("onedark").load()
      end
   }}

return gruvdark
