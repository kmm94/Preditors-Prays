local Table = {}

function Table.deserialize(string)


	if string.len(string) < 3 then return {} end

	load("table="..string)()
	--l_debug(string)
	--l_debug(table[1])
	return table
end


function Table.serialize(val, name, depth)
	--skipnewlines = skipnewlines or false
	depth = depth or 0
	local tbl = string.rep("", depth)
	if name then
		if type(name)=="number" then
			namestr = "["..name.."]"
			tbl= tbl..namestr.."="
		elseif name then 
			tbl = tbl ..name.."="
			--else tbl = tbl .. "systbl="
		end	
	end
	
	if type(val) == "table" then
			tbl = tbl .. "{"
			local i = 1
		for k, v in pairs(val) do
			if i ~= 1 then
				tbl = tbl .. ","
			end	
			tbl = tbl .. Table.serialize(v,k, depth +1) 
			i = i + 1;
		end
			tbl = tbl .. string.rep(" ", depth) ..  "}"
	elseif type(val) == "number" then
		tbl = tbl .. tostring(val) 
	elseif type(val) == "string" then
		tbl = tbl .. string.format("%q", val)
	else
		tbl = tbl .. "[datatype not serializable:".. type(val) .. "]"
	end

	return tbl

end

return Table
