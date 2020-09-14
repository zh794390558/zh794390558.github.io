# Coding Tutorials

## Version Control
* [An interactive git visualization to challenge and educate!](https://github.com/pcottle/learnGitBranching.git)


## Regular Expression
* [Tutorials and Test](https://regexone.com/)
* [Exercises](https://github.com/gskinner/regexr)


## SQL
* [SQL Tutorial](https://sqlzoo.net/)


## Session
* [HTTP Session Management for Go](https://github.com/alexedwards/scs)
* https://github.com/astaxie/build-web-application-with-golang.git


## Golang
* [A golang ebook intro how to build a web with golang](https://github.com/astaxie/build-web-application-with-golang.git)


## Jupyter
* [converting Python calculations into rendered latex](https://github.com/connorferster/handcalcs.git)
* [c++ in jupyter](https://github.com/prabhuomkar/pytorch-cpp/blob/master/notebooks/tensor_slicing.ipynb)
* [cling]()


## Python
* Disabling Bytecode (.pyc) Files
```bash
export PYTHONDONTWRITEBYTECODE=1
```

## CentOS 7 gcc update
* https://linuxize.com/post/how-to-install-gcc-compiler-on-centos-7/
 
`Software Collections`, also known as `SCL` is a community project that allows you to build, install, and use multiple versions of software on the same system, without affecting system default packages.
By enabling Software Collections, you gain access to the newer versions of programming languages and services which are not available in the core repositories.

The SCL repositories provide a package named Developer Toolset, which includes newer versions of the GNU Compiler Collection, and other development and debugging tools.  

First, install the CentOS SCL release file. It is part of the CentOS extras repository and can be installed by running the following command:  
```bash
sudo yum install centos-release-scl
```

Currently, the following Developer Toolset collections are available:

- Developer Toolset 7
- Developer Toolset 6

```bash
sudo yum install devtoolset-7
```

To access GCC version 7, you need to launch a new shell instance using the Software Collection scl tool:
```bash
scl enable devtoolset-7 bash
or
. /opt/rh/devtoolset-7/enable 
```
