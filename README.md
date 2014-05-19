## 准备工作

编译Python之前，需要做以下准备工作：

* CentOS 6.3
* [fpm](Effing package management)
* 编译工具链
* 网络连接

使用目录下的 `prepare.sh` 脚本将会安装 [fpm] 以及相应的编译工具链。

``` bash
sudo ./prepare.sh
```

## 创建 Python 的 RPM 包

## 修改安装目录

在创建 `rpm` 包之前，我们需要指定`rpm`包的安装目录，可以通过修改 `config.mk` 完成：

``` makefile
### Dictionary which this rpm will be installed to
PYTHON_INSTALL_DIR=/opt/python$(PYTHON_MAJOR_VERSION)
```

`config.mk` 的其它参数，若没有需要，可以不再修改。

### 编译，创建，并安装 Python 的 RPM 包


``` bash
sudo make
```

**NOTE:** 创建完成的 RPM 包将放到本文件所在目录下，可供今后使用。


### 编译，创建，并安装 Python 的常用库和工具包

以下包将会被创建：

- setuptools
- virtualenv
- pip
- meld3
- supervisor
- wheel


``` bash
cd extras/
sudo make
```

**NOTE:** 创建完成的 RPM 包将放到本文件所在目录下，可供今后使用。

[fpm]: https://github.com/jordansissel/fpm
