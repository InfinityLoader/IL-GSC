/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_uav.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 48
 * Decompile Time: 2255 ms
 * Timestamp: 10/27/2023 12:29:53 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_DBD9 = 23;
	level.advradarviewtime = 28;
	level.var_12AF0 = 23;
	scripts\mp\killstreaks\_killstreaks::func_DEFB("uav",::func_1290B);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("counter_uav",::func_1290B);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("directional_uav",::func_1290B);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("uav_3dping",::func_128B2);
	var_00 = ["passive_increased_duration","passive_decreased_duration","passive_decreased_health","passive_increased_armor","passive_increased_cost","passive_extra_assist","passive_stealth_vehicle","passive_vision_sweep","passive_disable_hud","passive_emp_blast","passive_duration_health","passive_armor_speed","passive_stealth_speed"];
	scripts\mp\_killstreak_loot::func_DF07("uav",var_00);
	scripts\mp\_killstreak_loot::func_DF07("counter_uav",var_00);
	scripts\mp\_killstreak_loot::func_DF07("directional_uav",var_00);
	level.var_12AF7 = [];
	level.var_12AF7["uav"] = spawnstruct();
	level.var_12AF7["uav"].var_11901 = level.var_DBD9;
	level.var_12AF7["uav"].health = 999999;
	level.var_12AF7["uav"].maxhealth = 800;
	level.var_12AF7["uav"].var_110EA = "uav";
	level.var_12AF7["uav"].var_B91A = "veh_mil_air_un_uav";
	level.var_12AF7["uav"].var_7630 = loadfx("vfx/iw7/core/mp/killstreaks/vfx_veh_exp_uav.vfx");
	level.var_12AF7["uav"].var_7631 = loadfx("vfx/misc/jet_engine_ac130");
	level.var_12AF7["uav"].var_7637 = loadfx("vfx/core/mp/killstreaks/vfx_3d_world_ping_large");
	level.var_12AF7["uav"].var_75A2 = "tag_origin";
	level.var_12AF7["uav"].var_762F = undefined;
	level.var_12AF7["uav"].var_7566 = undefined;
	level.var_12AF7["uav"].var_1045F = "ball_drone_explode";
	level.var_12AF7["uav"].var_115EB = "used_uav";
	level.var_12AF7["uav"].var_13554 = "uav_timeout";
	level.var_12AF7["uav"].var_377B = "callout_destroyed_uav";
	level.var_12AF7["uav"].var_17C8 = ::func_179A;
	level.var_12AF7["uav"].var_E124 = ::func_E0C1;
	level.var_12AF7["counter_uav"] = spawnstruct();
	level.var_12AF7["counter_uav"].var_11901 = level.var_12AF0;
	level.var_12AF7["counter_uav"].health = 999999;
	level.var_12AF7["counter_uav"].maxhealth = 800;
	level.var_12AF7["counter_uav"].var_110EA = "counter_uav";
	level.var_12AF7["counter_uav"].var_B91A = "veh_mil_air_un_cuav";
	level.var_12AF7["counter_uav"].var_7630 = loadfx("vfx/iw7/core/mp/killstreaks/vfx_veh_exp_uav.vfx");
	level.var_12AF7["counter_uav"].var_7631 = loadfx("vfx/misc/jet_engine_ac130");
	level.var_12AF7["counter_uav"].var_75A2 = "tag_origin";
	level.var_12AF7["counter_uav"].var_762F = undefined;
	level.var_12AF7["counter_uav"].var_7566 = undefined;
	level.var_12AF7["counter_uav"].var_1045F = "ball_drone_explode";
	level.var_12AF7["counter_uav"].var_13554 = "counter_uav_timeout";
	level.var_12AF7["counter_uav"].var_115EB = "used_counter_uav";
	level.var_12AF7["counter_uav"].var_377B = "callout_destroyed_counter_uav";
	level.var_12AF7["counter_uav"].var_17C8 = ::func_1799;
	level.var_12AF7["counter_uav"].var_E124 = ::func_E0BF;
	level.var_12AF7["directional_uav"] = spawnstruct();
	level.var_12AF7["directional_uav"].var_11901 = level.advradarviewtime;
	level.var_12AF7["directional_uav"].health = 999999;
	level.var_12AF7["directional_uav"].maxhealth = 2000;
	level.var_12AF7["directional_uav"].var_110EA = "directional_uav";
	level.var_12AF7["directional_uav"].var_B91A = "veh_mil_air_un_auav";
	level.var_12AF7["directional_uav"].var_7630 = loadfx("vfx/iw7/core/mp/killstreaks/vfx_veh_exp_uav.vfx");
	level.var_12AF7["directional_uav"].var_7631 = loadfx("vfx/misc/jet_engine_ac130");
	level.var_12AF7["directional_uav"].var_75A2 = "tag_origin";
	level.var_12AF7["directional_uav"].var_762F = undefined;
	level.var_12AF7["directional_uav"].var_7566 = "tag_jet_trail";
	level.var_12AF7["directional_uav"].var_1045F = "ball_drone_explode";
	level.var_12AF7["directional_uav"].var_13554 = "directional_uav_timeout";
	level.var_12AF7["directional_uav"].var_115EB = "used_directional_uav";
	level.var_12AF7["directional_uav"].var_377B = "callout_destroyed_directional_uav";
	level.var_12AF7["directional_uav"].var_17C8 = ::func_179A;
	level.var_12AF7["directional_uav"].var_E124 = ::func_E0C1;
	level.var_12AF7["uav_3dping"] = spawnstruct();
	level.var_12AF7["uav_3dping"].var_11901 = 63;
	level.var_12AF7["uav_3dping"].var_110EA = "uav_3dping";
	level.var_12AF7["uav_3dping"].var_8EF7 = 1.5;
	level.var_12AF7["uav_3dping"].var_CB9A = 10;
	level.var_12AF7["uav_3dping"].var_7636 = loadfx("vfx/core/mp/killstreaks/vfx_3d_world_ping");
	level.var_12AF7["uav_3dping"].var_1046A = "oracle_radar_pulse_plr";
	level.var_12AF7["uav_3dping"].var_10469 = "oracle_radar_pulse_npc";
	level.var_12AF7["uav_3dping"].var_13554 = "oracle_gone";
	level.var_12AF7["uav_3dping"].var_115EB = "used_uav_3dping";
	var_01 = getentarray("minimap_corner","targetname");
	if(var_01.size)
	{
		level.var_12AF6 = scripts\mp\_spawnlogic::func_6CAF(var_01[0].origin,var_01[1].origin);
	}
	else
	{
		level.var_12AF6 = (0,0,0);
	}

	level.var_12AF5 = spawn("script_model",level.var_12AF6);
	level.var_12AF5 setmodel("tag_origin");
	level.var_12AF5.angles = (0,115,0);
	level.var_12AF5 hide();
	level.var_12AF5.var_336 = "uavrig_script_model";
	level.var_12AF5 thread func_E734(70);
	level.uavrigslow = spawn("script_model",level.var_12AF6);
	level.uavrigslow setmodel("tag_origin");
	level.uavrigslow.angles = (0,115,0);
	level.uavrigslow hide();
	level.uavrigslow.var_336 = "uavrig_script_model";
	level.uavrigslow thread func_E734(90);
	level.var_46B8 = spawn("script_model",level.var_12AF6);
	level.var_46B8 setmodel("tag_origin");
	level.var_46B8.angles = (0,115,0);
	level.var_46B8 hide();
	level.var_46B8.var_336 = "counteruavrig_script_model";
	level.var_46B8 thread func_E734(80);
	level.var_18D2 = spawn("script_model",level.var_12AF6);
	level.var_18D2 setmodel("tag_origin");
	level.var_18D2.angles = (0,115,0);
	level.var_18D2 hide();
	level.var_18D2.var_336 = "advanceduavrig_script_model";
	level.var_18D2 thread func_E734(60);
	level.advanceduavrigslow = spawn("script_model",level.var_12AF6);
	level.advanceduavrigslow setmodel("tag_origin");
	level.advanceduavrigslow.angles = (0,115,0);
	level.advanceduavrigslow hide();
	level.advanceduavrigslow.var_336 = "advanceduavrig_script_model";
	level.advanceduavrigslow thread func_E734(80);
	var_02 = getuavstrengthlevelneutral();
	if(level.multiteambased)
	{
		for(var_03 = 0;var_03 < level.teamnamelist.size;var_03++)
		{
			level.var_254[level.teamnamelist[var_03]] = "normal_radar";
			level.var_1679[level.teamnamelist[var_03]] = 0;
			level.var_164F[level.teamnamelist[var_03]] = 0;
			level.activeadvanceduavs[level.teamnamelist[var_03]] = 0;
			level.var_12AF3[level.teamnamelist[var_03]] = [];
		}
	}
	else if(level.teambased)
	{
		level.var_254["allies"] = "normal_radar";
		level.var_254["axis"] = "normal_radar";
		level.var_1679["allies"] = 0;
		level.var_1679["axis"] = 0;
		level.var_164F["allies"] = 0;
		level.var_164F["axis"] = 0;
		level.activeadvanceduavs["allies"] = 0;
		level.activeadvanceduavs["axis"] = 0;
		level.var_12AF3["allies"] = [];
		level.var_12AF3["axis"] = [];
	}
	else
	{
		level.var_254 = [];
		level.var_1679 = [];
		level.var_164F = [];
		level.activeadvanceduavs = [];
		level.var_12AF3 = [];
	}

	level thread func_C56E();
	level thread func_12AF9();
}

//Function Number: 2
func_C56E()
{
	var_00 = getuavstrengthlevelneutral();
	for(;;)
	{
		level waittill("connected",var_01);
		scripts\mp\killstreaks\_utility::func_12F51();
		level.var_1679[var_01.var_86BD] = 0;
		level.var_1679[var_01.var_86BD + "_radarStrength"] = var_00;
		level.var_164F[var_01.var_86BD] = 0;
		level.var_254[var_01.var_86BD] = "normal_radar";
		var_01.var_256 = var_00;
		var_01 thread monitorplayerupdate();
	}
}

//Function Number: 3
monitorplayerupdate()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		level notify("uav_update");
	}
}

//Function Number: 4
func_E734(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	if(!isdefined(param_00))
	{
		param_00 = 60;
	}

	if(!isdefined(param_01))
	{
		param_01 = -360;
	}

	for(;;)
	{
		self rotateyaw(param_01,param_00);
		wait(param_00);
	}
}

//Function Number: 5
func_1290B(param_00)
{
	return func_130F4(param_00.var_110EA,param_00);
}

//Function Number: 6
func_128B2(param_00)
{
	var_01 = "uav_3dping";
	thread func_13920(var_01);
	thread func_13921(var_01);
	level thread scripts\mp\_utility::func_115DE(level.var_12AF7[var_01].var_115EB,self);
	return 1;
}

//Function Number: 7
func_130F4(param_00,param_01)
{
	scripts\mp\_matchdata::func_AFC9(param_00,self.origin);
	var_02 = self.pers["team"];
	var_03 = level.var_12AF7[param_00].var_11901;
	level thread func_AAB8(self,param_00,param_01);
	if(!isdefined(self.var_12AF8))
	{
		self.var_12AF8 = [];
	}

	switch(param_00)
	{
		case "counter_uav":
			self notify("used_counter_uav");
			self.var_12AF8["counter_uav"] = 1;
			break;

		case "directional_uav":
			self.var_255 = 1;
			if(level.teambased)
			{
				foreach(var_05 in level.players)
				{
					if(var_05.pers["team"] == var_02)
					{
						var_05.var_255 = 1;
					}
				}
			}
	
			self notify("used_directional_uav");
			self.var_12AF8["directional_uav"] = 1;
			break;

		default:
			self notify("used_uav");
			if(level.teambased)
			{
				var_07 = func_12B5(var_02);
				if(var_07 >= getuavstrengthlevelshowenemyfastsweep())
				{
					scripts\mp\_missions::func_D991("ch_uav_doubleup");
				}
			}
	
			self.var_12AF8["uav"] = 1;
			break;
	}

	if(self.var_12AF8.size == 3)
	{
		self.var_12AF8 = [];
		scripts\mp\_missions::func_D991("ch_uav_combo");
	}

	return 1;
}

//Function Number: 8
func_AAB8(param_00,param_01,param_02)
{
	var_03 = param_00.team;
	var_04 = func_81E8(param_01,param_02);
	var_05 = spawn("script_model",var_04 gettagorigin("tag_origin") + (0,0,5000));
	var_06 = level.var_12AF7[param_01].var_B91A;
	var_07 = level.var_12AF7[param_01].var_11901;
	var_08 = level.var_12AF7[param_01].maxhealth;
	var_09 = level.var_12AF7[param_01].var_115EB;
	var_0A = scripts\mp\_killstreak_loot::getrarityforlootitem(param_02.var_1318B);
	if(var_0A != "")
	{
		var_06 = var_06 + "_" + var_0A;
		var_09 = var_09 + "_" + var_0A;
	}

	level thread scripts\mp\_utility::func_115DE(var_09,param_00);
	if(param_01 == "uav")
	{
		if(scripts\mp\killstreaks\_utility::func_A69F(param_02,"passive_duration_health"))
		{
			var_07 = var_07 + 5;
			var_08 = var_08 - 200;
		}

		if(scripts\mp\killstreaks\_utility::func_A69F(param_02,"passive_armor_speed"))
		{
			var_07 = var_07 - 5;
		}
	}
	else if(param_01 == "counter_uav")
	{
		if(scripts\mp\killstreaks\_utility::func_A69F(param_02,"passive_duration_health"))
		{
			var_07 = var_07 + 5;
			var_08 = var_08 - 200;
		}

		if(scripts\mp\killstreaks\_utility::func_A69F(param_02,"passive_disable_hud"))
		{
			var_07 = var_07 - 10;
		}
	}
	else
	{
		if(scripts\mp\killstreaks\_utility::func_A69F(param_02,"passive_duration_health"))
		{
			var_07 = var_07 + 5;
			var_08 = var_08 - 500;
		}

		if(scripts\mp\killstreaks\_utility::func_A69F(param_02,"passive_vision_sweep"))
		{
			var_07 = var_07 - 5;
		}
	}

	var_05 setmodel(var_06);
	var_05.team = var_03;
	var_05.var_222 = param_00;
	var_05.var_11938 = 0;
	var_05.var_12AFA = param_01;
	var_05.health = level.var_12AF7[param_01].health;
	var_05.maxhealth = var_08;
	var_05.var_110E8 = param_02;
	var_05 method_831F(param_00);
	var_05 method_8549();
	var_05 method_8594();
	var_05 scripts\mp\killstreaks\_utility::func_1843(param_01,"Killstreak_Air",param_00);
	var_05 thread func_4D72();
	var_05 thread func_89B7();
	var_05 thread func_CA50();
	var_05 thread func_B9FF();
	var_05 thread func_E2E4();
	var_05 setscriptablepartstate("lights","on",0);
	if(scripts\mp\killstreaks\_utility::func_A69F(param_02,"passive_stealth_vehicle"))
	{
		var_05 setscriptablepartstate("stealth","active",0);
	}

	var_0B = randomintrange(5250,5500);
	if(isdefined(level.var_108FB))
	{
		var_0C = level.var_108FB;
	}
	else
	{
		var_0C = level.var_10DF1;
	}

	var_0D = var_0C[0];
	foreach(var_0F in var_0C)
	{
		if(var_0F.origin[2] < var_0D.origin[2])
		{
			var_0D = var_0F;
		}
	}

	var_11 = var_0D.origin[2];
	var_12 = var_04.origin[2];
	if(var_11 < 0)
	{
		var_12 = var_12 + var_11 * -1;
		var_11 = 0;
	}

	var_13 = var_12 - var_11;
	if(var_13 + var_0B > 8100)
	{
		var_0B = var_0B - var_13 + var_0B - 8100;
	}

	var_14 = randomint(360);
	var_15 = randomint(1000) + 4000;
	var_16 = cos(var_14) * var_15;
	var_17 = sin(var_14) * var_15;
	var_18 = vectornormalize((var_16,var_17,var_0B));
	var_18 = var_18 * var_0B;
	var_05 linkto(var_04,"tag_origin",var_18,(0,var_14 - 90,0));
	var_05 thread func_12F50();
	var_05 [[ level.var_12AF7[param_01].var_17C8 ]]();
	if(isdefined(level.var_1679[var_03]))
	{
		foreach(var_1A in level.var_12AF3[var_03])
		{
			if(var_1A == var_05)
			{
				continue;
			}

			if(isdefined(var_1A.var_11938))
			{
				var_1A.var_11938 = var_1A.var_11938 + 5;
			}
		}
	}

	var_05 thread handlewiretap();
	if(scripts\mp\killstreaks\_utility::func_A69F(param_02,"passive_disable_hud"))
	{
		var_05 thread startsystemshutdown();
	}

	if(scripts\mp\killstreaks\_utility::func_A69F(param_02,"passive_emp_blast"))
	{
		var_05 thread startemppulse();
	}

	level notify("uav_update");
	var_05 scripts\mp\_hostmigration::func_137B8("death",var_07);
	if(var_05.var_E1 < var_05.maxhealth)
	{
		var_05 unlink();
		var_1C = var_05.origin + anglestoforward(var_05.angles) * 20000;
		var_05 moveto(var_1C,60);
		if(isdefined(level.var_12AF7[param_01].var_7631) && isdefined(level.var_12AF7[param_01].var_75A2))
		{
			playfxontag(level.var_12AF7[param_01].var_7631,var_05,level.var_12AF7[param_01].var_75A2);
		}

		var_05 scripts\mp\_hostmigration::func_137B8("death",3);
		if(var_05.var_E1 < var_05.maxhealth)
		{
			var_05 notify("leaving");
			var_05 setscriptablepartstate("trail","on",0);
			var_05.var_9E78 = 1;
			var_05 moveto(var_1C,4,4,0);
		}

		var_05 scripts\mp\_hostmigration::func_137B8("death",4 + var_05.var_11938);
	}

	var_05 [[ level.var_12AF7[param_01].var_E124 ]]();
	if(isdefined(var_05.var_6569))
	{
		scripts\mp\objidpoolmanager::returnminimapid(var_05.var_6569);
		var_05 notify("uav_deleteObjective");
	}

	if(isdefined(var_05))
	{
		var_05 delete();
	}

	if(param_01 == "directional_uav")
	{
		param_00.var_255 = 0;
		if(level.teambased)
		{
			foreach(var_1E in level.players)
			{
				if(var_1E.pers["team"] == var_03)
				{
					var_1E.var_255 = 0;
				}
			}
		}
	}

	scripts\mp\_utility::func_D915("killstreak ended - " + param_01,param_00);
	level notify("uav_update");
}

//Function Number: 9
func_B9FF()
{
	self endon("death");
	self.var_222 scripts\common\utility::waittill_any_3("disconnect","joined_team");
	self hide();
	var_00 = anglestoright(self.angles) * 200;
	playfx(level.var_12AF7[self.var_12AFA].var_7630,self.origin,var_00);
	self.var_E1 = self.maxhealth;
	self notify("death");
}

//Function Number: 10
func_E2E4()
{
	self endon("death");
	for(;;)
	{
		level waittill("host_migration_end");
		if(level.teambased)
		{
			var_00 = func_12B5("allies");
			var_01 = func_12B5("axis");
			_setteamradarstrength("allies",var_00);
			_setteamradarstrength("axis",var_01);
		}
	}
}

//Function Number: 11
func_12F50()
{
	self endon("death");
	for(;;)
	{
		level scripts\common\utility::waittill_either("joined_team","uav_update");
		self hide();
		foreach(var_01 in level.players)
		{
			if(level.teambased)
			{
				if(var_01.team != self.team)
				{
					self showtoplayer(var_01);
				}

				continue;
			}

			if(isdefined(self.var_222) && var_01 == self.var_222)
			{
				continue;
			}

			self showtoplayer(var_01);
		}
	}
}

//Function Number: 12
func_4D72()
{
	level endon("game_ended");
	self setcandamage(1);
	self.var_E1 = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D);
		var_09 = scripts\mp\_utility::func_13CA1(var_09,var_0D);
		if(!isplayer(var_01))
		{
			if(!isdefined(self))
			{
				return;
			}

			continue;
		}

		if(lib_0DF8::func_9DDF(var_01))
		{
			continue;
		}

		if(isdefined(var_08) && var_08 & level.var_92C4)
		{
			self.var_1390E = 1;
		}

		if(isdefined(var_08) && var_08 & level.var_92C6)
		{
			self.var_1390F = 1;
		}

		self.var_1390B = 1;
		var_0E = var_00;
		if(isplayer(var_01))
		{
			var_01 scripts\mp\_damagefeedback::func_12E84("");
			if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET")
			{
				if(var_01 scripts\mp\_utility::_hasperk("specialty_armorpiercing"))
				{
					var_0E = var_0E + var_00 * level.var_218B;
				}
			}
		}

		var_0F = 1;
		var_10 = 1;
		var_11 = 1;
		if(self.var_12AFA == "directional_uav")
		{
			var_0F = 5;
			var_10 = 6;
			var_11 = 7;
			if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_duration_health"))
			{
				var_0F--;
				var_10--;
				var_11--;
			}
		}

		if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_armor_speed"))
		{
			var_0F++;
			var_10++;
			var_11++;
		}

		if(isdefined(var_09))
		{
			if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_armor_speed"))
			{
				if(scripts\mp\killstreaks\_utility::isexplosiveantikillstreakweapon(var_09))
				{
					var_01 scripts\mp\_damagefeedback::func_12E84("hitblastshield");
				}
			}

			var_0E = scripts\mp\killstreaks\_utility::func_7FBD(var_01,var_09,var_04,var_0E,self.maxhealth,var_0F,var_10,var_11);
			scripts\mp\killstreaks\_killstreaks::func_A6A0(var_01,var_09,self,var_04);
			scripts\mp\_damage::func_AF96(self,var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		}

		self.var_E1 = self.var_E1 + var_0E;
		if(self.var_E1 >= self.maxhealth)
		{
			if(isplayer(var_01) && !isdefined(self.var_222) || var_01 != self.var_222)
			{
				var_12 = scripts\mp\_killstreak_loot::getrarityforlootitem(self.var_110E8.var_1318B);
				var_13 = level.var_12AF7[self.var_12AFA].var_377B;
				if(var_12 != "")
				{
					var_13 = var_13 + "_" + var_12;
				}

				scripts\mp\_damage::func_C548(self.var_12AFA,var_01,var_09,var_04,var_00,"destroyed_" + self.var_12AFA,self.var_12AFA + "_destroyed",var_13);
				if(isdefined(self.var_12AF4) && self.var_12AF4 != var_01)
				{
					self.var_12AF4 thread scripts\mp\killstreaks\_remoteuav::func_DFA5();
				}
			}

			self hide();
			var_14 = anglestoright(self.angles) * 200;
			playfx(level.var_12AF7[self.var_12AFA].var_7630,self.origin,var_14);
			self notify("death");
			return;
		}
	}
}

//Function Number: 13
func_12AF9()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("uav_update");
		if(level.multiteambased)
		{
			for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
			{
				func_12F3F(level.teamnamelist[var_00]);
			}

			continue;
		}

		if(level.teambased)
		{
			func_12F3F("allies");
			func_12F3F("axis");
			scripts\mp\killstreaks\_utility::func_12F51();
			continue;
		}

		func_12EF2();
	}
}

//Function Number: 14
handlewiretap()
{
	foreach(var_01 in level.players)
	{
		if(isdefined(self.var_110EA) && self.var_110EA == "directional_uav" || self.var_110EA == "counter_uav")
		{
			return;
		}

		if(!var_01 scripts\mp\_utility::_hasperk("specialty_expanded_minimap"))
		{
			continue;
		}

		if(var_01.team == self.team)
		{
			continue;
		}

		thread executewiretapsweeps(var_01);
	}
}

//Function Number: 15
executewiretapsweeps(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	function_0223(param_00);
	self waittill("death");
	function_0223(param_00);
}

//Function Number: 16
func_12B5(param_00)
{
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	foreach(var_05 in level.var_12AF3[param_00])
	{
		if(!isdefined(var_05))
		{
			continue;
		}

		if(var_05.var_12AFA == "counter_uav")
		{
			continue;
		}

		if(var_05.var_12AFA == "remote_mortar")
		{
			continue;
		}

		if(var_05.var_12AFA == "directional_uav")
		{
			var_03++;
			continue;
		}

		var_01++;
	}

	if(level.multiteambased)
	{
		foreach(var_08 in level.teamnamelist)
		{
			foreach(var_05 in level.var_12AF3[var_08])
			{
				if(!isdefined(var_05))
				{
					continue;
				}

				if(var_08 == param_00)
				{
					continue;
				}

				if(var_05.var_12AFA != "counter_uav")
				{
					continue;
				}

				var_02++;
			}
		}
	}
	else
	{
		foreach(var_05 in level.var_12AF3[level.var_C74B[param_00]])
		{
			if(!isdefined(var_05))
			{
				continue;
			}

			if(var_05.var_12AFA != "counter_uav")
			{
				continue;
			}

			var_02++;
		}
	}

	var_0E = getuavstrengthmin();
	var_0F = getuavstrengthmax();
	if(var_03)
	{
		var_01 = var_0F - getuavstrengthlevelneutral();
	}

	if(param_00 == "axis")
	{
		level.axisactiveuavs = var_01;
	}
	else
	{
		level.alliesactiveuavs = var_01;
	}

	if(var_02 > 0)
	{
		var_10 = var_0E;
	}
	else if(var_04 > 0)
	{
		var_10 = var_10;
	}
	else
	{
		var_10 = int(clamp(var_02 + getuavstrengthlevelneutral(),getuavstrengthlevelneutral(),getuavstrengthlevelshowenemyfastsweep()));
	}

	if(var_10 <= var_0E)
	{
		var_10 = var_0E;
	}
	else if(var_10 >= var_0F)
	{
		var_10 = var_0F;
	}

	return var_10;
}

//Function Number: 17
_setteamradarstrength(param_00,param_01)
{
	func_12F3F(param_00,param_01);
}

//Function Number: 18
func_12F3F(param_00,param_01)
{
	var_02 = getuavstrengthmin();
	var_03 = getuavstrengthmax();
	var_04 = getuavstrengthlevelshowenemydirectional();
	var_05 = getuavstrengthlevelneutral();
	var_06 = getuavstrengthlevelshowenemyfastsweep();
	if(isdefined(param_01))
	{
		var_07 = param_01;
	}
	else
	{
		var_07 = func_12B5(param_01);
	}

	if(param_00 == "axis")
	{
		var_08 = level.axisactiveuavs;
	}
	else
	{
		var_08 = level.alliesactiveuavs;
	}

	foreach(var_0A in level.players)
	{
		var_0B = var_07;
		if(var_0A.team != param_00)
		{
			continue;
		}

		if(var_0A scripts\mp\_utility::_hasperk("specialty_empimmune") && var_07 <= var_05)
		{
			if(scripts\mp\_utility::func_9FB3(var_0A.var_255))
			{
				var_0B = var_03;
			}

			if(var_0B != var_03)
			{
				var_0B = int(clamp(var_08 + var_05,var_05,var_06));
			}
		}

		if(var_0B <= var_02)
		{
			var_0B = var_02;
		}
		else if(var_0B >= var_03)
		{
			var_0B = var_03;
		}

		var_0A.var_256 = var_0B;
		if(var_0B >= var_05)
		{
			var_0A.var_194 = 0;
		}
		else
		{
			var_0A.var_194 = 1;
		}

		if(var_0B <= var_05)
		{
			var_0A.var_16E = 0;
			var_0A.var_255 = 0;
			if(isdefined(var_0A.var_254) && var_0A.var_254 == "constant_radar")
			{
				var_0A.var_254 = "normal_radar";
			}

			var_0A setclientomnvar("ui_show_hardcore_minimap",0);
			continue;
		}

		var_0A setradarmode(var_0B,var_06,var_04);
		var_0A.var_255 = var_0B >= var_04;
		var_0A.var_16E = 1;
		var_0A setclientomnvar("ui_show_hardcore_minimap",1);
	}
}

//Function Number: 19
func_12EF2()
{
	var_00 = getuavstrengthmin();
	var_01 = getuavstrengthmax();
	var_02 = getuavstrengthlevelshowenemydirectional();
	var_03 = getuavstrengthlevelshowenemyfastsweep();
	foreach(var_05 in level.players)
	{
		var_06 = level.var_1679[var_05.var_86BD + "_radarStrength"];
		foreach(var_08 in level.players)
		{
			if(var_08 == var_05)
			{
				continue;
			}

			var_09 = level.var_164F[var_08.var_86BD];
			if(var_09 > 0 && !var_05 scripts\mp\_utility::_hasperk("specialty_empimmune"))
			{
				var_06 = var_00;
				break;
			}
		}

		if(var_06 <= var_00)
		{
			var_06 = var_00;
		}
		else if(var_06 >= var_01)
		{
			var_06 = var_01;
		}

		var_05.var_256 = var_06;
		if(var_06 >= getuavstrengthlevelneutral())
		{
			var_05.var_194 = 0;
		}
		else
		{
			var_05.var_194 = 1;
		}

		if(var_06 <= getuavstrengthlevelneutral())
		{
			var_05.var_16E = 0;
			var_05.var_255 = 0;
			if(isdefined(var_05.var_254) && var_05.var_254 == "constant_radar")
			{
				var_05.var_254 = "normal_radar";
			}

			var_05 setclientomnvar("ui_show_hardcore_minimap",0);
			continue;
		}

		var_05 setradarmode(var_06,var_03,var_02);
		var_05.var_255 = var_06 >= var_02;
		var_05.var_16E = 1;
		var_05 setclientomnvar("ui_show_hardcore_minimap",1);
	}
}

//Function Number: 20
setradarmode(param_00,param_01,param_02)
{
	if(param_00 >= param_01)
	{
		self.var_254 = "fast_radar";
	}
	else
	{
		self.var_254 = "normal_radar";
	}

	if(param_00 >= param_02)
	{
		var_03 = undefined;
		if(level.teambased)
		{
			var_03 = level.var_12AF3[self.team];
		}
		else
		{
			var_03 = level.var_12AF3;
		}

		foreach(var_05 in var_03)
		{
			if(isdefined(var_05) && var_05.var_12AFA == "directional_uav")
			{
				if(!level.teambased)
				{
					if(var_05.var_222 != self)
					{
						continue;
					}
				}

				if(scripts\mp\killstreaks\_utility::func_A69F(var_05.var_110E8,"passive_vision_sweep"))
				{
					self.var_254 = "constant_radar";
					break;
				}
			}
		}
	}
}

//Function Number: 21
func_2BBC()
{
	self endon("disconnect");
	self notify("blockPlayerUAV");
	self endon("blockPlayerUAV");
	self.var_194 = 1;
	wait(level.var_12AF0);
	self.var_194 = 0;
}

//Function Number: 22
func_12F40(param_00)
{
	var_01 = func_12B5(param_00) >= getuavstrengthlevelshowenemydirectional();
	foreach(var_03 in level.players)
	{
		if(var_03.team == "spectator")
		{
			continue;
		}

		var_03.var_254 = level.var_254[var_03.team];
		if(var_03.team == param_00)
		{
			var_03.var_255 = var_01;
		}
	}
}

//Function Number: 23
func_130BF(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	self notify("usePlayerUAV");
	self endon("usePlayerUAV");
	if(param_00)
	{
		self.var_254 = "fast_radar";
	}
	else
	{
		self.var_254 = "normal_radar";
	}

	self.var_16E = 1;
	wait(param_01);
	self.var_16E = 0;
}

//Function Number: 24
func_F87B(param_00,param_01)
{
	setteamradar(param_00,param_01);
	level notify("radar_status_change",param_00);
}

//Function Number: 25
func_89B7()
{
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("stinger_fired",var_00,var_01,var_02);
		if(!isdefined(var_02) || var_02 != self)
		{
			continue;
		}

		var_01 thread func_10FA8(var_02,var_00);
	}
}

//Function Number: 26
func_10FA8(param_00,param_01)
{
	self endon("death");
	var_02 = distance(self.origin,param_00 method_8159(0,0,0));
	var_03 = param_00 method_8159(0,0,0);
	for(;;)
	{
		if(!isdefined(param_00))
		{
			var_04 = var_03;
		}
		else
		{
			var_04 = param_00 method_8159(0,0,0);
		}

		var_03 = var_04;
		var_05 = distance(self.origin,var_04);
		if(var_05 < var_02)
		{
			var_02 = var_05;
		}

		if(var_05 > var_02)
		{
			if(var_05 > 1536)
			{
				return;
			}

			radiusdamage(self.origin,1536,600,600,param_01,"MOD_EXPLOSIVE","iw7_lockon_mp");
			playfx(level.var_10FA1,self.origin);
			self hide();
			self notify("deleted");
			wait(0.05);
			self delete();
			param_01 notify("killstreak_destroyed");
		}

		wait(0.05);
	}
}

//Function Number: 27
func_1867()
{
	if(level.teambased)
	{
		level.var_12AF3[self.team][level.var_12AF3[self.team].size] = self;
		return;
	}

	level.var_12AF3[self.var_222.var_86BD + "_" + gettime()] = self;
}

//Function Number: 28
func_E182()
{
	var_00 = [];
	if(level.teambased)
	{
		var_01 = self.team;
		foreach(var_03 in level.var_12AF3[var_01])
		{
			if(!isdefined(var_03))
			{
				continue;
			}

			var_00[var_00.size] = var_03;
		}

		level.var_12AF3[var_01] = var_00;
		return;
	}

	foreach(var_03 in level.var_12AF3)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_00[var_00.size] = var_03;
	}

	level.var_12AF3 = var_00;
}

//Function Number: 29
func_179A()
{
	if(level.teambased)
	{
		level.var_1679[self.team]++;
		if(self.var_12AFA == "directional_uav")
		{
			level.activeadvanceduavs[self.team]++;
			return;
		}

		return;
	}

	level.var_1679[self.var_222.var_86BD]++;
	level.var_1679[self.var_222.var_86BD + "_radarStrength"]++;
	if(self.var_12AFA == "directional_uav")
	{
		level.var_1679[self.var_222.var_86BD + "_radarStrength"] = level.var_1679[self.var_222.var_86BD + "_radarStrength"] + 2;
		if(!isdefined(level.activeadvanceduavs[self.var_222.var_86BD]))
		{
			level.activeadvanceduavs[self.var_222.var_86BD] = 0;
		}

		level.activeadvanceduavs[self.var_222.var_86BD]++;
	}
}

//Function Number: 30
func_1799()
{
	if(level.teambased)
	{
		level.var_164F[self.team]++;
		return;
	}

	level.var_164F[self.var_222.var_86BD]++;
}

//Function Number: 31
func_E0C1()
{
	if(level.teambased)
	{
		level.var_1679[self.team]--;
		if(self.var_12AFA == "directional_uav")
		{
			level.activeadvanceduavs[self.team]--;
			return;
		}

		return;
	}

	if(isdefined(self.var_222))
	{
		level.var_1679[self.var_222.var_86BD]--;
		level.var_1679[self.var_222.var_86BD + "_radarStrength"]--;
		if(self.var_12AFA == "directional_uav")
		{
			level.var_1679[self.var_222.var_86BD + "_radarStrength"] = level.var_1679[self.var_222.var_86BD + "_radarStrength"] - 2;
			level.activeadvanceduavs[self.var_222.var_86BD]--;
			return;
		}
	}
}

//Function Number: 32
func_E0BF()
{
	if(level.teambased)
	{
		level.var_164F[self.team]--;
		return;
	}

	if(isdefined(self.var_222))
	{
		level.var_164F[self.var_222.var_86BD]--;
	}
}

//Function Number: 33
func_108CD(param_00,param_01)
{
	self endon("death");
	level endon("game_ended");
	wait(0.5);
	playfxontag(param_00,self,param_01);
}

//Function Number: 34
func_13920(param_00,param_01)
{
	if(isdefined(param_01))
	{
		param_01 endon("death");
	}

	self endon("leave");
	self endon("killstreak_disowned");
	level endon("game_ended");
	var_02 = level.var_12AF7[param_00];
	var_03 = var_02.var_CB9A;
	if(level.teambased)
	{
		level.var_1679[self.team]++;
	}
	else
	{
		level.var_1679[self.var_86BD]++;
	}

	for(;;)
	{
		playfx(var_02.var_7636,self.origin);
		self playlocalsound(var_02.var_1046A);
		playsoundatpos(self.origin + (0,0,5),var_02.var_10469);
		foreach(var_05 in level.var_C928)
		{
			if(!scripts\mp\_utility::func_9F19(var_05))
			{
				continue;
			}

			if(!scripts\mp\_utility::func_9DD6(var_05))
			{
				continue;
			}

			if(var_05 scripts\mp\_utility::_hasperk("specialty_noplayertarget"))
			{
				continue;
			}

			var_05 scripts\mp\_hud_message::func_1013D("spotted");
			foreach(var_07 in level.var_C928)
			{
				if(!scripts\mp\_utility::func_9F19(var_07))
				{
					continue;
				}

				if(scripts\mp\_utility::func_9DD6(var_07))
				{
					continue;
				}

				if(isai(var_07))
				{
					var_07 scripts\common\utility::func_1913(var_05);
					continue;
				}

				var_08 = scripts\mp\_utility::func_C794(var_05,"orange",var_07,0,0,"killstreak");
				var_09 = var_02.var_8EF7;
				var_07 thread func_13AA0(var_08,var_05,var_09,param_01);
			}
		}

		scripts\mp\_hostmigration::func_13708(var_03);
	}
}

//Function Number: 35
func_13921(param_00)
{
	self endon("killstreak_disowned");
	level endon("game_ended");
	var_01 = level.var_12AF7[param_00];
	var_02 = var_01.var_11901;
	var_03 = self.var_86BD;
	if(level.teambased)
	{
		var_03 = self.team;
	}

	thread func_13922(var_03);
	scripts\mp\_hostmigration::func_13708(var_02);
	scripts\mp\_utility::func_AAEC(var_01.var_13554);
	self notify("leave");
	func_4044(var_03);
}

//Function Number: 36
func_13922(param_00)
{
	self endon("leave");
	self waittill("killstreak_disowned");
	func_4044(param_00);
}

//Function Number: 37
func_4044(param_00)
{
	level.var_1679[param_00]--;
	if(level.var_1679[param_00] < 0)
	{
		level.var_1679[param_00] = 0;
	}
}

//Function Number: 38
func_13AA0(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		param_03 endon("death");
	}

	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_timeout_no_endon_death_2(param_02,"leave");
	if(isdefined(param_01))
	{
		scripts\mp\_utility::func_C78F(param_00,param_01);
	}
}

//Function Number: 39
func_81E8(param_00,param_01)
{
	var_02 = undefined;
	switch(param_00)
	{
		case "uav":
			var_02 = level.var_12AF5;
			break;

		case "counter_uav":
			var_02 = level.var_46B8;
			break;

		case "directional_uav":
			var_02 = level.var_18D2;
			if(scripts\mp\killstreaks\_utility::func_A69F(param_01,"passive_stealth_vehicle"))
			{
				var_02 = level.advanceduavrigslow;
			}
			break;

		case "default":
			break;
	}

	return var_02;
}

//Function Number: 40
func_CA50()
{
	self.var_222 endon("disconnect");
	self endon("uav_deleteObjective");
	switch(self.var_12AFA)
	{
		case "uav":
			var_00 = "icon_minimap_uav_enemy";
			break;

		case "counter_uav":
			var_00 = "icon_minimap_counter_uav_enemy";
			break;

		case "directional_uav":
			var_00 = "icon_minimap_advanced_uav_enemy";
			break;

		default:
			var_00 = "icon_minimap_uav_enemy";
			break;
	}

	self.var_6569 = scripts\mp\killstreaks\_airdrop::func_49F8(var_00,1,1);
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(!isdefined(var_02))
			{
				continue;
			}

			if(!isplayer(var_02))
			{
				continue;
			}

			if(self.var_6569 != -1)
			{
				if(var_02 scripts\mp\_utility::_hasperk("specialty_engineer") && scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(var_02,self.var_222)))
				{
					scripts\mp\objidpoolmanager::minimap_objective_playermask_showto(self.var_6569,var_02 getentitynumber());
					continue;
				}

				scripts\mp\objidpoolmanager::minimap_objective_playermask_hidefrom(self.var_6569,var_02 getentitynumber());
			}
		}

		wait(0.1);
	}
}

//Function Number: 41
startsystemshutdown()
{
	level endon("game_ended");
	foreach(var_01 in level.players)
	{
		if(!scripts\mp\_utility::func_9F19(var_01))
		{
			continue;
		}

		if(!scripts\mp\_utility::playersareenemies(self.var_222,var_01))
		{
			continue;
		}

		if(!var_01 scripts\mp\_utility::_hasperk("specialty_empimmune"))
		{
			var_01 thread shutdownenemysystem(self);
		}
	}

	thread applyshutdownonspawn();
}

//Function Number: 42
givefriendlyperks(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	scripts\mp\_utility::func_8387("specialty_coldblooded");
	scripts\mp\_utility::func_8387("specialty_tracker_jammer");
	scripts\mp\_utility::func_8387("specialty_noscopeoutline");
	param_00 waittill("death");
	scripts\mp\_utility::func_E150("specialty_coldblooded");
	scripts\mp\_utility::func_E150("specialty_tracker_jammer");
	scripts\mp\_utility::func_E150("specialty_noscopeoutline");
}

//Function Number: 43
shutdownenemysystem(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	self method_85C7(1);
	self playlocalsound("counter_uav_jam_sfx");
	param_00 waittill("death");
	self method_85C7(0);
	self playlocalsound("counter_uav_jam_reboot_sfx");
}

//Function Number: 44
applyshutdownonspawn()
{
	self endon("death");
	level endon("game_ended");
	var_00 = self.var_222;
	var_01 = var_00.team;
	for(;;)
	{
		level waittill("player_spawned",var_02);
		if(!scripts\mp\_utility::playersareenemies(var_00,var_02))
		{
			continue;
		}

		if(!var_02 scripts\mp\_utility::_hasperk("specialty_empimmune"))
		{
			var_02 thread shutdownenemysystem(self);
		}
	}
}

//Function Number: 45
startemppulse()
{
	self endon("death");
	level endon("game_ended");
	wait(2);
	self playsound("jammer_drone_charge");
	playfxontag(scripts\common\utility::getfx("jammer_drone_charge"),self,"tag_origin");
	wait(1.5);
	stopfxontag(scripts\common\utility::getfx("jammer_drone_charge"),self,"tag_origin");
	playfxontag(scripts\common\utility::getfx("jammer_drone_shockwave"),self,"tag_origin");
	self playsound("jammer_drone_shockwave");
	foreach(var_01 in level.players)
	{
		if(!scripts\mp\_utility::func_9F19(var_01))
		{
			continue;
		}

		if(!scripts\mp\_utility::playersareenemies(self.var_222,var_01))
		{
			continue;
		}

		if(var_01 scripts\mp\_utility::_hasperk("specialty_empimmune"))
		{
			continue;
		}

		var_02 = 1;
		if(var_01 scripts\mp\killstreaks\_emp_common::isemped())
		{
			var_02 = 0;
		}

		var_03 = 1;
		if(lib_0DF8::func_9DDF(var_01))
		{
			var_03 = 0;
		}
		else if(scripts\mp\_utility::func_9FB3(var_01.visionpulsevisionsetactive))
		{
			var_03 = 0;
		}

		var_01 thread applyuavshellshock(var_03,var_02);
	}

	func_52C5(scripts\mp\_utility::getotherteam(self.team),self.var_222);
}

//Function Number: 46
applyuavshellshock(param_00,param_01)
{
	self endon("disconnect");
	if(param_00)
	{
		self shellshock("flashbang_mp",0.5);
		thread applyuavshellshockvisionset();
	}

	if(param_01)
	{
		self setscriptablepartstate("emped","active",0);
	}

	self playloopsound("emp_nade_lp");
	var_02 = gettime() + 500;
	while(gettime() <= var_02)
	{
		if(param_01 && scripts\mp\killstreaks\_emp_common::isemped())
		{
			param_01 = 0;
		}

		if(!scripts\mp\_utility::func_9F19(self))
		{
			break;
		}

		scripts\common\utility::func_136F7();
	}

	if(param_01)
	{
		self setscriptablepartstate("emped","neutral",0);
	}

	self stoploopsound("emp_nade_lp");
}

//Function Number: 47
applyuavshellshockvisionset()
{
	function_0237("coup_sunblind",0.05);
	scripts\common\utility::func_136F7();
	function_0237("coup_sunblind",0);
	function_0237("",0.5);
}

//Function Number: 48
func_52C5(param_00,param_01)
{
	var_02 = "nuke_mp";
	var_03 = level.var_1655;
	var_04 = scripts\mp\perks\_perkfunctions::func_7D96();
	var_05 = undefined;
	if(isdefined(var_03) && isdefined(var_04))
	{
		var_05 = scripts\common\utility::func_2284(var_03,var_04);
	}
	else if(isdefined(var_03))
	{
		var_05 = var_03;
	}
	else if(isdefined(var_04))
	{
		var_05 = var_04;
	}

	if(isdefined(var_05))
	{
		foreach(var_07 in var_05)
		{
			if(isdefined(var_07))
			{
				var_07 scripts\mp\killstreaks\_utility::dodamagetokillstreak(10000,param_01,param_01,param_00,var_07.origin,"MOD_EXPLOSIVE",var_02);
			}
		}
	}
}