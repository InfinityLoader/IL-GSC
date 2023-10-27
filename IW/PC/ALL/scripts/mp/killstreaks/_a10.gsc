/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_a10.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 42
 * Decompile Time: 1876 ms
 * Timestamp: 10/27/2023 12:27:53 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = spawnstruct();
	var_00.var_B923 = [];
	var_00.var_B923["allies"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
	var_00.var_B923["axis"] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
	var_00.var_131A0 = "a10_warthog_mp";
	var_00.var_93B9 = "veh_mig29_dist_loop";
	var_00.var_2B3 = 3000;
	var_00.var_8863 = 12500;
	var_00.var_8D13 = 750;
	var_00.var_3ED0 = 1;
	var_00.var_F1CA = "KS_hqr_airstrike";
	var_00.var_93BA = "KS_ast_inbound";
	var_00.var_38D9 = loadfx("vfx/core/smktrail/smoke_trail_white_heli");
	var_00.var_38DA = "ac130_25mm_fire";
	var_00.var_12A7B = "a10_30mm_turret_mp";
	var_00.var_12A58 = "tag_barrel";
	var_00.var_E5DD = "maverick_projectile_mp";
	var_00.var_C23F = 4;
	var_00.var_50DD = 0.125;
	var_00.var_50DC = 0.4;
	var_00.var_AF2A = "veh_hud_target_chopperfly";
	var_00.maxhealth = 1000;
	var_00.var_EC44 = "destroyed_a10_strafe";
	var_00.var_3774 = "callout_destroyed_a10";
	var_00.var_13523 = undefined;
	var_00.var_69B9 = loadfx("vfx/core/expl/aerial_explosion");
	var_00.var_FC39 = "veh_a10_plr_fire_gatling_lp";
	var_00.var_FC3B = "veh_a10_plr_fire_gatling_cooldown";
	var_00.var_FC3A = "veh_a10_npc_fire_gatling_lp";
	var_00.var_FC3C = "veh_a10_npc_fire_gatling_cooldown";
	var_00.var_FC38 = 500;
	var_00.var_FC37 = "veh_a10_npc_fire_gatling_short_burst";
	var_00.var_FC36 = "veh_a10_npc_fire_gatling_long_burst";
	var_00.var_FC35 = "veh_a10_bullet_impact_lp";
	var_00.var_FC41 = [];
	var_00.var_FC41[0] = "veh_a10_plr_missile_ignition_left";
	var_00.var_FC41[1] = "veh_a10_plr_missile_ignition_right";
	var_00.var_FC42 = "veh_a10_npc_missile_fire";
	var_00.var_FC40 = "veh_a10_missile_loop";
	var_00.var_FC3D = "veh_a10_plr_engine_lp";
	var_00.var_FC3E = "veh_a10_dist_loop";
	level.var_CC43["a10_strafe"] = var_00;
	scripts\mp\killstreaks\_killstreaks::func_DEFB("a10_strafe",::func_C5BB);
	func_31D4();
}

//Function Number: 2
func_C5BB(param_00,param_01)
{
	if(isdefined(level.var_1490))
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(scripts\mp\_utility::func_9FC6() || scripts\mp\_utility::func_9E68())
	{
		return 0;
	}

	if(function_0085() < 2)
	{
		return 0;
	}

	thread func_5AB7(param_00,"a10_strafe");
	return 1;
}

//Function Number: 3
func_5AB7(param_00,param_01)
{
	self endon("end_remote");
	self endon("death");
	level endon("game_ended");
	var_02 = func_8052();
	var_03 = func_10DF5(param_01,param_00);
	if(var_03)
	{
		var_04 = func_10829(param_01,param_00,level.var_148E[var_02]);
		if(isdefined(var_04))
		{
			var_04 func_5976();
			func_11370(var_04,param_01);
			var_04 = func_10829(param_01,param_00,level.var_148E[var_02]);
			if(isdefined(var_04))
			{
				thread scripts\mp\killstreaks\_killstreaks::func_41D6(1,0.75);
				var_04 func_5976();
				var_04 thread func_631B(param_01);
				func_638E(param_01);
				return;
			}
		}
	}
}

//Function Number: 4
func_10DF5(param_00,param_01)
{
	scripts\mp\_utility::func_FB09("a10_strafe");
	if(getdvarint("camera_thirdPerson"))
	{
		scripts\mp\_utility::setthirdpersondof(0);
	}

	self.var_E2D7 = self.angles;
	scripts\mp\_utility::func_7385(1);
	var_02 = scripts\mp\killstreaks\_killstreaks::func_98C2("a10_strafe");
	if(var_02 != "success")
	{
		if(var_02 != "disconnect")
		{
			scripts\mp\_utility::func_41E9();
		}

		if(isdefined(self.var_55E6) && self.var_55E6)
		{
			scripts\common\utility::allow_weapon(1);
		}

		self notify("death");
		return 0;
	}

	if(scripts\mp\_utility::func_9E59() && isdefined(self.var_A4A8))
	{
		self.var_A4A8.alpha = 0;
	}

	scripts\mp\_utility::func_7385(0);
	level.var_1490 = 1;
	self.var_13105 = 1;
	level thread scripts\mp\_utility::func_115DE("used_" + param_00,self,self.team);
	return 1;
}

//Function Number: 5
func_638E(param_00)
{
	scripts\mp\_utility::func_41E9();
	if(getdvarint("camera_thirdPerson"))
	{
		scripts\mp\_utility::setthirdpersondof(1);
	}

	if(scripts\mp\_utility::func_9E59() && isdefined(self.var_A4A8))
	{
		self.var_A4A8.alpha = 1;
	}

	self setplayerangles(self.var_E2D7);
	self.var_E2D7 = undefined;
	thread func_1483();
	level.var_1490 = undefined;
	self.var_13105 = undefined;
}

//Function Number: 6
func_11370(param_00,param_01)
{
	self.var_13118 = undefined;
	self visionsetnakedforplayer("black_bw",0.75);
	thread scripts\mp\_utility::func_F607("black_bw",0.75,0.75);
	wait(0.75);
	if(isdefined(param_00))
	{
		param_00 thread func_631B(param_01);
	}
}

//Function Number: 7
func_10829(param_00,param_01,param_02)
{
	var_03 = func_49FD(param_00,param_01,param_02);
	if(!isdefined(var_03))
	{
		return undefined;
	}

	var_03.var_110EA = param_00;
	self method_825C(var_03);
	thread func_13AA8(param_00,var_03);
	var_04 = level.var_CC43[param_00];
	var_03 playloopsound(var_04.var_FC3D);
	var_03 thread func_1485();
	scripts\mp\killstreaks\_plane::func_10E02(var_03);
	return var_03;
}

//Function Number: 8
func_24AE(param_00)
{
	var_01 = level.var_CC43[param_00];
	var_02 = self gettagorigin(var_01.var_12A58);
	var_03 = spawnturret("misc_turret",self.origin + var_02,var_01.var_12A7B,0);
	var_03 linkto(self,var_01.var_12A58,(0,0,0),(0,0,0));
	var_03 setmodel("vehicle_ugv_talon_gun_mp");
	var_03.angles = self.angles;
	var_03.var_222 = self.var_222;
	var_03 method_81F5();
	var_03 method_835B(0);
	var_03 method_830F("sentry_offline");
	var_03 makeunusable();
	var_03 setcandamage(0);
	var_03 method_8336(self.var_222);
	self.var_222 method_825A(var_03);
	self.var_129B9 = var_03;
}

//Function Number: 9
func_40E3()
{
	if(isdefined(self.var_129B9))
	{
		self.var_129B9 delete();
	}

	foreach(var_01 in self.var_11571)
	{
		if(isdefined(var_01["icon"]))
		{
			var_01["icon"] destroy();
			var_01["icon"] = undefined;
		}
	}

	self delete();
}

//Function Number: 10
func_8052()
{
	return randomint(level.var_148E.size);
}

//Function Number: 11
func_5976()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("splinePlaneReachedNode",var_00);
		if(isdefined(var_00) && var_00 == "End")
		{
			self notify("a10_end_strafe");
			break;
		}
	}
}

//Function Number: 12
func_631B(param_00)
{
	if(!isdefined(self))
	{
		return;
	}

	self.var_222 method_825D(self);
	if(isdefined(self.var_129B9))
	{
		self.var_222 method_825B(self.var_129B9);
	}

	self notify("end_remote");
	self.var_222 thermalvisionfofoverlayoff();
	var_01 = level.var_CC43[param_00];
	self stoploopsound(var_01.var_FC39);
	scripts\mp\killstreaks\_plane::func_11098(self);
	wait(5);
	if(isdefined(self))
	{
		self stoploopsound(var_01.var_FC3D);
		func_40E3();
	}
}

//Function Number: 13
func_49FD(param_00,param_01,param_02)
{
	var_03 = level.var_CC43[param_00];
	var_04 = function_008C(param_02,0);
	var_05 = function_008D(param_02,0);
	var_06 = vectortoangles(var_05);
	var_07 = spawnhelicopter(self,var_04,var_06,var_03.var_131A0,var_03.var_B923[self.team]);
	if(!isdefined(var_07))
	{
		return undefined;
	}

	var_07 method_81FC(18,-9,18);
	var_07.var_222 = self;
	var_07.team = self.team;
	var_07.var_AC68 = param_01;
	var_07 thread scripts\mp\killstreaks\_plane::func_D4FA();
	return var_07;
}

//Function Number: 14
func_898E()
{
	level endon("game_ended");
	self endon("delete");
	self waittill("death");
	level.var_1490 = undefined;
	self.var_222.var_13105 = undefined;
	self delete();
}

//Function Number: 15
func_1483()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	scripts\mp\_utility::func_7385(1);
	wait(0.5);
	scripts\mp\_utility::func_7385(0);
}

//Function Number: 16
func_BA0F(param_00,param_01)
{
	param_01 endon("end_remote");
	param_01 endon("death");
	self endon("death");
	level endon("game_ended");
	var_02 = level.var_CC43[param_00];
	param_01.var_C240 = var_02.var_C23F;
	self notifyonplayercommand("rocket_fire_pressed","+speed_throw");
	self notifyonplayercommand("rocket_fire_pressed","+ads_akimbo_accessible");
	if(!level.console)
	{
		self notifyonplayercommand("rocket_fire_pressed","+toggleads_throw");
	}

	while(param_01.var_C240 > 0)
	{
		self waittill("rocket_fire_pressed");
		param_01 func_C52A(param_00);
		wait(var_02.var_50DD);
	}
}

//Function Number: 17
func_BA0E(param_00,param_01)
{
	param_01 endon("end_remote");
	param_01 endon("death");
	self endon("death");
	level endon("game_ended");
	var_02 = level.var_CC43[param_00];
	param_01.var_C240 = var_02.var_C23F;
	self notifyonplayercommand("rocket_fire_pressed","+speed_throw");
	self notifyonplayercommand("rocket_fire_pressed","+ads_akimbo_accessible");
	if(!level.console)
	{
		self notifyonplayercommand("rocket_fire_pressed","+toggleads_throw");
	}

	param_01.var_11571 = [];
	while(param_01.var_C240 > 0)
	{
		if(!self adsbuttonpressed())
		{
			self waittill("rocket_fire_pressed");
		}

		param_01 func_B846();
		if(param_01.var_11571.size > 0)
		{
			param_01 thread func_6D76();
		}
	}
}

//Function Number: 18
func_B88B()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(func_B88E(var_02))
		{
			var_00[var_00.size] = var_02;
		}
	}

	foreach(var_05 in level.var_12F81)
	{
		if(func_B88E(var_05))
		{
			var_00[var_00.size] = var_05;
		}
	}

	if(var_00.size > 0)
	{
		var_07 = sortbydistance(var_00,self.origin);
		return var_07[0];
	}

	return undefined;
}

//Function Number: 19
func_B88E(param_00)
{
	return isalive(param_00) && param_00.team != self.var_222.team && !func_9EA2(param_00) && isplayer(param_00) && !param_00 scripts\mp\_utility::_hasperk("specialty_blindeye") && func_B8B3(param_00) > 0.25;
}

//Function Number: 20
func_B8B3(param_00)
{
	var_01 = vectornormalize(param_00.origin - self.origin);
	var_02 = anglestoforward(self.angles);
	return vectordot(var_01,var_02);
}

//Function Number: 21
func_B846()
{
	self endon("death");
	self endon("end_remote");
	level endon("game_ended");
	self endon("a10_missiles_fired");
	var_00 = level.var_CC43[self.var_110EA];
	self.var_222 setclientomnvar("ui_a10_rocket_lock",1);
	thread func_B8B7();
	var_01 = undefined;
	while(self.var_11571.size < self.var_C240)
	{
		if(!isdefined(var_01))
		{
			var_01 = func_B88B();
			if(isdefined(var_01))
			{
				thread func_B88F(var_01);
				wait(var_00.var_50DC);
				var_01 = undefined;
				continue;
			}
		}

		wait(0.1);
	}

	self.var_222 setclientomnvar("ui_a10_rocket_lock",0);
	self notify("a10_missiles_fired");
}

//Function Number: 22
func_B8B7()
{
	self endon("end_remote");
	self endon("death");
	level endon("game_ended");
	self endon("a10_missiles_fired");
	var_00 = self.var_222;
	var_00 notifyonplayercommand("rocket_fire_released","-speed_throw");
	var_00 notifyonplayercommand("rocket_fire_released","-ads_akimbo_accessible");
	if(!level.console)
	{
		var_00 notifyonplayercommand("rocket_fire_released","-toggleads_throw");
	}

	self.var_222 waittill("rocket_fire_released");
	var_00 setclientomnvar("ui_a10_rocket_lock",0);
	self notify("a10_missiles_fired");
}

//Function Number: 23
func_B88F(param_00)
{
	var_01 = level.var_CC43[self.var_110EA];
	var_02 = [];
	var_02["icon"] = param_00 scripts\mp\_entityheadicons::func_F73D(self.var_222,var_01.var_AF2A,(0,0,-70),10,10,0,0.05,1,0,0,0);
	var_02["target"] = param_00;
	self.var_11571[param_00 getentitynumber()] = var_02;
	self.var_222 playlocalsound("recondrone_lockon");
}

//Function Number: 24
func_9EA2(param_00)
{
	return isdefined(self.var_11571[param_00 getentitynumber()]);
}

//Function Number: 25
func_6D76()
{
	self endon("death");
	level endon("game_ended");
	var_00 = level.var_CC43[self.var_110EA];
	foreach(var_02 in self.var_11571)
	{
		if(self.var_C240 > 0)
		{
			var_03 = func_C529(self.var_110EA,var_02["target"],(0,0,-70));
			if(isdefined(var_02["icon"]))
			{
				var_03.var_928E = var_02["icon"];
				var_02["icon"] = undefined;
			}

			wait(var_00.var_50DD);
			continue;
		}

		break;
	}

	var_05 = [];
}

//Function Number: 26
func_C529(param_00,param_01,param_02)
{
	var_03 = self.var_C240 % 2;
	var_04 = "tag_missile_" + var_03 + 1;
	var_05 = self gettagorigin(var_04);
	if(isdefined(var_05))
	{
		var_06 = self.var_222;
		var_07 = level.var_CC43[param_00];
		var_08 = scripts\mp\_utility::func_1309(var_07.var_E5DD,var_05,var_05 + 100 * anglestoforward(self.angles),self.var_222);
		var_08 thread func_1488(param_01,param_02);
		earthquake(0.25,0.05,self.origin,512);
		self.var_C240--;
		var_07 = level.var_CC43[param_00];
		var_08 playsoundonmovingent(var_07.var_FC41[var_03]);
		var_08 playloopsound(var_07.var_FC40);
		return var_08;
	}

	return undefined;
}

//Function Number: 27
func_C52A(param_00)
{
	var_01 = "tag_missile_" + self.var_C240;
	var_02 = self gettagorigin(var_01);
	if(isdefined(var_02))
	{
		var_03 = self.var_222;
		var_04 = level.var_CC43[param_00];
		var_05 = scripts\mp\_utility::func_1309(var_04.var_E5DD,var_02,var_02 + 100 * anglestoforward(self.angles),self.var_222);
		earthquake(0.25,0.05,self.origin,512);
		self.var_C240--;
		var_05 playsoundonmovingent(var_04.var_FC41[self.var_C240]);
		var_05 playloopsound(var_04.var_FC40);
		self playsoundonmovingent("a10p_missile_launch");
	}
}

//Function Number: 28
func_1488(param_00,param_01)
{
	thread func_1486();
	wait(0.2);
	self missile_settargetent(param_00,param_01);
}

//Function Number: 29
func_1486()
{
	self waittill("death");
	if(isdefined(self.var_928E))
	{
		self.var_928E destroy();
	}
}

//Function Number: 30
func_BA39(param_00,param_01)
{
	param_01 endon("end_remote");
	param_01 endon("death");
	self endon("death");
	level endon("game_ended");
	var_02 = level.var_CC43[param_00];
	param_01.var_1E41 = 1350;
	self notifyonplayercommand("a10_cannon_start","+attack");
	self notifyonplayercommand("a10_cannon_start","+attack_akimbo_accessible");
	self notifyonplayercommand("a10_cannon_stop","-attack");
	self notifyonplayercommand("a10_cannon_stop","-attack_akimbo_accessible");
	while(param_01.var_1E41 > 0)
	{
		if(!self attackbuttonpressed())
		{
			self waittill("a10_cannon_start");
		}

		var_03 = gettime() + var_02.var_FC38;
		param_01 playloopsound(var_02.var_FC39);
		param_01 thread func_12E6D(param_00);
		self waittill("a10_cannon_stop");
		param_01 stoploopsound(var_02.var_FC39);
		param_01 playsoundonmovingent(var_02.var_FC3B);
		if(gettime() < var_03)
		{
			playsoundatpos(param_01.origin,var_02.var_FC37);
			continue;
		}

		playsoundatpos(param_01.origin,var_02.var_FC36);
	}
}

//Function Number: 31
func_12E6D(param_00)
{
	self.var_222 endon("a10_cannon_stop");
	self endon("death");
	level endon("game_ended");
	var_01 = level.var_CC43[param_00];
	while(self.var_1E41 > 0)
	{
		earthquake(0.2,0.5,self.origin,512);
		self.var_1E41 = self.var_1E41 - 10;
		var_02 = self gettagorigin("tag_flash_attach") + 20 * anglestoforward(self.angles);
		playfx(var_01.var_38D9,var_02);
		self playrumbleonentity(var_01.var_38DA);
		wait(0.1);
	}

	self.var_129B9 method_83C6();
}

//Function Number: 32
func_B9B6(param_00,param_01)
{
	param_01 endon("end_remote");
	param_01 endon("death");
	self endon("death");
	level endon("game_ended");
	self setclientomnvar("ui_a10_alt_warn",0);
	for(;;)
	{
		var_02 = int(clamp(param_01.origin[2],0,16383));
		self setclientomnvar("ui_a10_alt",var_02);
		if(var_02 <= 1000 && !isdefined(param_01.var_1D57))
		{
			param_01.var_1D57 = 1;
			self setclientomnvar("ui_a10_alt_warn",1);
		}
		else if(var_02 > 1000 && isdefined(param_01.var_1D57))
		{
			param_01.var_1D57 = undefined;
			self setclientomnvar("ui_a10_alt_warn",0);
		}

		wait(0.1);
	}
}

//Function Number: 33
func_13AA8(param_00,param_01)
{
	self endon("disconnect");
	level endon("game_ended");
	self waittill("intro_cleared");
	thread func_B9B6(param_00,param_01);
	thread func_BA0E(param_00,param_01);
	thread func_BA39(param_00,param_01);
	thread func_13B2F(param_01,param_00);
	self thermalvisionfofoverlayon();
	thread func_13A0D(param_01);
}

//Function Number: 34
func_13B2F(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("leaving");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level scripts\common\utility::waittill_any_3("round_end_finished","game_ended");
	param_00 thread func_631B(param_01);
	func_638E(param_01);
	func_1481();
}

//Function Number: 35
func_31D4()
{
	var_00 = [];
	var_00[0] = 1;
	var_00[1] = 2;
	var_00[2] = 3;
	var_00[3] = 4;
	var_00[4] = 1;
	var_00[5] = 2;
	var_00[6] = 4;
	var_00[7] = 3;
	var_01 = [];
	var_01[0] = 2;
	var_01[1] = 1;
	var_01[2] = 4;
	var_01[3] = 3;
	var_01[4] = 1;
	var_01[5] = 4;
	var_01[6] = 3;
	var_01[7] = 2;
	func_31D3(var_00,var_01);
}

//Function Number: 36
func_31D3(param_00,param_01)
{
	level.var_148E = param_00;
	level.var_148F = param_01;
}

//Function Number: 37
func_1480()
{
	level endon("remove_player_control");
	wait(randomfloatrange(3,7));
}

//Function Number: 38
func_13A0D(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("a10_end_strafe");
	param_00 thread scripts\mp\killstreaks\_killstreaks::func_1CA5();
	param_00 waittill("killstreakExit");
	self notify("end_remote");
	param_00 thread func_631B(param_00.var_110EA);
	func_638E(param_00.var_110EA);
	param_00 func_1481();
}

//Function Number: 39
func_1485()
{
	self endon("end_remote");
	var_00 = level.var_CC43[self.var_110EA];
	scripts\mp\_damage::func_B9C6(var_00.maxhealth,"helicopter",::func_898F,::func_B938,1);
}

//Function Number: 40
func_B938(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	var_05 = scripts\mp\_damage::func_8999(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_89C6(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8975(param_01,param_02,var_05);
	return var_05;
}

//Function Number: 41
func_898F(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_CC43[self.var_110EA];
	scripts\mp\_damage::func_C548("a10",param_00,param_01,param_02,param_03,var_04.var_EC44,var_04.var_13523,var_04.var_3774);
	func_1481();
}

//Function Number: 42
func_1481()
{
	var_00 = level.var_CC43[self.var_110EA];
	scripts\mp\killstreaks\_plane::func_11098(self);
	playfx(var_00.var_69B9,self.origin);
	self delete();
}