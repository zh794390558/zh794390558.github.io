# masked op backpropgation

## masked_select

```
Tensor masked_select_backward(const Tensor& grad, const Tensor& input, const Tensor& mask) {
  // The following could just be written as `zeros_like(input).masked_scatter(mask, grad)`.
  // However, as an optimization, we call the in-place variant of masked_scatter.
  // Unfortunately, that doesn't allow for the broadcasting of the LHS, so we need
  // to explicitly broadcast here (the out-of-place variant of masked_scatter
  // implicitly handles broadcasting).
  auto result = at::zeros_like(
      input.expand(at::infer_size(input.sizes(), mask.sizes())), 						at::MemoryFormat::Preserve);
  return result.masked_scatter_(mask, grad);
}
```

