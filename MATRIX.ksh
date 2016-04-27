#!/bin/bash
declare -A matrix
num_rows=63
num_columns=100

function tree {

	local row_num=$1
	local col_num=$2
	local iter2=$iter
        local rows=$(((65-row_num)/4))
	local row_end=$(($row_num+$rows))
	while [ $row_num -lt $row_end ] 
	do
                matrix[$row_num,$col_num]="1"
		let row_num++
        done


	row_end=$(($rows + $row_end))
	
	local mod_col_neg=$col_num
        local mod_col_pos=$col_num

        while [ $row_num -lt $row_end ]
	do
                let mod_col_neg--
                let mod_col_pos++
                matrix[$row_num,$mod_col_neg]="1"
                matrix[$row_num,$mod_col_pos]="1"
		let row_num++
        done
	
	while [ $iter -gt 1 ]
	do
	let iter--
	recurse $iter $row_num $mod_col_neg
	done
	
	while [ $iter2 -gt 1 ]
	do
	let iter2--
	recurse $iter2 $row_num $mod_col_pos
	done
	
}

function recurse {
	let iter=$1
	let row_num=$2
	let col_num=$3
	tree $row_num $col_num
}


for ((i=1;i<=num_rows;i++)) do
    for ((j=1;j<=num_columns;j++)) do
        matrix[$i,$j]="_"
    done
done

recurse 7 1 50

for ((i=num_rows;i>=1;i--)) do
    for ((j=1;j<=num_columns;j++)) do
        printf "%s" ${matrix[$i,$j]}
    done
	printf "\n"
done
