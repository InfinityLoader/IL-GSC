/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1568.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 2:21:16 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	var_03 = "mi17";
	if(isdefined(param_01) && param_01 == "mi17_so")
	{
		var_03 = "mi17_so";
	}
	else if(isdefined(param_01) && param_01 == "mi17_so_takes_damage")
	{
		var_03 = "mi17_so_takes_damage";
	}

	lib_061D::main(param_00,var_03,param_02);
	maps\_vehicle::build_drive(%mi17_heli_rotors,undefined,0);
	maps\_vehicle::build_deathmodel("vehicle_mi17_woodland");
	maps\_vehicle::build_deathmodel("vehicle_mi17_woodland_fly");
	maps\_vehicle::build_deathmodel("vehicle_mi17_woodland_landing");
	maps\_vehicle::build_deathmodel("vehicle_mi17_woodland_fly_cheap");
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_treadfx();
	maps\_vehicle::build_aianims(::func_3A9D,::func_3A9C);
	maps\_vehicle::build_attach_models(::func_3E84);
	maps\_vehicle::build_unload_groups(::func_3E58);
}

//Function Number: 2
init_local()
{
	if(maps\_utility::is_iw4_map_sp())
	{
		self.originheightoffset = distance(self gettagorigin("tag_origin"),self gettagorigin("tag_ground"));
		self.fastropeoffset = 710;
	}
	else
	{
		self.fastropeoffset = 710 + distance(self gettagorigin("tag_origin"),self gettagorigin("tag_ground"));
	}

	self.script_badplace = 0;
	maps\_vehicle::lights_on("running");
}

//Function Number: 3
func_3A9C(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		param_00[var_01].vehicle_getoutanim = %mi17_heli_idle;
	}

	return param_00;
}

//Function Number: 4
func_3E83(param_00)
{
	return param_00;
}

//Function Number: 5
func_3A9D()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 10;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[1].idle = %mi17_1_idle;
	var_00[2].idle = %mi17_2_idle;
	var_00[3].idle = %mi17_3_idle;
	var_00[4].idle = %mi17_4_idle;
	var_00[5].idle = %mi17_5_idle;
	var_00[6].idle = %mi17_6_idle;
	var_00[7].idle = %mi17_7_idle;
	var_00[8].idle = %mi17_8_idle;
	var_00[0].idle[0] = %helicopter_pilot1_idle;
	var_00[0].idle[1] = %helicopter_pilot1_twitch_clickpannel;
	var_00[0].idle[2] = %helicopter_pilot1_twitch_lookback;
	var_00[0].idle[3] = %helicopter_pilot1_twitch_lookoutside;
	var_00[0].idleoccurrence[0] = 500;
	var_00[0].idleoccurrence[1] = 100;
	var_00[0].idleoccurrence[2] = 100;
	var_00[0].idleoccurrence[3] = 100;
	var_00[0].bhasgunwhileriding = 0;
	var_00[9].bhasgunwhileriding = 0;
	var_00[9].idle[0] = %helicopter_pilot2_idle;
	var_00[9].idle[1] = %helicopter_pilot2_twitch_clickpannel;
	var_00[9].idle[2] = %helicopter_pilot2_twitch_lookoutside;
	var_00[9].idle[3] = %helicopter_pilot2_twitch_radio;
	var_00[9].idleoccurrence[0] = 450;
	var_00[9].idleoccurrence[1] = 100;
	var_00[9].idleoccurrence[2] = 100;
	var_00[9].idleoccurrence[3] = 100;
	var_00[0].sittag = "tag_driver";
	var_00[1].sittag = "tag_detach";
	var_00[2].sittag = "tag_detach";
	var_00[3].sittag = "tag_detach";
	var_00[4].sittag = "tag_detach";
	var_00[5].sittag = "tag_detach";
	var_00[6].sittag = "tag_detach";
	var_00[7].sittag = "tag_detach";
	var_00[8].sittag = "tag_detach";
	var_00[9].sittag = "tag_passenger";
	var_00[1].getout = %mi17_1_drop;
	var_00[2].getout = %mi17_2_drop;
	var_00[3].getout = %mi17_3_drop;
	var_00[4].getout = %mi17_4_drop;
	var_00[5].getout = %mi17_5_drop;
	var_00[6].getout = %mi17_6_drop;
	var_00[7].getout = %mi17_7_drop;
	var_00[8].getout = %mi17_8_drop;
	var_00[1].getoutstance = "crouch";
	var_00[2].getoutstance = "crouch";
	var_00[3].getoutstance = "crouch";
	var_00[4].getoutstance = "crouch";
	var_00[5].getoutstance = "crouch";
	var_00[6].getoutstance = "crouch";
	var_00[7].getoutstance = "crouch";
	var_00[8].getoutstance = "crouch";
	var_00[2].ragdoll_getout_death = 1;
	var_00[3].ragdoll_getout_death = 1;
	var_00[4].ragdoll_getout_death = 1;
	var_00[5].ragdoll_getout_death = 1;
	var_00[6].ragdoll_getout_death = 1;
	var_00[7].ragdoll_getout_death = 1;
	var_00[8].ragdoll_getout_death = 1;
	var_00[2].ragdoll_fall_anim = %fastrope_fall;
	var_00[3].ragdoll_fall_anim = %fastrope_fall;
	var_00[4].ragdoll_fall_anim = %fastrope_fall;
	var_00[5].ragdoll_fall_anim = %fastrope_fall;
	var_00[6].ragdoll_fall_anim = %fastrope_fall;
	var_00[7].ragdoll_fall_anim = %fastrope_fall;
	var_00[8].ragdoll_fall_anim = %fastrope_fall;
	var_00[1].rappel_kill_achievement = 1;
	var_00[2].rappel_kill_achievement = 1;
	var_00[3].rappel_kill_achievement = 1;
	var_00[4].rappel_kill_achievement = 1;
	var_00[5].rappel_kill_achievement = 1;
	var_00[6].rappel_kill_achievement = 1;
	var_00[7].rappel_kill_achievement = 1;
	var_00[8].rappel_kill_achievement = 1;
	var_00[1].getoutloopsnd = "fastrope_loop_npc";
	var_00[2].getoutloopsnd = "fastrope_loop_npc";
	var_00[3].getoutloopsnd = "fastrope_loop_npc";
	var_00[4].getoutloopsnd = "fastrope_loop_npc";
	var_00[5].getoutloopsnd = "fastrope_loop_npc";
	var_00[6].getoutloopsnd = "fastrope_loop_npc";
	var_00[7].getoutloopsnd = "fastrope_loop_npc";
	var_00[8].getoutloopsnd = "fastrope_loop_npc";
	var_00[1].fastroperig = "TAG_FastRope_RI";
	var_00[2].fastroperig = "TAG_FastRope_RI";
	var_00[3].fastroperig = "TAG_FastRope_RI";
	var_00[4].fastroperig = "TAG_FastRope_RI";
	var_00[5].fastroperig = "TAG_FastRope_LE";
	var_00[6].fastroperig = "TAG_FastRope_LE";
	var_00[7].fastroperig = "TAG_FastRope_LE";
	var_00[8].fastroperig = "TAG_FastRope_LE";
	return func_3E83(var_00);
}

//Function Number: 6
func_3E58()
{
	var_00 = [];
	var_1C["back"] = var_7B["back"].size;
	var_1C["back"] = var_1C["back"].size;
	var_1C["back"] = var_1C["back"].size;
	var_1C["back"] = var_1C["back"].size;
	var_1C["front"] = var_1C["front"].size;
	var_1C["front"] = var_1C["front"].size;
	var_1C["front"] = var_1C["front"].size;
	var_1C["front"] = var_1C["front"].size;
	var_1C["both"] = var_1C["both"].size;
	var_1C["both"] = var_1C["both"].size;
	var_1C["both"] = var_1C["both"].size;
	var_1C["both"] = var_1C["both"].size;
	var_1C["both"] = var_1C["both"].size;
	var_1C["both"] = var_1C["both"].size;
	var_1C["both"] = var_1C["both"].size;
	var_1C["both"] = var_1C["both"].size;
	return var_1C;
}

//Function Number: 7
func_3E84()
{
	var_00 = [];
	var_7B["TAG_FastRope_LE"].model = "rope_test";
	var_7B["TAG_FastRope_LE"].tag = "TAG_FastRope_LE";
	var_7B["TAG_FastRope_LE"].idleanim = %mi17_rope_idle_le;
	var_7B["TAG_FastRope_LE"].dropanim = %mi17_rope_drop_le;
	var_7B["TAG_FastRope_RI"].model = "rope_test_ri";
	var_7B["TAG_FastRope_RI"].tag = "TAG_FastRope_RI";
	var_7B["TAG_FastRope_RI"].idleanim = %mi17_rope_idle_ri;
	var_7B["TAG_FastRope_RI"].dropanim = %mi17_rope_drop_ri;
	var_01 = getarraykeys(var_7B);
	for(var_02 = 0;var_02 < var_01.size;var_02++ = var_7B["TAG_FastRope_RI"])
	{
		precachemodel(var_7B[var_01[var_02]].model);
	}

	return var_7B;
}