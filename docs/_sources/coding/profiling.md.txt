#  profiling

## Tools

* [pprof](https://github.com/google/pprof)  pprof is a tool for visualization and analysis of profiling data.
* [time.perf_counter() function in Python](https://www.geeksforgeeks.org/time-perf_counter-function-in-python/)
* [PyProf - PyTorch Profiling tool](https://github.com/NVIDIA/PyProf)

* [Nsight Systems](https://docs.nvidia.com/nsight-systems/#nsight-systems)

  Cuda10.0 后的GPU Porfiler工具

  * https://www.adityaagrawal.net/blog/dnn/dcgan

## Deep Learning Framework Profiling

1. 如何测试框架本身的耗时

   **（小模型+CPU）**这种场景下，只做加法计算，100W次后看平均时间，就能测试框架的耗时。因为计算小，剩余开销都是框架调度的。在这种极端的、计算量很小的、单纯对比框架本身执行效率。在（**大模型+GPU）**的场景上很难看出框架的开销。
