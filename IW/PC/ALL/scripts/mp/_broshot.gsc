/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_broshot.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 2473 ms
 * Timestamp: 10/27/2023 12:14:39 AM
*******************************************************************/

//Function Number: 1
initbroshotfx()
{
	level._effect["FX_BRO_LIGHT"] = loadfx("vfx/iw7/_requests/mp/broshot/vfx_bs_light_fill.vfx");
	level._effect["vfx_taunt_steel_dragon"] = loadfx("vfx/iw7/_requests/mp/frontend/vfx_taunt_steel_dragon.vfx");
	level._effect["vfx_bombard_antigrav_pre_expl"] = loadfx("vfx/iw7/_requests/mp/vfx_bombard_antigrav_pre_expl.vfx");
	level._effect["vfx_bombard_projectile_trail"] = loadfx("vfx/iw7/_requests/mp/vfx_bombard_projectile_trail.vfx");
	level._effect["vfx_bombardment_strike_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_bombardment_strike_explosion.vfx");
	level._effect["vfx_tnt_crate_smk"] = loadfx("vfx/iw7/levels/mp_frontend/vfx_tnt_crate_smk.vfx");
}

//Function Number: 2
forceinitbroshot()
{
	level.forcebroshot = 1;
	setomnvar("ui_broshot_debug",1);
	return func_97E0();
}

//Function Number: 3
func_97E0(param_00)
{
	level.var_37A8 = spawnstruct();
	level.var_37A8.var_289A = getent("camera_mp_broshot","targetname");
	level.var_37A8.var_3CAA[0] = getent("character_loc_broshot","targetname");
	level.var_37A8.var_3CAA[2] = getent("character_loc_broshot_a","targetname");
	level.var_37A8.var_3CAA[1] = getent("character_loc_broshot_b","targetname");
	level.var_37A8.var_3CAA[3] = getent("character_loc_broshot_c","targetname");
	level.var_37A8.var_3CAA[4] = getent("character_loc_broshot_d","targetname");
	level.var_37A8.var_3CAA[5] = getent("character_loc_broshot_e","targetname");
	if((!isdefined(self) || !isdefined(level.var_37A8.var_289A) || !isdefined(level.var_115D8) || !isdefined(level.var_115D8["allies"]) || !isdefined(level.var_115D8["axis"]) || level.var_115D8["allies"].size == 0 && level.var_115D8["axis"].size == 0) && !scripts\mp\_utility::func_9FB3(level.forcebroshot))
	{
		return 0;
	}

	if(level.teambased && !scripts\mp\_utility::func_9FB3(level.forcebroshot))
	{
		if(!isdefined(param_00))
		{
			var_01 = getteamscore("allies");
			var_02 = getteamscore("axis");
			if(var_01 == var_02)
			{
				return 0;
			}
		}
		else if(param_00 == "tie" || param_00 == "none" || param_00 == "draw")
		{
			return 0;
		}
	}
	else
	{
		var_03 = scripts\common\utility::func_22C3(level.players,::func_445C);
		if(!scripts\mp\_utility::func_9FB3(level.forcebroshot) && var_03[0].var_278 <= 0)
		{
			return 0;
		}
	}

	level.var_37A8.var_BE17 = 40;
	level.var_37A8.var_3CAA[0].origin = level.var_37A8.var_3CAA[0].origin + function_02D3(level.var_37A8.var_3CAA[0].angles) * 6;
	level.var_37A8.var_3CAA[2].origin = level.var_37A8.var_3CAA[2].origin + function_02D3(level.var_37A8.var_3CAA[2].angles) * 20;
	level.var_37A8.var_3CAA[1].origin = level.var_37A8.var_3CAA[1].origin + function_02D3(level.var_37A8.var_3CAA[1].angles) * 12;
	level.var_37A8.var_3CAA[4].origin = level.var_37A8.var_3CAA[4].origin + function_02D3(level.var_37A8.var_3CAA[4].angles) * 6;
	level.var_37A8.var_3CAA[3].origin = level.var_37A8.var_3CAA[3].origin + anglestoright(level.var_37A8.var_3CAA[3].angles) * 0;
	level.var_37A8.var_3CAA[5].origin = level.var_37A8.var_3CAA[5].origin + function_02D3(level.var_37A8.var_3CAA[5].angles) * 18;
	level.var_37A8.var_3CAA[4].origin = level.var_37A8.var_3CAA[4].origin + anglestoforward(level.var_37A8.var_3CAA[4].angles) * -46;
	level.var_37A8.var_3CAA[3].origin = level.var_37A8.var_3CAA[3].origin + anglestoforward(level.var_37A8.var_3CAA[3].angles) * -46;
	level.var_37A8.var_3CAA[5].origin = level.var_37A8.var_3CAA[5].origin + anglestoforward(level.var_37A8.var_3CAA[5].angles) * -46;
	setomnvar("ui_broshot_upside_down",scripts\mp\_utility::func_9FB3(level.upsidedowntaunts));
	for(var_04 = 3;var_04 < 6;var_04++)
	{
		if(scripts\mp\_utility::func_9FB3(level.upsidedowntaunts))
		{
			var_05 = level.var_37A8.var_3CAA[var_04].origin + (0,0,25);
			var_06 = (var_05[0],var_05[1],var_05[2] - 100);
		}
		else
		{
			var_05 = level.var_37A8.var_3CAA[var_04].origin;
			var_06 = (var_05[0],var_05[1],var_05[2] + 100);
		}

		var_07 = scripts\common\trace::func_48BC(0,1,1,1,1,0,0);
		var_08 = function_0287(var_06,var_05,var_07,undefined,1,"physicsquery_closest");
		var_09 = isdefined(var_08) && var_08.size > 0;
		if(var_09)
		{
			var_0A = var_08[0]["position"];
			level.var_37A8.var_3CAA[var_04].origin = var_0A;
		}
	}

	self.var_BE05 = [];
	return 1;
}

//Function Number: 4
func_10D73(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self;
	}

	level.broshotrunning = 1;
	func_40F4();
	cleanupgamemodes();
	var_01 = spawnstruct();
	if(scripts\mp\_utility::func_9FB3(level.upsidedowntaunts))
	{
		var_01.origin = level.var_37A8.var_3CAA[0].origin + (30,-15,-95);
		var_01.angles = level.var_37A8.var_289A.angles + (162,180,0);
	}
	else
	{
		var_01.origin = level.var_37A8.var_3CAA[0].origin;
		var_01.angles = level.var_37A8.var_289A.angles;
	}

	foreach(var_03 in level.players)
	{
		var_03 scripts\mp\_playerlogic::func_E285(var_01.origin,var_01.angles);
		var_03 scripts\mp\_gamelogic::func_7386();
		var_03 method_8232();
	}

	function_031E();
	level.var_1623 = var_01;
	level.var_37A6 = spawn("script_model",var_01.origin);
	level.var_37A6 setmodel("tag_origin");
	level.var_37A6.angles = var_01.angles;
	thread spawnfilllight();
	if(scripts\mp\_utility::func_9FB3(level.forcebroshot))
	{
		if(level.var_115D8["allies"].size > 1)
		{
			level.topplayers = scripts\common\utility::func_22C3(level.var_115D8["allies"],::func_445C);
		}
		else
		{
			level.topplayers = [];
			level.topplayers[0] = self;
		}
	}
	else if(level.teambased)
	{
		if(!isdefined(param_00))
		{
			var_05 = getteamscore("allies");
			var_06 = getteamscore("axis");
			var_07 = scripts\common\utility::func_116D7(var_05 >= var_06,"allies","axis");
		}
		else
		{
			var_07 = var_01;
		}

		level.topplayers = scripts\common\utility::func_22C3(level.var_115D8[var_07],::func_445C);
	}
	else
	{
		level.topplayers = level.var_CC1D["all"];
	}

	level.supergunout = [];
	level.interruptabletaunts = [];
	level.firsttaunttracker = [];
	foreach(var_03 in level.players)
	{
		var_03 hideeffectsforbroshot();
	}

	for(var_0A = 0;var_0A < 6;var_0A++)
	{
		if(!isdefined(level.topplayers[var_0A]))
		{
			break;
		}

		if(!isdefined(level.topplayers[var_0A].var_AE62))
		{
			continue;
		}

		self.var_BE05[var_0A] = spawnstruct();
		if(level.gametype == "infect")
		{
			if(isbot(level.topplayers[var_0A]))
			{
				var_0B = level.topplayers[var_0A].var_AE62;
			}
			else
			{
				var_0B = level.topplayers[var_0A] scripts\mp\_class::func_3676();
			}
		}
		else
		{
			var_0B = level.topplayers[var_0A].var_AE62;
		}

		var_0C = tablelookuprownum("mp/battleRigTable.csv",1,var_0B);
		if(isbot(level.topplayers[var_0A]) || isdefined(level.topplayers[var_0A].var_A93D))
		{
			var_0D = level.topplayers[var_0A] method_8119();
			var_0E = level.topplayers[var_0A] method_811A();
			var_0F = tablelookuprownum("mp/cac/heads.csv",1,var_0E);
			var_10 = tablelookuprownum("mp/cac/bodies.csv",1,var_0D);
			if(isdefined(level.topplayers[var_0A].var_A93D))
			{
				var_0C = tablelookuprownum("mp/battleRigTable.csv",1,level.topplayers[var_0A].var_A93D.var_2123);
			}
		}
		else
		{
			var_10 = level.topplayers[var_0A] scripts\mp\_teams::func_8078();
			var_0F = level.topplayers[var_0A] scripts\mp\_teams::func_8073();
		}

		self.var_BE05[var_0A].var_26A = var_0C;
		self.var_BE05[var_0A].var_6A = var_10;
		self.var_BE05[var_0A].var_171 = var_0F;
		self.var_BE05[var_0A].var_39C = getdisplayweapon(level.topplayers[var_0A]);
		self.var_BE05[var_0A].var_9C = level.topplayers[var_0A] method_8567();
		self.var_BE05[var_0A].name = level.topplayers[var_0A].name;
		self.var_BE05[var_0A].var_3A3 = level.topplayers[var_0A] getxuid();
		self.var_BE05[var_0A].var_D62C = var_0A;
		self.var_BE05[var_0A].var_41F5 = level.topplayers[var_0A] getentitynumber();
		level.topplayers[var_0A] setguntypeforui(var_0A);
		level.topplayers[var_0A].bro = func_B29D(var_0A,level.var_37A8.var_3CAA[var_0A]);
	}

	foreach(var_03 in level.players)
	{
		var_03 setsoundsubmix("mp_broshot");
		var_03 setsolid(0);
		var_03 dontinterpolate();
		if(isbot(var_03))
		{
			continue;
		}

		var_03 cameralinkto(level.var_37A6,"tag_origin",1);
		var_03 thread scripts\mp\_utility::func_F8A0(0);
		scripts\mp\_utility::func_144F("",0);
		if(!scripts\mp\_utility::func_9FB3(level.forcebroshot))
		{
			var_03 thread fadetoblack(1.5);
		}
	}

	level.var_37A6 scriptmodelplayanimdeltamotion("iw7_mp_brodium_cam");
	thread tauntinputlisten(level.topplayers);
	level thread func_C56E();
	function_030D(-1,self.var_BE05);
	return 13.5;
}

//Function Number: 5
hideeffectsforbroshot()
{
	if(self.sessionteam == "spectator")
	{
		return;
	}

	if(!isdefined(self.var_AE62))
	{
		return;
	}

	self setscriptablepartstate("cloak","offImmediate",1);
	self setscriptablepartstate("jet_pack","off",1);
	self setscriptablepartstate("teamColorPins","off",1);
	self setscriptablepartstate("armorUpMaterial","offImmediate",1);
	self setscriptablepartstate("armorUp","neutral",1);
	self setscriptablepartstate("light_armor","neutral",1);
	self setscriptablepartstate("adrenaline","neutral",1);
	self setscriptablepartstate("adrenalineHeal","neutral",1);
	self setscriptablepartstate("pts_drone","off",1);
}

//Function Number: 6
spawnfilllight()
{
	scripts\common\utility::func_136F7();
	playfxontag(scripts\common\utility::getfx("FX_BRO_LIGHT"),level.var_37A6,"tag_origin");
}

//Function Number: 7
fadetoblack(param_00)
{
	wait(12);
	scripts\mp\_utility::func_144F("",0);
	foreach(var_02 in level.players)
	{
		if(isbot(var_02))
		{
			continue;
		}

		var_02 visionsetfadetoblackforplayer("bw",param_00);
	}
}

//Function Number: 8
func_40F4()
{
	self notify("bro_shot_start");
	scripts\mp\_weapons::func_51A7();
	var_00 = getweaponarray();
	if(isdefined(var_00))
	{
		foreach(var_02 in var_00)
		{
			var_02 delete();
		}
	}
}

//Function Number: 9
cleanupgamemodes()
{
	if(isdefined(level.var_115CC))
	{
		if(isdefined(level.var_115CC[game["attackers"]]) && isdefined(level.var_115CC[game["attackers"]].visuals))
		{
			for(var_00 = 0;var_00 < level.var_115CC[game["attackers"]].visuals.size;var_00++)
			{
				level.var_115CC[game["attackers"]].visuals[var_00] hide();
			}
		}

		if(isdefined(level.var_115CC[game["defenders"]]) && isdefined(level.var_115CC[game["defenders"]].visuals))
		{
			for(var_00 = 0;var_00 < level.var_115CC[game["defenders"]].visuals.size;var_00++)
			{
				level.var_115CC[game["defenders"]].visuals[var_00] hide();
			}
		}
	}

	if((level.gametype == "dom" || level.gametype == "siege") && isdefined(level.var_5913))
	{
		foreach(var_02 in level.var_5913)
		{
			if(isdefined(var_02))
			{
				var_02.var_289 setscriptablepartstate("flag","off");
				var_02.var_289 setscriptablepartstate("pulse","off");
			}
		}
	}

	if(level.gametype == "grind" && isdefined(level.var_13FC1))
	{
		foreach(var_05 in level.var_13FC1)
		{
			if(isdefined(var_05) && isdefined(var_05.var_289))
			{
				var_05.var_289 setscriptablepartstate("flag","off");
				var_05.var_289 setscriptablepartstate("pulse","off");
			}
		}
	}

	if((level.gametype == "sr" || level.gametype == "dd" | level.gametype == "sd") && isdefined(level.var_2C7A))
	{
		foreach(var_08 in level.var_2C7A)
		{
			if(isdefined(var_08) && isdefined(var_08.visuals))
			{
				for(var_09 = 0;var_09 < var_08.visuals.size;var_09++)
				{
					if(isdefined(var_08.visuals[var_09]))
					{
						var_08.visuals[var_09] hide();
					}
				}
			}
		}
	}

	if(level.gametype == "front" && isdefined(level.var_13FC4))
	{
		foreach(var_05 in level.var_13FC4)
		{
			if(isdefined(var_05) && isdefined(var_05.visuals))
			{
				for(var_09 = 0;var_09 < var_05.visuals.size;var_09++)
				{
					var_05.visuals[var_09] hide();
				}
			}
		}
	}

	if(scripts\mp\_utility::func_9FB3(level.var_58C2))
	{
		if(isdefined(level.var_58C0))
		{
			foreach(var_0E in level.var_58C0)
			{
				if(isdefined(var_0E) && isdefined(var_0E.visuals))
				{
					for(var_09 = 0;var_09 < var_0E.visuals.size;var_09++)
					{
						var_0E.visuals[var_09] hide();
					}
				}
			}
		}
	}

	if(isdefined(level.var_2800))
	{
		foreach(var_11 in level.var_2800)
		{
			var_11.visuals[0] setscriptablepartstate("uplink_drone_hide","hide",0);
		}
	}

	if((level.gametype == "koth" || level.gametype == "grnd") && isdefined(level.var_13FC4))
	{
		foreach(var_05 in level.var_13FC4)
		{
			if(isdefined(var_05) && isdefined(var_05.var_130AC) && isdefined(var_05.var_130AC.chevrons))
			{
				foreach(var_15 in var_05.var_130AC.chevrons)
				{
					for(var_09 = 0;var_09 < var_15.numchevrons;var_09++)
					{
						var_15 setscriptablepartstate("chevron_" + var_09,"off");
					}
				}
			}
		}
	}
}

//Function Number: 10
tauntinputlisten(param_00)
{
	wait(3);
	for(var_01 = 0;var_01 < 3;var_01++)
	{
		if(!isdefined(param_00[var_01]) || isbot(param_00[var_01]))
		{
			continue;
		}

		param_00[var_01] thread func_AD7A(var_01);
	}
}

//Function Number: 11
getdisplayweapon(param_00)
{
	var_01 = param_00.var_A978;
	if(!issubstr(var_01,param_00.pers["primaryWeapon"]) && !issubstr(var_01,param_00.pers["secondaryWeapon"]))
	{
		var_01 = param_00.var_10922;
	}

	if(issubstr(var_01,"iw7_fists_mp") || issubstr(var_01,"iw7_knife") || issubstr(var_01,"iw7_axe"))
	{
		var_01 = param_00.pers["secondaryWeapon"];
	}

	if(issubstr(var_01,"nunchucks") || issubstr(var_01,"katana"))
	{
		var_01 = "iw7_fists_mp";
	}

	return var_01;
}

//Function Number: 12
func_37B1(param_00,param_01,param_02,param_03)
{
	self predictstreampos(param_00.origin);
	wait(param_02);
	level.var_37A6 method_8292();
	var_04 = distance(level.var_37A6.origin,param_00.origin);
	var_05 = var_04 / param_01;
	if(var_05 < 0.05)
	{
		var_05 = 0.05;
	}

	level.var_37A6.var_BC77 = param_00;
	level.var_37A6 moveto(param_00.origin,var_05);
	level.var_37A6 rotateto(param_00.angles,var_05);
	if(isdefined(param_03))
	{
		wait(var_05 - param_03);
		thread scripts\mp\_utility::func_F8A0(param_03);
	}
}

//Function Number: 13
func_6311()
{
	level.broshotrunning = undefined;
	self notify("broshot_done");
	foreach(var_01 in level.players)
	{
		var_01 method_84D6();
	}
}

//Function Number: 14
func_B29D(param_00,param_01)
{
	var_02 = spawn("script_character",param_01.origin,0,0,param_00);
	var_02.angles = param_01.angles;
	if(scripts\mp\_utility::func_9FB3(level.var_C1C3) && param_00 == 0)
	{
		playfx(scripts\common\utility::getfx("mons_screen_ash"),param_01.origin);
	}

	return var_02;
}

//Function Number: 15
func_AD7A(param_00)
{
	if(!isai(self) && scripts\common\utility::func_9C70())
	{
		self notifyonplayercommand("bro_action_1","+actionslot 1");
		self notifyonplayercommand("bro_action_2","+actionslot 2");
		self notifyonplayercommand("bro_action_3","+actionslot 3");
		self notifyonplayercommand("bro_action_4","+actionslot 4");
	}
	else
	{
		self notifyonplayercommand("bro_action_1","+actionslot 3");
		self notifyonplayercommand("bro_action_2","+actionslot 4");
		self notifyonplayercommand("bro_action_3","+actionslot 5");
		self notifyonplayercommand("bro_action_4","+actionslot 6");
	}

	for(;;)
	{
		thread func_AD79(param_00,1);
		thread func_AD79(param_00,2);
		thread func_AD79(param_00,3);
		thread func_AD79(param_00,4);
		self waittill("taunt_end");
	}
}

//Function Number: 16
func_AD79(param_00,param_01)
{
	self endon("taunt_start");
	self endon("broshot_done");
	for(;;)
	{
		self waittill("bro_action_" + param_01);
		thread func_5ABE(param_00,param_01);
		wait(0.05);
	}
}

//Function Number: 17
func_5ABE(param_00,param_01)
{
	self notify("taunt_start");
	self endon("broshot_done");
	if(isdefined(self.var_3C56))
	{
		var_02 = level.var_2127[self.var_3C56.var_2123];
		if(level.rankedmatch)
		{
			var_03 = self getplayerdata("rankedloadouts","squadMembers","archetypePreferences",var_02,"taunts",param_01 - 1);
		}
		else
		{
			var_03 = self getplayerdata("privateloadouts","squadMembers","archetypePreferences",var_02,"taunts",param_01 - 1);
		}
	}
	else if(level.rankedmatch)
	{
		var_03 = self getplayerdata("rankedloadouts","squadMembers","taunts",var_03 - 1);
	}
	else
	{
		var_03 = self getplayerdata("privateloadouts","squadMembers","taunts",var_03 - 1);
	}

	if(isdefined(level.overridebroslot))
	{
		param_00 = level.overridebroslot - 1;
	}

	if(isdefined(level.overridetaunt))
	{
		var_03 = tablelookup("mp/cac/taunts.csv",0,level.overridetaunt,1);
	}

	var_04 = tablelookuprownum("mp/cac/taunts.csv",1,var_03);
	var_05 = tablelookup("mp/cac/taunts.csv",0,var_04,5);
	if(var_05 == "")
	{
		return;
	}

	var_06 = tablelookup("mp/cac/taunts.csv",0,var_04,19);
	var_07 = tablelookup("mp/cac/taunts.csv",0,var_04,20);
	var_08 = tablelookup("mp/cac/taunts.csv",0,var_04,21);
	var_09 = tablelookup("mp/cac/taunts.csv",0,var_04,12) == "Y";
	var_0A = tablelookup("mp/cac/taunts.csv",0,var_04,9);
	var_0B = "ui_broshot_anim_" + param_00;
	if(isdefined(level.interruptabletaunts[param_00]) && level.interruptabletaunts[param_00] == var_0A)
	{
		self notify("taunt_end");
		return;
	}

	var_0C = getdisplayweapon(self) == "none" || getdisplayweapon(self) == "iw7_fists_mp";
	if(!isdefined(level.firsttaunttracker[var_0B]) && !var_0C)
	{
		if(!var_09 && isdefined(level.supergunout[var_0B]))
		{
			level.firsttaunttracker[var_0B] = 1;
			func_DB36(var_0B);
		}

		if(!var_09)
		{
			level.supergunout[var_0B] = undefined;
		}
	}

	if(var_09 && !isdefined(level.supergunout[var_0B]))
	{
		level.firsttaunttracker[var_0B] = undefined;
		takesupergunout(var_0B,var_05);
		level.supergunout[var_0B] = 1;
	}

	var_0D = tablelookup("mp/cac/taunts.csv",0,var_04,17);
	var_0E = tablelookup("mp/cac/taunts.csv",0,var_04,18);
	if(param_00 > 0 && var_0D != "" && var_0E != "")
	{
		if(param_00 == 1)
		{
			var_0A = var_0D;
		}
		else if(param_00 == 2)
		{
			var_0A = var_0E;
		}
	}

	scripts\mp\broshot_utilities::processepictaunt(var_0A,param_00,1);
	var_0F = "ui_broshot_anim_" + param_00;
	setomnvar(var_0F,var_04);
	var_10 = float(var_08) / 30;
	var_11 = var_10;
	if(var_06 != "")
	{
		var_11 = var_11 * float(var_06);
	}

	level.interruptabletaunts[param_00] = var_0A;
	thread interruptblocker(param_00,var_10);
	wait(var_11);
	level.taunts_done = 1;
	self notify("taunt_end");
}

//Function Number: 18
interruptblocker(param_00,param_01)
{
	self notify("combo_started_" + param_00);
	self endon("combo_started_" + param_00);
	wait(param_01);
	level.interruptabletaunts[param_00] = undefined;
}

//Function Number: 19
getaltgunanimstring()
{
	var_00 = getdisplayweapon(self);
	if(issubstr(var_00,"iw7_nrg") || issubstr(var_00,"iw7_udm45") || issubstr(var_00,"iw7_ump45_mpr_akimbo"))
	{
		return "_alt";
	}

	return "";
}

//Function Number: 20
getgunanimstring()
{
	var_00 = getdisplayweapon(self);
	if(issubstr(var_00,"minilmg_mpl") && !issubstr(var_00,"spooled"))
	{
		return "augfury";
	}

	if(issubstr(var_00,"akimbo"))
	{
		return "akimbo";
	}

	if(issubstr(var_00,"mp28"))
	{
		return "mp28";
	}

	if(issubstr(var_00,"chargeshot") || issubstr(var_00,"glprox") || issubstr(var_00,"venom"))
	{
		return "assault_rifle";
	}

	if(issubstr(var_00,"knife"))
	{
		return "knife";
	}

	if(issubstr(var_00,"axe"))
	{
		return "axe";
	}

	var_01 = scripts\mp\_utility::func_8225(var_00);
	switch(var_01)
	{
		case "weapon_melee":
			return "melee";

		case "weapon_pistol":
			return "pistol";

		case "weapon_beam":
		case "weapon_smg":
			return "smg";

		case "weapon_assault":
			return "assault_rifle";

		case "weapon_lmg":
			return "lmg";

		case "weapon_rail":
		case "weapon_sniper":
		case "weapon_dmr":
			return "sniper";

		case "weapon_shotgun":
			return "shotgun";

		case "weapon_projectile":
			return "launcher";

		default:
			return "akimbo";
	}
}

//Function Number: 21
getgunanimindex()
{
	var_00 = getdisplayweapon(self);
	var_01 = scripts\mp\_utility::func_8225(var_00);
	if(issubstr(var_00,"minilmg_mpl") && !issubstr(var_00,"spooled"))
	{
		return 11;
	}

	if(issubstr(var_00,"mp28"))
	{
		return 12;
	}

	if(issubstr(var_00,"akimbo") && !issubstr(var_00,"akimbofmg") && !issubstr(var_00,"mod_akimboshotgun"))
	{
		if(issubstr(var_00,"iw7_nrg") || issubstr(var_00,"iw7_udm45") || issubstr(var_00,"iw7_ump45_mpr_akimbo"))
		{
			return 13;
		}

		return 8;
	}

	if(issubstr(var_00,"chargeshot") || issubstr(var_00,"glprox") || issubstr(var_00,"venom"))
	{
		return 2;
	}

	if(issubstr(var_00,"knife"))
	{
		return 9;
	}

	if(issubstr(var_00,"axe"))
	{
		return 10;
	}

	if(issubstr(var_00,"nunchuk") || issubstr(var_00,"katana"))
	{
		return 7;
	}

	switch(var_01)
	{
		case "weapon_pistol":
			return 0;

		case "weapon_beam":
		case "weapon_smg":
			return 1;

		case "weapon_assault":
			return 2;

		case "weapon_lmg":
			return 3;

		case "weapon_rail":
		case "weapon_sniper":
		case "weapon_dmr":
			return 4;

		case "weapon_shotgun":
			return 5;

		case "weapon_projectile":
			return 6;

		case "weapon_melee":
		default:
			return 7;
	}
}

//Function Number: 22
setguntypeforui(param_00)
{
	var_01 = "ui_broshot_weapon_type_" + param_00;
	setomnvar(var_01,getgunanimindex());
}

//Function Number: 23
func_DB36(param_00)
{
	var_01 = getgunanimstring();
	var_02 = var_01 + "_put_away" + getaltgunanimstring();
	var_03 = tablelookuprownum("mp/cac/taunts.csv",1,var_02);
	setomnvar(param_00,-1);
	var_04 = getgunputawayduration(var_01);
	wait(var_04);
}

//Function Number: 24
takesupergunout(param_00,param_01)
{
	var_02 = getrigtransstringfromref(param_01) + "transout_0";
	var_03 = tablelookuprownum("mp/cac/taunts.csv",1,var_02);
	setomnvar(param_00,var_03 + 30000);
	var_04 = getrigsupertakeoutdurationfromref(param_01);
	wait(var_04);
}

//Function Number: 25
getrigtransstringfromref(param_00)
{
	var_01 = "";
	switch(param_00)
	{
		case "archetype_assault":
		default:
			var_01 = "war_";
			break;

		case "archetype_heavy":
			var_01 = "heavy_";
			break;

		case "archetype_scout":
			var_01 = "c6_";
			break;

		case "archetype_assassin":
			var_01 = "ftl_";
			break;

		case "archetype_engineer":
			var_01 = "stryker_";
			break;

		case "archetype_sniper":
			var_01 = "ghost_";
			break;
	}

	return var_01;
}

//Function Number: 26
getgunputawayduration(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "akimbo":
		default:
			var_01 = 1.067;
			break;

		case "launcher":
			var_01 = 1.567;
			break;

		case "lmg":
			var_01 = 1.333;
			break;

		case "pistol":
			var_01 = 2.233;
			break;

		case "shotgun":
			var_01 = 1.233;
			break;

		case "smg":
		case "mp28":
			var_01 = 1.2;
			break;

		case "sniper":
			var_01 = 1.367;
			break;

		case "assault_rifle":
			var_01 = 1.233;
			break;

		case "melee":
			var_01 = 1.233;
			break;
	}

	return var_01 - 0.2;
}

//Function Number: 27
getrigsupertakeoutdurationfromref(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "archetype_assault":
		default:
			var_01 = 1.733;
			break;

		case "archetype_heavy":
			var_01 = 1.4;
			break;

		case "archetype_scout":
			var_01 = 0.67;
			break;

		case "archetype_assassin":
			var_01 = 1.133;
			break;

		case "archetype_engineer":
			var_01 = 1.733;
			break;

		case "archetype_sniper":
			var_01 = 1.3;
			break;
	}

	return var_01 - 0.2;
}

//Function Number: 28
getrigsuperputawaydurationfromref(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "archetype_assault":
		default:
			var_01 = 1.267;
			break;

		case "archetype_heavy":
			var_01 = 1.5;
			break;

		case "archetype_scout":
			var_01 = 0.67;
			break;

		case "archetype_assassin":
			var_01 = 1;
			break;

		case "archetype_engineer":
			var_01 = 1.3;
			break;

		case "archetype_sniper":
			var_01 = 1.167;
			break;
	}

	return var_01 - 0.2;
}

//Function Number: 29
func_445C(param_00,param_01)
{
	return param_00.var_278 >= param_01.var_278;
}

//Function Number: 30
func_C56E()
{
	self endon("broshot_done");
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isai(var_00))
		{
			thread startlatejoinpodium(var_00);
		}
	}
}

//Function Number: 31
startlatejoinpodium(param_00)
{
	param_00 endon("disconnect");
	wait(0.25);
	param_00 cameralinkto(level.var_37A6,"tag_origin",1);
	var_01 = param_00 getentitynumber();
	function_030D(var_01,self.var_BE05);
}

//Function Number: 32
changetestrig(param_00,param_01)
{
	level.overriderig = param_00;
	var_02 = param_01 - 1;
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	switch(param_00)
	{
		case 1:
		default:
			var_03 = 4;
			var_04 = 18;
			var_05 = 6;
			break;

		case 2:
			var_03 = 12;
			var_04 = 5;
			var_05 = 1;
			break;

		case 3:
			var_03 = 28;
			var_04 = 1;
			var_05 = 2;
			break;

		case 4:
			var_03 = 57;
			var_04 = 28;
			var_05 = 3;
			break;

		case 5:
			var_03 = 45;
			var_04 = 39;
			var_05 = 4;
			break;

		case 6:
			var_03 = 27;
			var_04 = 31;
			var_05 = 5;
			break;
	}

	self.var_BE05 = [];
	var_06 = max(param_01,level.topplayers.size);
	for(var_07 = 0;var_07 < var_06;var_07++)
	{
		self.var_BE05[var_07] = spawnstruct();
		self.var_BE05[var_07].var_26A = var_05;
		self.var_BE05[var_07].var_6A = var_04;
		self.var_BE05[var_07].var_171 = var_03;
		self.var_BE05[var_07].var_39C = getdisplayweapon(level.players[0]);
		self.var_BE05[var_07].var_9C = level.players[0] method_8567();
		self.var_BE05[var_07].name = level.players[0].name;
		self.var_BE05[var_07].var_3A3 = level.players[0] getxuid();
		self.var_BE05[var_07].var_D62C = param_01;
		self.var_BE05[var_07].var_41F5 = level.players[0] getentitynumber();
		if(!isdefined(level.topplayers[var_07]))
		{
			self.topplayers[var_07] = spawnstruct();
			level.topplayers[var_07].bro = func_B29D(var_07,level.var_37A8.var_3CAA[var_07]);
		}
	}

	for(var_07 = 0;var_07 < var_06;var_07++)
	{
		level.topplayers[var_07] setguntypeforui(var_07);
	}

	wait(0.05);
	function_030D(-1,self.var_BE05);
}

//Function Number: 33
changetesttaunt(param_00)
{
	level.overridetaunt = param_00;
}

//Function Number: 34
changetestslot(param_00)
{
	level.overridebroslot = param_00;
	if(!isdefined(level.topplayers[param_00 - 1]))
	{
		var_01 = 0;
		if(isdefined(level.overriderig))
		{
			var_01 = level.overriderig;
		}

		changetestrig(var_01,param_00);
	}
}