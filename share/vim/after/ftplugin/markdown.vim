let g:ale_languagetool_options = '--autoDetect --level PICKY '
  \ . '--mothertongue pt-BR --disable '
  \ . join([
    \ 'ARROWS',
    \ 'COMMA_PARENTHESIS_WHITESPACE',
    \ 'DASH_RULE',
    \ 'EN_QUOTES',
    \ 'MULTIPLICATION_SIGN',
    \ 'PLUS_MINUS',
    \ 'SUPPORT',
    \ 'WORD_CONTAINS_UNDERSCORE',
    \ 'WHITESPACE_RULE',
    \ 'WRONG_APOSTROPHE'
    \ ], ',')
