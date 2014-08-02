all:
		prmd combine --meta meta.json schemata/ > schema.json
		cat schema.json
		pwd
		prmd verify schema.json
		prmd doc schema.json > README.md

clean:
		rm -f schema.json
