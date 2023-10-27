/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_airdrop.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 596 ms
 * Timestamp: 10/27/2023 3:24:51 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	if(getdvarint("4017",0) || function_0367())
	{
		return;
	}

	func_8620("care_package");
	level.var_275F = [];
	func_09F1();
	func_401A();
}

//Function Number: 2
func_09F1()
{
	func_09F0("uav",120,"support",&"MP_UAV_PICKUP");
	func_09F0("counter_uav",110,"support",&"MP_COUNTER_UAV_PICKUP");
	func_09F0("fritzx",100,"missile",&"MP_FRITZX_PICKUP");
	func_09F0("mortar_strike",90,"missile",&"MP_MORTAR_STRIKE_PICKUP");
	func_09F0("flak_gun",85,"support",&"MP_FLAK_GUN_PICKUP");
	func_09F0("flamethrower",85,"support",&"MP_FLAMETHROWER_PICKUP");
	func_09F0("missile_strike",80,"missile",&"MP_MISSILE_STRIKE_PICKUP");
	func_09F0("airstrike",75,"plane",&"MP_AIRSTRIKE_PICKUP");
	func_09F0("firebomb",70,"plane",&"MP_FIREBOMB_PICKUP");
	func_09F0("attack_dogs",50,"plane",&"MP_DOGS_PICKUP");
	func_09F0("fighter_strike",40,"plane",&"MP_FIGHTER_STRIKE_PICKUP");
	func_09F0("plane_gunner",20,"plane",&"MP_PLANE_GUNNER_PICKUP");
}

//Function Number: 3
func_401A()
{
	level.var_274B["all"] = 0;
	foreach(var_01 in level.var_275F)
	{
		var_02 = var_01.var_944E;
		var_03 = var_01.var_9451;
		if(!isdefined(level.var_274B[var_01.var_9451]))
		{
			level.var_274B[var_01.var_9451] = 0;
		}

		level.var_274B[var_03] = level.var_274B[var_03] + var_01.var_7A8F;
		level.var_275F[var_02].var_9452 = level.var_274B[var_03];
		level.var_274B["all"] = level.var_274B["all"] + var_01.var_7A8F;
		level.var_275F[var_02].var_C36 = level.var_274B["all"];
	}
}

//Function Number: 4
func_8620(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	if(!isdefined(var_01) || var_01.size == 0)
	{
		return;
	}

	level.var_B80 = getent(var_01[0].var_1A2,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 func_2D30();
	}
}

//Function Number: 5
func_09F0(param_00,param_01,param_02,param_03)
{
	level.var_275F[param_00] = spawnstruct();
	level.var_275F[param_00].var_944E = param_00;
	level.var_275F[param_00].var_9451 = param_02;
	level.var_275F[param_00].var_7A8F = param_01;
	level.var_275F[param_00].var_C36 = param_01;
	level.var_275F[param_00].var_9452 = param_01;
	if(isdefined(param_03))
	{
		game["strings"][param_00 + "_hint"] = param_03;
	}
}

//Function Number: 6
func_4479(param_00)
{
	var_02 = undefined;
	if(isdefined(param_00) && param_00 != "all")
	{
		var_03 = randomint(level.var_274B[param_00]);
		foreach(var_05 in level.var_275F)
		{
			if(var_05.var_9451 != param_00)
			{
				continue;
			}

			var_02 = var_05.var_944E;
			if(var_05.var_9452 > var_03)
			{
				break;
			}
		}
	}
	else
	{
		var_03 = randomint(level.var_274B["all"]);
		foreach(var_05 in level.var_275F)
		{
			var_02 = var_05.var_944E;
			if(var_05.var_C36 > var_03)
			{
				break;
			}
		}
	}

	return var_02;
}

//Function Number: 7
func_90C6(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(var_04 != param_01)
		{
			var_02[var_04.var_1B9] = var_04;
		}
	}

	return var_02;
}

//Function Number: 8
func_2D43(param_00)
{
	self linkto(param_00,"tag_origin",(0,0,0),(0,0,0));
	param_00 waittill("death");
	self delete();
}

//Function Number: 9
func_275C()
{
	self endon("death");
	self method_805C();
	foreach(var_01 in level.var_744A)
	{
		if(var_01.var_1A7 != "spectator")
		{
			self showtoclient(var_01);
		}
	}

	for(;;)
	{
		level waittill("joined_team");
		self method_805C();
		foreach(var_01 in level.var_744A)
		{
			if(var_01.var_1A7 != "spectator")
			{
				self showtoclient(var_01);
			}
		}
	}
}

//Function Number: 10
func_274D(param_00,param_01)
{
	self endon("death");
	self method_805C();
	foreach(var_03 in level.var_744A)
	{
		if(var_03.var_1A7 == param_00 || param_01 && var_03.var_1A7 == "spectator")
		{
			self showtoclient(var_03);
		}
	}

	for(;;)
	{
		level common_scripts\utility::knock_off_battery("joined_team","joined_spectators");
		self method_805C();
		foreach(var_03 in level.var_744A)
		{
			if(var_03.var_1A7 == param_00 || param_01 && var_03.var_1A7 == "spectator")
			{
				self showtoclient(var_03);
			}
		}
	}
}

//Function Number: 11
func_274C(param_00,param_01)
{
	self endon("death");
	self method_805C();
	foreach(var_03 in level.var_744A)
	{
		if(param_01 && isdefined(param_00) && var_03 != param_00)
		{
			continue;
		}

		if(!param_01 && isdefined(param_00) && var_03 == param_00)
		{
			continue;
		}

		self showtoclient(var_03);
	}

	for(;;)
	{
		level waittill("joined_team");
		self method_805C();
		foreach(var_03 in level.var_744A)
		{
			if(param_01 && isdefined(param_00) && var_03 != param_00)
			{
				continue;
			}

			if(!param_01 && isdefined(param_00) && var_03 == param_00)
			{
				continue;
			}

			self showtoclient(var_03);
		}
	}
}

//Function Number: 12
func_2762(param_00)
{
	self endon("death");
	for(;;)
	{
		func_8A56(param_00);
		level waittill("joined_team");
	}
}

//Function Number: 13
func_27CB(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_04))
	{
		param_04 = (0,0,0);
	}

	if(!isdefined(param_06))
	{
		param_06 = 1;
	}

	var_07 = spawn("script_model",param_03);
	var_07.var_1D = param_04;
	var_07.var_28D5 = 0;
	var_07.var_A22B = 0;
	var_07.var_1A7 = self.var_1A7;
	if(isdefined(param_00))
	{
		var_07.var_117 = param_00;
	}
	else
	{
		var_07.var_117 = undefined;
	}

	var_07.var_944E = param_02;
	var_07.var_34B5 = param_01;
	var_07.var_1A5 = "care_package";
	if(var_07.var_1A7 == "any")
	{
		var_07 setmodel("ger_carepackage_crate");
		var_07.var_3EE1 = spawn("script_model",var_07.var_116);
		var_07.var_3EE1 setmodel("tag_origin");
		var_07.var_3EE1 thread func_2D43(var_07);
	}
	else
	{
		var_07 setmodel(maps\mp\gametypes\_teams::func_46C6(var_07.var_1A7));
		var_07 thread func_275C();
		var_08 = "ger_carepackage_crate";
		var_09 = "ger_carepackage_crate";
		var_07.var_3EE1 = spawn("script_model",param_03);
		var_07.var_3EE1 setmodel(var_08);
		var_07.var_3EE1.var_6E77 = var_07;
		var_07.var_3EE1 notsolid();
		var_07.var_376E = spawn("script_model",param_03);
		var_07.var_376E setmodel(var_09);
		var_07.var_376E.var_6E77 = var_07;
		var_07.var_376E notsolid();
		var_07.var_3EE1 thread func_2D43(var_07);
		if(level.var_984D)
		{
			var_07.var_3EE1 thread func_274D(var_07.var_1A7,1);
		}
		else
		{
			var_07.var_3EE1 thread func_274C(param_00,1);
		}

		var_07.var_376E thread func_2D43(var_07);
		if(level.var_984D)
		{
			var_07.var_376E thread func_274D(level.var_6C63[var_07.var_1A7],0);
		}
		else
		{
			var_07.var_376E thread func_274C(param_00,0);
		}
	}

	var_07.var_54F5 = 0;
	if(param_06)
	{
		var_07 clonebrushmodeltoscriptmodel(level.var_B80);
	}

	var_07.var_5A2C = spawn("script_model",var_07.var_116 + (0,0,-200));
	var_07.var_5A2C setscriptmoverkillcam("missile");
	var_07.var_5A2C method_80B1();
	var_07.var_5A2C linkto(var_07);
	return var_07;
}

//Function Number: 14
func_275B(param_00)
{
	self setcursorhint("HINT_NOICON");
	self sethintstring(param_00);
}

//Function Number: 15
func_275A(param_00)
{
	self makeusable();
	if(self.var_1A7 == "any")
	{
		var_01 = maps\mp\gametypes\_gameobjects::func_45A9();
		objective_add(var_01,"invisible",(0,0,0));
		objective_position(var_01,self.var_116);
		objective_state(var_01,"active");
		var_02 = "compass_objpoint_ammo_friendly";
		function_01D1(var_01,var_02);
		objective_team(var_01,"none");
		self.var_698E = var_01;
	}
	else
	{
		if(level.var_984D || isdefined(self.var_117))
		{
			var_01 = maps\mp\gametypes\_gameobjects::func_45A9();
			objective_add(var_01,"invisible",(0,0,0));
			objective_position(var_01,self.var_116);
			objective_state(var_01,"active");
			var_02 = "compass_objpoint_ammo_friendly";
			function_01D1(var_01,var_02);
			if(!level.var_984D && isdefined(self.var_117))
			{
				objective_playerteam(var_01,self.var_117 getentitynumber());
			}
			else
			{
				objective_team(var_01,self.var_1A7);
			}

			self.var_698E = var_01;
		}

		if(isdefined(self.var_117))
		{
			var_01 = maps\mp\gametypes\_gameobjects::func_45A9();
			objective_add(var_01,"invisible",(0,0,0));
			objective_position(var_01,self.var_116);
			objective_state(var_01,"active");
			function_01D1(var_01,"compass_objpoint_ammo_enemy");
			if(!level.var_984D && isdefined(self.var_117))
			{
				objective_playerenemyteam(var_01,self.var_117 getentitynumber());
			}
			else
			{
				objective_team(var_01,level.var_6C63[self.var_1A7]);
			}

			self.var_698D = var_01;
		}
	}

	if(self.var_1A7 == "any")
	{
		foreach(var_04 in level.var_985B)
		{
			if(isdefined(param_00) && isarray(param_00))
			{
				func_869F(var_04,param_00);
				continue;
			}

			maps\mp\_entityheadicons::func_869E(var_04,param_00,(0,0,60),14,14,undefined,undefined,undefined,undefined,undefined,0);
		}

		return;
	}

	thread func_2762();
	var_06 = self.var_944E;
	if(level.var_984D)
	{
		if(isdefined(param_00) && isarray(param_00))
		{
			func_869F(self.var_1A7,param_00);
			return;
		}

		maps\mp\_entityheadicons::func_869E(self.var_1A7,param_00,(0,0,60),14,14,undefined,undefined,undefined,undefined,undefined,0);
		return;
	}

	if(isdefined(self.var_117))
	{
		if(isdefined(param_00) && isarray(param_00))
		{
			func_869F(self.var_117,param_00);
			return;
		}

		maps\mp\_entityheadicons::func_869E(self.var_117,param_00,(0,0,60),14,14,undefined,undefined,undefined,undefined,undefined,0);
		return;
	}
}

//Function Number: 16
func_869F(param_00,param_01)
{
	var_02 = 10;
	var_03 = 0;
	self.var_5010 = [];
	foreach(var_05 in param_01)
	{
		self.var_5010[var_05] = common_scripts\utility::func_8FFC();
		self.var_5010[var_05] maps\mp\_entityheadicons::func_869E(param_00,var_05,(0,0,55 + var_03 * var_02),14,14,undefined,undefined,undefined,undefined,undefined,0);
		var_03++;
	}
}

//Function Number: 17
func_8A56(param_00)
{
	var_01 = self.var_944E;
	foreach(var_03 in level.var_744A)
	{
		if(!isdefined(param_00) || param_00 == var_03.var_1A7)
		{
			self enableplayeruse(var_03);
			continue;
		}

		self disableplayeruse(var_03);
	}
}

//Function Number: 18
func_6FAD(param_00,param_01)
{
	self waittill("physics_finished");
	self.var_34A3 = 0;
	thread func_5A5F(param_01);
	level thread func_34B2(self);
	var_02 = getentarray("trigger_hurt","classname");
	foreach(var_04 in var_02)
	{
		if(self.var_3EE1 istouching(var_04))
		{
			func_2D30();
			return;
		}
	}

	if(isdefined(self.var_117) && abs(self.var_116[2] - self.var_117.var_116[2]) > 4000)
	{
		func_2D30();
		return;
	}

	var_06 = spawnstruct();
	var_06.var_2AA8 = ::func_64EB;
	var_06.var_9AC2 = ::func_64EC;
	thread maps\mp\_movers::func_4A27(var_06);
}

//Function Number: 19
func_64EB(param_00)
{
	func_2D30(1,1);
}

//Function Number: 20
func_64EC(param_00)
{
	return func_1FFA(param_00) && func_1FFB(param_00);
}

//Function Number: 21
func_1FFA(param_00)
{
	return !isdefined(self.var_1A5) || !isdefined(param_00.var_1A5) || self.var_1A5 != "care_package" || param_00.var_1A5 != "care_package";
}

//Function Number: 22
func_1FFB(param_00)
{
	return !isdefined(self.var_1A5) || !isdefined(param_00.var_1FFE) || self.var_1A5 != "care_package" || !param_00.var_1FFE;
}

//Function Number: 23
func_34B2(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	maps\mp\gametypes\_hostmigration::func_A6F5(90);
	while(param_00.var_28D5 != 0)
	{
		wait(1);
	}

	param_00 func_2D30(1,1);
}

//Function Number: 24
func_2744()
{
	self endon("captured");
	while(isdefined(self))
	{
		self waittill("trigger",var_00);
		thread func_11C3(var_00);
	}
}

//Function Number: 25
func_11C3(param_00)
{
	if(param_00 method_83B8())
	{
		return;
	}

	if(!param_00 isonground() && !func_A6F8(param_00))
	{
		return;
	}

	if(!func_A276(param_00))
	{
		return;
	}

	var_01 = 3000;
	if(param_00 == self.var_117)
	{
		var_01 = 500;
	}

	param_00.var_56A1 = 1;
	var_02 = func_2836();
	var_03 = var_02 func_A213(param_00,var_01);
	if(isdefined(var_02))
	{
		var_02 delete();
	}

	if(isdefined(param_00))
	{
		param_00.var_56A1 = 0;
	}

	if(!var_03)
	{
		return;
	}

	self notify("captured",param_00);
}

//Function Number: 26
func_A6F8(param_00)
{
	if(param_00 isonground())
	{
		return 0;
	}

	var_01 = 200;
	var_02 = param_00.var_116;
	var_03 = gettime();
	while(isdefined(param_00) && maps\mp\_utility::func_57A0(param_00) && !param_00 isonground() && var_02 == param_00.var_116 && param_00 usebuttonpressed())
	{
		var_04 = gettime() - var_03;
		if(var_04 >= var_01)
		{
			return 1;
		}

		wait 0.05;
	}

	return 0;
}

//Function Number: 27
func_A276(param_00)
{
	var_01 = param_00 getcurrentprimaryweapon();
	if(issubstr(var_01,"turrethead") || issubstr(var_01,"flamethrower") || issubstr(var_01,"carepackage"))
	{
		return 1;
	}

	if(!param_00 maps\mp\killstreaks\_killstreaks::func_1F6E())
	{
		return 0;
	}

	if(isdefined(param_00.var_20CC) && !param_00 maps\mp\killstreaks\_killstreaks::func_1F6E())
	{
		return 0;
	}

	return 1;
}

//Function Number: 28
func_5A5F(param_00)
{
	self endon("death");
	var_01 = undefined;
	if(isdefined(game["strings"][param_00 + "_hint"]))
	{
		var_01 = game["strings"][param_00 + "_hint"];
	}
	else
	{
		var_01 = &"PLATFORM_GET_KILLSTREAK";
	}

	func_275A(maps\mp\killstreaks\_killstreaks::func_4533(param_00));
	if(isdefined(self.var_56C5) && self.var_56C5)
	{
		self waittill("physics_finished");
	}

	func_275B(var_01);
	thread func_2744();
	for(;;)
	{
		self waittill("captured",var_02);
		if(isdefined(self.var_117) && var_02 != self.var_117)
		{
			if(!level.var_984D || var_02.var_1A7 != self.var_1A7)
			{
				var_02 thread maps\mp\_events::func_4D4F(self.var_117);
			}
			else
			{
				self.var_117 thread maps\mp\_events::func_8AD6();
			}
		}

		var_02 method_8615("scavenger_pack_pickup");
		var_03 = var_02 maps\mp\killstreaks\_killstreaks::func_45A5(self.var_944E,0);
		var_02 thread maps\mp\gametypes\_hud_message::func_5A78(self.var_944E,undefined,undefined,var_03);
		var_02 thread maps\mp\killstreaks\_killstreaks::func_478D(self.var_944E,0,0,self.var_117);
		var_02 lib_0468::func_A28("packageCapped");
		func_2D30(1);
	}
}

//Function Number: 29
func_2D30(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(isdefined(self.var_698E))
	{
		maps\mp\_utility::func_68B(self.var_698E);
	}

	if(isdefined(self.var_698D))
	{
		maps\mp\_utility::func_68B(self.var_698D);
	}

	if(isdefined(self.var_5A2C))
	{
		self.var_5A2C delete();
	}

	if(isdefined(self.var_6DB1))
	{
		self.var_6DB1 delete();
	}

	if(isdefined(self.var_6C62))
	{
		self.var_6C62 delete();
	}

	if(isdefined(self.var_34B5))
	{
		if(param_00)
		{
			playfx(common_scripts\utility::func_44F5("care_package_axis_destroy"),self.var_116,anglestoforward(self.var_1D));
		}

		if(param_01)
		{
			playsoundatpos(self.var_116,"orbital_pkg_self_destruct");
		}
	}

	if(isdefined(self.var_5010))
	{
		foreach(var_03 in self.var_5010)
		{
			var_03 delete();
		}
	}

	thread func_27DF(self.var_116,self.var_1D);
	self delete();
}

//Function Number: 30
func_27DF(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02 setmodel("hub_lootcrate_a_pieces_chunks");
	var_02.var_1D = param_01;
	var_02 method_805B();
	wait 0.05;
	physicsexplosionsphere(param_00,100,80,0.6);
	wait(2);
	var_02 delete();
}

//Function Number: 31
func_A213(param_00,param_01)
{
	if(isplayer(param_00))
	{
		param_00 playerlinkto(self);
	}
	else
	{
		param_00 linkto(self);
	}

	param_00 common_scripts\utility::func_602();
	thread func_A215(param_00);
	self.var_28D5 = 0;
	self.var_54F5 = 1;
	self.var_A22B = 0;
	if(isplayer(param_00))
	{
		param_00 thread func_6F82(self,param_01);
	}

	var_02 = func_A214(param_00,param_01);
	if(!isdefined(self))
	{
		return 0;
	}

	self notify("useHoldThinkLoopDone");
	self.var_54F5 = 0;
	self.var_28D5 = 0;
	return var_02;
}

//Function Number: 32
func_A215(param_00)
{
	param_00 endon("death");
	common_scripts\utility::knock_off_battery("death","captured","useHoldThinkLoopDone");
	if(isalive(param_00))
	{
		param_00 common_scripts\utility::func_616();
		if(param_00 islinked())
		{
			param_00 unlink();
		}
	}
}

//Function Number: 33
func_6F82(param_00,param_01)
{
	self endon("disconnect");
	self setclientomnvar("ui_use_bar_text",1);
	self setclientomnvar("ui_use_bar_start_time",int(gettime()));
	var_02 = -1;
	while(maps\mp\_utility::func_57A0(self) && isdefined(param_00) && param_00.var_54F5 && !level.var_3F9D)
	{
		if(var_02 != param_00.var_A22B)
		{
			if(param_00.var_28D5 > param_01)
			{
				param_00.var_28D5 = param_01;
			}

			if(param_00.var_A22B > 0)
			{
				var_03 = gettime();
				var_04 = param_00.var_28D5 / param_01;
				var_05 = var_03 + 1 - var_04 * param_01 / param_00.var_A22B;
				self setclientomnvar("ui_use_bar_end_time",int(var_05));
			}

			var_02 = param_00.var_A22B;
		}

		wait 0.05;
	}

	self setclientomnvar("ui_use_bar_end_time",0);
}

//Function Number: 34
func_A214(param_00,param_01)
{
	while(!level.var_3F9D && isdefined(self) && maps\mp\_utility::func_57A0(param_00) && param_00 usebuttonpressed() && self.var_28D5 < param_01)
	{
		self.var_28D5 = self.var_28D5 + self.var_A22B * 50;
		if(!self.var_A22B)
		{
			self.var_A22B = 1;
		}

		if(self.var_28D5 >= param_01)
		{
			return maps\mp\_utility::func_57A0(param_00);
		}

		wait 0.05;
	}

	return 0;
}

//Function Number: 35
func_2836()
{
	var_00 = spawn("script_origin",self.var_116);
	var_00.var_28D5 = 0;
	var_00.var_A22B = 0;
	var_00.var_54F5 = 0;
	var_00 thread func_2D57(self);
	return var_00;
}

//Function Number: 36
func_2D57(param_00)
{
	self endon("death");
	param_00 waittill("death");
	self delete();
}