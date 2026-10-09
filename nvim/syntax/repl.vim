" Vim syntax file
" Language: Renode platform description (.repl)
" Follows Renode's own parser: src/Renode/PlatformDescription/Syntax/Grammar.cs

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Comments (handled by Renode's prelexer)
syn keyword replTodo contained TODO FIXME XXX NOTE
syn match   replComment "//.*$" contains=replTodo,@Spell
syn region  replComment start="/\*" end="\*/" contains=replTodo,@Spell

" Keywords
syn keyword replUsing using nextgroup=replString skipwhite
syn keyword replKeyword new as local
syn keyword replConstant none empty
syn keyword replBoolean true false True False

" Entry header: `[local] name: Type.Name @ ...`. Entries start in column 0;
" indented `name:` lines are constructor arguments or properties.
syn match replEntryName "^\(local\s\+\)\=\h\w*\ze\s*:" contains=replKeyword nextgroup=replEntryColon
syn match replEntryColon ":" contained nextgroup=replType skipwhite
syn match replType "\h\w*\(\.\h\w*\)*" contained
syn match replProperty "^\s\+\zs\h\w*\ze\s*:"

" Registration: `@ sysbus 0x1000`, `@ { sysbus 0x1; other 0x2 }`, `@ none`
syn match replAt "@" nextgroup=replRegister,replConstant skipwhite
syn match replRegister "\h\w*" contained

" IRQ wiring: `0 -> gic@1 | nvic@2`, `[0-3] -> gic@[4-7]`, `IRQ -> nvic#1@5`
syn match replOperator "->\||\|#"

" Values
syn match replNumber "-\=\<0x\x\+\(_\x\+\)*\>"
syn match replNumber "-\=\<\d\+\(_\d\+\)*\(\.\d\+\)\=\>"
syn match replEnum "\(\w\)\@<!\.\h\w*"
syn region replRange matchgroup=replDelimiter start="<" end=">" oneline contains=replNumber,replOperatorPlus
syn match replOperatorPlus "+" contained
syn region replString start=+"+ skip=+\\[\\"]+ end=+"+ contains=@Spell
syn region replString start=+'''+ skip=+\\'''+ end=+'''+ contains=@Spell

" preinit / init / reset blocks hold Monitor commands. A block ends at the first
" non-blank line indented no deeper than the keyword.
syn match replSectionKeyword "^\s*\zs\(preinit\|init\|reset\)\(\s\+add\)\=\ze\s*:"
if !exists("b:resc_including_repl")
  let b:repl_including_resc = 1
  syn include @replResc syntax/resc.vim
  unlet b:repl_including_resc
  unlet! b:current_syntax
  syn region replSection matchgroup=replSectionKeyword
        \ start="^\z(\s*\)\(preinit\|init\|reset\)\(\s\+add\)\=\s*:\s*$"
        \ end="^\%(\z1\s\)\@!\ze\s*\S"
        \ contains=replComment,@replResc keepend
endif

" Files are small; parse from the top so multi-line regions are never lost
syn sync fromstart

hi def link replTodo           Todo
hi def link replComment        Comment
hi def link replUsing          Include
hi def link replKeyword        Keyword
hi def link replConstant       Constant
hi def link replBoolean        Boolean
hi def link replEntryName      Identifier
hi def link replType           Type
hi def link replProperty       Label
hi def link replAt             Operator
hi def link replRegister       Special
hi def link replOperator       Operator
hi def link replOperatorPlus   Operator
hi def link replNumber         Number
hi def link replEnum           Constant
hi def link replDelimiter      Delimiter
hi def link replString         String
hi def link replSectionKeyword Statement

let b:current_syntax = "repl"

let &cpo = s:cpo_save
unlet s:cpo_save
