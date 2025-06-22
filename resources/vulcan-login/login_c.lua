local screenW, screenH = guiGetScreenSize()

 local all = { "ammo", "area_name", "armour", "breath", "clock", "health", "money", "radar", "vehicle_name", "weapon", "radio", "wanted" }

local posW, posH = 30, 30
local xjv = 10
local loginX, loginY = (screenW/2 - (posW/2) - (38*(4))), (screenH/2 - (posH/2) - (45*(4)))

local animation = {}
local alpha = {}

local login = {}
login.gui = {}
login.pagetype = nil
login.select = nil
login.input = {}
login.input.pass = nil
login.tick = getTickCount()
login.tickUp = getTickCount()
login.tickAplah = getTickCount()

login.fonts = {
	regular = {
		[1] = dxCreateFont("assets/fonts/regular.ttf", 10),
		[2] = dxCreateFont("assets/fonts/regular.ttf", 9),
		[3] = dxCreateFont("assets/fonts/regular.ttf", 8),
	},
}

function hasCreateGui(type)
	if tostring(type) == "destroy" then
		for i = 1, 6 do
			if isElement(login.gui[i]) then
				destroyElement(login.gui[i])
			end
		end

	elseif tostring(type) == "login" then
		user = loadLoginFromXML()
		login.gui[1] = guiCreateEdit(loginX + 24*4 + 2, loginY + 29*6 - xjv, 138, 28, user, false)
		guiSetAlpha(login.gui[1], 0)
		guiEditSetMaxLength(login.gui[1], 15)
		guiSetFont(login.gui[1], guiCreateFont("assets/fonts/regular.ttf", 9.5))
		--
		login.gui[2] = guiCreateEdit(loginX + 24*4 + 2, loginY + 34*6 + 2 - xjv, 138, 28, "", false)
		guiSetAlpha(login.gui[2], 0)
		guiEditSetMaxLength(login.gui[2], 15)
		guiSetFont(login.gui[2], guiCreateFont("assets/fonts/regular.ttf", 9.5))

	elseif tostring(type) == "register" then
		login.gui[1] = guiCreateEdit(loginX + 24*4 + 2, loginY + 29*6 - xjv - 25, 138, 28, "", false)
		guiSetAlpha(login.gui[1], 0)
		guiEditSetMaxLength(login.gui[1], 15)
		guiSetFont(login.gui[1], guiCreateFont("assets/fonts/regular.ttf", 9.5))
		--

		login.gui[2] = guiCreateEdit(loginX + 24*4 + 2, loginY + 34*6 + 2 - xjv - 25, 138, 28, "", false)
		guiSetAlpha(login.gui[2], 0)
		guiEditSetMaxLength(login.gui[2], 15)
		guiSetFont(login.gui[2], guiCreateFont("assets/fonts/regular.ttf", 9.5))
		--

		login.gui[3] = guiCreateEdit(loginX + 24*4 + 2, loginY + 34*6 + 2 - xjv + 8, 138, 28, "", false)
		guiSetAlpha(login.gui[3], 0)
		guiEditSetMaxLength(login.gui[3], 30)
		guiSetFont(login.gui[3], guiCreateFont("assets/fonts/regular.ttf", 9.5))
	end
end

addEventHandler("onClientResourceStart", resourceRoot,
	function()
		showCursor(true)
		login.pagetype = "Logo"
		login.tickAplah = getTickCount()
		login.input.pass = nil
		login.tick = getTickCount()
		login.tickUp = getTickCount()
		sound = playSound("assets/sounds/itsOk.mp3", true)
		setSoundVolume(sound, 0.8)

		for i, v in ipairs( all ) do

			showPlayerHudComponent( v, false )
			showPlayerHudComponent("crosshair", true)
			showChat(false)

		end

		setTimer(function()
			hasCreateGui("login")
			login.pagetype = "login"
			login.tickAplah = getTickCount()
		end, 11000, 1)
	end
)

addEventHandler("onClientRender", root,
	function()
		if login.pagetype == "Logo" then

			dxDrawImage(0, 0, screenW, screenH, "assets/images/wallpaper.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

			local fftMul = 0
			if isElement(sound) then
				local FFT = getSoundFFTData(sound, 2048, 0)
				
				if FFT then
					FFT[1] = math.sqrt(FFT[1]) * 2

					if FFT[1] < 0 then
						FFT[1] = 0
					elseif FFT[1] > 1 then
						FFT[1] = 1
					end

					fftMul = FFT[1]

					dxDrawImage(0, 0, screenW, screenH, "assets/images/lights.png", 0, 0, 0, tocolor(255, 255, 255, 255 * FFT[1]))
				end
			end

			animation.alpha = interpolateBetween(0, 0, 0, 255, 0, 0, (getTickCount() - login.tick)/10000, "OutQuad")
			animation.low = interpolateBetween(0, 0, 0, 228, 0, 0, (getTickCount() - login.tick)/10000, "OutQuad")
			animation.create = interpolateBetween(0, 0, 0, 324, 0, 0, (getTickCount() - login.tick)/10000, "OutQuad")
			animation.atrocious = interpolateBetween(222,184,135, 0, 0, 0, (getTickCount() - login.tick)/10000, "OutQuad")

			local seconds = getTickCount() / 1000
			local angle = math.sin(seconds) * 80

			dxDrawImage(loginX + 8*4, loginY + 4*6, animation.low, animation.create, "assets/images/logo_max.png", animation.atrocious, -180, -180, tocolor(255, 255, 255, animation.alpha), false)
		
		elseif login.pagetype == "login" then

			dxDrawImage(0, 0, screenW, screenH, "assets/images/wallpaper.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

			local fftMul = 0
			if isElement(sound) then
				local FFT = getSoundFFTData(sound, 2048, 0)
				
				if FFT then
					FFT[1] = math.sqrt(FFT[1]) * 2

					if FFT[1] < 0 then
						FFT[1] = 0
					elseif FFT[1] > 1 then
						FFT[1] = 1
					end

					fftMul = FFT[1]

					dxDrawImage(0, 0, screenW, screenH, "assets/images/lights.png", 0, 0, 0, tocolor(255, 255, 255, 255 * FFT[1]))
				end
			end

			alpha[1] = interpolateBetween(0, 0, 0, 255, 0, 0, (getTickCount() - login.tickAplah)/6000, "OutQuad")
			alpha[2] = interpolateBetween(0, 0, 0, 180, 0, 0, (getTickCount() - login.tickAplah)/6000, "OutQuad")
			alpha[3] = interpolateBetween(0, 0, 0, 255, 0, 0, (getTickCount() - login.tickAplah)/6000, "OutQuad")

			dxDrawRectangle(loginX, loginY, 338, 370, tocolor(16, 16, 16, alpha[2]))

			dxDrawRectangle(loginX, loginY + 34*10, 338, 30, tocolor(16, 16, 16, alpha[2]))
			dxDrawRectangle(loginX, loginY + 36*10 + 10, 338, 1, tocolor(222,184,135, 255))

			dxDrawImage(loginX + 26*4, loginY + 18*2, 111, 101, "assets/images/logo.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)

			if cursorPosition(loginX + 36*10 + 2, loginY + 29*6 - xjv, 10, 20) then
				dxDrawImage(loginX + 36*10 + 2, loginY + 29*6 - xjv, 10, 20, "assets/images/arrow-2.png", 0, 0, 0, tocolor(222,184,135, alpha[1]), false)
			else
				dxDrawImage(loginX + 36*10 + 2, loginY + 29*6 - xjv, 10, 20, "assets/images/arrow-2.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			end

			if cursorPosition(loginX + 24*4 + 2, loginY + 29*6 - xjv, 138, 28) or login.select == "Btn 1" then
				dxDrawImage(loginX + 24*4 + 2, loginY + 29*6 - xjv, 138, 28, "assets/images/buttonOn.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			else
				dxDrawImage(loginX + 24*4 + 2, loginY + 29*6 - xjv, 138, 28, "assets/images/buttonOff.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			end

			if cursorPosition(loginX + 24*4 + 2, loginY + 34*6 + 2 - xjv, 138, 28) or login.select == "Btn 2" then
				dxDrawImage(loginX + 24*4 + 2, loginY + 34*6 + 2 - xjv, 138, 28, "assets/images/buttonOn.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			else
				dxDrawImage(loginX + 24*4 + 2, loginY + 34*6 + 2 - xjv, 138, 28, "assets/images/buttonOff.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			end

			if isElement(login.gui[1]) then
				dxDrawText(string.sub(guiGetText(login.gui[1]), 1, 15), loginX + 26*4, loginY + 30*6 - 1 - xjv, 130, 26, tocolor(255, 255, 255, alpha[1]), 1, login.fonts.regular[2], "left", "top", false, false, false, true, false)
			end

			if isElement(login.gui[2]) then
				if login.input.pass == "Senha" then
					dxDrawText(string.sub(guiGetText(login.gui[2]), 1, 15), loginX + 26*4, loginY + 36*6 - 4 - xjv, 130, 26, tocolor(255, 255, 255, alpha[1]), 1, login.fonts.regular[2], "left", "top", false, false, false, true, false)
				else
					dxDrawText(passwordHash(string.sub(guiGetText(login.gui[2]), 1, 15)), loginX + 26*4, loginY + 36*6 - 4 - xjv, 130, 26, tocolor(255, 255, 255, alpha[1]), 1, login.fonts.regular[2], "left", "top", false, false, false, true, false)
				end
			end

			if cursorPosition(loginX + 28*4 - 2, loginY + 44*6 + 2, 112, 28) then
				dxDrawImage(loginX + 28*4 - 2, loginY + 44*6 + 2, 112, 28, "assets/images/buttonOn-2.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			else
				dxDrawImage(loginX + 28*4 - 2, loginY + 44*6 + 2, 112, 28, "assets/images/buttonOff-2.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			end
			dxDrawText("Logar-se", loginX + 34*4 + 4, loginY + 44*6 + 8, 112, 28, tocolor(255, 255, 255, alpha[1]), 1, login.fonts.regular[2], "left", "top", false, false, false, true, false)

			if cursorPosition(loginX + 28*4 + 4 - xjv + 3, loginY + 38*8 + 2, 14, 14) or login.input.pass == "Senha" then
				dxDrawImage(loginX + 28*4 + 4 - xjv + 3, loginY + 38*8 + 2, 14, 14, "assets/images/circleOn.png", 0, 0, 0, tocolor(255,255,255,alpha[1]),false)
				dxDrawImage(loginX + 28*4 + 4 - xjv + 5, loginY + 38*8 + 6, 9, 6, "assets/images/success.png", 0, 0, 0, tocolor(255,255,255,alpha[1]),false)
			else
				dxDrawImage(loginX + 28*4 + 4 - xjv + 3, loginY + 38*8 + 2, 14, 14, "assets/images/circleOff.png", 0, 0, 0, tocolor(255,255,255,alpha[1]),false)
			end

			dxDrawText("Visualizar Senha", loginX + 34*4 - xjv + 3, loginY + 36*8 + 10*2 - 1, 112, 28, tocolor(255, 255, 255, alpha[1]), 1, login.fonts.regular[3], "left", "top", false, false, false, true, false)

			dxDrawText("Bem vindo ao Vulcan Academy. Bom jogo!", loginX + 34*4 - xjv - xjv*8 + 10, loginY + 36*8 + 10*2 + 	10*4, 112, 28, tocolor(255, 255, 255, alpha[1]), 1, login.fonts.regular[3], "left", "top", false, false, false, true, false)
		
		elseif login.pagetype == "register" then

			dxDrawImage(0, 0, screenW, screenH, "assets/images/wallpaper.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

			local fftMul = 0
			if isElement(sound) then
				local FFT = getSoundFFTData(sound, 2048, 0)
				
				if FFT then
					FFT[1] = math.sqrt(FFT[1]) * 2

					if FFT[1] < 0 then
						FFT[1] = 0
					elseif FFT[1] > 1 then
						FFT[1] = 1
					end

					fftMul = FFT[1]

					dxDrawImage(0, 0, screenW, screenH, "assets/images/lights.png", 0, 0, 0, tocolor(255, 255, 255, 255 * FFT[1]))
				end
			end

			dxDrawRectangle(loginX, loginY, 338, 370, tocolor(16, 16, 16, alpha[2]))

			dxDrawRectangle(loginX, loginY + 34*10, 338, 30, tocolor(16, 16, 16, alpha[2]))
			dxDrawRectangle(loginX, loginY + 36*10 + 10, 338, 1, tocolor(222,184,135, 255))

			dxDrawImage(loginX + 26*4, loginY + 16*2, 111, 101, "assets/images/logo.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)

			if cursorPosition(loginX - 9*4 + 2, loginY + 29*6 - xjv - 25, 10, 20) then
				dxDrawImage(loginX - 9*4 + 2, loginY + 29*6 - xjv - 25, 10, 20, "assets/images/arrow.png", 0, 0, 0, tocolor(222,184,135, alpha[1]), false)
			else
				dxDrawImage(loginX - 9*4 + 2, loginY + 29*6 - xjv - 25, 10, 20, "assets/images/arrow.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			end

			if cursorPosition(loginX + 24*4 + 2, loginY + 29*6 - xjv - 25, 138, 28) or login.select == "Btn 1" then
				dxDrawImage(loginX + 24*4 + 2, loginY + 29*6 - xjv - 25, 138, 28, "assets/images/buttonOn.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			else
				dxDrawImage(loginX + 24*4 + 2, loginY + 29*6 - xjv - 25, 138, 28, "assets/images/buttonOff.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			end

			if cursorPosition(loginX + 24*4 + 2, loginY + 34*6 + 2 - xjv - 25, 138, 28) or login.select == "Btn 2" then
				dxDrawImage(loginX + 24*4 + 2, loginY + 34*6 + 2 - xjv - 25, 138, 28, "assets/images/buttonOn.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			else
				dxDrawImage(loginX + 24*4 + 2, loginY + 34*6 + 2 - xjv - 25, 138, 28, "assets/images/buttonOff.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			end

			if cursorPosition(loginX + 24*4 + 2, loginY + 34*6 + 2 - xjv + 8, 138, 28) or login.select == "Btn 3" then
				dxDrawImage(loginX + 24*4 + 2, loginY + 34*6 + 2 - xjv + 8, 138, 28, "assets/images/buttonOn.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			else
				dxDrawImage(loginX + 24*4 + 2, loginY + 34*6 + 2 - xjv + 8, 138, 28, "assets/images/buttonOff.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			end

			if isElement(login.gui[1]) then
				dxDrawText(string.sub(guiGetText(login.gui[1]), 1, 15), loginX + 24*4 + 5, loginY + 29*6 - xjv - 19, 138, 28, tocolor(255, 255, 255, alpha[1]), 1, login.fonts.regular[2], "left", "top", false, false, false, true, false)
			end

			if isElement(login.gui[2]) then
				if login.input.pass == "Senha" then
					dxDrawText(string.sub(guiGetText(login.gui[2]), 1, 15), loginX + 24*4 + 5, loginY + 34*6 + 2 - xjv - 18, 138, 28, tocolor(255, 255, 255, alpha[1]), 1, login.fonts.regular[2], "left", "top", false, false, false, true, false)
				else
					dxDrawText(passwordHash(string.sub(guiGetText(login.gui[2]), 1, 15)), loginX + 24*4 + 5, loginY + 34*6 + 2 - xjv - 18, 138, 28, tocolor(255, 255, 255, alpha[1]), 1, login.fonts.regular[2], "left", "top", false, false, false, true, false)
				end
			end

			if isElement(login.gui[3]) then
				if login.input.pass == "Senha" then
					dxDrawText(string.sub(guiGetText(login.gui[3]), 1, 15), loginX + 24*4 + 5, loginY + 34*6 + 2 - xjv + 16, 138, 28, tocolor(255, 255, 255, alpha[1]), 1, login.fonts.regular[2], "left", "top", false, false, false, true, false)
				else
					dxDrawText(passwordHash(string.sub(guiGetText(login.gui[3]), 1, 15)), loginX + 24*4 + 5, loginY + 34*6 + 2 - xjv + 16, 138, 28, tocolor(255, 255, 255, alpha[1]), 1, login.fonts.regular[2], "left", "top", false, false, false, true, false)
				end
			end

			if cursorPosition(loginX + 28*4 - 2, loginY + 44*6 + 2, 112, 28) then
				dxDrawImage(loginX + 28*4 - 2, loginY + 44*6 + 2, 112, 28, "assets/images/buttonOn-2.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			else
				dxDrawImage(loginX + 28*4 - 2, loginY + 44*6 + 2, 112, 28, "assets/images/buttonOff-2.png", 0, 0, 0, tocolor(255, 255, 255, alpha[1]), false)
			end
			dxDrawText("Registrar-se", loginX + 34*4 - 4, loginY + 44*6 + 8, 112, 28, tocolor(255, 255, 255, alpha[1]), 1, login.fonts.regular[2], "left", "top", false, false, false, true, false)

			dxDrawText("Bem vindo ao Vulcan Academy. Bom jogo!", loginX + 34*4 - xjv - xjv*8 + 10, loginY + 36*8 + 10*2 + 	10*4, 112, 28, tocolor(255, 255, 255, alpha[1]), 1, login.fonts.regular[3], "left", "top", false, false, false, true, false)
		end
	end
)

addEvent("login:menu:close", true)
addEventHandler("login:menu:close",root,
	function()
		login.pagetype = nil
		showCursor(false)
		showPlayerHudComponent("crosshair", true)
		showPlayerHudComponent("radar", false)
		showChat(true)
		destroyElement(sound)
		hasCreateGui( "destroy")
	end
)

addEventHandler("onClientClick", root,
	function(button, state)
		if (button == "left" and state == "down") then
			if login.pagetype == "login" then
				if cursorPosition(loginX + 28*4 - 2, loginY + 44*6 + 2, 112, 28) then
					triggerServerEvent("login:logged", localPlayer, guiGetText(login.gui[1]), guiGetText(login.gui[2]))
 				elseif cursorPosition(loginX + 28*4 + 4 - xjv + 3, loginY + 38*8 + 2, 14, 14) then
					setTimer(function() login.input.pass = "Senha" end, 100, 1)
				elseif cursorPosition(loginX + 36*10 + 2, loginY + 29*6 - xjv, 10, 20) then
					login.pagetype = "register"
					hasCreateGui("destroy")
					setTimer(function()
						hasCreateGui("register")
					end, 10, 1)
				end
			elseif login.pagetype == "register" then
				if cursorPosition(loginX - 9*4 + 2, loginY + 29*6 - xjv - 25, 10, 20) then
					login.pagetype = "login"
					hasCreateGui("destroy")
					setTimer(function()
						hasCreateGui("login")
					end, 10, 1)
				elseif cursorPosition(loginX + 28*4 - 2, loginY + 44*6 + 2, 112, 28) then
					triggerServerEvent("login:register", localPlayer, guiGetText(login.gui[1]), guiGetText(login.gui[2]), guiGetText(login.gui[3]))
				end
			end
		end
	end
)

addEventHandler("onClientClick", root,
	function(button, state)
		if (button == "left" and state == "down") then
			if login.input.pass == "Senha" then 
				if cursorPosition(loginX + 28*4 + 4 - xjv + 3, loginY + 38*8 + 2, 14, 14) then
					setTimer( function( ) login.input.pass = nil end, 100, 1 )
				end
 			end
		end
	end
)

function loadLoginFromXML()
	local XML = xmlLoadFile ("userdata.xml")
	if not XML then
		XML = xmlCreateFile("userdata.xml", "login")
	end
	
	local usernameNode = xmlFindChild (XML, "username", 0)
	if usernameNode then
		return xmlNodeGetValue(usernameNode)
	else
		return ""
	end
	xmlUnloadFile ( XML )
end

function saveLoginToXML(username)
	local XML = xmlLoadFile ("userdata.xml")
	if not XML then
		XML = xmlCreateFile("userdata.xml", "login")
	end
	if (username ~= "") then
		local usernameNode = xmlFindChild (XML, "username", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(XML, "username")
		end
		xmlNodeSetValue (usernameNode, tostring(username))
	end
    xmlSaveFile(XML)
    xmlUnloadFile (XML)
end
addEvent("saveLoginToXML", true)
addEventHandler("saveLoginToXML", root, saveLoginToXML)

function passwordHash(password)
	local length = utfLen(password)

	if length > 23 then
		length = 23
	end
	return string.rep("*", length)
end
 
function cursorPosition(x, y, width, height)
	if (not isCursorShowing()) then
		return false
	end
	local screenX, screenY = guiGetScreenSize()
	local cursorX, cursorY = getCursorPosition()
	local cursorX, cursorY = (cursorX*screenX), (cursorY*screenY)
	if (cursorX >= x and cursorX <= x + width) and (cursorY >= y and cursorY <= y + height) then
		return true
	else
		return false
	end
end