# OpenGrm Libraries

*OpenGrm* is a collection of open-source libraries for constructing, combining, applying and searching formal grammars and related representations including:

- [NGram Library](http://www.openfst.org/twiki/bin/view/GRM/NGramLibrary): makes and modifies n-gram language models encoded as weighted finite-state transducers (FSTs),

- [Thrax Grammar Compiler](http://www.openfst.org/twiki/bin/view/GRM/Thrax): compiles grammars expressed as regular expressions and context-dependent rewrite rules into weighted finite-state transducers.

- [Pynini Grammar Compiler](http://www.openfst.org/twiki/bin/view/GRM/Pynini): compiles Thrax-like grammars from within Python.

- [SFst Library](http://www.openfst.org/twiki/bin/view/GRM/SFstLibrary): operations to normalize, sample, combine, and approximate *stochastic* finite-state transducers.

- [Baum-Welch Library](http://www.openfst.org/twiki/bin/view/GRM/BaumWelch): performs Baum-Welch and Viterbi training on weighted transducers.

These libraries use the [OpenFst library](http://www.openfst.org/) for their underlying finite-state models.



## NGram

| OpenGrm NGram Library Quick Tour | http://www.openfst.org/twiki/bin/view/GRM/NGramQuickTour   |
| -------------------------------- | ---------------------------------------------------------- |
| NGram Model Format               | http://www.openfst.org/twiki/bin/view/GRM/NGramModelFormat |

### Available Operations

Click on operation name for additional information.

| [Operation](http://www.openfst.org/twiki/bin/view/GRM/NGramQuickTour?sortcol=0;table=1;up=0#sorted_table) | [Usage](http://www.openfst.org/twiki/bin/view/GRM/NGramQuickTour?sortcol=1;table=1;up=0#sorted_table) | [Description](http://www.openfst.org/twiki/bin/view/GRM/NGramQuickTour?sortcol=2;table=1;up=0#sorted_table) |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [NGramApply](http://www.openfst.org/twiki/bin/view/GRM/NGramApply) | ngramapply [--bo_arc_type] ngram.fst [in.far [out.far]]      | Intersect n-gram model with fst archive                      |
| [NGramCount](http://www.openfst.org/twiki/bin/view/GRM/NGramCount) | ngramcount [--order] [in.far [out.fst]]                      | count n-grams from fst archive                               |
|                                                              | NGramCounter(order);                                         | --- n-gram counter                                           |
| [NGramInfo](http://www.openfst.org/twiki/bin/view/GRM/NGramInfo) | ngraminfo [in.mod]                                           | print various information about an n-gram model              |
| [NGramMake](http://www.openfst.org/twiki/bin/view/GRM/NGramMake) | ngrammake [--method] [--backoff] [--bins] [--witten_bell_k] [--discount_D] [in.fst [out.fst]] | n-gram model smoothing and normalization                     |
|                                                              | NGramAbsolute(&CountFst);                                    | --- Absolute Discount smoothing                              |
|                                                              | NGramKatz(&CountFst);                                        | --- Katz smoothing                                           |
|                                                              | NGramKneserNey(&CountFst);                                   | --- Kneser Ney smoothing                                     |
|                                                              | NGramUnsmoothed(&CountFst);                                  | --- no smoothing                                             |
|                                                              | NGramWittenBell(&CountFst);                                  | --- Witten-Bell smoothing                                    |
| [NGramMarginal](http://www.openfst.org/twiki/bin/view/GRM/NGramMarginal) | ngrammarginalize [--iterations] [--max_bo_updates] [--output_each_iteration] [--steady_state_file] [in.mod [out.mod]] | impose marginalization constraints on input model            |
|                                                              | NGramMarginal(&M);                                           | --- n-gram marginalization constraint class                  |
| [NGramMerge](http://www.openfst.org/twiki/bin/view/GRM/NGramMerge) | ngrammerge [--alpha] [--beta] [--use_smoothing] [--normalize] in1.fst in2.fst [out.fst] | merge two count or model FSTs                                |
|                                                              | NGramMerge(&M1, &M2, alpha, beta);                           | --- n-gram merge class                                       |
| [NGramPerplexity](http://www.openfst.org/twiki/bin/view/GRM/NGramPerplexity) | ngramperplexity [--OOV_symbol] [--OOV_class_size] [--OOV_probability] ngram.fst [in.far [out.txt]] | calculate perplexity of input corpus from model              |
| [NGramPrint](http://www.openfst.org/twiki/bin/view/GRM/NGramPrint) | ngramprint [--ARPA] [--backoff] [--integers] [--negativelogs] [in.fst [out.txt]] | print n-gram model to text file                              |
| [NGramRandgen](http://www.openfst.org/twiki/bin/view/GRM/NGramRandGen) | ngramrandgen [--max_sents] [--max_length] [--seed] [in.mod [out.far]] | randomly sample sentences from an n-gram model               |
| [NGramRead](http://www.openfst.org/twiki/bin/view/GRM/NGramRead) | ngramread [--ARPA] [--epsilon_symbol] [--OOV_symbol] [in.txt [out.fst]] | read n-gram counts or model from file                        |
| [NGramShrink](http://www.openfst.org/twiki/bin/view/GRM/NGramShrink) | ngramshrink [--method=count,relative_entropy,seymore] [-count_pattern] [-theta] [in.mod [out.mod]] | n-gram model pruning                                         |
|                                                              | NGramCountPrune(&M, count_pattern);                          | --- count-based model pruning                                |
|                                                              | NGramRelativeEntropy(&M, theta);                             | --- relative-entropy-based model pruning                     |
|                                                              | NGramSeymoreShrink(&M, theta);                               | --- Seymore/Rosenfeld-based model pruning                    |
| [NGramSymbols](http://www.openfst.org/twiki/bin/view/GRM/NGramSymbols) | ngramsymbols [--epsilon_symbol] [--OOV_symbol] [in.txt [out.txt]] | create symbol table from corpus                              |

### Convenience Script

The shell script `ngramdisttrain.sh` is provided to run some common OpenGrm NGram pipelines of commands and to provide some rudimentary [distributed computation support](http://www.openfst.org/twiki/bin/view/GRM/NGramAdvancedUsage#DistributedComputation). For example:

```
$ ngramdisttrain.sh --itype=text_sents --otype=pruned_lm --ifile=in.txt --ofile=lm.fst --symbols=in.syms --order=5 --smooth_method=katz --shrink_method=relative_entropy --theta=.00015
```

will read a text corpus in the format accepted by `farcompilestrings` and output a backoff 5-gram LM pruned with a relative entropy threshold of .00015. See `ngramdisttrain.sh --help` for available options and values and see [here](http://www.openfst.org/twiki/bin/view/GRM/NGramAdvancedUsage#DistributedComputation) for a discussion of the distributed computation support.

### Distributed Computation

The C++ operations in OpenGrm offer extensive distributed computation support. N-gram counting can readily be parallelized by *sharding* the data and producing a [count FST](http://www.openfst.org/twiki/bin/view/GRM/NGramCount) *Md* for each data shard *d*. These can then be [count-merged](http://www.openfst.org/twiki/bin/view/GRM/NGramMerge) to produce a single count FST. Alternatively and with more parallelism, each *Md* can be further split by *context* *c*, which restricts each sub-model *Md,c* to a specific range of n-grams. The *Md,c* in the same context *c* can then be count-merged to produce one model *Mc* for each context. The *Mc* are constructed to be in proper [n-gram model format](http://www.openfst.org/twiki/bin/view/GRM/NGramModelFormat) and so can be processed in parallel by the estimation and pruning operations and then the pruned model components can be [model-merged](http://www.openfst.org/twiki/bin/view/GRM/NGramMerge) into a single model at the end of this pipeline.

We have implemented a complete distributed version of OpenGrm NGram in [C++ Flume![img](http://www.openfst.org/twiki/pub/TWiki/TWikiDocGraphics/external-link.gif)](http://dl.acm.org/citation.cfm?id=1806638), however this system is currently not released. Instead, we provide here some added functionality to our convenience script, [ngramdisttrain.sh](http://www.openfst.org/twiki/bin/view/GRM/NGramQuickTour#ConvenienceScript). While this does not perform parallel computation, it can construct a pruned model as described above using data and context sharding. This allows processing corpora that would otherwise exceed available memory provided adequate disk space (under `$TMPDIR`) and computation time are provided. The script also could serve as a starting point for a fully distributed implementation by parallelizing the calls internal to the script, which should linearly speed up the pipeline with the degree of parallelism. An implementation that didn't use the file system for all data sharing/transfer like `ngram.sh` would also help greatly.

Multiple data shards are supported by specifying multiple input files to `ngramdisttrain.sh` with `--ifile="in.txt[0-9]"`. Multiple contexts are supported by specifying a context file with `--contexts=context.txt`. The best way to create a context file with, say, ten contexts balanced in size is with:



```
ngramcontext --context=10 lm.fst context.txt
```

where `lm.fst` is a n-gram LM that was built on a sample of the corpus (e..g, small enough to build unshared). Note you must provide a context file (even if it only has one context) if you want to use data sharding. If you wish the shared context models to be merged when the pipeline finishes, you should provide the `--merge_contexts` flag, otherwise the component models will be returned.



## Pynini

*OpenGrm* *Pynini*, like [Thrax](http://www.openfst.org/twiki/bin/view/GRM/Thrax), compiles grammars expressed as strings, regular expressions, and context-dependent rewrite rules into weighted finite-state transducers. It uses the [OpenFst library](http://www.openfst.org/) and its [Python extension![img](http://www.openfst.org/twiki/pub/TWiki/TWikiDocGraphics/external-link.gif)](http://www.python.openfst.org/) to create, access and manipulate compiled grammars. Pynini is embedded in a [Python![img](http://www.openfst.org/twiki/pub/TWiki/TWikiDocGraphics/external-link.gif)](https://www.python.org/) module, allowing users to write Thrax-like grammars using Python's flexible syntax (including imperative programming constructs not available in Thrax) and powerful toolchain, including an [interactive development![img](http://www.openfst.org/twiki/pub/TWiki/TWikiDocGraphics/external-link.gif)](http://ipython.org/) ("REPL") environment.

| How to get superior text processing in Python with Pynini | https://www.oreilly.com/content/how-to-get-superior-text-processing-in-python-with-pynini/ |
| --------------------------------------------------------- | ------------------------------------------------------------ |
| paper                                                     | https://aclanthology.org/W16-2409.pdf                        |
|                                                           |                                                              |
|                                                           |                                                              |



## Baum-Welch

*OpenGrm* *Baum-Welch* is a C++ library (including associated binaries) which allows the user to estimate the parameters of a discrete hidden Markov model (HMM) using the Baum-Welch algorithm (a special case of the expectation maximization meta-algorithm). It uses [OpenFst library](http://www.openfst.org/) finite-state transducers (FSTs) and FST archives (FARs) as inputs and outputs

