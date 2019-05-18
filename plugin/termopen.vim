scriptencoding utf-8

if exists('g:loaded_termopen') && g:loaded_termopen
  finish
endif
let g:loaded_termopen = 1

let s:save_cpo = &cpo
set cpo&vim

if has('nvim')
  let s:supported_opencmd = [
        \ "edit",
        \ "drop",
        \ "split",
        \ "vsplit",
        \ "tabnew",
        \ ]
else
  let s:supported_opencmd = [
        \ "open",
        \ "edit",
        \ "drop",
        \ "split",
        \ "vsplit",
        \ "tabnew",
        \ ]
endif

if has('nvim')
  let s:opencmd_newcmd_mapping = {
        \ "edit": "enew",
        \ "drop": "enew",
        \ "split": "new",
        \ "vsplit": "vnew",
        \ "tabnew": "tabnew",
        \ }
else
  let s:opencmd_newcmd_mapping = {
        \ "open": "enew",
        \ "edit": "enew",
        \ "drop": "enew",
        \ "split": "new",
        \ "vsplit": "vnew",
        \ "tabnew": "tabnew",
        \ }
endif

function s:open(cmd, files)
  if len(a:files)
    execute s:opencmd_newcmd_mapping[a:cmd]
    return
  endif

  if count(s:supported_opencmd, a:cmd) == 1
    for f in a:files
      execute a:cmd f
    endfor
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
