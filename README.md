Data-sync
===

Install
---
Golang must be installed with config `$GOROOT` & `$GOPATH`

Pull library with command

```
go get
```

Usage
---
Build project

```
go build
```

Execute binary file 

```
./generate_data
```

Config
---
Must be in same path with binary file, in folder

```
config/config.yaml
```

Update connection configuration in `config.yaml`
Supported Postgres (`postgres`) and MySQL (`mysql`)