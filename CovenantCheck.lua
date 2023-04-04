local vCovChk_AppTitle = "|CFFFFFF00"..strsub(GetAddOnMetadata("CovenantCheck", "Title"),2).."|r v"..GetAddOnMetadata("CovenantCheck", "Version")
------------------------------------------------------------------------
-- Global Localizations
------------------------------------------------------------------------
local CovCheckTable = {}
local w, h, l, r, t, b, ws, hS = 1024, 512, 0, 0, 0, 0, 0, 0
local CovPic = {{ 926,52,85, }, { 856,60,83, }, { 770,75,75, }, { 696,70,90, }}
------------------------------------------------------------------------
-- Check World Quest for Necrolord
------------------------------------------------------------------------
function Necrolord_WQ_List()
	vCovChk_ResultArea:SetText("")
	wipe(CovCheckTable)
		Necrolord_World_Quest = {
		-- Pet Battles					-- 1 to 4
		61867, 61870, 61866, 61868, 
		-- World Quest					-- 5 to 35
		57205, 59703, 61352, 61353, 
		58605, 61343, 59836, 61342,
		57650, 58207, 61477, 58490,
		61141, 61708, 61667, 61189,
		58221, 61540, 61539, 59234,
		66617, 61841, 61699, 58437,
		58505, 59642, 61060, 60211,
		60231, 59743, 58601,
		-- Callings						-- 36 to 55
		60423, 60426, 62694, 60433,
		60390, 60393, 60398, 60396,
		60459, 60440, 60443, 60445,
		60449, 60416, 60402, 60455,
		60405, 60411, 60408, 60429,
		-- World Boss					-- 56
		61816,	
	}
	Necrolord_WQ_Title = { "|cff4F77FFPet Battle|r", "|cffFFFE22World Quest|r", "|cff22FFF9Callings|r (Inc Last Callings)", "|cffFFAD22World Boss|r  (Mald Only)", }
	
	tinsert(WoWTweakTable,
		( "As of "..date("%I:%M"..(date("%p", time())=="AM" and "a" or "p").." CST", time()).."\n\n" )
	)
	for g, n in pairs(Necrolord_World_Quest) do
		a = C_TaskQuest.IsActive(n)
		c = C_QuestLog.IsQuestFlaggedCompleted(n)
		local Title =
			( g == 1 and Necrolord_WQ_Title[1].."\n" or							-- Pet Battles
				( g == 5 and Necrolord_WQ_Title[2].."\n" or						-- World Quest
					( g == 36 and Necrolord_WQ_Title[3].."\n" or 				-- Callings
						( ( ( C_TaskQuest.IsActive(61816) and g == 56 ) and Necrolord_WQ_Title[4].."\n" ) or "" )		-- World Boss
					)
				)
			)
		
		tinsert(WoWTweakTable,Title)
		if ( a or c ) then
			tinsert(WoWTweakTable,
			--	( (c and ":x: " or ":mag: ").."["..n.."] "..C_QuestLog.GetTitleForQuestID(n)..Extra.."\n" ) -- Verify Quest ID
				(	(c and ":x: " or ":mag: ")..
					( C_QuestLog.GetTitleForQuestID(n) == nil and CheckAPIRepeat(n) or C_QuestLog.GetTitleForQuestID(n) )..
					( ( n == 61343 or n == 59836 or n == 61342 ) and " (Sync)" or "" )..
					"\n"
				)
			)
		end
		tinsert(WoWTweakTable,( ( g == 4 or g == 35 or g == 55 ) and "\n" or "" ) )
	end
	vNWQ_ResultArea:SetText(table.concat(WoWTweakTable,""))
end
------------------------------------------------------------------------
-- Check World Quest for Necrolord (Recheck to prevent NIL if possible)
------------------------------------------------------------------------
function CheckAPIRepeat(n)
	C_Timer.After(1, function()
		if C_QuestLog.GetTitleForQuestID(n) ~= nil then CheckAPIRepeat(n) end
	end)
end
------------------------------------------------------------------------
-- Check Pet Battle World Quest for Venthyr and Place Map Pin fo Mirror Locations
------------------------------------------------------------------------
function CheckMirror_Venthyr()
	
	local m = { 61879, 61883, 61885, 61886, }
	for g, n in pairs(m) do
		a=C_TaskQuest.IsActive(n)
		c=C_QuestLog.IsQuestFlaggedCompleted(n)
		if a or c then
			if g == 1 then
				Ia = { .294, .372, "G1 - Cliff North of Sinfall - Room with Cooking Pot", }
				Ib = { .271, .216, "G1 - Dominance Keep - Room with Elite Spider", }
				Ic = { .404, .733, "G1 - Dredhollow - House with Sleeping Wildlife", }
				Id = "Dominance Keep Mirror"
			end
			if g == 2 then
				Ia = { .390, .521, "G2 - Charred Ramparts - Ground Floor", }
				Ib = { .588, .678, "G2 - Stonevigil Overlook - Corner House next to Feeders' Thicket", }
				Ic = { .709, .436, "G2 - Halls of Atonement - Room with Disciples", }
				Id = "The Banewood Mirror"
			end
			if g == 3 then
				Ia = { .726, .436, "G3 - Halls of Atonement - Crypt with Disciples", }
				Ib = { .403, .771, "G3 - Dredhollow - House with Fighting Wildlife", }
				Ic = { .771, .654, "G3 - Caretaker's Manor - Elite Mobs", }
				Id = "Halls of Atonement Mirror"
			end
			if g == 4 then
				Ia = { .296, .258, "G4 - Dominance Keep - Room with Elite Soulbinder", }
				Ib = { .207, .542, "G4 - The Shrouded Asylum - Entrance of Main Building", }
				Ic = { .551, .356, "G4 - Redelav District - Inside Crypt with Nobles", }
				Id = "Dominance Keep Mirror"
			end
			print("Mirror: \124cff00FE00" .. g .. "\124r - Go to: " .. Id)
			TomTom:AddWaypoint( 1525, Ia[1], Ia[2], { title = Ia[3], persistent = nil, world = true, from = "WoWTweaks", } )
			TomTom:AddWaypoint( 1525, Ib[1], Ib[2], { title = Ib[3], persistent = nil, world = true, from = "WoWTweaks", } )
			TomTom:AddWaypoint( 1525, Ic[1], Ic[2], { title = Ic[3], persistent = nil, world = true, from = "WoWTweaks", } )
		end
	end
end
------------------------------------------------------------------------
-- Place Map Pin for possible/frequent Chest that appears when using Toothpick in Ardenweald & Revendreth
------------------------------------------------------------------------
function MarkTreasures_Necrolord()
	NecroChest = {
		-- Aldrenweld
		{ 1565, .496, .762 }, { 1565, .507, .756 }, { 1565, .508, .732 }, { 1565, .508, .754 }, { 1565, .518, .796 },
		{ 1565, .521, .741 }, { 1565, .521, .773 }, { 1565, .527, .787 }, { 1565, .530, .757 },
		 -- Revendreth
		{ 1525, .415, .674 }, { 1525, .423, .634 }, { 1525, .423, .635 }, { 1525, .433, .669 }, { 1525, .439, .648 },
		{ 1525, .440, .616 }, { 1525, .446, .677 }, { 1525, .458, .641 }, { 1525, .458, .673 },
	}	
	for i = 1, #NecroChest do
		TomTom:AddWaypoint( NecroChest[i][1], NecroChest[i][2], NecroChest[i][3], { title = "Buried Chest", persistent = nil, world = true, from = "WoWTweaks", } )
	end
end
------------------------------------------------------------------------
-- Framing Background/Border
------------------------------------------------------------------------
	local defaultBackdrop = {
		edgeFile = "Interface\\ToolTips\\UI-Tooltip-Border",
		bgFile = "Interface\\BlackMarket\\BlackMarketBackground-Tile",
		tileEdge = true,
		tileSize = 10,
		edgeSize = 14,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	}
-------------------------------------------------------
-- Frame For Necrolord Unity
-------------------------------------------------------
	local vCovChk_Result = CreateFrame("Frame", "vCovChk_Result", UIParent, BackdropTemplateMixin and "BackdropTemplate")
		vCovChk_Result:SetBackdrop(defaultBackdrop)
		vCovChk_Result:SetSize(230, 255)
		vCovChk_Result:ClearAllPoints()
		vCovChk_Result:EnableMouse(true)
		vCovChk_Result:SetMovable(true)
		vCovChk_Result:RegisterForDrag("LeftButton")
		vCovChk_Result:SetScript("OnDragStart", function() vCovChk_Result:StartMoving() end)
		vCovChk_Result:SetScript("OnDragStop", function() vCovChk_Result:StopMovingOrSizing() end)
		vCovChk_Result:SetClampedToScreen(true)
		vCovChk_Result:SetPoint("TOPLEFT", UIParent, 100, -25)
	--Title
	local vCovChk_Title = vCovChk_Result:CreateFontString(nil, "ARTWORK", "GameFontNormalLeftYellow")
		vCovChk_Title:SetPoint("TOP", vCovChk_Result, 0, -8)
		vCovChk_Title:SetText("Necrolord Active WQ")
	-- Close Button
	local vCovChk_CloseButton = CreateFrame("Button", "vCovChk_CloseButton", vCovChk_Result, "UIPanelCloseButton")
		vCovChk_CloseButton:SetSize(22, 22)
		vCovChk_CloseButton:SetPoint("TOPRIGHT", vCovChk_Result, -3, -3)
		vCovChk_CloseButton:SetScript("OnClick", function() vCovChk_Result:Hide() end)	
	-- Necrolord Map Pins
	local vCovChk_Burial_Chest = CreateFrame("Button", "vCovChk_Burial_Chest", vCovChk_Result)
		vCovChk_Burial_Chest:SetSize(18, 18)
		vCovChk_Burial_Chest:SetNormalTexture("Interface\\Worldmap\\UI-World-Icon")
		vCovChk_Burial_Chest:ClearAllPoints()
		vCovChk_Burial_Chest:SetPoint("TOPLEFT", vCovChk_Result, "TOPLEFT", 3, -4)
		vCovChk_Burial_Chest:SetScript("OnClick", function() if IsAddOnLoaded("TomTom") then MarkTreasures_Necrolord() end end)
		vCovChk_Burial_Chest:SetScript("OnEnter", function()
			GameTooltip:ClearLines()
			GameTooltip:Hide()
			GameTooltip:SetOwner(vCovChk_Burial_Chest, "ANCHOR_LEFT")
			local msg = ( IsAddOnLoaded("TomTom") and "" or "Sorry, |CFFFF0000Disabled/Missing|r,\nNeed TomTom for WP to work\n\n" )
			GameTooltip:AddLine(msg.."Post Map Pin\n\nFor Ardenweald and\nRevendreth to find\nBurial Chest for your\nNecrolord Adbom Factory",1,1,1,1)
			GameTooltip:Show()
		end)
		vCovChk_Burial_Chest:SetScript("OnLeave", function()
			GameTooltip:ClearLines()
			GameTooltip:Hide()
		end)
	-- Scrollable Editbox
	local vCovChk_ResultScroll = CreateFrame("ScrollFrame", "vCovChk_ResultScroll", vCovChk_Result, "UIPanelScrollFrameTemplate")
		vCovChk_ResultScroll:SetPoint("TOPLEFT", vCovChk_Result, 7, -28)
		vCovChk_ResultScroll:SetWidth(vCovChk_Result:GetWidth()-35)
		vCovChk_ResultScroll:SetHeight(vCovChk_Result:GetHeight()-32)
			vCovChk_ResultArea = CreateFrame("EditBox", "vCovChk_ResultArea", vCovChk_ResultScroll)
			vCovChk_ResultArea:SetWidth(vCovChk_ResultScroll:GetWidth())
			vCovChk_ResultArea:SetFontObject(GameFontNormalSmall)
			vCovChk_ResultArea:SetAutoFocus(false)
			vCovChk_ResultArea:SetMultiLine(true)
			vCovChk_ResultArea:EnableMouse(true)
			vCovChk_ResultArea:SetScript("OnEditFocusGained", function() vCovChk_ResultArea:HighlightText() end)
			vCovChk_ResultArea:SetText("")
		vCovChk_ResultScroll:SetScrollChild(vCovChk_ResultArea)
		vCovChk_Result:Hide()

	-- Middle of Parent UI for Button
	local vCovChk_Frame = CreateFrame("Frame", "vCovChk_Frame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
		vCovChk_Frame:SetBackdrop(defaultBackdrop)
		vCovChk_Frame:ClearAllPoints()
		vCovChk_Frame:SetSize(50, 50)
		vCovChk_Frame:SetPoint("CENTER", UIParent, "CENTER")
		vCovChk_Frame:EnableMouse(true)
		vCovChk_Frame:SetMovable(true)
		vCovChk_Frame:RegisterForDrag("LeftButton")
		vCovChk_Frame:SetScript("OnDragStart", function() vCovChk_Frame:StartMoving() end)
		vCovChk_Frame:SetScript("OnDragStop", function() vCovChk_Frame:StopMovingOrSizing() end)
		vCovChk_Frame:SetClampedToScreen(true)
	-- Button for Rev and Nec ONLY
	local vCovChk_Button = CreateFrame("Button", "vCovChk_Button", vCovChk_Frame)
		vCovChk_Button:SetScript("OnClick", function()
			if C_Covenants.GetActiveCovenantID() == 2 then
				if IsAddOnLoaded("TomTom") then
					CheckMirror_Venthyr()
				else
					print("Sorry, |CFFFF5656Missing|r TomTom, it's needed for WP to work")
				end
			end
			if C_Covenants.GetActiveCovenantID() == 4 then
				if vCovChk_Result:IsVisible() then vCovChk_Result:Hide() else vCovChk_Result:Show() end
				if vCovChk_Result:IsVisible() then Necrolord_WQ_List() end
			end
		end)
		vCovChk_Button:SetScript("OnEnter", function()
			GameTooltip:ClearLines()
			GameTooltip:Hide()
			GameTooltip:SetOwner(vCovChk_Frame, "ANCHOR_LEFT")
			GameTooltip:AddLine(vCovChk_AppTitle,1,1,1,1)
			GameTooltip:Show()
		end)
		vCovChk_Button:SetScript("OnLeave", function()
			GameTooltip:ClearLines()
			GameTooltip:Hide()
		end)

-------------------------------------------------------
-- OnEvent
-------------------------------------------------------
local vCovCheck = CreateFrame("Frame")
	vCovCheck:RegisterEvent("ADDON_LOADED")
	vCovCheck:SetScript("OnEvent", function(self, event, ...)
	-------------------------------------------------------
	-- ADDON_LOADED EVENT
	-------------------------------------------------------
		if ( event == "ADDON_LOADED" ) then
			local TheEvents = { "PLAYER_LOGIN", "CHALLENGE_MODE_MAPS_UPDATE", "QUEST_LOG_UPDATE", "QUEST_WATCH_LIST_CHANGED", }
			for ev = 1, #TheEvents do
				vCovCheck:RegisterEvent(TheEvents[ev])
			end
			vCovCheck:UnregisterEvent("ADDON_LOADED")
		end
	-------------------------------------------------------
	-- PLAYER_LOGIN EVENT
	-------------------------------------------------------	
	if ( event == "PLAYER_LOGIN" ) then
		if (C_Covenants.GetActiveCovenantID() == 2 or C_Covenants.GetActiveCovenantID() == 4 ) then
			-------------------------------------------------------
			-- 1 Kyrian, 2 Venthyr, 3 NightFae, 4 Necrolord
			-- Left, Width, Height
			-------------------------------------------------------
			local cID = C_Covenants.GetActiveCovenantID()
			if (cID == 0 or cID == nil) then
				l, r, t, b, wS, hS = 434, 540, 372, 475, 92, 89
			else
				l, r, t, b, wS, hS = CovPic[cID][1], CovPic[cID][1]+CovPic[cID][2], 362, CovPic[cID][3]+362, CovPic[cID][2], CovPic[cID][3]
			end
			vCovChk_Button:SetSize(wS*.35,hS*.35)
			vCovChk_Button:SetPoint("CENTER", vCovChk_Frame, "CENTER", ((cID == 0 or cID == nil) and 3 or 2), ((cID == 0 or cID == nil) and -3 or -2))
			vCovChk_Button:SetNormalTexture("interface\\covenantchoice\\covenantchoicecelebration")
			vCovChk_Button:GetNormalTexture():SetTexCoord(l/w, r/w, t/h, b/h)
			vCovChk_Frame:Show()
		else
			vCovChk_Frame:Hide()
	end
		vCovCheck:UnregisterEvent("PLAYER_LOGIN")
	end
	-------------------------------------------------------
	-- QUEST_LOG_UPDATE EVENT
	-------------------------------------------------------
		if ( event == "QUEST_LOG_UPDATE" or event == "CHALLENGE_MODE_MAPS_UPDATE" or event == "QUEST_WATCH_LIST_CHANGED" ) then
			if ( C_Covenants.GetActiveCovenantID() == 4 and vCovChk_Result:IsVisible() ) then
				Necrolord_WQ_List()
			end
		end
end)