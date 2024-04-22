/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _patrol_extended.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 67 ms
 * Timestamp: 4/22/2024 2:22:06 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\_flashlight_cheap::cheap_flashlight_init();
	maps\_patrol_anims_creepwalk::main();
	maps\_patrol_anims_patroljog::main();
	maps\_patrol_anims_active::main();
	maps\_patrol_anims_casualkiller::main();
	maps\_patrol_anims::main();
	extended_idle_anims();
}

//Function Number: 2
force_patrol_anim_set(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	self.patrol_walk_twitch = undefined;
	self.patrol_walk_anim = undefined;
	self.script_animation = param_00;
	if(param_02)
	{
		maps\_patrol::patrol();
	}

	maps\_patrol::set_patrol_run_anim_array();
	self.goalradius = 32;
	self allowedstances("stand");
	self.disablearrivals = 1;
	self.disableexits = 1;
	self.allowdeath = 1;
	maps\_utility::disable_cqbwalk();
	self.patrol_anim_set = param_00;
	if(isdefined(param_01) && param_01)
	{
		self.enable_flashlight_callback = ::maps\_flashlight_cheap::add_cheap_flashlight;
		maps\_flashlight_cheap::add_cheap_flashlight("flashlight",undefined,param_03);
	}
}

//Function Number: 3
extended_idle_anims()
{
	maps\_idle::idle_main();
	level.idle_animation_list_func = ::_extended_patrol_idle_animation_list_func;
	level.scr_anim["generic"]["flashlight_high_idle"][0] = %so_hijack_search_flashlight_high_loop;
	level.scr_anim["generic"]["flashlight_high_react"] = %so_hijack_search_flashlight_high_reaction;
	level.scr_anim["generic"]["flashlight_low_idle"][0] = %so_hijack_search_flashlight_low_loop;
	level.scr_anim["generic"]["flashlight_low_react"] = %so_hijack_search_flashlight_low_reaction;
	level.scr_anim["generic"]["flashlight_high2_into_idle"] = %patrol_flashlight_high_stop;
	level.scr_anim["generic"]["flashlight_high2_idle"][0] = %patrol_flashlight_high_idle_v1;
	level.scr_anim["generic"]["flashlight_high2_react"] = %patrol_flashlight_high_putaway;
	maps\_anim::addnotetrack_customfunction("generic","flashlight_hide",::maps\_flashlight_cheap::cheap_flashlight_hide,"flashlight_high2_react");
	level.scr_anim["generic"]["flashlight_high2_takeout"] = %patrol_flashlight_high_takeout;
	maps\_anim::addnotetrack_customfunction("generic","flashlight_show",::maps\_flashlight_cheap::cheap_flashlight_show,"flashlight_high2_takeout");
}

//Function Number: 4
_extended_patrol_idle_animation_list_func(param_00)
{
	param_00[param_00.size] = "flashlight_high";
	param_00[param_00.size] = "flashlight_low";
	param_00[param_00.size] = "flashlight_high2";
	return param_00;
}