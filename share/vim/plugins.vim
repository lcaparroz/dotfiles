"Automatically install vim-plug (plugin manager)
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'
Plug 'dense-analysis/ale'
Plug 'dominikduda/vim_current_word'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'fatih/vim-go'
Plug 'gkeep/iceberg-dark'
Plug 'hashivim/vim-terraform'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'keith/rspec.vim'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'mhinz/vim-signify'
Plug 'mracos/mermaid.vim'
Plug 'metakirby5/codi.vim'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'preservim/vimux'
Plug 'previm/previm'
Plug 'rhysd/git-messenger.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'rust-lang/rust.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tyru/open-browser.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-test/vim-test'
Plug 'vimwiki/vimwiki'

if has('macunix')
  if !empty(glob('/usr/local/opt/fzf'))
    Plug '/usr/local/opt/fzf'
  endif
endif

call plug#end()
