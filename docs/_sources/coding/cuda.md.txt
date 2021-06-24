# CUDA

## Docs

* [CUDA Toolkit Documentation v11.3.1](https://docs.nvidia.com/cuda/index.html)
* [Profiler User's Guide](https://docs.nvidia.com/cuda/profiler-users-guide/index.html#abstract)
* [CUDA C++ Programming Guide](https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html#abstract)
* [CUDA C++ Best Practices Guide](https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#abstract)

## Books

* https://github.com/sallenkey-wei/cuda-handbook
* [Programming on GPUs part1](https://www3.nd.edu/~zxu2/acms60212-40212/Lec-11-GPU.pdf)
* [Standard Introduction to CUDA C Programming](https://www.bu.edu/tech/files/2016/02/Introduction_to_CUDA_C.pptx)

## Blogs

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

* [An Even Easier Introduction to CUDA](https://developer.nvidia.com/blog/even-easier-introduction-cuda/)

  CUDA C++ provides keywords that let kernels get the indices of the running threads. Specifically, `threadIdx.x` contains the index of the current thread within its block, and `blockDim.x` contains the number of threads in the block.

  **Out of the Blocks**

  CUDA GPUs have many parallel processors grouped into Streaming Multiprocessors, or SMs. Each SM can run multiple concurrent thread blocks. As an example, a Tesla P100 GPU based on the [Pascal GPU Architecture](https://developer.nvidia.com/blog/parallelforall/inside-pascal/) has 56 SMs, each capable of supporting up to 2048 active threads. To take full advantage of all these threads, I should launch the kernel with multiple thread blocks.

  By now you may have guessed that the first parameter of the execution configuration specifies the number of thread blocks. Together, the blocks of parallel threads make up what is known as the *grid*. Since I have `N` elements to process, and 256 threads per block, I just need to calculate the number of blocks to get at least N threads. I simply divide `N` by the block size (being careful to round up in case `N` is not a multiple of `blockSize`).

  ```
  int blockSize = 256;
  int numBlocks = (N + blockSize - 1) / blockSize;
  add<<<numBlocks, blockSize>>>(N, x, y);
  ```

  ![blocks](https://developer-blogs.nvidia.com/wp-content/uploads/2017/01/cuda_indexing.png)

  I also need to update the kernel code to take into account the entire grid of thread blocks. CUDA provides `gridDim.x`, which contains the number of blocks in the grid, and `blockIdx.x`, which contains the index of the current thread block in the grid. Figure 1 illustrates the the approach to indexing into an array (one-dimensional) in CUDA using `blockDim.x`, `gridDim.x`, and `threadIdx.x`. The idea is that each thread gets its index by computing the offset to the beginning of its block (the block index times the block size: `blockIdx.x * blockDim.x`) and adding the thread’s index within the block (`threadIdx.x`). The code `blockIdx.x * blockDim.x + threadIdx.x` is idiomatic CUDA.

  ```
  __global__
  void add(int n, float *x, float *y)
  {
    int index = blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;
    for (int i = index; i < n; i += stride)
      y[i] = x[i] + y[i];
  }
  ```

  The updated kernel also sets `stride` to the total number of threads in the grid (`blockDim.x * gridDim.x`). This type of loop in a CUDA kernel is often called a [*grid-stride loop*](https://developer.nvidia.com/blog/parallelforall/cuda-pro-tip-write-flexible-kernels-grid-stride-loops/).

* [An Easy Introduction to CUDA C and C++](https://developer.nvidia.com/blog/easy-introduction-cuda-c-and-c/)

  The information between the triple chevrons is the *execution configuration*, which dictates how many device threads execute the kernel in parallel. In CUDA there is a hierarchy of threads in software which mimics how thread processors are grouped on the GPU. In the CUDA programming model we speak of launching a kernel with a *grid* of *thread blocks*. The first argument in the execution configuration specifies the number of thread blocks in the grid, and the second specifies the number of threads in a thread block.

  Thread blocks and grids can be made one-, two- or three-dimensional by passing dim3 (a simple struct defined by CUDA with `x`, `y`, and `z` members) values for these arguments, but for this simple example we only need one dimension so we pass integers instead.

  For cases where the number of elements in the arrays is not evenly divisible by the thread block size, the kernel code must check for out-of-bounds memory accesses.

  To issue a kernel to a non-default stream we specify the stream identifier as a fourth execution configuration parameter (the third execution configuration parameter allocates shared device memory, which we’ll talk about later; use 0 for now).

  ```c
  increment<<<1,N,0,stream1>>>(d_a)

  kernel<<<nthreadblocks_in_grid,nthreads_in_threadblock,device_shared_mem_per_thread_block_in_bytes,stream_id>>>(param0, param1, ..., paramN)
  ```

  As mentioned earlier, the kernel is executed by multiple threads in parallel. If we want each thread to process an element of the resultant array, then we need a means of distinguishing and identifying each thread. CUDA defines the variables `blockDim`, `blockIdx`, and `threadIdx`. These predefined variables are of type `dim3`, analogous to the execution configuration parameters in host code. The predefined variable `blockDim` contains the dimensions of each thread block as specified in the second execution configuration parameter for the kernel launch. The predefined variables `threadIdx` and `blockIdx` contain the index of the thread within its thread block and the thread block within the grid, respectively. The expression:

  ```
  int i = blockDim.x * blockIdx.x + threadIdx.x
  ```

  generates a global index that is used to access elements of the arrays. We didn’t use it in this example, but there is also `gridDim` which contains the dimensions of the grid as specified in the first execution configuration parameter to the launch.

  Before this index is used to access array elements, its value is checked against the number of elements, `n`, to ensure there are no out-of-bounds memory accesses. This check is required for cases where the number of elements in an array is not evenly divisible by the thread block size, and as a result the number of threads launched by the kernel is larger than the array size.

* [How to Implement Performance Metrics in CUDA C/C++](https://developer.nvidia.com/blog/how-implement-performance-metrics-cuda-cc/)

  ### Memory Bandwidth

  **Theoretical Bandwidth**

  Theoretical bandwidth can be calculated using hardware specifications available in the product literature. For example, the NVIDIA Tesla M2050 GPU uses DDR (double data rate) RAM with a memory clock rate of 1,546 MHz and a 384-bit wide memory interface. Using these data items, the peak theoretical memory bandwidth of the NVIDIA Tesla M2050 is 148 GB/sec, as computed in the following.

  ```
  *BW*_Theoretical = 1546 * 106 * (384/8) * 2 / 10^9 = 148 GB/s
  ```

  In this calculation, we convert the memory clock rate to Hz, multiply it by the interface width (divided by 8, to convert bits to bytes) and multiply by 2 due to the double data rate. Finally, we divide by 109 to convert the result to GB/s.

  **Effective Bandwidth**

  We calculate effective bandwidth by timing specific program activities and by knowing how our program accesses data. We use the following equation.

  ```
  *BW*_Effective = (R_B + W_B) / (t * 10^9)
  ```

  Here, *BW*Effective is the effective bandwidth in units of GB/s, *R*B is the number of bytes read per kernel, *W*B is the number of bytes written per kernel, and *t* is the elapsed time given in seconds.

  ### Computational Throughput

  A common measure of computational throughput is GFLOP/s, which stands for “Giga-FLoating-point OPerations per second”, where *Giga* is that prefix for 10^9.

  For our SAXPY computation, measuring effective throughput is simple: each SAXPY element does a multiply-add operation, which is typically measured as two FLOPs, so we have

  ```
  *GFLOP/s* Effective = 2*N / (t * 10^9)
  ```

  *N* is the number of elements in our SAXPY operation, and *t* is the elapsed time in seconds.

  Theoretical peak GFLOP/s can be gleaned from the product literature (but calculating it can be a bit tricky because it is very architecture-dependent). For example, the Tesla M2050 GPU has a theoretical peak single-precision floating point throughput of 1030 GFLOP/s, and a theoretical peak double-precision throughput of 515 GFLOP/s.

  SAXPY reads 12 bytes per element computed, but performs only a single multiply-add instruction (2 FLOPs), so it’s pretty clear that it will be bandwidth bound, and so in this case (in fact in many cases), bandwidth is the most important metric to measure and optimize. In more sophisticated computations, measuring performance at the level of FLOPs can be very difficult. Therefore it’s more common to use profiling tools to get an idea of whether computational throughput is a bottleneck. Applications often provide throughput metrics that are problem-specific (rather than architecture specific) and therefore more useful to the user. For example, “Billion Interactions per Second” for astronomical n-body problems, or “nanoseconds per day” for molecular dynamic simulations.

  A large percentage of kernels are memory bandwidth bound, so calculation of the effective bandwidth is a good first step in performance optimization.

* [How to Optimize Data Transfers in CUDA C/C++](https://developer.nvidia.com/blog/how-optimize-data-transfers-cuda-cc/)

* [How to Overlap Data Transfers in CUDA C/C++](https://developer.nvidia.com/blog/how-overlap-data-transfers-cuda-cc/)

* [How to Access Global Memory Efficiently in CUDA C/C++ Kernels](https://developer.nvidia.com/blog/how-access-global-memory-efficiently-cuda-c-kernels/)

  There are several kinds of memory on a CUDA device, each with different scope, lifetime, and caching behavior. So far in this series we have used *global memory*, which resides in device DRAM, for transfers between the host and device as well as for the data input to and output from kernels. The name *global* here refers to scope, as it can be accessed and modified from both the host and the device. Global memory can be declared in global (variable) scope using the `__device__` declaration specifier as in the first line of the following code snippet, or dynamically allocated using [`cudaMalloc()`](http://docs.nvidia.com/cuda/cuda-runtime-api/index.html#group__CUDART__MEMORY_1g16a37ee003fcd9374ac8e6a5d4dee29e) and assigned to a regular C pointer variable as in line 7. Global memory allocations can persist for the lifetime of the application. Depending on the [compute capability](https://developer.nvidia.com/blog/parallelforall/how-query-device-properties-and-handle-errors-cuda-cc/) of the device, global memory may or may not be cached on the chip.

  Before we go into global memory access performance, we need to refine our understanding of the CUDA execution model. We have discussed how [threads are grouped into thread blocks](https://developer.nvidia.com/blog/parallelforall/easy-introduction-cuda-c-and-c/), which are assigned to multiprocessors on the device. During execution there is a finer grouping of threads into *warps*. Multiprocessors on the GPU execute instructions for each **warp** in SIMD ([Single Instruction Multiple Data](http://en.wikipedia.org/wiki/SIMD)) fashion. The warp size (effectively the SIMD width) of all current CUDA-capable GPUs is 32 threads.

  **Global Memory Coalescing**

  Grouping of threads into warps is not only relevant to computation, but also to global memory accesses. The device *coalesces* global memory loads and stores issued by threads of a warp into as few transactions as possible to minimize DRAM bandwidth (on older hardware of compute capability less than 2.0, transactions are coalesced within half warps of 16 threads rather than whole warps).

  * Misaligned Data Accesses

    Arrays allocated in device memory are aligned to 256-byte memory segments by the CUDA driver. The device can access global memory via 32-, 64-, or 128-byte transactions that are aligned to their size.

    For the C870 or any other device with a compute capability of 1.0, any misaligned access by a half warp of threads (or aligned access where the threads of the half warp do not access memory in sequence) results in 16 separate 32-byte transactions

  * Strided Memory Access

    This should not be surprising: when concurrent threads simultaneously access memory addresses that are very far apart in physical memory, then there is no chance for the hardware to combine the accesses.

    When accessing multidimensional arrays it is often necessary for threads to index the higher dimensions of the array, so strided access is simply unavoidable. We can handle these cases by using a type of CUDA memory called *shared memory*. Shared memory is an on-chip memory shared by all threads in a thread block. One use of shared memory is to extract a 2D tile of a multidimensional array from global memory in a coalesced fashion into shared memory, and then have contiguous threads stride through the shared memory tile. Unlike global memory, there is no penalty for strided access of shared memory.

* [Using Shared Memory in CUDA C/C++](https://developer.nvidia.com/blog/using-shared-memory-cuda-cc/)

  In the [previous post](https://developer.nvidia.com/blog/parallelforall/how-access-global-memory-efficiently-cuda-c-kernels/), I looked at how global memory accesses by a group of threads can be coalesced into a single transaction, and how alignment and stride affect coalescing for various generations of CUDA hardware. For recent versions of CUDA hardware, misaligned data accesses are not a big issue. However, striding through global memory is problematic regardless of the generation of the CUDA hardware, and would seem to be unavoidable in many cases, such as when accessing elements in a multidimensional array along the second and higher dimensions. However, it is possible to coalesce memory access in such cases if we use shared memory.

  **Shared Memory**

  Because it is on-chip, shared memory is much faster than local and global memory. In fact, shared memory latency is roughly 100x lower than uncached global memory latency(provided that there are no bank conflicts between the threads, which we will examine later in this post).Shared memory is allocated per thread block, so all threads in the block have access to the same shared memory. Threads can access data in shared memory loaded from global memory by other threads within the same thread block. This capability (combined with thread synchronization) has a number of uses, such as user-managed data caches, high-performance cooperative parallel algorithms (parallel reductions, for example), and to facilitate global memory coalescing in cases where it would otherwise not be possible.

  **Thread Synchronization**

  When sharing data between threads, we need to be careful to avoid race conditions, because while threads in a block run *logically* in parallel, not all threads can execute *physically* at the same time.Let’s say that two threads A and B each load a data element from global memory and store it to shared memory. Then, thread A wants to read B’s element from shared memory, and vice versa. Let’s assume that A and B are threads in two different warps. If B has not finished writing its element before A tries to read it, we have a race condition, which can lead to undefined behavior and incorrect results.

  To ensure correct results when parallel threads cooperate, we must synchronize the threads. CUDA provides a simple barrier synchronization primitive, `__syncthreads()`. A thread’s execution can only proceed past a `__syncthreads()` after all threads in its block have executed the `__syncthreads()`. Thus, we can avoid the race condition described above by calling `__syncthreads()` after the store to shared memory and before any threads load from shared memory. It’s important to be aware that calling `__syncthreads()` in divergent code is undefined and can lead to deadlock—all threads within a thread block must call `__syncthreads()` at the same point.

  Dynamic Shared Memory

  The other three kernels in this example use dynamically allocated shared memory, which can be used when the amount of shared memory is not known at compile time. In this case the shared memory allocation size per thread block must be specified (in bytes) using an optional third execution configuration parameter.

  ```
  dynamicReverse<<<1, n, n*sizeof(int)>>>(d_d, n);
  ```

  The dynamic shared memory kernel, `dynamicReverse()`, declares the shared memory array using an unsized extern array syntax, `extern **shared** int s[]` (note the empty brackets and use of the extern specifier). The size is implicitly determined from the third execution configuration parameter when the kernel is launched.

  What if you need multiple dynamically sized arrays in a single kernel? You must declare a single `extern` unsized array as before, and use pointers into it to divide it into multiple arrays, as in the following excerpt.

  ```
  extern __shared__ int s[];
  int *integerData = s;                        // nI ints
  float *floatData = (float*)&integerData[nI]; // nF floats
  char *charData = (char*)&floatData[nF];      // nC chars
  ```

  In the kernel launch, specify the total shared memory needed, as in the following.

  ```
  myKernel<<<gridSize, blockSize, nI*sizeof(int)+nF*sizeof(float)+nC*sizeof(char)>>>(...);
  ```

  Shared memory bank conflicts

  To achieve high memory bandwidth for concurrent accesses, shared memory is divided into equally sized memory modules (banks) that can be accessed simultaneously. Therefore, any memory load or store of *n* addresses that spans *b* distinct memory banks can be serviced simultaneously, yielding an effective bandwidth that is *b* times as high as the bandwidth of a single bank.

  However, if multiple threads’ requested addresses map to the same memory bank, the accesses are serialized. The hardware splits a conflicting memory request into as many separate conflict-free requests as necessary, decreasing the effective bandwidth by a factor equal to the number of colliding memory requests. An exception is the case where all threads in a warp address the same shared memory address, resulting in a broadcast. Devices of compute capability 2.0 and higher have the additional ability to multicast shared memory accesses, meaning that multiple accesses to the same location by any number of threads within a warp are served simultaneously.

  To minimize bank conflicts, it is important to understand how memory addresses map to memory banks. Shared memory banks are organized such that successive 32-bit words are assigned to successive banks and the bandwidth is 32 bits per bank per clock cycle. For devices of compute capability 1.x, the warp size is 32 threads and the number of banks is 16. A shared memory request for a warp is split into one request for the first half of the warp and one request for the second half of the warp. Note that no bank conflict occurs if only one memory location per bank is accessed by a half warp of threads.

  For devices of compute capability 2.0, the warp size is 32 threads and the number of banks is also 32. A shared memory request for a warp is not split as with devices of compute capability 1.x, meaning that bank conflicts can occur between threads in the first half of a warp and threads in the second half of the same warp.

  Devices of compute capability 3.x have configurable bank size, which can be set using [cudaDeviceSetSharedMemConfig](http://docs.nvidia.com/cuda/cuda-runtime-api/index.html#group__CUDART__DEVICE_1g1a4789fb687cc36dccc98f25c96f0cd8)() to either four bytes (cudaSharedMemBankSizeFourByte, the default) or eight bytes (`cudaSharedMemBankSizeEightByte)`. Setting the bank size to eight bytes can help avoid shared memory bank conflicts when accessing double precision data.

  Summary

  Shared memory is a powerful feature for writing well optimized CUDA code. Access to shared memory is much faster than global memory access because it is located on chip. Because shared memory is shared by threads in a thread block, it provides a mechanism for threads to cooperate.

* [An Efficient Matrix Transpose in CUDA C/C++](https://developer.nvidia.com/blog/efficient-matrix-transpose-cuda-cc/)

* [How to Query Device Properties and Handle Errors in CUDA C/C++](https://developer.nvidia.com/blog/how-query-device-properties-and-handle-errors-cuda-cc/)

* [GPU Pro Tip: CUDA 7 Streams Simplify Concurrency](https://developer.nvidia.com/blog/gpu-pro-tip-cuda-7-streams-simplify-concurrency/)

* [CUDA C/C++ Streams and Concurrency](https://developer.download.nvidia.cn/CUDA/training/StreamsAndConcurrencyWebinar.pdf)
* [Unified Memory in CUDA 6](https://developer.nvidia.com/blog/unified-memory-in-cuda-6/)
* [Beyond GPU Memory Limits with Unified Memory on Pascal](https://developer.nvidia.com/blog/beyond-gpu-memory-limits-unified-memory-pascal/)
* [CUDA Pro Tip: Write Flexible Kernels with Grid-Stride Loops](https://developer.nvidia.com/blog/cuda-pro-tip-write-flexible-kernels-grid-stride-loops/)
