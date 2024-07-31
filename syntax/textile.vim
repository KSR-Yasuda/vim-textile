"
"   You will have to restart vim for this to take effect.  In any case
"   it is a good idea to read ":he new-filetype" so that you know what
"   is going on, and why the above lines work.
"
"   Written originally by Dominic Mitchell, Jan 2006.
"   happygiraffe.net
"
"   Modified by Aaron Bieber, May 2007.
"   blog.aaronbieber.com
"
"   Modified by Tim Harper, July 2008 - current
"   tim.theenchanter.com
" @(#) $Id$

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" Textile commands like "h1" are case sensitive, AFAIK.
syn case match

" Textile syntax: <http://textism.com/tools/textile/>

" Inline elements.
syn match  txtEmphasis    /\(^\|[[:space:]*\-+^~(]\)\zs_\([^[:space:]_]\|\n\).\{-}\(\n\s*[^[:space:]].\{-}\)*\n\?_\ze\([[:space:]*\-+^~.,:;/<()[\]{}!?"''#&]\|$\)/
syn match  txtBold        /\(^\|[[:space:]_\-+^~(]\)\zs\*\([^[:space:]*]\|\n\).\{-}\(\n\s*[^[:space:]].\{-}\)*\n\?\*\ze\([[:space:]_\-+^~.,:;/<()[\]{}!?"'#&]\|$\)/
syn match  txtCite        /\(^\|[[:space:]_*\-+^~(]\)\zs??\([^[:space:]]\|\n\).\{-}\(\n\s*[^[:space:]].\{-}\)*\n\???\ze\([[:space:]_*\-+^~.,:;/<()[\]{}!?"'#&]\|$\)/
syn match  txtDeleted     /\(^\|[[:space:]_*+^~(]\)\zs-\([^[:space:]-]\|\n\).\{-}\(\n\s*[^[:space:]].\{-}\)*\n\?-\ze\([[:space:]_*+^~.,:;/<()[\]{}!?"'#&]\|$\)/
syn match  txtInserted    /\(^\|[[:space:]_*\-^~(]\)\zs+\([^[:space:]+]\|\n\).\{-}\(\n\s*[^[:space:]].\{-}\)*\n\?+\ze\([[:space:]_*\-^~.,:;/<()[\]{}!?"'#&]\|$\)/
syn match  txtSuper       /\(^\|[[:space:]_*\-+~(]\)\zs\^\([^[:space:]^]\|\n\).\{-}\(\n\s*[^[:space:]].\{-}\)*\n\?\^\ze\([[:space:]_*\-+~.,:;/<()[\]{}!?"'#&]\|$\)/
syn match  txtSub         /\(^\|[[:space:]_*\-+^(]\)\zs\~\([^[:space:]~]\|\n\).\{-}\(\n\s*[^[:space:]].\{-}\)*\n\?\~\ze\([[:space:]_*\-+^.,:;/<()[\]{}!?"'#&]\|$\)/
syn match  txtSpan        /\(^\|[[:space:]_*\-+^~(]\)\zs%\([^[:space:]%]\|\n\).\{-}\(\n\s*[^[:space:]].\{-}\)*\n\?%\ze\([[:space:]_*\-+^~.,:;/<()[\]{}!?"'#&]\|$\)/
syn match  txtFootnoteRef /\[[0-9]\+]/
syn match  txtCode        /@\([^[:space:]@]\|\n\).\{-}\(\n\s*[^[:space:]].\{-}\)*\n\?@/
syn region txtCode        start='<code\(\s[^>]*\)\?>' end='</code>'

" Block elements.
syn match  txtHeader      /^h1\. .\+/
syn match  txtHeader2     /^h2\. .\+/
syn match  txtHeader3     /^h[3-6]\..\+/
syn match  txtBlockquote  /^bq\./
syn match  txtFootnoteDef /^fn[0-9]\+\./
syn match  txtListBullet  /\v^\*+ /
syn match  txtListBullet2 /\v^(\*\*)+ /
syn match  txtListNumber  /\v^#+ /
syn match  txtListNumber2 /\v^(##)+ /
syn region txtCodeBlock   start='<pre\(\s[^>]*\)\?>' end='</pre>'

syn cluster txtBlockElement contains=txtHeader,txtBlockElement,txtFootnoteDef,txtListBullet,txtListNumber


" Everything after the first colon is from RFC 2396, with extra
" backslashes to keep vim happy...  Original:
" ^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?
"
" Revised the pattern to exclude spaces from the URL portion of the
" pattern. Aaron Bieber, 2007.
syn match txtLink /"[^"]\+":\(\([^:\/?# ]\+\):\)\?\(\/\/\([^\/?# ]*\)\)\?\([^?# ]*\)\(?\([^# ]*\)\)\?\(#\([^ ]*\)\)\?/

syn cluster txtInlineElement contains=txtEmphasis,txtBold,txtCite,txtDeleted,txtInserted,txtSuper,txtSub,txtSpan

if version >= 508 || !exists("did_txt_syn_inits")
    if version < 508
        let did_txt_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink txtHeader Title
    HiLink txtHeader2 Question
    HiLink txtHeader3 Statement
    HiLink txtBlockquote Comment
    HiLink txtListBullet Operator
    HiLink txtListBullet2 Constant
    HiLink txtListNumber Operator
    HiLink txtListNumber2 Constant
    HiLink txtLink String
    HiLink txtCode Identifier
    HiLink txtCodeBlock txtCode
    HiLink txtCite Keyword
    HiLink txtSuper Special
    HiLink txtSub Special
    HiLink txtSpan String
    HiLink txtFootnoteRef Tag
    HiLink txtFootnoteDef Tag
    hi def txtEmphasis term=underline,italic cterm=underline,italic gui=italic
    hi def txtBold term=bold cterm=bold gui=bold
    hi def txtDeleted term=strikethrough cterm=strikethrough gui=strikethrough
    hi def txtInserted term=underline cterm=underline gui=underline

    delcommand HiLink
endif

" vim: set ai et sw=4 :
