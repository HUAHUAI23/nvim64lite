intDir=$(pwd)
alias n="bash ${intDir}/open.sh  ${intDir}"

packGit() {
	mkdir "${intDir}"/gitlnk
	touch "${intDir}"/opengit.sh
	cat >"${intDir}"/opengit.sh <<EOF
#!/bin/bash 
exec ${intDir}/git-annex.linux/git "\$@"
EOF
	chmod +x "${intDir}"/opengit.sh
	ln -s "${intDir}"/opengit.sh "${intDir}"/gitlnk/git
}

if ! type "git" &>"/dev/null"; then
	echo -e "\033[41;30m        系统没有git,将使用包自带的git\n包自带git参考: https://git-annex.branchable.com/install/Linux_standalone/      \033[0m"
	if [ ! -d "${intDir}"/gitlnk ]; then
		packGit
	fi
	PATH=$PATH:"${intDir}"/gitlnk
fi
