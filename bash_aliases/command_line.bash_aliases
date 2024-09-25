##
# Disk Use Information
#

# Disk use
alias d-use=" du -h * "

# Displays disk usage information directory
alias d-use-ts=" du -sh * "

# Displays disk usage information for each file and directory
alias d-use-file=" du -ck * | sort -rn | head -11 "

##
# Shortcuts
#

alias  src="source ~/.bash_profile"
alias  la=" ls -la "
alias  latr=" ls -latr "
alias  ll=" ls -l "

alias  up1=" cd .. "
alias  up2=" cd ../.. "
alias  up3=" cd ../../.. "
alias  up4=" cd ../../../.. "
alias  up5=" cd ../../../../.. "
alias  up6=" cd ../../../../../.. "

alias cls=" clear; ls "
alias c=" clear "

alias h=" history "

##
# Find useful programs
#

alias where='
		echo ""
		echo "Python:"
		echo ""
		ls -al $(which -a python python3);
		echo ""
		echo "Pip:"
		echo ""
		ls -al $(which -a pip pip3);
		echo ""
		echo "Bash:"
		echo ""
		which bash;
		echo ""
		echo "Git:"
		echo ""
		which git;
		echo ""
		echo "VS Code:"
		echo ""
		which code;
		echo ""
		echo "Vim:"
		echo ""
		which vim;
		echo ""
		echo "Notepad++:"
		echo ""
		which notepad++;
            '

alias mypath='echo $PATH | tr ":" "\n" '