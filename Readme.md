![](https://upload-images.jianshu.io/upload_images/3778244-65c62b2e2775b20a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 概述

这个是以前在公司搞得,因为公司的软件包比较大,然后每次在本地传给客户的时候很慢,一般要一天才可以传完,之后决定把软件包放到别的地方让用户自己下载,要求下载服务器有下面几个需求

- 支持断点续传
- 支持密码访问
- 支持控制传输速度

其实nginx默认就是支持断点续传的,我们要配置的就是密码访问和控制传输速度而已,为了简单,我直接使用docker做,这样搭建环境几乎就快乐很多,废话不多说,放上项目地址

### 项目地址

`https://github.com/bboysoulcn/nginx-down`

欢迎star和follow

### 使用方法

首先clone下来

`git clone https://github.com/bboysoulcn/nginx-down`

之后根据需求修改你的下载速度

`vim nginx.conf`

修改下面这行就可以

`limit_rate 2048k;`

上面我就是限制了2m的下载速度

下面是修改输入密码提示语的地方

~~bash
        # 密码文件位置和提示语
	auth_basic "motherfucker man";
	auth_basic_user_file /etc/nginx/passwd;
~~

修改完成之后保存

之后修改下载的端口,修改下面这个文件

`vim docker-compose.yml`

~~bash
    ports:
      - 8082:80
~~

我现在使用的是8082端口下载的,修改8082为你想要的端口就可以

修改需要下载的目录位置

也就是你要把你要下载的文件放在哪一个目录

~~bash
    volumes:
      - /home/data:/usr/share/nginx/html/data
~~

我现在是/home/data下,你修改成你的就可以

最后生成你的密码,删除下面这个文件

`rm -rf passwd`

之后重新生成

安装下面这个工具

`sudo apt install apache2-utils`

使用下面的命令生成密码

`htpasswd -c passwd bboysoul`

bboysoul是你的用户名

最后执行下面命令启动就可以

`docker-compose up -d`

最后浏览器访问ip:8082就可以

### 最后

如果为了安全可以在前面再加一个nginx做根据域名端口转发,这样就可以直接使用域名访问了

欢迎关注Bboysoul的博客[www.bboysoul.com](http://www.bboysoul.com/)
Have Fun
