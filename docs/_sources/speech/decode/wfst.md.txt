# wfst

### Papers

* [Speech Recognition Algorithms Using Weighted Finite-State Transducers]()
* [SPEECH RECOGNITIONWITHWEIGHTED FINITE-STATE TRANSDUCERS]()
* [Weighted Finite-State Transducers in Speech Recognition](http://www.openfst.org/twiki/pub/FST/FstBackground/csl01.pdf)
* [SLT 2010 Tutorial](http://www.openfst.org/twiki/bin/view/FST/FstSltTutorial)
* [OpenFst Tutorial](http://www.openfst.org/twiki/bin/view/FST/FstHltTutorial)

### Blogs

* https://robin1001.github.io/2019/07/23/fst/
* https://zhuanlan.zhihu.com/p/210975288
* http://www5.informatik.uni-erlangen.de/Forschung/Publikationen/2016/Horndasch16-HTA-talk.pdf
* https://arxiv.org/pdf/1909.00556v1.pdf
* https://arxiv.org/pdf/1812.02142.pdf
* https://arxiv.org/pdf/1910.10670v1.pdf
* http://www.interspeech2020.org/uploadfile/pdf/Thu-2-8-3.pdf

### Tools

|                             |                                                           |
| --------------------------- | --------------------------------------------------------- |
| python wrapper              | https://github.com/jpuigcerver/openfst-python.git         |
| python wrapper              | https://github.com/beer-asr/pywrapfst                     |
| ASR TLG graph               | https://github.com/athena-team/athena-decoder.git         |
| Openfst                     | http://www.openfst.org/twiki/bin/view/FST/WebHome         |
| OpenFst Python extension    | http://www.openfst.org/twiki/bin/view/FST/PythonExtension |
| OpenFst Background Material | http://www.openfst.org/twiki/bin/view/FST/FstBackground   |
| OpenFst Extensions          | http://www.openfst.org/twiki/bin/view/FST/FstExtensions   |

## Install

```shell
openfst=openfst-1.8.1
test -e ${openfst}.tar.gz || wget http://www.openfst.org/twiki/pub/FST/FstDownload/${openfst}.tar.gz
test -d ${openfst} || tar -xvf ${openfst}.tar.gz && chown -R root:root ${openfst}

mkdir -p output
pushd ${openfst} && ./configure --enable-static --enable-compact-fsts  --enable-compress   --enable-const-fsts   --enable-far    --enable-linear-fsts   --enable-lookahead-fsts  --enable-mpdt  --enable-ngram-fsts   --enable-pdt    --enable-python   --enable-special  --enable-bin  --enable-grm --prefix ${PWD}/output && popd

pushd ${openfst} && make -j &&  make install && popd
cp output/pywrapfst.* $(python3 -c 'import sysconfig; print(sysconfig.get_paths()["purelib"])')
```

## # Demos

* https://ysk24ok.github.io/2020/11/23/passing_pywrapfst_objects_to_cpp_using_cython.html
