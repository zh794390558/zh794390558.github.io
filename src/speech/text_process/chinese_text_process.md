# 文本分析

## 1 拼音标注风格

读此章节时读者有必要回顾拼音的基础知识

- 中华人民共和国教育部发布的 [汉语拼音方案](http://www.moe.edu.cn/s78/A19/yxs_left/moe_810/s230/195802/t19580201_186000.html) [pdf](http://www.moe.gov.cn/ewebeditor/uploadfile/2015/03/02/20150302165814246.pdf)
- [整体认读音节](https://baike.baidu.com/item/整体认读音节/6147451?fr=aladdin)

- 整体认读音节

  **16个**整体认读音节分别是：zhi 、chi、shi、ri、zi、ci、si、yi、wu、yu、ye、yue、yuan、yin 、yun、ying，但是要注意没有yan，因为yan并不发作an音

- 声母

  **21个声母**没有什么争议，如果说有**22个声母，一般指多加一个零声母**，yw都属于零声母。如果用**23个声母，则是21声母+yw两个零声母**，如果用**27个声母**，则是将不同情况下的yw零声母分成6种情况，**标注成aa, ee, ii, oo, uu, vv，即21+6=27个声母**（具体见hmm训练，合成基元的选择一节）

- 韵母

  国家汉语拼音方案中韵母数量为**35个**，但另一说为**39个（如百度百科）**，在原国家汉语拼音方案上**增加了-i（前）、-i（后）、er、ê**。

- 下面新加的4个元音做简要解释

  * ê[ε] 在普通话中，ê只在语气词“欸”中单用【因此一些项目忽略了这个单韵母，即38个韵母】。ê不与任何辅音声母相拼，只构成复韵母ie、üe，并在书写时省去上面的附加符号“ˆ”。

  * er[] 是在[ә]的基础上加上卷舌动作而成。 发音例词：而且érqiě 儿歌érgē 耳朵ěrduō 二胡èrhú 二十èrshí 儿童értóng

  * -i(前) 指zi/ci/si中的i 发音例词：私自sīzì 此次cǐcì 次子cìzǐ 字词zìcí 自私zìsī 孜孜zīzī

  * -i(后) 指zhi/chi/shi/ri中的i 发音例词：实施shíshī 支持zhīchí 知识zhīshi 制止zhìzhǐ 值日zhírì 试制shìzhì

拼音标注风格分成两类，

1.第一类是国家规定的方案，也就是日常生活中用到的风格，规定了声母21个，其韵母表中列出35个韵母，具体参见中华人民共和国教育部发布的 [汉语拼音方案](http://www.moe.edu.cn/s78/A19/yxs_left/moe_810/s230/195802/t19580201_186000.html)

- 2.第二类是方便系统处理的拼音标注风格，不同项目有不同的注音风格，区别主要在于

  对y w的处理，有的项目为了方便处理，也将yw视为声母，有的则会将对应的yw传换成实际发音，如ye,yan,yang（整体认读音节）等改成ie,ian,iang，而不适用yw是否将整体认读音节还原成单个韵母或声母ju qu xu的标注是否转为实际发音标注，即jv qv xvyuan yue yun的标注是否转成yvan yve yvn注意到iou, uei, uen 前面加声母时，写成iu ui un，例如牛(niu), 归(gui)，论(lun)，标注时是否还原成niou, guei, luen 的问题儿化音是否简化标注，例如’花儿’，汉语拼音方案中标注为’huar’，一般我们将其转为’hua er’

- 本项目使用的风格

  将yw视作声母，但同时将ya还原成yia, ye还原成yie,其余类似标注为 jv qv xv标注为 yvan yve yvn将iou, uei, uen 标注还原ê标注为ee, er(包括儿化音中的r)标注为er, i(前)标注为ic, i(后)标记为ih声调标注，轻声标注为5，其他标注为1234

最终使用的声韵母表如下

- 声母（23个）

  b p m f d t n l g k h j q x zh ch sh r z c s y w

- 韵母（39个）

  单韵母 a、o、e、 ê、i、u、ü、-i（前）、-i（后）、er

  复韵母 ai、ei、ao、ou、ia、ie、ua、uo、 üe、iao 、iou、uai、uei

  鼻韵母 an、ian、uan、 üan 、en、in、uen、 ün 、ang、iang、uang、eng、ing、ueng、ong、iong

- 韵母（39个）（转换标注后）

  单韵母 a、o、e、ea、i、u、v、ic、ih、er

  复韵母 ai、ei、ao、ou、ia、ie、ua、uo、 ve、iao 、iou、uai、uei

  鼻韵母 an、ian、uan、 van 、en、in、uen、 vn 、ang、iang、uang、eng、ing、ueng、ong、iong

注意： * pypinyin中使用的是 yuan ju lun * 本文语料库使用的是 yvan jv lun，语料库中音素标注将yw视作声母

另外一种推荐的方案是使用27个声母，即去掉yw

- 声母（27个）

  b p m f d t n l g k h j q x zh ch sh r z c s aa ee ii oo uu vv

## 2 多音字的处理

本项目使用了pypinyin

## 3 文本规范化

本项目暂时没有实现此功能

对文本进行预处理，主要是去掉无用字符，全半角字符转化等

- 有时候普通话文本中会出现简略词、日期、公式、号码等文本信息，这就需要通过文本规范化，对这些文本块进行处理以正确发音[7]。例如

  “小明体重是 128 斤”中的“128”应该规范为“一百二十八”，而“G128 次列车”中的“128” 应该规范为“一 二 八”；“2016-05-15”、“2016 年 5 月 15 号”、“2016/05/15”可以统一为一致的发音

- 对于英文而言，如：

  2011 NYER twenty eleven£100 MONEY one hundred poundsIKEA ASWD apply letter-to-sound100 NUM one hundredDVD LSEQ D. V. D. ꔄ dee vee dee

## 4 词性标注

本项目使用 结巴 工具进行词性标注。结巴分词工具包采用和 ictclas 兼容的标记法。由于结巴分词的标准较为简单，本项目使用结巴的词性标注规范，在上下文标注和问题集中只取大类标注，即字母a-z所代表的词性，具体见下方列表中给出的结巴词性标注表

- 词性标注规范

  [结巴使用的词性标注表](https://github.com/Jackiexiao/MTTS/tree/master/docs/mddocs/jieba.md)[中科院ictclas规范](https://github.com/Jackiexiao/MTTS/tree/master/docs/mddocs/ictclas.md)[斯坦福Stanford coreNLP宾州树库的词性标注规范](https://github.com/Jackiexiao/MTTS/tree/master/docs/mddocs/Stanford_coreNLP.md)[ICTPOS3.0词性标记集](https://gist.github.com/luw2007/6016931) 链接中还包括了ICTCLAS 汉语词性标注集、jieba 字典中出现的词性、simhash 中可以忽略的部分词性北大标注集

## 5 句子语气类型

[todo]找到能自动标识句子语气类型的工具

| 句子语气的类型 | 陈述句 | 疑问句 | 祈使句 | 感叹句 |
| -------------- | ------ | ------ | ------ | ------ |
| 标识符         | d      | e      | i      | q      |

## 6 中文分词

本项目使用了结巴分词器，读者可以按自己的需要选择其他分词器，可见github项目：[中文分词器分词效果评估对比](https://github.com/ysc/cws_evaluation)

## Reference

* https://mtts.readthedocs.io/zh_CN/latest/text_analyse.html





## **声韵母与停顿的标记格式**

- 标注符号采用a，b，d，s四种标记符号进行标注，标注符号的意思如下：

  a表示中文汉字的声母。

  b表示中文汉字的韵母。

  d表示句中的静音长度小于100ms的停顿。

  s表示句子的起始点和结束点以及句中大于100ms的停顿。

  

## **声韵标注的具体规则**

> 1. 中文汉字拼音的声母用a表示，韵母用b表示。
> 2. 其中有一些汉字音节以元音开头，称为零声母音节，如a/o/e/ang/eng/en/ai/ei/ao/ou/an/er/，我们用标记点a来进行标注。
> 3. 其中有一些汉字是特殊读音，仅仅表示鼻子发出的气流，如m/n/ng/，分别对应汉字（呣，嗯，嗯），我们用标记点b来进行标注。
> 4. 汉字发音为yu/yi/wu/的为整体认读音节，但我们此次把以w，y为声母加韵母的拼音按照声韵进行切分。

举一个例子

```
我#1就怕#2自己的#1俗气#3亵渎了#2普者黑的#1风景

wo3 jiu4 pa4 zi4 ji3 de5 su2 qi4 xie4 du2 le5 pu2 zhe3 hei1 de5 feng1 jing3
```

​	* https://mtts.readthedocs.io/zh_CN/latest/corpus.html



## [23_initial_39_final_3_sil](https://github.com/Jackiexiao/MTTS/tree/master/docs/misc/23_initial_39_final_3_sil)

* [**mono.list**](https://github.com/Jackiexiao/MTTS/blob/master/docs/misc/23_initial_39_final_3_sil/mono.list)
* [**mono_tone.list** ](



# MTTS项目的设计规则

## 1 合成基元

这里选取声韵母作为基元，同时为了模拟发音中的停顿，可以将短时停顿和长时停顿看做是合成基元，此外，将句子开始前和结束时的静音sil也当做合成基元

### **合成基元的列表**

本项目选用的合成基元为

- 声母 | 21个声母+wy（共23个）
- 韵母 | 39个韵母
- 静音 | sil pau sp

sil(silence) 表示句首和句尾的静音，pau(pause) 表示由逗号，顿号造成的停顿，句中其他的短停顿为sp(short pause)

- 声母（23个）

  b p m f d t n l g k h j q x zh ch sh r z c s y w

- 韵母（39个）

  单韵母 a、o、e、 ê、i、u、ü、-i（前）、-i（后）、er复韵母 ai、ei、ao、ou、ia、ie、ua、uo、 üe、iao 、iou、uai、uei鼻韵母 an、ian、uan、 üan 、en、in、uen、 ün 、ang、iang、uang、eng、ing、ueng、ong、iong

- 韵母（39个）（转换标注后）

  单韵母 a、o、e、ea、i、u、v、ic、ih、er复韵母 ai、ei、ao、ou、ia、ie、ua、uo、 ve、iao 、iou、uai、uei鼻韵母 an、ian、uan、 van 、en、in、uen、 vn 、ang、iang、uang、eng、ing、ueng、ong、iong

### **其他项目的方法-引入零声母，这里没有采用**

6个零声母的引入是为了减少上下文相关的tri-IF数目，这样就可以使得每个音节都是由声母和韵母组成，原先一些只有韵母的音节可以被视作是声母和韵母的结构，这样一来，基元就只有 声母-韵母-声母 以及 韵母-声母-韵母 两种结构，而不会出现两个韵母相邻的情况，进而明显减少了上下文相关的基元。

- 如果这么做的话就是21+6=27个声母，可以将零声母标记成 aa, ee, ii, oo, uu, vv，一是将yw替换，二是将一个韵母组成的音节手动添加上零声母，举例

  ye,yan,yang（整体认读音节）标注成——ii ie, ii ian, ii iang （ie, ian, iang是真实发音的韵母）ao an ou 熬 安 欧, 标记成 aa ao, aa an, oo ou

## 2上下文相关标注与问题集

上下文相关标注的规则要综合考虑有哪些上下文对当前音素发音的影响，总的来说，需要考虑发音基元及其前后基元的信息，以及发音基元所在的音节、词、韵律词、韵律短语、语句相关的信息。

本项目的设计规则参考了 [面向汉语统计参数语音合成的标注生成方法](https://github.com/Jackiexiao/MTTS/tree/master/docs/mddocs/mandarin_example_label.md)

具体规则与示例 * [上下文相关标注](https://github.com/Jackiexiao/MTTS/blob/master/docs/mddocs/mandarin_label.md) * [问题集设计规则和示例](https://github.com/Jackiexiao/MTTS/blob/master/docs/mddocs/question.md) * [完整问题集文件](https://github.com/Jackiexiao/MTTS/blob/master/docs/misc/23_initial_39_final_3_sil/question.hed)

问题集(Question Set)即是决策树中条件判断的设计。问题集通常很大，由几百个判断条件组成。 [一个典型的英文问题集文件(merlin)](https://github.com/CSTR-Edinburgh/merlin/blob/master/misc/questions/questions-radio_dnn_416.hed)

问题集的设计依赖于不同语言的语言学知识，而且与上下文标注文件相匹配，改变上下文标注方法也需要相应地改变问题集，对于中文语音合成而言，问题集的设计的规则有:

- 前前个，前个，当前，下个，下下个声韵母分别是某个合成基元吗，合成基元共有65个(23声母+39韵母+3静音)，例如判断是否是元音a QS “LL-a” QS “L-a” QS “C-a” QS “R-a” QS “RR-a”
- 声母特征划分，例如声母可以划分成塞音，擦音，鼻音，唇音等，声母特征划分24个
- 韵母特征划分，例如韵母可以划分成单韵母，复合韵母，分别包含aeiouv的韵母，韵母特征划分8个
- 其他信息划分，词性划分，26个词性; 声调类型，5个; 是否是声母或者韵母或者静音，3个
- 韵律特征划分，如是否是重音，重音和韵律词/短语的位置数量
- 位置和数量特征划分

对于三音素模型而言，对于每个划分的特征，都会产生3个判断条件，该音素是否满足条件，它的左音素（声韵母）和右音素（声韵母）是否满足条件，有时会扩展到左左音素和右右音素的情况，这样就有5个问题。其中，每个问题都是以 QS 命令开头，问题集的答案可以有多个，中间以逗号隔开，答案是一个包含通配符的字符串。当问题表达式为真时，该字符串成功匹配标注文件中的某一行标注。格式如：

QS 问题表达式 {答案 1，答案 2，答案 3，……}

QS “LL==Fricative” {f^*,s^*,sh^*,x^*,h^*,lh^*,hy^*,hh^*}

对于3音素上下文相关的基元模型的3个问题，例如： * 判断当前，前接，后接音素/单元是否为擦音 * QS ‘C_Fricative’ * QS ‘L_Fricative’ * QS ‘R_Fricative’

更多示例：

| Question         | 含义                   |
| ---------------- | ---------------------- |
| QS “C_a”         | 当前单元是否为韵母a    |
| QS “L_Fricative” | 前接单元是否为擦音     |
| QS “R_Fricative” | 后接单元是否为擦音     |
| QS “C_Fricative” | 当前单元是否为擦音     |
| QS “C_Stop”      | 当前单元是否为塞音     |
| QS “C_Nasal”     | 当前单元是否为鼻音     |
| QS “C_Labial”    | 当前单元是否为唇音     |
| QS “C_Apieal”    | 当前单元是否为顶音     |
| QS “C_TypeA”     | 含有a的韵母            |
| QS “C_TypeE”     | 含有e的韵母            |
| QS “C_TypeI”     | 含有i的韵母            |
| QS “C_POS==a”    | 当前单元是否为形容词   |
| QS “C_Toner==1”  | 当前单元音调是否为一声 |

值得注意的是，merlin中使用的问题集和HTS中有所不同，Merlin中新增加了CQS问题，Merlin处理Questions Set 的模块在merlin/src/frontend/label_normalisation 中的Class HTSLabelNormalisation

- Question Set 的格式是

  **QS + 一个空格 + “question_name” + 任意空格+ {Answer1, answer2, answer3…}**  # 无论是QS还是CQS的answer中，前后的**不用加，加了也会被去掉 

  **CQS + 一个空格 + “question_name” + 任意空格+ {Answer}**  #对于CQS，这里只能有一个answer 比如 CQS C-Syl-Tone {_(d+)+} merlin也支持浮点数类型，只需改为CQS C-Syl-Tone {_([d.]+)+}

