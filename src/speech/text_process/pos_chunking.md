# POS Tagging and Chunking

There are eight parts of speech in the English language: noun, pronoun, verb, adjective, adverb, preposition, conjunction, and interjection.

- **Noun (N)** — John, London, Table, Teacher, Pen, City, Happiness, Hope
- **Pronoun(PRO)** — I, We, They, You, He, She, It, Me, Us, Them, Him, Her, This, That
- **Verb (V)** — Read, Eat, Go, Speak, Run, Play, Live, Have, Like, Are, Is
- **Adverb(ADV)** — Slowly, Quietly, Very, Always, Never, Too, Well, Tomorrow
- **Adjective(ADJ)** — Big, Happy, Green, Young, Fun, Crazy, Three
- **Preposition (P)** — At, On, In, From, With, Near, Between, About, Under
- **Conjunction (CON)** — And, Or,But, Because, So, Yet, Unless, Since, If
- **Interjection (INT)** — Ouch! Wow! Great! Help! Oh! Hey! Hi!

<img src="/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/pos-tag.jpeg" alt="pos-tag" style="zoom:50%;" />

## Pipeline

As per the NLP Pipeline, we start POS Tagging with text normalization after obtaining a text from the source. Text normalization includes:

- Converting Text (all letters) into lower case
- Removing HTML tags
- Expanding contractions
- Converting numbers into words or removing numbers
- Removing special character (punctuations, accent marks and other diacritics)
- Removing white spaces
- Word Tokenization
- Stemming and Lemmatization
- Removing stop words, sparse terms, and particular words

## Tools

There are many tools containing POS taggers including NLTK, TextBlob, spaCy, Pattern, Stanford CoreNLP, Memory-Based Shallow Parser (MBSP), Apache OpenNLP, Apache Lucene, General Architecture for Text Engineering (GATE), FreeLing, Illinois Part of Speech Tagger, and DKPro Core.

## **The Different POS Tagging Techniques**

There are different techniques for POS Tagging:

**Lexical Based Methods —** Assigns the POS tag the most frequently occurring with a word in the training corpus.

**Rule-Based Methods —** Assigns POS tags based on rules. For example, we can have a rule that says, words ending with “ed” or “ing” must be assigned to a verb. Rule-Based Techniques can be used along with Lexical Based approaches to allow POS Tagging of words that are not present in the training corpus but are there in the testing data.

**Probabilistic Methods —** This method assigns the POS tags based on the probability of a particular tag sequence occurring. Conditional Random Fields (CRFs) and Hidden Markov Models (HMMs) are probabilistic approaches to assign a POS Tag.

**Deep Learning Methods —** Recurrent Neural Networks can also be used for POS tagging. 

## **What is Chunking (shallow parsing) ?**

Before understanding chunking let us discuss what is **chunk**?

A chunk is a collection of basic familiar units that have been grouped together and stored in a person’s memory. In natural language, chunks are collective higher order units that have discrete grammatical meanings (noun groups or phrases, verb groups, etc.)

**Chunking** is a process of extracting phrases (chunks) from unstructured text. Instead of using a single word which may not represent the actual meaning of the text, it’s recommended to use chunk or phrase.

The basic technique we will use for entity detection is **chunking,** which segments and labels multi-token sequences as illustrated below:

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/pos-chunk.png)

Segmentation and Labeling at both the Token and Chunk Levels : NLTK.org

**Chunking tools:** NLTK, TreeTagger chunker, Apache OpenNLP, General Architecture for Text Engineering (GATE), FreeLing.

There are a lot of libraries which give phrases out-of-box such as Spacy or TextBlob. NLTK just provides a mechanism using regular expressions to generate chunks.

Let us discuss a standard set of Chunk tags:

- Noun Phrase(NP)
- Verb Phrase (VP)

**Noun Phrase:** Noun phrase chunking, or NP-chunking, where we search for chunks corresponding to individual noun phrases.

In order to create an NP-chunk, we will first define a **chunk grammar** using POS tags**,** consisting of rules that indicate how sentences should be chunked. We will define this using a single regular expression rule.

In this case, we will define a simple grammar with a single regular-expression rule. This rule says that an NP chunk should be formed whenever the chunker finds an optional determiner (DT) followed by any number of adjectives (JJ) and then a noun (NN) then the Noun Phrase(NP) chunk should be formed.

The result is a tree, which we can either print or display graphically.

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/pos-np-chunk.png)

Simple Regular Expression Based NP Chunker : nltk.org

## Blogs

* [Parts of Speech](https://www.englishclub.com/grammar/parts-of-speech.htm)

* https://en.wikipedia.org/wiki/Part_of_speech
* [**NLP: POS (Part of speech) Tagging & Chunking**](https://suneelpatel-in.medium.com/nlp-pos-part-of-speech-tagging-chunking-f72178cc7385)
* [Learning POS Tagging & Chunking in NLP](https://medium.com/greyatom/learning-pos-tagging-chunking-in-nlp-85f7f811a8cb)

