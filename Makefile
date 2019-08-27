.PHONY: package

all: run

run:
	love .

install-pebbles:
	$(foreach pebble,$(shell cat .pebbles),git clone https://github.com/$(pebble) libs/$(pebble);)

love.js:
	git clone --single-branch --branch 0.11 https://github.com/TannerRogalsky/love.js.git
	cd love.js && git submodule update --init --recursive
	cd love.js && npm i

package:
	@rm -rf build
	mkdir build
	zip -9 -r build/YangWorld.love assets src libs main.lua

web: package
	@rm -rf build-web
	mkdir build-web
	./love.js/index.js -m 100000000 -t YangWorld ./build/YangWorld.love build-web

serve: web
	cd build-web && python -m SimpleHTTPServer 8000

deploy: web
	aws s3 cp build-web s3://proto.yangworld.io/ --recursive