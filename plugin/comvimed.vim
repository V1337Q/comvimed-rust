autocmd FileType rust call comvimed#RenderPlayButton()

command! ComvimedHelp echo "press leader r to run main function"
command! ComvimedRunMain :call comvimed#RunRust()

nnoremap <silent> <leader>r :call comvimed#RunRust()<CR>
nnoremap <silent> <leader>u :call comvimed#FunctSearch()<CR>
nnoremap <silent> <leader>t :call comvimed#RunRustTests()<CR>
nnoremap <silent> <leader>h :below terminal<CR>
nnoremap <silent> <leader>x :call comvimed#Runs()<CR>
nnoremap <silent> <leader>f :call comvimed#cUnitTestRun()<CR>
" nnoremap <silent> <leader>. :call comvimed#KotlinComp()<CR>

call comvimed#GetRidOfUglyAssBlocks()
