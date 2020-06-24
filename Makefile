.PHONY: build run

build:
	docker build -t leanote:local .

run:
	docker run -ti --rm -v leanote:/data -p 9000:9000 leanote:local
