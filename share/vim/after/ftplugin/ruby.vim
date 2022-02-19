set omnifunc=ale#completion#OmniFunc
set completeopt=menu,menuone,popup,noselect,noinsert
let b:ale_completion_enabled = 1

" vim-ruby configuration
let ruby_operators = 1
let ruby_pseudo_operators = 1
let ruby_space_errors = 1
let ruby_line_continuation_error = 1

let ruby_foldable_groups = 'ALL'
let ruby_fold = 1

autocmd Syntax ruby normal zR
