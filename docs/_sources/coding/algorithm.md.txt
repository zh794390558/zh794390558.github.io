# Algorithm

* [Read First](https://github.com/labuladong/fucking-algorithm/blob/master/%E7%AE%97%E6%B3%95%E6%80%9D%E7%BB%B4%E7%B3%BB%E5%88%97/%E5%AD%A6%E4%B9%A0%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84%E5%92%8C%E7%AE%97%E6%B3%95%E7%9A%84%E9%AB%98%E6%95%88%E6%96%B9%E6%B3%95.md)
* [dp thinking frame](https://github.com/labuladong/fucking-algorithm/blob/master/%E5%8A%A8%E6%80%81%E8%A7%84%E5%88%92%E7%B3%BB%E5%88%97/%E5%8A%A8%E6%80%81%E8%A7%84%E5%88%92%E8%AF%A6%E8%A7%A3%E8%BF%9B%E9%98%B6.md)
* [backtrack thiking frame](https://github.com/labuladong/fucking-algorithm/blob/master/%E7%AE%97%E6%B3%95%E6%80%9D%E7%BB%B4%E7%B3%BB%E5%88%97/%E5%9B%9E%E6%BA%AF%E7%AE%97%E6%B3%95%E8%AF%A6%E8%A7%A3%E4%BF%AE%E8%AE%A2%E7%89%88.md)



## Refs

* [fucking-algorithm](https://github.com/labuladong/fucking-algorithm.git)

  


## High Light
* DP table 是⾃底向上求解，递归解法是⾃顶向下求解

* 动态规划算法的时间复杂度就是[⼦问题个数 × 函数本⾝的复杂度]。

* 其实回溯算法和动态规划的本质都是穷举，只不过动态规划存在「重叠⼦问题」可以优化，⽽回溯算法不存在⽽已。

* `n&(n-1)`作⽤是消除数字 n 的⼆进制表⽰中的最后⼀个1。

* ⼀个数如果是 2 的指数，那么它的⼆进制表⽰⼀定只含有⼀个 1

  ```c++
  bool isPowerOfTwo(int n) {
  if (n <= 0) return false;
  return (n & (n - 1)) == 0;
  }
  ```

* 判断两个数是否异号

  ```c++
  int x = -1, y = 2;
  bool f = ((x ^ y) < 0); // true
  int x = 3, y = 2;
  bool f = ((x ^ y) < 0); // false
  ```

* 利⽤或操作 | 和空格将英⽂字符转换为⼩写

  ```c++
  ('a' | ' ') = 'a'
  ('A' | ' ') = 'a'
  ```

* 利⽤与操作 & 和下划线将英⽂字符转换为⼤写

  ```c++
  ('b' & '_') = 'B'
  ('B' & '_') = 'B'
  ```

* 利⽤异或操作 ^ 和空格进⾏英⽂字符⼤⼩写互换

```c++
('d' ^ ' ') = 'D'
('D' ^ ' ') = 'd'
```

