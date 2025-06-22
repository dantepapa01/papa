function showBoxSide( target, text, type )

	if ( isElement( target ) and text and type ) then

		triggerClientEvent( target, "showBoxSide", target, text, type )

	end

end




function removeHex (s)
    return s:gsub ("#%x%x%x%x%x%x", "") or false
end


--[[
    ><><><><><><><><><><><><><><><><><><><><
    ><              VulcaN                ><
    ><><><><><><><><><><><><><><><><><><><><
--]]

function Anuncio(playerSource, commandName, ...)
	local nomeAcc = getAccountName (getPlayerAccount ( playerSource)) 
	if isObjectInACLGroup ("user."..nomeAcc, aclGetGroup("Staff")) then --- Digite aqui a ACL da Staff do seu servidor.
		for i, v in pairs(getElementsByType("player")) do
			local msg = table.concat ( { ... }, " " )
			local id = getElementData(playerSource, "ID") or "N/A"
			msg = string.gsub(msg, "#%x%x%x%x%x%x", "")
			msg = getPlayerName(playerSource).." ("..id.."): "..msg
			triggerClientEvent(v, "showBoxSide", resourceRoot, msg, "staff")
		end
	end
end
addCommandHandler("anunciar", Anuncio)

--[[
    ><><><><><><><><><><><><><><><><><><><><
    ><              VulcaN                ><
    ><><><><><><><><><><><><><><><><><><><><
--]]