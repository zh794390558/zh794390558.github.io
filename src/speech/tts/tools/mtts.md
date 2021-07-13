# MTTS

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/syllable-arch.jpeg)

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/hmm-tts.png)

![](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/tone-f0.jpeg)

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/f0.jpeg)



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
* [**mono_tone.list** ](https://github.com/Jackiexiao/MTTS/blob/master/docs/misc/23_initial_39_final_3_sil/mono_tone.list)



## 本项目自行设计的上下文标注

设置此中文上下文标注和对应问题集时参考了

- [HTS label](http://www.cs.columbia.edu/~ecooper/tts/lab_format.pdf)
- [Merlin Questions](https://github.com/CSTR-Edinburgh/merlin/tree/master/misc/questions)

对应的 [Question set](https://github.com/Jackiexiao/MTTS/blob/master/misc/questions-mandarin.hed)

备注：

- 没有设计语调短语层和段落层
- 也没有设置重音标注
- @&#$!^-+=以及/A:/B:...的使用主要是为了正则表达式匹配方便，10个符号(@&#$!^-+=)共有100个匹配组合，即可以匹配100个属性
- **如果前后位置的基元不存在的话，用xx代替**，例如 xx^sil-w+o=sh

```
层级          标注格式  
声韵母层     p1^p2-p3+p4=p5@p6@  
声调层       /A:a1-a2^a3@  
字/音节层    /B:b1+b2@b3^b4^b5+b6#b7-b8-  
词层         /C:c1_c2^c3#c4+c5+c6&  
韵律词层     /D:d1=d2!d3@d4-d5&  
韵律短语层   /E:e1|e2-e3@e4#e5&e6!e7-e8#  
语句层       /F:f1^f2=f3_f4-f5!  
```

| 标号 | 含义                                  |
| ---- | ------------------------------------- |
| p1   | 前前基元                              |
| p2   | 前一基元                              |
| p3   | 当前基元                              |
| p4   | 后一基元                              |
| p5   | 后后基元                              |
| p6   | 当前音节的元音                        |
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



## **questions-mandarin.hed**

* https://github.com/Jackiexiao/MTTS/blob/master/misc/questions-mandarin.hed



## **mandarin-for-montreal-forced-aligner-pre-trained-model.lexicon**

* https://github.com/Jackiexiao/MTTS/blob/master/misc/mandarin-for-montreal-forced-aligner-pre-trained-model.lexicon



## **mandarin_mtts.lexicon**

* https://github.com/Jackiexiao/MTTS/blob/master/misc/mandarin_mtts.lexicon



## 语音合成测试语料库

目标是设计1000句左右的测试语料，包含多方面考察点，以便用于合成语音的评价和分析。

### 基本要求

- 尽可能覆盖所有发音
- 覆盖发音字，轻声，儿话音，上声单音节
- 包含一些生僻字
- 标注韵律
- 覆盖所有语气类型，陈述句，疑问句，感叹句，祈使句等等
- 覆盖常见的不同说话场景：新闻，日常对话，演讲等
- 覆盖分词测试，例如人名，地名
- 包括汉语中参见的英文缩写发音，度量单位，数字串
- 包含英语和汉语两种语言的测试语料
- 变调规则，例如两个三声连着读第一个字读二声 todo

### 汉语部分

```
101 向#1香港#2特别#1行政区#1同胞，#4澳门#2和#1台湾#1同胞#2海外#1侨胞
102 向#1香港#2特别#1行政区#4同胞，#4澳门#1和#1台湾#1同胞#4，海外#3侨胞
103 向香港特别行政区同胞，澳门和台湾同胞，海外侨胞，致以诚挚的问候和良好的祝愿
104 这#1两批#1货物#2都打折出售#4，严重#2折本#3，他#1再也#2经不起#1这样折腾。
105 他#1每次#2出差#3，差不多#1都要#1出点#1差错。
106 广州市#1明天#2多云转晴。
107 江南、#3华南#1东部#3以及#1四川、#3重庆、#1湖北#3有#1小到#1中雨
108 呵呵#3，我不知道诶#4，我现在#1什么#1都不想说。		
109 一二三四五六七八九十十一十二一百两千三万四亿五兆六六六
110 六百#1九十一万#2三千零一元
111 啊！欸？恩。好。额。哼！喵喵。
112 姑姑舅舅#3，这个#1哑巴#3在打量#1我，真不是个东西！
113 爹爹#1明白#1之后#3，鸡皮疙瘩#2都起来了。
114 后面#1住的#3都是#1什么#1人？
115 难道#3咱们#1就#1一点#1盼望#3也没#1有了吗？
116 猩猩#1中弹#2之后#1动弹不得。
117 立定！不许胡说！找个地方坐下！
118 老风刀勾亏丑工光女扑虫书乒乓鸟
119 房客#2有时#2想要#1早餐#4，有时#1想要#1大床房#3，如果#2比较#1好一#1点的，就#1先预留#1给他们。让他们#1可以#2先到一旁#1坐着#1等候#4。我们#1一会#2就可以#1安排好。
120 美国会通过对台售武法案。
121 体重128斤的小明手机是1289025621，他现在在乘坐G128列车。
122 KFC，ATM，CNN。
123 八百标兵奔北坡，北坡炮兵并排跑，炮兵怕把标兵碰，标兵怕碰炮兵炮。
124 吃葡萄不吐葡萄皮儿，不吃葡萄倒吐葡萄皮儿。
125 我和林小兰打算过去广州番禺天和服装厂
126 吴小姐和曾先生曾经去过那里
```

### 说明

```
101 韵律
102 不同韵律
103 无韵律
104 多音字测试：打折（zhé），折（shé）本，折（zhē）腾。
105 多音字测试：出差（chāi）差（chà）不多差（chā）错
106 天气
107 天气
108 日常对话&带情感
109 数字串
110 数字串
111 语气词
112 轻声：姑姑 舅舅 哑巴 打量 东西
113 轻声：爹爹 明白 疙瘩 
114 疑问句
115 疑问句
116 多音字：中弹（dan4）动弹（tan3）
117 祈使句：立定！不许胡说！找个地方坐下！
118 儿话音
119 长句&日常对话
120 中文分词歧义：既可以切分成“美国/会/通过对台售武法案”，又可以切分成“美/国会/通过对台售武法案”
121 数字规范化：小明体重是128斤”中的"128"应该规范为"一百二十八"，而"G128次列车”中的"128"应该规范为“一二八”，而电话中却读作幺二八
122 英文缩写：KFC，ATM，CNN。
123 绕口令
124 绕口令
125 分词中的人名和地名
126 分词与多音字
```

### English

reference: [google tacotron2 example] (https://github.com/google/tacotron/tree/master/publications/tacotron2)

```
201 Generative adversarial network or variational auto-encoder.
202 Basilar membrane and otolaryngology are not auto-correlations.
203 He has read the whole thing.
204 He reads books
205 Don't desert me here in the desert!
206 He thought it was time to present the present.
207 Thisss isrealy awhsome
208 This is your personal assistant, Google Home.
209 This is your personal assistant Google Home.
210 The buses aren't the problem, they actually provide a solution.
211 The buses aren't the PROBLEM, they actually provide a SOLUTION.
212 The quick brown fox jumps over the lazy dog.
213 Does the quick brown fox jump over the lazy dog?
214 She sells sea-shells on the sea-shore. The shells she sells are sea-shells I'm sure.
215 Peter Piper picked a peck of pickled peppers. How many pickled peppers did Peter Piper pick?
```

### explanation

```
201 out-of-domain and complex words
202 out-of-domain and complex words
203 polyphone
204 polyphone
205 polyphone
206 polyphone
207 spelling errors
208 punctuation
209 punctuation
210 stress and intonation
211 stress and intonation
212 declarative sentences
213 interrogative sentences
214 tongue twisters
215 tongue twisters
```



## lab file

`start-time-stamp end-time-stamp context-label`

```
0 2823000 xx^xx-sil+x=iang4@/A:xx-xx^xx@/B:xx+xx@xx^xx^xx+xx#xx-xx-/C:xx_xx^xx#xx+xx+xx&/D:xx=xx!xx@xx-xx&/E:xx|xx-xx@xx#xx&xx!xx-xx#/F:xx^xx=xx_xx-xx!
2823000 4167000 xx^sil-x+iang4=x@/A:xx-4^1@/B:0+20@1^1^1+1#1-1-/C:xx_p^n#xx+1+7&/D:xx=1!7@1-1&/E:xx|1-12@xx#1&4!1-3#/F:xx^21=7_7-3!
4167000 7052500 sil^x-iang4+x=iang1@/A:xx-4^1@/B:0+20@1^1^1+1#1-1-/C:xx_p^n#xx+1+7&/D:xx=1!7@1-1&/E:xx|1-12@xx#1&4!1-3#/F:xx^21=7_7-3!
7052500 8160500 x^iang4-x+iang1=g@/A:4-1^3@/B:1+19@1^7^1+7#1-12-/C:p_n^n#1+7+2&/D:1=7!2@1-4&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
8160500 10202000 iang4^x-iang1+g=ang3@/A:4-1^3@/B:1+19@1^7^1+7#1-12-/C:p_n^n#1+7+2&/D:1=7!2@1-4&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
10202000 10542000 x^iang1-g+ang3=t@/A:1-3^4@/B:2+18@2^6^2+6#2-11-/C:p_n^n#1+7+2&/D:1=7!2@1-4&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
10542000 12538000 iang1^g-ang3+t=e4@/A:1-3^4@/B:2+18@2^6^2+6#2-11-/C:p_n^n#1+7+2&/D:1=7!2@1-4&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
12538000 13630000 g^ang3-t+e4=b@/A:3-4^2@/B:3+17@3^5^3+5#3-10-/C:p_n^n#1+7+2&/D:1=7!2@1-4&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
13630000 14774000 ang3^t-e4+b=ie2@/A:3-4^2@/B:3+17@3^5^3+5#3-10-/C:p_n^n#1+7+2&/D:1=7!2@1-4&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
14774000 15143000 t^e4-b+ie2=x@/A:4-2^2@/B:4+16@4^4^4+4#4-9-/C:p_n^n#1+7+2&/D:1=7!2@1-4&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
15143000 16549000 e4^b-ie2+x=ing2@/A:4-2^2@/B:4+16@4^4^4+4#4-9-/C:p_n^n#1+7+2&/D:1=7!2@1-4&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
16549000 17661000 b^ie2-x+ing2=zh@/A:2-2^4@/B:5+15@5^3^5+3#5-8-/C:p_n^n#1+7+2&/D:1=7!2@1-4&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
17661000 19040000 ie2^x-ing2+zh=eng4@/A:2-2^4@/B:5+15@5^3^5+3#5-8-/C:p_n^n#1+7+2&/D:1=7!2@1-4&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
19040000 19409500 x^ing2-zh+eng4=q@/A:2-4^1@/B:6+14@6^2^6+2#6-7-/C:p_n^n#1+7+2&/D:1=7!2@1-4&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
19409500 20930000 ing2^zh-eng4+q=v1@/A:2-4^1@/B:6+14@6^2^6+2#6-7-/C:p_n^n#1+7+2&/D:1=7!2@1-4&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
20930000 21927000 zh^eng4-q+v1=t@/A:4-1^2@/B:7+13@7^1^7+1#7-6-/C:p_n^n#1+7+2&/D:1=7!2@1-4&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
21927000 22858000 eng4^q-v1+t=ong2@/A:4-1^2@/B:7+13@7^1^7+1#7-6-/C:p_n^n#1+7+2&/D:1=7!2@1-4&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
22858000 23924000 q^v1-t+ong2=b@/A:1-2^1@/B:8+12@1^2^1+2#8-5-/C:n_n^n#7+2+2&/D:7=2!2@2-3&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
23924000 25583000 v1^t-ong2+b=ao1@/A:1-2^1@/B:8+12@1^2^1+2#8-5-/C:n_n^n#7+2+2&/D:7=2!2@2-3&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
25583000 25933000 t^ong2-b+ao1=pau@/A:2-1^4@/B:9+11@2^1^2+1#9-4-/C:n_n^n#7+2+2&/D:7=2!2@2-3&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
25933000 28348000 ong2^b-ao1+pau=ao4@/A:2-1^4@/B:9+11@2^1^2+1#9-4-/C:n_n^n#7+2+2&/D:7=2!2@2-3&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
28348000 34773000 b^ao1-pau+ao4=m@/A:xx-xx^xx@/B:xx+xx@xx^xx^xx+xx#xx-xx-/C:xx_xx^xx#xx+xx+xx&/D:xx=xx!xx@xx-xx&/E:xx|xx-xx@xx#xx&xx!xx-xx#/F:xx^xx=xx_xx-xx!
34773000 36428000 ao1^pau-ao4+m=en2@/A:1-4^2@/B:10+10@1^2^1+2#10-3-/C:n_n^c#2+2+1&/D:2=2!1@3-2&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
36428000 37145000 pau^ao4-m+en2=h@/A:4-2^2@/B:11+9@2^1^2+1#11-2-/C:n_n^c#2+2+1&/D:2=2!1@3-2&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
37145000 39154000 ao4^m-en2+h=e2@/A:4-2^2@/B:11+9@2^1^2+1#11-2-/C:n_n^c#2+2+1&/D:2=2!1@3-2&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
39154000 40109000 m^en2-h+e2=t@/A:2-2^2@/B:12+8@1^1^1+1#12-1-/C:n_c^n#2+1+4&/D:2=1!4@4-1&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
40109000 41547000 en2^h-e2+t=ai2@/A:2-2^2@/B:12+8@1^1^1+1#12-1-/C:n_c^n#2+1+4&/D:2=1!4@4-1&/E:1|12-8@1#4&2!2-2#/F:xx^21=7_7-3!
41547000 42775500 h^e2-t+ai2=w@/A:2-2^1@/B:13+7@1^4^1+4#1-8-/C:c_n^n#1+4+4&/D:1=4!4@1-2&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
42775500 44298000 e2^t-ai2+w=uan1@/A:2-2^1@/B:13+7@1^4^1+4#1-8-/C:c_n^n#1+4+4&/D:1=4!4@1-2&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
44298000 44833999 t^ai2-w+uan1=t@/A:2-1^2@/B:14+6@2^3^2+3#2-7-/C:c_n^n#1+4+4&/D:1=4!4@1-2&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
44833999 46376000 ai2^w-uan1+t=ong2@/A:2-1^2@/B:14+6@2^3^2+3#2-7-/C:c_n^n#1+4+4&/D:1=4!4@1-2&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
46376000 47079000 w^uan1-t+ong2=b@/A:1-2^1@/B:15+5@3^2^3+2#3-6-/C:c_n^n#1+4+4&/D:1=4!4@1-2&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
47079000 48792000 uan1^t-ong2+b=ao1@/A:1-2^1@/B:15+5@3^2^3+2#3-6-/C:c_n^n#1+4+4&/D:1=4!4@1-2&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
48792000 49088000 t^ong2-b+ao1=pau@/A:2-1^3@/B:16+4@4^1^4+1#4-5-/C:c_n^n#1+4+4&/D:1=4!4@1-2&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
49088000 51089000 ong2^b-ao1+pau=h@/A:2-1^3@/B:16+4@4^1^4+1#4-5-/C:c_n^n#1+4+4&/D:1=4!4@1-2&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
51089000 54047000 b^ao1-pau+h=ai3@/A:xx-xx^xx@/B:xx+xx@xx^xx^xx+xx#xx-xx-/C:xx_xx^xx#xx+xx+xx&/D:xx=xx!xx@xx-xx&/E:xx|xx-xx@xx#xx&xx!xx-xx#/F:xx^xx=xx_xx-xx!
54047000 55240000 ao1^pau-h+ai3=w@/A:1-3^4@/B:17+3@1^4^1+4#5-4-/C:n_n^xx#4+4+xx&/D:4=4!xx@2-1&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
55240000 56717000 pau^h-ai3+w=uai4@/A:1-3^4@/B:17+3@1^4^1+4#5-4-/C:n_n^xx#4+4+xx&/D:4=4!xx@2-1&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
56717000 57211500 h^ai3-w+uai4=q@/A:3-4^2@/B:18+2@2^3^2+3#6-3-/C:n_n^xx#4+4+xx&/D:4=4!xx@2-1&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
57211500 58857000 ai3^w-uai4+q=iao2@/A:3-4^2@/B:18+2@2^3^2+3#6-3-/C:n_n^xx#4+4+xx&/D:4=4!xx@2-1&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
58857000 60138500 w^uai4-q+iao2=b@/A:4-2^1@/B:19+1@3^2^3+2#7-2-/C:n_n^xx#4+4+xx&/D:4=4!xx@2-1&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
60138500 62168000 uai4^q-iao2+b=ao1@/A:4-2^1@/B:19+1@3^2^3+2#7-2-/C:n_n^xx#4+4+xx&/D:4=4!xx@2-1&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
62168000 62606500 q^iao2-b+ao1=sil@/A:2-1^xx@/B:20+0@4^1^4+1#8-1-/C:n_n^xx#4+4+xx&/D:4=4!xx@2-1&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
62606500 64912000 iao2^b-ao1+sil=xx@/A:2-1^xx@/B:20+0@4^1^4+1#8-1-/C:n_n^xx#4+4+xx&/D:4=4!xx@2-1&/E:12|8-xx@4#2&xx!3-1#/F:xx^21=7_7-3!
64912000 67795000 b^ao1-sil+xx=xx@/A:xx-xx^xx@/B:xx+xx@xx^xx^xx+xx#xx-xx-/C:xx_xx^xx#xx+xx+xx&/D:xx=xx!xx@xx-xx&/E:xx|xx-xx@xx#xx&xx!xx-xx#/F:xx^xx=xx_xx-xx!
```



## Sfs file

`end-time-stamp label-type`

```
2823000 s
4167000 a
7052500 b
8160500 a
10202000 b
10542000 a
12538000 b
13630000 a
14774000 b
15143000 a
16549000 b
17661000 a
19040000 b
19409500 a
20930000 b
21927000 a
22858000 b
23924000 a
25583000 b
25933000 a
28348000 b
34773000 s
36428000 a
37145000 a
39154000 b
40109000 a
41547000 b
42775500 a
44298000 b
44833999 a
46376000 b
47079000 a
48792000 b
49088000 a
51089000 b
54047000 s
55240000 a
56717000 b
57211500 a
58857000 b
60138500 a
62168000 b
62606500 a
64912000 b
67795000 s
```



## Reference

* https://github.com/thuhcsi/Crystal