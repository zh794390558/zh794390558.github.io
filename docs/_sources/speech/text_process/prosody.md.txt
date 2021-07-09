# Prosody

Prosody refers to the rhythm, stress and intonation of speech, including variations in duration, loudness and pitch.

In Chinese speech synthesis systems, typical prosody bound- ary labels consist of prosodic word (PW), prosodic phrase (PPH) and intonational phrase (IPH), which construct a three- layer prosody structure tree [Jingwei Sun,Chinese prosody structure prediction based on conditional random field].The leaf nodes of tree structure are lexical words that can be derived from a lexical-based word segmentation module.Whether the prosody labels are properly predicted will directly affect the naturalness and intelligibility of the synthesized speech.

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/prosody-sctructure-tree.png)

## Repos

* https://github.com/BoragoCode/AttentionBasedProsodyPrediction
* https://github.com/Riroaki/Chinese-Rhythm-Predictor
* https://github.com/Zeqiang-Lai/Prosody_Prediction

## Decision Tree & CRF

Some syntactic cues like part-of-speech (POS), syllable identity, syllable stress and their contextual counterparts are commonly used for prosody boundary prediction [3,4,5].

A CRF-based prosodic boundary prediction approach was used as baseline and boundary prediction (B, NB and O) was **operated at word level**. Atomic features in the CRF approach include **word identity, POS tags, the length of word and the predicted tag from the previous boundary level.** A linear statistical model was applied to optimize the feature templates. Parameters grid search was adopted to achieve the best perfor- mance of the CRF model. The CRF++ toolkit2 was used for the CRF-based prosodic boundary prediction.

1. Input Text

   ```
   那些庄稼田园在果果眼里感觉太亲切了！
   ```

2. Tokenize and POS

   ```
   Tokens: 那些 庄稼 田园 在 果果 眼里 感觉 太 亲切 了 ！
   POS: r n nr p n s n d a ul x
   Tags: #1 #1 #2 #1 #1 #2 #1 #0 #0 #4 #0
   ```

3. Extracting features

   feature colums:

   ```
   num_left, num_right, size_left, size_right, len_left, len_right, pos_left_2, pos_left, pos_right, pos_right_2, tone_left, tone_right
   ```

   ```
   token_len=num tokens exclude punctation
   cur_index=current token index, cur_index is belong to left part
   # Numeric features
   num_left=num tokens less equal than `cur_index`
   num_right=num tokens greater than `cur_index`
   size_left=num charactors in cur token in `cur_index`
   size_righ=num charactors in cur token in `cur_index+1`
   len_left=num charactors of tokens less equal than `cur_index`
   len_right=num charactors of tokens greater than `cur_index`
   # Categorical features
   ## Pos Info
   pos_left_2 = pos of `cur_index - 1` if cur_index > 0 else 'BEG'
   pos_right_2 = pos of `cur_index + 2] if index < num_cut -1 else 'END'
   pos_left = pos of `cur_index`
   pos_right = pos of `cur_index + 1`
   ## Pinyin Info
   tone_left=tone of last charactor of `cur_index` token
   tone_right=tone of first charactor of `cur_index + 1` token
   ```

4. 特征编码

   数值型保持不变，类别型做onthot编码。

5. 单个词训练

   输入单个词的特征，输出词的韵律标记（#0，#1，#2，#3，#4）

   模型使用随机森林：RandomForestClassifier

   **X** **{array-like, sparse matrix} of shape (n_samples, n_features)**

   **y ** **array-like of shape (n_samples,) or (n_samples, n_outputs)**

   **p** **ndarray of shape (n_samples, n_classes), or a list of n_outputs**

6. 词序列训练

   输入词序列特征，输出词序列韵律标记

   模型使用随机森林：RandomForestClassifier

   先训练好基于词的RandomForestClassifier，之后再用CRF在词序列 RandomForestClassifier.predict_proba的结果score作为emit score上做finetune。

7. 解码

   词序列提取特征并编码，RandomForestClassifier结算proba scores。使用CRF时，使用 Viterbi 解码；否则，使用greedy search取每个词的最大概率class。

## BLSTM Prosody Prediction

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/blstm-prosody.png)

To model the tag dependency and infer the tag sequence glob- ally, given a set of tags G = {B,NB, O}, a transition score

![img](/Users/zhanghui41/workspace/zh794390558.github.io/src/_static/crf-loss.png)

Totally **48210** sentences randomly selected from People’s Daily were used in our experiments. Prosodic boundaries (PW, PPH and IPH) were labelled by professional annotators with corresponding speech and labeling consistency is en- sured. Word segmentation and POS tagging were carried out by a front-end preprocessing tool. The accuracy of word seg- mentation is 97% and the accuracy of POS tagging is 96%. The corpus was partitioned into three parts: a training set with **43390** utterances, a validation set with 2410 utterances for pa- rameter tuning and a testing set with another 2410 utterances. A character dictionary D of size 4030 was extracted from the training set. A large set of raw texts was also collected from People’s Daily for unsupervised embedding feature learning. All texts were preprocessed with text normalization.

In the experiments, PW, PPH and IPH were predicted separately. That is to say, three separate neural network models were trained independently for PW, PPH and IPH. Each character in a sentence was assigned to one of the following three boundary tags: **B for a prosodic boundary, NB for a non-boundary, and O for other symbols such as punctuation.** Precision (P), recall (R) and F-score (F) were calculated as standard objective evaluation criteria.

# Blogs

* https://prosodylab.cs.mcgill.ca/lab/
* AUTOMATIC PROSODY PREDICTION FOR CHINESE SPEECH SYNTHESIS USING BLSTM-RNN AND EMBEDDING FEATURES
