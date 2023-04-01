if engine.ActiveGamemode() ~= "terrortown" and gmod.GetGamemode().Name ~= "Trouble in Terrorist Town" then 
    return 
end
util.AddNetworkString( "ClientDeathNotify" )

hook.Add("PlayerDeath", "Kill_Reveal_Notify", function( victim, entity, killer )
	local reason = 0

    if IsValid(entity) and IsValid(killer) and entity:GetClass() == "entityflame" and killer:GetClass() == "entityflame" then
    reason = "burned"
    killerz = "nil"
    role = "nil"
    entity:Remove() -- 删除实体
	
	elseif victim.DiedByWater then
		reason = "water"
		killerz = "nil" 
		role = "nil"
		
 	elseif entity:GetClass() == "worldspawn" and killer:GetClass() == "worldspawn" then
		reason = "fell"
		killerz = "nil"
		role = "nil"
		
	elseif victim:IsPlayer() and entity:GetClass() == 'prop_physics' or entity:GetClass() == "prop_dynamic" or entity:GetClass() == 'prop_physics' then -- If the killer is also a prop
			reason = "prop"
			killerz = "nil"
			role = "nil"
			
	elseif( killer == victim ) then 
		reason = "suicide"
		killerz = "nil"
		role = "nil"
		
	elseif killer:IsPlayer() && victim != killer then
		reason = "ply"
		killerz = killer:Nick() 
		role = killer:GetRole()
	else
		reason = "nil"
		killerz = "nil"
		role = "nil"
	end

	net.Start("ClientDeathNotify")
    net.WriteString(killerz)
	net.WriteString(role)
	net.WriteString(reason)
	net.Send(victim)
end)