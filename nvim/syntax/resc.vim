" Vim syntax file
" Language: Renode Monitor script (.resc)
" Follows Renode's Monitor tokenizer:
" src/Infrastructure/src/Emulator/Extensions/UserInterface/Tokenizer/Tokenizer.cs

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" `#` starts a comment only at the start of a token
syn keyword rescTodo contained TODO FIXME XXX NOTE
syn match   rescComment "\(^\|\s\|;\)\zs#.*$" contains=rescTodo,@Spell
" `:name:` / `:description:` script metadata
syn match   rescMetadata "^\s*:.*$"

" First word of a command: a built-in Monitor command or a peripheral/object name
syn match rescObject "\(^\|;\)\s*\zs[A-Za-z_][[:alnum:]_.\-?]*" contains=rescCommand
syn keyword rescCommand contained
      \ alias allowPrivates analyzers createPlatform currentTime displayImage
      \ execute help i include lastLog log logFile logLevel mach macro
      \ numbersMode p path pause peripherals printenv python q quit require
      \ resd reverseExecMode runMacro s set setAndRevertAfter showAnalyzer
      \ start string tags trace using verboseMode version w watch

" Method or property after the object name: `sysbus LoadELF ...`
syn match rescMethod "\(\(^\|;\)\s*[A-Za-z_][[:alnum:]_.\-?]*\s\+\)\@<=\u\w*"

syn match rescVariable "\$[[:alnum:]_.]\+"
syn match rescOperator "?\==\|;\|,"
syn match rescPath "@\(\\ \|[^[:space:];]\)\+"
syn region rescExecution start="`" end="`" oneline contains=rescVariable

syn match rescNumber "\<0x\x\+\>"
syn match rescNumber "[+-]\=\<\d\+\(\.\d*\)\=\(e[+-]\=\d\+\)\=\>"
syn match rescNumber "\<\(\(\d\+:\)\=\d\+:\)\d\+\(\.\d\+\)\=\>"
syn keyword rescBoolean true false True False
syn keyword rescConstant null
syn region rescRange matchgroup=rescDelimiter start="<\ze\s*\(0x\|[+-]\=\d\)" end=">" oneline contains=rescNumber
syn region rescList matchgroup=rescDelimiter start="\[" end="\]" transparent

syn region rescString start=+"+ skip=+\\.+ end=+"+ oneline contains=rescVariable
syn region rescString start=+'+ skip=+\\.+ end=+'+ oneline
syn region rescString start=+"""+ end=+"""+ contains=rescVariable

" `LoadPlatformDescriptionFromString """ ... """` embeds a .repl description
if !exists("b:repl_including_resc")
  let b:resc_including_repl = 1
  syn include @rescRepl syntax/repl.vim
  unlet b:resc_including_repl
  unlet! b:current_syntax
  " preinit/init/reset blocks of the embedded description hold Monitor commands again
  syn region rescReplSection contained matchgroup=replSectionKeyword
        \ start="^\z(\s*\)\(preinit\|init\|reset\)\(\s\+add\)\=\s*:\s*$"
        \ end="^\%(\z1\s\)\@!\ze\s*\S" end=+\ze"""+
        \ contains=TOP keepend
  syn cluster rescRepl add=rescReplSection
  syn region rescReplString matchgroup=rescString
        \ start=+\(LoadPlatformDescriptionFromString\s\+\)\@<="""+ end=+"""+
        \ contains=@rescRepl keepend
endif

" Files are small; parse from the top so multi-line regions are never lost
syn sync fromstart

hi def link rescTodo      Todo
hi def link rescComment   Comment
hi def link rescMetadata  PreProc
hi def link rescObject    Identifier
hi def link rescCommand   Statement
hi def link rescMethod    Function
hi def link rescVariable  PreProc
hi def link rescOperator  Operator
hi def link rescPath      Include
hi def link rescExecution Special
hi def link rescNumber    Number
hi def link rescBoolean   Boolean
hi def link rescConstant  Constant
hi def link rescDelimiter Delimiter
hi def link rescString    String

let b:current_syntax = "resc"

let &cpo = s:cpo_save
unlet s:cpo_save
