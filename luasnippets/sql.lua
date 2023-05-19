local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node
local extras = require "luasnip.extras"
local fmt = require("luasnip.extras.fmt").fmt
local events = require "luasnip.util.events"
local conds = require "luasnip.extras.conditions"
local ai = require "luasnip.nodes.absolute_indexer"
local m = extras.match
local l = extras.lambda
local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix

ls.add_snippets("sql", {

    --------------------------------------------------------------
    -- config
    --------------------------------------------------------------
    s({
        name = "config",
        trig = "config",
        description = "config statements",
    },
        fmt([[
            {}
        ]], {
            c(1, {
                sn(nil, fmt([[
                    CREATE USER IF NOT EXISTS {} WITH {} ;
                ]], {
                    i(1, "name"),
                    i(1, "options"),
                })),

                sn(nil, fmt([[
                    CREATE EXTENSION IF NOT EXISTS {} WITH {} ;
                ]], {
                    i(1, "name"),
                    i(1, "options"),
                })),

                sn(nil, fmt([[
                    ALTER USER {} ;
                ]], {
                    i(1, "name"),
                })),

                sn(nil, fmt([[
                    ALTER USER {} ;
                ]], {
                    i(1, "name"),
                })),

                sn(nil, fmt([[
                    ALTER EXTENSION {} {} TO {} ;
                ]], {
                    i(1, "name"),
                    i(2, "UPDATE"),
                    i(3, "VERSION"),
                })),

                sn(nil, fmt([[
                    DROP USER {} ;
                ]], {
                    i(1, "name"),
                })),

                sn(nil, fmt([[
                    DROP EXTENSION {} ;
                ]], {
                    i(1, "name"),
                })),
            })
        })
    ),

    --------------------------------------------------------------
    -- create
    --------------------------------------------------------------
    s({
        name = "create",
        trig = "create",
        description = "create objects",
    },
        fmt([[
            CREATE {}
        ]], {
            c(1, {
                sn(nil, fmt([[
                    DATABASE {} {};
                ]], {
                    i(1, "name"),
                    c(2,{
                        t(""),
                        sn(nil,fmt([[
                            WITH owner = postgres
                            ENCODING = 'UTF-8'
                        ]],{}))
                    }),
                })),
                sn(nil,fmt([[
                    TABLE {} {}
                ]],{
                    i(1,"name"),
                    c(2,{
                        sn(1,fmt([[
                            (
                            {}
                            ) {};
                        ]],{
                            i(2, "fiel type constraint"),
                            c(1, {
                                sn(nil, fmt([[
                                    INHERITS ({}) 
                                ]], {
                                    i(1, "INHERITS")
                                })),
                                t("")
                            })
                        })),
                        sn(2,fmt([[
                            AS
                            SELECT {} FROM {}
                            {}
                        ]],{
                            i(1, "*/cols"),
                            i(2, "table"),
                            -- i(3, "filter"),
                            c(3,{
                                sn(nil,fmt([[WHERE {} ; ]],{
                                    i(1,"filter")
                                })),
                                t(""),
                            }),
                        })),
                    }),
                })),
                sn(nil, fmt([[
                    PROCEDURE {}({})
                    LANGUAJE {}
                    AS $$
                        {}
                    $$ ;
                ]], {
                    i(1, "name"),
                    c(2, {
                        i(1, "args"),
                        t(""),
                    }),
                    c(3, {
                        t("SQL"),
                        t("C"),
                    }),
                    i(4, "-- code --"),
                })),
                sn(nil, fmt([[
                    FUNCTION {}({})
                    RETURNS {}
                    LANGUAJE {}
                    AS $$
                        {}
                    $$ ;
                ]], {
                    i(1, "name"),
                    c(2, {
                        i(2, "args"),
                        t(""),
                    }),
                    i(3, "return_type"),
                    c(4, {
                        t("SQL"),
                        t("C"),
                    }),
                    i(5, "-- code"),
                })),
                sn(nil, fmt([[
                    FUNCTION {}({})
                    RETURNS {}
                    LANGUAJE PLPGSQL
                    AS $$
                    DECLARE
                        {}
                    BEGIN
                        {}
                    END
                    $$ ;
                ]], {
                    i(1, "name"),
                    c(2, {
                        i(2, "args"),
                        t(""),
                    }),
                    i(3, "return_type"),
                    c(4, {
                        i(1, "declarations"),
                        t(""),
                    }),
                    i(5, "-- code"),
                })),
                sn(nil, fmt([[
                    VIEW {} AS SELECT {} FROM {} WHERE {} ;
                ]], {
                    i(1, "name"),
                    i(2, "*/cols"),
                    i(3, "table"),
                    i(3, "filter"),
                })),
                sn(nil, fmt([[
                    INDEX {} ON {}({}) ;
                ]], {
                    i(1, "name"),
                    i(2, "table"),
                    i(3, "cols"),
                })),
                sn(nil, fmt([[
                    TRIGGER {}
                    {} {}
                    ON {} FROM {}
                    FOR EACH {}
                    BEGIN
                        {}
                    END ;
                ]], {
                    i(1, "name"),
                    c(2, {
                        t("BEFORE"),
                        t("AFTER"),
                        t("INSTEAD OF"),
                    }),
                    i(3, "UPDATE OR INSERT OR DELETE OR TRUNCATE"),
                    i(4, "table"),
                    i(5, "table"),
                    c(6, {
                        t("ROW"),
                        t("STATEMENT"),
                    }),
                    i(7, "code")
                })),
                sn(nil, fmt([[
                    TYPE {} AS {}
                ]], {
                    i(1,"name"),
                    c(2, {
                        sn(nil,fmt([[ {} ;]], {
                            i(1, "basetype"),
                        })),
                        sn(nil, fmt([[ENUM({}) ;]], {
                            i(1, "variants"),
                        })),
                        sn(nil, fmt([[
                            (
                                {}
                            ) ;
                        ]], {
                            i(1, "name type"),
                        })),
                    })
                })),
                sn(nil, fmt([[
                    COMMENT ON TABLE {} IS {} ;
                ]], {
                    i(1, "table"),
                    i(2, "comment"),
                })),
                sn(nil, fmt([[
                    BEGIN TRANSACTION {}
                        {}
                    -- SAVEPOINT
                    {} TRANSACTION ;
                ]], {
                    i(1, "operator"),
                    i(3, "-- code"),
                    c(2, {
                        t("ROLLBACK"),
                        t("COMMIT"),
                    }),
                })),
                c(1, {
                    sn(nil, fmt([[
                        OPERATOR {} (
                            LEFTARG = {},
                            RIGTHARG = {},
                            PROCEDURE = {}
                        ) ;
                    ]], {
                        i(1, "operator"),
                        i(2, "leftarg"),
                        i(3, "rigtharg"),
                        i(4, "procedure"),
                    })),
                    sn(nil, fmt([[
                        OPERATOR {} ( LEFTARG = {}, RIGTHARG = {}, PROCEDURE = {}) ;
                    ]], {
                        i(1, "operator"),
                        i(2, "leftarg"),
                        i(3, "rigtharg"),
                        i(4, "procedure"),
                    })),
                })
            }),
        })
    ),

    --------------------------------------------------------------
    -- drops
    --------------------------------------------------------------
    s({
        name = "drop database",
        trig = "DROP DATABASE",
        description = "drop database",
    },
        fmt([[
            DROP {} {}
        ]], {
            c(2, {
                sn(nil, fmt([[
                    DATABASE IF EXISTS {} ;
                ]], {
                    i(1, "name")
                })),
                sn(nil, fmt([[
                    TABLE IF EXISTS {} ;
                ]], {
                    i(1, "name")
                })),
                sn(nil, fmt([[
                    PROCEDURE IF EXISTS {} ;
                ]], {
                    i(1, "name")
                })),
                sn(nil, fmt([[
                    FUNCTION IF EXISTS {} ;
                ]], {
                    i(1, "name")
                })),
                sn(nil, fmt([[
                    VIEW IF EXISTS {} ;
                ]], {
                    i(1, "name")
                })),
                sn(nil, fmt([[
                    INDEX IF EXISTS {} ;
                ]], {
                    i(1, "name")
                })),
                sn(nil, fmt([[
                    TRIGGER IF EXISTS {} ON {} ;
                ]], {
                    i(1, "name"),
                    i(2, "table"),
                })),
                sn(nil, fmt([[
                    TYPE IF EXISTS {} ;
                ]], {
                    i(1, "name"),
                })),
            }),
            c(1, {
                t("RESTRICT"), -- avoid cascade behavior
                t("CASCADE"), -- delete all objects that depend on deleteded objects
            })
        })
    ),

    --------------------------------------------------------------
    -- alter
    --------------------------------------------------------------
    s(
        {
            name = "alter",
            trig = "alter",
            dscr = "alter a table object",
        },
        fmt([[
            ALTER TABLE {} {} 
          ]], {
            i(1, "name"),
            c(2, {
                sn(nil, fmt([[
                    RENAME TO {} ;
                  ]], {
                    i(1, "newname"),
                })),
                sn(nil, fmt([[
                    RENAME COLUMN {} TO {} ;
                  ]], {
                    i(1, "oldname"),
                    i(2, "newname"),
                })),
                sn(nil, fmt([[
                    ADD COLUMN {} {} ;
                  ]], {
                    i(1, "col"),
                    i(2, "type"),
                })),
                sn(nil, fmt([[
                    ADD CONSTRAINT {} {} {} ;
                  ]], {
                    i(1, "constraint_name"),
                    i(2, "constraint"),
                    i(3, "target_col"),
                })),
                sn(nil, fmt([[
                    DROP COLUMN {} ;
                  ]], {
                    i(1, "column_name"),
                })),
                sn(nil, fmt([[
                    DROP CONSTRAINT {} ;
                  ]], {
                    i(1, "constraint_name"),
                })),
                sn(nil, fmt([[
                    INSERT INTO {} ({}) VALUES ({}) ;
                  ]], {
                    i(1, "name"),
                    i(2, "fields"),
                    i(3, "values"),
                })),
                sn(nil, fmt([[
                    INSERT INTO {} ({})
                    SELECT {}
                    FROM {}
                    WHERE {}
                ]], {
                    i(1, "table"),
                    i(3, "cols"),
                    rep(3),
                    i(2, "table"),
                    i(4, "filter"),
                })),

            })
        })
    ),

    --------------------------------------------------------------
    -- select
    --------------------------------------------------------------
    s(
        {
            name = "select",
            trig = "select",
            dscr = "select data from table",
        },
        fmt([[
            SELECT {} FROM {} {} ;
        ]], {
            i(1, "*/cols/distinct/key -> val/key ->> val"),
            c(2, {
                i(1, "table"),
                i(1,"fn"),
            }),
            c(3, {
                t("filter"),
                t(";"),
            }),
        })
    ),

    s(
        {
            name = "filter",
            trig = "filter",
            dscr = "filter data",
        },
        fmt([[
            {}
        ]], {
            c(1, {
                sn(nil, fmt([[
                    WHERE {} ;
                ]], {
                    i(1,"condition"),
                })),
                sn(nil, fmt([[
                    GROUP BY {} ;
                ]], {
                    i(1,"cols"),
                })),
                sn(nil, fmt([[
                    GROUP BY {} HAVING {} ;
                ]], {
                    i(1, "cols"),
                    i(2, "conds"),
                })),
                sn(nil, fmt([[
                    ORDER BY {} {} ;
                ]], {
                    i(1, "cols"),
                    c(2, {
                        t("ASC"),
                        t("DESC"),
                    }),
                })),
                sn(nil, fmt([[
                    LIMIT {} ;
                ]], {
                    i(1, "item_qty"),
                })),
                sn(nil, fmt([[
                    OFFSET {} ;
                ]], {
                    i(1, "row_num"),
                })),
                sn(nil, fmt([[
                    BETWEEN {} AND {} ;
                ]], {
                    i(1, "val1"),
                    i(2, "val2"),
                })),
                sn(nil, fmt([[
                    GLOB {} ;
                ]], {
                    i(1, "regex"),
                })),
                sn(nil, fmt([[
                    IN {} ;
                ]], {
                    i(1, "collection/container"),
                })),
                sn(nil, fmt([[
                    COALESCE({},{})
                ]], {
                    i(1, "col"),
                    i(2, "default_value"),
                })),
                sn(nil, fmt([[
                    EXTRACT({} FROM {})
                ]], {
                    i(1, "field"),
                    i(2, "data"),
                })),
                sn(nil, fmt([[
                    {} {} ON {}.{} = {}.{} ;
                ]], {
                    c(1, {
                        t("LEFTH JOIN"),
                        t("RIGTH JOIN"),
                        t("INNER JOIN"),
                        t("OUTTER JOIN"),
                    }),
                    i(2, "table2"),
                    rep(1),
                    i(3, "table1_field"),
                    rep(2),
                    i(4, "table2_field"),
                })),
            }),
        })
    ),

    --------------------------------------------------------------
    -- delete
    --------------------------------------------------------------
    s(
        {
            name = "delete",
            trig = "delete",
            dscr = "delete data from table",
        },
        fmt([[
            DELETE FROM {} WHERE {} ;
        ]], {
            i(1, "table"),
            i(2, "filter"),
        })
    ),

    --------------------------------------------------------------
    -- update
    --------------------------------------------------------------
    s({
        name = "update",
        trig = "update",
        description = "update table data",
    },
        fmt([[
            UPDATE {} 
        ]], {
            c(1, {
                sn(nil, fmt([[
                    {} SET {} WHERE {} ;
                ]], {
                    i(1, "table"),
                    i(2, "cols = vals"),
                    i(3, "filter"),
                })),
                sn(nil, fmt([[
                    {}
                    SET {} = {}.{}
                    FROM {}
                    WHERE {} ;
                ]], {
                    i(1, "table"),
                    i(3, "cols"),
                    rep(2),
                    rep(3),
                    i(2, "table"),
                    i(5, "filter"),
                }))
            })
        })
    ),

    --------------------------------------------------------------
    -- auxiliar
    --------------------------------------------------------------

    s({
        name = "WITH",
        trig = "WITH",
        description = "declare a CTE(common table expresion)",
    },
        fmt([[
	   "CALL {}
	]]      , {
            i(1, "PROCEDURE")
        })
    ),

    s({
        name = "cast",
        trig = "CAST",
        description = "transform type of data to desire type output_type",
    },
        fmt([[
   	        CAST({} AS {}) ;",
	    ]]  , {
            i { 1, "data" },
            i { 2, "output_type" }
        })
    ),

    s({
        name = "call-proc",
        trig = "CALL",
        description = "call/execute a procedure",
    },
        fmt([[
            CALL {} ;
	    ]]  , {
            i(1, "PROCEDURE")
        })
    ),

    s({
        name = "call-function",
        trig = "CALL",
        description = "call/execute a function",
    },
        fmt([[
		    "SELECT {} ;
	    ]]  , {
            i(1, "FUNCTION")
        })
    ),

    s({
        name = "row",
        trig = "ROW",
        description = "construct a composite type with values vals",
    },
        fmt([[
	        ROW({}) ;
	    ]]  , {
            i(1, "vals")
        })
    ),
    s({
        name = "if",
        trig = "if",
        description = "if declaration",
    },
        fmt([[
            IF {1} THEN,
			    {2}
            ELSE,
			    {3}
            END IF ;
        ]], {
            i(1, "cond"),
            i(2, "code_if"),
            i(3, "code_else"),
        })
    ),


    -- types
    s({
        name = "types",
        trig = "types",
        description = "types declaration"
    },
        fmt([[
		    {}
        ]], {
            c(1, {
                t("INT"),
                t("SMALLINT"),
                t("BIGINT"),
                t("REAL"),
                sn(1, {
                    t("CHARS"),
                    c(1, {
                        sn(1, {
                            t("("),
                            i(1, "limit_qty"),
                            t(")"),
                        }),
                        t(""),
                    })
                }),
                sn(1, {
                    t("VARCHARS"),
                    c(1, {
                        sn(1, {
                            t("("),
                            i(1, "limit_qty"),
                            t(")"),
                        }),
                        t(""),
                    })
                }),
                t("TEXT"),
                t("DATE"),
                t("JSON"),
            })
        })
    ),

    s({
        name = "constraint",
        trig = "constraint",
        description = "constraints declaration",
    },
        fmt([[
    		{}
      ]] , {
            c(1, {
                t("PRIMARY KEY"),
                t("NOT NULL"),
                t("DEFAULT"),
                t("UNIQUE"),
                t("AUTOINCREMENT"),
                sn(1, fmt([[
    		  	    CHECK {}
    	  	    ]]   , {
                    c(1, {
                        i(1, "cond"),
                        t(""),
                    })
                })),
                sn(1, fmt([[
      	  	        REFERENCES {table}({field})
    	  	    ]]   , {
                    table = i(1, "table"),
                    field = i(2, "field"),
                })),
                sn(1, fmt([[
      	  	  	    NOTE {}
    	  		]]      , {
                    i(1, "note")
                })),
            })
        })
    ),

    s({
        name = "functions",
        trig = "fn",
        description = "auxiliar functions"
    },
        fmt([[
		    {}
        ]], {
            c(1, {
                sn(nil, fmt([[
                    COUNT({})
                ]], {
                    i(1, "cols")
                })),
                sn(nil, fmt([[
                    SUM({})
                ]], {
                    i(1, "cols")
                })),
                sn(nil, fmt([[
                    MAX({})
                ]], {
                    i(1, "cols")
                })),
                sn(nil, fmt([[
                    MIN({})
                ]], {
                    i(1, "cols")
                })),
                sn(nil, fmt([[
                    AVG({})
                ]], {
                    i(1, "cols")
                })),
                t("NOW()"),
            })
        })
    ),

    --------------------------------------------------------------
    -- postgres commands
    --------------------------------------------------------------
    s({
        name = "postgres commands",
        trig = "pg-cmd",
        description = "postgres commands"
    },
        fmt([[
		    {}
        ]], {
            c(1, {
                sn(nil, fmt([[
                    \\copy (SELECT {} FROM {}) TO '{}.csv' ;
                ]], {
                    i(1, "content"),
                    i(2, "source"),
                    i(3, "destination"),
                })),
                t("SELECT * FROM pg_extension ;"),
                t("SELECT * FROM pg_available_extensions ;"),
                t("SELECT * FROM pg_available_extensions_versions ;"),
                sn(nil, fmt([[
                    CREATE EXTENSION IF NOT EXISTS '{}' ;
                ]], {
                    i(1, "extension")
                })),
                sn(nil, fmt([[
                    pg_dump_all > {}.sql"
                ]], {
                    i(1, "dst_db"),
                })),
                sn(nil, fmt([[
                    psql {} < {}.sql
                ]], {
                    i(1, "dst_db"),
                    i(2, "src_data"),
                })),
                sn(nil, fmt([[
                    pg_restore -d {} {}
                ]], {
                    i(1, "dst_db"),
                    i(2, "src_data"),
                })),
                sn(nil, fmt([[
                    SELECT pg_size_pretty(pg_database_size('{}')) ;
                ]], {
                    i(1, "db_name"),
                })),
                sn(nil, fmt([[
                    SELECT pg_size_pretty(pg_table_size('{}')) FROM pg_stat_all_tables ;
                ]], {
                    i(1, "table_name"),
                })),
                sn(nil, fmt([[
                    SELECT pg_size_pretty(pg_database_size('{}')) ;
                ]], {
                    i(1, "extension"),
                })),
            })
        })
    ),

    s({
        name = "postgres variables",
        trig = "pg-var",
        description = "postgres variables"
    },
        fmt([[
		    {}
        ]], {
            c(1, {
                t("pg_catalog"),
                t("pg_stat_all_tables"),
                t("pg_class"),
            })
        })
    ),

})
