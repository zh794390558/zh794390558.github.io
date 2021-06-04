# CRF([Conditional Random Fields](http://blog.echen.me/2012/01/03/introduction-to-conditional-random-fields/))

 *CRFs is a generalization of any undirected graph structure, such as sequences, trees, or a weird graph. In this post I’ll focus on sequences structures by conditioning only on previous transitions, which is known as Linear Chain CRF. For the rest of this post I’ll use the acronym CRF intermittently between a general CRF and its linear chain structure.*

* http://www.cs.columbia.edu/~mcollins/
* [Language Modeling](http://www.cs.columbia.edu/~mcollins/lm-spring2013.pdf)
* [Tagging Problems, and Hidden Markov Models](http://www.cs.columbia.edu/~mcollins/hmms-spring2013.pdf)
* **[log-Linear Modles, MEMMs, and CRFs](http://www.cs.columbia.edu/~mcollins/crf.pdf)**
* [The Forward-Backward Algorithm](http://www.cs.columbia.edu/~mcollins/fb.pdf)
* [The EM Algorithm](http://www.cs.columbia.edu/~mcollins/em.pdf)

## Repos

* **https://github.com/mtreviso/linear-chain-crf**

  这个仓库的看代码清晰，而且有blog介绍。

* https://github.com/kmkurn/pytorch-crf

* https://github.com/allenai/allennlp

  viterbi 解码时可以对 transition矩阵中不可达的跳转做约束，来提升解码准确率。

## Reference

* [Overview of Conditional Random Fields](https://medium.com/ml2vec/overview-of-conditional-random-fields-68a2a20fa541)
* [Introduction to Conditional Random Fields](http://blog.echen.me/2012/01/03/introduction-to-conditional-random-fields/)
* [Viterbi algorithm](https://en.wikipedia.org/wiki/Viterbi_algorithm)
* [Conditional Random Field Tutorial in PyTorch](https://towardsdatascience.com/conditional-random-field-tutorial-in-pytorch-ca0d04499463)
* **[Implementing a linear-chain Conditional Random Field (CRF) in PyTorch](https://towardsdatascience.com/implementing-a-linear-chain-conditional-random-field-crf-in-pytorch-16b0b9c4b4ea)**

* https://homepages.inf.ed.ac.uk/csutton/publications/crftutv2.pdf

