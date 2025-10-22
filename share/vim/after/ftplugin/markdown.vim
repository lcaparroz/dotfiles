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

let g:tagbar_type_markdown = {
  \ 'ctagstype'	: 'markdown',
  \ 'kinds'		: [
    \ 'c:chapter:0:1',
    \ 's:section:0:1',
    \ 'S:subsection:0:1',
    \ 't:subsubsection:0:1',
    \ 'T:l4subsection:0:1',
    \ 'u:l5subsection:0:1',
  \ ],
  \ 'sro'			: '""',
  \ 'kind2scope'	: {
    \ 'c' : 'chapter',
    \ 's' : 'section',
    \ 'S' : 'subsection',
    \ 't' : 'subsubsection',
    \ 'T' : 'l4subsection',
  \ },
  \ 'scope2kind'	: {
    \ 'chapter' : 'c',
    \ 'section' : 's',
    \ 'subsection' : 'S',
    \ 'subsubsection' : 't',
    \ 'l4subsection' : 'T',
  \ },
\ }
