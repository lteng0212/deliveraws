简要介绍aws虚拟网络的概念以及创建方法

Amazon Virtual Private Cloud (VPC) 是一个让您能够在自己定义的逻辑隔离的虚拟网络中启动 AWS 资源的服务

VPC基础功能：流日志、IP地址管理、IP寻址、入口路由、网络控制、流量景象、安全等

相关地址：https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html
terraform地址：https://www.5axxw.com/wiki/content/bj4a3s#joi6k9az91

1. aws中子网与腾讯云一致，不能垮zone建立
2. 路由表
3. Gateways网关和 专属链接点 and endpoints（不需要nat和网关）
4. 对等链接
5. Transit gateways中心网关
6. vpn 链接本地
7. nat 1个公网映射多个内网IP

vpc上限是64000 peer 上限12800

可以创建完全是ipv6的地址
