#!/bin/bash
# /**
#  * @author yangqi
#  * @email txzm2018@gmail.com
#  * @create date 2018-10-09 12:30:12
#  * @modify date 2018-10-09 12:30:12
#  * @desc [description]
# */
# 使用方法：在目标脚本中使用 . ./TXZMArgsParser.sh $@执行此脚本
# -acv将会被转换为_tFlags[c]=0,_tFlags[a]=0,_tFlags[v]=0
# --value=10将会被转换为_tArgs[value]=10
# 所有的参数都会被存在_tFlags与_tArgs的关联数组中
tArgsParseSingle(){
    local e=$1;
    local prefix=${e:0:1};
    if [[ $prefix = - ]]; then
        local index=1;
        local length=${#e};
        while [ $index -lt $length ];
        do
            local key=${e:$index:1};
            _tFlags[$key]=0;
            let index++;
        done
    fi
}

tARgsParseDouble(){
    local str=${1:2};
    local key=${str%%=*};
    local value=${str##*=};
    _tArgs[$key]="$value";
}

tArgsParse(){
    local i;
    for (( i=1; i <= $#; i++ ));
    do
	local e=`eval echo '$'"$i"`;
        #echo "handle:${e}";
        local prefix=${e:0:2};
        if [[ $prefix = -- ]]; then
            tARgsParseDouble "$e";
        else
            tArgsParseSingle "$e";
        fi
    done
}

declare -A _tFlags;
declare -A _tArgs;
tArgsParse "$@";

#for key in ${!_tFlags[@]};
#do
#    echo "flag:${key}";
#done
#for key in ${!_tArgs[@]};
#do
#    echo "key:${key},value:${_tArgs[$key]}";
#done
