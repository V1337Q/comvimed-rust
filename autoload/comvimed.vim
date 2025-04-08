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
		echom "running command: "
		redraw
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

" function! comvimed#cCompile()
" 	" let l:name_file = buffname("%")
" 	let l:file_name = expand('%:t')
" 	let l:file_name_noex = expand('%:t:r')

" 	" let l:condition = 1

" 	" if l:condition
" 	" nnoremap <silent> <leader>n :call comvimed#cCompile()<CR>
" 		below terminal
" 		call feedkeys("g++ " . l:file_name . " -o " . l:file_name_noex . "\<CR>" )

" 		call feedkeys("./" . l:file_name_noex . "\<CR>")
" 	" call feedkeys("./comvimed")
" " endif
" endfunction

" function! comvimed#actionControl()
" 	if &filetype == 'cpp'
" 		call comvimed#cCompile()
" 	elseif &filetype == 'rust'
" 		call comvimed#RunRust()
" 	else 
" 		echo "No action"
" endif
" endfunction
function! comvimed#Runs()
	let filetype_actions = {
				\ 'cpp': 'comvimed#CppCompile',
				\ 'rust': 'comvimed#RunRust',
				\ 'python': 'comvimed#PythonComp',
				\ 'go': 'comvimed#GoComp',
				\ 'c': 'comvimed#cComp',
				\ 'java': 'comvimed#JavaComp',
				\ 'asm': 'comvimed#AsmComp',
				\ 'lua': 'comvimed#LuaComp',
				\ 'kotlin': 'comvimed#KotlinComp',
				\ 'ruby': 'comvimed#RubyCompile'
				\ }

	if has_key(filetype_actions, &filetype)
		call function(filetype_actions[&filetype])()
	else
		echo "Action not available yet."
	endif
endfunction

function! comvimed#CppCompile()
	let l:file_name = expand('%t')
	let l:file_name_without_file_type = expand('%:t:r')

	below terminal
	call feedkeys("g++ " . l:file_name . " -o " . l:file_name_without_file_type . "\<CR>")
	call feedkeys("./" .l:file_name_without_file_type . "\<CR>")
endfunction

function! comvimed#PythonComp()
	let l:file_name_py = expand('%t')
	" let l:file_name_py_noex = expand('%:t:r')

	below terminal
	call feedkeys("python " . l:file_name_py . "\<CR>")

endfunction

function! comvimed#PyRunUnitTests()
	if executable('pytest')
		call feedkeys("pytest \<CR>")
	elseif executable('pacman')
		call feedkeys("sudo pacman -S pytest \<CR>")
		call feedkeys("pytest")
	elseif executable('apt')
		call feedkeys("sudo apt install pytest \<CR>")
	elseif executable('dnf')
		call feedkeys("dnf install pytest")
	else 
		echo "Package manager not supported yet :("
endif
endfunction


function! comvimed#GoComp()
	let l:file_name_go = expand('%t')
	let l:file_name_go_noex = expand('%:t:r')

	below terminal
	call feedkeys("go build " . l:file_name_go . "\<CR>")
	call feedkeys("./" . l:file_name_go_noex . "\<CR>")

endfunction

function! comvimed#cComp()
	let l:file_name_c = expand('%t')
	let l:file_name_c_noex = expand('%:t:r')

	below terminal
	call feedkeys("gcc " .l:file_name_c . " -o " . l:file_name_c_noex . "\<CR>")
	echo "running command: "
	call feedkeys("./" . l:file_name_c_noex . "\<CR>")
endfunction

function! comvimed#cUnitTestRun()
	let files = readdir(getcwd())
	let first_file = files[0]
	echo first_file
endfunction

"files[0] – first file

"files[-1] – last file

"len(files) – total number of files

"index(files, 'somefile.txt') – find the index of a specific file

function! comvimed#JavaComp()
	let l:file_name_java = expand('%t')
	let l:file_name_java_noex = expand('%:t:r')

	below terminal
	call feedkeys("javac " . l:file_name_java . "\<CR>")
	call feedkeys("java " . l:file_name_java_noex . "\<CR>")

endfunction

function! comvimed#AsmComp()
	let l:file_name_asm = expand('%t')
	let l:file_name_asm_noex = expand('%:t:r')

	below terminal
	call feedkeys("nasm -f elf64 -o " . l:file_name_asm_noex . ".o " . l:file_name_asm . "\<CR>")
	call feedkeys("ld -o " . l:file_name_asm_noex . " " . l:file_name_asm_noex . ".o\<CR>")
	call feedkeys("chmod +x " . l:file_name_asm_noex . "\<CR>")
	call feedkeys("./" . l:file_name_asm_noex . "\<CR>")
endfunction

function! comvimed#LuaComp()
	let l:file_name_lua = expand('%t')
	" let l:file_name_lua_noex = expand('%:t:r')

	below terminal
	call feedkeys("lua " . l:file_name_lua . "\<CR>")
endfunction

" kotlinc hello.kt -include-runtime -d hello.jar
" java -jar hello.jar


function! comvimed#KotlinComp()
	let l:file_name_kt = expand('%t')
	let l:file_name_kt_noex = expand('%:t:r')

	below terminal
	call feedkeys("kotlinc " . l:file_name_kt . " -include-runtime -d " . l:file_name_kt_noex . ".jar \<CR>")
	call feedkeys("java -jar " . l:file_name_kt_noex . ".jar \<CR>")
endfunction

function! comvimed#RubyCompile()
	let l:file_name_rb = expand('%t')
	" let l:file_name_rb_noex = expand('%:t:r')

	below terminal
	call feedkeys("ruby " . l:file_name_rb . "\<CR>")
endfunction

function! comvimed#RunTestC()
	let l:current_line = getline('.')
	let files = readdir(getcwd())
	let first_file = files[0]

	if l:current_line =~ '^\s*\def'

		below terminal
		call feedkeys("gcc " . l:test_name .  "\<CR>")
	else
		echo "No unit test found at the cursor position."
	endif
endfunction

function! comvimed#UnitTestRuns()
	let filetype_actions = {
				\ 'cpp': 'comvimed#CppCompile',
				\ 'rust': 'comvimed#RunRustTests',
				\ 'python': 'comvimed#PythonComp',
				\ 'go': 'comvimed#GoComp',
				\ 'c': 'comvimed#cComp',
				\ 'java': 'comvimed#JavaComp',
				\ 'asm': 'comvimed#AsmComp',
				\ 'lua': 'comvimed#LuaComp',
				\ 'kotlin': 'comvimed#KotlinComp',
				\ 'ruby': 'comvimed#RubyCompile'
				\ }

	if has_key(filetype_actions, &filetype)
		call function(filetype_actions[&filetype])()
	else
		echo "Filetype does not available yet."
	endif
endfunction

" function! comvimed#UnitTestRuns() 
" 	if &filetype == 'rust'
" 		call comvimed#RunRustTests()
" 	else
" 		echo "No unit tests found"
" endif
" endfunction


