/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_playerlogic.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 79
 * Decompile Time: 3026 ms
 * Timestamp: 10/27/2023 12:21:15 AM
*******************************************************************/

//Function Number: 1
func_1193B(param_00)
{
	if(!self.var_8C2A)
	{
		return 0;
	}

	var_01 = gettime() + param_00 * 1000;
	var_02 = level.var_AA44[self.pers["team"]];
	var_03 = level.var_13BDE[self.pers["team"]] * 1000;
	var_04 = var_01 - var_02 / var_03;
	var_05 = ceil(var_04);
	var_06 = var_02 + var_05 * var_03;
	if(isdefined(self.var_E29A))
	{
		var_07 = gettime() - self.var_E29A / 1000;
		if(self.var_E29A < var_02)
		{
			return 0;
		}
	}

	if(isdefined(self.var_13BE5))
	{
		var_06 = var_06 + 50 * self.var_13BE5;
	}

	return var_06 - gettime() / 1000;
}

//Function Number: 2
func_115D4()
{
	var_00 = self.pers["teamkills"];
	if(level.var_B47A < 0 || var_00 <= level.var_B47A)
	{
		return 0;
	}

	var_01 = var_00 - level.var_B47A;
	return scripts\mp\_tweakables::func_81E7("team","teamkillspawndelay") * var_01;
}

//Function Number: 3
func_1193A(param_00)
{
	if((level.ingraceperiod && !self.var_8C2A) || level.var_7669)
	{
		return 0;
	}

	var_01 = 0;
	if(self.var_8C2A)
	{
		var_02 = self [[ level.var_C583 ]]();
		if(isdefined(var_02))
		{
			var_01 = var_02;
		}
		else
		{
			var_01 = getdvarfloat("scr_" + level.gametype + "_playerrespawndelay");
		}

		if(param_00 && isdefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"])
		{
			var_01 = var_01 + func_115D4();
		}

		if(isdefined(self.var_E29A))
		{
			var_03 = gettime() - self.var_E29A / 1000;
			var_01 = var_01 - var_03;
			if(var_01 < 0)
			{
				var_01 = 0;
			}
		}

		if(isdefined(self.var_F851))
		{
			var_01 = var_01 + level.var_11946;
		}
	}

	var_04 = getdvarint("scr_" + level.gametype + "_waverespawndelay") > 0;
	if(var_04)
	{
		return func_1193B(var_01);
	}

	return var_01;
}

//Function Number: 4
func_B4EE()
{
	if(scripts\mp\_utility::func_9FB3(level.var_C1C3))
	{
		return 0;
	}

	if(scripts\mp\_utility::func_7ECE() || isdefined(level.var_5611))
	{
		if(isdefined(level.var_5611) && level.var_5611)
		{
			return 0;
		}

		if(scripts\mp\_utility::func_9FB3(self.pers["teamKillPunish"]))
		{
			return 0;
		}

		if(self.pers["lives"] <= 0 && scripts\mp\_utility::func_7672())
		{
			return 0;
		}
		else if(scripts\mp\_utility::func_7672())
		{
			if(level.ingraceperiod && !self.var_8C2A)
			{
				return 1;
			}

			if(!level.ingraceperiod && !self.var_8C2A && isdefined(level.var_1C9A) && !level.var_1C9A)
			{
				if(isdefined(self.var_101D9) && !self.var_101D9)
				{
					return 1;
				}

				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 5
func_1083A()
{
	self endon("becameSpectator");
	if(isdefined(self.var_136FE) && self.var_136FE)
	{
		self waittill("okToSpawn");
	}

	if(isdefined(self.var_185F))
	{
		scripts\mp\_menus::func_185F(self.var_185F);
		self.var_185F = undefined;
	}

	if(!func_B4EE())
	{
		wait(0.05);
		var_00 = self.origin;
		var_01 = self.angles;
		self notify("attempted_spawn");
		if(scripts\mp\_utility::func_9FB3(self.pers["teamKillPunish"]))
		{
			self.pers["teamkills"] = max(self.pers["teamkills"] - 1,0);
			scripts\mp\_utility::setlowermessage("friendly_fire",&"MP_FRIENDLY_FIRE_WILL_NOT");
			if(!self.var_8C2A && self.pers["teamkills"] <= level.var_B47A)
			{
				self.pers["teamKillPunish"] = 0;
			}
		}
		else if(scripts\mp\_utility::func_9F32() && game["finalRound"] == 0)
		{
			if(isdefined(self.var_113EF) && self.var_113EF)
			{
				scripts\mp\_utility::setlowermessage("spawn_info",game["strings"]["spawn_tag_wait"]);
			}
			else if(level.gametype == "siege")
			{
				scripts\mp\_utility::setlowermessage("spawn_info",game["strings"]["spawn_point_capture_wait"]);
			}
			else
			{
				scripts\mp\_utility::setlowermessage("spawn_info",game["strings"]["spawn_next_round"]);
			}

			thread func_E170(3);
		}

		if(self.sessionstate != "spectator")
		{
			var_00 = var_00 + (0,0,60);
		}

		if(scripts\mp\_utility::func_9FC6())
		{
			self.var_108DB = 1;
			self.var_4E55 = self.origin;
			self waittill("stopped_using_remote");
		}

		if(!scripts\mp\_utility::func_9FB3(level.var_C1C3))
		{
			thread func_10911(var_00,var_01);
		}

		return;
	}

	if(self.var_136FF)
	{
		return;
	}

	self.var_136FF = 1;
	func_1369D();
	if(isdefined(self))
	{
		self.var_136FF = 0;
	}
}

//Function Number: 6
func_1369D()
{
	self endon("disconnect");
	self endon("end_respawn");
	level endon("game_ended");
	self notify("attempted_spawn");
	var_00 = 0;
	if(scripts\mp\_utility::func_9FB3(self.pers["teamKillPunish"]))
	{
		var_01 = func_115D4();
		if(var_01 > 0)
		{
			scripts\mp\_utility::setlowermessage("friendly_fire",&"MP_FRIENDLY_FIRE_WILL_NOT",var_01,1,1);
			thread func_E285(self.origin + (0,0,60),self.angles);
			var_00 = 1;
			wait(var_01);
			scripts\mp\_utility::clearlowermessage("friendly_fire");
			self.var_E29A = gettime();
		}

		self.pers["teamKillPunish"] = 0;
	}
	else if(func_115D4())
	{
		self.pers["teamkills"] = max(self.pers["teamkills"] - 1,0);
	}

	if(scripts\mp\_utility::func_9FC6())
	{
		self.var_108DB = 1;
		self.var_4E55 = self.origin;
		self waittill("stopped_using_remote");
		if(scripts\mp\_utility::func_9FB3(level.var_C1C3))
		{
			return;
		}
	}

	if(!isdefined(self.var_13BE5) && isdefined(level.var_13BE0[self.team]))
	{
		self.var_13BE5 = level.var_13BE0[self.team];
		level.var_13BE0[self.team]++;
	}

	var_02 = func_1193A(0);
	thread func_D81E(var_02);
	if(scripts\mp\_utility::isinarbitraryup())
	{
		var_03 = self getworldupreferenceangles();
		var_04 = anglestoup(var_03);
		var_05 = var_04 * 60;
	}
	else
	{
		var_05 = (0,0,60);
	}

	if(var_02 > 0)
	{
		scripts\mp\_utility::setlowermessage("spawn_info",game["strings"]["waiting_to_spawn"],var_02,1,1);
		if(!var_00)
		{
			thread func_E285(self.origin + var_05,self.angles);
		}

		var_00 = 1;
		scripts\mp\_utility::func_136EF(var_02,"force_spawn");
		if(!scripts\mp\_utility::func_9FB3(self.var_136FE))
		{
			self notify("stop_wait_safe_spawn_button");
		}
	}

	if(func_BE8F())
	{
		if(!scripts\mp\_utility::func_9FB3(self.var_136FE))
		{
			scripts\mp\_utility::setlowermessage("spawn_info",game["strings"]["press_to_spawn"],undefined,undefined,undefined,undefined,undefined,undefined,1);
		}

		if(!var_00)
		{
			thread func_E285(self.origin + var_05,self.angles);
		}

		var_00 = 1;
		func_1370E();
	}

	waitclassselected();
	if(isbot(self))
	{
		if(!scripts\mp\bots\_bots::func_2DDF())
		{
			self waittill("bot_ready_to_spawn");
		}
	}

	self.var_136FF = 0;
	scripts\mp\_utility::clearlowermessage("spawn_info");
	self.var_13BE5 = undefined;
	thread func_108F2();
}

//Function Number: 7
waitclassselected()
{
	while(scripts\mp\_utility::func_9FB3(self.var_136FE))
	{
		wait(0.05);
	}
}

//Function Number: 8
func_BE8F()
{
	if(scripts\mp\_tweakables::func_81E7("player","forcerespawn") != 0)
	{
		return 0;
	}

	if(!self.var_8C2A)
	{
		return 0;
	}

	var_00 = getdvarint("scr_" + level.gametype + "_waverespawndelay") > 0;
	if(var_00)
	{
		return 0;
	}

	if(self.var_138DD)
	{
		return 0;
	}

	return 1;
}

//Function Number: 9
func_1370E()
{
	self endon("disconnect");
	self endon("end_respawn");
	for(;;)
	{
		if(self usebuttonpressed())
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 10
func_E170(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	waittillframeend;
	self endon("end_respawn");
	wait(param_00);
	scripts\mp\_utility::clearlowermessage("spawn_info");
}

//Function Number: 11
func_AA0D()
{
	self laststandrevive();
	if(scripts\mp\_utility::_hasperk("specialty_finalstand") && !level.var_54CC)
	{
		scripts\mp\_utility::func_E150("specialty_finalstand");
	}

	if(level.var_54CC)
	{
		self.var_16F = "";
	}

	self setstance("crouch");
	self.var_E4A8 = 1;
	self notify("revive");
	if(isdefined(self.var_10B67))
	{
		self.maxhealth = self.var_10B67;
	}

	self.health = self.maxhealth;
	scripts\common\utility::func_1C6E(1);
	if(game["state"] == "postgame")
	{
		scripts\mp\_gamelogic::func_7386();
	}
}

//Function Number: 12
func_7E63()
{
	var_00 = spawn("script_origin",self.origin);
	var_00 hide();
	var_00.angles = self.angles;
	return var_00;
}

//Function Number: 13
func_D81E(param_00)
{
	if(!0)
	{
		return;
	}

	self endon("disconnect");
	self endon("spawned");
	self endon("used_predicted_spawnpoint");
	self notify("predicting_about_to_spawn_player");
	self endon("predicting_about_to_spawn_player");
	if(param_00 <= 0)
	{
		return;
	}

	if(param_00 > 1)
	{
		wait(param_00 - 1);
	}

	func_D81D();
	self predictstreampos(self.var_D820.origin + (0,0,60),self.var_D820.angles);
	self.var_D821 = gettime();
	for(var_01 = 0;var_01 < 30;var_01++)
	{
		wait(0.4);
		var_02 = self.var_D820;
		func_D81D();
		if(self.var_D820 != var_02)
		{
			self predictstreampos(self.var_D820.origin + (0,0,60),self.var_D820.angles);
			self.var_D821 = gettime();
		}
	}
}

//Function Number: 14
func_D81D()
{
	if(func_1193A(1) > 1)
	{
		self.var_D820 = func_8148();
		return;
	}

	if(isdefined(self.var_F851))
	{
		self.var_D820 = self.var_F851;
		return;
	}

	var_00 = self [[ level.var_8136 ]]();
	self.var_D820 = var_00;
}

//Function Number: 15
func_3E42(param_00)
{
	self notify("used_predicted_spawnpoint");
	self.var_D820 = undefined;
}

//Function Number: 16
func_CA12(param_00,param_01)
{
	return param_00 + " (" + int(param_00 / param_01 * 100) + "%)";
}

//Function Number: 17
func_D919()
{
}

//Function Number: 18
func_8135(param_00)
{
	if(!positionwouldtelefrag(param_00.origin))
	{
		return param_00.origin;
	}

	if(!isdefined(param_00.var_1D53))
	{
		return param_00.origin;
	}

	foreach(var_02 in param_00.var_1D53)
	{
		if(!positionwouldtelefrag(var_02))
		{
			return var_02;
		}
	}

	return param_00.origin;
}

//Function Number: 19
func_119A9()
{
	if(!isdefined(self.var_F851))
	{
		return 0;
	}

	var_00 = getentarray("care_package","targetname");
	foreach(var_02 in var_00)
	{
		if(distance(var_02.origin,self.var_F851.var_D424) > 64)
		{
			continue;
		}

		if(isdefined(var_02.var_222))
		{
			scripts\mp\_hud_message::func_10151("destroyed_insertion",undefined,var_02.var_222);
		}

		scripts\mp\perks\_perkfunctions::func_51D7(self.var_F851);
		return 0;
	}

	var_04 = [];
	var_04[0] = self;
	var_04[1] = self.var_F851;
	var_05 = scripts\common\trace::func_48BC(1,1,1,0,0,1,1);
	if(!scripts\common\trace::func_DCF1(self.var_F851.origin + (0,0,60),self.var_F851.origin,var_04,var_05))
	{
		return 0;
	}

	var_06 = self.var_F851.origin + (0,0,1);
	var_07 = playerphysicstrace(var_06,self.var_F851.origin + (0,0,-16));
	if(var_06[2] == var_07[2])
	{
		return 0;
	}

	return 1;
}

//Function Number: 20
func_108DC()
{
	self notify("spawningClientThisFrameReset");
	self endon("spawningClientThisFrameReset");
	wait(0.05);
	level.var_C23D--;
}

//Function Number: 21
func_806C(param_00,param_01)
{
	var_02 = scripts\mp\_class::func_AE31();
	var_02 = scripts\mp\_class::func_AE48(var_02,param_01);
	scripts\mp\_class::func_AE4C(var_02);
	self.var_400E = var_02;
	self.var_400F = 1;
	if(var_02.var_AE89 != "none")
	{
		param_00.var_D8E1 = var_02.var_AE89;
	}

	if(var_02.var_AE9D != "none")
	{
		param_00.var_F0C4 = var_02.var_AE9D;
	}

	var_03 = scripts\mp\_teams::func_7E55();
	if(isdefined(var_03["body"]))
	{
		param_00.var_2C09 = var_03["body"];
	}

	if(isdefined(var_03["head"]))
	{
		param_00.var_8C59 = var_03["head"];
	}
}

//Function Number: 22
func_AEAD(param_00,param_01)
{
	var_02 = [];
	if(isdefined(param_00.var_D8E1))
	{
		var_02[var_02.size] = param_00.var_D8E1;
	}

	if(isdefined(param_00.var_F0C4))
	{
		var_02[var_02.size] = param_00.var_F0C4;
	}

	if(var_02.size > 0)
	{
		self loadweaponsforplayer(var_02,param_01);
	}

	self loadcustomization(param_00.var_2C09,param_00.var_8C59,param_01);
}

//Function Number: 23
func_1CB6(param_00)
{
	var_01 = [];
	if(isdefined(param_00.var_D8E1))
	{
		var_01[var_01.size] = param_00.var_D8E1;
	}

	if(isdefined(param_00.var_F0C4))
	{
		var_01[var_01.size] = param_00.var_F0C4;
	}

	if(!self hasloadedviewweapons(var_01))
	{
		return 0;
	}

	if(!self hasloadedcustomizationviewmodels(param_00.var_2C09))
	{
		return 0;
	}

	return 1;
}

//Function Number: 24
func_108F2(param_00)
{
	self endon("disconnect");
	self endon("joined_spectators");
	self notify("spawned");
	self notify("end_respawn");
	self notify("started_spawnPlayer");
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = undefined;
	self.var_1189A = 0;
	self setclientomnvar("ui_options_menu",0);
	self setclientomnvar("ui_hud_shake",0);
	self.var_A9A6 = undefined;
	self.var_4C87 = undefined;
	self.killsteakvariantattackerinfo = undefined;
	self.cratemantle = undefined;
	if(!level.ingraceperiod && !self.var_8BE9)
	{
		level.var_C23D++;
		if(level.var_C23D > 1)
		{
			self.var_13700 = 1;
			wait(0.05 * level.var_C23D - 1);
		}

		thread func_108DC();
		self.var_13700 = 0;
	}

	var_02 = spawnstruct();
	func_806C(var_02,self.var_4004);
	func_AEAD(var_02,1);
	if(!getomnvar("ui_prematch_period"))
	{
		if(!func_1CB6(var_02))
		{
			var_03 = scripts\mp\_tweakables::func_81E7("player","streamingwaittime");
			var_04 = var_03 * 1000;
			var_05 = gettime() + var_04;
			self.var_13700 = 1;
			wait(0.1);
			while(!func_1CB6(var_02))
			{
				wait(0.1);
				if(gettime() > var_05)
				{
					break;
				}
			}

			self.var_13700 = 0;
		}
	}

	if(isdefined(self.var_72E2))
	{
		var_06 = self.var_72E2;
		self.var_72E2 = undefined;
		if(isdefined(self.var_72E0))
		{
			var_07 = self.var_72E0;
			self.var_72E0 = undefined;
		}
		else
		{
			var_07 = (0,randomfloatrange(0,360),0);
		}
	}
	else if(isdefined(self.var_F851) && isdefined(self.var_F851.var_C188) || func_119A9())
	{
		var_06 = self.var_F851;
		if(!isdefined(self.var_F851.var_C188))
		{
			self.var_1189A = 1;
			self playlocalsound("tactical_spawn");
			if(level.multiteambased)
			{
				foreach(var_09 in level.teamnamelist)
				{
					if(var_09 != self.team)
					{
						self playsoundtoteam("tactical_spawn",var_09);
					}
				}
			}
			else if(level.teambased)
			{
				self playsoundtoteam("tactical_spawn",level.var_C74B[self.team]);
			}
			else
			{
				self playsound("tactical_spawn");
			}
		}

		foreach(var_0C in level.var_12B14)
		{
			if(distancesquared(var_0C.origin,var_01.var_D424) < 1024)
			{
				var_0C notify("damage",5000,var_0C.var_222,(0,0,0),(0,0,0),"MOD_EXPLOSIVE","","","",undefined,"killstreak_jammer_mp");
			}
		}

		var_06 = self.var_F851.var_D424;
		var_07 = self.var_F851.angles;
		if(isdefined(self.var_F851.var_6578))
		{
			self.var_F851.var_6578 delete();
		}

		self.var_F851 delete();
		var_01 = undefined;
	}
	else if(isdefined(self.var_9F69) && isdefined(self.var_28CC))
	{
		var_06 = undefined;
		var_07 = undefined;
		var_0E = scripts\mp\_battlebuddy::func_3DF5();
		if(var_0E.var_10E5B == 0)
		{
			var_06 = var_0E.origin;
			var_07 = var_0E.angles;
		}
		else
		{
			var_01 = self [[ level.var_8136 ]]();
			var_06 = var_01.origin;
			var_07 = var_01.angles;
		}

		scripts\mp\_battlebuddy::func_40E7();
		self setclientomnvar("cam_scene_name","battle_spawn");
		self setclientomnvar("cam_scene_lead",self.var_28CC getentitynumber());
		self setclientomnvar("cam_scene_support",self getentitynumber());
	}
	else if(isdefined(self.var_8DD8) && !isdefined(self.var_6DED) || isdefined(self.var_6DED) && self.var_6DED && level.var_D84D > 0 && self.team == "allies")
	{
		while(!isdefined(level.var_1C29))
		{
			wait(0.1);
		}

		var_06 = level.var_1C29.origin;
		var_07 = level.var_1C29.angles;
		self.var_6DED = 0;
	}
	else if(isdefined(self.var_8DD8) && !isdefined(self.var_6DED) || isdefined(self.var_6DED) && self.var_6DED && level.var_D84D > 0 && self.team == "axis")
	{
		while(!isdefined(level.var_26F5))
		{
			wait(0.1);
		}

		var_06 = level.var_26F5.origin;
		var_07 = level.var_26F5.angles;
		self.var_6DED = 0;
	}
	else
	{
		var_06 = self [[ level.var_8136 ]]();
		var_06 = var_06.origin;
		var_07 = var_02.angles;
	}

	func_F853();
	var_0F = self.var_8C2A;
	self.var_6BA7 = undefined;
	if(!param_00)
	{
		self.var_A684 = [];
		self.var_A685 = [];
		self.var_A6B4 = [];
		scripts\mp\_utility::func_12F19("playing");
		scripts\mp\_utility::func_41BF();
		self.var_3881 = undefined;
		self.maxhealth = scripts\mp\_tweakables::func_81E7("player","maxhealth");
		self.health = self.maxhealth;
		self.var_7408 = undefined;
		self.var_8C2A = 1;
		self.var_10916 = gettime();
		self.var_1391E = !isdefined(var_01);
		self.var_18DF = 0;
		self.var_4D44 = [];
		self.killstreakscaler = 1;
		self.var_C2AD = 1;
		self.var_4000 = undefined;
		self.var_FC96 = 0;
		self.var_FC97 = 0;
		self.var_FC95 = 0;
		self.var_DDCC = 0;
		self.var_AA43 = undefined;
		self.var_AC68 = 0;
		if(isdefined(self.pers["deaths"]))
		{
			self.var_AC68 = self.pers["deaths"];
		}

		scripts\mp\_utility::func_41A6();
		scripts\mp\_killcam::clearkillcamomnvars();
		thread monitorwallrun();
	}

	self.var_BCF6 = 1;
	self.inlaststand = 0;
	self.var_1B3 = undefined;
	self.var_94A2 = undefined;
	self.var_93BB = undefined;
	if(!param_00)
	{
		self.var_26B9 = 4;
		var_10 = self.pers["lives"];
		if(var_10 == scripts\mp\_utility::func_7ECE())
		{
			func_1853();
		}

		if(var_10)
		{
			self.pers["lives"]--;
		}

		func_1845();
		if(!var_0F || scripts\mp\_utility::func_7672() || scripts\mp\_utility::func_7672() && level.ingraceperiod && self.var_8BE9)
		{
			func_E112();
		}

		if(!self.var_13906)
		{
			var_11 = 20;
			if(scripts\mp\_utility::func_81CA() > 0 && var_11 < scripts\mp\_utility::func_81CA() * 60 / 4)
			{
				var_11 = scripts\mp\_utility::func_81CA() * 60 / 4;
			}

			if(level.ingraceperiod || scripts\mp\_utility::func_81CB() < var_11 * 1000)
			{
				self.var_13906 = 1;
			}
		}
	}

	self setdepthoffield(0,0,512,512,4,0);
	if(level.console)
	{
		self setclientdvar("cg_fov","63");
	}

	if(isdefined(var_01))
	{
		scripts\mp\_spawnlogic::func_6C5B(var_01);
		var_06 = func_8135(var_01);
		var_07 = var_01.angles;
	}
	else if(!isdefined(self.var_6BA5))
	{
		self.var_A9F6 = gettime();
	}

	self.var_108FF = var_06;
	if(param_00 && scripts\mp\_gameobjects::touchingarbitraryuptrigger())
	{
		if(self isonground())
		{
			self normalizeworldupreferenceangles();
			var_06 = var_06 - (0,0,80);
		}

		var_07 = self getworldupreferenceangles();
	}

	self spawn(var_06,var_07);
	if(param_00 && isdefined(self.var_6BA6))
	{
		self setstance(self.var_6BA6);
		self.var_6BA6 = undefined;
	}

	if(isai(self))
	{
		scripts\mp\_utility::func_7385(1);
	}

	self motionblurhqenable();
	[[ level.onspawnplayer ]]();
	if(isdefined(var_01))
	{
		func_3E42(var_01.origin);
	}

	if(!param_00)
	{
		if(isai(self) && isdefined(level.var_2D9E) && isdefined(level.var_2D9E["player_spawned"]))
		{
			self [[ level.var_2D9E["player_spawned"] ]]();
		}

		if(!isai(self))
		{
			thread func_13A6C();
		}

		if(isdefined(level.var_B3FB))
		{
			[[ level.var_B3FB ]](self.var_41F0,self.team,"SPAWN",self.var_108FF[0],self.var_108FF[1],self.var_10916);
		}

		if(!isai(self))
		{
			if(!isdefined(self.pers["distTrackingPassed"]))
			{
				thread totaldisttracking(var_06);
			}

			thread stancespamtracking();
		}
	}

	if(!param_00)
	{
		self.var_B3E3 = scripts\mp\_matchdata::func_AFD6();
		self.lastmatchdatakillstreakindex = -1;
		thread func_DDED();
		if(self ishost())
		{
			setmatchdata("players",self.var_41F0,"wasAHost",1);
		}
	}

	scripts\mp\_class::func_F691(self.var_4004);
	if(isdefined(level.var_4C55))
	{
		self [[ level.var_4C55 ]](param_00);
	}
	else
	{
		scripts\mp\_class::func_8379(self.team,self.var_4004);
	}

	self method_84BE("player_mp");
	if(isdefined(game["roundsPlayed"]) && game["roundsPlayed"] > 0)
	{
		if(!isdefined(self.var_400D) || !self.var_400D)
		{
			if(isdefined(self.var_4006))
			{
				self setclientomnvar("ui_loadout_selected",self.var_4006);
				self.var_400D = 1;
			}
		}
	}

	if(getdvarint("camera_thirdPerson"))
	{
		scripts\mp\_utility::setthirdpersondof(1);
	}

	if(!scripts\mp\_utility::func_766C("prematch_done"))
	{
		func_1CA2(self);
	}
	else
	{
		scripts\mp\_utility::func_7385(0);
	}

	if(scripts\mp\_utility::func_7F1D("scr_showperksonspawn",1) == 1 && game["state"] != "postgame")
	{
		scripts\mp\perks\_perks::func_F7C5("ui_spawn_perk_",self.pers["loadoutPerks"]);
		self setclientomnvar("ui_spawn_abilities_show",1);
	}

	waittillframeend;
	self.var_108DB = undefined;
	self notify("spawned_player");
	level notify("player_spawned",self);
	thread func_F850();
	if(game["state"] == "postgame")
	{
		scripts\mp\_gamelogic::func_7386();
	}

	if(scripts\mp\_analyticslog::func_1E6A() && !param_00)
	{
		if(scripts\mp\_analyticslog::func_1E5E())
		{
			level.var_10841 = level.var_10841 + 1;
		}
		else
		{
			scripts\mp\_analyticslog::func_1E60();
		}

		if(scripts\mp\_analyticslog::func_1E65(level.var_10841))
		{
			if(isdefined(level.var_108D1.var_108FD))
			{
				scripts\mp\_analyticslog::func_1E66(self,self.var_108FD,level.var_10841,var_01);
				scripts\mp\_analyticslog::func_1E68(var_01.origin,self.team,self.var_AC68,level.var_10841);
				scripts\mp\_analyticslog::func_1E67(self,var_01.origin,level.var_10841);
			}
		}

		self.var_A9F4 = var_01;
	}
}

//Function Number: 25
func_F850()
{
	self endon("disconnect");
	scripts\common\utility::func_136F7();
	self setclientomnvar("ui_player_spawned_notify",gettime());
}

//Function Number: 26
func_DDED()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(scripts\mp\_matchdata::func_38C6(self))
	{
		for(;;)
		{
			var_00 = self.var_B3E3;
			if(!isdefined(var_00))
			{
				var_00 = -1;
			}

			var_01 = scripts\mp\_utility::func_9EE8();
			var_02 = scripts\mp\_matchdata::func_81C8(gettime());
			var_03 = var_02 / 1000;
			self method_8571(var_03,var_00,var_01);
			wait(2);
		}
	}
}

//Function Number: 27
func_1CA2(param_00)
{
	param_00 allowmovement(0);
	param_00 scripts\common\utility::func_1C46(0);
	param_00 scripts\common\utility::func_1C58(0);
	param_00 scripts\common\utility::allow_jump(0);
	param_00.var_D84C = 1;
}

//Function Number: 28
func_41D1(param_00)
{
	if(scripts\common\utility::istrue(param_00.var_D84C))
	{
		param_00 allowmovement(1);
		param_00 scripts\common\utility::func_1C46(1);
		param_00 scripts\common\utility::func_1C58(1);
		param_00 scripts\common\utility::allow_jump(1);
		param_00.var_D84C = undefined;
	}
}

//Function Number: 29
waitforversusmenudone()
{
	level endon("prematch_over");
	self endon("versus_menu_done");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "versus_done")
		{
			self notify("versus_menu_done");
		}
	}
}

//Function Number: 30
func_10912(param_00)
{
	var_01 = 6;
	self endon("disconnect");
	if(isai(self))
	{
		return;
	}

	if(level.splitscreen || self issplitscreenplayer())
	{
		self setclientdvars("cg_fovscale","0.65");
	}
	else
	{
		self setclientdvars("cg_fovscale","1");
	}

	self setclientomnvar("ui_mapshot_camera",1);
	self lerpfovbypreset("mapflyover");
	var_02 = scripts\common\utility::getstructarray("camera_intro","targetname");
	if(var_02.size == 0)
	{
		self visionsetfadetoblackforplayer("",0.75);
		return;
	}

	var_03 = undefined;
	var_04 = undefined;
	func_F853();
	scripts\mp\_utility::clearlowermessage("spawn_info");
	scripts\mp\_utility::func_12F19("spectator");
	self.pers["team"] = "spectator";
	self.team = "spectator";
	scripts\mp\_utility::func_41BF();
	self.var_7408 = undefined;
	func_E27B();
	self allowspectateteam("allies",0);
	self allowspectateteam("axis",0);
	self allowspectateteam("freelook",0);
	self allowspectateteam("none",0);
	if(isdefined(var_02) && var_02.size > 1)
	{
		var_05 = randomintrange(0,var_02.size - 1);
		var_03 = var_02[var_05];
	}
	else if(isdefined(var_02))
	{
		var_03 = var_02[0];
	}
	else
	{
	}

	var_03.var_6C01 = 1;
	scripts\mp\_utility::func_7385(1);
	self setspectatedefaults(var_03.origin,var_03.angles);
	self spawn(var_03.origin,var_03.angles);
	func_3E42(var_03.origin);
	var_06 = spawn("script_model",var_03.origin);
	var_06 setmodel("tag_origin");
	var_06.angles = var_03.angles;
	thread waitforversusmenudone();
	if(isdefined(param_00) && param_00 == 99)
	{
		var_07 = "debug";
	}
	else if(scripts\mp\_utility::func_766C("prematch_done"))
	{
		var_07 = "prematch_over";
	}
	else if(self.versusdone)
	{
		var_07 = "versus_menu_done";
	}
	else
	{
		var_07 = scripts\common\utility::waittill_any_timeout_1(2,"versus_menu_done","prematch_over");
	}

	if(var_07 == "timeout")
	{
		if(scripts\mp\_utility::func_766C("prematch_done"))
		{
			var_07 = "prematch_over";
		}
		else
		{
			var_07 = "versus_menu_done";
		}
	}

	if(var_07 == "prematch_over")
	{
		self visionsetfadetoblackforplayer("",0.75);
		return;
	}

	if(self issplitscreenplayer() && self issplitscreenplayerprimary())
	{
		var_08 = self getothersplitscreenplayer();
		var_08 notify("versus_menu_done");
		wait(0.05);
	}

	self cameralinkto(var_06,"tag_origin");
	var_09 = scripts\mp\_utility::func_7F8B();
	self notify("mapCamera_start");
	switch(var_09)
	{
		case "mp_parkour":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_parkour",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_frontier":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_frontier",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_fallen":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_fallen",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_proto":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_proto",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_metropolis":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_metropolis",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_dome_iw":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_dome_iw",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_breakneck":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_breakneck",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_desert":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_desert",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_divide":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_divide",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_quarry":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_quarry",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_skyway":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_skyway",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_rivet":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_rivet",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_riot":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_riot",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_dome_dusk":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_dome_iw",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_geneva":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_geneva",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_renaissance2":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_geneva",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_afghan":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_afghan",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_neon":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_neon",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_prime":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_prime",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_flip":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_flip",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_mansion":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_mansion",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_marsoasis":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_marsoasis",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_junk":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_junk",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_turista2":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_marsoasis",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_overflow":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_overflow",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_permafrost2":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_overflow",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_nova":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_nova",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_paris":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_paris",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_pixel":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_pixel",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_hawkwar":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_hawkwar",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_rally":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_rally",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_carnage2":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_rally",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_depot":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_depot",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		case "mp_codphish":
			var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_codphish",1);
			self visionsetfadetoblackforplayer("",0.75);
			self playlocalsound("mp_camera_intro_whoosh");
			wait(var_01 - 0.25);
			break;

		default:
			break;
	}

	wait(0.25);
	self visionsetfadetoblackforplayer("",0.75);
	self playlocalsound("mp_camera_intro_whoosh");
	var_0A = var_03;
	var_04 = scripts\common\utility::getstruct(var_03.target,"targetname");
	var_0B = 0;
	for(;;)
	{
		if(isdefined(var_0A.var_10992))
		{
			var_0C = 1 / var_0A.var_10992;
			var_0D = var_0C * distance(var_0A.origin,var_04.origin);
		}
		else
		{
			var_0D = distance(var_0A.origin,var_04.origin);
		}

		var_0B = var_0B + var_0D;
		var_0A.var_5708 = var_0D;
		var_0A = var_04;
		if(isdefined(var_0A.target))
		{
			var_04 = scripts\common\utility::getstruct(var_0A.target,"targetname");
			continue;
		}

		break;
	}

	var_0A.var_666E = 1;
	var_0A = var_03;
	var_04 = scripts\common\utility::getstruct(var_03.target,"targetname");
	for(;;)
	{
		var_0E = var_0A.var_5708 / var_0B;
		var_0F = var_0E * var_01;
		if(isdefined(var_04.var_666E))
		{
			var_10 = var_0F / 2;
		}
		else
		{
			var_10 = 0;
		}

		if(isdefined(var_0A.var_6C01))
		{
			var_11 = var_0F / 2;
		}
		else
		{
			var_11 = 0;
		}

		var_06 moveto(var_04.origin,var_0F,var_11,var_10);
		var_06 rotateto(var_04.angles,var_0F,var_11,var_10);
		if(isdefined(var_04.var_666E))
		{
			var_12 = int(var_0F / 2);
			wait(var_12);
			wait(var_12);
		}
		else
		{
			wait(var_0F);
		}

		var_0A = var_04;
		if(isdefined(var_0A.target))
		{
			var_04 = scripts\common\utility::getstruct(var_0A.target,"targetname");
			continue;
		}

		break;
	}

	scripts\mp\_utility::func_7385(0);
	self.var_10D78 = var_06;
	self setclientomnvar("ui_mapshot_camera",0);
}

//Function Number: 31
func_10911(param_00,param_01)
{
	self notify("spawned");
	self notify("end_respawn");
	self notify("joined_spectators");
	if(isdefined(self.deathspectatepos))
	{
		param_00 = self.deathspectatepos;
		param_01 = vectortoangles(self.origin - self.deathspectatepos);
	}

	if(isdefined(self.var_10D78) && !isdefined(param_00))
	{
		param_00 = self.var_10D78.origin;
		param_01 = self.var_10D78.angles;
		self.var_10D78 delete();
	}

	func_93A5(param_00,param_01);
}

//Function Number: 32
func_E285(param_00,param_01)
{
	if(isdefined(self.deathspectatepos))
	{
		param_00 = self.deathspectatepos;
		param_01 = vectortoangles(self.origin - self.deathspectatepos);
	}

	func_93A5(param_00,param_01);
}

//Function Number: 33
func_93A5(param_00,param_01)
{
	func_F853();
	var_02 = self.pers["team"];
	if(isdefined(var_02) && var_02 == "spectator" && !level.var_7669)
	{
		scripts\mp\_utility::clearlowermessage("spawn_info");
	}

	scripts\mp\_utility::func_12F19("spectator");
	scripts\mp\_utility::func_41BF();
	self.var_7408 = undefined;
	func_E27B();
	scripts\mp\_spectating::func_F857();
	func_C5A0(param_00,param_01);
	if(level.teambased && !level.splitscreen && !self issplitscreenplayer())
	{
		self setdepthoffield(0,128,512,4000,6,1.8);
	}
}

//Function Number: 34
func_8072(param_00)
{
	if(param_00 < 0)
	{
		return undefined;
	}

	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		if(level.players[var_01] getentitynumber() == param_00)
		{
			return level.players[var_01];
		}
	}

	return undefined;
}

//Function Number: 35
func_C5A0(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		self setspectatedefaults(param_00,param_01);
		self spawn(param_00,param_01);
		func_3E42(param_00);
		return;
	}

	var_02 = func_8148();
	var_03 = 8;
	if(isdefined(level.var_37C8) && level.var_37C8.size)
	{
		for(var_04 = 0;var_04 < level.camerahighestindex + 1 && var_04 < var_03;var_04++)
		{
			if(!isdefined(level.var_37C8[var_04]) || !isdefined(level.var_37C1[var_04]))
			{
				continue;
			}

			self setmlgcameradefaults(var_04,level.var_37C8[var_04],level.var_37C1[var_04]);
			level.var_37C3[var_04].origin = level.var_37C8[var_04];
			level.var_C215[var_04].origin = level.var_37C8[var_04];
			level.var_37C3[var_04].angles = level.var_37C1[var_04];
			level.var_C215[var_04].angles = level.var_37C1[var_04];
		}
	}
	else
	{
		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			self setmlgcameradefaults(var_04,var_02.origin,var_02.angles);
		}
	}

	self setspectatedefaults(var_02.origin,var_02.angles);
	self spawn(var_02.origin,var_02.angles);
	func_3E42(var_02.origin);
}

//Function Number: 36
func_8148()
{
	var_00 = getentarray("mp_global_intermission","classname");
	var_01 = scripts\mp\_spawnlogic::func_813C(var_00);
	return var_01;
}

//Function Number: 37
func_108DD()
{
	self endon("disconnect");
	self notify("spawned");
	self notify("end_respawn");
	func_F853();
	scripts\mp\_utility::clearlowermessages();
	scripts\mp\_utility::func_7385(1);
	self setclientdvar("cg_everyoneHearsEveryone",1);
	if(isdefined(level.var_6C6F) && level.var_6C6F != "none" && isdefined(level.var_B3D9) && scripts\mp\_utility::func_13916() && !scripts\mp\_utility::func_9FB3(level.var_58D7))
	{
		wait(level.var_B3D9);
	}

	if(!scripts\mp\_utility::func_9FB3(level.var_58D7))
	{
		scripts\mp\_utility::func_12F19("intermission");
	}

	scripts\mp\_utility::func_41BF();
	self.var_7408 = undefined;
	var_00 = getentarray("mp_global_intermission","classname");
	var_00 = scripts\mp\_spawnscoring::func_3E05(var_00);
	var_01 = var_00[0];
	if(!isdefined(level.var_4C4E))
	{
		self spawn(var_01.origin,var_01.angles);
		func_3E42(var_01.origin);
		self setdepthoffield(0,128,512,4000,6,1.8);
	}
	else
	{
		level notify("scoreboard_displaying");
	}

	scripts\mp\_utility::func_7385(1);
}

//Function Number: 38
func_10857()
{
	if(1)
	{
		if(isdefined(level.var_4C4E) && scripts\mp\_utility::func_13916())
		{
			level notify("start_custom_ending");
		}

		if(!self.var_45D6)
		{
			scripts\mp\_utility::func_7385(1);
		}

		if(scripts\mp\_utility::func_9FB3(level.var_58D7))
		{
			self notify("spawned");
			scripts\mp\_utility::func_41BF();
		}
		else
		{
			func_10911();
			scripts\mp\_utility::func_7385(1);
		}

		return;
	}

	self notify("spawned");
	self notify("end_respawn");
	func_F853();
	scripts\mp\_utility::clearlowermessages();
	self setclientdvar("cg_everyoneHearsEveryone",1);
	scripts\mp\_utility::func_12F19("dead");
	scripts\mp\_utility::func_41BF();
	self.var_7408 = undefined;
	var_00 = func_8148();
	func_10911(var_00.origin,var_00.angles);
	func_3E42(var_00.origin);
	scripts\mp\_utility::func_7385(1);
	self setdepthoffield(0,0,512,512,4,0);
}

//Function Number: 39
func_F853()
{
	self stopshellshock();
	self stoprumble("damage_heavy");
	self.var_4E55 = undefined;
}

//Function Number: 40
func_C15D()
{
	waittillframeend;
	if(isdefined(self))
	{
		level notify("connecting",self);
	}
}

//Function Number: 41
func_374F(param_00)
{
	if(!isdefined(self.var_452B))
	{
		return;
	}

	if(scripts\mp\_utility::func_9F32())
	{
		setmatchdata("players",self.var_41F0,"playerQuitRoundNumber",game["roundsPlayed"]);
	}

	if(level.teambased)
	{
		if(isdefined(self.team))
		{
			if(self.team == "allies")
			{
				setmatchdata("players",self.var_41F0,"playerQuitTeamScore",getteamscore("allies"));
				setmatchdata("players",self.var_41F0,"playerQuitOppposingTeamScore",getteamscore("axis"));
			}
			else if(self.team == "axis")
			{
				setmatchdata("players",self.var_41F0,"playerQuitTeamScore",getteamscore("axis"));
				setmatchdata("players",self.var_41F0,"playerQuitOppposingTeamScore",getteamscore("allies"));
			}
		}
	}

	setmatchdata("players",self.var_41F0,"utcDisconnectTimeSeconds",function_00D2());
	setmatchdata("players",self.var_41F0,"disconnectReason",param_00);
	self method_859C(self.var_41F0,param_00);
	var_01 = getmatchdata("commonMatchData","playerCountLeft");
	var_01++;
	setmatchdata("commonMatchData","playerCountLeft",var_01);
	if(scripts\mp\_utility::func_DCD5())
	{
		scripts\mp\_matchdata::func_AFB9();
	}

	if(scripts\mp\_utility::func_9D92())
	{
		self method_84E3();
	}

	scripts\mp\_matchdata::func_AFD4();
	if(isdefined(self.pers["confirmed"]))
	{
		scripts\mp\_matchdata::func_AFC6();
	}

	if(isdefined(self.pers["denied"]))
	{
		scripts\mp\_matchdata::func_AFC7();
	}

	func_E15B();
	scripts\mp\_spawnlogic::func_E113();
	scripts\mp\_spawnlogic::func_E106();
	var_02 = self getentitynumber();
	if(!level.teambased)
	{
		game["roundsWon"][self.var_86BD] = undefined;
	}

	if(level.splitscreen)
	{
		var_03 = level.players;
		if(var_03.size <= 1)
		{
			level thread scripts\mp\_gamelogic::func_72BE();
		}
	}

	if(isdefined(self.var_1AB) && isdefined(self.var_E9))
	{
		if(120 < self.var_1190E["total"])
		{
			var_04 = self.var_1AB - self.var_E9 / self.var_1190E["total"] / 60;
			setplayerteamrank(self,self.var_41F0,var_04);
		}
	}
	else
	{
	}

	var_05 = self getentitynumber();
	var_06 = self.var_86BD;
	function_0131("Q;" + var_06 + ";" + var_05 + ";" + self.name + "\n");
	thread scripts\mp\_events::func_5638();
	if(level.var_7669)
	{
		scripts\mp\_gamescore::func_E0ED();
	}

	if(isdefined(self.team))
	{
		func_E11D();
	}

	if(self.sessionstate == "playing" && !isdefined(self.var_6BA7) && self.var_6BA7)
	{
		func_E0FF(1);
		return;
	}

	if(self.sessionstate == "spectator" || self.sessionstate == "dead")
	{
		level thread scripts\mp\_gamelogic::func_12E9D();
	}
}

//Function Number: 42
func_E15B()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		if(level.players[var_01] == self)
		{
			var_00 = 1;
			while(var_01 < level.players.size - 1)
			{
				level.players[var_01] = level.players[var_01 + 1];
				var_01++;
			}

			level.players[var_01] = undefined;
			break;
		}
	}
}

//Function Number: 43
func_97EA()
{
	if(level.splitscreen || self issplitscreenplayer())
	{
		self setclientdvars("cg_fovscale","0.75");
		setdvar("r_materialBloomHQScriptMasterEnable",0);
		return;
	}

	self setclientdvars("cg_fovscale","1");
}

//Function Number: 44
func_97E9()
{
	setdvar("cg_drawCrosshair",1);
	setdvar("cg_drawCrosshairNames",1);
	if(level.var_8B38)
	{
		setdvar("cg_drawCrosshair",0);
		setdvar("cg_drawCrosshairNames",1);
	}

	if(isdefined(level.var_1D5D) && level.var_1D5D)
	{
		setdvar("cg_drawFriendlyNamesAlways",1);
	}
	else
	{
		setdvar("cg_drawFriendlyNamesAlways",0);
	}

	self setclientdvars("cg_drawSpectatorMessages",1);
	func_97EA();
	if(scripts\mp\_utility::func_7ECE())
	{
		self setclientdvars("cg_deadChatWithDead",1,"cg_deadChatWithTeam",0,"cg_deadHearTeamLiving",0,"cg_deadHearAllLiving",0);
	}
	else
	{
		self setclientdvars("cg_deadChatWithDead",0,"cg_deadChatWithTeam",1,"cg_deadHearTeamLiving",1,"cg_deadHearAllLiving",0);
	}

	if(level.teambased)
	{
		self setclientdvars("cg_everyonehearseveryone",0);
	}

	self setclientdvar("ui_altscene",0);
	if(getdvarint("scr_hitloc_debug"))
	{
		for(var_00 = 0;var_00 < 6;var_00++)
		{
			self setclientdvar("ui_hitloc_" + var_00,"");
		}

		self.var_903A = 1;
	}
}

//Function Number: 45
func_7F87()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < 30;var_01++)
	{
		foreach(var_03 in level.players)
		{
			if(!isdefined(var_03))
			{
				continue;
			}

			if(var_03.var_41F0 == var_01)
			{
				var_00 = 1;
				break;
			}

			var_00 = 0;
		}

		if(!var_00)
		{
			return var_01;
		}
	}
}

//Function Number: 46
func_FAE7()
{
	self.var_EB6A = [];
	for(var_00 = 1;var_00 <= 4;var_00++)
	{
		self.var_EB6A[var_00] = spawnstruct();
		self.var_EB6A[var_00].type = "";
		self.var_EB6A[var_00].var_195 = undefined;
	}

	if(!level.console)
	{
		for(var_00 = 5;var_00 <= 8;var_00++)
		{
			self.var_EB6A[var_00] = spawnstruct();
			self.var_EB6A[var_00].type = "";
			self.var_EB6A[var_00].var_195 = undefined;
		}
	}
}

//Function Number: 47
connect_validateplayerteam()
{
	if(!isdefined(self))
	{
		return;
	}

	if(self.sessionteam == "none" && scripts\mp\_utility::func_B3EC() && level.teambased && !isdefined(self.pers["isBot"]) && !self ismlgspectator() && level.gametype != "infect")
	{
		bbprint("mp_invalid_team_error","player_xuid %s isHost %i",self getxuid(),self ishost());
		wait(1.5);
		kick(self getentitynumber(),"EXE_PLAYERKICKED_INVALIDTEAM");
	}
}

//Function Number: 48
queueconnectednotify()
{
	for(;;)
	{
		if(!isdefined(level.players_waiting_for_callback))
		{
			wait(0.05);
			continue;
		}

		break;
	}

	for(;;)
	{
		for(var_00 = 0;var_00 < level.players_waiting_for_callback.size;var_00++)
		{
			var_01 = level.players_waiting_for_callback[var_00];
			if(isdefined(var_01))
			{
				level notify("connected",var_01);
				var_01 notify("connected_continue");
				level.players_waiting_for_callback[var_00] = undefined;
				break;
			}
		}

		var_02 = scripts\mp\_utility::cleanarray(level.players_waiting_for_callback);
		level.players_waiting_for_callback = var_02;
		wait(0.05);
	}
}

//Function Number: 49
watchforversusdone()
{
	self endon("disconnect");
	self.versusdone = 0;
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "versus_done")
		{
			self.versusdone = 1;
			return;
		}
	}
}

//Function Number: 50
monitorplayersegments(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	createplayersegmentstats(param_00);
	for(;;)
	{
		param_00 waittill("spawned_player");
		recordsegmentdata(param_00);
	}
}

//Function Number: 51
createplayersegmentstats(param_00)
{
	param_00.var_F18B = [];
	param_00.var_F18B["distanceTotal"] = 0;
	param_00.var_F18B["movingTotal"] = 0;
	param_00.var_F18B["movementUpdateCount"] = 0;
}

//Function Number: 52
recordsegmentdata(param_00)
{
	param_00 endon("death");
	while(!scripts\mp\_utility::func_766C("prematch_done"))
	{
		wait(0.5);
	}

	wait(4);
	param_00.savedsegmentposition = param_00.origin;
	param_00.positionptm = param_00.origin;
	for(;;)
	{
		wait(1);
		if(param_00 scripts\mp\_utility::func_9FC6())
		{
			param_00 waittill("stopped_using_remote");
			param_00.savedsegmentposition = param_00.origin;
			param_00.positionptm = param_00.origin;
			continue;
		}

		param_00.var_F18B["movementUpdateCount"]++;
		param_00.var_F18B["distanceTotal"] = param_00.var_F18B["distanceTotal"] + distance2d(param_00.savedsegmentposition,param_00.origin);
		param_00.savedsegmentposition = param_00.origin;
		if(param_00.var_F18B["movementUpdateCount"] % 5 == 0)
		{
			var_01 = distance2d(param_00.positionptm,param_00.origin);
			param_00.positionptm = param_00.origin;
			if(var_01 > 16)
			{
				param_00.var_F18B["movingTotal"]++;
			}
		}
	}
}

//Function Number: 53
writesegmentdata(param_00)
{
	param_00 endon("disconnect");
	if(param_00.var_F18B["movementUpdateCount"] < 30)
	{
		return;
	}

	var_01 = param_00.var_F18B["movingTotal"] / param_00.var_F18B["movementUpdateCount"] / 5 * 100;
	var_02 = param_00.var_F18B["distanceTotal"] / param_00.var_F18B["movementUpdateCount"];
	setmatchdata("players",param_00.var_41F0,"averageSpeedDuringMatch",var_02);
	setmatchdata("players",param_00.var_41F0,"percentageOfTimeMoving",var_01);
}

//Function Number: 54
func_374C()
{
	thread func_C15D();
	thread watchforversusdone();
	self.var_2C7 = "hud_status_connecting";
	self waittill("begin");
	self.var_2C7 = "";
	self.var_4539 = undefined;
	self visionsetfadetoblackforplayer("bw",0);
	level.players_waiting_for_callback[level.players_waiting_for_callback.size] = self;
	self waittill("connected_continue");
	self.var_452B = 1;
	self setclientomnvar("ui_scoreboard_freeze",0);
	if(self ishost())
	{
		level.player = self;
	}

	if(!level.splitscreen && !isdefined(self.pers["score"]))
	{
		iprintln(&"MP_CONNECTED",self);
	}

	self.var_13114 = self isusingonlinedataoffline();
	func_97E9();
	func_98BE();
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		level waittill("eternity");
	}

	self.var_86BD = scripts\mp\_utility::func_81EC();
	var_00 = 0;
	var_01 = 0;
	if(!isdefined(self.pers["clientid"]))
	{
		for(var_02 = 0;var_02 < 30;var_02++)
		{
			var_03 = getmatchdata("players",var_02,"playerID","xuid");
			if(var_03 == self.var_86BD)
			{
				self.pers["clientid"] = var_02;
				var_01 = 1;
				var_04 = getmatchdata("commonMatchData","playerCountReconnected");
				var_04++;
				setmatchdata("commonMatchData","playerCountReconnected",var_04);
				setmatchdata("players",var_02,"utcReconnectTimeSeconds",function_00D2());
				break;
			}
		}

		if(!var_01)
		{
			if(game["clientid"] >= 30)
			{
				self.pers["clientid"] = func_7F87();
			}
			else
			{
				self.pers["clientid"] = game["clientid"];
			}

			if(game["clientid"] < 30)
			{
				game["clientid"]++;
			}
		}

		var_00 = 1;
		self.pers["matchdataWeaponStats"] = [];
		self.pers["matchdataScoreEventCounts"] = [];
		self.pers["xpAtLastDeath"] = 0;
		self.pers["scoreAtLastDeath"] = 0;
		self method_8596(self.pers["clientid"]);
		setmatchdata("players",self.pers["clientid"],"joinType",self getjointype());
		setmatchdata("players",self.pers["clientid"],"isTrialVersion",self method_85B4());
	}

	if(var_00)
	{
		scripts\mp\_persistence::func_10E57("round","timePlayed",0,1);
		self setplayerdata("common","round","timePlayed",0);
		self setplayerdata("common","round","totalXp",0);
		self setplayerdata("common","aarUnlockCount",0);
		if(!isdefined(game["uniquePlayerCount"]))
		{
			game["uniquePlayerCount"] = 1;
		}
		else
		{
			game["uniquePlayerCount"]++;
		}
	}

	self.var_41F0 = self.pers["clientid"];
	self.pers["teamKillPunish"] = 0;
	function_0131("J;" + self.var_86BD + ";" + self getentitynumber() + ";" + self.name + "\n");
	self method_85A3();
	var_05 = getmatchdata("commonMatchData","playerCount");
	if(game["clientid"] <= 30 && game["clientid"] != var_05)
	{
		if(!isai(self) && scripts\mp\_utility::func_B3EC())
		{
			self registerparty(self.var_41F0);
		}

		if(var_00 && !var_01)
		{
			var_05++;
			setmatchdata("commonMatchData","playerCount",var_05);
		}

		setmatchdata("players",self.var_41F0,"playerID","xuid",scripts\mp\_utility::func_81EC());
		setmatchdata("players",self.var_41F0,"gamertag",self.name);
		setmatchdata("players",self.var_41F0,"skill",self method_810F());
		setmatchclientip(self,self.var_41F0);
		if(var_00 && !var_01)
		{
			setmatchdata("players",self.var_41F0,"utcConnectTimeSeconds",function_00D2());
		}

		if(scripts\mp\_utility::func_DCD5())
		{
			scripts\mp\_matchdata::func_AFC4();
		}

		if((isdefined(self.pers["isBot"]) && self.pers["isBot"]) || isai(self))
		{
			var_06 = 1;
			setmatchdata("players",self.var_41F0,"isBot",1);
		}
		else
		{
			var_06 = 0;
		}

		if(scripts\mp\_utility::func_B3EC() && scripts\mp\_utility::func_1CAD() && !var_06)
		{
			setmatchdata("players",self.var_41F0,"team",self.sessionteam);
		}

		if(var_00 && isdefined(level.var_B3FD))
		{
			[[ level.var_B3FD ]](self.var_41F0,self.team,self.name);
		}
	}

	if(!level.teambased)
	{
		game["roundsWon"][self.var_86BD] = 0;
	}

	self.var_AAEF = [];
	self.var_AAEB = [];
	self.var_AAE8 = "";
	self.var_AAEA = [];
	self.var_AAE9 = "";
	if(!isdefined(self.pers["cur_kill_streak"]))
	{
		self.pers["cur_kill_streak"] = 0;
	}

	if(!isdefined(self.pers["cur_death_streak"]))
	{
		self.pers["cur_death_streak"] = 0;
	}

	if(!isdefined(self.pers["cur_kill_streak_for_nuke"]))
	{
		self.pers["cur_kill_streak_for_nuke"] = 0;
	}

	if(scripts\mp\_utility::func_DCD5())
	{
		self.var_A61A = scripts\mp\_persistence::func_10E33("killStreak");
	}

	self.var_A991 = -1;
	self.var_115D5 = 0;
	self.var_8C2A = 0;
	self.var_136FF = 0;
	self.var_138DD = 0;
	self.var_13906 = 0;
	self.var_BCF6 = 1;
	self.killstreakscaler = 1;
	self.var_C2AD = 1;
	self.var_6DED = 1;
	self.var_AC68 = 0;
	if(isdefined(self.pers["deaths"]))
	{
		self.var_AC68 = self.pers["deaths"];
	}

	func_FAE7();
	level thread monitorplayersegments(self);
	func_E278();
	waittillframeend;
	level.players[level.players.size] = self;
	scripts\mp\_spawnlogic::func_1855();
	scripts\mp\_spawnlogic::func_184B();
	if(game["state"] == "postgame")
	{
		self.var_4530 = 1;
		self setclientdvars("cg_drawSpectatorMessages",0);
		self visionsetfadetoblackforplayer("",0.25);
		func_108DD();
		return;
	}

	if(var_00 && scripts\mp\_utility::func_81CB() >= -5536 || game["roundsPlayed"] > 0)
	{
		self.var_A49D = 1;
	}

	if(isai(self) && isdefined(level.var_2D9E) && isdefined(level.var_2D9E["think"]))
	{
		self thread [[ level.var_2D9E["think"] ]]();
	}

	level endon("game_ended");
	if(isdefined(level.var_90A9))
	{
		thread scripts\mp\_hostmigration::func_90AA();
	}

	if(isdefined(level.var_C56F))
	{
		[[ level.var_C56F ]]();
	}

	if(!isdefined(self.pers["team"]))
	{
		var_0A = scripts\mp\_utility::func_81CB() / 1000 + 6;
		if(var_0A < level.var_D84D)
		{
			func_10912();
			self lerpfovbypreset("default");
			self setclientomnvar("ui_mapshot_camera",0);
			func_97EA();
			self.pers["team"] = "";
			self.team = "free";
		}
		else
		{
			self visionsetfadetoblackforplayer("",0.5);
		}

		connect_validateplayerteam();
		if(self ismlgspectator())
		{
			thread scripts\mp\_menus::func_F859();
			return;
		}

		if((scripts\mp\_utility::func_B3EC() || scripts\mp\_utility::func_AEB6() || function_0303()) && self.sessionteam != "none")
		{
			thread func_10911();
			thread scripts\mp\_menus::func_F876(self.sessionteam);
			if(scripts\mp\_utility::func_1C7D() || scripts\mp\_utility::func_10125() && !isai(self))
			{
				self setclientomnvar("ui_options_menu",2);
			}

			if(!function_0303())
			{
				thread func_A5AD();
			}

			return;
		}

		if(!scripts\mp\_utility::func_B3EC() && scripts\mp\_utility::func_1CAD())
		{
			scripts\mp\_menus::func_B678();
			self setclientomnvar("ui_options_menu",1);
			return;
		}

		thread func_10911();
		scripts\mp\_menus::func_2642();
		if(scripts\mp\_utility::func_1C7D() || scripts\mp\_utility::func_10125() && !isai(self))
		{
			self setclientomnvar("ui_options_menu",2);
		}

		if(scripts\mp\_utility::func_B3EC())
		{
			thread func_A5AD();
		}

		return;
	}

	self visionsetfadetoblackforplayer("",0.5);
	connect_validateplayerteam();
	var_0B = self.pers["team"];
	if(scripts\mp\_utility::func_B3EC() && !isdefined(self.pers["isBot"]) && !self ismlgspectator() && getdvarint("team_consistency_fix"))
	{
		var_0B = self.sessionteam;
	}

	scripts\mp\_menus::func_185F(var_0B,1);
	if(self ismlgspectator())
	{
		thread func_10911();
		return;
	}

	if(scripts\mp\_utility::func_9FD4(self.pers["class"]))
	{
		thread func_1083A();
		return;
	}

	thread func_10911();
	if(self.pers["team"] == "spectator")
	{
		if(scripts\mp\_utility::func_1CAD())
		{
			scripts\mp\_menus::func_2A7A();
			return;
		}

		self [[ level.var_2642 ]]();
		return;
	}

	scripts\mp\_menus::func_2A61();
}

//Function Number: 55
func_3755()
{
	if(isdefined(self.var_452B) && self.var_452B)
	{
		scripts\mp\_utility::func_12EDC();
		scripts\mp\_utility::func_12EC8();
	}

	if(self ishost())
	{
		func_97EA();
	}

	var_00 = 0;
	foreach(var_02 in level.players)
	{
		if(!isdefined(var_02.pers["isBot"]) || var_02.pers["isBot"] == 0)
		{
			var_00++;
		}
	}

	if(!isdefined(self.pers["isBot"]) || self.pers["isBot"] == 0)
	{
		level.var_90A8++;
		if(level.var_90A8 >= var_00 * 2 / 3)
		{
			level notify("hostmigration_enoughplayers");
		}
	}
}

//Function Number: 56
func_17EA(param_00,param_01)
{
	var_02 = scripts\mp\_rank::func_80C9(param_00);
	var_03 = scripts\mp\_rank::func_80CF(var_02);
	var_04 = scripts\mp\_rank::func_80CE(var_02);
	var_02 = var_02 + param_00 - var_03 / var_04 - var_03;
	var_02 = var_02 + param_01;
	if(var_02 < 0)
	{
		var_02 = 0;
		var_05 = 0;
	}
	else if(var_03 >= level.var_B4C0 + 1)
	{
		var_03 = level.var_B4C0;
		var_05 = 1;
	}
	else
	{
		var_05 = var_03 - floor(var_03);
		var_02 = int(floor(var_02));
	}

	var_03 = scripts\mp\_rank::func_80CF(var_02);
	var_04 = scripts\mp\_rank::func_80CE(var_02);
	return int(var_05 * var_04 - var_03) + var_03;
}

//Function Number: 57
func_72DF()
{
	self endon("death");
	self endon("disconnect");
	self endon("spawned");
	wait(60);
	if(self.var_8C2A)
	{
		return;
	}

	if(self.pers["team"] == "spectator")
	{
		return;
	}

	if(!scripts\mp\_utility::func_9FD4(self.pers["class"]))
	{
		self.pers["class"] = "CLASS_CUSTOM1";
		self.var_4004 = self.pers["class"];
	}

	thread func_1083A();
}

//Function Number: 58
func_A5AD()
{
	self endon("death");
	self endon("disconnect");
	self endon("spawned");
	self endon("attempted_spawn");
	var_00 = getdvarfloat("scr_kick_time",90);
	var_01 = getdvarfloat("scr_kick_mintime",45);
	var_02 = getdvarfloat("scr_kick_hosttime",120);
	var_03 = gettime();
	if(self ishost())
	{
		func_A5AF(var_02);
	}
	else
	{
		func_A5AF(var_00);
	}

	var_04 = gettime() - var_03 / 1000;
	if(var_04 < var_00 - 0.1 && var_04 < var_01)
	{
		return;
	}

	if(self.var_8C2A)
	{
		return;
	}

	if(self.pers["team"] == "spectator")
	{
		return;
	}

	kick(self getentitynumber(),"EXE_PLAYERKICKED_INACTIVE",1);
	level thread scripts\mp\_gamelogic::func_12E9D();
}

//Function Number: 59
func_A5AF(param_00)
{
	level endon("game_ended");
	scripts\mp\_hostmigration::func_13708(param_00);
}

//Function Number: 60
func_BA38()
{
	level endon("game_ended");
	self endon("disconnect");
	self.var_13552 = 0;
	while(self.var_13552 < 2)
	{
		self waittill("voteToKick");
		self.var_13552++;
	}

	kick(self getentitynumber(),"EXE_PLAYERKICKED_TEAMKILLS");
}

//Function Number: 61
func_6B57()
{
	wait(1);
	self notify("voteToKick");
	wait(3);
	self notify("voteToKick");
	wait(2);
	self notify("voteToKick");
}

//Function Number: 62
totaldisttracking(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("spawned");
	self notify("distFromSpawnTracking");
	self endon("distFromSpawnTracking");
	if(!scripts\mp\_utility::func_766C("prematch_done"))
	{
		scripts\mp\_utility::func_7670("prematch_done");
	}

	var_01 = param_00;
	for(;;)
	{
		scripts\common\utility::waittill_notify_or_timeout("death",5);
		if(!isdefined(self.pers["totalDistTraveledSQ"]))
		{
			self.pers["totalDistTraveledSQ"] = 0;
		}

		self.pers["totalDistTraveledSQ"] = self.pers["totalDistTraveledSQ"] + distancesquared(var_01,self.origin);
		var_01 = self.origin;
		if(self.pers["totalDistTraveledSQ"] > 90000)
		{
			self.pers["distTrackingPassed"] = 1;
		}
	}
}

//Function Number: 63
stancespamtracking()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("spawned");
	self notify("stanceSpamTracking");
	self endon("stanceSpamTracking");
	if(!scripts\mp\_utility::func_766C("prematch_done"))
	{
		scripts\mp\_utility::func_7670("prematch_done");
	}

	var_00 = undefined;
	for(;;)
	{
		var_01 = self getstance();
		if(isdefined(var_00) && var_00 != var_01)
		{
			if(!isdefined(self.pers["stanceTracking"]))
			{
				self.pers["stanceTracking"] = [];
				self.pers["stanceTracking"]["prone"] = 0;
				self.pers["stanceTracking"]["crouch"] = 0;
				self.pers["stanceTracking"]["stand"] = 0;
			}

			if(var_01 == "prone" || var_01 == "crouch" || var_01 == "stand")
			{
				self.pers["stanceTracking"][var_01]++;
			}
		}

		var_00 = var_01;
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 64
func_98BE()
{
	scripts\mp\_persistence::func_97E2();
	if(!isdefined(self.pers["deaths"]))
	{
		scripts\mp\_utility::initpersstat("deaths");
		scripts\mp\_persistence::func_10E56("round","deaths",0);
	}

	self.var_E9 = scripts\mp\_utility::getpersstat("deaths");
	if(!isdefined(self.pers["score"]))
	{
		scripts\mp\_utility::initpersstat("score");
		scripts\mp\_persistence::func_10E56("round","score",0);
	}

	self.var_278 = scripts\mp\_utility::getpersstat("score");
	if(!isdefined(self.pers["suicides"]))
	{
		scripts\mp\_utility::initpersstat("suicides");
	}

	self.var_111BB = scripts\mp\_utility::getpersstat("suicides");
	if(!isdefined(self.pers["kills"]))
	{
		scripts\mp\_utility::initpersstat("kills");
		scripts\mp\_persistence::func_10E56("round","kills",0);
	}

	self.var_1AB = scripts\mp\_utility::getpersstat("kills");
	if(!isdefined(self.pers["headshots"]))
	{
		scripts\mp\_utility::initpersstat("headshots");
	}

	self.var_8CA0 = scripts\mp\_utility::getpersstat("headshots");
	if(!isdefined(self.pers["assists"]))
	{
		scripts\mp\_utility::initpersstat("assists");
		scripts\mp\_persistence::func_10E56("round","assists",0);
	}

	self.var_4D = scripts\mp\_utility::getpersstat("assists");
	if(!isdefined(self.pers["captures"]))
	{
		scripts\mp\_utility::initpersstat("captures");
		scripts\mp\_persistence::func_10E56("round","captures",0);
	}

	self.var_3A3F = scripts\mp\_utility::getpersstat("captures");
	if(!isdefined(self.pers["returns"]))
	{
		scripts\mp\_utility::initpersstat("returns");
		scripts\mp\_persistence::func_10E56("round","returns",0);
	}

	self.var_E476 = scripts\mp\_utility::getpersstat("returns");
	if(!isdefined(self.pers["defends"]))
	{
		scripts\mp\_utility::initpersstat("defends");
		scripts\mp\_persistence::func_10E56("round","defends",0);
	}

	self.var_508B = scripts\mp\_utility::getpersstat("defends");
	if(!isdefined(self.pers["plants"]))
	{
		scripts\mp\_utility::initpersstat("plants");
		scripts\mp\_persistence::func_10E56("round","plants",0);
	}

	self.var_CC51 = scripts\mp\_utility::getpersstat("plants");
	if(!isdefined(self.pers["defuses"]))
	{
		scripts\mp\_utility::initpersstat("defuses");
		scripts\mp\_persistence::func_10E56("round","defuses",0);
	}

	self.var_50AA = scripts\mp\_utility::getpersstat("defuses");
	if(!isdefined(self.pers["destructions"]))
	{
		scripts\mp\_utility::initpersstat("destructions");
		scripts\mp\_persistence::func_10E56("round","destructions",0);
	}

	self.var_5383 = scripts\mp\_utility::getpersstat("destructions");
	if(!isdefined(self.pers["confirmed"]))
	{
		scripts\mp\_utility::initpersstat("confirmed");
		scripts\mp\_persistence::func_10E56("round","confirmed",0);
	}

	self.var_4522 = scripts\mp\_utility::getpersstat("confirmed");
	if(!isdefined(self.pers["denied"]))
	{
		scripts\mp\_utility::initpersstat("denied");
		scripts\mp\_persistence::func_10E56("round","denied",0);
	}

	self.var_51E9 = scripts\mp\_utility::getpersstat("denied");
	if(!isdefined(self.pers["rescues"]))
	{
		scripts\mp\_utility::initpersstat("rescues");
		scripts\mp\_persistence::func_10E56("round","rescues",0);
	}

	self.var_E1C2 = scripts\mp\_utility::getpersstat("rescues");
	if(!isdefined(self.pers["touchdowns"]))
	{
		scripts\mp\_utility::initpersstat("touchdowns");
		scripts\mp\_persistence::func_10E56("round","touchdowns",0);
	}

	self.var_11A3E = scripts\mp\_utility::getpersstat("touchdowns");
	if(!isdefined(self.pers["fieldgoals"]))
	{
		scripts\mp\_utility::initpersstat("fieldgoals");
		scripts\mp\_persistence::func_10E56("round","fieldgoals",0);
	}

	self.var_6BDB = scripts\mp\_utility::getpersstat("fieldgoals");
	if(!isdefined(self.pers["killChains"]))
	{
		scripts\mp\_utility::initpersstat("killChains");
		scripts\mp\_persistence::func_10E56("round","killChains",0);
	}

	self.var_A642 = scripts\mp\_utility::getpersstat("killChains");
	if(!isdefined(self.pers["killsAsSurvivor"]))
	{
		scripts\mp\_utility::initpersstat("killsAsSurvivor");
		scripts\mp\_persistence::func_10E56("round","killsAsSurvivor",0);
	}

	self.var_A676 = scripts\mp\_utility::getpersstat("killsAsSurvivor");
	if(!isdefined(self.pers["killsAsInfected"]))
	{
		scripts\mp\_utility::initpersstat("killsAsInfected");
		scripts\mp\_persistence::func_10E56("round","killsAsInfected",0);
	}

	self.var_A675 = scripts\mp\_utility::getpersstat("killsAsInfected");
	if(!isdefined(self.pers["teamkills"]))
	{
		scripts\mp\_utility::initpersstat("teamkills");
	}

	if(!isdefined(self.pers["extrascore0"]))
	{
		scripts\mp\_utility::initpersstat("extrascore0");
	}

	if(!isdefined(self.pers["extrascore1"]))
	{
		scripts\mp\_utility::initpersstat("extrascore1");
	}

	if(!isdefined(self.pers["stabs"]))
	{
		scripts\mp\_utility::initpersstat("stabs");
		scripts\mp\_persistence::func_10E56("round","stabs",0);
	}

	self.var_10B39 = scripts\mp\_utility::getpersstat("stabs");
	if(!isdefined(self.pers["setbacks"]))
	{
		scripts\mp\_utility::initpersstat("setbacks");
		scripts\mp\_persistence::func_10E56("round","setbacks",0);
	}

	self.var_F655 = scripts\mp\_utility::getpersstat("setbacks");
	if(!isdefined(self.pers["objTime"]))
	{
		scripts\mp\_utility::initpersstat("objTime");
		scripts\mp\_persistence::func_10E56("round","objTime",0);
	}

	self.var_C2C5 = scripts\mp\_utility::getpersstat("objTime");
	if(!isdefined(self.pers["gamemodeScore"]))
	{
		scripts\mp\_utility::initpersstat("gamemodeScore");
		scripts\mp\_persistence::func_10E56("round","gamemodeScore",0);
	}

	if(!isdefined(self.pers["supersEarned"]))
	{
		scripts\mp\_utility::initpersstat("supersEarned");
	}

	if(!isdefined(self.pers["wardenKSCount"]))
	{
		scripts\mp\_utility::initpersstat("wardenKSCount");
	}

	if(!isdefined(self.pers["teamKillPunish"]))
	{
		self.pers["teamKillPunish"] = 0;
	}

	scripts\mp\_utility::initpersstat("longestStreak");
	self.pers["lives"] = scripts\mp\_utility::func_7ECE();
	scripts\mp\_persistence::func_10E56("round","killStreak",0);
	scripts\mp\_persistence::func_10E56("round","loss",0);
	scripts\mp\_persistence::func_10E56("round","win",0);
	scripts\mp\_persistence::func_10E56("round","scoreboardType","none");
}

//Function Number: 65
func_1860()
{
	level.var_115C6[self.team]++;
	if(!isdefined(level.var_115D8))
	{
		level.var_115D8 = [];
	}

	if(!isdefined(level.var_115D8[self.team]))
	{
		level.var_115D8[self.team] = [];
	}

	level.var_115D8[self.team][level.var_115D8[self.team].size] = self;
	scripts\mp\_gamelogic::func_12E9D();
}

//Function Number: 66
func_E11D()
{
	level.var_115C6[self.team]--;
	if(isdefined(level.var_115D8) && isdefined(level.var_115D8[self.team]))
	{
		var_00 = [];
		foreach(var_02 in level.var_115D8[self.team])
		{
			if(!isdefined(var_02) || var_02 == self)
			{
				continue;
			}

			var_00[var_00.size] = var_02;
		}

		level.var_115D8[self.team] = var_00;
	}
}

//Function Number: 67
func_1845()
{
	var_00 = self.team;
	if(!isdefined(self.var_1D40) && self.var_1D40)
	{
		level.var_8C2A[var_00]++;
		func_93F8(var_00);
	}

	self.var_1D40 = undefined;
	if(level.var_1BE6["allies"] + level.var_1BE6["axis"] > level.var_B4BC)
	{
		level.var_B4BC = level.var_1BE6["allies"] + level.var_1BE6["axis"];
	}
}

//Function Number: 68
func_93F8(param_00,param_01)
{
	level.var_1BE6[param_00]++;
	if(!isdefined(level.var_1BE5))
	{
		level.var_1BE5 = [];
	}

	if(!isdefined(level.var_1BE5[param_00]))
	{
		level.var_1BE5[param_00] = [];
	}

	level.var_1BE5[param_00] = scripts\common\utility::array_add(level.var_1BE5[param_00],self);
	if(scripts\mp\_utility::func_9FB3(param_01) && param_00 == "allies" || param_00 == "axis")
	{
		var_02 = level.var_C74B[param_00];
		foreach(var_04 in level.players)
		{
			if(var_04.team == param_00)
			{
				var_04 playsoundtoplayer("mp_bodycount_tick_positive",var_04);
				continue;
			}

			if(var_04.team == var_02)
			{
				var_04 playsoundtoplayer("mp_bodycount_tick_negative",var_04);
			}
		}
	}

	scripts\mp\_gamelogic::func_12E9D();
}

//Function Number: 69
func_E0FF(param_00)
{
	var_01 = self.pers["lives"];
	var_02 = scripts\mp\_utility::func_7ECE() != 0 && var_01 == 0;
	var_03 = self.team;
	if(isdefined(self.var_11377) && self.var_11377 && isdefined(self.var_A49E) && self.var_A49E == self.team)
	{
		var_03 = self.var_AB33;
	}

	if(isdefined(param_00))
	{
		func_E0CA();
	}
	else if(isdefined(self.var_11377) && !level.ingraceperiod || self.var_8BE9)
	{
		if(var_01)
		{
			self.pers["lives"]--;
		}
	}

	func_4FBD(var_03,var_02);
}

//Function Number: 70
func_4FBD(param_00,param_01)
{
	level.var_1BE6[param_00]--;
	for(var_02 = 0;var_02 < level.var_1BE5[param_00].size;var_02++)
	{
		if(level.var_1BE5[param_00][var_02] == self)
		{
			level.var_1BE5[param_00][var_02] = level.var_1BE5[param_00][level.var_1BE5[param_00].size - 1];
			level.var_1BE5[param_00][level.var_1BE5[param_00].size - 1] = undefined;
			break;
		}
	}

	if(scripts\mp\_utility::func_9FB3(param_01) && param_00 == "allies" || param_00 == "axis")
	{
		var_03 = level.var_C74B[param_00];
		foreach(var_05 in level.players)
		{
			if(var_05.team == param_00)
			{
				var_05 playsoundtoplayer("mp_bodycount_tick_negative",var_05);
				continue;
			}

			if(var_05.team == var_03)
			{
				var_05 playsoundtoplayer("mp_bodycount_tick_positive",var_05);
			}
		}
	}

	scripts\mp\_gamelogic::func_12E9D();
}

//Function Number: 71
func_1853()
{
	level.var_AD8D[self.team] = level.var_AD8D[self.team] + self.pers["lives"];
}

//Function Number: 72
func_E112()
{
	level.var_AD8D[self.team]--;
	level.var_AD8D[self.team] = int(max(0,level.var_AD8D[self.team]));
}

//Function Number: 73
func_E0CA()
{
	level.var_AD8D[self.team] = level.var_AD8D[self.team] - self.pers["lives"];
	level.var_AD8D[self.team] = int(max(0,level.var_AD8D[self.team]));
}

//Function Number: 74
func_E278()
{
	self setclientomnvar("ui_carrying_bomb",0);
	self setclientomnvar("ui_objective_state",0);
	self setclientomnvar("ui_securing",0);
	self setclientomnvar("ui_light_armor",0);
	self setclientomnvar("ui_killcam_end_milliseconds",0);
	self setclientomnvar("ui_juiced_end_milliseconds",0);
	self setclientdvar("ui_eyes_on_end_milliseconds",0);
	self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",0);
	self setclientomnvar("ui_edge_glow",0);
}

//Function Number: 75
func_E27B()
{
	self setclientomnvar("ui_carrying_bomb",0);
	self setclientomnvar("ui_objective_state",0);
	self setclientomnvar("ui_securing",0);
	self setclientomnvar("ui_light_armor",0);
	self setclientomnvar("ui_killcam_end_milliseconds",0);
	self setclientomnvar("ui_juiced_end_milliseconds",0);
	self setclientdvar("ui_eyes_on_end_milliseconds",0);
	self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",0);
	self setclientomnvar("ui_edge_glow",0);
}

//Function Number: 76
monitorwallrun()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		if(self method_8446())
		{
			self.var_AA43 = gettime();
		}

		wait(0.05);
	}
}

//Function Number: 77
func_13A6C()
{
	self endon("death");
	self endon("disconnect");
	self waittill("sprint_slide_begin");
}

//Function Number: 78
func_13B76()
{
	self endon("death");
	self endon("disconnect");
	self.var_11563 = [];
	for(;;)
	{
		var_00 = (self.origin[0],self.origin[1],self.origin[2] + 64);
		var_01 = self getplayerangles();
		var_02 = anglestoforward(var_01);
		var_03 = var_00 + var_02 * 10000;
		var_04 = bullettrace(var_00,var_03,1,self,0,0,0,0,0);
		var_05 = var_04["entity"];
		if(isdefined(var_05) && isplayer(var_05) && var_05.team != self.team && lib_0DF8::func_213D(self,var_05))
		{
			if(isdefined(var_05))
			{
				func_12F36("ui_target_health",var_05.health);
			}

			if(isdefined(var_05))
			{
				func_12F36("ui_target_max_health",var_05.maxhealth);
			}

			if(isdefined(var_05))
			{
				func_12F36("ui_target_entity_num",var_05 getentitynumber());
			}
		}
		else
		{
			func_12F36("ui_target_entity_num",-1);
		}

		wait(0.1);
	}
}

//Function Number: 79
func_12F36(param_00,param_01)
{
	scripts\common\utility::func_136F7();
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		return;
	}

	if(!isdefined(self.var_11563[param_00]) || param_01 != self.var_11563[param_00])
	{
		self setclientomnvar(param_00,param_01);
		self.var_11563[param_00] = param_01;
	}
}