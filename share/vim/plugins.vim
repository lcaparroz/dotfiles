"Automatically install vim-plug (plugin manager)
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'mhinz/vim-signify'
Plug 'ryanoasis/vim-devicons'

Plug 'dense-analysis/ale'
Plug 'dominikduda/vim_current_word'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'metakirby5/codi.vim'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'preservim/vimux'
Plug 'previm/previm'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'turbio/bracey.vim', { 'do': 'npm install --prefix server' }
Plug 'tyru/open-browser.vim'
Plug 'vim-test/vim-test'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hashivim/vim-terraform'
Plug 'keith/rspec.vim'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'mattn/emmet-vim'
Plug 'mracos/mermaid.vim'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'vimwiki/vimwiki'

Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sainnhe/edge'
Plug 'sainnhe/gruvbox-material'

if has('macunix')
  if !empty(glob('/usr/local/opt/fzf'))
    Plug '/usr/local/opt/fzf'
  endif
endif

call plug#end()
