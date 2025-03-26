function! comvimed#FindMainFunction()
    let l:main_line = search('fn\s\+main\s*()', 'nw')
    if l:main_line > 0
        return l:main_line
    else
        return 0
    endif
endfunction

function! comvimed#FunctSearch()
    let l:UnitTest = search('^\s*#\[test\]\|^\s*fn\s\+\w\+\s*()', 'w')
endfunction

command! RustTests call FunctSearch()


function! comvimed#RenderPlayButton()
    let l:main_line = comvimed#FindMainFunction()
    if l:main_line > 0
        sign define PlayButton text= texthl=Comment
        execute 'sign place 1 line=' . l:main_line . ' name=PlayButton buffer=' . bufnr('%')
    endif
endfunction

function! comvimed#RunRust()
    if filereadable('Cargo.toml')
        below terminal
        call feedkeys("cargo run\<CR>")
    else
        echo "Cargo.toml not found in the current directory."
    endif
endfunction

function! comvimed#RunRustTests()
    let l:current_line = getline('.')
    let l:next_line = getline(line('.') + 1)

    if l:current_line =~ '^\s*#\[test\]' && l:next_line =~ '^\s*fn\s\+\w\+\s*('
        let l:test_name = matchstr(l:next_line, '^\s*fn\s\+\zs\w\+\ze\s*(')
        
        below terminal
        call feedkeys("cargo test " . l:test_name . " -- --exact --show-output\<CR>")
    elseif l:current_line =~ '^\s*fn\s\+\w\+\s*(' && getline(line('.') - 1) =~ '^\s*#\[test\]'
        let l:test_name = matchstr(l:current_line, '^\s*fn\s\+\zs\w\+\ze\s*(')
        
        below terminal
        call feedkeys("cargo test " . l:test_name . " -- --exact --show-output\<CR>")
    else
        echo "No unit test found at the cursor position."
    endif
endfunction

function! comvimed#GetRidOfUglyAssBlocks()
  highlight SignColumn ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE

  if !exists('g:yourplugin_highlights_defined')
    let g:yourplugin_highlights_defined = 1
    highlight! link SignColumn LineNr
  endif
endfunction
