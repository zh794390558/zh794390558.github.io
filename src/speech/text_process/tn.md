# Text Normalization

Text normalization includes:

- Converting Text (all letters) into lower case
- Removing HTML tags
- Expanding contractions
- Converting numbers into words or removing numbers
- Removing special character (punctuations, accent marks and other diacritics)
- Removing white spaces
- Word Tokenization
- Stemming and Lemmatization
- Removing stop words, sparse terms, and particular words

## **NLP Pipeline: Step-by-step**

**Converting text to lowercase:**

In-text normalization process, very first step to convert all text data into lowercase which makes all **text** on a level playing field. With this step, we are able to cover each and every word available in text data.

**Removing HTML Tags:**

HTML tags are typically one of these components which don’t add much value towards understanding and analyzing text. When we used text data collected using techniques like web scraping or screen scraping, it contained a lot of noise. We can remove unnecessary HTML tags and retain the useful textual information for further process.

**Remove HTML Tags using Regular Expression (Regex)**

In [01]:

```
# Import libraryimport reTAG_RE = re.compile(r'<[^>]+>')def remove_tags(text): #define remove tag funtion
    return TAG_RE.sub('', text)
```

In [02]:

```
text = """<div> <h1>Title</h1> <p>A long text........ </p> <a href=""> a link </a> </div>"""
```

In [03]:

```
text = remove_tags(text)
text
```

Out[04]:

```
' Title A long text........   a link
```

**Removing accented characters**

Usually, in any text corpus, you might be dealing with accented characters/letters, especially if you only want to analyze the English language. Hence, we need to make sure that these characters are converted and standardized into ASCII characters. A simple example — converting é to e.

**Expanding Contractions**

Contractions are words or combinations of words that are shortened by dropping letters and replacing them by an apostrophe. Let’s have a look at some examples:

we’re = we are; we’ve = we have; I’d = I would

We can say that contractions are shortened versions of words or syllables. Or simply, a contraction is an abbreviation for a sequence of words.

In NLP, we can deal with constraints by converting each contraction to its expanded, original form helps with text standardization.

**Removing Special Characters**

Special characters and symbols are usually non-alphanumeric characters or even occasionally numeric characters (depending on the problem), which adds to the extra noise in unstructured text. Usually, simple regular expressions (regexes) can be used to remove them.

**Stemming**

To understand the stemming, we have to gain some knowledge about the word stem. **Word stems** are also known as the base form of a word, and we can create new words by attaching affixes to them in a process known as inflection.

You can add affixes to it and form new words like JUMPS, JUMPED, and JUMPING. In this case, the base word JUMP is the word stem.

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/word-stem.jpeg)

The figure shows how the word stem is present in all its inflections since it forms the base on which each inflection is built upon using affixes. The reverse process of obtaining the base form of a word from its inflected form is known as stemming. Stemming helps us in standardizing words to their base or root stem, irrespective of their inflections, which helps many applications like classifying or clustering text, and even in information retrieval.

Different types of stemmers in NLTK are PorterStemmer, LancasterStemmer, SnowballStemmer.

**Lemmatization:**

In NLP, lemmatization is the process of figuring out the root form or root word (most basic form) or lemma of each word in the sentence. Lemmatization is very similar to stemming, where we remove word affixes to get to the base form of a word. The difference is that the root word is always a lexicographically correct word (present in the dictionary), but the root stem may not be so. Thus, the root word, also known as the lemma, will always be present in the dictionary. It uses a knowledge base called WordNet. Because of knowledge, lemmatization can even convert words that are different and cant be solved by stemmers, for example converting “came” to “come”.

**StopWords**

Words which have little or no significance, especially when constructing meaningful features from text, are known as stopwords or stop words. These are usually words that end up having the maximum frequency if you do a simple term or word frequency in a corpus. Consider words like **a, an, the, be** etc. These words don’t add any extra information in a sentence.



## Blogs

* https://suneelpatel-in.medium.com/nlp-pipeline-building-an-nlp-pipeline-step-by-step-7f0576e11d08
