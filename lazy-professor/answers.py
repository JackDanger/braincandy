

def grade():
    Professor().grade()


class Professor:
    questions = []
    test_file = './test.txt'

    def grade(self):
        for test in self.tests():
            for question, answer in enumerate(test):
                self.score(question, answer)
        print "".join([max(question, key=question.get) for question in self.questions])

    def score(self, question, answer):
        if question >= len(self.questions):
            # We can just append because question is an array index
            self.questions.append({'A': 0, 'B': 0, 'C': 0, 'D': 0})
        self.questions[question][answer] += 1

    def tests(self):
        with open(self.test_file, 'r') as f:
            return f.read().splitlines()

if __name__ == '__main__':
    grade()
