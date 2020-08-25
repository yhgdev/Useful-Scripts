#!/bin/sh

head_print_s="===================================================="
script_desc="Script desc:	Find si4project folder and do backup!"
author_name="Author name:	yhgdev@163.com"
modify_date="Modify date:	2020-08-25"
version="Cur version:	V1.0.0"
head_print_e="===================================================="

#timestamp=`date '+%Y%m%d%H%M%S'`
timestamp=`date '+%Y%m%d%H%M'`

function ListFolder(){
	#echo "ListFolder"
	flist=`ls $1`
	cd $1
	#echo $flist
	for f in $flist
	do
		if test -d $f
		then
			#echo "dir:$f"
			if [ ${f##*.} = "si4project" ]
			then
				backuptarget="$f"
				echo $timestamp
				echo -e "\033[33mDelete the exist si4project.tgz file,then packaged new one, ready go! >>>>>\033[0m"
				echo $backuptarget
				rm -rf *.si4project.tgz
				tar czf ${timestamp}_${backuptarget}.tgz $backuptarget
				echo -e "\033[42;37m$f has been packaged for backup\033[0m"
			else
				#echo `pwd`
				if [ ${f##*.} = "alkaid" ] || [ ${f##*.} = "sdk_rtk" ] || [ ${f##*.} = "ssl" ]
				then
					echo -e "\033[33mThe path is alkaid/sdk_rtk/ssl ... do nothing!\033[0m"
				else
					ListFolder $f
				fi
			fi
		#else
			#echo "file:$f"
			#echo "it's file" $f
		fi
	done
	cd ../
}

echo -e "\033[42;37m<Version Info>\033[0m"
echo $head_print_s
echo $script_desc
echo $author_name
echo $modify_date
echo $version
echo $head_print_e

if [ ! -n "$1" ];then
	echo "---------------------------------------------------------------------------------"
	dir=`pwd`
	echo -e "\033[41;37mYou have not input a list path, use my default workspaces path!\033[0m"
	echo -e "\033[41;37mThe path is = $dir\033[0m"
	#echo -e "\033[41;37mYou have not input a list path.\033[0m"
	#echo -e "usage:./si_backup.sh <path>, [eg:./si_backup.sh ~/workspaces]"
	#exit
	#dir=~/01_workspaces
	echo "---------------------------------------------------------------------------------"
else
	echo "-------------------------------------------"
	echo -e "\033[34mThe path you input is = $1\033[0m"
	#dir=~/workspaces
	dir="$1"
	echo "-------------------------------------------"
fi

ListFolder $dir

echo -e "\033[32m\n\nAll package work is done! check it.\n\033[0m"
