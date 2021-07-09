# **Tokenization**

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/nlp-tokenizition.jpeg)

## **Tokenization**

Language is the beauty of human communication. To understand or interpret the meaning of any text we read each word one by one till we encounter a full stop in a sentence. And that’s exactly the way with our machines. In order to get our computer to understand any text, we need to break that word down in a way that our machine can understand. That’s where the concept of tokenization in Natural Language Processing (NLP) comes in.

In machine learning, the model needs all words separately making up the sentence. So, if we are given a paragraph, we need to get all the sentences. From all these sentences, we need words & then only we can move on for any sort of prediction.

**Tokenization is a process of breaking a text into smaller parts or chunks. Whether it’s breaking paragraphs into sentences, sentence into words or word into characters.**

**Goal of Tokenization:** Creating **Vocabulary** is the ultimate goal of Tokenization.

## **Uses of Tokenization**

There are numerous uses of tokenization. We can use this tokenized form to:

- Count the number of words in the text
- Count the frequency of the word, that is, the number of times a particular word is present

## **Word Tokenization:**

Word Tokenization is the most commonly used tokenization algorithm. It splits a piece of text into individual words based on a certain delimiter. Depending upon delimiters, different word-level tokens are formed.

We use the method **word_tokenize()** to split a sentence into words. The output of word tokenization can be converted to Data Frame for better text understanding in machine learning applications. It can also be provided as input for further text cleaning steps such as punctuation removal, numeric character removal or stemming.

## **Sentence Tokenization:**

Sentence Tokenization is the process of splitting a piece of paragraph into sentences based on full stop as a delimiter. Each sentence can also be a token, if you tokenized the sentences out of a paragraph. Sub module **“sent_tokenize”** available for sentence tokenization.

## **Regex Tokenization**

Regex tokenization is the process to extract the tokens from the string by using regular expressions with the **“RegexpTokenizer()”** method.

Syntax : tokenize.RegexpTokenizer()

## Blogs

* [**NLP Guide 101: Tokenization and Methods to Perform Tokenization**](https://suneelpatel-in.medium.com/nlp-guide-101-tokenization-and-methods-to-perform-tokenization-8e4e34d74805)
* [How to Get Started with NLP – 6 Unique Methods to Perform Tokenization](https://www.analyticsvidhya.com/blog/2019/07/how-get-started-nlp-6-unique-ways-perform-tokenization/)
