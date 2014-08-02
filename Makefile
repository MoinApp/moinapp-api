all:
		prmd combine --meta meta.json schemata/ > schema.json
		prmd verify schema.json
		prmd doc schema.json > schema.md

clean:
		rm schema.json schema.md
