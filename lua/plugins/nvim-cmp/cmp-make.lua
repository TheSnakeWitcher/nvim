local source = {}

source.new = function()
    --local self = setmetatable({cache = {}} , {__index = source})
    local self = setmetatable({} , {__index = source})
    return self
end

function find_makefile_path()
    local path_root , files = vim.loop.cwd() , {"Makefile","makefile"}
    local makefile_path = vim.fs.find( files, {path = path_root,type = "file"})

    if #makefile_path == 0 then
        return nil  -- no makefile in project 
    end

    return makefile_path[1]
end

source.complete = function (self,params,callback)

    -- local makefile_path = find_makefile_path()
    local path_root , files = vim.loop.cwd() , {"Makefile","makefile"}
    local makefile_path = vim.fs.find( files, {path = path_root,type = "file"})
    if #makefile_path == 0 then return end -- no makefile in project 

    local makefile = io.open(makefile_path[1], 'r')
    local string_to_parse = makefile:read("*a")
    makefile:close()

    local lang,query = "make" , [[(rule (targets (word) @rule_name))]]
    local parser = vim.treesitter.get_string_parser(string_to_parse,lang,{})

    local tree = parser:parse()[1]
    local tree_root = tree:root()
    local rule_names = vim.treesitter.query.parse_query(lang,query)

    local items = {}
    for id,node,metadata in rule_names:iter_captures(tree_root,string_to_parse) do
        table.insert(items,{
          label = "make " .. vim.treesitter.query.get_node_text(node,string_to_parse,{})
        })
    end

    callback(items)

    -- if self.cache[path_root] then
    --     callback {items = self.cache[path_root] , isIncomplete = false}
    -- else
        -- self.cache[path_root] = items
    -- end

end

function source:get_keyword_pattern()
    return [[make .*]]
end

source.is_available = function()
    -- return find_makefile_path() and true or false
    --
    -- if find_makefile_path() == nil then
    --      return false
    --  else
    --      true
    --  end
    return true
end

require("cmp").register_source("make",source.new())
