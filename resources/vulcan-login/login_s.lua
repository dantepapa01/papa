local isChatVisible = true


addEvent('login:logged', true)
addEventHandler('login:logged', root,
	function(username, password)
		if source then
			if username == "" then
				return exports["vulcan-box"]:showBoxSide(source, "Coloque o seu usuário.", "error")
			end

			if password == "" then
				return exports["vulcan-box"]:showBoxSide(source, "Coloque a sua senha.", "error")
			end

			local account = getAccount(username, password)
			if not account then
				return exports["vulcan-box"]:showBoxSide(source, "Provalmente esta conta não existe.", "error")
			end

			logIn(source, account, password)
			exports["vulcan-box"]:showBoxSide(source, "Você entrou com sucesso na cidade.", "success")
			triggerClientEvent(source, "saveLoginToXML",source, tostring(username))
			triggerClientEvent(source, "login:menu:close", source)
			setElementData( source, "conta:loggedIn", true )
			setElementData( source, "conta:hud", true )
			showChat(source, true)
			
		end
	end
)

addEvent('login:register', true)
addEventHandler('login:register', root,
	function(username, password, password2)
		if source then

			if username == "" then
				return exports["vulcan-box"]:showBoxSide(source, "Coloque o seu usuário", "error")
			end

			if not (password == password2) then
				return exports["vulcan-box"]:showBoxSide(source, "As senhas não coincidem.", "error")
			end

			if (password2 == "") then
				return exports["vulcan-box"]:showBoxSide(source, "Coloque a sua senha.", "error")
			end

			local account = getAccount(username, password)

			if not account then
				local accountAdd = addAccount(tostring(username), tostring(password))
				if accountAdd then
					logIn(source, accountAdd, tostring(password))
					exports["vulcan-box"]:showBoxSide(source, "Sua conta foi criada com sucesso", "success")
				end
			end
		end
	end
)