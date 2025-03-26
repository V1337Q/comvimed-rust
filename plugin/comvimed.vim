autocmd FileType rust call comvimed#RenderPlayButton()

nnoremap <silent> <leader>r :call comvimed#RunRust()<CR>
nnoremap <silent> <leader>u :call comvimed#FunctSearch()<CR>
nnoremap <silent> <leader>t :call comvimed#RunRustTests()<CR>
call comvimed#GetRidOfUglyAssBlocks()
