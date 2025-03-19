function anims_out()
	local moves = {} 
	for i,v in pairs(game:GetDescendants()) do 
		if v:IsA("Animation") and not v:IsDescendantOf(game.CoreGui) then 
			local id = v:GetAttribute("OldId") or v.AnimationId
			if not v:GetAttribute("OldId") then v:SetAttribute("OldId", id) end
			v:SetAttribute("OLDID", nil)

			local is_rblx = id:find("roblox.com/asset") and true or false

			local subbed = id:sub(is_rblx and 33 or 14)
			moves[subbed] = subbed
		end
	end 

	local estr = ""

	for id,name in pairs(moves) do
		estr = `{estr}{id} {name}\n`
	end

	return estr
end

function anims_in(str)
	local anims = {}
	for i,v in pairs(game:GetDescendants()) do 
		if v:IsA("Animation") and not v:IsDescendantOf(game.CoreGui) and v:GetAttribute("OldId") then
			local id = v:GetAttribute("OldId")
			local is_rblx = id:find("roblox.com/asset") and true or false

			local subbed = id:sub(is_rblx and 33 or 14)
			anims[v] = subbed
		end
	end
	
	warn(anims)
	
	local lines = string.split(str, "\n")
	for _,v in pairs(lines) do
		local splits = string.split(v, " ")
		local id = splits[1]
		local name = splits[2]
		
		local animation = nil
		
		for i2, v2 in pairs(anims) do
			if v2 == name then
				i2.AnimationId = `rbxassetid://{id}`
			end
		end
	end
end


-- rough script for roblox-animation-transfer
-- USAGE:
--[[
	print(anims_out()) -- Log a list of current animations

	-- Process externally with RAT

	anims_in([[id1 name1
	id2 name2]]) -- Import and override animations
]]
