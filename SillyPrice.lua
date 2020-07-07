SillyPrice = {}
SillyPrice.items = {}
SillyPrice.items = spDkp
SillyPrice.frame = CreateFrame("Frame","ItemSillyPriceFrame")

SillyPrice.frame:RegisterEvent("ADDON_LOADED")

SillyPrice.frame:SetScript("OnEvent", function(self, event, arg1, ...)
	--print(arg1)
	if event == "ADDON_LOADED" and arg1 == "SillyPrice" then
		--print("SillyPrice")
	end
end)

local find = string.find
local format = string.format

local function GameTooltip_OnTooltipSetItem(tooltip)
	local itemName, itemLink = tooltip:GetItem()

	if
		not itemName or
		not itemLink
	then
		return
	end

	local _, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId,
		  linkLevel, specializationID, reforgeId, unknown1, unknown2 = strsplit(":", itemLink)
	itemId = tonumber(itemId)

	-- https://wow.gamepedia.com/API_GetItemInfo
	local 	itemName, itemLink, itemRarity, itemLevel,
			itemMinLevel, itemType, itemSubType, itemStackCount,
			itemEquipLoc, itemIcon, itemSellPrice, itemClassID,
			itemSubClassID, bindType, expacID, itemSetID,
			isCraftingReagent = GetItemInfo(itemLink)

	--print(itemType)
	--print(itemId)

	-- https://wow.gamepedia.com/ItemType
	if
		itemClassID ~= LE_ITEM_CLASS_WEAPON and
		itemClassID ~= LE_ITEM_CLASS_ARMOR and
		itemClassID ~= LE_ITEM_CLASS_MISCELLANEOUS
	then
		return
	end

	--for itemSet, note in pairs(itemSets) do
		--if find(itemName, format("^%s", itemSet)) then
			--tooltip:AddLine(note)
		--end
	--end

	if SillyPrice.items == nil then
		tooltip:AddLine("error-idiot-lol")
	else
		if SillyPrice.items[itemId] then
			--tooltip:AddLine(SillyPrice.items[itemId][1]["name"])
			--tooltip:AddLine(SillyPrice.items[itemId][1]["value"])
			--tooltip:AddLine(table.getn(SillyPrice.items[itemId]))

			local t = SillyPrice.items[itemId]

			tooltip:AddLine(" ")
			tooltip:AddLine("|cFF00FF00---------- SillyWalks LootListe ----------|r")
			
			for p=1,table.getn(t) do
				local row = t[p]
				
				local value = "|cFFA330C9" ..  row["value"] .. "|r"
				
				tooltip:AddLine("LootPrio: " .. row["role"])
				tooltip:AddLine("DKP: ".. value)
				if row["note"] ~= "" then
					tooltip:AddLine("Notiz: " .. row["note"])
				end
				--tooltip:AddLine(row["name"])
				--tooltip:AddLine(row["value"])
				--tooltip:AddLine(row["note"])
			end
			tooltip:AddLine("|cFF00FF00---------------------------------------------|r")
			tooltip:AddLine(" ")
		end
	end
end

GameTooltip:HookScript("OnTooltipSetItem", GameTooltip_OnTooltipSetItem)
