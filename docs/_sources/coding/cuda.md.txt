# CUDA

* [cuda线程束原语 __shfl_xor、__shfl、__shfl_up()、__shfl_down()](https://www.huaweicloud.com/articles/cf0f3711f2ae444bbf103cd6c89ada84.html)

  在CC3.0以上，支持了shuffle指令，允许thread直接读其他thread的寄存器值，只要两个thread在 同一个warp中，这种比通过shared Memory进行thread间的通讯效果更好，latency更低，同时也不消耗额外的内存资源来执行数据交换。

  这里介绍warp中的一个概念 lane，一个lane就是一个warp中的一个thread，每个lane在同一个warp中由lane索引唯一确定，因此其范围为[0,31]。在一个一维的block中，可以通过下面两个公式计算索引：

  ```
  laneID = threadIdx.x % 32
  warpID = threadIdx.x / 32
  ```

  例如，在同一个block中的thread1和thread33拥有相同的 lane索引1。

  * https://people.maths.ox.ac.uk/gilesm/cuda/lecs/lec4.pdf
  * https://people.maths.ox.ac.uk/gilesm/cuda/2019/lecture_04.pdf



## Books

* https://github.com/sallenkey-wei/cuda-handbook

