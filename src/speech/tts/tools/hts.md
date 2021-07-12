# HTS

## HTS Lab format

If you are familiar with the HTS demos, you probably know about their full-context label format. One full context labels looks like this:

```
n^t-s+iy=b@1_2/A:1_1_4/B:1-0-2@1-1&4-3#3-2$3-3!1-1;1-1|iy/C:1+1+4/D:content_1/E:content+1@4+2&3+1#1+1/F:content_2/G:0_0/H:6=5@1=2|L-L%/I:7=6/J:13+11-2
```

The above line contain the phone identity and many of its linguistic context, including the 2 previous and 2 following phones, position of current phone in current syllable, position of current syllable in current words, stress, accent and so many other think. The detailed description of all those context is in lab_format.pdf inside the data folder of any HTS demo.

However, if you are building your own system, you may have problem getting all those context to create that long labels. In fact, HTS could still work with much shorter full-context labels containing much less information, but you should expect some degree of degradation in the quality of the synthesized speech due to the shrinking of the decision tree.

**Understanding the Label File Format**

The fullcontext label format represents phonemes in context. The different context elements are extracted by a frontend tool (we use Festival). The label file basically has one phoneme-in-context per line (with the start and end times of that phoneme in ten-millionths of seconds), and the line contains each context element separated by unique delimiters to enable pattern matching. See [lab_format.pdf](http://www.cs.columbia.edu/~ecooper/tts/lab_format.pdf) from the HTS demo for more information on the format and the standard contextual features.

## Lab Format For Chinese

| 层级       | 标注格式                                           |
| ---------- | -------------------------------------------------- |
| 声韵母层   | p1^p2-p3+p4=p5@p6_p7                               |
| .          | /A:a1_a2-a3_a4#a5                                  |
| 音节层     | /B:b1_b2!b3_b4#b5@b6!b7+b8@b9#b10_b11              |
| .          | /C:c1+c2-c3=c4#c5                                  |
| 词层       | /D:d1-d2 /E:e1&e2^e3_e4 /F:f1-f2                   |
| 韵律层     | /G:g1-g2 /H:h1-h2@h3+h4 /I:i1-i2                   |
| 韵律短语层 | /J:j1^j2=j3-j4 /K:k1=k2_k3^k4&k5_k6 /L:l1^l2#l3-l4 |
| 语句层     | /M:m1#m2+m3+m4!m5                                  |

| 标号 | 含义                             |
| ---- | -------------------------------- |
| p1   | 前前基元                         |
| p2   | 前一基元                         |
| p3   | 当前基元                         |
| p4   | 后一基元                         |
| p5   | 后后基元                         |
| p6   | 当前基元在当前音节的位置（正序） |
| p7   | 当前基元在当前音节的位置（倒序） |

|
a1 | 前一音节的首基元 a2 | 前一音节的末基元 a3，a4 | 前一音节的声调类型 a5 | 前一音节的基元数目 |
b1 | 当前音节的首基元 b2 | 当前音节的末基元 b3，b4 | 当前音节的声调类型 a5 | 当前音节的基元数目 b6 | 当前音节在词中的位置（正序） b7 | 当前音节在词中的位置（倒序） b8 | 当前音节在韵律词中的位置（正序） b9 | 当前音节在韵律词中的位置（倒序） b10 | 当前音节在韵律短语中的位置（正序） b11 | 当前音节在韵律短语中的位置（倒序） |
c1 | 后一音节的首基元 c2 | 后一音节的末基元 c3，c4 | 后一音节的声调类型 c5 | 后一音节的基元数目 |
d1 | 前一个词的词性 d2 | 前一个词的音节数目 |
e1 | 当前词的词性 e2 | 当前词中的音节数目 e3 | 当前词在韵律词中的位置（正序） e4 | 当前词在韵律词中的位置（倒序） |
f1 | 后一个词的词性 f2 | 后一个词的音节数目 |
g1 | 前一个韵律词的音节数目 g2 | 前一个韵律词的词数目 |
h1 | 当前韵律词的音节数目 h2 | 当前韵律词的词数目 h3 | 当前韵律词在韵律短语的位置（正序） h4 | 当前韵律词在韵律短语的位置（倒序） |
i1 | 后一个韵律词的音节数目 i2 | 后一个韵律词的词数目 |
j1 | 前一韵律短语的语调类型 j2 | 前一韵律短语的音节数目 j3 | 前一韵律短语的词数目 j4 | 前一韵律短语的韵律词个数 |
k1 | 当前韵律短语的语调类型 k2 | 当前韵律短语的音节数目 k3 | 当前韵律短语的词数目 k4 | 当前韵律短语的韵律词个数 k5 | 当前韵律短语在语句中的位置（正序） k6 | 当前韵律短语在语句中的位置（倒序） |
l1 | 后一韵律短语的语调类型 l2 | 后一韵律短语的音节数目 l3 | 后一韵律短语的词数目 l4 | 后一韵律短语的韵律词个数 |
m1 | 语句的语调类型 m2 | 语句的音节数目 m3 | 语句的词数目 m4 | 语句的韵律词数目 m5 | 语句的韵律短语数目

## Reference

* https://gist.github.com/candlewill/e0e3bce9139de0a058d655ae90807191

* http://www.cs.columbia.edu/~ecooper/tts/lab_format.pdf
* http://www.cs.columbia.edu/~ecooper/tts/
