" Vim color file
" Name: Amaranth Dark
" Maintainer: Ported from Emacs by Gemini
" Original Author: Emiliano Rizzonelli
" License: MIT

set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "amaranth-dark"

" Color Palette
let s:fg        = "#e4e4ef"
let s:fg_plus_1 = "#f4f4ff"
let s:white     = "#ffffff"
let s:black     = "#000000"
let s:bg_minus_1= "#080808"
let s:bg        = "#000000"
let s:bg_plus_1 = "#101010"
let s:bg_plus_2 = "#302d2d"
let s:bg_plus_3 = "#4f4949"
let s:bg_plus_4 = "#7b7171"
let s:red_minus_1= "#c73c3f"
let s:red       = "#a02e2e"
let s:red_plus_1= "#c81a1a"
let s:green     = "#598b43"
let s:yellow    = "#ffd966"
let s:brown     = "#7b7171"
let s:quartz    = "#959da3"
let s:niagara   = "#97a1b5"
let s:wisteria  = "#a64d79"

" Helper function for highlighting
function! s:h(group, fg, bg, attr)
  let l:cmd = "hi " . a:group
  if !empty(a:fg) | let l:cmd .= " guifg=" . a:fg | endif
  if !empty(a:bg) | let l:cmd .= " guibg=" . a:bg | endif
  if !empty(a:attr) | let l:cmd .= " gui=" . a:attr | endif
  execute l:cmd
endfunction

" --- UI Components ---
call s:h("Normal",          s:fg,       s:bg,       "none")
call s:h("Cursor",          s:black,    s:yellow,   "none")
call s:h("CursorLine",      "",         s:bg_plus_1,"none")
call s:h("CursorColumn",    "",         s:bg_plus_1,"none")
call s:h("ColorColumn",     "",         s:bg_plus_1,"none")
call s:h("LineNr",          s:bg_plus_4,s:bg,       "none")
call s:h("CursorLineNr",    s:yellow,   s:bg,       "none")
call s:h("VertSplit",       s:bg_plus_2,s:bg_plus_2,"none")
call s:h("StatusLine",      s:white,    s:bg_plus_1,"none")
call s:h("StatusLineNC",    s:quartz,   s:bg_plus_1,"none")
call s:h("Visual",          "",         s:bg_plus_3,"none")
call s:h("Search",          s:black,    s:fg_plus_1,"none")
call s:h("IncSearch",       s:black,    s:yellow,   "none")
call s:h("MatchParen",      "",         s:bg_plus_4,"none")
call s:h("Folded",          s:brown,    s:bg_minus_1,"none")
call s:h("Pmenu",           s:fg,       s:bg_plus_1,"none")
call s:h("PmenuSel",        s:fg,       s:bg_minus_1,"none")
call s:h("SignColumn",      "",         s:bg,       "none")
call s:h("Directory",       s:niagara,  "",         "bold")
call s:h("ErrorMsg",        s:white,    s:red,      "bold")
call s:h("WarningMsg",      s:yellow,   "",         "none")
call s:h("Todo",            s:yellow,   s:bg,       "bold")

" --- Syntax Highlighting ---
call s:h("Comment",         s:brown,    "",         "none")
call s:h("String",          s:green,    "",         "none")
call s:h("Constant",        s:quartz,   "",         "none")
call s:h("Identifier",      s:fg_plus_1, "",         "none")
call s:h("Function",        s:niagara,  "",         "none")
call s:h("Statement",       s:yellow,   "",         "bold")
call s:h("Operator",        s:fg,       "",         "none")
call s:h("PreProc",         s:quartz,   "",         "none")
call s:h("Type",            s:quartz,   "",         "none")
call s:h("Keyword",         s:yellow,   "",         "bold")
call s:h("Underlined",      s:niagara,  "",         "underline")
call s:h("Special",         s:yellow,   "",         "none")

" --- Diff Highlighting ---
call s:h("DiffAdd",         s:green,    s:bg_plus_1,"none")
call s:h("DiffChange",      s:yellow,   s:bg_plus_1,"none")
call s:h("DiffDelete",      s:red_plus_1,s:bg_plus_1,"none")
call s:h("DiffText",        s:niagara,  s:bg_plus_2,"bold")

" --- Tabs ---
call s:h("TabLine",         s:bg_plus_4,s:bg_plus_1,"none")
call s:h("TabLineFill",     "",         s:bg_plus_1,"none")
call s:h("TabLineSel",      s:yellow,   s:bg,       "bold")

" --- Links ---
hi! link Character       String
hi! link Number          Constant
hi! link Boolean         Constant
hi! link Float           Constant
hi! link Conditional     Statement
hi! link Repeat          Statement
hi! link Label           Statement
hi! link Exception       Statement
hi! link Include         PreProc
hi! link Define          PreProc
hi! link Macro           PreProc
hi! link PreCondit       PreProc
hi! link StorageClass    Type
hi! link Structure       Type
hi! link Typedef         Type
hi! link SpecialKey      NonText
hi! link NonText         LineNr
