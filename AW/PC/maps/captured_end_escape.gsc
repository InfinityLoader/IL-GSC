/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: captured_end_escape.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 131 ms
 * Timestamp: 4/22/2024 2:26:10 AM
*******************************************************************/

//Function Number: 1
pre_load()
{
	precachemodel("vehicle_mil_v32_razorback");
	if(level.currentgen)
	{
		precachemodel("vehicle_mil_cargo_truck_captured_cghi_ai");
	}
}

//Function Number: 2
post_load()
{
}

//Function Number: 3
start(param_00,param_01)
{
	setsaveddvar("g_friendlyNameDist",0);
	level.player maps\captured_util::warp_to_start(param_00);
	level.allies maps\captured_util::warp_allies(param_01,1);
	level._exit.final_player_rig = maps\_utility::spawn_anim_model("player_rig");
	level._exit.final_player_rig hide();
}

//Function Number: 4
main_end_escape()
{
	if(maps\captured_util::start_point_is_before("end_escape"))
	{
		maps\_playermech_code::playermech_end();
	}

	if(!isalive(level.allies[1]))
	{
		var_00 = getent("ally_1","targetname");
		var_00.count = 1;
		var_01 = var_00 maps\_utility::spawn_ai(1);
		var_01 maps\captured_util::ignore_everything();
		var_01.animname = "ally_1";
		level.allies = common_scripts\utility::array_add(level.allies,var_01);
	}

	common_scripts\utility::array_thread(level.allies,::maps\_utility::gun_remove);
	var_02 = common_scripts\utility::getstructarray("ee_rpg_start","targetname");
	var_03 = maps\_utility::spawn_anim_model("exit_truck");
	var_04 = level._exit.final_player_rig;
	var_05 = [var_04,var_03,level.allies[0],level.allies[1]];
	for(var_06 = 0;var_06 < 7;var_06++)
	{
		var_05 = common_scripts\utility::array_add(var_05,maps\_utility::spawn_anim_model("exit_helo_" + maps\_utility::string(var_06),level.player.origin));
	}

	level.player freezecontrols(1);
	level.player allowstand(1);
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player allowjump(0);
	level.player allowsprint(0);
	level.player allowmelee(0);
	level.player disableweapons();
	level.player showviewmodel();
	level notify("truck_dof");
	common_scripts\utility::array_thread(common_scripts\utility::getstructarray("ee_rpg_end","targetname"),::ee_rpg_fire,var_02);
	thread maps\captured_fx::fx_end_amb_fx();
	level.player common_scripts\utility::delaycall(1.15,::playrumbleonentity,"light_1s");
	level.player common_scripts\utility::delaycall(9.75,::playrumbleonentity,"light_1s");
	level.player common_scripts\utility::delaycall(10.2,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(11,::playrumbleonentity,"heavy_3s");
	level.player common_scripts\utility::delaycall(32.5,::playrumbleonentity,"light_2s");
	level.player playerlinktodelta(var_04,"tag_player",1,0,0,0,0,1);
	var_04 show();
	level._exit.node maps\_anim::anim_single(var_05,"end_escape");
	common_scripts\utility::flag_set("flag_end_escape_end");
}

//Function Number: 5
ee_rpg_fire(param_00)
{
	var_01 = common_scripts\utility::getclosest(self.origin,param_00);
	wait(self.script_wait);
	magicbullet("iw5_mahemcaptured",var_01.origin,self.origin);
}

//Function Number: 6
end_fade_to_black(param_00)
{
	wait(0.5);
	var_01 = maps\_hud_util::create_client_overlay("black",0,level.player);
	var_01 fadeovertime(2);
	var_01.alpha = 1;
}

//Function Number: 7
end_change_fov(param_00)
{
	level.player lerpfov(50,3);
}