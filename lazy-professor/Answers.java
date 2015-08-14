import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.lang.System;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Answers {

  static String testFilePath = "./test.txt";

  public static void main(String[] args) {
    List<HashMap<Character, Integer>> questions = new ArrayList<HashMap<Character, Integer>>();

    for (Test test : tests()) {
      List<Character> responses = test.responses();
      for (int i = 0; i < responses.size(); i++) {
        Character response = responses.get(i);
        if (questions.size() <= i) {
          questions.add(new HashMap<Character, Integer>());
        }
        if (!questions.get(i).containsKey(response)) {
          questions.get(i).put(response, 0);
        }
        questions.get(i).put(response, questions.get(i).get(response) + 1);
      }
    }
    for (Map<Character, Integer> question : questions) {
      Character maxCharacter = 'Z';
      Integer max = 0;
      for (Character c : question.keySet()) {
        if (question.get(c) > max) {
          maxCharacter = c;
          max = question.get(c);
        }
      }
      // And print it.
      System.out.print(maxCharacter);
    }
    System.out.println("");
  }

  public static List<Test> tests() {
    List<Test> list = new ArrayList<Test>();
    for (String line : Answers.slurpFile()) {
      list.add(new Test(line));
    }
    return list;
  }

  public static List<String> slurpFile() {
    try {
      List<String> lines = new ArrayList<String>();
      File file = new File(Answers.testFilePath);
      FileReader fileReader = new FileReader(file);
      BufferedReader bufferedReader = new BufferedReader(fileReader);
      String line;
      while ((line = bufferedReader.readLine()) != null) {
        lines.add(line);
      }
      fileReader.close();
      return lines;
    } catch (IOException e) {
      e.printStackTrace();
    }
    return new ArrayList<String>();
  }

  public static class Test {
    private final String line;

    public Test(String line) {
      this.line = line;
    }

    public List<Character> responses() {
      List<Character> list = new ArrayList<Character>();
      for (char c : this.line.toCharArray()) {
        list.add(c);
      }
      return list;
    }
  }
}
