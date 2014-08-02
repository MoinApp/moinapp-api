all:
		prmd combine --meta meta.json schemata/ > schema.json
		prmd verify schema.json
		prmd doc schema.json > README.md

clean:
		rm -f schema.json
