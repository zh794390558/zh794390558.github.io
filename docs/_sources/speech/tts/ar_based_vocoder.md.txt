# AR based Vocoder

One family relies on knowledge disillusion, including Parallel WaveNet and Clarinet . Under this framework, the knowledge of an AR teacher model is trans- ferred to a small student model based on the inverse auto- regressive flows (IAF) . Although the IAF students can synthesize high-quality speech with a reasonable fast speed, this approach requires not only a well-trained teacher model but also some strategies to optimize the complex density distillation process. The student is trained using a probability distillation objective, along with additional perceptual loss terms. In the meanwhile, such models rely on GPU inference in order to achieve a low real-time factor (RTF)* because of the huge amount of model parameters.

AR models have been recently modified to speed up their inference. Two approaches are very competitive, both of which are variants of WaveRNN . In [6], a multi-band WaveRNN was proposed with over 2x speed-up in inference. A full-band audio was divided into four subbands, and by pre- dicting the four subbands at the same time using the same network, the parameters of WaveRNN were significantly re- duced. In [4, 5], the original WaveRNN structure was simpli- fied by introducing linear prediction (LP), resulting in LPC- Net. Combining LP with RNNs can significantly improve the efficiency of speech synthesis.

## AR Vocoder

1. WaveRNN
2. MB-WaveRNN
3. LPC-Net

## Reference

0. baseline

* WaveNet: A Generative Model for Raw Audio

1. knowledge disillusion, inverse auto-regressive flows (IAF)

* Parallel WaveNet: Fast High-Fidelity Speech Synthesis
* ClariNet: Parallel Wave Generation in End-to-End Text-to- Speech

2. rnn to speed up inference

* WaveRNN, Efficient Neural Audio Synthesis

* Multi-band WaveRNN, DurIAN: Duration In- formed Attention Network For Multimodal Synthesis

* LPCNet:  Improving Neural Speech Synthesis Through Linear Prediction
