# TTS Train with HTS/Merlin

* http://simple4all.org/
* http://www.sp.nitech.ac.jp/~tokuda/tokuda_iscslp2006.pdf

## Tools

* **[HTS](http://hts.sp.nitech.ac.jp/)**

* [indicTTS](https://www.iitm.ac.in/donlab/tts/synthDocs.php)

  The documentation contains major steps for building a HTS voice (version 2.2), namely, Hybrid Segmentation for segmenting speech into accurate phonetic units, Pruning for improving the quality of segmentation, HTS voice building and HTS with STRAIGHT vocoder voice building steps. The TBT toolkit covers all steps required to build TTS from start to end. It also provides the synthesis framework. "HTS 2.3 Synthesis Using a Built Voice Model" details how to synthesize Indian language text using an already built HTS 2.3 voice model.

  [1. initial steps and hybird segmentation](https://www.iitm.ac.in/donlab/tts/downloads/synthesisDocs/1.Voice_building_initial_and_hybrid_segmentation.pdf)

  [2. pruning](https://www.iitm.ac.in/donlab/tts/downloads/synthesisDocs/2.Pruning.pdf)

  [3. STRAIGHT_voice_building](https://www.iitm.ac.in/donlab/tts/downloads/synthesisDocs/3.STRAIGHT_voice_building.pdf)

  [4. HTS_voice_building](https://www.iitm.ac.in/donlab/tts/downloads/synthesisDocs/4.HTS_voice_building.pdf)

  [5. supporting scripts](https://www.iitm.ac.in/donlab/tts/downloads/synthesisDocs/supporting_scripts.zip)

  [6. TBT](https://github.com/TTS-cdac-mumbai/TBT)

  [7. HTS2.3_synthesis_using_voiceModel](https://www.iitm.ac.in/donlab/tts/downloads/synthesisDocs/7.HTS2.3_synthesis_using_voiceModel.pdf)

* **[Ossian](https://github.com/CSTR-Edinburgh/Ossian) ** is a collection of Python code for building text-to-speech (TTS) systems, with an emphasis on easing research into building TTS systems with minimal expert supervision

  * https://gist.github.com/candlewill/8141bbe9d6c4c6224be8d3b4c07723eb

* [Preparing Data for Training an HTS Voice](http://www.cs.columbia.edu/~ecooper/tts/data.html)

* [Festival](https://github.com/festvox/festival)  Speech Synthesis System

* [Festvox](http://festvox.org/) This project is part of the work at [Carnegie Mellon University's speech group](http://www.speech.cs.cmu.edu/) aimed at advancing the state of Speech Synthesis.

  * **http://festvox.org/bsv/book1.html**

  * **http://festvox.org/bsv/bsv.pdf**

* [Carnegie Mellon University](http://www.speech.cs.cmu.edu/)

* [nnmnkwii](https://github.com/r9y9/nnmnkwii)  [nnmnkwii_gallery](https://github.com/r9y9/nnmnkwii_gallery)

### FrontEnd

* festival
* festvox
* hts
* htk

### Vocoder

* [WORLD](https://github.com/mmorise/World)
* SPTK
* MagPhase
* STRIGHT
