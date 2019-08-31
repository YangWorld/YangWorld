.PHONY: package

all: run

run:
	love .

install-pebbles:
	$(foreach pebble,$(shell cat .pebbles),git clone https://github.com/$(pebble) libs/$(subst .lua,,$(pebble));)

love.js:
	git clone --single-branch --branch 0.11 https://github.com/TannerRogalsky/love.js.git
	cd love.js && git submodule update --init --recursive
	cd love.js && npm i

package: clean
	mkdir build
	zip -9 -r build/YangWorld.love assets src libs config conf.lua main.lua

web: package
	mkdir build-web
	./love.js/index.js -s ASSERTIONS=1 -m 200000000 -t YangWorld ./build/YangWorld.love build-web

serve: web
	cd build-web && python -m SimpleHTTPServer 8000

deploy: web
	aws s3 cp build-web s3://proto.yangworld.io/ --recursive

clean:
	@rm -rf build-web build