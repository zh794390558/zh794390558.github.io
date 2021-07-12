# Merlin

Merlin 的简要介绍 Merlin 不是一个完整的 TTS 系统，它只是提供了 TTS 核心的声学建模模块（声学和语 音特征归一化，神经网络声学模型训练和生成).

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

## 生成Merlin的英文label用于语音合成

注意到merlin是没有自带frontend的，对于英文，你需要安装Festival来将文本转换成HTS label, 对于其他语言，你需要自行设计或者找到支持的frontend，中文目前网络上还没有开源的工具，所以你需要自己设计

英文FrontEnd安装 具体步骤如下参见：[Create_your_own_label_Using_Festival.md](https://github.com/Jackiexiao/MTTS/blob/master/docs/mddocs/Create_your_own_label_Using_Festival.md)

安装完毕之后，参考merlin/tools/alignment 里面的文档生成自己的英文label

## Merlin源码详解

关于merlin的详细解读（强烈推荐），可参考candlewill的[github gist](https://gist.github.com/candlewill/5584911728260904414b4a6679a93d53)

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
