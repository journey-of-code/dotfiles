# http://www.simplehelp.net/2009/11/11/how-to-tweak-your-linux-machines-history-command/
# Use single history for all open shells
shopt -s histappend
PROMPT_COMMAND='history -a'
# No duplicates
export HISTCONTROL="ignoredups:ignorespace"
export HISTIGNORE="&:ls:[bf]g:exit"
# Spell checking
shopt -s cdspell

alias ll='ls -Agoh'

# Latex stuff
alias pdflatex="pdflatex -interaction=nonstopmode"

# Remeber directories (a - add, c - choose, r - remove)
alias a='p=`pwd`; echo $p >> ~/.dirs; sort -fu ~/.dirs > ~/.dirsTmp; mv ~/.dirsTmp ~/.dirs;'
alias c='oldIFS=$IFS; IFS=$'\n'; text=(); while read line ; do text=( ${text[@]-} "${line}") ; done < ~/.dirs; PS3="Choose the directory to cd into: " ; cd `select selection in ${text[@]}; do echo "$selection"; break; done`; IFS=$oldIFS'
alias r='p=`pwd`; sed -i "\#${p}\$#d" ~/.dirs;'

# Remember commands (ad - add command, sc - select command, sch - sc to history, rc - remove command)
# history : gives all typed lines
# tail -n 2 : gives the last two lines
# sed -n '1 p' : gives the first line
# sed 's/[ 0-9]*// :  cuts space and 0-9 from the beginning of the history line (which lists line numbers)
# so what is this '"'"'-stuff? the first quote ends the single-quote, first double-quote starts quoting which contains just a single quote. then double-quoting is ended and single-quoting started. bash interprets it as a single '
alias ac="history 2 | sed -n '1 s/[ 0-9]*//p' >> ~/.commands; sort -fu ~/.commands > ~/.commandsTmp; mv ~/.commandsTmp ~/.commands"
alias sc='oldIFS=$IFS; IFS=$'\n'; text=(); while read line ; do text=( ${text[@]-} "${line}") ; done < ~/.commands; PS3="Choose command by number: " ; eval `select selection in ${text[@]}; do echo "$selection"; break; done`; IFS=$oldIFS'
alias sch='oldIFS=$IFS; IFS=$'\n'; text=(); while read line ; do text=( ${text[@]-} "${line}") ; done < ~/.commands; PS3="Choose command by number: " ; history -s `select selection in ${text[@]}; do echo "$selection"; break; done`; IFS=$oldIFS'
alias rc='awk '"'"'{print NR,$0}'"'"' ~/.commands; read -p "Remove number: " number; sed "${number} d" ~/.commands > ~/.commandsTmp; mv ~/.commandsTmp ~/.commands'
