class WordSuggestions {
  static List<String> initialWords() => ["I", "You", "We", "They"];

  static Map<String, List<String>> wordMap = {
    "I": ["am", "will", "like", "have"],
    "You": ["are", "will", "want", "need"],
    "We": ["should", "can", "have", "love"],
    "They": ["do", "might", "enjoy", "prefer"],
    "am": ["happy", "tired", "ready", "here"],
    "will": ["go", "stay", "help", "wait"],
    "like": ["this", "that", "playing", "coding"],
  };

  static List<String> getNextSuggestions(String word) {
    return wordMap.containsKey(word) && wordMap[word]!.isNotEmpty ? wordMap[word]! : initialWords();
  }
}
