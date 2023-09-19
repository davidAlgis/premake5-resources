--* Variables exported to the user, descriptions in the README
premake.api.register({
    name = "addResource",
    scope = "project", -- this field can be set at the project scope
    kind = "string", -- expect a string value (e.g., "On" or "Off")
    allowed = { "On", "Off" }, -- only allow these specific values
    default = "Off" -- default value
})

require("vstudio")

-- Helper function to check if a file exists
local function fileExists(filename)
    local f = io.open(filename, "r")
    if f then
        f:close()
        return true
    else
        return false
    end
end

local function writeResource(prj)
    local rcExist = fileExists(prj.location .. "\\" .. prj.name .. ".rc")
    if rcExist == false then
        print("Please a " .. prj.name .. ".rc file before compiling resources.")
        return
    end
    if (prj.project.addResource == "On" and rcExist) then
        premake.w('<ItemGroup>')
        premake.w('  <ResourceCompile Include="%s.rc" />', prj.name)
        premake.w('</ItemGroup>')
    end

end

premake.override(premake.vstudio.vc2010.elements, "project", function(base, prj)
    local calls = base(prj)
    table.insertafter(calls, premake.vstudio.vc2010.files, writeResource)
    return calls
end)
-- end
