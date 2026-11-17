local mod = get_mod("strategium_ru")
local dmf = get_mod("DMF")
local target = "strategium"

if Application.user_setting("language_id") ~= "ru" then
	return
end

if get_mod(target) then
	mod:warning("Load strategium_ru before strategium in mod_load_order.txt.")
	return
end

local strings = mod:io_dofile("strategium_ru/scripts/mods/strategium_ru/strings")

local function format_signature(value)
	local signature = {}

	for token in value:gmatch("%%[%-+ #0]*%d*%.?%d*[%%cdiouxXeEfgGqs]") do
		signature[#signature + 1] = token:sub(-1)
	end

	return table.concat(signature)
end

local function merge_translations(localization, translations)
	if type(localization) ~= "table" then
		return
	end

	for id, russian in pairs(translations) do
		local entry = localization[id]

		if type(entry) == "table" and entry.ru == nil and type(entry.en) == "string"
			and format_signature(entry.en) == format_signature(russian) then
			entry.ru = russian
		end
	end
end

mod:hook(dmf, "initialize_mod_localization", function (original, owner, localization)
	if owner:get_name() == target then
		merge_translations(localization, strings.mod)
	end

	return original(owner, localization)
end)

mod:hook(DMFMod, "add_global_localize_strings", function (original, owner, localization)
	if owner:get_name() == target then
		merge_translations(localization, strings.global)
	end

	return original(owner, localization)
end)
