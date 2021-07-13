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



## Lab Format For Chinese - Festival

* https://gist.github.com/candlewill/e0e3bce9139de0a058d655ae90807191

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



## [面向汉语统计参数语音合成的标注生成方法](https://github.com/Jackiexiao/MTTS/tree/master/docs/mddocs/mandarin_example_label.md)

此标注格式来源：郝东亮, 杨鸿武, 张策,等. [面向汉语统计参数语音合成的标注生成方法](http://cea.ceaj.org/CN/abstract/abstract34932.shtml)[J]. 计算机工程与应用, 2016, 52(19):146-153.  

这是较为齐全的标注，包括了上下文标注，韵律结构的标注等但不包括重音标注

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

下面的（发音）基元指的是声韵母，HMM建模选用的单元是音节

| 标号   | 含义                                       |
| ------ | ------------------------------------------ |
| p1     | 前前基元                                   |
| p2     | 前一基元                                   |
| p3     | 当前基元                                   |
| p4     | 后一基元                                   |
| p5     | 后后基元                                   |
| p6     | 当前基元在当前音节的位置（正序）           |
| p7     | 当前基元在当前音节的位置（倒序）           |
| a1     | 前一音节的首基元                           |
| a2     | 前一音节的末基元                           |
| a3，a4 | 前一音节的声调类型（词典和文本分析，下同） |
| a5     | 前一音节的基元数目                         |
| b1     | 当前音节的首基元                           |
| b2     | 当前音节的末基元                           |
| b3，b4 | 当前音节的声调类型（词典和文本分析，下同） |
| a5     | 当前音节的基元数目                         |
| b6     | 当前音节在词中的位置（正序）               |
| b7     | 当前音节在词中的位置（倒序）               |
| b8     | 当前音节在韵律词中的位置（正序）           |
| b9     | 当前音节在韵律词中的位置（倒序）           |
| b10    | 当前音节在韵律短语中的位置（正序）         |
| b11    | 当前音节在韵律短语中的位置（倒序）         |
| c1     | 后一音节的首基元                           |
| c2     | 后一音节的末基元                           |
| c3，c4 | 后一音节的声调类型（词典和文本分析，下同） |
| c5     | 后一音节的基元数目                         |
| d1     | 前一个词的词性                             |
| d2     | 前一个词的音节数目                         |
| e1     | 当前词的词性                               |
| e2     | 当前词中的音节数目                         |
| e3     | 当前词在韵律词中的位置（正序）             |
| e4     | 当前词在韵律词中的位置（倒序）             |
| f1     | 后一个词的词性                             |
| f2     | 后一个词的音节数目                         |
| g1     | 前一个韵律词的音节数目                     |
| g2     | 前一个韵律词的词数目                       |
| ---    | ----                                       |
| h1     | 当前韵律词的音节数目                       |
| h2     | 当前韵律词的词数目                         |
| h3     | 当前韵律词在韵律短语的位置（正序）         |
| h4     | 当前韵律词在韵律短语的位置（倒序）         |
| ---    | --                                         |
| i1     | 后一个韵律词的音节数目                     |
| i2     | 后一个韵律词的词数目                       |
| --     | ---                                        |
| j1     | 前一韵律短语的语调类型                     |
| j2     | 前一韵律短语的音节数目                     |
| j3     | 前一韵律短语的词数目                       |
| j4     | 前一韵律短语的韵律词个数                   |
| ---    | ----                                       |
| k1     | 当前韵律短语的语调类型                     |
| k2     | 当前韵律短语的音节数目                     |
| k3     | 当前韵律短语的词数目                       |
| k4     | 当前韵律短语的韵律词个数                   |
| k5     | 当前韵律短语在语句中的位置（正序）         |
| k6     | 当前韵律短语在语句中的位置（倒序）         |
| ---    | ---                                        |
| l1     | 后一韵律短语的语调类型                     |
| l2     | 后一韵律短语的音节数目                     |
| l3     | 后一韵律短语的词数目                       |
| l4     | 后一韵律短语的韵律词个数                   |
| ---    | ---                                        |
| m1     | 语句的语调类型                             |
| m2     | 语句的音节数目                             |
| m3     | 语句的词数目                               |
| m4     | 语句的韵律词数目                           |
| m5     | 语句的韵律短语数目                         |



## MTTS项目自行设计的上下文标注

此上下文设计时尽可能考虑了可扩展性，如果需要在某一层级添加新的属性，在该层级后面添加新的未使用的匹配组合符即可。例如声韵母层添加p6属性，原标注格式改写为...=p5#p6_即可，问题集中其他问题的答案不受影响，只需添加新的问题即可。

设置此中文上下文标注和对应问题集时参考了

- [HTS label](http://www.cs.columbia.edu/~ecooper/tts/lab_format.pdf)
- [Merlin Questions](https://github.com/CSTR-Edinburgh/merlin/tree/master/misc/questions)

对应的 [Question set](https://github.com/Jackiexiao/MTTS/blob/master/misc/questions-mandarin.hed)

备注：

- 没有设计语调短语层和段落层
- 也没有设置重音标注
- @&#$!^-+=以及/A:/B:...的使用主要是为了正则表达式匹配方便，10个符号(@&#$!^-+=)共有100个匹配组合，即可以匹配100个属性
- **如果前后位置的基元不存在的话，用xx代替，例如 xx^sil-w+o=sh**

| 层级       | 标注格式                    |
| ---------- | --------------------------- |
| 声韵母层   | p1^p2-p3+p4=p5@             |
| 声调层     | /A:a1-a2^a3@                |
| 字/音节层  | /B:b1+b2@b3^b4^b5+b6#b7-b8- |
| 词层       | /C:c1_c2^c3#c4+c5+c6&       |
| 韵律词层   | /D:d1=d2!d3@d4-d5&          |
| 韵律短语层 | /E:e1                       |
| 语句层     | /F:f1^f2=f3_f4-f5!          |

还没有使用的匹配组合符号如下

, , , , , ^!, ^*, ^&, , ^|,
, , , , , , , , -*, -|,
, , , +|, +^, +*, , , +!, ,
=^, =-, =+, ==, =|, =&, =#, , , ,
@&, @+, @*, @=, @@, , , , @!, @|,
, _+, _#, _=, *@, __, , \*&, \*!, \*|,
\#^, ,#! , #=, #@, #\*, , , ##, #|,
, &=, &+, , &@, &\*, &#, &&, &^, &|,
!^, , !+, !=, , !\*, !#, !&, !!, !|,
|^, |*, |+, |=, |@, |#, , |&, |!, ||,

原匹配组合符号

^^, ^-, ^+, ^=, ^@, ^*, ^#, ^&, ^!, ^|,
-^, --, -+, -=, -@, -*, -#, -&, -!, -|,
+^, +-, ++, +=, +@, +*, +#, +&, +!, +|,
=^, =-, =+, ==, =@, =*, =#, =&, =!, =|,
@^, @-, @+, @=, @@, @_, @#, @&, @!, @|,
_^, _-, _+, _=, _@, __, *#, \*&, \*!, \*|,
\#^, #-, #+, #=, #@, #\*, ##, #&, #!, #|,
&^, &-, &+, &=, &@, &\*, &#, &&, &!, &|,
!^, !-, !+, !=, !@, !\*, !#, !&, !!, !|,
|^, |-, |+, |=, |@, |*, |#, |&, |!, ||,

| 标号 | 含义                                  |
| ---- | ------------------------------------- |
| p1   | 前前基元                              |
| p2   | 前一基元                              |
| p3   | 当前基元                              |
| p4   | 后一基元                              |
| p5   | 后后基元                              |
| ---- | ----                                  |
| a1   | 前一音节/字的声调                     |
| a2   | 当前音节/字的声调                     |
| a3   | 后一音节/字的声调                     |
| ---- | ----                                  |
| b1   | 当前音节/字到语句开始字的距离         |
| b2   | 当前音节/字到语句结束字的距离         |
| b3   | 当前音节/字在词中的位置（正序）       |
| b4   | 当前音节/字在词中的位置（倒序）       |
| b5   | 当前音节/字在韵律词中的位置（正序）   |
| b6   | 当前音节/字在韵律词中的位置（倒序）   |
| b7   | 当前音节/字在韵律短语中的位置（正序） |
| b8   | 当前音节/字在韵律短语中的位置（倒序） |
| ---- | ----                                  |
| c1   | 前一个词的词性                        |
| c2   | 当前词的词性                          |
| c3   | 后一个词的词性                        |
| c4   | 前一个词的音节数目                    |
| c5   | 当前词中的音节数目                    |
| c6   | 后一个词的音节数目                    |
| ---- | ----                                  |
| d1   | 前一个韵律词的音节数目                |
| d2   | 当前韵律词的音节数目                  |
| d3   | 后一个韵律词的音节数目                |
| d4   | 当前韵律词在韵律短语的位置（正序）    |
| d5   | 当前韵律词在韵律短语的位置（倒序）    |
| ---- | ----                                  |
| e1   | 前一韵律短语的音节数目                |
| e2   | 当前韵律短语的音节数目                |
| e3   | 后一韵律短语的音节数目                |
| e4   | 前一韵律短语的韵律词个数              |
| e5   | 当前韵律短语的韵律词个数              |
| e6   | 后一韵律短语的韵律词个数              |
| e7   | 当前韵律短语在语句中的位置（正序）    |
| e8   | 当前韵律短语在语句中的位置（倒序）    |
| ---- | ----                                  |
| f1   | 语句的语调类型                        |
| f2   | 语句的音节数目                        |
| f3   | 语句的词数目                          |
| f4   | 语句的韵律词数目                      |
| f5   | 语句的韵律短语数目                    |



## Reference

* https://gist.github.com/candlewill/e0e3bce9139de0a058d655ae90807191
* http://www.cs.columbia.edu/~ecooper/tts/lab_format.pdf
* http://www.cs.columbia.edu/~ecooper/tts/
* http://www.sp.nitech.ac.jp/~tokuda/tokuda_iscslp2006.pdf
* [Preparing Data for Training an HTS Voice](http://www.cs.columbia.edu/~ecooper/tts/data.html)
* [HMM/DNN-based Speech Synthesis System (HTS)](http://hts.sp.nitech.ac.jp/)

