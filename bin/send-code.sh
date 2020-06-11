#########################################################################
# 测试发短信 😝
#########################################################################
#!/bin/bash


# 生成的手机号码存放到指定的目录的文件


num_fix=(136 138 159 189 185)

#(())语法类似C语法的括号
for((i=1;i<=3;i++))
do
    # 取模
    num1=$[$RANDOM%10]
    num2=$[$RANDOM%10]
    num3=$[$RANDOM%10]
    num4=$[$RANDOM%10]
    num5=$[$RANDOM%10]
    num6=$[$RANDOM%10]
    num7=$[$RANDOM%10]
    num8=$[$RANDOM%10]
    num9=$[$RANDOM%10]
   
	r1=$(($RANDOM%5+0));
	echo ${num_fix[${r1}]};
    # 将结果输到指定的文件里面
	phone="${num_fix[${r1}]}${num1}${num2}${num3}${num4}${num5}${num6}${num7}${num8}"
	echo $phone;
  sleep 1s
done

