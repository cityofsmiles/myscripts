#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias u='yay; flatpak update'
alias srb='source ~/.bashrc'
alias in='yay -S'
alias pr='yay -R'
alias sound='alsamixer'
alias bright='xrandr --output LVDS-1 --brightness'
alias sr='yay -Ss'
#alias anddev='cd /home/jonathan/Android-Development/Android/ && source bin/activate && cd examautochecker'
alias wifioff='nmcli radio wifi off'
alias wifion='nmcli radio wifi on'
alias pdf2jpg='python3 /home/jonathan/Documents/myscripts/python-scripts/pdf2jpg.py'
alias gaa='git add --all'
alias gcm='git commit -m'
alias gpm='git push -u origin master'
alias gpa='git push -u origin assets'
alias gpc='git push -u origin calendar'
alias gromit-mpx='/home/jonathan/gromit-mpx-1.3.1/build/gromit-mpx'
alias cl='sudo yay -Yc'
alias gpmn='git push -u origin main'
alias cpcn='cp /home/jonathan/.config/i3/config /home/jonathan/Documents/myscripts/configs; cp /home/jonathan/.bashrc /home/jonathan/Documents/myscripts/configs; cp /home/jonathan/.config/i3status/config /home/jonathan/Documents/myscripts/configs; cp /home/jonathan/.config/ranger/rifle.conf /home/jonathan/Documents/myscripts/configs'
alias okular='flatpak run --file-forwarding org.kde.okular'


export PATH=/home/jonathan/idea-IC-202.6948.69/bin/:/home/jonathan/.local/bin:$PATH

export EDITOR=mousepad

shopt -s extglob

extract() {
    local c e i

    (($#)) || return

    for i; do
        c=''
        e=1

        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
            *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
                   c=(bsdtar xvf);;
            *.7z)  c=(7z x);;
            *.Z)   c=(uncompress);;
            *.bz2) c=(bunzip2);;
            *.exe) c=(cabextract);;
            *.gz)  c=(gunzip);;
            *.rar) c=(unrar x);;
            *.xz)  c=(unxz);;
            *.zip) c=(unzip);;
            *)     echo "$0: unrecognized file extension: \`$i'" >&2
                   continue;;
        esac

        command "${c[@]}" "$i"
        ((e = e || $?))
    done
    return "$e"
}

up(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}


# for python-for-android. Adjust the paths!
#export ANDROIDSDK="/home/jonathan/Android/Sdk/"
#export ANDROIDNDK="/home/jonathan/.local/bin/android-ndk-r19c/"
#export ANDROIDAPI="27"  # Target API version of your application
#export NDKAPI="21"  # Minimum supported API version of your application
#export ANDROIDNDKVER="r19c"  # Version of the NDK you installed

export JAVA_HOME=/usr/lib/jvm/java-14-openjdk export PATH=$JAVA_HOME/bin:$PATH 

export SNOWMIX=/usr/lib/Snowmix-0.5.1/
alias algeb='cd ~/algeb_solver_v2; python3 algeb_solver_v2.py; cd ~'
alias synth='cd ~/synthetic-calc; python3 synthetic-calc.py; cd ~'
alias syst='cd ~/systems-solver; python3 systems-solver.py; cd ~'
alias semser='cd ~/semser_solver; python3 semser_solver.py; cd ~'
alias gcal='python /home/jonathan/gencal/calculators/gen_cal_v2/gen_cal_v2.py'

