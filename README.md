<p align="center">
<img src="https://gitee.com/Peyet/image-library/raw/master/NewsAPP/Splash.gif" alt="NewsAPP" title="NewsAPP" width="557"/>
</p>
<p align="center">
<img src="https://img.shields.io/badge/platform-iOS-blue" alt="platform">
<img src="https://img.shields.io/tokei/lines/github/peyet/NewsAPP" alt="Lines of code">
<img src="https://img.shields.io/github/last-commit/peyet/NewsAPP" alt="GitHub last commit">
<img src="https://img.shields.io/github/v/release/peyet/NewsAPP?include_prereleases" alt="GitHub releases">
<img src="https://img.shields.io/github/license/peyet/NewsAPP" alt="License">  
<a href="https://twitter.com/PeyetZh"><img src="https://img.shields.io/twitter/follow/peyetzh?style=social" alt="Twitter Follow"></a>
</p>


# NewsAPP

一款新闻与娱乐的聚合iOS应用。

<table border="1" style = "center">
    <tr>
        <td>开发平台</td>
        <td>Xcode 13.1</td>
        <td>iOS 15.0</td>
    </tr>
</table>

## 应用演示

<img src="https://gitee.com/Peyet/image-library/raw/master/NewsAPP/Splash.gif" alt="Splash" style="zoom:48%;" /><img src="https://gitee.com/Peyet/image-library/raw/master/NewsAPP/News.gif" alt="News" style="zoom:48%;" /><img src="https://gitee.com/Peyet/image-library/raw/master/NewsAPP/Video.gif" alt="Video" style="zoom:48%;" /><img src="https://gitee.com/Peyet/image-library/raw/master/NewsAPP/Recommend.gif" alt="Recommend" style="zoom:48%;" />						

## TODO List

- [x] **推送通知**

- [x] **开屏广告**

- [x] **加载新闻、视频、图片列表**

- [x] **查看新闻、图片详情**

- [x] **已读新闻标记**

- [x] **删除页面内容**

- [x] **离线缓存**

- [ ] 分享功能

- [ ] 优化离线缓存

- [ ] 个人中心（使用后端云服务存储用户数据）

## API

[新闻](https://www.free-api.com/doc/66)	[视频](https://www.free-api.com/doc/515)	[图片](https://github.com/huanghui0906/API/blob/master/Tuchong.md)

## 技术实现

- 开屏广告

  ​	iOS系统在App启动前，也就是AppDelegate的`- application: didFinishLaunchingWithOptions:` 前，会加载一个从LaunchScreen中提前准备好的启动图片，在加载完成App UI后，这张图片就会消失。由于现在手机手机处理器速度很快，这张图片的展示事件非常短，所以需要在展示完系统启动图后衔接一个和系统启动图一样的界面。

  ​	这里选择了在SceneDelegate中 `- scene: willConnectToSession options:` 即将把Scene绑定到UIWindow的时候，配置我们的自定义广告界面。这样就实现了无缝切换 。