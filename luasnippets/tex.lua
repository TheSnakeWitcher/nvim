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
local fmta = require("luasnip.extras.fmt").fmta
local events = require "luasnip.util.events"
local conds = require "luasnip.extras.conditions"
local ai = require "luasnip.nodes.absolute_indexer"
local m = extras.match
local l = extras.lambda
local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix


ls.add_snippets("tex", {

    ------------------------------------------------------
    -- 	              codebase structures   	 	--
    ------------------------------------------------------
    s(
        {
            name = "base structure",
            trig = "!",
            dscr = "basic tex estructure",
        },
        fmta([[
            \documentclass{<>}


            \usepackage{<>}


            \title{<>}
            \author{Alejandro Virelles}
            \date{\today}


            \begin{document}

            \maketitle

            <>

            \end{document}
        ]],
            {
                i(1),
                i(2),
                i(3, "title"),
                i(4, "code"),
            }
        )
    ),

    s(
        {
            name = "input/include",
            trig = "in",
            dscr = [[codebase management,note:
                input:
                    can contain another \input
                    don't insert line breaks
                    tex extension is optional
                include:
                    can't contain another \include but can \input
                    insert line breaks
                    tex extension required
                includeonly:
                    determines from a subset of \include which will be compiled
            ]],
        },
        fmta([[
            <>{<>}
        ]],
            {
                c(1, {
                    t "input",
                    t "include",
                    t "includeonly",
                }),
                i(2, "file"),
            }
        )
    ),

    s(
        {
            name = "begin",
            trig = "begin",
            dscr = [[begin statement,note:
                figure options:
                    h: float
                    t: position at top page
                    b: position at bottom
                    p: speciall page for floats only
            ]],
        },
        fmta([[
            \begin{<>}<>
                <>
            \end{<>}
        ]],
            {
                i(1),
                d(2, function(args, parent, old_state, user_args)
                    if args[1][1] == "figure" then
                        return sn(nil,
                            fmt([[
                                [{}]
                            ]], {
                                i(1, "h|t|b|p|H|!"),
                            })
                        )
                    else
                        return sn(nil, t(""))
                    end
                end, { 1 }, {}),
                d(3, function(args, _, _, _)
                    if args[1][1] == "enumerate" or args[1][1] == "itemize" then
                        return sn(nil,
                            fmt([[
                                \item{{{}}}
                            ]], {
                                i(1, "content")
                            })
                        )
                    elseif args[1][1] == "description" then
                        return sn(nil,
                            fmt([[
                                \item[{}]{}
                            ]], {
                                i(1, "term"),
                                i(2, "description"),
                            })
                        )
                    else
                        return sn(nil, { i(1, "code") })
                    end
                end, { 1 }, {}),
                rep(1),
            }
        )
    ),

    s(
        {
            name = "section",
            trig = "section",
            dscr = "section declaration",
        },
        fmta([[
            \<>{<>}
                <>
        ]],
            {
                c(1, {
                    t("section"),
                    t("subsection"),
                    t("subsubsection"),
                    t("paragraph"),
                    t("subparagraph"),
                    t("chapter"),
                    t("part"),
                    -- ununmbereds
                    t("section*"),
                    t("subsection*"),
                }),
                i(2, "heading"),
                i(3, "content"),
            }
        ), {
        keys = {
            "paragraph",
            "part",
            "chapter",
        },
    }
    ),

    s(
        {
            name = "fmt",
            trig = "fmt",
            dscr = "fmt commands",
        },
        fmta([[
            \<>{<>}
        ]],
            {
                c(1, {
                    t("textnormal"),
                    t("emph"), -- emphasize(bold)
                    t("textrm"), -- roman font family
                    t("textsf"), -- san serif font family
                    t("texttt"), -- teletype font family
                    t("textup"), -- upright shape
                    t("textit"), -- italic shape
                    t("textst"), -- slanted shape
                    t("textsc"), -- small capitals
                    t("uppercase"),
                    t("textbf"), -- bold
                    t("textmd"), -- medium weight
                    t("textlf"), -- light
                }),
                i(2, "content")
            }
        ), {
        key = "paragraph",
    }
    ),

})
