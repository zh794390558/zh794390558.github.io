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





## 词的分类

- 实词：名词、动词、形容词、状态词、区别词、数词、量词、代词
- 虚词：副词、介词、连词、助词、拟声词、叹词。

* https://gist.github.com/luw2007/6016931



## ICTPOS3.0词性标记集

```
n 名词
	nr 人名
		nr1 汉语姓氏
		nr2 汉语名字
		nrj 日语人名
		nrf 音译人名
	ns 地名
	　nsf 音译地名
	nt 机构团体名
	nz 其它专名
	nl 名词性惯用语
	ng 名词性语素

t 时间词
　　tg 时间词性语素

s 处所词

f 方位词

v 动词
	vd 副动词
	vn 名动词
	vshi 动词“是”
	vyou 动词“有”
	vf 趋向动词
	vx 形式动词
	vi 不及物动词（内动词）
	vl 动词性惯用语
	vg 动词性语素
a 形容词
	ad 副形词
	an 名形词
	ag 形容词性语素
	al 形容词性惯用语
b 区别词
	bl 区别词性惯用语
z 状态词
r 代词
	rr 人称代词
	rz 指示代词
		rzt 时间指示代词
		rzs 处所指示代词
		rzv 谓词性指示代词
	ry 疑问代词
		ryt 时间疑问代词
		rys 处所疑问代词
		ryv 谓词性疑问代词
	rg 代词性语素
m 数词
	mq 数量词
q 量词
	qv 动量词
	qt 时量词
```

## 虚词

```
d 副词
p 介词
	pba 介词“把”
	pbei 介词“被”
c 连词
	cc 并列连词
u 助词
	uzhe 着
	ule 了 喽
	uguo 过
	ude1 的 底
	ude2 地
	ude3 得
	usuo 所
	udeng 等 等等 云云
	uyy 一样 一般 似的 般
	udh 的话
	uls 来讲 来说 而言 说来

	uzhi 之
	ulian 连 （“连小学生都会”）

e 叹词
y 语气词(delete yg)
o 拟声词
h 前缀
k 后缀
x 字符串
	xx 非语素字
	xu 网址URL
w 标点符号
	wkz 左括号，全角：（ 〔  ［  ｛  《 【  〖 〈   半角：( [ { <
	wky 右括号，全角：） 〕  ］ ｝ 》  】 〗 〉 半角： ) ] { >
	wyz 左引号，全角：“ ‘ 『
	wyy 右引号，全角：” ’ 』
	wj 句号，全角：。
	ww 问号，全角：？ 半角：?
	wt 叹号，全角：！ 半角：!
	wd 逗号，全角：， 半角：,
	wf 分号，全角：； 半角： ;
	wn 顿号，全角：、
	wm 冒号，全角：： 半角： :
	ws 省略号，全角：……  …
	wp 破折号，全角：——   －－   ——－   半角：---  ----
	wb 百分号千分号，全角：％ ‰   半角：%
	wh 单位符号，全角：￥ ＄ ￡  °  ℃  半角：$
```



## 结巴词性标注表

出处： https://gist.github.com/hscspring/c985355e0814f01437eaf8fd55fd7998

笔者注：ictclas标准中 w 表示标点符号

- a 形容词
  - ad 副形词
  - ag 形容词性语素
  - an 名形词
- b 区别词
- c 连词
- d 副词
  - df
  - dg 副语素
- e 叹词
- f 方位词
- g 语素
- h 前接成分
- i 成语
- j 简称略称
- k 后接成分
- l 习用语
- m 数词
  - mg
  - mq 数量词
- n 名词
  - ng 名词性语素
  - nr 人名
  - nrfg
  - nrt
  - ns 地名
  - nt 机构团体名
  - nz 其他专名
- o 拟声词
- p 介词
- q 量词
- r 代词
  - rg 代词性语素
  - rr 人称代词
  - rz 指示代词
- s 处所词
- t 时间词
  - tg 时语素
- u 助词
  - ud 结构助词 得
  - ug 时态助词
  - uj 结构助词 的
  - ul 时态助词 了
  - uv 结构助词 地
  - uz 时态助词 着
- v 动词
  - vd 副动词
  - vg 动词性语素
  - vi 不及物动词
  - vn 名动词
  - vq
- x 非语素词
- y 语气词
- z 状态词
  - zg



## ICTCLAS 汉语词性标注集

正常出处应该是这里 http://ictclas.org/ictclas_files.html 但是没有人维护，所以复制于网友的版本

出处：https://www.bbsmax.com/A/MyJx86X2Jn/

| 代码 | 名称     | 帮助记忆的诠释                                         |
| ---- | -------- | ------------------------------------------------------ |
| Ag   | 形语素   | 形容词性语素。形容词代码为a，语素代码ｇ前面置以A。     |
| a    | 形容词   | 取英语形容词adjective的第1个字母。                     |
| ad   | 副形词   | 直接作状语的形容词。形容词代码a和副词代码d并在一起。   |
| an   | 名形词   | 具有名词功能的形容词。形容词代码a和名词代码n并在一起。 |
| b    | 区别词   | 取汉字“别”的声母。                                     |
| c    | 连词     | 取英语连词conjunction的第1个字母。                     |
| Dg   | 副语素   | 副词性语素。副词代码为d，语素代码ｇ前面置以D。         |
| d    | 副词     | 取adverb的第2个字母，因其第1个字母已用于形容词。       |
| e    | 叹词     | 取英语叹词exclamation的第1个字母。                     |
| f    | 方位词   | 取汉字“方” 的声母。                                    |
| g    | 语素     | 绝大多数语素都能作为合成词的“词根”，取汉字“根”的声母。 |
| h    | 前接成分 | 取英语head的第1个字母。                                |
| i    | 成语     | 取英语成语idiom的第1个字母。                           |
| j    | 简称略语 | 取汉字“简”的声母。                                     |
| k    | 后接成分 |                                                        |
| l    | 习用语   | 习用语尚未成为成语，有点“临时性”，取“临”的声母。       |
| m    | 数词     | 取英语numeral的第3个字母，n，u已有他用。               |
| Ng   | 名语素   | 名词性语素。名词代码为n，语素代码ｇ前面置以N。         |
| n    | 名词     | 取英语名词noun的第1个字母。                            |
| nr   | 人名     | 名词代码n和“人(ren)”的声母并在一起。                   |
| ns   | 地名     | 名词代码n和处所词代码s并在一起。                       |
| nt   | 机构团体 | “团”的声母为t，名词代码n和t并在一起。                  |
| nz   | 其他专名 | “专”的声母的第1个字母为z，名词代码n和z并在一起。       |
| o    | 拟声词   | 取英语拟声词onomatopoeia的第1个字母。                  |
| p    | 介词     | 取英语介词prepositional的第1个字母。                   |
| q    | 量词     | 取英语quantity的第1个字母。                            |
| r    | 代词     | 取英语代词pronoun的第2个字母,因p已用于介词。           |
| s    | 处所词   | 取英语space的第1个字母。                               |
| Tg   | 时语素   | 时间词性语素。时间词代码为t,在语素的代码g前面置以T。   |
| t    | 时间词   | 取英语time的第1个字母。                                |
| u    | 助词     | 取英语助词auxiliary 的第2个字母,因a已用于形容词。      |
| Vg   | 动语素   | 动词性语素。动词代码为v。在语素的代码g前面置以V。      |
| v    | 动词     | 取英语动词verb的第一个字母。                           |
| vd   | 副动词   | 直接作状语的动词。动词和副词的代码并在一起。           |
| vn   | 名动词   | 指具有名词功能的动词。动词和名词的代码并在一起。       |
| w    | 标点符号 |                                                        |
| x    | 非语素字 | 非语素字只是一个符号，字母x通常用于代表未知数、符号。  |
| y    | 语气词   | 取汉字“语”的声母。                                     |
| z    | 状态词   | 取汉字“状”的声母的前一个字母                           |



## 斯坦福Stanford coreNLP宾州树库的词性标注规范

出处：《NLP汉语自然语言处理原理与实践》

| 词性标记 | 英文名称                              | 中文名称                | 示例                                       |
| -------- | ------------------------------------- | ----------------------- | ------------------------------------------ |
| AD       | Adverbs                               | 副词                    | 还                                         |
| AS       | Aspect marker                         | 体标记                  | 了，着，过，的                             |
| BA       | In ba-const                           | 把、将                  |                                            |
| CC       | Coordinating conjunction              | 并列连词                | 和、与、或、或者                           |
| CD       | Cardinal numbers                      | 数字、基数词            | 一百                                       |
| CS       | Subordinating conj                    | 从属连词                | 若，如果，如                               |
| DEC      | For relative-clause etc               | 标句词，关系从句“的”    | 我买“的”书                                 |
| DEG      | Associative                           | 所有格、连接作用“的”    | 我“的”书                                   |
| DER      | In V-de constructive ,and V-de-R      | V得，表示结果补语的“得” | 跑“得”气喘吁吁                             |
| DEV      | Before VP                             | 表示方式状的“地”        | 高兴/NA地/DEV说/VV                         |
| DT       | Determiner                            | 限定词                  | 这                                         |
| ETC      | Tag for words in coordination phrase  | “等”，“等等”            | 科技文教 等/ETC 领域                       |
| FW       | Foreign words                         | 外语词                  | Intel                                      |
| IJ       | Interjection                          | 感叹词                  | 啊                                         |
| JJ       | Noun-modifier other thannouns         | 其他名词修饰语          | 共同/JJ的/DEG目的/NN他/PN是/VC男//JJ的/DEG |
| LB       | In long bei-construction              | “被”                    | “被”他打了                                 |
| LC       | Localizer                             | 方位词                  | 桌子“上”                                   |
| M        | Measure word（including classifiers） | 量词                    | 一“块”糖                                   |
| MSP      | Some particles                        | 其他结构助词            | 他/PN所/MSP需要VV的/DEC 所，而，以         |
| NN       | Common nouns                          | 普通名词                | 桌子                                       |
| NR       | Proper nouns                          | 专有名词                | 天安门                                     |
| NT       | Temporal nouns                        | 时间名词                | 清朝                                       |
| OD       | Ordinal numbers                       | 序数词                  | 第一                                       |
| ON       | Onomatopoeia                          | 拟声词                  | 哗啦啦                                     |
| P        | Prepositions                          | 介词                    | 在                                         |
| PN       | pronouns                              | 代词                    | 你，我，他                                 |
| PU       | punctuations                          | 标点                    | ， 。                                      |
| SB       | In long bei-consturction              | 被                      | 他/PN被/SB训了/AS                          |
| SP       | Sentence-final particle               | 句末助词                | 你好吧、SP吧 呢 啊 吗                      |
| VA       | Predicative adjective                 | 谓词形容词              | 太阳红彤彤/VA雪白 丰富                     |
| VC       | Copula                                | 系动词                  | 是 为 非                                   |
| VE       | as the main verb                      | “有”作为主要动词        | 有，无                                     |
| VV       | verbs                                 | 普通动词                | 喜欢，走                                   |



## Reference

* [Parts of Speech](https://www.englishclub.com/grammar/parts-of-speech.htm)
* https://en.wikipedia.org/wiki/Part_of_speech
* [**NLP: POS (Part of speech) Tagging & Chunking**](https://suneelpatel-in.medium.com/nlp-pos-part-of-speech-tagging-chunking-f72178cc7385)
* [Learning POS Tagging & Chunking in NLP](https://medium.com/greyatom/learning-pos-tagging-chunking-in-nlp-85f7f811a8cb)
* [ICTCLAS 汉语词性标注集](http://lore.chuci.info/taurenshaman/json/810300d3edd34db7b639fb2c0966051b)
* [ICTPOS3.0词性标记集](http://lore.chuci.info/taurenshaman/json/33f7e945e8de47e6b707a3200023dd42)

