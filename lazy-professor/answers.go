package main

import (
	"bufio"
	"fmt"
	"os"
)

type Question map[uint8]int

func main() {
	characters := map[uint8]string{
		'A': "A",
		'B': "B",
		'C': "C",
		'D': "D",
	}

	for _, question := range examine() {
		fmt.Printf(characters[keyOfMaxValue(question)])
	}
	fmt.Println()
}

func examine() []Question {
	questions := make([]Question, 0, 1024)

	for _, test := range tests() {
		for question, answer := range []rune(test) {
			if len(questions) <= question {
				questions = append(questions, newQuestion())
			}
			c := fmt.Sprintf("%c", answer)[0]
			questions[question][c]++
		}
	}
	return questions
}

func newQuestion() Question {
	return Question{
		'A': 0,
		'B': 0,
		'C': 0,
		'D': 0,
	}
}

func tests() []string {
	testFile, err := os.Open("./test.txt")

	if err != nil {
		panic(err)
	}
	defer testFile.Close()

	tests := make([]string, 0, 162) // super cheating here on slice capacity

	scanner := bufio.NewScanner(testFile)
	for scanner.Scan() {
		tests = append(tests, scanner.Text())
	}
	return tests
}

func keyOfMaxValue(m map[uint8]int) uint8 {
	max := 0
	maxKey := uint8(0)
	for key, value := range m {
		if value > max {
			max = value
			maxKey = key
		}
	}
	if maxKey == 'Z' {
		panic("question was malformed")
	}
	return maxKey
}
