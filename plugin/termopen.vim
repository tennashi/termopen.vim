scriptencoding utf-8

if exists('g:loaded_termopen') && g:loaded_termopen
  finish
endif
let g:loaded_termopen = 1

let s:save_cpo = &cpo
set cpo&vim

let s:supported_opencmd = [
      \ "open",
      \ "edit",
      \ "drop",
      \ "split",
      \ "vsplit",
      \ "tabnew",
      \ ]

let s:opencmd_newcmd_mapping = {
      \ "open": "enew",
      \ "edit": "enew",
      \ "drop": "enew",
      \ "split": "new",
      \ "vsplit": "vnew",
      \ "tabnew": "tabnew",
      \ }

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

  call s:open(a:args[0], a:args[2:])
  call s:wait(a:bufnr, a:args[1])
endfunction

function! s:open(cmd, files)
  if len(a:files) == 0
    execute s:opencmd_newcmd_mapping[a:cmd]
    return
  endif

  if count(s:supported_opencmd, a:cmd) == 1
    for f in a:files
      echo f
      execute a:cmd f
    endfor
  endif
endfunction

function! s:wait(bufnr, res_id)
  let b:cur_bufnr = a:bufnr
  let b:res = "{\"res_id\":" .. a:res_id .. ",\"res\":\"done\"}\<CR>"
  augroup TermOpen
    autocmd! * <buffer>
    autocmd BufUnload <buffer> :call term_sendkeys(b:cur_bufnr, b:res)
    autocmd QuitPre <buffer> :call term_sendkeys(b:cur_bufnr, b:res)
  augroup END
endfunction

function! s:leave(cmd, files)
  let b:is_leave = v:true
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
