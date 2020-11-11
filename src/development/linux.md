# Linux

## file encoding 

```
iconv -f utf-8 -t gb18030 trans.utf8 > trans.gb
enca -L zh_CN -x utf-8 result.txt

用它不仅可以转换编码，还可以查看文件的原始编码，使用上也比iconv方便一些。
 
enca -L zh_CN file 检查文件的编码

enca -L zh_CN -x UTF-8 file 将文件编码转换为”UTF-8″编码

enca -L zh_CN -x UTF-8 < file1 > file2 如果不想覆盖原文件可以这样

除了有检查文件编码的功能以外，”enca”还有一个好处就是如果文件本来就是你要转换的那种编码，它不会报错，还是会print出结果来， 而”iconv”则会报错。这对于脚本编写是比较方便的事情。
```
