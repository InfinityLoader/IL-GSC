/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_escortairdrop.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 2024 ms
 * Timestamp: 10/27/2023 12:28:32 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_C73F = [];
	level.var_C73F["escort_airdrop"] = spawnstruct();
	level.var_C73F["escort_airdrop"].var_131A0 = "osprey_mp";
	level.var_C73F["escort_airdrop"].var_B91A = "vehicle_v22_osprey_body_mp";
	level.var_C73F["escort_airdrop"].var_B91B = "vehicle_v22_osprey_blades_mp";
	level.var_C73F["escort_airdrop"].var_11415 = "tag_le_door_attach";
	level.var_C73F["escort_airdrop"].var_11416 = "tag_ri_door_attach";
	level.var_C73F["escort_airdrop"].var_113F0 = "tag_turret_attach";
	level.var_C73F["escort_airdrop"].var_DA71 = &"KILLSTREAKS_DEFEND_AIRDROP_PACKAGES";
	level.var_C73F["escort_airdrop"].name = &"KILLSTREAKS_ESCORT_AIRDROP";
	level.var_C73F["escort_airdrop"].var_39B = "osprey_minigun_mp";
	level.var_C73F["escort_airdrop"].var_8DD9 = "osprey";
	level.var_C73F["escort_airdrop"].var_5EF1 = "airdrop_escort";
	level.var_C73F["escort_airdrop"].maxhealth = level.var_8D73 * 2;
	level.var_C73F["escort_airdrop"].var_11901 = 60;
	level.var_C73F["osprey_gunner"] = spawnstruct();
	level.var_C73F["osprey_gunner"].var_131A0 = "osprey_player_mp";
	level.var_C73F["osprey_gunner"].var_B91A = "vehicle_v22_osprey_body_mp";
	level.var_C73F["osprey_gunner"].var_B91B = "vehicle_v22_osprey_blades_mp";
	level.var_C73F["osprey_gunner"].var_11415 = "tag_le_door_attach";
	level.var_C73F["osprey_gunner"].var_11416 = "tag_ri_door_attach";
	level.var_C73F["osprey_gunner"].var_113F0 = "tag_turret_attach";
	level.var_C73F["osprey_gunner"].var_DA71 = &"KILLSTREAKS_DEFEND_AIRDROP_PACKAGES";
	level.var_C73F["osprey_gunner"].name = &"KILLSTREAKS_OSPREY_GUNNER";
	level.var_C73F["osprey_gunner"].var_39B = "osprey_player_minigun_mp";
	level.var_C73F["osprey_gunner"].var_8DD9 = "osprey_gunner";
	level.var_C73F["osprey_gunner"].var_5EF1 = "airdrop_osprey_gunner";
	level.var_C73F["osprey_gunner"].maxhealth = level.var_8D73 * 2;
	level.var_C73F["osprey_gunner"].var_11901 = 75;
	foreach(var_01 in level.var_C73F)
	{
		level.var_3F19["explode"]["death"][var_01.var_B91A] = loadfx("vfx/core/expl/helicopter_explosion_osprey");
		level.var_3F19["explode"]["air_death"][var_01.var_B91A] = loadfx("vfx/core/expl/helicopter_explosion_osprey_air_mp");
		level.var_3F19["anim"]["blades_anim_up"][var_01.var_B91A] = loadfx("vfx/props/osprey_blades_anim_up");
		level.var_3F19["anim"]["blades_anim_down"][var_01.var_B91A] = loadfx("vfx/props/osprey_blades_anim_down");
		level.var_3F19["anim"]["blades_static_up"][var_01.var_B91A] = loadfx("vfx/props/osprey_blades_up");
		level.var_3F19["anim"]["blades_static_down"][var_01.var_B91A] = loadfx("vfx/props/osprey_blades_default");
		level.var_3F19["anim"]["hatch_left_static_up"][var_01.var_B91A] = loadfx("vfx/props/osprey_bottom_door_left_default");
		level.var_3F19["anim"]["hatch_left_anim_down"][var_01.var_B91A] = loadfx("vfx/props/osprey_bottom_door_left_anim_open");
		level.var_3F19["anim"]["hatch_left_static_down"][var_01.var_B91A] = loadfx("vfx/props/osprey_bottom_door_left_up");
		level.var_3F19["anim"]["hatch_left_anim_up"][var_01.var_B91A] = loadfx("vfx/props/osprey_bottom_door_left_anim_close");
		level.var_3F19["anim"]["hatch_right_static_up"][var_01.var_B91A] = loadfx("vfx/props/osprey_bottom_door_right_default");
		level.var_3F19["anim"]["hatch_right_anim_down"][var_01.var_B91A] = loadfx("vfx/props/osprey_bottom_door_right_anim_open");
		level.var_3F19["anim"]["hatch_right_static_down"][var_01.var_B91A] = loadfx("vfx/props/osprey_bottom_door_right_up");
		level.var_3F19["anim"]["hatch_right_anim_up"][var_01.var_B91A] = loadfx("vfx/props/osprey_bottom_door_right_anim_close");
	}

	level.var_1A6F = [];
	scripts\mp\killstreaks\_killstreaks::func_DEFB("escort_airdrop",::func_128E4);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("osprey_gunner",::func_128F3);
}

//Function Number: 2
func_128E4(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(level.var_3F14))
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA + var_02 >= scripts\mp\_utility::func_B4D2())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	if(scripts\mp\_utility::func_9E68())
	{
		return 0;
	}

	scripts\mp\_utility::func_93FA();
	return 1;
}

//Function Number: 3
func_128F3(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(level.var_3F14))
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA + var_02 >= scripts\mp\_utility::func_B4D2())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	scripts\mp\_utility::func_93FA();
	var_04 = func_F1AD(param_00,"osprey_gunner","compass_objpoint_osprey_friendly","compass_objpoint_osprey_enemy",&"KILLSTREAKS_SELECT_MOBILE_MORTAR_LOCATION");
	if(!isdefined(var_04) || !var_04)
	{
		scripts\mp\_utility::func_4FC1();
		return 0;
	}

	scripts\mp\_matchdata::func_AFC9("osprey_gunner",self.origin);
	return 1;
}

//Function Number: 4
func_6CE4(param_00,param_01,param_02,param_03)
{
	self notify("used");
	var_04 = (0,param_02,0);
	var_05 = 12000;
	var_06 = getent("airstrikeheight","targetname");
	var_07 = var_06.origin[2];
	var_08 = level.var_8D96[randomint(level.var_8D96.size)];
	var_09 = var_08.origin;
	var_0A = (param_01[0],param_01[1],var_07);
	var_0B = param_01 + anglestoforward(var_04) * var_05;
	var_0C = vectortoangles(var_0A - var_09);
	var_0D = param_01;
	param_01 = (param_01[0],param_01[1],var_07);
	var_0E = func_4983(self,param_00,var_09,var_0C,param_01,param_03);
	var_09 = var_08;
	func_130E3(param_00,var_0E,var_09,var_0A,var_0B,var_07,var_0D);
}

//Function Number: 5
func_6CDF(param_00,param_01,param_02,param_03)
{
	self notify("used");
	var_04 = (0,param_02,0);
	var_05 = 12000;
	var_06 = getent("airstrikeheight","targetname");
	var_07 = var_06.origin[2];
	var_08 = level.var_8D96[randomint(level.var_8D96.size)];
	var_09 = var_08.origin;
	var_0A = (param_01[0],param_01[1],var_07);
	var_0B = param_01 + anglestoforward(var_04) * var_05;
	var_0C = vectortoangles(var_0A - var_09);
	param_01 = (param_01[0],param_01[1],var_07);
	var_0D = func_4983(self,param_00,var_09,var_0C,param_01,param_03);
	var_09 = var_08;
	func_130B6(param_00,var_0D,var_09,var_0A,var_0B,var_07);
}

//Function Number: 6
func_11089()
{
	self waittill("stop_location_selection",var_00);
	switch(var_00)
	{
		case "emp":
		case "weapon_change":
		case "cancel_location":
		case "disconnect":
		case "death":
			self notify("customCancelLocation");
			break;
	}
}

//Function Number: 7
func_F1AD(param_00,param_01,param_02,param_03,param_04)
{
	self endon("customCancelLocation");
	var_05 = undefined;
	var_06 = level.var_B339 / 6.46875;
	if(level.splitscreen)
	{
		var_06 = var_06 * 1.5;
	}

	scripts\mp\_utility::func_1197(param_01,"map_artillery_selector",0,500);
	thread func_11089();
	self waittill("confirm_location",var_07,var_08);
	scripts\mp\_utility::stoplocationselection(0);
	scripts\mp\_utility::func_FB09(param_01);
	var_09 = scripts\mp\killstreaks\_killstreaks::func_98C2(param_01);
	if(var_09 != "success")
	{
		if(var_09 != "disconnect")
		{
			scripts\mp\_utility::func_41E9();
		}

		return 0;
	}

	if(isdefined(level.var_3F14))
	{
		scripts\mp\_utility::func_41E9();
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA >= scripts\mp\_utility::func_B4D2())
	{
		scripts\mp\_utility::func_41E9();
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	thread func_6CDF(param_00,var_07,var_08,param_01);
	return 1;
}

//Function Number: 8
func_1012E(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\mp\_hud_util::createfontstring("bigfixed",0.5);
	var_04 scripts\mp\_hud_util::setpoint("CENTER","CENTER",0,-150);
	var_04 settext(param_02);
	self.var_AECD = [];
	for(var_05 = 0;var_05 < param_03;var_05++)
	{
		self.var_AECD[var_05] = scripts\mp\objidpoolmanager::requestminimapid(1);
		if(self.var_AECD[var_05] != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_add(self.var_AECD[var_05],"invisible",(0,0,0));
			scripts\mp\objidpoolmanager::minimap_objective_position(self.var_AECD[var_05],level.var_1A6F[level.script][var_05]["origin"]);
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_AECD[var_05],"active");
			scripts\mp\objidpoolmanager::minimap_objective_player(self.var_AECD[var_05],self getentitynumber());
			if(level.var_1A6F[level.script][var_05]["in_use"] == 1)
			{
				scripts\mp\objidpoolmanager::minimap_objective_icon(self.var_AECD[var_05],param_01);
				continue;
			}

			scripts\mp\objidpoolmanager::minimap_objective_icon(self.var_AECD[var_05],param_00);
		}
	}

	scripts\common\utility::waittill_any_3("cancel_location","picked_location","stop_location_selection");
	var_04 scripts\mp\_hud_util::destroyelem();
	for(var_05 = 0;var_05 < param_03;var_05++)
	{
		scripts\mp\objidpoolmanager::returnminimapid(self.var_AECD[var_05]);
	}
}

//Function Number: 9
func_4983(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnhelicopter(param_00,param_02,param_03,level.var_C73F[param_05].var_131A0,level.var_C73F[param_05].var_B91A);
	if(!isdefined(var_06))
	{
		return undefined;
	}

	var_06.var_C740 = param_05;
	var_06.var_8DA0 = level.var_C73F[param_05].var_B91A;
	var_06.var_8DD9 = level.var_C73F[param_05].var_8DD9;
	var_06.var_2550 = missile_createattractorent(var_06,level.var_8D2E,level.var_8D2D);
	var_06.var_AC68 = param_01;
	var_06.team = param_00.pers["team"];
	var_06.pers["team"] = param_00.pers["team"];
	var_06.var_222 = param_00;
	var_06 method_831F(param_00);
	var_06.maxhealth = level.var_C73F[param_05].maxhealth;
	var_06.var_13F0A = (0,0,0);
	var_06.var_11568 = level.var_8D9A;
	var_06.var_D8DF = undefined;
	var_06.var_F0C3 = undefined;
	var_06.var_4F = undefined;
	var_06.var_4C07 = "ok";
	var_06.var_5EF1 = level.var_C73F[param_05].var_5EF1;
	var_06 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air",param_00);
	level.var_3F14 = var_06;
	var_06 scripts\mp\killstreaks\_helicopter::func_184E();
	var_06 thread scripts\mp\killstreaks\_flares::func_6EAD(2);
	var_06 thread scripts\mp\killstreaks\_helicopter::func_8D69(param_00);
	var_06 thread scripts\mp\killstreaks\_helicopter::func_8D68(param_00);
	var_06 thread scripts\mp\killstreaks\_helicopter::func_8D6A(param_00);
	var_07 = level.var_C73F[param_05].var_11901;
	var_06 thread scripts\mp\killstreaks\_helicopter::func_8D6D(var_07);
	var_06 thread scripts\mp\killstreaks\_helicopter::func_8D40(param_05,0);
	var_06 thread scripts\mp\killstreaks\_helicopter::func_8D61();
	var_06 thread scripts\mp\killstreaks\_helicopter::func_8D49();
	var_06 thread func_1AE8();
	var_06 thread func_1AEA();
	if(param_05 == "escort_airdrop")
	{
		var_08 = var_06.origin + anglestoforward(var_06.angles) * -200 + anglestoright(var_06.angles) * -200 + (0,0,200);
		var_06.var_A63A = spawn("script_model",var_08);
		var_06.var_A63A setscriptmoverkillcam("explosive");
		var_06.var_A63A linkto(var_06,"tag_origin");
	}

	return var_06;
}

//Function Number: 10
func_1AE8()
{
	self endon("death");
	wait(0.05);
	playfxontag(level.var_3F19["light"]["tail"],self,"tag_light_tail");
	wait(0.05);
	playfxontag(level.var_3F19["light"]["belly"],self,"tag_light_belly");
	wait(0.05);
	playfxontag(level.var_3F19["anim"]["blades_static_down"][level.var_C73F[self.var_C740].var_B91A],self,"TAG_BLADES_ATTACH");
	wait(0.05);
	playfxontag(level.var_3F19["anim"]["hatch_left_static_up"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11415);
	wait(0.05);
	playfxontag(level.var_3F19["anim"]["hatch_right_static_up"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11416);
}

//Function Number: 11
func_1AEA()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		thread func_1AE9(var_00);
	}
}

//Function Number: 12
func_1AE9(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	wait(0.05);
	playfxontagforclients(level.var_3F19["light"]["tail"],self,"tag_light_tail",param_00);
	wait(0.05);
	playfxontagforclients(level.var_3F19["light"]["belly"],self,"tag_light_belly",param_00);
	if(isdefined(self.var_DA9F))
	{
		if(self.var_DA9F == "up")
		{
			wait(0.05);
			playfxontagforclients(level.var_3F19["anim"]["blades_static_up"][level.var_C73F[self.var_C740].var_B91A],self,"TAG_BLADES_ATTACH",param_00);
		}
		else
		{
			wait(0.05);
			playfxontagforclients(level.var_3F19["anim"]["blades_static_down"][level.var_C73F[self.var_C740].var_B91A],self,"TAG_BLADES_ATTACH",param_00);
		}
	}
	else
	{
		wait(0.05);
		playfxontagforclients(level.var_3F19["anim"]["blades_static_down"][level.var_C73F[self.var_C740].var_B91A],self,"TAG_BLADES_ATTACH",param_00);
	}

	if(isdefined(self.var_8C42))
	{
		if(self.var_8C42 == "down")
		{
			wait(0.05);
			playfxontagforclients(level.var_3F19["anim"]["hatch_left_static_down"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11415,param_00);
			wait(0.05);
			playfxontagforclients(level.var_3F19["anim"]["hatch_right_static_down"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11416,param_00);
			return;
		}

		wait(0.05);
		playfxontagforclients(level.var_3F19["anim"]["hatch_left_static_up"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11415,param_00);
		wait(0.05);
		playfxontagforclients(level.var_3F19["anim"]["hatch_right_static_up"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11416,param_00);
		return;
	}

	wait(0.05);
	playfxontagforclients(level.var_3F19["anim"]["hatch_left_static_up"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11415,param_00);
	wait(0.05);
	playfxontagforclients(level.var_3F19["anim"]["hatch_right_static_up"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11416,param_00);
}

//Function Number: 13
func_130E3(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_01 thread func_1AE6(self,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 14
func_130B6(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread func_E4F8(param_00,param_01);
	param_01 thread func_1AE7(self,param_02,param_03,param_04,param_05);
}

//Function Number: 15
func_E4F8(param_00,param_01)
{
	self endon("disconnect");
	param_01 endon("helicopter_done");
	thread scripts\mp\_utility::func_115DE("used_osprey_gunner",self);
	scripts\mp\_utility::func_12C6("heli_remote_mp");
	scripts\mp\_utility::_switchtoweapon("heli_remote_mp");
	if(getdvarint("camera_thirdPerson"))
	{
		scripts\mp\_utility::setthirdpersondof(0);
	}

	param_01 method_83ED(self);
	self playerlinkweaponviewtodelta(param_01,"tag_player",1,0,0,0,0,1);
	self setplayerangles(param_01 gettagangles("tag_player"));
	param_01 thread scripts\mp\killstreaks\_helicopter::func_8D99();
	param_01.var_8712 = self;
	self.var_8DD2 = param_00;
	thread func_6381(param_01);
	thread func_13714(1,param_01);
	thread scripts\mp\_utility::func_DF2E(param_01);
	for(;;)
	{
		param_01 waittill("turret_fire");
		param_01 method_80EB();
		earthquake(0.2,1,param_01.origin,1000);
	}
}

//Function Number: 16
func_13714(param_00,param_01)
{
	self endon("disconnect");
	param_01 endon("death");
	param_01 endon("helicopter_done");
	param_01 endon("crashing");
	param_01 endon("leaving");
	wait(param_00);
	self visionsetthermalforplayer(level.var_1537.var_65D1,0);
	self.var_AA42 = level.var_1537.var_65D1;
	self thermalvisionon();
	self thermalvisionfofoverlayon();
}

//Function Number: 17
func_1011E(param_00)
{
	self endon("disconnect");
	param_00 endon("helicopter_done");
	self.var_6741 = scripts\mp\_hud_util::createfontstring("bigfixed",1.5);
	self.var_6741 scripts\mp\_hud_util::setpoint("CENTER","CENTER",0,-150);
	self.var_6741 settext(level.var_C73F[param_00.var_C740].var_DA71);
	wait(6);
	if(isdefined(self.var_6741))
	{
		self.var_6741 scripts\mp\_hud_util::destroyelem();
	}
}

//Function Number: 18
func_1AEE()
{
	self endon("crashing");
	self endon("death");
	stopfxontag(level.var_3F19["anim"]["blades_static_down"][level.var_C73F[self.var_C740].var_B91A],self,"TAG_BLADES_ATTACH");
	playfxontag(level.var_3F19["anim"]["blades_anim_up"][level.var_C73F[self.var_C740].var_B91A],self,"TAG_BLADES_ATTACH");
	wait(1);
	if(isdefined(self))
	{
		playfxontag(level.var_3F19["anim"]["blades_static_up"][level.var_C73F[self.var_C740].var_B91A],self,"TAG_BLADES_ATTACH");
		self.var_DA9F = "up";
	}
}

//Function Number: 19
func_1AED()
{
	self endon("crashing");
	self endon("death");
	stopfxontag(level.var_3F19["anim"]["blades_static_up"][level.var_C73F[self.var_C740].var_B91A],self,"TAG_BLADES_ATTACH");
	playfxontag(level.var_3F19["anim"]["blades_anim_down"][level.var_C73F[self.var_C740].var_B91A],self,"TAG_BLADES_ATTACH");
	wait(1);
	if(isdefined(self))
	{
		playfxontag(level.var_3F19["anim"]["blades_static_down"][level.var_C73F[self.var_C740].var_B91A],self,"TAG_BLADES_ATTACH");
		self.var_DA9F = "down";
	}
}

//Function Number: 20
func_1AEC()
{
	self endon("crashing");
	self endon("death");
	stopfxontag(level.var_3F19["anim"]["hatch_left_static_down"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11415);
	playfxontag(level.var_3F19["anim"]["hatch_left_anim_up"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11415);
	stopfxontag(level.var_3F19["anim"]["hatch_right_static_down"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11416);
	playfxontag(level.var_3F19["anim"]["hatch_right_anim_up"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11416);
	wait(1);
	if(isdefined(self))
	{
		playfxontag(level.var_3F19["anim"]["hatch_left_static_up"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11415);
		playfxontag(level.var_3F19["anim"]["hatch_right_static_up"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11416);
		self.var_8C42 = "up";
	}
}

//Function Number: 21
func_1AEB()
{
	self endon("crashing");
	self endon("death");
	stopfxontag(level.var_3F19["anim"]["hatch_left_static_up"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11415);
	playfxontag(level.var_3F19["anim"]["hatch_left_anim_down"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11415);
	stopfxontag(level.var_3F19["anim"]["hatch_right_static_up"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11416);
	playfxontag(level.var_3F19["anim"]["hatch_right_anim_down"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11416);
	wait(1);
	if(isdefined(self))
	{
		playfxontag(level.var_3F19["anim"]["hatch_left_static_down"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11415);
		playfxontag(level.var_3F19["anim"]["hatch_right_static_down"][level.var_C73F[self.var_C740].var_B91A],self,level.var_C73F[self.var_C740].var_11416);
		self.var_8C42 = "down";
	}

	self notify("hatch_down");
}

//Function Number: 22
func_7DFC(param_00)
{
	self endon("helicopter_removed");
	self endon("heightReturned");
	var_01 = getent("airstrikeheight","targetname");
	if(isdefined(var_01))
	{
		var_02 = var_01.origin[2];
	}
	else if(isdefined(level.var_1AF8))
	{
		var_02 = 850 * level.var_1AF8;
	}
	else
	{
		var_02 = 850;
	}

	self.var_2A95 = var_02;
	var_03 = 200;
	var_04 = 0;
	var_05 = 0;
	for(var_06 = 0;var_06 < 125;var_06++)
	{
		wait(0.05);
		var_07 = var_06 % 8;
		var_08 = var_06 * 3;
		switch(var_07)
		{
			case 0:
				var_04 = var_08;
				var_05 = var_08;
				break;

			case 1:
				var_04 = var_08 * -1;
				var_05 = var_08 * -1;
				break;

			case 2:
				var_04 = var_08 * -1;
				var_05 = var_08;
				break;

			case 3:
				var_04 = var_08;
				var_05 = var_08 * -1;
				break;

			case 4:
				var_04 = 0;
				var_05 = var_08 * -1;
				break;

			case 5:
				var_04 = var_08 * -1;
				var_05 = 0;
				break;

			case 6:
				var_04 = var_08;
				var_05 = 0;
				break;

			case 7:
				var_04 = 0;
				var_05 = var_08;
				break;

			default:
				break;
		}

		var_09 = bullettrace(param_00 + (var_04,var_05,1000),param_00 + (var_04,var_05,-10000),1,self);
		if(var_09["position"][2] > var_03)
		{
			var_03 = var_09["position"][2];
		}
	}

	self.var_2A95 = var_03 + 300;
	switch(getdvar("mapname"))
	{
		case "mp_morningwood":
			self.var_2A95 = self.var_2A95 + 600;
			break;

		case "mp_overwatch":
			var_0A = level.var_108FB;
			var_0B = var_0A[0];
			var_0C = var_0A[0];
			foreach(var_0E in var_0A)
			{
				if(var_0E.origin[2] < var_0B.origin[2])
				{
					var_0B = var_0E;
				}
	
				if(var_0E.origin[2] > var_0C.origin[2])
				{
					var_0C = var_0E;
				}
			}
	
			if(var_03 < var_0B.origin[2] - 100)
			{
				self.var_2A95 = var_0C.origin[2] + 900;
			}
			break;
	}
}

//Function Number: 23
func_1AE6(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self notify("airshipFlyDefense");
	self endon("airshipFlyDefense");
	self endon("helicopter_removed");
	self endon("death");
	self endon("leaving");
	thread func_7DFC(param_02);
	scripts\mp\killstreaks\_helicopter::func_8D53(param_01);
	self.var_C96C = param_02;
	var_06 = self.angles;
	self method_8378(30,30,30,0.3);
	var_07 = self.origin;
	var_08 = self.angles[1];
	var_09 = self.angles[0];
	self.var_11901 = level.var_C73F[self.var_C740].var_11901;
	self method_8362(param_02,1);
	var_0A = gettime();
	self waittill("goal");
	var_0B = gettime() - var_0A * 0.001;
	self.var_11901 = self.var_11901 - var_0B;
	thread func_1AEE();
	var_0C = param_02 * (1,1,0);
	var_0C = var_0C + (0,0,self.var_2A95);
	self method_83E5(25,10,10);
	self method_8378(20,10,10,0.3);
	self method_8362(var_0C,1);
	var_0A = gettime();
	self waittill("goal");
	var_0B = gettime() - var_0A * 0.001;
	self.var_11901 = self.var_11901 - var_0B;
	self method_82F6(65,50,50);
	func_C73E(1,level.var_C73F[self.var_C740].var_113F0,var_0C);
	thread func_A663(param_05);
	if(isdefined(param_00))
	{
		param_00 scripts\common\utility::waittill_any_timeout_1(self.var_11901,"disconnect");
	}

	self waittill("leaving");
	self notify("osprey_leaving");
	thread func_1AED();
}

//Function Number: 24
func_13589(param_00)
{
	self endon("death");
	level endon("game_ended");
	wait(param_00);
	self delete();
}

//Function Number: 25
func_A663(param_00)
{
	self endon("osprey_leaving");
	self endon("helicopter_removed");
	self endon("death");
	var_01 = param_00;
	for(;;)
	{
		foreach(var_03 in level.players)
		{
			wait(0.05);
			if(!isdefined(self))
			{
				return;
			}

			if(!isdefined(var_03))
			{
				continue;
			}

			if(!scripts\mp\_utility::func_9F19(var_03))
			{
				continue;
			}

			if(!self.var_222 scripts\mp\_utility::func_9DD6(var_03))
			{
				continue;
			}

			if(var_03 scripts\mp\_utility::_hasperk("specialty_blindeye"))
			{
				continue;
			}

			if(distancesquared(var_01,var_03.origin) > 500000)
			{
				continue;
			}

			thread func_1B01(var_03,var_01);
			func_136B2();
		}
	}
}

//Function Number: 26
func_1B01(param_00,param_01)
{
	self notify("aiShootPlayer");
	self endon("aiShootPlayer");
	self endon("helicopter_removed");
	self endon("leaving");
	param_00 endon("death");
	self method_835C(param_00);
	self method_8305(param_00);
	thread func_1155A(param_00);
	var_02 = 6;
	var_03 = 2;
	for(;;)
	{
		var_02--;
		self method_80EB("tag_flash",param_00);
		wait(0.15);
		if(var_02 <= 0)
		{
			var_03--;
			var_02 = 6;
			if(distancesquared(param_00.origin,param_01) > 500000 || var_03 <= 0 || !scripts\mp\_utility::func_9F19(param_00))
			{
				self notify("abandon_target");
				return;
			}

			wait(1);
		}
	}
}

//Function Number: 27
func_1155A(param_00)
{
	self endon("abandon_target");
	self endon("leaving");
	self endon("helicopter_removed");
	param_00 waittill("death");
	self notify("target_killed");
}

//Function Number: 28
func_136B2()
{
	self endon("helicopter_removed");
	self endon("leaving");
	self endon("target_killed");
	self endon("abandon_target");
	wait(0.05);
}

//Function Number: 29
func_1AE7(param_00,param_01,param_02,param_03,param_04)
{
	self notify("airshipFlyGunner");
	self endon("airshipFlyGunner");
	self endon("helicopter_removed");
	self endon("death");
	self endon("leaving");
	thread func_7DFC(param_02);
	scripts\mp\killstreaks\_helicopter::func_8D53(param_01);
	thread scripts\mp\killstreaks\_helicopter::func_8D6D(level.var_C73F[self.var_C740].var_11901);
	var_05 = self.angles;
	self method_8378(30,30,30,0.3);
	var_06 = self.origin;
	var_07 = self.angles[1];
	var_08 = self.angles[0];
	self.var_11901 = level.var_C73F[self.var_C740].var_11901;
	self method_8362(param_02,1);
	var_09 = gettime();
	self waittill("goal");
	var_0A = gettime() - var_09 * 0.001;
	self.var_11901 = self.var_11901 - var_0A;
	thread func_1AEE();
	var_0B = param_02 * (1,1,0);
	var_0B = var_0B + (0,0,self.var_2A95);
	self method_83E5(25,10,10);
	self method_8378(20,10,10,0.3);
	self method_8362(var_0B,1);
	var_09 = gettime();
	self waittill("goal");
	var_0A = gettime() - var_09 * 0.001;
	self.var_11901 = self.var_11901 - var_0A;
	func_C73D(1,level.var_C73F[self.var_C740].var_113F0,var_0B);
	var_0C = 1;
	if(isdefined(param_00))
	{
		param_00 scripts\common\utility::waittill_any_timeout_1(var_0C,"disconnect");
	}

	self.var_11901 = self.var_11901 - var_0C;
	self method_8362(param_02,1);
	var_09 = gettime();
	self waittill("goal");
	var_0A = gettime() - var_09 * 0.001;
	self.var_11901 = self.var_11901 - var_0A;
	var_0D = getentarray("heli_attack_area","targetname");
	var_0E = level.var_8D6F[randomint(level.var_8D6F.size)];
	if(var_0D.size)
	{
		thread scripts\mp\killstreaks\_helicopter::func_8D55(var_0D);
	}
	else
	{
		thread scripts\mp\killstreaks\_helicopter::func_8D52(var_0E);
	}

	self waittill("leaving");
	thread func_1AED();
}

//Function Number: 30
func_C73E(param_00,param_01,param_02)
{
	thread func_1AEB();
	self waittill("hatch_down");
	level notify("escort_airdrop_started",self);
	var_03[0] = thread scripts\mp\killstreaks\_airdrop::func_5EEC(undefined,self.var_5EF1,undefined,0,undefined,self.origin,(randomint(10),randomint(10),randomint(10)),undefined,param_01);
	wait(0.05);
	self notify("drop_crate");
	wait(param_00);
	var_03[1] = thread scripts\mp\killstreaks\_airdrop::func_5EEC(undefined,self.var_5EF1,undefined,0,undefined,self.origin,(randomint(100),randomint(100),randomint(100)),var_03,param_01);
	wait(0.05);
	self notify("drop_crate");
	wait(param_00);
	var_03[2] = thread scripts\mp\killstreaks\_airdrop::func_5EEC(undefined,self.var_5EF1,undefined,0,undefined,self.origin,(randomint(50),randomint(50),randomint(50)),var_03,param_01);
	wait(0.05);
	self notify("drop_crate");
	wait(param_00);
	var_03[3] = thread scripts\mp\killstreaks\_airdrop::func_5EEC(undefined,self.var_5EF1,undefined,0,undefined,self.origin,(randomintrange(-100,0),randomintrange(-100,0),randomintrange(-100,0)),var_03,param_01);
	wait(0.05);
	self notify("drop_crate");
	wait(param_00);
	thread scripts\mp\killstreaks\_airdrop::func_5EEC(undefined,self.var_5EF1,undefined,0,undefined,self.origin,(randomintrange(-50,0),randomintrange(-50,0),randomintrange(-50,0)),var_03,param_01);
	wait(0.05);
	self notify("drop_crate");
	wait(1);
	thread func_1AEC();
}

//Function Number: 31
func_C73D(param_00,param_01,param_02)
{
	thread func_1AEB();
	self waittill("hatch_down");
	var_03[0] = thread scripts\mp\killstreaks\_airdrop::func_5EEC(undefined,self.var_5EF1,undefined,0,undefined,self.origin,(randomint(10),randomint(10),randomint(10)),undefined,param_01);
	wait(0.05);
	self.var_11901 = self.var_11901 - 0.05;
	self notify("drop_crate");
	wait(param_00);
	self.var_11901 = self.var_11901 - param_00;
	var_03[1] = thread scripts\mp\killstreaks\_airdrop::func_5EEC(undefined,self.var_5EF1,undefined,0,undefined,self.origin,(randomint(100),randomint(100),randomint(100)),var_03,param_01);
	wait(0.05);
	self.var_11901 = self.var_11901 - 0.05;
	self notify("drop_crate");
	wait(param_00);
	self.var_11901 = self.var_11901 - param_00;
	var_03[2] = thread scripts\mp\killstreaks\_airdrop::func_5EEC(undefined,self.var_5EF1,undefined,0,undefined,self.origin,(randomint(50),randomint(50),randomint(50)),var_03,param_01);
	wait(0.05);
	self.var_11901 = self.var_11901 - 0.05;
	self notify("drop_crate");
	wait(1);
	thread func_1AEC();
}

//Function Number: 32
func_6380(param_00)
{
	if(isdefined(self.var_6741))
	{
		self.var_6741 scripts\mp\_hud_util::destroyelem();
	}

	self method_8258();
	self thermalvisionoff();
	self thermalvisionfofoverlayoff();
	self unlink();
	scripts\mp\_utility::func_41E9();
	if(getdvarint("camera_thirdPerson"))
	{
		scripts\mp\_utility::setthirdpersondof(1);
	}

	self visionsetthermalforplayer(game["thermal_vision"],0);
	if(isdefined(param_00))
	{
		param_00 method_83EC(self);
	}

	self notify("heliPlayer_removed");
	scripts\mp\_utility::_switchtoweapon(scripts\common\utility::getlastweapon());
	scripts\mp\_utility::func_141E("heli_remote_mp");
}

//Function Number: 33
func_6381(param_00)
{
	self endon("disconnect");
	param_00 waittill("helicopter_done");
	func_6380(param_00);
}