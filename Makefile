.PHONY: build
build:
	docker build --tag restyled/init-certificates .

.PHONY: test
test: build
	docker run --rm --volume "$(PWD)/tmp":/certs \
	  restyled/init-certificates -H blah.example.com

VERSION ?=

.PHONY: release
release: build
	[ -n "$(VERSION)" ]
	docker tag \
	  restyled/init-certificates \
	  restyled/init-certificates:v$(VERSION)
	docker push restyled/init-certificates:v$(VERSION)
	git tag -s -m "v$(VERSION)" "v$(VERSION)"
	git push --tags
