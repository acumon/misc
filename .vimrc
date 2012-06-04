" 我的部分.vimrc配置，资源多来源于网上。没上传的部分主要是一些imap, map定制的快捷键。
"
" 设置字符编码。参考：http://www.rainux.org/blog/index.php/2005/10/20/106

" encoding: Vim 内部使用的字符编码方式，包括 Vim 的 buffer (缓冲区)、菜单文
" 本、消息文本等。用户手册上建议只在 .vimrc 中改变它的值，事实上似乎也只有
" 在 .vimrc 中改变它的值才有意义。
"
" 由于 Unicode 能够包含几乎所有的语言的字符，而且 Unicode 的 UTF-8 编码方式
" 又是非常具有性价比的编码方式 (空间消耗比 UCS-2 小)，因此建议 encoding 的
" 值设置为 utf-8。这么做的另一个理由是 encoding 设置为 utf-8 时，Vim 自动探
" 测文件的编码方式会更准确 (或许这个理由才是主要的)。
set encoding=utf-8
set fileencodings=utf-8,chinese ",cs-bom,utf-8
" fileencodings: Vim 启动时会按照它所列出的字符编码方式逐一探测即将打开的文
" 件的字符编码方式，并且将 fileencoding 设置为最终探测到的字符编码方式。因
" 此最好将 Unicode 编码方式放到这个列表的最前面。
"
" 拉丁语系编码方式 latin1 最好去掉。因为如果有 latin-1，在文件中有多种编码
" 方式的内容时 (比如，a 为 utf-8 编码的中文文本文件，b 为 cp936 编码的中文
" 文本文件，执行命令 cat b >> a 后的 a 文件)，最后 Vim 会将文件编码设为
" latin-1，导致最终非英文内容显示完全乱码。
"set fileencodings=utf-8,chinese,latin-1
set fileencoding=utf-8
" fileencoding: Vim 中当前编辑的文件的字符编码方式，Vim 保存文件时也会将文
" 件保存为这种字符编码方式。
"
" 如果打开的是已有的文件，则 Vim 会将 fileencoding 设置为上面探测到的字符编
" 码，此处的设置不再有效；如果是新文件，则此处的 fileencoding 生效。

" termencoding: Vim 所工作的终端 (或者 Windows 的 Console 窗口) 的字符编码
" 方式。这个选项对 GUI 模式的 gVim 无效，而对 Console 模式的 Vim 而言就是
" Windows 控制台的代码页 (对于 Windows 而言)，并且通常我们不需要改变它。
"
" 下面这句只影响普通模式 (非图形界面) 下的 Vim。
set termencoding=utf-8

" 一般而言，在字符编码配置正确的情况下，是不会出现乱码问题的。
" 万一不幸菜单乱码 (比如，locale 设置为 zh_CN.UTF-8 而 encoding 却设置为
" cp936 时。当然，此时最好的方法还是将 encoding 设置为 utf-8) ，请取消下
" 面两行语句的注释。
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 设置图形界面。
"
" 字体部分，可参考《程序员最喜欢用的编程字体》一文：
" http://www.2maomao.com/blog/best-programmer-fonts/

if has("gui_running")
    if has("win32")
        " 设定 windows 下 gvim 启动时最大化
        autocmd GUIEnter * simalt ~x
        " 设定 windows 下图形界面下的字体。该字体需要自己下载安装，下载地址：
        " http://ftp.gnome.org/pub/GNOME/sources/ttf-bitstream-vera/1.10/ttf-bitstream-vera-1.10.zip
        set guifont=Bitstream_Vera_Sans_Mono:h14:cANSI
    else
        " 设定 linux 下图形界面下的字体，该字体 Fedora 7 自带
       " set guifont=DejaVu\ LGC\ Sans\ Mono\ 14
        set guifont=Bitstream_Vera_Sans_Mono:h14:cANSI
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_running")
    colorscheme desert "or koehler
else
    colorscheme evening 
endif
"evening         " 设定背景为夜间模式
filetype plugin on          " 自动识别文件类型，自动匹配对应的
                            " “文件类型Plugin.vim”文件，使用缩进定义文件
set ambiwidth=double        " ambiwidth 默认值为 single。在其值为 single 时，
                            " 若 encoding 为 utf-8，gvim 显示全角符号时就会
                            " 出问题，会当作半角显示。
set autochdir               " 自动切换当前目录为当前文件所在的目录
set autoindent cindent cinoptions=g0
                            " 打开自动缩进和 C 语言风格的缩进模式，
                            " 定制 C 语言缩进风格
set backspace=indent,eol,start
                            " 不设定的话在插入状态无法用退格键和 Delete
                            " 键删除回车符
set backupcopy=yes          " 设置备份时的行为为覆盖

if v:version >= 700
    set completeopt=menu,longest,preview
                            " 自动补全(ctrl-p)时的一些选项：
                            " 多于一项时显示菜单，最长选择，
                            " 显示当前选择的额外信息
endif

set fileformat=unix         " unix|dos|mac
set confirm                 " 用确认对话框（对于 gvim）或命令行选项（对于
                            " vim）来代替有未保存内容时的警告信息
set display=lastline        " 长行不能完全显示时显示当前屏幕能显示的部分。
                            " 默认值为空，长行不能完全显示时显示 @。
set expandtab               " 将 tab 键转换为空格
set formatoptions=tcqro     " 使得注释换行时自动加上前导的空格和星号
set hidden                  " 允许在有未保存的修改时切换缓冲区，
                            " 此时的修改由切换由 vim 负责保存
set history=500             " 设置冒号命令和搜索命令的命令历史列表的长度为 50
set hlsearch                " 搜索时高亮显示被找到的文本
set ignorecase smartcase    " 搜索时忽略大小写，但在有一个或以上大写字母时
                            " 仍保持对大小写敏感
set incsearch               " 输入搜索内容时就显示搜索结果
set mouse=a                 " 设定在任何模式下鼠标都可用
set nobackup                " 覆盖文件时不备份
set nocompatible            " 设定 gvim 运行在增强模式下
set noignorecase            " 默认区分大小写
set nolinebreak             " 在单词中间断行
set number                  " 显示行号
set ruler                   " 打开状态栏标尺
set scrolloff=5             " 设定光标离窗口上下边界 5 行时窗口自动滚动
set shiftwidth=4            " 设定 << 和 >> 命令移动时的宽度为 4
set showcmd                 " 在状态栏显示目前所执行的指令，未完成的指令片段亦
                            " 会显示出来
set softtabstop=4           " 使得按退格键时可以一次删掉 4 个空格
                            " （不足 4 个时删掉所有剩下的空格）
set tabstop=4               " 设定 tab 长度为 4
set whichwrap=b,s,<,>,[,]   " 设定退格键、空格键以及左右方向键在行首行尾时的
                            " 行为，不影响 h 和 l 键
set nowrap                  " 自动换行显示
syntax on                   " 自动语法高亮

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 设置命令行和状态栏

set cmdheight=1            " 设定命令行的行数为 1
set laststatus=2            " 显示状态栏 (默认值为 1, 无法显示状态栏)
set statusline=%F%m%r\ \|\ %Y,%{&fileencoding}\ \|%=\ %l/%L,%c\ \|\ %f
                            " 设置在状态行显示的信息如下：
                            " %f    当前的文件名
                            " %F    当前全路径文件名
                            " %m    当前文件修改状态
                            " %r    当前文件是否只读
                            " %Y    当前文件类型
                            " %{&fileformat}
                            "       当前文件编码
                            " %{&fileencoding}
                            "       中文编码
                            " %b    当前光标处字符的 ASCII 码值
                            " %B    当前光标处字符的十六进制值
                            " %l    当前光标行号
                            " %c    当前光标列号
                            " %V    当前光标虚拟列号 (根据字符所占字节数计算)
                            " %p    当前行占总行数的百分比
                            " %%    百分号
                            " %L    当前文件总行数

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 自动命令

" 读文件时自动设定当前目录为刚读入文件所在的目录
autocmd BufReadPost * cd %:p:h

"cscope
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif
"for omnicppcomplete
set nocp
let OmniCpp_MayCompleteScope = 1
let OmniCpp_ShowPrototypeInAbbr = 1

"auto-close proview
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"temp"


