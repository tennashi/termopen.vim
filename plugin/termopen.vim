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

function! Tapi_open(bufnr, args)
  if len(a:args) < 1
    return
  endif

  call s:open(a:args[0], a:args[1:])
endfunction

function! Tapi_open_wait(bufnr, args)
  if len(a:args) < 1
    return
  endif

  call s:open_wait(a:args[0], a:args[1:])
endfunction

function! s:open(cmd, files)
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

let s:is_leave = v:false

function! s:open_wait(cmd, files)
  call s:open(cmd, files)
  augroup TermOpen
    autocmd! * <buffer>
    autocmd BufUnload <buffer> :call <SID>leave()
    autocmd QuitPre <buffer> :call <SID>leave()
  augroup END

  while s:is_leave
  endwhile
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
