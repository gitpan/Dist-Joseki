# If not running interactively, then exit
if [ -n "$PS1" ]; then

test -f ~/.bashrc_site_before && source ~/.bashrc_site_before
test -f /sw/bin/init.sh && . /sw/bin/init.sh
source ~/.aliases

# speeding up text selection: The colon is a no-op for the Bourne family
# of shells. So just select whole lines and paste; with conventional
# prompts you have to be careful not to select the prompt as well.

set_prompt () {
    export PS1=": \u@\h \W; "
    export PS2=":; "
}

# append commands from all terminals into the history file immediately
shopt -s histappend
PROMPT_COMMAND='history -a'

stty sane 2>/dev/null
stty erase ^?
umask 022

IGNORE_EOF=1

export LESSCHARSET=iso8859
export EDITOR=/usr/bin/vim
export CVSEDITOR=/usr/bin/vim
export CVS_RSH=ssh
export PAGER=less
export TEST_MODE=1
#export LC_COLLATE=C
export DISPLAY=:0.0
export TEST_AUTHOR=1
export PROJROOT
export PTAGSFILE=~/.ptags
# for iTerm:
export TERM=linux

export CPPFLAGS
for d in /{sw,usr/local}/include
do
    test -d $d && CPPFLAGS="-I$d $CPPFLAGS"
done

export LDFLAGS
for d in /{sw,usr/local}/lib
do
    test -d $d && LDFLAGS="-L$d $LDFLAGS"
done

# remove domain name from hostname, if domain name
# is in hostname (otherwise, just hostname).
export HOSTNAME=`hostname | sed s/\\\..\*//g`

export PATH
export MANPATH
for d in /usr /{usr,opt}/{local,share,local/share,local/pgsql,git,git/share} ~{,/home,/perl}
do
    test -d $d/bin && PATH=$d/bin:$PATH
    test -d $d/man && MANPATH=$d/man:$MANPATH
done

TESTPATH=/usr/local/teTeX/bin/i386-apple-darwin-current
test -d $TESTPATH && PATH=$TESTPATH:$PATH

LESSPIPE=`which lesspipe.sh`
[[ $LESSPIPE ]] && export LESSOPEN="|$LESSPIPE %s"

IGNOREEOF=1  # so first ^D doesn't logout, second ^D does

cd () {
    builtin cd "$*"
    ls --color=auto
}

# see /etc/bash_completion/bash_completion: _cd()
cdignore=( CVS .svn )

(which ncftp >/dev/null) && alias ftp=ncftp


# vim: If args are given, open those files. If no arg is given, use
# viminfo to jump to last known cursor position

vi () { /usr/bin/vim ${@:- -c "normal '0"}; }

# perl module development
cdpm () { cd $(dirname $(pmpath $1)); }

pver () {
    perl -MCPAN -e"print CPAN::Shell->format_result(q{Module}, q{$1})"
}

# so you can do
#   vit Foo::Bar::Baz
# to edit the class
#   cdt Foo::Bar::Baz
# to cd to the class's directory, we use vim tags.
# We also have custom completion rules for cdt and vit in
# .bash_completion.

cdt () { cd `cdt.pl $1`; }


targets () { perl -ne 'print "$1\n" if /^(\w+):/' Makefile; }

# Check for recent enough version of bash.
bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}

# Check for interactive shell.
if [ -n "$PS1" ]; then
  if [ $bmajor -eq 2 -a $bminor '>' 04 ] || [ $bmajor -gt 2 ]; then
    if [ -r /etc/bash_completion ]; then
      # Source completion code.
    . /etc/bash_completion/bash_completion
    . /etc/bash_completion/contrib/svk
    fi
  fi
fi
unset bash bminor bmajor


# list all instances of one or more files found within the $PATH.

wh () {
    perl -MFile::Which -e'
        for $file (@ARGV) {
            print "$_\n" for grep { !$seen{$_}++ } which($file)
        }
    ' $*;
}

projptags () {
    rm -f $PTAGSFILE
    ptags $* --use $PROJROOT --exclude ~/.ptags_exclude >>$PTAGSFILE

    if [ -f $PTAGS_DYNAMIC ]; then
        echo Generating dynamic ptags
        $PTAGS_DYNAMIC >>$PTAGSFILE
    fi

    ptags_sort <$PTAGSFILE >$PTAGSFILE.sorted
    mv $PTAGSFILE.sorted $PTAGSFILE
}


ORIGPATH=$PATH

set_project () {
    export PROJROOT=$1
    export PERL5OPT="-MDevel::SearchINC=$PROJROOT"
    export CF_CONF=local

    PATH=$ORIGPATH
    for i in $(distfind)
    do
        if [ -d $i/bin ]; then
            PATH=$i/bin:$PATH
        fi
    done
}


set_prompt
test -f ~/.bashrc_site_after && . ~/.bashrc_site_after

fi
