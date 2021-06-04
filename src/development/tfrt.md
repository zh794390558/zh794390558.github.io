# [TFRT: A New TensorFlow Runtime ](https://github.com/tensorflow/runtime)


## Design
* [TFRT Deep Dive](https://drive.google.com/drive/folders/1fkLJuVP-tIk4GENBu2AgemF3oXYGr2PB)
* [host runtime design](https://github.com/tensorflow/runtime/blob/master/documents/tfrt_host_runtime_design.md)


## Tutorial
* [TFRT Tutorial](https://github.com/tensorflow/runtime/blob/master/documents/tutorial.md)


## IR
* [MLIR](https://www.tensorflow.org/mlir)

## BEF Executor - "Binary Executor Format" (BEF) Files

Executor features:
- Lock-free: atomics instead of mutexes
- Non-blocking: defer dependent work with AsyncValue::AndThen
- Supports “non-strict” execution: may run a kernel when some of its inputs are available
   -- Good for efficiently forwarding unavailable inputs to outputs

Key concepts:
- BEF: dataflow graph
- Kernel: dataflow node
- AsyncValue: dataflow edge
