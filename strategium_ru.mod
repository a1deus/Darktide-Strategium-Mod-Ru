return {
	run = function()
		fassert(rawget(_G, "new_mod"), "strategium_ru requires the Darktide Mod Framework.")

		new_mod("strategium_ru", {
			mod_script = "strategium_ru/scripts/mods/strategium_ru/strategium_ru",
		})
	end,
	packages = {},
}
