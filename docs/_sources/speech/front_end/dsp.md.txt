# Speech Processing

* **https://wiki.aalto.fi/display/ITSP/Introduction+to+Speech+Processing**
* [nnAudio : An on-the-fly GPU Audio to Spectrogram Conversion Toolbox Using 1D Convolutional Neural Networks](https://arxiv.org/abs/1912.12055)

# [Basic representations and models](https://wiki.aalto.fi/display/ITSP/Basic+representations+and+models)

### 1. [Waveform](https://wiki.aalto.fi/display/ITSP/Waveform)

### 2. Pitch

https://en.wikipedia.org/wiki/Pitch_(music)

### 3. Loudness

https://en.wikipedia.org/wiki/Loudness

### 4. [Fundamental frequency (F0)](https://wiki.aalto.fi/pages/viewpage.action?pageId=149890776)

The fundamental frequency of a speech signal, often denoted by F0 or F0, refers to the approximate frequency of the (quasi-)periodic structure of voiced speech signals. The oscillation originates from the vocal folds, which oscillate in the airflow when appropriately tensed. The fundamental frequency is defined as the average number of oscillations per second and expressed in Hertz. Since the oscillation originates from an organic structure, it is not exactly periodic but contains significant fluctuations. In particular, amount of variation in period length and amplitude are known respectively as *jitter* and *shimmer*. Moreover, the F0 is typically not stationary, but changes constantly within a sentence. In fact, the F0 can be used for expressive purposes to signify, for example, emphasis and questions.

Typically fundamental frequencies lie roughly in the range *80* to *450 Hz*, where males have lower voices than females and children. The F0 of an individual speaker depends primarily on the length of the vocal folds, which is in turn correlated with overall body size. Cultural and stylistic aspects of speech naturally have also a large impact.

**The fundamental frequency is closely related to *pitch*, which is defined as our perception of fundamental frequency. That is, the F0 describes the actual physical phenomenon, whereas pitch describes how our ears and brains interpret the signal, in terms of periodicity.** For example, a voice signal could have an F0 of 100 Hz. If we then apply a high-pass filter to remove all signal components below 450 Hz, then that would remove the actual fundamental frequency. The lowest remaining periodic component would be 500 Hz, which correspond to the fifth harmonic of the original F0. However, a human listener would then typically still perceive a pitch of 100 Hz, even if it does not exist anymore. The brain somehow reconstructs the fundamental from the upper harmonics. This well-known phenomenon is however still not completely understood.

* https://wiki.aalto.fi/pages/viewpage.action?pageId=149890776
* https://en.wikipedia.org/wiki/Fundamental_frequency.

### 5. [Signal energy, loudness and decibel](https://wiki.aalto.fi/display/ITSP/Signal+energy%2C+loudness+and+decibel)

In practically all uses of acoustic data, we need to normalize the sounds such that they have approximately the same volume or at least a known volume. For example, consider a television program and advertisements. Most would feel that it is very annoying if the advertisements are much louder than the main program (see also [loudness wars](https://en.wikipedia.org/wiki/Loudness_war)). We thus need to normalize the advertisement to match volume of the main program. Normalizing the average energy of the advertisement to match that of the main program is one crude way of doing that. Observe however that perception of energy is different across frequency ranges such that energy and the perceived loudness are not the same thing. To measure loudness we therefore need to model subjective perception. This is an involved subject and not discussed further here. Practical applications however still need some normalization to avoid fundamental problems such as clipping.

The energy measures decibel to overload, *dBov* and decibel to full-scale, *dBFS,* are related to the dynamic range of a signal storage or transmission format. Suppose for example that the maximum amplitude that a digital representation in which a signal is represented is *xov*. If we would try to represent a larger amplitude than that, then the signal would be clipped (distorted). dBov is a measure of how much below the maximum amplitude (how much below clipping) a signal is. Suppose *P0* is the energy of the maximum-amplitude square wave. Then the dBov of a signal with energy *P* is defined as

*L*ov=10log10(*P**P*0).

Since the energy of a sinusoid with maximum amplitude is 12‾‾√ of the maximum-amplitude square wave, then its dBov is -3.01. Observe that dBov values are always negative. dBFS is a similar

In typical cases, input speech signals are normalized to -26 dBov such that moderate processing of the signal is unlikely to cause clipping.

### 6. Window Function

https://en.wikipedia.org/wiki/Window_function

### 7. [Pre-emphasis](https://wiki.aalto.fi/display/ITSP/Pre-emphasis)

A common pre-processing tool used to compensate for the average spectral shape is *pre-emphasis*, which emphasises higher frequencies.

### 8. Mel Scale

https://en.wikipedia.org/wiki/Mel_scale

### 9. DFT

* http://practicalcryptography.com/miscellaneous/machine-learning/intuitive-guide-discrete-fourier-transform/

### 10. [Cepstrum and MFCC](https://wiki.aalto.fi/display/ITSP/Cepstrum+and+MFCC)

* http://www.practicalcryptography.com/miscellaneous/machine-learning/guide-mel-frequency-cepstral-coefficients-mfccs/
* https://en.wikipedia.org/wiki/Mel-frequency_cepstrum

### 11. DCT

* https://en.wikipedia.org/wiki/Discrete_cosine_transform#DCT-II

* https://pytorch.org/audio/stable/_modules/torchaudio/functional/functional.html#create_dct

  ```python
  def create_dct(
          n_mfcc: int,
          n_mels: int,
          norm: Optional[str]
  ) -> Tensor:
      r"""Create a DCT transformation matrix with shape (``n_mels``, ``n_mfcc``),
      normalized depending on norm.

      Args:
          n_mfcc (int): Number of mfc coefficients to retain
          n_mels (int): Number of mel filterbanks
          norm (str or None): Norm to use (either 'ortho' or None)

      Returns:
          Tensor: The transformation matrix, to be right-multiplied to
          row-wise data of size (``n_mels``, ``n_mfcc``).
      """
      # http://en.wikipedia.org/wiki/Discrete_cosine_transform#DCT-II
      n = torch.arange(float(n_mels))
      k = torch.arange(float(n_mfcc)).unsqueeze(1)
      dct = torch.cos(math.pi / float(n_mels) * (n + 0.5) * k)  # size (n_mfcc, n_mels)
      if norm is None:
          dct *= 2.0
      else:
          assert norm == "ortho"
          dct[0] *= 1.0 / math.sqrt(2.0)
          dct *= math.sqrt(2.0 / float(n_mels))
      return dct.t()
  ```

### 12. Cepstrum and LPCCs

* http://practicalcryptography.com/miscellaneous/machine-learning/tutorial-cepstrum-and-lpccs/



## Neural Network-based Audio processing

### nnAudio

* https://github.com/KinWaiCheuk/nnAudio
* https://arxiv.org/abs/1912.12055
* https://kinwaicheuk.github.io/nnAudio/index.html

## Torch FFT

* https://github.com/locuslab/pytorch_fft
