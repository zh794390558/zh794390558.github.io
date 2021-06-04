# Flow based Vocoder

The other family is flow-based models [10, 11, 12], including WaveG- low [13] and FloWaveNet [14]. They use a single network with the likelihood loss function only for training. As their inference process is parallel, the RTF is obviously lower as compared with the AR models. But it requires a week of training on eight GPUs to achieve good quality for a single speaker model [13]. While inference is fast on GPU, the large size of the model makes it impractical for applications with a constrained memory usage.

