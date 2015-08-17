#!/bin/zsh

typeset -A counts
counts[A]=""
counts[B]=""
counts[C]=""
counts[D]=""

sample=$(head -n 1 test.txt)
num_questions=$(echo -n $sample | wc -c)

# initialize the count lists with double-digit numbers
for question in $(seq $num_questions); do
  counts[A]="00${counts[A]}"
  counts[B]="00${counts[B]}"
  counts[C]="00${counts[C]}"
  counts[D]="00${counts[D]}"
done

for answer in `cat test.txt`; do
  for question in $(seq $num_questions); do
    # The letter chosen at the position $question
    local choice=$(echo -n $answer | cut -c $question)
    local digit_offset_ones=$((question * 2)) # double-digit serialization
    local digit_offset_tens=$(($digit_offset_ones - 1))
    local current="${counts[$choice][$digit_offset_tens]}${counts[$choice][$(($digit_offset_ones))]}"
    local new_count=$(($current + 1))
    local count=${counts[$choice]}

    # turn single-digit numbers (which, which the heredoc, look like two-digit)
    # into double-digit ones.
    if [[ 10 -gt $new_count ]]; then
      new_count="0$new_count"
    fi

    count[$digit_offset_tens]=${new_count[1]}
    count[$digit_offset_ones]=${new_count[2]}
    counts[$choice]=$count
  done
done;

for question in `seq $num_questions`; do
  local digit_offset_ones=$((question * 2)) # double-digit serialization
  local digit_offset_tens=$(($digit_offset_ones - 1))
  local best_choice=''
  local best_count=0
  for choice in A B C D; do
    this_count="${counts[$choice][$digit_offset_tens]}${counts[$choice][$(($digit_offset_ones))]}"
    if [[ $this_count -gt $best_count ]]; then
      best_choice=$choice
      best_count=$this_count
    fi
  done
  echo -n $best_choice
done
echo ''

