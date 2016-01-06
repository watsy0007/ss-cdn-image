# ss-cdn-image

简化上传图片到七牛的接口。


## 背景

最近在使用MWeb，感觉效果非常不错，不过官方提供的图床功能对骑牛支持不好，顺手写1个ruby版的图床服务器代码。


## 测试使用方式

### 1. 配置七牛

略

### 2. 启动

```shell
rackup config.ru
```

### 3. 配置图床服务

参考 [MWeb 1.9 发布！新图标、编辑器大改进、导出 PDF 改进、增加图床功能、中文版等！](http://zh.mweb.im/mweb-1.9.1-release.html)


## todo list

- [ ] 验证图片
- [ ] 环境配置
- [ ] docker配置与镜像
