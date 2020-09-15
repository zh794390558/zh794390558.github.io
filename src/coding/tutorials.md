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

## NFS Mount
* https://www.howtoforge.com/tutorial/setting-up-an-nfs-server-and-client-on-centos-7/

### Install
- server
```bash
yum -y install nfs-utils
```
Then enable and start the nfs server service.  
```bash
systemctl enable nfs-server.service
systemctl start nfs-server.service
```

- client
```bash
yum install nfs-utils
```

### Exporting Directories on the Server
- server
```bash
vi /etc/exports
```
```text
/home           192.168.1.101(rw,sync,no_root_squash,no_subtree_check)
/var/nfs        192.168.1.101(rw,sync,no_subtree_check)
/home/zh        *(rw,async,no_root_squash,all_squash,anonuid=6084,anongid=6084)
```

(The no_root_squash option makes that /home will be accessed as root.)
Whenever we modify /etc/exports, we must run:
```bash
exportfs -a
```
afterwards, to make the changes effective.


### Mounting the NFS Shares on the Client

show mountable points on `192.168.1.101`
```bash
showmount -e 192.168.1.101
```

- client
First we create the directories where we want to mount the NFS shares, e.g.:
```bash
mkdir -p /mnt/nfs/home
mkdir -p /mnt/nfs/var/nfs
```
Afterwards, we can mount them as follows:
```bash
mount 192.168.1.100:/home /mnt/nfs/home
mount 192.168.1.100:/var/nfs /mnt/nfs/var/nfs
```


## Nginx
- file server
```
vi /etc/nginx/nginx.conf
```

```text
    autoindex on;# 显示目录
    autoindex_exact_size on;# 显示文件大小
    autoindex_localtime on;# 显示文件时间
    server {
        listen       8011 default_server;
        server_name  fileserver;
        root         /home/name;
        charset      UTF-8;#enable charset HTTP-header

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / { 
        }   

        error_page 404 /404.html;
            location = /40x.html {
        }   

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }   
    }   
```

* support play `wav` and read multitype raw file as `text/plain`

```
 vi /etc/nginx/mime.types
```
```
types {
 		  #mime type :  file suffix
			...
			audio/x-wav                                      wav;
			...
			text/plain																		   txt log csv tsv yaml yml trn;
}
```

