# Algorithm

* [Read First](https://github.com/labuladong/fucking-algorithm/blob/master/%E7%AE%97%E6%B3%95%E6%80%9D%E7%BB%B4%E7%B3%BB%E5%88%97/%E5%AD%A6%E4%B9%A0%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84%E5%92%8C%E7%AE%97%E6%B3%95%E7%9A%84%E9%AB%98%E6%95%88%E6%96%B9%E6%B3%95.md)
* [dp thinking frame](https://github.com/labuladong/fucking-algorithm/blob/master/%E5%8A%A8%E6%80%81%E8%A7%84%E5%88%92%E7%B3%BB%E5%88%97/%E5%8A%A8%E6%80%81%E8%A7%84%E5%88%92%E8%AF%A6%E8%A7%A3%E8%BF%9B%E9%98%B6.md)
* [backtrack thiking frame](https://github.com/labuladong/fucking-algorithm/blob/master/%E7%AE%97%E6%B3%95%E6%80%9D%E7%BB%B4%E7%B3%BB%E5%88%97/%E5%9B%9E%E6%BA%AF%E7%AE%97%E6%B3%95%E8%AF%A6%E8%A7%A3%E4%BF%AE%E8%AE%A2%E7%89%88.md)

## Data Structure
* https://www.bilibili.com/video/BV1nE411R7sM?from=search&seid=16769163313077745083

## Dynamic Programming
* https://iq.opengenus.org/tag/dynamic-programming/
* https://www.geeksforgeeks.org/dynamic-programming/


## Graph
* https://iq.opengenus.org/tag/graph-algorithm/
* https://www.geeksforgeeks.org/graph-data-structure-and-algorithms/
* https://www.geeksforgeeks.org/topological-sorting-indegree-based-solution/?ref=lbp

* https://www.bilibili.com/video/av96408783/
| Shortest Path (SP) Algorithms | BFS | Dijkstra's | Bellman Ford | Floyd Warshall |
| --- | --- | --- | --- | --- |
| Complexity | O(V+E) | O((V+E)logV) | O(VE) | O(V^3) |
| Recommended graph size | Large | Large/Medium | Medium/Small | Small |
| Good for AP(all pair)SP? | Only works on unweighted graphs | Ok | Bad | Yes |
| Can detect negative cycles? | No | No | Yes | Yes |
| SP on graph with weighted edges | Incorrect SP answer | Best algorithm | Works | Bad in general |
| SP on graph with unweighted edges | Best algorithm | Ok | Bad | Bad in genral |


## Refs

* [fucking-algorithm](https://github.com/labuladong/fucking-algorithm.git)
* [Tutorial from a Google Engineer](https://github.com/williamfiset/Algorithms)

  


## Highlight
###Recursion

* 链表是树的子结构，递归便利模式与树类似；树是图的子结构，图的便利模式与树相似；

  ```c++
  void traverse(ListNode* head){	
  		//线序遍历
  	  traverse(head->next);
  	  //后续遍历，回溯
  }
  
  void traverse(Tree *root){
  		//先序遍历
  		traverse(root->left);
  		//中序遍历
  		traverse(root->right);
  		//后续遍历，回溯
  }
  
  void traverse(Graph *node){
  		//先序遍历
      for (int i =0; i < node.childrens; i++){
          traverse(node.child(i));
      }
      //后续遍历，回溯
  }
  ```

* 递归时间复杂度 = 解决每个子问题需要的时间 x 子问题总数
* **从 原问题展开子问题进行求解的方式叫自顶向下**

###DP

* DP table 是⾃底向上求解，递归解法是⾃顶向下求解
* 采用备忘录的方式来存子问题的解以避免大量的重复计算(剪枝)
* 动态规划算法的时间复杂度就是[⼦问题个数 × 函数本⾝的复杂度]。
* 其实回溯算法和动态规划的本质都是穷举，只不过动态规划存在「重叠⼦问题」可以优化，⽽回溯算法不存在⽽已。
* 最优子结构，状态转移方程，重叠子问题就是动态规划的三要素，这其中定义子问题的状态与写出状态转移方程是解决动态规划最为关键的步骤，状态转移方程如果定义好了，解决动态规划就基本不是问题了。


* 求解动态规划基本思路如下（解题四步曲）
  * 判断是否可用递归来解，可以的话进入步骤 2
  * 分析在递归的过程中是否存在大量的重复子问题
  * 采用备忘录的方式来存子问题的解以避免大量的重复计算（剪枝）
  * 改用自底向上的方式来递推，即动态规划

### Bitwise

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



###DFS&BFS

* 深度优先遍历: 

  主要思路是从图中一个未访问的顶点 V 开始，沿着一条路一直走到底，然后从这条路尽头的节点回退到上一个节点，再从另一条路开始走到底...，不断递归重复此过程，直到所有的顶点都遍历完成，它的特点是不撞南墙不回头，先走完一条路，再换一条路继续走。


* DFS 一般是解决连通性问题，而 BFS 一般是解决最短路径问题

  ```c++
  //DFS
  void dfs(i){
  	 stack<int> s;
  	 s.push(root);
  	 while(!s.empty()){
  	     auto t = s.top();
  	     s.pop();
  	     process(t);
  	     for (int i = 0; i < t.adjs(); i++){
  	     			s.push(t.adj(i));
  	     }
  	 }
  }
  
  //BFS
  void bfs(i){
  	 queue<int> s;
  	 s.push(root);
  	 while(!s.empty()){
  	     auto t = s.front();
  	     s.pop();
  	     process(t);
  	     for (int i = 0; i < t.adjs(); i++){
  	     			s.push(t.adj(i));
  	     }
  	 }
  }
  ```

  

* 树的前序遍历,实际上不管是前序遍历，还是中序遍历，亦或是后序遍历，都属于深度优先遍历。

* 深度优先遍历用的是栈，而广度优先遍历要用队列来实现

* 连通性问题可以用DFS,BFS, 并查集解决
  为了找到连通块的个数，一个简单的方法就是使用深度优先搜索，从每个节点开始，我们使用一个大小为 N 的 visited 数组（M 大小为 N×N），这样 visited[i] 表示第 i 个元素是否被深度优先搜索访问过。    我们首先选择一个节点，访问任一相邻的节点。然后再访问这一节点的任一相邻节点。这样不断遍历到没有未访问的相邻节点时，回溯到之前的节点进行访问。    连通块就是可以从任意起点到达的所有节点。因此，连通块的个数，我们从每个未被访问的节点开始深搜，每开始一次搜索就增加 count计数器一次。

* 树是图的一种特例（连通无环的图就是树）。图的DFS/BFS和树的原理其实也是一样，只不过图和树两者的表示形式不同而已。

###Union&Find


* 并查集模板：

  并查集，在一些有N个元素的[集合](https://baike.baidu.com/item/集合/2908117)应用问题中，我们通常是在开始时让每个元素构成一个单元素的集合，然后按一定顺序将属于同一组的元素所在的集合合并，其间要反复查找一个元素在哪个集合中。

  并查集是一种树型的数据结构，用于处理一些不相交[集合](https://baike.baidu.com/item/集合/2908117)（*Disjoint* *Sets*）的合并及查询问题。常常在使用中以森林来表示。

  - 合并（Union）：把两个不相交的集合合并为一个集合
  - 查询（Find）：查询两个元素是否在同一个集合中

```python
class UnionFindSet:
	def UnionFindSet(n):
		parents = [0,1...n] # 记录每个元素的parent即根节点 先将它们的父节点设为自己
		ranks =[0,0...0]    # 记录节点的rank值
	
    # 如下图 递归版本 路径压缩(Path Compression)
    # 如果当前的x不是其父节点，就找到当前x的父节点的根节点(find(parents[x])) 并将这个值赋值给x的父节点
	def find(x):
		if ( x !=parents[x]): # 注意这里的if
			parents[x] = find(parents[x])
		return parents[x]

	# 如下图 根据Rank来合并(Union by Rank)
	def union(x,y):
		rootX = find(x) # 找到x的根节点rootX
		rootY = find(y) # 找到y的根节点rootY
        #取rank值小的那个挂到大的那个节点下面，此时两个根节点的rank值并没有发生变化，还是原来的值
		if(ranks[rootX]>ranks[rootY]): parents[rootY] = rootX 
		if(ranks[rootX]<ranks[rootY]): parents[rootX] = rootY
        # 当两个rank值相等时，随便选择一个根节点挂到另外一个跟节点上，但是被挂的那个根节点的rank值需要+1    
		if(ranks[rootX] == ranks[rootY] ):
			parents[rootY] = rootX
			ranks[rootY]++
```

### Array

* 数组中间位置的删时间复杂度是O(n)，所以删一定要将该数置换到数组结尾再删除。

###Binary Heap

* 二叉堆（Binary Heap）没什么神秘，性质比二叉搜索树 BST 还简单。其主要操作就两个，sink（下沉）和 swim（上浮），用以维护二叉堆的性质。其主要应用有两个，首先是一种排序方法「堆排序」，第二是一种很有用的数据结构「优先级队列」。

  二叉堆其实就是一种特殊的二叉树（完全二叉树），只不过存储在数组里。一般的链表二叉树，我们操作节点的指针，而在数组里，我们把数组索引作为指针：

  ```c++
  // 父节点的索引
  int parent(int root) {
      return root / 2;
  }
  // 左孩子的索引
  int left(int root) {
      return root * 2;
  }
  // 右孩子的索引
  int right(int root) {
      return root * 2 + 1;
  }
  ```

  **注意数组的第一个索引 0 空着不用**.

  二叉堆还分为最大堆和最小堆。**最大堆的性质是：每个节点都大于等于它的两个子节点。**类似的，**最小堆的性质是：每个节点都小于等于它的子节点**。

  对于最大堆，会破坏堆性质的有有两种情况：

  如果某个节点 A 比它的子节点（中的一个）小，那么 A 就不配做父节点，应该下去，下面那个更大的节点上来做父节点，这就是对 A 进行 **下沉**。

  如果某个节点 A 比它的父节点大，那么 A 不应该做子节点，应该把父节点换下来，自己去做父节点，这就是对 A 的 **上浮**。

  insert, delete操作只会在堆底和堆顶进行，显然堆底的「错位」元素需要上浮，堆顶的「错位」元素需要下沉。

  ```java
  private void swim(int k) {
      // 如果浮到堆顶，就不能再上浮了
      while (k > 1 && less(parent(k), k)) {
          // 如果第 k 个元素比上层大
          // 将 k 换上去
          exch(parent(k), k);
          k = parent(k);
      }
  }
  ```

  下沉比上浮略微复杂一点，因为上浮某个节点 A，只需要 A 和其父节点比较大小即可；但是下沉某个节点 A，需要 A 和其两个子节点比较大小，如果 A 不是最大的就需要调整位置，要把较大的那个子节点和 A 交换。

  ```java
  private void sink(int k) {
      // 如果沉到堆底，就沉不下去了
      while (left(k) <= N) {
          // 先假设左边节点较大
          int older = left(k);
          // 如果右边节点存在，比一下大小
          if (right(k) <= N && less(older, right(k)))
              older = right(k);
          // 结点 k 比俩孩子都大，就不必下沉了
          if (less(older, k)) break;
          // 否则，不符合最大堆的结构，下沉 k 结点
          exch(k, older);
          k = older;
      }
  }
  ```

  **`insert` 方法先把要插入的元素添加到堆底的最后，然后让其上浮到正确位置。**

  ```java
  public void insert(Key e) {
      N++;
      // 先把新元素加到最后
      pq[N] = e;
      // 然后让它上浮到正确的位置
      swim(N);
  }
  ```

  **`delMax` 方法先把堆顶元素 A 和堆底最后的元素 B 对调，然后删除 A，最后让 B 下沉到正确位置。**

  ```java
  public Key delMax() {
      // 最大堆的堆顶就是最大元素
      Key max = pq[1];
      // 把这个最大元素换到最后，删除之
      exch(1, N);
      pq[N] = null;
      N--;
      // 让 pq[1] 下沉到正确位置
      sink(1);
      return max;
  }
  ```

  二叉堆就是一种完全二叉树，所以适合存储在数组中，而且二叉堆拥有一些特殊性质。

  二叉堆的操作很简单，主要就是上浮和下沉，来维护堆的性质（堆有序），核心代码也就十行。

  优先级队列是基于二叉堆实现的，主要操作是插入和删除。插入是先插到最后，然后上浮到正确位置；删除是调换位置后再删除，然后下沉到正确位置。核心代码也就十行。
