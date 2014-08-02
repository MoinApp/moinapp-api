all:
		prmd combine --meta meta.json schemata/ > schema.json
		prmd doc schema.json > README.md

verify:
		prmd verify ./schema.json

clean:
		rm -f schema.json
