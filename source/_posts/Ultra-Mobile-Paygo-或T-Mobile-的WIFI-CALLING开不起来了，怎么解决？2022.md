---
title: Ultra Mobile Paygo(或T-Mobile)的WIFI CALLING开不起来了，怎么解决 2022？
date: 2022-11-11 21:22:36
tags:
---

手机端手动改DNS。最简单方便。

在连上WIFI的信号上，添加2条手动DNS

```
199.85.126.10

199.85.127.10
```

或是

```
208.54.49.131 depdg.epc.mnc260.mcc310.pub.3gppnetwork.org
208.54.36.3 ss.epdg.epc.mnc260.mcc310.pub.3gppnetwork.org
208.54.35.163 epdg.epc.mnc260.mcc310.pub.3gppnetwork.org
208.54.35.163 ss.epdg.epc.mnc260.mcc310.pub.3gppnetwork.org
208.54.87.3 ss.epdg.epc.geo.mnc260.mcc310.pub.3gppnetwork.org
```

格式规律是 
```
epdg.epc.<服务商 mnc>.<服务商 mcc>.pub.3gppnetwork.org
```
mnc mcc 号码来自 

https://en.wikipedia.org/wiki/Mobile_country_code

例如
```
epdg.epc.mnc260.mcc310.pub.3gppnetwork.org for MNC260 MCC310 (T-Mobile USA)
```

wifi calling 

UDP 500,4500

TCP 143




