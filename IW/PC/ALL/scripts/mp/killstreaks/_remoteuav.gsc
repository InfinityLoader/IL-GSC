/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_remoteuav.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 59
 * Decompile Time: 2954 ms
 * Timestamp: 10/27/2023 12:29:35 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_DF98["hit"] = loadfx("vfx/core/impacts/large_metal_painted_hit");
	level.var_DF98["smoke"] = loadfx("vfx/core/smktrail/remote_heli_damage_smoke_runner");
	level.var_DF98["explode"] = loadfx("vfx/core/expl/bouncing_betty_explosion");
	level.var_DF98["missile_explode"] = loadfx("vfx/core/expl/stinger_explosion");
	level.var_DF91["launch"][0] = "ac130_plt_yeahcleared";
	level.var_DF91["launch"][1] = "ac130_plt_rollinin";
	level.var_DF91["launch"][2] = "ac130_plt_scanrange";
	level.var_DF91["out_of_range"][0] = "ac130_plt_cleanup";
	level.var_DF91["out_of_range"][1] = "ac130_plt_targetreset";
	level.var_DF91["track"][0] = "ac130_fco_moreenemy";
	level.var_DF91["track"][1] = "ac130_fco_getthatguy";
	level.var_DF91["track"][2] = "ac130_fco_guymovin";
	level.var_DF91["track"][3] = "ac130_fco_getperson";
	level.var_DF91["track"][4] = "ac130_fco_guyrunnin";
	level.var_DF91["track"][5] = "ac130_fco_gotarunner";
	level.var_DF91["track"][6] = "ac130_fco_backonthose";
	level.var_DF91["track"][7] = "ac130_fco_gonnagethim";
	level.var_DF91["track"][8] = "ac130_fco_personnelthere";
	level.var_DF91["track"][9] = "ac130_fco_rightthere";
	level.var_DF91["track"][10] = "ac130_fco_tracking";
	level.var_DF91["tag"][0] = "ac130_fco_nice";
	level.var_DF91["tag"][1] = "ac130_fco_yougothim";
	level.var_DF91["tag"][2] = "ac130_fco_yougothim2";
	level.var_DF91["tag"][3] = "ac130_fco_okyougothim";
	level.var_DF91["assist"][0] = "ac130_fco_goodkill";
	level.var_DF91["assist"][1] = "ac130_fco_thatsahit";
	level.var_DF91["assist"][2] = "ac130_fco_directhit";
	level.var_DF91["assist"][3] = "ac130_fco_rightontarget";
	level.var_DF9D = 0;
	level.var_DFA2 = getentarray("no_vehicles","targetname");
	scripts\mp\killstreaks\_killstreaks::func_DEFB("remote_uav",::func_130CC);
	level.var_DF74 = [];
}

//Function Number: 2
func_130CC(param_00,param_01)
{
	return func_12900(param_00,"remote_uav");
}

//Function Number: 3
func_68C4(param_00)
{
	if(level.gametype == "dm")
	{
		if(isdefined(level.var_DF74[param_00]) || isdefined(level.var_DF74[level.var_C74B[param_00]]))
		{
			return 1;
		}

		return 0;
	}

	if(isdefined(level.var_DF74[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
func_12900(param_00,param_01)
{
	scripts\common\utility::func_1C6E(0);
	if(scripts\mp\_utility::func_9FC6() || self isusingturret() || isdefined(level.var_C1C4))
	{
		scripts\common\utility::func_1C6E(1);
		return 0;
	}

	var_02 = 1;
	if(func_68C4(self.team) || level.var_AD8B.size >= 4)
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		scripts\common\utility::func_1C6E(1);
		return 0;
	}
	else if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA + var_02 >= scripts\mp\_utility::func_B4D2())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		scripts\common\utility::func_1C6E(1);
		return 0;
	}

	self setplayerdata("reconDroneState","staticAlpha",0);
	self setplayerdata("reconDroneState","incomingMissile",0);
	scripts\mp\_utility::func_93FA();
	var_03 = func_8355(param_00,param_01);
	if(var_03)
	{
		scripts\mp\_matchdata::func_AFC9(param_01,self.origin);
		thread scripts\mp\_utility::func_115DE("used_remote_uav",self);
	}
	else
	{
		scripts\mp\_utility::func_4FC1();
	}

	self.var_9D81 = 0;
	return var_03;
}

//Function Number: 5
func_8355(param_00,param_01)
{
	var_02 = func_4994(param_01,self);
	scripts\mp\_utility::func_141E("killstreak_uav_mp");
	scripts\mp\_utility::func_12C6("killstreak_remote_uav_mp");
	scripts\mp\_utility::_switchtoweaponimmediate("killstreak_remote_uav_mp");
	func_F686(var_02);
	if(isalive(self) && isdefined(var_02))
	{
		var_03 = var_02.origin;
		var_04 = self.angles;
		var_02.var_10478 delete();
		var_02 delete();
		var_05 = func_10DEA(param_00,param_01,var_03,var_04);
	}
	else
	{
		var_05 = 0;
		if(isalive(self))
		{
			scripts\mp\_utility::func_141E("killstreak_remote_uav_mp");
			scripts\mp\_utility::func_12C6("killstreak_uav_mp");
		}
	}

	return var_05;
}

//Function Number: 6
func_4994(param_00,param_01)
{
	var_02 = param_01.origin + anglestoforward(param_01.angles) * 4 + anglestoup(param_01.angles) * 50;
	var_03 = spawnturret("misc_turret",var_02,"sentry_minigun_mp");
	var_03.origin = var_02;
	var_03.angles = param_01.angles;
	var_03.var_F26E = "sentry_minigun";
	var_03.var_3872 = 1;
	var_03 method_835B(1);
	var_03 method_830F("sentry_offline");
	var_03 makeunusable();
	var_03 method_81F5();
	var_03.var_222 = param_01;
	var_03 method_8336(var_03.var_222);
	var_03.var_EB9C = 3;
	var_03.var_94D1 = 0;
	var_03 thread func_3AFE();
	var_03.var_DCD0 = getent("remote_uav_range","targetname");
	if(!isdefined(var_03.var_DCD0))
	{
		var_04 = getent("airstrikeheight","targetname");
		var_03.var_B4A3 = var_04.origin[2];
		var_03.var_B492 = 3600;
	}

	var_03.var_10478 = spawn("script_origin",var_03.origin);
	var_03.var_10478.angles = var_03.angles;
	var_03.var_10478.origin = var_03.origin;
	var_03.var_10478 linkto(var_03);
	var_03.var_10478 playloopsound("recondrone_idle_high");
	return var_03;
}

//Function Number: 7
func_F686(param_00)
{
	param_00 thread func_3AFF(self);
	self notifyonplayercommand("place_carryRemoteUAV","+attack");
	self notifyonplayercommand("place_carryRemoteUAV","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_carryRemoteUAV","+actionslot 4");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_carryRemoteUAV","+actionslot 5");
		self notifyonplayercommand("cancel_carryRemoteUAV","+actionslot 6");
		self notifyonplayercommand("cancel_carryRemoteUAV","+actionslot 7");
	}

	for(;;)
	{
		var_01 = func_AEBE("place_carryRemoteUAV","cancel_carryRemoteUAV","weapon_switch_started","force_cancel_placement","death","disconnect");
		self method_80F3();
		if(var_01 != "place_carryRemoteUAV")
		{
			func_3AFD(param_00);
			break;
		}

		if(!param_00.var_3872)
		{
			if(self.team != "spectator")
			{
				self method_80F4(&"KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE");
			}

			continue;
		}

		if(func_68C4(self.team) || scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA >= scripts\mp\_utility::func_B4D2())
		{
			self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
			func_3AFD(param_00);
			break;
		}

		self.var_9D81 = 0;
		param_00.var_3A9D = undefined;
		param_00 playsound("sentry_gun_plant");
		param_00 notify("placed");
		break;
	}
}

//Function Number: 8
func_AEBE(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if((!isdefined(param_00) || param_00 != "death") && !isdefined(param_01) || param_01 != "death" && !isdefined(param_02) || param_02 != "death" && !isdefined(param_03) || param_03 != "death" && !isdefined(param_04) || param_04 != "death")
	{
		self endon("death");
	}

	var_06 = spawnstruct();
	if(isdefined(param_00))
	{
		thread scripts\common\utility::func_13806(param_00,var_06);
	}

	if(isdefined(param_01))
	{
		thread scripts\common\utility::func_13806(param_01,var_06);
	}

	if(isdefined(param_02))
	{
		thread scripts\common\utility::func_13806(param_02,var_06);
	}

	if(isdefined(param_03))
	{
		thread scripts\common\utility::func_13806(param_03,var_06);
	}

	if(isdefined(param_04))
	{
		thread scripts\common\utility::func_13806(param_04,var_06);
	}

	if(isdefined(param_05))
	{
		thread scripts\common\utility::func_13806(param_05,var_06);
	}

	var_06 waittill("returned",var_07);
	var_06 notify("die");
	return var_07;
}

//Function Number: 9
func_3AFF(param_00)
{
	self setcandamage(0);
	self method_8335(param_00);
	self method_82C7(0);
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	param_00 thread func_12E70(self);
	self notify("carried");
}

//Function Number: 10
func_3AFD(param_00)
{
	self.var_9D81 = 0;
	if(isdefined(param_00))
	{
		if(isdefined(param_00.var_10478))
		{
			param_00.var_10478 delete();
		}

		param_00 delete();
	}
}

//Function Number: 11
func_9E4F()
{
	if(isdefined(level.var_DFA2) && level.var_DFA2.size)
	{
		foreach(var_01 in level.var_DFA2)
		{
			if(self istouching(var_01))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 12
func_12E70(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("placed");
	param_00 endon("death");
	param_00.var_3872 = 1;
	var_01 = -1;
	scripts\common\utility::func_1C6E(1);
	for(;;)
	{
		var_02 = 18;
		switch(self getstance())
		{
			case "stand":
				var_02 = 40;
				break;
	
			case "crouch":
				var_02 = 25;
				break;
	
			case "prone":
				var_02 = 10;
				break;
		}

		var_03 = self canplayerplacetank(22,22,50,var_02,0,0);
		param_00.origin = var_03["origin"] + anglestoup(self.angles) * 27;
		param_00.angles = var_03["angles"];
		param_00.var_3872 = self isonground() && var_03["result"] && param_00 func_DF9C() && !param_00 func_9E4F();
		if(param_00.var_3872 != var_01)
		{
			if(param_00.var_3872)
			{
				if(self.team != "spectator")
				{
					self method_80F4(&"KILLSTREAKS_REMOTE_UAV_PLACE");
				}

				if(self attackbuttonpressed())
				{
					self notify("place_carryRemoteUAV");
				}
			}
			else if(self.team != "spectator")
			{
				self method_80F4(&"KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE");
			}
		}

		var_01 = param_00.var_3872;
		wait(0.05);
	}
}

//Function Number: 13
func_3AFE()
{
	level endon("game_ended");
	self.var_222 endon("place_carryRemoteUAV");
	self.var_222 endon("cancel_carryRemoteUAV");
	self.var_222 scripts\common\utility::waittill_any_3("death","disconnect","joined_team","joined_spectators");
	if(isdefined(self))
	{
		if(isdefined(self.var_10478))
		{
			self.var_10478 delete();
		}

		self delete();
	}
}

//Function Number: 14
func_E162()
{
	level endon("game_ended");
	self endon("disconnect");
	wait(0.7);
}

//Function Number: 15
func_10DEA(param_00,param_01,param_02,param_03)
{
	func_AF31();
	scripts\mp\_utility::func_FB09(param_01);
	scripts\mp\_utility::func_12C6("uav_remote_mp");
	scripts\mp\_utility::_switchtoweaponimmediate("uav_remote_mp");
	self visionsetnakedforplayer("black_bw",0);
	var_04 = scripts\mp\killstreaks\_killstreaks::func_98C2("remote_uav");
	if(var_04 != "success")
	{
		if(var_04 != "disconnect")
		{
			self notify("remoteuav_unlock");
			scripts\mp\_utility::func_141E("uav_remote_mp");
			scripts\mp\_utility::func_41E9();
		}

		return 0;
	}

	if(func_68C4(self.team) || scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA >= scripts\mp\_utility::func_B4D2())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		self notify("remoteuav_unlock");
		scripts\mp\_utility::func_141E("uav_remote_mp");
		scripts\mp\_utility::func_41E9();
		return 0;
	}

	self notify("remoteuav_unlock");
	var_05 = func_4A07(param_00,self,param_01,param_02,param_03);
	if(isdefined(var_05))
	{
		thread func_DFA7(param_00,var_05,param_01);
		return 1;
	}

	self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
	scripts\mp\_utility::func_141E("uav_remote_mp");
	scripts\mp\_utility::func_41E9();
	return 0;
}

//Function Number: 16
func_AF31()
{
	var_00 = spawn("script_origin",self.origin);
	var_00 hide();
	self playerlinkto(var_00);
	thread func_41CD(var_00);
}

//Function Number: 17
func_41CD(param_00)
{
	level endon("game_ended");
	var_01 = scripts\common\utility::func_13734("disconnect","death","remoteuav_unlock");
	if(var_01 != "disconnect")
	{
		self unlink();
	}

	param_00 delete();
}

//Function Number: 18
func_4A07(param_00,param_01,param_02,param_03,param_04)
{
	if(level.console)
	{
		var_05 = spawnhelicopter(param_01,param_03,param_04,"remote_uav_mp","vehicle_remote_uav");
	}
	else
	{
		var_05 = spawnhelicopter(param_02,param_04,var_05,"remote_uav_mp_pc","vehicle_remote_uav");
	}

	if(!isdefined(var_05))
	{
		return undefined;
	}

	var_05 scripts\mp\killstreaks\_helicopter::func_1852();
	var_05 thread scripts\mp\killstreaks\_helicopter::func_E111();
	var_05 method_81FC(18,-9,18);
	var_05.var_AC68 = param_00;
	var_05.team = param_01.team;
	var_05.pers["team"] = param_01.team;
	var_05.var_222 = param_01;
	var_05 method_831F(param_01);
	var_05 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air",param_01);
	var_05.maxhealth = 250;
	var_05.var_EC9C = spawn("script_model",param_03);
	var_05.var_EC9C linkto(var_05,"tag_origin",(0,0,-160),(0,0,0));
	var_05.var_EC9C method_81F4(param_01);
	var_05.var_1037E = 0;
	var_05.var_94D1 = 0;
	var_05.var_8DD9 = "remote_uav";
	var_05.var_B372 = [];
	var_05 thread func_DFA0();
	var_05 thread func_DF95();
	var_05 thread func_DF93();
	var_05 thread func_DF94();
	var_05 thread func_DF8D();
	var_05 thread func_DF9F();
	var_05 thread func_DFAD();
	var_05 thread func_DFAE();
	var_05 thread func_DF99();
	var_05.var_C22B = 2;
	var_05.var_8C01 = 0;
	var_05.var_93DB = [];
	var_05 thread func_DF8E();
	var_05 thread func_DF9B();
	var_05 thread func_DF9A();
	level.var_DF74[var_05.team] = var_05;
	return var_05;
}

//Function Number: 19
func_DFA7(param_00,param_01,param_02)
{
	param_01.var_D3D3 = 1;
	self.var_E2D7 = self.angles;
	if(getdvarint("camera_thirdPerson"))
	{
		scripts\mp\_utility::setthirdpersondof(0);
	}

	self cameralinkto(param_01,"tag_origin");
	self method_825C(param_01);
	thread func_DFA4(param_01);
	thread func_DFAA(param_01);
	thread func_DF96(param_01);
	self.var_DF75 = param_00;
	self.var_DF8A = param_01;
	thread func_DF90(param_01);
	self visionsetnakedforplayer("black_bw",0);
	scripts\mp\_utility::func_E2D8(1);
}

//Function Number: 20
func_DF90(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("death");
	param_00 endon("end_remote");
	param_00 endon("end_launch_dialog");
	wait(3);
	func_DF91("launch");
}

//Function Number: 21
func_DF92(param_00)
{
	if(isdefined(param_00))
	{
		param_00.var_D3D3 = 0;
		param_00 notify("end_remote");
		scripts\mp\_utility::func_41E9();
		if(getdvarint("camera_thirdPerson"))
		{
			scripts\mp\_utility::setthirdpersondof(1);
		}

		self cameraunlink(param_00);
		self method_825D(param_00);
		self thermalvisionoff();
		self setplayerangles(self.var_E2D7);
		var_01 = scripts\common\utility::getlastweapon();
		if(!self hasweapon(var_01))
		{
			var_01 = scripts\mp\killstreaks\_utility::func_7EB7();
		}

		scripts\mp\_utility::_switchtoweapon(var_01);
		scripts\mp\_utility::func_141E("uav_remote_mp");
		thread func_DF97();
	}

	self.var_DF8A = undefined;
}

//Function Number: 22
func_DF97()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	scripts\mp\_utility::func_7385(1);
	wait(0.5);
	scripts\mp\_utility::func_7385(0);
}

//Function Number: 23
func_DFA4(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("death");
	param_00 endon("end_remote");
	wait(2);
	for(;;)
	{
		var_01 = 0;
		while(self usebuttonpressed())
		{
			var_01 = var_01 + 0.05;
			if(var_01 > 0.75)
			{
				param_00 thread func_DF9E();
				return;
			}

			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 24
func_DFAA(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("death");
	param_00 endon("end_remote");
	param_00.var_AA34 = 0;
	self.var_AEFB = undefined;
	self weaponlockfree();
	wait(1);
	for(;;)
	{
		var_01 = param_00 gettagorigin("tag_turret");
		var_02 = anglestoforward(self getplayerangles());
		var_03 = var_01 + var_02 * 1024;
		var_04 = bullettrace(var_01,var_03,1,param_00);
		if(isdefined(var_04["position"]))
		{
			var_05 = var_04["position"];
		}
		else
		{
			var_05 = var_03;
			var_04["endpos"] = var_03;
		}

		param_00.var_11A7B = var_04;
		var_06 = func_DFAB(param_00,level.players,var_05);
		var_07 = func_DFAB(param_00,level.var_12A83,var_05);
		var_08 = undefined;
		if(level.multiteambased)
		{
			var_09 = [];
			foreach(var_0B in level.teamnamelist)
			{
				if(var_0B != self.team)
				{
					foreach(var_0D in level.var_12AF3[var_0B])
					{
						var_09[var_09.size] = var_0D;
					}
				}
			}

			var_08 = func_DFAB(param_00,var_09,var_05);
		}
		else if(level.teambased)
		{
			var_08 = func_DFAB(param_00,level.var_12AF3[level.var_C74B[self.team]],var_05);
		}
		else
		{
			var_08 = func_DFAB(param_00,level.var_12AF3,var_05);
		}

		var_10 = undefined;
		if(isdefined(var_06))
		{
			var_10 = var_06;
		}
		else if(isdefined(var_07))
		{
			var_10 = var_07;
		}
		else if(isdefined(var_08))
		{
			var_10 = var_08;
		}

		if(isdefined(var_10))
		{
			if(!isdefined(self.var_AEFB) || isdefined(self.var_AEFB) && self.var_AEFB != var_10)
			{
				self method_8402(var_10);
				self.var_AEFB = var_10;
				if(isdefined(var_06))
				{
					param_00 notify("end_launch_dialog");
					func_DF91("track");
				}
			}
		}
		else
		{
			self weaponlockfree();
			self.var_AEFB = undefined;
		}

		wait(0.05);
	}
}

//Function Number: 25
func_DFAB(param_00,param_01,param_02)
{
	level endon("game_ended");
	var_03 = undefined;
	foreach(var_05 in param_01)
	{
		if(level.teambased && !isdefined(var_05.team) || var_05.team == self.team)
		{
			continue;
		}

		if(isplayer(var_05))
		{
			if(!scripts\mp\_utility::func_9F19(var_05))
			{
				continue;
			}

			if(var_05 == self)
			{
				continue;
			}

			var_06 = var_05.var_86BD;
		}
		else
		{
			var_06 = var_05.var_64;
		}

		if(isdefined(var_05.var_F26E) || isdefined(var_05.var_12A9A))
		{
			var_07 = (0,0,32);
			var_08 = "hud_fofbox_hostile_vehicle";
		}
		else if(isdefined(var_05.var_12AFA))
		{
			var_07 = (0,0,-52);
			var_08 = "hud_fofbox_hostile_vehicle";
		}
		else
		{
			var_07 = (0,0,26);
			var_08 = "veh_hud_target_unmarked";
		}

		if(isdefined(var_05.var_12AF4))
		{
			if(!isdefined(param_00.var_B372[var_06]))
			{
				param_00.var_B372[var_06] = [];
				param_00.var_B372[var_06]["player"] = var_05;
				param_00.var_B372[var_06]["icon"] = var_05 scripts\mp\_entityheadicons::func_F73D(self,"veh_hud_target_marked",var_07,10,10,0,0.05,0,0,0,0);
				param_00.var_B372[var_06]["icon"].shader = "veh_hud_target_marked";
				if(!isdefined(var_05.var_F26E) || !isdefined(var_05.var_12A9A))
				{
					param_00.var_B372[var_06]["icon"] settargetent(var_05);
				}
			}
			else if(isdefined(param_00.var_B372[var_06]) && isdefined(param_00.var_B372[var_06]["icon"]) && isdefined(param_00.var_B372[var_06]["icon"].shader) && param_00.var_B372[var_06]["icon"].shader != "veh_hud_target_marked")
			{
				param_00.var_B372[var_06]["icon"].shader = "veh_hud_target_marked";
				param_00.var_B372[var_06]["icon"] setshader("veh_hud_target_marked",10,10);
				param_00.var_B372[var_06]["icon"] setwaypoint(0,0,0,0);
			}

			continue;
		}

		if(isplayer(var_05))
		{
			var_09 = isdefined(var_05.var_10916) && gettime() - var_05.var_10916 / 1000 <= 5;
			var_0A = var_05 scripts\mp\_utility::_hasperk("specialty_blindeye");
			var_0B = 0;
			var_0C = 0;
		}
		else
		{
			var_09 = 0;
			var_0A = 0;
			var_0B = isdefined(var_07.var_3A9D);
			var_0C = isdefined(var_06.var_9E78) && var_06.var_9E78 == 1;
		}

		if(!isdefined(param_00.var_B372[var_06]) && !var_09 && !var_0A && !var_0B && !var_0C)
		{
			param_00.var_B372[var_06] = [];
			param_00.var_B372[var_06]["player"] = var_05;
			param_00.var_B372[var_06]["icon"] = var_05 scripts\mp\_entityheadicons::func_F73D(self,var_08,var_07,10,10,0,0.05,0,0,0,0);
			param_00.var_B372[var_06]["icon"].shader = var_08;
			if(!isdefined(var_05.var_F26E) || !isdefined(var_05.var_12A9A))
			{
				param_00.var_B372[var_06]["icon"] settargetent(var_05);
			}
		}

		if(((!isdefined(var_03) || var_03 != var_05) && isdefined(param_00.var_11A7B["entity"]) && param_00.var_11A7B["entity"] == var_05 && !var_0B && !var_0C) || distance(var_05.origin,param_02) < 200 * param_00.var_11A7B["fraction"] && !var_09 && !var_0B && !var_0C || !var_0C && func_DF8B(param_00,var_05))
		{
			var_0D = bullettrace(param_00.origin,var_05.origin + (0,0,32),1,param_00);
			if((isdefined(var_0D["entity"]) && var_0D["entity"] == var_05) || var_0D["fraction"] == 1)
			{
				self playlocalsound("recondrone_lockon");
				var_03 = var_05;
			}
		}
	}

	return var_03;
}

//Function Number: 26
func_DF8B(param_00,param_01)
{
	if(isdefined(param_01.var_12AFA))
	{
		var_02 = anglestoforward(self getplayerangles());
		var_03 = vectornormalize(param_01.origin - param_00 gettagorigin("tag_turret"));
		var_04 = vectordot(var_02,var_03);
		if(var_04 > 0.985)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 27
func_DF96(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	level endon("game_ended");
	param_00 endon("end_remote");
	wait(1);
	self notifyonplayercommand("remoteUAV_tag","+attack");
	self notifyonplayercommand("remoteUAV_tag","+attack_akimbo_accessible");
	for(;;)
	{
		self waittill("remoteUAV_tag");
		if(isdefined(self.var_AEFB))
		{
			self playlocalsound("recondrone_tag");
			scripts\mp\_damagefeedback::func_12E84("");
			thread func_DFA1(self.var_AEFB);
			thread func_DFA8(param_00,3);
			wait(0.25);
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 28
func_DFA8(param_00,param_01)
{
	self endon("disconnect");
	param_00 endon("death");
	level endon("game_ended");
	param_00 endon("end_remote");
	param_00 notify("end_rumble");
	param_00 endon("end_rumble");
	for(var_02 = 0;var_02 < param_01;var_02++)
	{
		self playrumbleonentity("damage_heavy");
		wait(0.05);
	}
}

//Function Number: 29
func_DFA1(param_00)
{
	level endon("game_ended");
	param_00.var_12AF4 = self;
	if(isplayer(param_00) && !param_00 scripts\mp\_utility::func_9FC6())
	{
		param_00 playlocalsound("player_hit_while_ads_hurt");
		param_00 thread scripts\mp\_flashgrenades::func_20CA(2,1);
		param_00 thread scripts\mp\_rank::func_EC2D("marked_by_remote_uav");
	}
	else if(isdefined(param_00.var_12AFA))
	{
		param_00.var_2B0C = param_00.var_64;
	}
	else if(isdefined(param_00.var_222) && isalive(param_00.var_222))
	{
		param_00.var_222 thread scripts\mp\_rank::func_EC2D("turret_marked_by_remote_uav");
	}

	func_DF91("tag");
	if(level.gametype != "dm")
	{
		if(isplayer(param_00))
		{
			thread scripts\mp\_utility::func_83B4("kill");
		}
	}

	if(isplayer(param_00))
	{
		param_00 method_8320("specialty_radarblip",1);
	}
	else
	{
		if(isdefined(param_00.var_12AFA))
		{
			var_01 = "compassping_enemy_uav";
		}
		else
		{
			var_01 = "compassping_sentry_enemy";
		}

		if(level.teambased)
		{
			var_02 = scripts\mp\objidpoolmanager::requestminimapid(1);
			if(var_02 != -1)
			{
				scripts\mp\objidpoolmanager::minimap_objective_add(var_02,"invisible",(0,0,0));
				scripts\mp\objidpoolmanager::minimap_objective_onentity(var_02,param_00);
				scripts\mp\objidpoolmanager::minimap_objective_state(var_02,"active");
				scripts\mp\objidpoolmanager::minimap_objective_team(var_02,self.team);
				scripts\mp\objidpoolmanager::minimap_objective_icon(var_02,var_01);
			}

			param_00.var_DFAF = var_02;
		}
		else
		{
			var_02 = scripts\mp\objidpoolmanager::requestminimapid(1);
			if(var_02 != -1)
			{
				scripts\mp\objidpoolmanager::minimap_objective_add(var_02,"invisible",(0,0,0));
				scripts\mp\objidpoolmanager::minimap_objective_onentity(var_02,param_00);
				scripts\mp\objidpoolmanager::minimap_objective_state(var_02,"active");
				scripts\mp\objidpoolmanager::minimap_objective_team(var_02,level.var_C74B[self.team]);
				scripts\mp\objidpoolmanager::minimap_objective_icon(var_02,var_01);
			}

			param_00.var_DFB0 = var_02;
			var_02 = scripts\mp\objidpoolmanager::requestminimapid(1);
			if(var_02 != -1)
			{
				scripts\mp\objidpoolmanager::minimap_objective_add(var_02,"invisible",(0,0,0));
				scripts\mp\objidpoolmanager::minimap_objective_onentity(var_02,param_00);
				scripts\mp\objidpoolmanager::minimap_objective_state(var_02,"active");
				scripts\mp\objidpoolmanager::minimap_objective_team(var_02,self.team);
				scripts\mp\objidpoolmanager::minimap_objective_icon(var_02,var_01);
			}

			param_00.var_DFB1 = var_02;
		}
	}

	param_00 thread func_DFAC(self.var_DF8A);
}

//Function Number: 30
func_DFA5(param_00)
{
	func_DF91("assist");
	if(level.gametype != "dm")
	{
		self.var_113FF = 1;
		if(isdefined(param_00))
		{
			thread scripts\mp\_gamescore::func_D98C(param_00);
			return;
		}

		thread scripts\mp\_utility::func_83B4("assist");
	}
}

//Function Number: 31
func_DFAC(param_00)
{
	level endon("game_ended");
	var_01 = scripts\common\utility::func_13734("death","disconnect","carried","leaving");
	if(var_01 == "leaving" || !isdefined(self.var_12AFA))
	{
		self.var_12AF4 = undefined;
	}

	if(isdefined(param_00))
	{
		if(isplayer(self))
		{
			var_02 = self.var_86BD;
		}
		else if(isdefined(self.var_64))
		{
			var_02 = self.var_64;
		}
		else
		{
			var_02 = self.var_2B0C;
		}

		if(var_01 == "carried" || var_01 == "leaving")
		{
			param_00.var_B372[var_02]["icon"] destroy();
			param_00.var_B372[var_02]["icon"] = undefined;
		}

		if(isdefined(var_02) && isdefined(param_00.var_B372[var_02]))
		{
			param_00.var_B372[var_02] = undefined;
			param_00.var_B372 = scripts\common\utility::func_22BC(param_00.var_B372);
		}
	}

	if(isplayer(self))
	{
		self method_83CC("specialty_radarblip",1);
		return;
	}

	if(isdefined(self.var_DFAF))
	{
		scripts\mp\objidpoolmanager::returnminimapid(self.var_DFAF);
	}

	if(isdefined(self.var_DFB0))
	{
		scripts\mp\objidpoolmanager::returnminimapid(self.var_DFB0);
	}

	if(isdefined(self.var_DFB1))
	{
		scripts\mp\objidpoolmanager::returnminimapid(self.var_DFB1);
	}
}

//Function Number: 32
func_DF8F()
{
	foreach(var_01 in self.var_B372)
	{
		if(isdefined(var_01["icon"]))
		{
			var_01["icon"] destroy();
			var_01["icon"] = undefined;
		}
	}

	self.var_B372 = undefined;
}

//Function Number: 33
func_DFA3(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	level endon("game_ended");
	param_00 endon("end_remote");
	for(;;)
	{
		self playrumbleonentity("damage_light");
		wait(0.5);
	}
}

//Function Number: 34
func_DFAD()
{
	self endon("death");
	self.var_DCD0 = getent("remote_uav_range","targetname");
	if(!isdefined(self.var_DCD0))
	{
		var_00 = getent("airstrikeheight","targetname");
		self.var_B4A3 = var_00.origin[2];
		self.var_B492 = 12800;
	}

	self.var_3BB7 = spawn("script_model",level.var_B32E);
	var_01 = self.origin;
	self.var_DCCE = 0;
	for(;;)
	{
		if(!func_DF9C())
		{
			var_02 = 0;
			while(!func_DF9C())
			{
				self.var_222 func_DF91("out_of_range");
				if(!self.var_DCCE)
				{
					self.var_DCCE = 1;
					thread func_DFA6();
				}

				if(isdefined(self.var_8DBD))
				{
					var_03 = distance(self.origin,self.var_8DBD.origin);
					var_02 = 1 - var_03 - 150 / 150;
				}
				else
				{
					var_03 = distance(self.origin,var_01);
					var_02 = min(1,var_03 / 200);
				}

				self.var_222 setplayerdata("reconDroneState","staticAlpha",var_02);
				wait(0.05);
			}

			self notify("in_range");
			self.var_DCCE = 0;
			thread func_DFA9(var_02);
		}

		var_01 = self.origin;
		wait(0.05);
	}
}

//Function Number: 35
func_DF9C()
{
	if(isdefined(self.var_DCD0))
	{
		if(!self istouching(self.var_DCD0) && !self.var_94D1)
		{
			return 1;
		}
	}
	else if(distance2d(self.origin,level.var_B32E) < self.var_B492 && self.origin[2] < self.var_B4A3 && !self.var_94D1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
func_DFA9(param_00)
{
	self endon("death");
	while(func_DF9C())
	{
		param_00 = param_00 - 0.05;
		if(param_00 < 0)
		{
			self.var_222 setplayerdata("reconDroneState","staticAlpha",0);
			break;
		}

		self.var_222 setplayerdata("reconDroneState","staticAlpha",param_00);
		wait(0.05);
	}
}

//Function Number: 37
func_DFA6()
{
	self endon("death");
	self endon("in_range");
	if(isdefined(self.var_8DBD))
	{
		var_00 = 3;
	}
	else
	{
		var_00 = 6;
	}

	scripts\mp\_hostmigration::func_13708(var_00);
	self notify("death");
}

//Function Number: 38
func_DF95()
{
	self endon("death");
	self.var_222 waittill("disconnect");
	self notify("death");
}

//Function Number: 39
func_DF93()
{
	self endon("death");
	self.var_222 scripts\common\utility::waittill_any_3("joined_team","joined_spectators");
	self notify("death");
}

//Function Number: 40
func_DF8D()
{
	self endon("death");
	level waittill("game_ended");
	func_DF8F();
}

//Function Number: 41
func_DF9F()
{
	self endon("death");
	var_00 = 60;
	scripts\mp\_hostmigration::func_13708(var_00);
	thread func_DF9E();
}

//Function Number: 42
func_DF9E()
{
	level endon("game_ended");
	self endon("death");
	self notify("leaving");
	self.var_222 func_DF92(self);
	self notify("death");
}

//Function Number: 43
func_DF94()
{
	level endon("game_ended");
	self waittill("death");
	self playsound("recondrone_destroyed");
	playfx(level.var_DF98["explode"],self.origin);
	func_DF8C();
}

//Function Number: 44
func_DF8C()
{
	if(self.var_D3D3 == 1 && isdefined(self.var_222))
	{
		self.var_222 func_DF92(self);
	}

	if(isdefined(self.var_EC9C))
	{
		self.var_EC9C delete();
	}

	if(isdefined(self.var_3BB7))
	{
		self.var_3BB7 delete();
	}

	func_DF8F();
	stopfxontag(level.var_DF98["smoke"],self,"tag_origin");
	level.var_DF74[self.team] = undefined;
	scripts\mp\_utility::func_4FC1();
	self delete();
}

//Function Number: 45
func_DFA0()
{
	playfxontag(level.var_3F19["light"]["belly"],self,"tag_light_nose");
	wait(0.05);
	playfxontag(level.var_3F19["light"]["tail"],self,"tag_light_tail1");
}

//Function Number: 46
func_DF91(param_00)
{
	if(param_00 == "tag")
	{
		var_01 = 1000;
	}
	else
	{
		var_01 = 5000;
	}

	if(gettime() - level.var_DF9D < var_01)
	{
		return;
	}

	level.var_DF9D = gettime();
	var_02 = randomint(level.var_DF91[param_00].size);
	var_03 = level.var_DF91[param_00][var_02];
	var_04 = scripts\mp\_teams::func_81BC(self.team) + var_03;
	self playlocalsound(var_04);
}

//Function Number: 47
func_DF9B()
{
	level endon("game_ended");
	self endon("death");
	self endon("end_remote");
	for(;;)
	{
		level waittill("stinger_fired",var_00,var_01,var_02);
		if(!isdefined(var_01) || !isdefined(var_02) || var_02 != self)
		{
			continue;
		}

		self.var_222 playlocalsound("javelin_clu_lock");
		self.var_222 setplayerdata("reconDroneState","incomingMissile",1);
		self.var_8C01 = 1;
		self.var_93DB[self.var_93DB.size] = var_01;
		var_01.var_222 = var_00;
		var_01 thread func_13B5F(var_02);
	}
}

//Function Number: 48
func_DF9A()
{
	level endon("game_ended");
	self endon("death");
	self endon("end_remote");
	for(;;)
	{
		level waittill("sam_fired",var_00,var_01,var_02);
		if(!isdefined(var_02) || var_02 != self)
		{
			continue;
		}

		var_03 = 0;
		foreach(var_05 in var_01)
		{
			if(isdefined(var_05))
			{
				self.var_93DB[self.var_93DB.size] = var_05;
				var_05.var_222 = var_00;
				var_03++;
			}
		}

		if(var_03)
		{
			self.var_222 playlocalsound("javelin_clu_lock");
			self.var_222 setplayerdata("reconDroneState","incomingMissile",1);
			self.var_8C01 = 1;
			level thread func_13B30(var_02,var_01);
		}
	}
}

//Function Number: 49
func_13B5F(param_00)
{
	level endon("game_ended");
	self endon("death");
	self missile_settargetent(param_00);
	var_01 = vectornormalize(param_00.origin - self.origin);
	while(isdefined(param_00))
	{
		var_02 = param_00 method_8159(0,0,0);
		var_03 = distance(self.origin,var_02);
		if(param_00.var_C22B > 0 && var_03 < 4000)
		{
			var_04 = param_00 func_5231();
			self missile_settargetent(var_04);
			return;
		}
		else
		{
			var_04 = vectornormalize(var_01.origin - self.origin);
			if(vectordot(var_04,var_02) < 0)
			{
				self playsound("exp_stinger_armor_destroy");
				playfx(level.var_DF98["missile_explode"],self.origin);
				if(isdefined(self.var_222))
				{
					radiusdamage(self.origin,400,1000,1000,self.var_222,"MOD_EXPLOSIVE","stinger_mp");
				}
				else
				{
					radiusdamage(self.origin,400,1000,1000,undefined,"MOD_EXPLOSIVE","stinger_mp");
				}

				self hide();
				wait(0.05);
				self delete();
				continue;
			}

			var_02 = var_04;
		}

		wait(0.05);
	}
}

//Function Number: 50
func_13B30(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("death");
	foreach(var_03 in param_01)
	{
		if(isdefined(var_03))
		{
			var_03 missile_settargetent(param_00);
			var_03.var_AA41 = vectornormalize(param_00.origin - var_03.origin);
		}
	}

	while(param_01.size && isdefined(param_00))
	{
		var_05 = param_00 method_8159(0,0,0);
		foreach(var_0D, var_03 in param_01)
		{
			if(isdefined(var_03))
			{
				if(isdefined(self.var_B37B))
				{
					self delete();
					continue;
				}

				if(param_00.var_C22B > 0)
				{
					var_07 = distance(var_03.origin,var_05);
					if(var_07 < 4000)
					{
						var_08 = param_00 func_5231();
						foreach(var_0A in param_01)
						{
							if(isdefined(var_0A))
							{
								var_0A missile_settargetent(var_08);
							}
						}

						return;
					}

					continue;
				}

				var_0C = vectornormalize(var_04.origin - var_0D.origin);
				if(vectordot(var_0C,var_0D.var_AA41) < 0)
				{
					var_0D playsound("exp_stinger_armor_destroy");
					playfx(level.var_DF98["missile_explode"],var_0D.origin);
					if(isdefined(var_0D.var_222))
					{
						radiusdamage(var_0D.origin,400,1000,1000,var_0D.var_222,"MOD_EXPLOSIVE","stinger_mp");
					}
					else
					{
						radiusdamage(var_0D.origin,400,1000,1000,undefined,"MOD_EXPLOSIVE","stinger_mp");
					}

					var_0D hide();
					var_0D.var_B37B = 1;
				}
				else
				{
					var_0D.var_AA41 = var_0C;
				}
			}
		}

		var_05 = scripts\common\utility::func_22BC(var_05);
		wait(0.05);
	}
}

//Function Number: 51
func_5231()
{
	self.var_C22B--;
	self.var_222 thread func_DFA8(self,6);
	self playsound("WEAP_SHOTGUNATTACH_FIRE_NPC");
	thread func_D47A();
	var_00 = self.origin + (0,0,-100);
	var_01 = spawn("script_origin",var_00);
	var_01.angles = self.angles;
	var_01 movegravity((0,0,-1),5);
	var_01 thread func_51A6(5);
	return var_01;
}

//Function Number: 52
func_D47A()
{
	for(var_00 = 0;var_00 < 5;var_00++)
	{
		if(!isdefined(self))
		{
			return;
		}

		playfxontag(level._effect["vehicle_flares"],self,"TAG_FLARE");
		wait(0.15);
	}
}

//Function Number: 53
func_51A6(param_00)
{
	wait(param_00);
	self delete();
}

//Function Number: 54
func_DF8E()
{
	level endon("game_ended");
	self endon("death");
	self endon("end_remote");
	for(;;)
	{
		var_00 = 0;
		for(var_01 = 0;var_01 < self.var_93DB.size;var_01++)
		{
			if(isdefined(self.var_93DB[var_01]) && func_B80A(self.var_93DB[var_01],self))
			{
				var_00++;
			}
		}

		if(self.var_8C01 && !var_00)
		{
			self.var_8C01 = 0;
			self.var_222 setplayerdata("reconDroneState","incomingMissile",0);
		}

		self.var_93DB = scripts\common\utility::func_22BC(self.var_93DB);
		wait(0.05);
	}
}

//Function Number: 55
func_B80A(param_00,param_01)
{
	var_02 = vectornormalize(param_01.origin - param_00.origin);
	var_03 = anglestoforward(param_00.angles);
	return vectordot(var_02,var_03) > 0;
}

//Function Number: 56
func_DFAE()
{
	level endon("game_ended");
	self endon("death");
	self endon("end_remote");
	for(;;)
	{
		var_00 = 0;
		foreach(var_02 in level.var_8DD3)
		{
			if(distance(var_02.origin,self.origin) < 300)
			{
				var_00 = 1;
				self.var_8DBD = var_02;
			}
		}

		foreach(var_05 in level.var_AD8B)
		{
			if(var_05 != self && !isdefined(var_05.var_8DD9) || var_05.var_8DD9 != "remote_uav" && distance(var_05.origin,self.origin) < 300)
			{
				var_00 = 1;
				self.var_8DBD = var_05;
			}
		}

		if(!self.var_94D1 && var_00)
		{
			self.var_94D1 = 1;
		}
		else if(self.var_94D1 && !var_00)
		{
			self.var_94D1 = 0;
			self.var_8DBD = undefined;
		}

		wait(0.05);
	}
}

//Function Number: 57
func_DF99()
{
	self endon("end_remote");
	scripts\mp\_damage::func_B9C6(self.maxhealth,"remote_uav",::func_898F,::func_B938,1);
}

//Function Number: 58
func_B938(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	var_05 = scripts\mp\_damage::func_8999(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_89C6(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8975(param_01,param_02,var_05);
	playfxontagforclients(level.var_DF98["hit"],self,"tag_origin",self.var_222);
	self playsound("recondrone_damaged");
	if(self.var_1037E == 0 && self.var_E1 >= self.maxhealth / 2)
	{
		self.var_1037E = 1;
		playfxontag(level.var_DF98["smoke"],self,"tag_origin");
	}

	return var_05;
}

//Function Number: 59
func_898F(param_00,param_01,param_02,param_03)
{
	scripts\mp\_damage::func_C548("remote_uav",param_00,param_01,param_02,param_03,"destroyed_remote_uav",undefined,"callout_destroyed_remote_uav");
}