## 准备工作

编译Python之前，需要做以下准备工作：

* CentOS 6.3
* [fpm](Effing package management)
* 编译工具链
* 网络连接

使用目录下的 `prepare.sh` 脚本将会安装 [fpm] 以及相应的编译工具链。

``` bash
./prepare.sh
```

## 修改安装目录

在创建 `rpm` 包之前，我们需要指定`rpm`包的安装目录，可以通过修改 `config.mk` 完成：

``` makefile
### Dictionary which this rpm will be installed to
PYTHON_INSTALL_DIR=/opt/python$(PYTHON_MAJOR_VERSION)
```


[fpm]: https://github.com/jordansissel/fpm
