/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createfx\mp_vlobby_room_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 27 ms
 * Timestamp: 4/22/2024 2:07:51 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = common_scripts\utility::createoneshoteffect("vlobby_steam");
	var_00 common_scripts\_createfx::set_origin_and_angles((507.68,13.4615,423.188),(270,0,0));
	var_00.v["fxid"] = "vlobby_steam";
	var_00.v["delay"] = -15;
	var_00 = common_scripts\utility::createoneshoteffect("vlobby_steam");
	var_00 common_scripts\_createfx::set_origin_and_angles((231.703,276.411,413.934),(270,0,0));
	var_00.v["fxid"] = "vlobby_steam";
	var_00.v["delay"] = -15;
	var_00 = common_scripts\utility::createoneshoteffect("vlobby_steam");
	var_00 common_scripts\_createfx::set_origin_and_angles((2.44485,268.129,374.212),(270,0,0));
	var_00.v["fxid"] = "vlobby_steam";
	var_00.v["delay"] = -15;
	var_00 = common_scripts\utility::createoneshoteffect("vlobby_steam");
	var_00 common_scripts\_createfx::set_origin_and_angles((-226.166,298.461,367.155),(270,0,0));
	var_00.v["fxid"] = "vlobby_steam";
	var_00.v["delay"] = -15;
	var_00 = common_scripts\utility::createoneshoteffect("vlobby_steam");
	var_00 common_scripts\_createfx::set_origin_and_angles((-496.045,-13.0039,417.704),(270,0,0));
	var_00.v["fxid"] = "vlobby_steam";
	var_00.v["delay"] = -15;
	var_00 = common_scripts\utility::createoneshoteffect("vlobby_dust");
	var_00 common_scripts\_createfx::set_origin_and_angles((18.5216,-378.813,457.625),(270,0,0));
	var_00.v["fxid"] = "vlobby_dust";
	var_00.v["delay"] = -15;
}