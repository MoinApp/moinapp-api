all:
		prmd combine --meta meta.json schemata/ > $(shell pwd)/schema.json
		prmd doc $(shell pwd)/schema.json #> $(shell pwd)/README.md

verify:
		prmd verify $(shell pwd)/schema.json

clean:
		rm -f schema.json
