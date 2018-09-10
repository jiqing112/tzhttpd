### TZHTTPD
这是一个高性能且易于使用的HTTP服务框架，可以帮助您快速开发支持HTTP的服务器。
### Key Points of TZHTTPD
1.使用Boost.Asio开发，这意味着高并发性和高性能。非常差的虚拟机可以支持高达1.5K的QPS，所以我相信它在大多数情况下都能满足性能要求。
2.仅支持HTTP GET / POST方法，但满足大多数后端应用程序网关开发的需要。参数和桩体处理得很好。基于uri正则表达式匹配的路由处理程序。
3.连接可以保持，并自动超时并被删除。
4.通过.so库支持加载处理程序，此功能可以方便地模拟传统的CGI部署。该库尝试其最佳加载和更新处理程序，对其他人的影响较小。更令人惊奇的是，您可以构建一个tzhttpd实例并将其复制到任何地方，并编写处理程序并将其构建为个人，因此，将它们添加到配置文件，就像插件一样。
5.基于Boost库和C ++ 0x标准，因此可以在传统但广泛使用的RHEL-6.x环境中使用。
6.没有bug，并且在某种程度上经受了考验。   

### Possible usage
1.通用Web服务器，KIDDING。 TZHTTPD不支持完整的HTTP协议，因此在这种情况下可能表现不佳。 但我还添加了VHost，Cache Control功能，而我的[主页]（http://taozj.net）由此托管，它运行正常。
2.后端应用程序网关，是。 TZHTTPD专为此目的而设计和优化。
3. HTTP协议适配器。 这样TZHTTPD可以用作代理，它接受并解析HTTP请求，转发请求并将相应的respose转换为标准的HTTP响应。
4.服务管理界面。 您可以将TZHTTPD集成到您已经完成的项目中，然后您可以发送自定义uri来干扰您的服务，例如配置更新，运行时统计输出，...... 

### Performance
![siege](siege.png?raw=true "siege")

### Manage URI
```bash
# dynamic reload cfg
curl 'http://127.0.0.1:18430/internal_manage?cmd=reload&auth=d44bfc666db304b2f72b4918c8b46f78'

# disable & enable handler
curl 'http://127.0.0.1:18430/internal_manage?cmd=switch_handler&method=get&path=^/cgi-bin/getdemo.cgi$&enable=off&auth=d44bfc666db304b2f72b4918c8b46f78'
curl 'http://127.0.0.1:18430/internal_manage?cmd=switch_handler&method=get&path=^/cgi-bin/getdemo.cgi$&enable=on&auth=d44bfc666db304b2f72b4918c8b46f78'

# steps to dynamic update handler from so, without impact other service
curl 'http://127.0.0.1:18430/internal_manage?cmd=switch_handler&method=get&path=^/cgi-bin/getdemo.cgi$&enable=off&auth=d44bfc666db304b2f72b4918c8b46f78'
cp libgetdemo.so ../cgi-bin 
curl 'http://127.0.0.1:18430/internal_manage?cmd=update_handler&method=get&path=^/cgi-bin/getdemo.cgi$&enable=on&auth=d44bfc666db304b2f72b4918c8b46f78'
```

### NOTE
As a common sense, you should try your best to make your uri not blocking or consume too long time, otherwise your server will support only little throughput. Sometime these may be inevitable, I will try to fix this problem later if I can.

### Reference project   
[tzmonitor](https://github.com/taozhijiang/tzmonitor).   

