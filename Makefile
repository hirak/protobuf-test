VENDOR=vendor
GOOGLEAPIS=github.com/googleapis/googleapis
PROTOBUF=github.com/protocolbuffers/protobuf/src
PATHS=-I. -I$(VENDOR)/$(GOOGLEAPIS) -I$(VENDOR)/$(PROTOBUF)

.PHONY: clean
clean:
	rm -rf artifacts/{js,php,go}

artifacts/js:
	rm -rf $@ && mkdir -p $@
	find myapp -name '*.proto' | xargs protoc $(PATHS) --js_out=artifacts/js

artifacts/php:
	rm -rf $@ && mkdir -p $@
	find myapp -name '*.proto' | xargs protoc $(PATHS) --php_out=artifacts/php

artifacts/go:
	rm -rf $@ && mkdir -p $@
	find myapp -name '*.proto' | xargs protoc $(PATHS) --plugin=protoc-gen-grpc=`which protoc-gen-go` --go_out=plugins=grpc:artifacts/go

.PHONY: fmt
fmt:
	find . -name '*.proto' | xargs -P8 -IXXX clang-format -i XXX
