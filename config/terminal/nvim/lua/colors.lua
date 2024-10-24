-- -------------------------------------------------------------------------------------------
-- GRUVDARK THEMES REFERENCE
-- -------------------------------------------------------------------------------------------
-- Use :Inspect to check groups
-- darianmorat/gruvdark-theme.nvim -- Pending with variations
-- Fix vscode colors -- to mach this ones

return {
   { 
      "sainnhe/gruvbox-material",
      config = function()
         local group = vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", { clear=true })

         vim.g.gruvbox_material_foreground = "material" -- material, mix, original

         vim.api.nvim_create_autocmd("ColorScheme", {
            group = group,
            pattern = "gruvbox-material",
            callback = function()
               vim.api.nvim_set_hl(0, "Normal", { bg = "#1E1E1E" })
               vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1E1E1E" })
               vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1E1E1E" })
               vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1E1E1E" })
               vim.api.nvim_set_hl(0, "Folded", { bg = "#282828" })
               vim.api.nvim_set_hl(0, "Search", { bg = "#283946" })
               vim.api.nvim_set_hl(0, "CursorLine", { bg = "#303030" })
               vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#e1dcd6", bg = "#303030" })

               -- vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = "#151515", bg = "#fe6a62" })
               vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = "#e5d4b7" })
               vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#fe6a62" })
               vim.api.nvim_set_hl(0, "EyelinerDimmed", { fg = "#585858" })
               

               vim.api.nvim_set_hl(0, "Visual", { bg = "#2C2C2C" })
               vim.api.nvim_set_hl(0, "LineNr", { fg = "#555555" })
               vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#222222" })
               vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#2F2F2F", bg = "NONE" })
               vim.api.nvim_set_hl(0, "SignColumn", { bg = "#1E1E1E" })
               vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2F2F2F" })
               vim.api.nvim_set_hl(0, "@comment", { fg = "#585858" })
            end
         })
      end
   },

   {
      "navarasu/onedark.nvim",
      config = function()
         require("onedark").setup({
            code_style = {
               comments = 'none'
            },

            -- -----------------------
            -- GRUVDARK
            -- -----------------------
            colors = {
               fg         = "#CDC5B8",
               black      = "#1B1B1B",
               blue       = "#5b98c9",
               red        = "#DB6A6A",
               green      = "#76B568",
               purple     = "#CD60B9",
               grey       = "#595959",
               lightGrey  = "#8D8A85",

               aqua       = "#00aa9c",
               cyan       = "#00aa9c",

               orange     = "#D19F66",
               yellow     = "#D19F66",

               bg2 = "#313131",
               bg1 = "#2F2F2F",
               bg_blue = "#5b98c9",
            },
            highlights = {
               -- Interface
               Normal                         = { fg = "$fg", bg = "#1E1E1E" },
               Folded                         = { fg = "$fg", bg = "#282828" },

               Search                         = { fg = "$fg", bg = "#283946" },
               IncSearch                      = { fg = "$black", bg="$red", fmt="bold" },  

               CursorLine                     = { bg = "#303030" },
               Visual                         = { bg = "#2C2C2C" },
               TSParameter                    = { fg = "$fg" },
               TSParameterReference           = { fg = "$fg" }, 
               LineNr                         = { fg = "#555555" },
               ColorColumn                    = { bg = "#222222" },
               EndOfBuffer                    = { bg = "NONE" },
               SignColumn                     = { bg = "#1E1E1E" },
               IblIndent                      = { fg = "#2F2F2F" },
               WinSeparator                   = { fg = "#2F2F2F" },

               TelescopeSelection             = { fg = "#e1dcd6", bg = "#303030"},
               TelescopeSelectionCaret        = { fg = "$fg"},
               TelescopeMatching              = { fg = "$green"},
               TelescopePromptBorder          = { fg = "$fg"},
               TelescopeResultsBorder         = { fg = "$fg"},
               TelescopePreviewBorder         = { fg = "$fg"},
               
               -- LeapLabelPrimary               = { fg = "#e1dcd6", bg = "#4c4c4d" },
               EyelinerPrimary                = { fg = "#e1dcd6" },
               EyelinerSecondary              = { fg = "#df5a5a" },

               FloatBorder                    = { fg = "$fg", bg = "#1E1E1E" },
               NormalFloat                    = { fg = "$fg", bg = "#1E1E1E" },
               FloatTitle                     = { fg = "$red"},
               FloatermBorder                 = { fg = "NONE", bg = "#1E1E1E" },

               CmpItemAbbrMatch               = { fg = "$green" },
               CmpItemAbbrMatchFuzzy          = { fg = "$green", fmt = "none" },
               CmpItemKindText                = { fg = "$lightGrey" },
               CmpItemMenu                    = { fg = "$lightGrey" },

               -- General
               ["@none"]                        = { fg = "NONE" },
               ["@spell"]                       = { fg = "NONE" },
               ["@variable.parameter"]          = { fg = "$fg" },
               ["@lsp.type.parameter"]          = { fg = "$fg" },
               ["@keyword.function"]            = { fg = "$blue" },
               ["@keyword"]                     = { fg = "$blue" },
               ["@keyword.conditional.ternary"] = { fg = "$blue" },
               ["@keyword.return"]              = { fg = "$purple" },  
               ["@keyword.conditional"]         = { fg = "$purple" },
               ["@keyword.repeat"]              = { fg = "$purple" },  
               ["@keyword.import"]              = { fg = "$purple" },
               ["@keyword.export"]              = { fg = "$purple" },
               ["@function"]                    = { fg = "$red" },
               ["@function.builtin"]            = { fg = "$red" },
               ["@function.method"]             = { fg = "$red" },
               ["@variable.builtin"]            = { fg = "$orange" },
               ["@string"]                      = { fg = "$green" },
               ["@lsp.type.namespace"]          = { fg = "$aqua" },
               ["@constructor"]                 = { fg = "$aqua" },
               ["@variable.member"]             = { fg = "$fg" },
               ["@lsp.type.class.javascript"]   = { fg = "$aqua" },

               -- Symbols
               ["@comment"]                     = { fg = "#555555" },
               ["@operator"]                    = { fg = "$blue" },
               ["@punctuation"]                 = { fg = "$fg" },
               ["@punctuation.bracket"]         = { fg = "$fg" },
               ["@punctuation.delimiter"]       = { fg = "$lightGrey" },

               -- Html
               ["@tag"]                         = { fg = "$red" },
               ["@tag.delimiter"]               = { fg = "$red" },
               ["@operator.html"]               = { fg = "#9266DA" },
               ["@tag.attribute"]               = { fg = "#9266DA" },
               ["@markup.heading.1.html"]       = { fg = "$fg", fmt = "none" },
               ["@markup.heading.html"]         = { fg = "$fg", fmt = "none" },

               -- Css
               ["@property.css"]                = { fg = "$blue" },  
               ["@string.css"]                  = { fg = "$orange" },  
               ["@string.plain.css"]            = { fg = "$fg" },  
               ["@tag.css"]                     = { fg = "$red" },  
               ["@constant.css"]                = { fg = "$red" },  
               ["@property.id.css"]             = { fg = "$red" },  
               ["@property.class.css"]          = { fg = "$red" },  
               ["@tag.attribute.css"]           = { fg = "$fg" },  
               ["@type.css"]                    = { fg = "$red" },  
               ["@type.tag.css"]                = { fg = "$red" },  
               ["@operator.css"]                = { fg = "$fg" },  
               ["@attribute.css"]               = { fg = "$red" },  
               ["@keyword.modifier.css"]        = { fg = "$purple" },  

               -- Lua
               ["@constructor.lua"]             = { fg = "$fg" },
               ["@keyword.operator.lua"]        = { fg = "$blue" },
               ["@module.builtin.lua"]          = { fg = "$aqua" },
               ["@property.lua"]             = { fg = "$fg" },
               
               
               -- Json
               ["@property.json"]               = { fg = "$red" },

               -- Markdown
               htmlTag                          = { fg = "$red" },
               htmlTagName                      = { fg = "$red" },
               markdownCodeDelimiter            = { fg = "$green" },
               markdownLinkText                 = { fg = "$blue" },
               markdownUrl                      = { fg = "$green" },
               markdownCode                     = { fg = "$green" },
               markdownListMarker               = { fg = "$blue" },
               ["@label.markdown"]              = { fg = "$red" },
               ["@markup.raw.block.markdown"]   = { fg = "$red" },

               -- Typescript
               ["@keyword.directive.typescript"] = { fg = "$green"},

               -- Javascript
               ["@tag.javascript"]               = { fg = "$aqua" },
               ["@type.javascript"]              = { fg = "$fg" },  
               ["@constant.javascript"]          = { fg = "$fg" },  

               ["@markup.heading.1.javascript"]                         = { fg = "$fg", fmt = "none" },
               ["@lsp.typemod.property.declaration.javascript"]         = { fg = "$fg" },
               ["@lsp.typemod.property.defaultLibrary.javascript"]      = { fg = "$orange"},
               ["@lsp.typemod.variable.defaultLibrary.javascript"]      = { fg = "$orange"},
               ["@lsp.typemod.variable.defaultLibrary.javascriptreact"] = { fg = "$orange"},
               ["@lsp.typemod.function.defaultLibrary"]                 = { fg = "$red"},
            }

            -- -----------------------
            -- LIGHT GRUVDARK 
            -- Light colors look different compared to vscode
            -- -----------------------
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

            -- }
         })
      end
   }
}
