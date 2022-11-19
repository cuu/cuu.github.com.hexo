---
title: new golang basis
date: 2022-11-11 22:04:50
tags: golang 
---

First
```
export GO111MODULE=on
export GOPROXY=direct
export GOSUMDB=off
```

otherwise the dumbass golang will try to visit https://sum.golang.org/lookup/xxxxxx

Then directly go to work folder where gonna write go code

```
go mod init example.com/thebinaryname
go get github.com/cuu/yyyy@latest

...

```

the developers must got these ideas from nodejs development....

then create main.go ,the old days back

go build or go run main.go


