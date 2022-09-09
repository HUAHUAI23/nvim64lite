intDir=$(pwd)
alias n="bash ${intDir}/open.sh  ${intDir}"

if ! type "git" &>"/dev/null"; then
	echo -e "\033[41;30m        系统没有git,将使用包自带的git\n包自带git参考: https://git-annex.branchable.com/install/Linux_standalone/      \033[0m"
	alias git="bash ${intDir}/git-annex.linux/git"
fi
