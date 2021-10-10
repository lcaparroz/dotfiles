"Automatically install vim-plug (plugin manager)
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go'
Plug 'hashivim/vim-terraform'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'keith/rspec.vim'
Plug 'mracos/mermaid.vim'
Plug 'metakirby5/codi.vim'
Plug 'preservim/tagbar'
Plug 'preservim/vimux'
Plug 'ryanoasis/vim-devicons'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-test/vim-test'
Plug 'vimwiki/vimwiki'

if has('macunix')
  if !empty(glob('/usr/local/opt/fzf'))
    Plug '/usr/local/opt/fzf'
  endif
endif

call plug#end()
