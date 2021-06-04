# FFPMEG

## Command
s16le表示：s表示有符号，l表示小端。 可以用 s16be代替，表示s有符号b表示大端
44100代表采样率，注意保持一致，可以是16000／8000...

- 转MP3为wav

  ```
  ffmpeg -i input.mp3 -acodec pcm_s16le -ac 2 -ar 44100 output.wav
  ```

*  转m4a为wav

  ```
  ffmpeg -i input.m4a -acodec pcm_s16le -ac 2 -ar 44100 output.wavb
  ```

- wav与PCM的相互转换

  ```
  ffmpeg -iinput.wav -f s16le -ar 44100 -acodec pcm_s16le output.raw
  ```

- PCM转wav

  ```
  ffmpeg -f s16le -ar 44100 -ac 2 -acodec pcm_s16le -i input.raw output.wav
  ```


- 用ffplay播放PCM

  ```
  ffplay -f s16le -ar 44100 -ac 2 **.raw
  ```
