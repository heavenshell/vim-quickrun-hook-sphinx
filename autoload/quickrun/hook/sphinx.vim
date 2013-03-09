" File: sphinx.vim
" Author: Shinya Ohyanagi <sohyanagi@gmail.com>
" Version: 0.0.1
" WebPage: http://github.com/heavenshell/vim-quickrun-hook-sphinx/
" Description: QuickRun hook script for Sphinx build
" License: zlib License

let s:save_cpo = &cpo
set cpo&vim

let s:hook = {'config': {'enable': 0}}

function! quickrun#hook#sphinx#new()
  return deepcopy(s:hook)
endfunction

function! s:hook.on_module_loaded(session, context)
  if &filetype == 'rst'
    if has('win32') || has('win64')
      let path = findfile('make.bat', '.;')
    else
      let path = findfile('Makefile', '.;')
    endif
    let root_path = fnamemodify(path, ':p:h')

    let build_dir_name = 'build'
    let source_path = printf('%s/source', root_path)
    if !isdirectory(source_path)
      let source_path = '.'
      let build_dir_name = '_build'
    endif
    let build_path = printf('%s/%s/html', root_path, build_dir_name)
    let doctrees_path = printf('%s/%s/doctrees', root_path, build_dir_name)

    let new_cmdopt = printf('%s -d %s %s %s', a:session['config']['cmdopt'], doctrees_path, source_path, build_path)

    let a:session['config']['cmdopt'] = new_cmdopt
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
