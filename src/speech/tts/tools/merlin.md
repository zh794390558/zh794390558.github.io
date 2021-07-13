# Merlin

Merlin 的简要介绍 Merlin 不是一个完整的 TTS 系统，它只是提供了 TTS 核心的声学建模模块（声学和语 音特征归一化，神经网络声学模型训练和生成).



## Mandarin egs

* https://github.com/CSTR-Edinburgh/merlin/tree/master/egs/mandarin_voice



## File Type

| Folder                                                       | Contains                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Recordings                                                   | speech recordings, copied from the studio                    |
| Wav                                                          | individual wav files for each utterance                      |
| pm                                                           | pitch marks                                                  |
| [Mfcc](http://practicalcryptography.com/miscellaneous/machine-learning/guide-mel-frequency-cepstral-coefficients-mfccs/) | MFCCs for use in automatic alignment                         |
| Lab                                                          | label files from automatic alignment                         |
| Utt                                                          | Festival utterance structures                                |
| F0                                                           | Pitch contours                                               |
| Coef                                                         | MFCCs + f0, for the join cost                                |
| coef2                                                        | coef2, but stripped of unnecessary frames to save space, for the join cost |
| lpc                                                          | LPCs and residuals, for waveform generation                  |
| bap                                                          | band aperiodicity                                            |



## English Text FrontEnd

- 在Merlin中，Label有两种类别，分别是

  **state align**（使用HTK来生成，以发音状态为单位的label文件，一个音素由几个发音状态组成）

  **phoneme align**（使用Festvox来生成，以音素为单位的label文件）

* txt to utt

  文本到文本规范标注文件是非常重要的一步，这涉及自然语言处理，对于英文来说，具体工程实现可使用 Festival，参见：[Creating .utt Files for English](http://www.cs.columbia.edu/~ecooper/tts/utt_eng.html)

  Festival 使用了**英文词典，语言规范等文件**，用最新的 EHMM alignment 工具将txt转换成**包含了文本特征（如上下文，韵律等信息）的utt文件**

* utt to label

  **在获得utt的基础上，需要对每个音素的上下文信息，韵律信息进行更为细致的整理**，对于英文的工程实现可参见：[Creating Label Files for Training Data](http://www.cs.columbia.edu/~ecooper/tts/labels.html)

  label文件的格式请参见：[lab_format.pdf](http://www.cs.columbia.edu/~ecooper/tts/lab_format.pdf)

* label to training-data(Question file)

  The questions in the question file will be used to convert the full-context labels into binary and/or numerical features for vectorization. It is suggested to do a manual selection of the questions, as the number of questions will affect the dimensionality of the vectorized input features.

  * 在Merlin目录下，merlin/misc/questions目录下，有两个不同的文件，分别是：

    questions-radio_dnn_416.hedquestions-unilex_dnn_600.hed

  查看这两个文件，我们不难发现，questions-radio_dnn_416.hed定义了一个416维度的向量，向量各个维度上的值由label文件来确定，也即是说，从label文件上提取必要的信息，我们可以很轻易的按照定义确定Merlin训练数据training-data；同理questions-unilex_dnn_600.hed确定了一个600维度的向量，各个维度上的值依旧是由label文件加以确定。



## Merlin vocoder声码器

Merlin中自带的vocoder工具有以下三类：Straight，World，World_v2

这三类工具可以在Merlin的文件目录下找到，具体的路径如下merlin/misc/scripts/vocoder

在介绍三类vocoder之前，首先说明几个概念：

- **MGC特征(Mel-generalized cepstral)**

  通过语音提取的MFCC特征由于维度太高，并不适合直接放到网络上进行训练，所以就出现了MGC特征，将提取到的MFCC特征降维（在这三个声码器中MFCC都被统一将低到60维），以这60维度的数据进行训练就形成了我们所说的MGC特征

- **BAP特征**

  Band Aperiodicity的缩写

- **LF0**

  LF0是语音的基频特征

**Straight**

音频文件通过Straight声码器产生的是：**60维的MGC特征，25维的BAP特征，以及1维的LF0特征**。

通过 STRAIGHT 合成器提取的谱参数具有独特特征(维数较高), 所以它不能直接用于 HTS 系统中, 需要使用 SPTK 工具将其特征参数降维, 转换为 HTS 训练中可用的 **mgc(Mel-generalized cepstral)**参数, 即, 就是由 STRAIGHT 频谱计算得到 mgc 频谱参数, 最后利用原 STRAIGHT 合成器进行语音合成

**World**

音频文件通过World声码器产生的是：**60维的MGC特征，可变维度的BAP特征，以及1维的LF0特征**，对于16kHz采样的音频信号，BAP的维度为1，对于48kHz采样的音频信号，BAP的维度为5

网址为：[github.com/mmorise/World](https://github.com/mmorise/World)



## 声学特征提取

本文介绍如何提取提取声学特征用于Merlin训练。在语音合成中，属于声码器(vocoder)的内容。

Merlin可以使用两种vocoder，`STRAIGHT`或`WORLD`。

`WORLD`的目标是提取60-dim MGC, variable-dim BAP (BAP dim: 1 for 16Khz, 5 for 48Khz), 1-dim LF0；

`STRAIGHT`的目标是提取60-dim MGC, 25-dim BAP, 1-dim LF0。

新版本的`WORLD_v2`还在开发中，目标是提取60-dim MGC, 5-dim BAP, 1-dim LF0(MGC和BAP的维度支持微调)。

由于`STRAIGHT`的使用有严格的证书限制，本文，主要介绍`WORLD`。

### 代码

代码路径为：https://github.com/CSTR-Edinburgh/merlin/blob/master/misc/scripts/vocoder/world/extract_features_for_merlin.py

在这个代码中，主要是调用`world`的`analysis`和`sptk`的`x2x`工具。

#### 输入

在调用时需要指定四个参数，如下所示：

```
python extract_features_for_merlin.py <path_to_merlin_dir> <path_to_wav_dir> <path_to_feat_dir> <sampling frequency>

<path_to_merlin_dir>    Merlin安装路径，借此，可以定位到world和sptk路径
<path_to_wav_dir>       原始音频路径
<path_to_feat_dir>      提取出的特征所保存的路径
<sampling frequency>    采样率
```

#### 输出

在<path_to_feat_dir>路径下创建三个目录：

```
|-- bap
|-- lf0
`-- mgc
```

分别用于保存不同类型的特征。



## 生成Merlin的英文label用于语音合成

注意到merlin是没有自带frontend的，对于英文，你需要安装Festival来将文本转换成HTS label, 对于其他语言，你需要自行设计或者找到支持的frontend，中文目前网络上还没有开源的工具，所以你需要自己设计

英文FrontEnd安装 具体步骤如下参见：[Create_your_own_label_Using_Festival.md](https://github.com/Jackiexiao/MTTS/blob/master/docs/mddocs/Create_your_own_label_Using_Festival.md)

安装完毕之后，参考merlin/tools/alignment 里面的文档生成自己的英文label



## forced alignment

前文利用festival提取了文本标签，历经`festival -b <scm_file>`、`dumpfeats`、归一化等操作，形成了归一化的full context labels。本文，我们将介绍如何使用HTK工具，利用full context labels和wav实现对齐。

注意：Merlin提供了state和phone两种级别的对齐。由于state对齐性能更好，本文，我们只考虑如何进行state级别的对齐。

### 初探

对齐脚本位于：https://github.com/CSTR-Edinburgh/merlin/tree/master/misc/scripts/alignment/state_align

目录结构如下：

```
├── binary_io.py
├── forced_alignment.py
├── htk_io.py
├── htkmfc.py
├── mean_variance_norm.py
├── prepare_labels_from_txt.sh
├── README.md
├── run_aligner.sh
└── setup.sh
```

运行方式为：

```
python $aligner/forced_alignment.py
```

不带任何参数，如需修改，可通过`sed`命令修改，例如：

```
sed -i s#'HTKDIR =.*'#'HTKDIR = "'$HTKDIR'"'# $aligner/forced_alignment.py                       # HTK目录
sed -i s#'work_dir =.*'#'work_dir = "'$WorkDir/$lab_dir'"'# $aligner/forced_alignment.py         # 工作路径，里面包含一个子目录"label_no_align"，为未对齐的标签
sed -i s#'wav_dir =.*'#'wav_dir = "'$wav_dir'"'# $aligner/forced_alignment.py                    # 音频所在路径
```

未对齐标签格式如下所示，不含有时间信息(time steps)：

```
$ cat label_no_align/arctic_b0001.lab

x^x-sil+g=ae@x_x/A:0_0_0/B:x-x-x@x-x&x-x#x-x$x-x!x-x;x-x|x/C:1+1+3/D:0_0/E:x+x@x+x&x+x#x+x/F:content_1/G:0_0/H:x=x@1=1|0/I:7=5/J:7+5-1
x^sil-g+ae=d@1_3/A:0_0_0/B:1-1-3@1-1&1-7#1-5$1-3!0-1;0-1|ae/C:1+1+2/D:0_0/E:content+1@1+5&1+4#0+1/F:content_1/G:0_0/H:7=5@1=1|L-L%/I:0=0/J:7+5-1
sil^g-ae+d=d@2_2/A:0_0_0/B:1-1-3@1-1&1-7#1-5$1-3!0-1;0-1|ae/C:1+1+2/D:0_0/E:content+1@1+5&1+4#0+1/F:content_1/G:0_0/H:7=5@1=1|L-L%/I:0=0/J:7+5-1
g^ae-d+d=uw@3_1/A:0_0_0/B:1-1-3@1-1&1-7#1-5$1-3!0-1;0-1|ae/C:1+1+2/D:0_0/E:content+1@1+5&1+4#0+1/F:content_1/G:0_0/H:7=5@1=1|L-L%/I:0=0/J:7+5-1
..................后略..................
```

输出：

将对齐之后的标签输出到`<work_dir>/<lab_align_dir>`目录中。

```
$ cat label_state_align/arctic_b0001.lab

0 50000 x^x-sil+g=ae@x_x/A:0_0_0/B:x-x-x@x-x&x-x#x-x$x-x!x-x;x-x|x/C:1+1+3/D:0_0/E:x+x@x+x&x+x#x+x/F:content_1/G:0_0/H:x=x@1=1|0/I:7=5/J:7+5-1[2]
50000 100000 x^x-sil+g=ae@x_x/A:0_0_0/B:x-x-x@x-x&x-x#x-x$x-x!x-x;x-x|x/C:1+1+3/D:0_0/E:x+x@x+x&x+x#x+x/F:content_1/G:0_0/H:x=x@1=1|0/I:7=5/J:7+5-1[3]
100000 300000 x^x-sil+g=ae@x_x/A:0_0_0/B:x-x-x@x-x&x-x#x-x$x-x!x-x;x-x|x/C:1+1+3/D:0_0/E:x+x@x+x&x+x#x+x/F:content_1/G:0_0/H:x=x@1=1|0/I:7=5/J:7+5-1[4]
300000 1450000 x^x-sil+g=ae@x_x/A:0_0_0/B:x-x-x@x-x&x-x#x-x$x-x!x-x;x-x|x/C:1+1+3/D:0_0/E:x+x@x+x&x+x#x+x/F:content_1/G:0_0/H:x=x@1=1|0/I:7=5/J:7+5-1[5]
1450000 1750000 x^x-sil+g=ae@x_x/A:0_0_0/B:x-x-x@x-x&x-x#x-x$x-x!x-x;x-x|x/C:1+1+3/D:0_0/E:x+x@x+x&x+x#x+x/F:content_1/G:0_0/H:x=x@1=1|0/I:7=5/J:7+5-1[6]
1750000 1800000 x^sil-g+ae=d@1_3/A:0_0_0/B:1-1-3@1-1&1-7#1-5$1-3!0-1;0-1|ae/C:1+1+2/D:0_0/E:content+1@1+5&1+4#0+1/F:content_1/G:0_0/H:7=5@1=1|L-L%/I:0=0/J:7+5-1[2]
1800000 1850000 x^sil-g+ae=d@1_3/A:0_0_0/B:1-1-3@1-1&1-7#1-5$1-3!0-1;0-1|ae/C:1+1+2/D:0_0/E:content+1@1+5&1+4#0+1/F:content_1/G:0_0/H:7=5@1=1|L-L%/I:0=0/J:7+5-1[3]
..................后略..................
```

这两个文件完整内容可访问：[未对齐](https://cnbj1.fds.api.xiaomi.com/tts/ExternalLink/XiaoMi/TTS_labels/arctic_b0001.lab.no.txt)、[已对齐](https://cnbj1.fds.api.xiaomi.com/tts/ExternalLink/XiaoMi/TTS_labels/arctic_b0001.lab.txt)。对应英文文本为：`Gad, do I remember it.`

### 原理

上述对齐使用到了HTK提供的工具，包括：HCompV, HCopy, HERest, HHEd, HVite.

使用的先后顺序为：`HCopy -> HCompV -> HERest -> HHEd -> HVite`。下面我们先对这几个工具简单介绍。

| 工具   | 说明                                                         |
| ------ | ------------------------------------------------------------ |
| HCopy  | 参数化数据，即，提特征，将wav格式的语音文件转化为包含若干特征矢量的特征文件 |
| HCompV | 初始化模型参数                                               |
| HERest | 模型训练，参数估计                                           |
| HHEd   | 模型定义编辑器                                               |
| HVite  | 解码，维特比算法                                             |

对齐标签将用于后续训练时长模型和声学模型，详细下文介绍。



## Merlin源码详解

关于merlin的详细解读（强烈推荐），可参考candlewill的[github gist](https://gist.github.com/candlewill/5584911728260904414b4a6679a93d53)

## Merlin Source Code Analysis

本文简单分析Merlin的一些源码。用于更深入的学习Merlin。

### genScmFile.py

代码路径：https://github.com/CSTR-Edinburgh/merlin/blob/master/misc/scripts/frontend/utils/genScmFile.py

作用是对文本文件进行格式转换，转换成文本`标准格式`。`标准格式`由`3`类文件组成：utt文件，scheme文件，scp文件。utt为空文件夹，供后续操作；scheme文件为文本和后续产生的utt文件之间的对应关系；scp文件为文件列表（无后缀）。

#### 输入

```
 <in_txt_dir/in_txt_file>    为原始文本所在目录（每个文件以.txt结尾），或者原始文本
 <out_utt_dir>               之后utt产生的路径
 <out_scm_file>              生成的scm文件
 <out_file_id_list>          生成的scp文件
```

#### 输出

- 常见 <out_utt_dir>空文件夹
- 生成文件名称为 scm文件，内容如下所示：

```
(utt.save (utt.synth (Utterance Text "Hello world." )) "D:\Python_Programs\Merlin_Toolkit\egs_database\utt\test_001.utt")
(utt.save (utt.synth (Utterance Text "Hi, this is a demo voice from Merlin." )) "D:\Python_Programs\Merlin_Toolkit\egs_database\utt\test_002.utt")
(utt.save (utt.synth (Utterance Text "Hope you guys enjoy free open-source voices from Merlin." )) "D:\Python_Programs\Merlin_Toolkit\egs_database\utt\test_003.utt")
(utt.save (utt.synth (Utterance Text "I love you China." )) "D:\Python_Programs\Merlin_Toolkit\egs_database\utt\test_004.utt")
(utt.save (utt.synth (Utterance Text "Are you OK?" )) "D:\Python_Programs\Merlin_Toolkit\egs_database\utt\test_005.utt")
(utt.save (utt.synth (Utterance Text "I am comming from China." )) "D:\Python_Programs\Merlin_Toolkit\egs_database\utt\test_006.utt")
```

- 生成文件列表scp，如下所示：

```
test_001
test_002
test_003
test_004
test_005
test_006
```

<in_txt_dir/in_txt_file>不仅可以是文本路径，也可以是单个文件，其格式如下：

```
( arctic_a0001 "Author of the danger trail, Philip Steels, etc." )
( arctic_a0002 "Not at this particular case, Tom, apologized Whittemore." )
( arctic_a0003 "For the twentieth time that evening the two men shook hands." )
( arctic_a0004 "Lord, but I'm glad to see you again, Phil." )
```

### festival

```
festival -b <scheme_file>
```

**作用**：调用festival对文本进行批量处理。<scheme_file>为前一步所产生。(no interaction)

**结果**：生成utt文件。路径保存于<scheme_file>所指定的路径。

festival这一前端工具对文本进行了分析，例如：对文本`Hello world.`操作后的结果为：

```
EST_File utterance
DataType ascii
version 2
EST_Header_End
Features max_id 44 ; type Text ; iform "\"Hello world.\"" ; 
Stream_Items
1 id _1 ; name Hello ; whitespace "" ; prepunctuation "" ; 
2 id _2 ; name world ; punc . ; whitespace " " ; prepunctuation "" ; 
............此处省略n行............
End_of_Relation
Relation US_map ; ()
1 43 0 0 0 0
End_of_Relation
Relation Wave ; ()
1 44 0 0 0 0
End_of_Relation
End_of_Relations
End_of_Utterance
```

### make_labels

代码路径：https://github.com/CSTR-Edinburgh/merlin/blob/master/misc/scripts/frontend/festival_utt_to_lab/make_labels

#### 功能

从utt中提取单音素（monophone），以及full context labels

#### 用法

```
make_labels <labels_dir> <utts_dir> <dumpfeats> <scripts>

<labels_dir>      ## 新产生的标签所在的文件路径
<utts_dir>        ## utt文件所在路径
<dumpfeats>       ## 指向Festival的dumpfeats脚本，安装好festival后应该知道，常见为：{FESTDIR}/examples/dumpfeats
<scripts>         ## 下列脚本所在路径: extra_feats.scm label.feats label-full.awk  label-mono.awk 
```

#### 执行流程

- 在<labels_dir>文件夹中创建两个子目录，mono和full

- 对于<utts_dir>文件夹中的每个utt文件执行：

  1. 通过`basename $utt .utt`获得basename

  2. 调用dumpfeats提取特征：

     ```
     dumpfeats	-eval		$scripts/extra_feats.scm \
     		-relation 	Segment \
     		-feats    	$scripts/label.feats \
     		-output   	$labels/tmp \
     		$utt
     ```

  3. 分别写入mono和full文件夹：

     ```
     gawk -f $scripts/label-full.awk $labels/tmp > $labels/full/$base.lab; \
     gawk -f $scripts/label-mono.awk $labels/tmp > $labels/mono/$base.lab; \
     ```

- 清理临时产生的文件：`rm -f tmp`

#### 解释说明

- dumpfeats为festival提供的工具，用于从utt中提取特征，详细如下：

```
Usage: dumpfeats [options] <utt_file_0> <utt_file_1> ...
  
  Dump features from a set of utterances
  
  Options
  -relation  <string>
             Relation from which the features have to be dumped from
  -output    <string>
             If output parameter contains a %s its treated as a skeleton
             e.g feats/%s.feats and multiple files will be created one
             each utterance.  If output doesn't contain %s the output
             is treated as a single file and all features and dumped in it.
  -feats     <string>
             If argument starts with a "(" it is treated as a list of
             features to dump, otherwise it is treated as a filename whose
             contents contain a set of features (without parenetheses).
  -eval      <ifile>
             A scheme file to be loaded before dumping.  This may contain
             dump specific features etc.  If filename starts with a left
             parenthis it it evaluated as lisp.
  -from_file <ifile>
             A file with a list of utterance files names (used when there
             are a very large number of files.
```

- gawk为比sed更强大的文本操作命令。`-f`选项表示指定`program`文件：

```
-f file		 Specifies a filename to read the program from 
```

详细program可见`$scripts/label-full.awk`和`$scripts/label-mono.awk`。

#### 示例

我们以刚才通过文本`Hello world.`产生的utt为例，展示经过`make_labels`之后可以得到什么。

当前路径：/root/workspace/merlin_projects/step_by_step， 这个路径中所含文件结构如下：

```
root@de-3879-ng-2-123705-3173223045-0f7q9:~/workspace/merlin_projects/step_by_step# tree ./
|-- scm.scm
|-- test_001.utt
|-- test_002.utt
|-- test_003.utt
|-- test_004.utt
|-- test_005.utt
`-- test_006.utt
```

**dumpfeats**

```
dumpfeats=/root/workspace/Python_Programs/merlin/tools/festival/examples/dumpfeats
scripts=/root/workspace/Python_Programs/merlin/misc/scripts/frontend/festival_utt_to_lab
labels=.
utt=test_001.utt
$dumpfeats -eval $scripts/extra_feats.scm \
-relation Segment \
-feats $scripts/label.feats \
-output $labels/tmp \
$utt
```

执行完后，将产生一个`tmp`新文件，内容如下：

```
0 pau hh 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3 2 1 0 0 0 0 0 3 0 content 0 2 0 3 0 2 0 ax 0 0.22 
pau hh ax 0 0 0 1 0 0 1 0 3 1 0 0 2 0 2 0 2 0 1 0 1 ax 0 content content 0 2 1 0 2 0 1 0 1 0 3 0 0 2 0 0 L-L% 3 2 1 0 0 0 0 0 3 0 content 0 2 0 3 0 2 0 l 0.22 0.27795401 
hh ax l 1 0 0 1 0 0 1 0 3 1 0 0 2 0 2 0 2 0 1 0 1 ax 0 content content 0 2 1 0 2 0 1 0 1 0 3 0 0 2 0 0 L-L% 3 2 1 0 0 0 0 3 3 content content 2 2 3 3 2 2 pau ow 0.27795401 0.32017601 
ax l ow 2 0 0 1 0 0 1 0 3 1 0 0 2 0 2 0 2 0 1 0 1 ax 0 content content 0 2 1 0 2 0 1 0 1 0 3 0 0 2 0 0 L-L% 3 2 1 0 1 0 1 3 1 content content 2 2 3 3 2 2 hh w 0.32017601 0.39965901 
l ow w 0 0 1 1 0 1 1 3 1 4 1 1 1 0 1 0 1 0 1 0 1 ow 0 content content 0 2 1 0 2 0 1 0 1 0 3 0 0 2 0 0 L-L% 3 2 1 0 1 0 1 3 4 content content 2 1 3 3 2 2 ax er 0.39965901 0.55004603 
ow w er 0 1 1 0 1 1 0 1 4 0 0 2 0 1 0 1 0 1 0 1 0 er content content 0 2 1 0 1 1 1 0 1 0 0 3 0 0 2 0 0 L-L% 3 2 1 1 1 1 1 1 4 content content 2 1 3 3 2 2 l l 0.55004603 0.62555099 
w er l 1 1 1 0 1 1 0 1 4 0 0 2 0 1 0 1 0 1 0 1 0 er content content 0 2 1 0 1 1 1 0 1 0 0 3 0 0 2 0 0 L-L% 3 2 1 1 1 1 1 4 4 content content 1 1 3 3 2 2 ow d 0.62555099 0.72588098 
er l d 2 1 1 0 1 1 0 1 4 0 0 2 0 1 0 1 0 1 0 1 0 er content content 0 2 1 0 1 1 1 0 1 0 0 3 0 0 2 0 0 L-L% 3 2 1 1 1 1 1 4 4 content content 1 1 3 3 2 2 w pau 0.72588098 0.81338102 
l d pau 3 1 1 0 1 1 0 1 4 0 0 2 0 1 0 1 0 1 0 1 0 er content content 0 2 1 0 1 1 1 0 1 0 0 3 0 0 2 0 0 L-L% 3 2 1 1 0 1 0 4 0 content 0 1 0 3 0 2 0 er 0 0.81338102 0.88916397 
d pau 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3 2 1 1 0 1 0 4 0 content 0 1 0 3 0 2 0 l 0 0.88916397 1.33796 
```

**gawk**

```
mkdir full
mkdir mono
base=test_001
gawk -f $scripts/label-full.awk $labels/tmp > $labels/full/$base.lab; \
gawk -f $scripts/label-mono.awk $labels/tmp > $labels/mono/$base.lab;
```

执行完后文件夹结构

```
|-- full
|   `-- test_001.lab
|-- mono
|   `-- test_001.lab
|-- scm.scm
|-- test_001.utt
|-- test_002.utt
|-- test_003.utt
|-- test_004.utt
|-- test_005.utt
|-- test_006.utt
`-- tmp
```

full/test_001.lab文件内容：

```
         0    2200000 x^x-pau+hh=ax@x_x/A:0_0_0/B:x-x-x@x-x&x-x#x-x$x-x!x-x;x-x|x/C:0+0+3/D:0_0/E:x+x@x+x&x+x#x+x/F:content_2/G:0_0/H:x=x@1=1|0/I:3=2/J:3+2-1
   2200000    2779540 x^pau-hh+ax=l@1_3/A:0_0_0/B:0-0-3@1-2&1-3#1-3$1-3!0-1;0-1|ax/C:1+1+1/D:0_0/E:content+2@1+2&1+1#0+1/F:content_1/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
   2779540    3201760 pau^hh-ax+l=ow@2_2/A:0_0_0/B:0-0-3@1-2&1-3#1-3$1-3!0-1;0-1|ax/C:1+1+1/D:0_0/E:content+2@1+2&1+1#0+1/F:content_1/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
   3201760    3996590 hh^ax-l+ow=w@3_1/A:0_0_0/B:0-0-3@1-2&1-3#1-3$1-3!0-1;0-1|ax/C:1+1+1/D:0_0/E:content+2@1+2&1+1#0+1/F:content_1/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
   3996590    5500460 ax^l-ow+w=er@1_1/A:0_0_3/B:1-1-1@2-1&2-2#1-2$1-2!0-1;0-1|ow/C:1+1+4/D:0_0/E:content+2@1+2&1+1#0+1/F:content_1/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
   5500460    6255510 l^ow-w+er=l@1_4/A:1_1_1/B:1-1-4@1-1&3-1#2-1$2-1!1-0;1-0|er/C:0+0+0/D:content_2/E:content+1@2+1&2+0#1+0/F:0_0/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
   6255510    7258810 ow^w-er+l=d@2_3/A:1_1_1/B:1-1-4@1-1&3-1#2-1$2-1!1-0;1-0|er/C:0+0+0/D:content_2/E:content+1@2+1&2+0#1+0/F:0_0/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
   7258810    8133810 w^er-l+d=pau@3_2/A:1_1_1/B:1-1-4@1-1&3-1#2-1$2-1!1-0;1-0|er/C:0+0+0/D:content_2/E:content+1@2+1&2+0#1+0/F:0_0/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
   8133810    8891640 er^l-d+pau=x@4_1/A:1_1_1/B:1-1-4@1-1&3-1#2-1$2-1!1-0;1-0|er/C:0+0+0/D:content_2/E:content+1@2+1&2+0#1+0/F:0_0/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
   8891640   13379600 l^d-pau+x=x@x_x/A:1_1_4/B:x-x-x@x-x&x-x#x-x$x-x!x-x;x-x|x/C:0+0+0/D:content_1/E:x+x@x+x&x+x#x+x/F:0_0/G:3_2/H:x=x@1=1|0/I:0=0/J:3+2-1
```

mono/test_001.lab文件内容：

```
         0    2200000 pau
   2200000    2779540 hh
   2779540    3201760 ax
   3201760    3996590 l
   3996590    5500460 ow
   5500460    6255510 w
   6255510    7258810 er
   7258810    8133810 l
   8133810    8891640 d
   8891640   13379600 pau
```

### normalize_lab_for_merlin.py

路径：https://github.com/CSTR-Edinburgh/merlin/blob/master/misc/scripts/frontend/utils/normalize_lab_for_merlin.py

#### 功能

将上面步骤产生的mono和full lab进行归一化(normalization)，以供merlin使用。

依据https://github.com/CSTR-Edinburgh/merlin/issues/156 所言，这一代码主要做如下三件事：

1. Normalize duration to nearest divisible number by 5. Say 1.413 -> 1.415
2. Merge consecutive silence phones or pause phones to one.
3. Get rid of timestamps if required -- input format for HTK alignment

即：

1. 将duration向最近邻靠近
2. 对连续静音和暂停进行合并
3. 如果需要，去掉timestamps

#### 参数

```
Usage: python normalize_lab_for_merlin.py <input_lab_dir> <output_lab_dir> <label_style> <file_id_list_scp> <optional: write_time_stamps (1/0)>

<input_lab_dir>                          full标签所在路径
<output_lab_dir>                         归一化后标签保存路径
<label_style>                            使用何种对齐方式，支持phone_align, state_align
<file_id_list_scp>                       标签文件列表所在路径
<optional: write_time_stamps (1/0)>      是否写time stamps （可以省略，默认为1）
```

注意：上述过程暂时没有使用到mono label信息。
**注意**：对于训练数据需要指定`label_style>=phone_align`并且置`write_time_stamps>=0`对于测试数据，无此要求（推荐：`label_style>=stete_align, <write_time_stamps>=1`。

#### 结果

归一化的结果保存在<output_lab_dir>，文件名称和原文件相同。内容如下：

```
0 2200000 x^x-sil+hh=ax@x_x/A:0_0_0/B:x-x-x@x-x&x-x#x-x$x-x!x-x;x-x|x/C:0+0+3/D:0_0/E:x+x@x+x&x+x#x+x/F:content_2/G:0_0/H:x=x@1=1|0/I:3=2/J:3+2-1
2200000 2800000 x^sil-hh+ax=l@1_3/A:0_0_0/B:0-0-3@1-2&1-3#1-3$1-3!0-1;0-1|ax/C:1+1+1/D:0_0/E:content+2@1+2&1+1#0+1/F:content_1/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
2800000 3200000 sil^hh-ax+l=ow@2_2/A:0_0_0/B:0-0-3@1-2&1-3#1-3$1-3!0-1;0-1|ax/C:1+1+1/D:0_0/E:content+2@1+2&1+1#0+1/F:content_1/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
3200000 4000000 hh^ax-l+ow=w@3_1/A:0_0_0/B:0-0-3@1-2&1-3#1-3$1-3!0-1;0-1|ax/C:1+1+1/D:0_0/E:content+2@1+2&1+1#0+1/F:content_1/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
4000000 5500000 ax^l-ow+w=er@1_1/A:0_0_3/B:1-1-1@2-1&2-2#1-2$1-2!0-1;0-1|ow/C:1+1+4/D:0_0/E:content+2@1+2&1+1#0+1/F:content_1/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
5500000 6250000 l^ow-w+er=l@1_4/A:1_1_1/B:1-1-4@1-1&3-1#2-1$2-1!1-0;1-0|er/C:0+0+0/D:content_2/E:content+1@2+1&2+0#1+0/F:0_0/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
6250000 7250000 ow^w-er+l=d@2_3/A:1_1_1/B:1-1-4@1-1&3-1#2-1$2-1!1-0;1-0|er/C:0+0+0/D:content_2/E:content+1@2+1&2+0#1+0/F:0_0/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
7250000 8150000 w^er-l+d=sil@3_2/A:1_1_1/B:1-1-4@1-1&3-1#2-1$2-1!1-0;1-0|er/C:0+0+0/D:content_2/E:content+1@2+1&2+0#1+0/F:0_0/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
8150000 8900000 er^l-d+sil=x@4_1/A:1_1_1/B:1-1-4@1-1&3-1#2-1$2-1!1-0;1-0|er/C:0+0+0/D:content_2/E:content+1@2+1&2+0#1+0/F:0_0/G:0_0/H:3=2@1=1|L-L%/I:0=0/J:3+2-1
8900000 13400000 l^d-sil+x=x@x_x/A:1_1_4/B:x-x-x@x-x&x-x#x-x$x-x!x-x;x-x|x/C:0+0+0/D:content_1/E:x+x@x+x&x+x#x+x/F:0_0/G:3_2/H:x=x@1=1|0/I:0=0/J:3+2-1
```

归一化之后的标签将输入到`forced_alignment.py`，实现对齐。具体如何对齐，我们将在后文介绍。



## Merlin流程图

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/merlin-train-1.png)

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/merlin-duration.png)

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/merlin-acoustic.png)







## Install

```
% Assumptions: vctk is in ~/vctk/VCTK-Corpus.tar.gz
% htk is in ~/htk/HTK-3.4.1.tar.gz
% festival is in ~/festival/festival-2.4-release.tar.gz
% speech_tools is in ~/speech_tools/speech_tools-2.4-release.tar.gz
% sptk is in ~/sptk
% extrafiles from http://festvox.org/packed/festival/2.4/
% festlex_CMU.tar.gz
% festlex_POSTLEX.tar.gz
% festlex_OALD.tar.gz
% festvox_cmu_us_slt_cg.tar.gz
% in ~/fest_extras

% To get VCTK...
% To Festival and HTK
% Festival
% http://festvox.org/packed/festival/2.4/festival-2.4-release.tar.gz
% speech_tools
% http://www.cstr.ed.ac.uk/downloads/festival/2.4/speech_tools-2.4-release.tar.gz

% HTK
% http://htk.eng.cam.ac.uk/download.shtml
% Need a username and password
% mkdir ~/htk
% mkdir ~/festival
% mkdir ~/speech_tools
% mkdir ~/vctk

% FestVox
% http://festvox.org/festvox-2.7/festvox-2.7.0-release.tar.gz

cd ~/speech_tools
tar xzf speech_tools-2.4-release.tar.gz
% ~/speech_tools/speech_tools
cd speech_tools
./configure && make -j 4
% speech_tools are in ~/speech_tools/speech_tools/bin
cd ~/src/merlin/tools
ln -s ~/speech_tools/speech_tools .

cd ~/festival
ln -s ~/speech_tools/speech_tools .
tar xzf festival-2.4-release.tar.gz
cd festival
% multicore make -j 4 gives errors? wtf
./configure && make


cd ~/festvox
tar xzf festvox-2.7.0-release.tar.gz
cd festvox
ESTDIR=~/speech_tools/speech_tools ./configure && make
cd ~/src/merlin/tools
ln -s ~/festvox/festvox .

cd ~/htk
tar xzf HTK-3.4.1.tar.gz
cd htk
# How to pathch, see `INSTALL`
PATCH IT FROM http://hts.sp.nitech.ac.jp/?Download#k7c50de8
sudo apt-get install g++-multilib
./configure --disable-hlmtools --disable-hslab CFLAGS="-DARCH=linux" --prefix=/root/workspace/Programs/HTK &&
make
% files in ~/htk/htk/

cd ~/sptk
tar xzf SPTK-3.9.tar.gz
sudo apt-get install csh
cd SPTK-3.9
mkdir out && ./configure --prefix=`pwd`/out && make && make install

cd ~/fest_extras
tar xzf festlex_CMU.tar.gz
tar xzf festlex_OALD.tar.gz
tar xzf festlex_POSLEX.tar.gz
tar xzf festvox_cmu_us_slt_cg.tar.gz
cp -pr festival ~/festival/festival

cd ~/src/merlin/tools
ln -s ~/sptk/SPTK-3.9/out/bin SPTK-3.9

cd ~/vctk
tar xzf VCTK-Corpus.tar.gz

hts_engine_API-1.10
./configure && make

./configure --with-fest-search-path=/Tmp/kastner/speech_synthesis/festival/examples --with-sptk-search-path=/Tmp/kastner/speech_synthesis/SPTK-3.9/out/bin --with-hts-search-path=/Tmp/kastner/speech_synthesis/htk/HTKTools --with-hts-engine-search-path=/Tmp/kastner/speech_synthesis/hts_engine_API-1.10/bin

cp -pr ~/src/merlin/egs/build_your_own_voice/s1 ~/src/merlin/egs/build_your_own_voice/kks1
cd ~/src/merlin/egs/build_your_own_voice/kks1

ln -s ~/festival/festival ~/src/merlin/tools/festival
ln -s ~/htk/htk ~/src/merlin/tools/htk

bash ./01_setup.sh my_vctk_example

% alignment_script=~/src/merlin/misc/scripts/alignment/state_align/run_aligner.sh

cd ~/src/merlin/egs/build_your_own_voice/kks1/database
ln -s ~/vctk/VCTK-Corpus/txt .
ln -s ~/vctk/VCTK-Corpus/wav48 wav

cd ~/src/merlin/tools
bash compile_tools.sh
cd ~/src/merlin/egs/slt_arctic/s1
bash run_full_voice.sh

sudo apt-get install gawk

cd ~/src/merlin/misc/scripts/vocoder/world/
sed -e 's|merlin_dir=.*|merlin_dir="$HOME/src/merlin"|g' extract_features_for_merlin.sh > extract_features_edit.sh
bash extract_features_edit.sh

cd ~/src/merlin/misc/scripts/alignment/state_align/
mkdir ~/src/merlin/misc/scripts/alignment/state_align/prompt-lab/tmp
bash ./setup.sh

# convert symlinks to hardlinks

cd ~/src/merlin/tools
# Brutal... http://superuser.com/questions/560597/convert-symlinks-to-hard-links
find -type l -exec bash -c 'fi="$(readlink -m "$0")" && rm "$0" && cp -pfr $fi "$0"' {} \;

cd ~/src/merlin/misc/scripts/alignment/phone_align
echo 'export ESTDIR="~/src/merlin/tools/speech_tools"' > source.sh
echo 'export FESTDIR="~/src/merlin/tools/festival"' >> source.sh
echo 'export FESTVOXDIR="~/src/merlin/tools/festvox"' >> source.sh

bash setup.sh
source source.sh && bash ./run_aligner.sh config.cfg

cd ~/src/merlin/misc/scripts/alignment/state_align
echo 'export ESTDIR="~/src/merlin/tools/speech_tools"' > source.sh
echo 'export FESTDIR="~/src/merlin/tools/festival"' >> source.sh
echo 'export FESTVOXDIR="~/src/merlin/tools/festvox"' >> source.sh
echo 'export HTKDIR="~/src/merlin/tools/htk/HTKTools"'> source.sh

bash setup.sh
sed -i -e 's|HTKDIR=.*|HTKDIR='"$HOME"'/kkastner/src/merlin/tools/htk/HTKTools|g' config.cfg
source source.sh && bash run_sligner.sh config.cfg
```



## Reference

* https://github.com/Jackiexiao/MTTS
* **[MTTS Merlin/Mandarin Text-to-Speech Document](https://mtts.readthedocs.io/zh_CN/latest/)**
* **[TTS Voices](http://www.cs.columbia.edu/~ecooper/tts/)**
* https://mtts.readthedocs.io/_/downloads/zh_CN/latest/pdf/
* https://www.pure.ed.ac.uk/ws/files/28201681/master_2.pdf
* [Sub-Phonetic Modeling for Capturing Pronunciation Variations for Conversational Synthetic Speech (Prahallad et al. 2006)](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwinhfyQ-tPSAhUY9GMKHXbnCmYQFggcMAA&url=https%3A%2F%2Fwww.cs.cmu.edu%2F~awb%2Fpapers%2FICASSP2006%2F0100853.pdf&usg=AFQjCNEwSZEb8GLl1jhJxwkpajpXPSchgQ&sig2=XPFrUsRS223EnEQOWWzQsw).
* https://www.nguyenquyhy.com/2014/01/how-to-create-full-context-labels-for-your-hts-system-update-not-really-worked/
* https://www.nguyenquyhy.com/2014/07/create-full-context-labels-for-hts/
* [Creating English gen .lab Files for Synthesis](http://www.cs.columbia.edu/~ecooper/tts/gen_eng.html)
* [Creating Label Files for Training Data](http://www.cs.columbia.edu/~ecooper/tts/labels.html)
* **[Create_your_own_label_Using_Festival.md](https://gist.github.com/candlewill/e0e3bce9139de0a058d655ae90807191)**
* **[extract_features_for_merlin.md](https://gist.github.com/candlewill/5584911728260904414b4a6679a93d53)**
* [Carnegie Mellon University](http://www.speech.cs.cmu.edu/)
* **[mTTS_frontend_.gitignore](https://gist.github.com/feelins/df4beb3726a9a839ac1af5473a3e21e0)**

