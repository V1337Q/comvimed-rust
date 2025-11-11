# comvimed
A vim plugin to run Rust main function and unit tests within the buffer.

<p align="center">
  <a href="https://github.com/V1337Q/comvimed-rust/stargazers">
    <img
      alt="Stargazers"
      src="https://img.shields.io/github/stars/V1337Q/comvimed-rust?style=for-the-badge&logo=starship&color=78dba9&logoColor=b6beca&labelColor=1a1e24"
    >
  </a>
  <a href="https://github.com/V1337Q/comvimed-rust/issues">
    <img
      alt="Issues"
      src="https://img.shields.io/github/issues/V1337Q/comvimed-rust?style=for-the-badge&logo=gitbook&color=70a5eb&logoColor=b6beca&labelColor=1a1e24"
    >
  </a>
</p>

![Alt text](./images/rust.gif)

## Installation

### Manual Installation

1.  Clone the repository
2.  Copy the directory [comvimed-rust] into 
```bash
~/.vim/plugged/
```

## Keymaps

You can actually customize the Keymaps inside the plugin folder. The default reads: 

```vim
nnoremap <silent> <leader>r :call comvimed#RunRust()<CR>

```


### `<leader>r` to run the main function


```vim
nnoremap <silent> <leader>u :call comvimed#FunctSearch()<CR>
```

### `<leader>u` to search for functions


```vim
nnoremap <silent> <leader>t :call comvimed#RunRustTests()<CR>
```
### `<leader>t` to run test functions
#### Or just change it to your liking :)

# Showcase

## Search for functions

![Alt text](./images/search_function.gif)

## Run main function

### Rust
![Alt text](./images/main_function.gif)

### C++
![Alt text](./images/cpp.gif)

### C
![Alt text](./images/c.gif)

### Python
![Alt text](./images/py.gif)

## And many much more languages.

## Run test funtions

![Alt text](./images/unit_tests.gif)


