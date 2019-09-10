.PHONY: all build publish

RUST_VSN = 1.37.0
ELIXIR_VSN = 1.9.1

all: build publish

build:
	@for rvsn in $(RUST_VSN) ; do \
		for evsn in $(ELIXIR_VSN) ; do \
			sed -e s/%%RUST_VSN%%/$$rvsn/g -e s/%%ELIXIR_VSN%%/$$evsn/g Dockerfile.template > Dockerfile ; \
			docker build -t rustler:rust$$rvsn-elixir$$evsn . ; \
		done \
	done

publish: build
	@for rvsn in $(RUST_VSN) ; do \
		for evsn in $(ELIXIR_VSN) ; do \
			docker tag rustler:rust$$rvsn-elixir$$evsn xtianw/rustler:rust$$rvsn-elixir$$evsn ; \
			docker push xtianw/rustler:rust$$rvsn-elixir$$evsn ; \
		done \
	done
