/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1321.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 60
 * Decompile Time: 84 ms
 * Timestamp: 10/27/2023 3:25:12 AM
*******************************************************************/

//Function Number: 1
func_52F4(param_00)
{
	if(getdvarint("4017",0) || function_0367())
	{
		return;
	}

	level.var_611["care_package_axis_destroy"] = loadfx("vfx/props/care_package_explode_axis");
	level.var_611["care_package_allies_destroy"] = loadfx("vfx/props/care_package_explode_allies");
	level.var_611["care_package_allies_beacon"] = loadfx("vfx/lights/usa_carepackage_beacon");
	level.var_611["care_package_axis_beacon"] = loadfx("vfx/lights/ger_carepackage_beacon");
	level.var_611["care_package_landed"] = loadfx("vfx/smoke/care_package_landed");
	level.var_5A7D["killstreak_carepackage_grenade_mp"] = "carepackage";
	level.var_5A7D["killstreak_carepackage_grenade_axis_mp"] = "carepackage";
	level.var_5A7D["killstreak_emergency_carepackage_grenade_mp"] = "emergency_carepackage";
	level.var_5A7D["killstreak_emergency_carepackage_grenade_axis_mp"] = "emergency_carepackage";
	level.var_5A7D["carepackage_crate_mp"] = "carepackage";
	level.var_80B7["carepackage"] = 0;
	level.var_80B8["carepackage"] = 0;
	level.var_80B6["carepackage"] = 0;
	level.var_80B9["carepackage"] = 1;
	level.var_80B5["carepackage"] = 0;
	level.var_80B7["raid_carepackage"] = 0;
	level.var_80B8["raid_carepackage"] = 0;
	level.var_80B6["raid_carepackage"] = 0;
	level.var_80B9["raid_carepackage"] = 1;
	level.var_80B5["raid_carepackage"] = 0;
	level.var_80B7["emergency_carepackage"] = 0;
	level.var_80B8["emergency_carepackage"] = 0;
	level.var_80B6["emergency_carepackage"] = 0;
	level.var_80B9["emergency_carepackage"] = 1;
	level.var_80B5["emergency_carepackage"] = 0;
	level.var_80B7["zm_carepackage"] = 0;
	level.var_80B8["zm_carepackage"] = 0;
	level.var_80B6["zm_carepackage"] = 0;
	level.var_80B9["zm_carepackage"] = 1;
	level.var_80B5["zm_carepackage"] = 0;
	func_8A0E();
	if(isdefined(param_00))
	{
		func_27D5(param_00);
	}
	else
	{
		func_27D4();
	}

	addstreakhintstringentries();
}

//Function Number: 2
func_27D4()
{
	level.var_275F = [];
	func_09A9("uav",120,"lowEndStreak",&"MP_UAV_PICKUP");
	func_09A9("counter_uav",105,"lowEndStreak",&"MP_COUNTER_UAV_PICKUP");
	func_09A9("fighter_strike",100,"lowEndStreak",&"MP_FIGHTER_STRIKE_PICKUP");
	func_09A9("fritzx",90,"lowEndStreak",&"MP_FRITZX_PICKUP");
	func_09A9("flamethrower",80,"lowEndStreak",&"MP_FLAMETHROWER_PICKUP");
	func_09A9("mortar_strike",75,"lowEndStreak",&"MP_MORTAR_STRIKE_PICKUP");
	func_09A9("missile_strike",70,"highEndStreak",&"MP_MISSILE_STRIKE_PICKUP");
	func_09A9("paratroopers",30,"highEndStreak",&"MP_PARATROOPERS_PICKUP");
	func_09A9("airstrike",25,"highEndStreak",&"MP_AIRSTRIKE_PICKUP");
	func_09A9("plane_gunner",10,"highEndStreak",&"MP_PLANE_GUNNER_PICKUP");
	if(getdvarint("1258",0) == 0 && getdvarint("2803",0) == 0)
	{
		func_09A9("flak_gun",50,"lowEndStreak",&"MP_FLAK_GUN_PICKUP");
		func_09A9("firebomb",45,"highEndStreak",&"MP_FIREBOMB_PICKUP");
	}

	func_4019();
}

//Function Number: 3
addstreakhintstringentries()
{
	game["strings"]["v2_rocket_hint"] = &"MP_V2_ROCKET_PICKUP";
	game["strings"]["tripwire_hint"] = &"MP_TRIPWIRE_PICKUP";
}

//Function Number: 4
func_27D5(param_00)
{
	var_01 = 0;
	var_02 = 1;
	var_03 = 2;
	var_04 = 3;
	foreach(var_06 in param_00)
	{
		func_09A9(var_06[var_01],var_06[var_02],var_06[var_03],var_06[var_04]);
	}

	func_4019();
}

//Function Number: 5
func_4019()
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

//Function Number: 6
func_09A9(param_00,param_01,param_02,param_03)
{
	if(getdvarint("scorestreak_enabled_" + param_00) == 0)
	{
		return;
	}

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

//Function Number: 7
func_8A0E()
{
	var_00 = getentarray("care_package","targetname");
	if(!isdefined(var_00) || var_00.size == 0)
	{
		return;
	}

	level.var_1FFC = getent(var_00[0].var_1A2,"targetname");
	foreach(var_02 in var_00)
	{
		var_02 func_2D30(0,0,0);
	}
}

//Function Number: 8
func_464D(param_00,param_01)
{
	if(function_0367())
	{
		return "ammo";
	}

	var_03 = undefined;
	if(isdefined(param_00) && param_00 != "all")
	{
		while(!isdefined(var_03) || common_scripts\utility::func_F79(param_01,var_03))
		{
			var_04 = randomint(level.var_274B[param_00]);
			foreach(var_06 in level.var_275F)
			{
				if(var_06.var_9451 != param_00)
				{
					continue;
				}

				var_03 = var_06.var_944E;
				if(var_06.var_9452 > var_04)
				{
					break;
				}
			}
		}
	}
	else
	{
		var_04 = randomint(level.var_274B["all"]);
		foreach(var_06 in level.var_275F)
		{
			var_03 = var_06.var_944E;
			if(var_06.var_C36 > var_04)
			{
				break;
			}
		}
	}

	return var_03;
}

//Function Number: 9
func_7032(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("death");
	param_00 endon("crashing");
	if(isdefined(param_01))
	{
		param_01 endon("disconnect");
		param_01 endon("joined_team");
	}

	lib_0527::func_A6E4(param_00,func_445E(param_02),param_01);
	level notify("airdropInbound");
	param_00.var_6F2A = 1;
	var_05 = func_464E();
	var_06 = [];
	for(var_07 = 0;var_07 < func_45BE(param_02);var_07++)
	{
		var_08 = func_3493(param_00,param_01,func_448E(param_02,var_05[var_07]),param_02,var_06,param_03,param_04);
		var_06[var_06.size] = var_08;
		if(var_08 == "uav")
		{
			var_06[var_06.size] = "counter_uav";
		}
		else if(var_08 == "counter_uav")
		{
			var_06[var_06.size] = "uav";
		}

		wait(randomfloatrange(0.075,0.15));
	}
}

//Function Number: 10
func_3493(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	lib_0527::func_34B0(param_00.var_116,param_00);
	var_07 = param_00.var_116 + (randomintrange(-3,3),randomfloatrange(-3,3),-5);
	return func_4AAE(param_01,var_07,param_03,param_02,param_04,param_05,param_06);
}

//Function Number: 11
func_45BE(param_00)
{
	switch(param_00)
	{
		case "zm_carepackage":
		case "raid_carepackage":
		case "carepackage":
			return 1;

		case "emergency_carepackage":
			return 3;
	}
}

//Function Number: 12
func_448E(param_00,param_01)
{
	switch(param_00)
	{
		case "zm_carepackage":
		case "raid_carepackage":
		case "carepackage":
			return "all";

		case "emergency_carepackage":
			return param_01;
	}
}

//Function Number: 13
func_464E()
{
	return common_scripts\utility::func_F92(["lowEndStreak","lowEndStreak","highEndStreak"]);
}

//Function Number: 14
func_445E(param_00)
{
	switch(param_00)
	{
		case "zm_carepackage":
		case "raid_carepackage":
		case "carepackage":
			return 50;

		case "emergency_carepackage":
			return 200;
	}
}

//Function Number: 15
func_9E38(param_00,param_01)
{
	if(maps\mp\_utility::func_5668() && !function_0367())
	{
		return 0;
	}

	if(isdefined(self.var_1A7) && self.var_1A7 == "allies")
	{
		var_02 = "killstreak_carepackage_grenade_mp";
	}
	else
	{
		var_02 = "killstreak_carepackage_grenade_axis_mp";
	}

	if(param_01 == "emergency_carepackage")
	{
		if(isdefined(self.var_1A7) && self.var_1A7 == "allies")
		{
			var_02 = "killstreak_emergency_carepackage_grenade_mp";
		}
		else
		{
			var_02 = "killstreak_emergency_carepackage_grenade_axis_mp";
		}
	}

	var_03 = func_7470(var_02,param_00,param_01);
	if(!isdefined(var_03) || !var_03)
	{
		return 0;
	}

	maps\mp\_matchdata::func_5E9A(param_01,self.var_116);
	return 1;
}

//Function Number: 16
func_7470(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	self endon("carepackage_grenade_switch");
	thread func_742D(param_00);
	for(;;)
	{
		self waittill("grenade_fire",var_03,var_04);
		if(isdefined(var_04) && var_04 == param_00)
		{
			self notify("grenade_info_processing");
			thread func_1E84(var_03,param_01,param_02);
			return 1;
		}
	}
}

//Function Number: 17
func_1E84(param_00,param_01,param_02)
{
	param_00 waittill("explode",var_03);
	var_04 = lib_0527::func_4570();
	lib_0527::func_9302(param_01,[var_03],[var_04],param_02);
}

//Function Number: 18
func_742D(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("grenade_info_processing");
	var_01 = self getcurrentweapon();
	while(var_01 == param_00 || maps\mp\_utility::func_568F(var_01) || maps\mp\_utility::isuseweapon(var_01))
	{
		self waittill("weapon_change",var_01);
	}

	if(maps\mp\_utility::func_5740(var_01))
	{
		self.var_5992 = var_01;
	}

	self notify("carepackage_grenade_switch");
}

//Function Number: 19
func_4AAE(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_06))
	{
		var_07 = param_06;
	}
	else
	{
		var_07 = func_464D(param_04,param_05);
	}

	thread func_8A0F(param_00,param_01,var_07,param_02,param_05);
	return var_07;
}

//Function Number: 20
func_8A0F(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_00 func_27D3(param_00,param_02,param_01,undefined,0,param_03,param_04);
	if(!isdefined(param_00.var_3448))
	{
		param_00.var_3448 = [];
	}

	param_00.var_3448[param_00.var_3448.size] = var_05;
	if(!isdefined(level.all_drop_crates))
	{
		level.all_drop_crates = [];
	}

	level.all_drop_crates[level.all_drop_crates.size] = var_05;
	if(level.all_drop_crates.size > 18)
	{
		level.all_drop_crates[0] func_2D30(1,1,1);
	}

	var_05 thread func_2358(param_00);
	var_06 = spawn("script_model",var_05 gettagorigin("tag_origin") + (0,0,-10));
	var_06.var_1D = (0,180,0);
	var_06.visualteam = param_00.var_1A7;
	if(isdefined(param_04))
	{
		var_06.visualteam = param_04;
	}

	if(var_06.visualteam == "allies" || var_06.visualteam == "zm")
	{
		var_06 setmodel("usa_carepackage_parachute_anim");
	}
	else
	{
		var_06 setmodel("ger_carepackage_parachute_anim");
	}

	var_06.var_1A7 = param_00.var_1A7;
	var_07 = spawn("script_model",var_06.var_116);
	var_07.var_1D = var_06.var_1D;
	var_07 setmodel("ger_carepackage_parachute");
	var_07 setcandamage(1);
	var_07 method_805C();
	var_07 method_8449(var_06);
	var_05.var_1D = var_06 gettagangles("TAG_CRATE");
	var_05.var_116 = var_06 gettagorigin("TAG_CRATE");
	var_05 method_8449(var_06,"TAG_CRATE");
	var_05.var_6E4A = var_06;
	var_05.flag_wait = var_07;
	if(isdefined(var_05.var_5A2C))
	{
		var_05.var_5A2C linkto(var_06,"tag_origin",(0,0,250),(90,0,0));
		var_05.var_5A2C.var_5A32 = gettime();
	}

	var_06 thread func_64B8();
	var_06 scriptmodelplayanim("carepackage_parachute_deploy");
	wait(1.75);
	if(!isdefined(var_06) || !isdefined(var_05))
	{
		return;
	}

	var_06.var_2D6A = 1;
	if(isdefined(var_05.var_6E4A))
	{
		var_06 scriptmodelplayanim("carepackage_parachute_loop");
	}

	if(maps\mp\_utility::func_585F() && isdefined(level.zombiekillstreaksenabled) && level.zombiekillstreaksenabled)
	{
		level notify("zombies_crate_spawned",var_05);
	}

	var_06 thread func_63BB(var_05,var_06);
	var_07 thread func_63BA(var_06,var_05);
	var_05 thread func_6376(param_00);
	var_05 thread func_2745();
	var_05 thread func_2752(param_02,param_00);
	var_05 thread func_74BA();
}

//Function Number: 21
func_2358(param_00)
{
	level endon("death");
	self waittill("death");
	if(isdefined(param_00) && isdefined(param_00.var_3448))
	{
		param_00.var_3448 = common_scripts\utility::func_FA0(param_00.var_3448);
	}

	if(isdefined(level.all_drop_crates))
	{
		level.all_drop_crates = common_scripts\utility::func_FA0(level.all_drop_crates);
	}
}

//Function Number: 22
func_64B8()
{
	self endon("death");
	self endon("detach");
	lib_0378::func_8D74("ks_carepackage_parachute");
	for(;;)
	{
		if(!isdefined(self.var_2D6A) || !self.var_2D6A)
		{
			self moveto(self.var_116 + (0,0,-45),0.05);
		}
		else
		{
			self moveto(self.var_116 + (0,0,-20),0.05);
		}

		wait 0.05;
	}
}

//Function Number: 23
func_63BA(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("detach");
	if(function_0367())
	{
		for(;;)
		{
			self waittill("damage",var_02,var_03);
			if(var_02 == 1)
			{
				break;
			}
		}
	}
	else
	{
		common_scripts\utility::func_A732("damage","death");
	}

	param_00 thread func_2E45(param_01,1);
}

//Function Number: 24
func_63BB(param_00,param_01)
{
	self endon("detach");
	param_00 endon("death");
	param_01 endon("death");
	var_02 = undefined;
	for(;;)
	{
		var_03 = param_01 gettagorigin("tag_origin");
		var_04 = (var_03[0],var_03[1],var_03[2] - 1000);
		var_05 = var_03;
		var_06 = bullettrace(var_03,var_04,1,param_00);
		if(var_06["fraction"] <= 0.5)
		{
			thread func_2E45(param_00,0);
			break;
		}

		if(isdefined(var_05) && isdefined(var_02) && var_05 == var_02)
		{
			break;
		}

		var_02 = var_05;
		wait 0.05;
	}
}

//Function Number: 25
func_2E45(param_00,param_01)
{
	var_02 = 2.666667;
	if(!isdefined(param_00) || !isdefined(self))
	{
		return;
	}

	if(isdefined(param_00.var_34A3) && param_00.var_34A3)
	{
		return;
	}

	self notify("detach");
	if(isdefined(param_00.flag_wait))
	{
		param_00.flag_wait delete();
	}

	param_00.var_34A3 = 1;
	self method_8278("carepackage_parachute_detach");
	wait(0.2);
	if(param_00.visualteam == "allies")
	{
		playfxontag(common_scripts\utility::func_44F5("care_package_allies_beacon"),param_00,"TAG_FX");
	}
	else
	{
		playfxontag(common_scripts\utility::func_44F5("care_package_axis_beacon"),param_00,"TAG_FX");
	}

	param_00 unlink();
	if(isdefined(param_00.var_5A2C))
	{
		param_00.var_5A2C unlink();
		param_00.var_5A2C thread func_5A2E(param_00);
	}

	if(!function_0367())
	{
		param_00 clonebrushmodeltoscriptmodel(level.var_1FFC);
	}

	if(function_0367() && param_01)
	{
		param_00 func_2D30(1,1,1);
	}
	else
	{
		var_03 = 500;
		if(maps\mp\_utility::func_579B())
		{
			var_03 = 100;
		}

		param_00 physicslaunchserver((0,0,0),(0,0,1000),3000,var_03);
	}

	var_04 = 1;
	wait(var_02 - 0.2 - var_04);
	self setmaterialscriptparam(1,1,0);
	if(self.visualteam == "allies")
	{
		self setmodel("usa_carepackage_parachute_anim_fade");
	}
	else
	{
		self setmodel("ger_carepackage_parachute_anim_fade");
	}

	self setmaterialscriptparam(1,0,var_04);
	wait(var_04);
	self delete();
}

//Function Number: 26
func_74BA()
{
	self endon("death");
	self waittill("physics_impact",var_00,var_01,var_02,var_03);
	lib_0378::func_8D74("ks_carepackage_firstImpact");
	playfx(common_scripts\utility::func_44F5("care_package_landed"),var_00,var_01);
	if(function_0367())
	{
		self.var_5AFA = 1;
	}

	thread func_720C();
}

//Function Number: 27
func_720C()
{
	self endon("physics_finished");
	self waittill("physics_impact",var_00,var_01,var_02,var_03);
	lib_0380::func_6844("ks_carepackage_physics",undefined,self);
	playfx(common_scripts\utility::func_44F5("care_package_landed"),var_00,var_01);
}

//Function Number: 28
func_2745()
{
	if(!isdefined(self))
	{
		return;
	}

	self endon("physics_finished");
	self endon("death");
	var_00 = 0;
	var_01 = self.var_116;
	for(;;)
	{
		wait 0.05;
		if(!isdefined(self))
		{
			return;
		}

		var_02 = distancesquared(var_01,self.var_116);
		if(var_02 < 56.25)
		{
			var_00++;
		}
		else
		{
			var_00 = 0;
		}

		var_01 = self.var_116;
	}
}

//Function Number: 29
func_0F30(param_00,param_01)
{
	var_02 = 300;
	var_03 = 100;
	var_04 = 1250;
	var_05 = vectornormalize(param_01 - param_00.var_116);
	var_06 = var_05[0] * var_02;
	var_07 = var_05[1] * var_02;
	var_08 = -1 * var_05[1] * var_04;
	var_09 = var_05[0] * var_04;
	self physicssetvelocityserver((var_06,var_07,var_03),(var_08,var_09,0));
}

//Function Number: 30
func_6376(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("physics_finished");
	if(maps\mp\_utility::func_579B() || !isdefined(param_00))
	{
		return;
	}

	var_01 = self.var_116;
	for(;;)
	{
		var_02 = self gettagorigin("tag_weapon");
		if(distancesquared(var_01,var_02) > 100)
		{
			foreach(var_04 in level.var_744A)
			{
				if((var_04.var_1A7 != "spectator" && var_04.var_1A7 != self.var_1A7) || isdefined(param_00) && var_04 == param_00)
				{
					if(var_04 istouching(self))
					{
						thread func_0F30(var_04,var_02);
						if(isdefined(param_00))
						{
							var_04 dodamage(150,var_02,param_00,self,"MOD_PROJECTILE","carepackage_crate_mp");
						}

						self notify("hit_player");
					}
				}
			}
		}

		var_01 = var_02;
		wait 0.05;
	}
}

//Function Number: 31
func_2752(param_00,param_01)
{
	self endon("death");
	self waittill("physics_finished");
	self.var_34A3 = 0;
	thread func_5A5F(param_00);
	if(!function_0367())
	{
		if(maps\mp\_utility::func_585F() && isdefined(level.zombie_crate_timeout_callback))
		{
			level thread [[ level.zombie_crate_timeout_callback ]](self);
		}
		else
		{
			level thread func_34B2(self);
		}
	}

	var_02 = getentarray("trigger_hurt","classname");
	foreach(var_04 in var_02)
	{
		if(self istouching(var_04))
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
	thread func_275D();
}

//Function Number: 32
func_64EB(param_00)
{
	func_2D30(1,1);
}

//Function Number: 33
func_64EC(param_00)
{
	return func_1FFA(param_00) && func_1FFB(param_00);
}

//Function Number: 34
func_1FFA(param_00)
{
	return !isdefined(self.var_1A5) || !isdefined(param_00.var_1A5) || self.var_1A5 != "care_package" || param_00.var_1A5 != "care_package";
}

//Function Number: 35
func_1FFB(param_00)
{
	return !isdefined(self.var_1A5) || !isdefined(param_00.var_1FFE) || self.var_1A5 != "care_package" || !param_00.var_1FFE;
}

//Function Number: 36
func_275D()
{
	var_00 = getnodesinradiussorted(self.var_116,300,0,300);
	foreach(var_02 in function_02D1())
	{
		if(!isalive(var_02))
		{
			continue;
		}

		if(var_02 istouching(self))
		{
			foreach(var_04 in var_00)
			{
				if(distancesquared(var_04.var_116,self.var_116) > 10000)
				{
					var_02 setorigin(var_04.var_116,1);
					var_00 = common_scripts\utility::func_F93(var_00,var_04);
					break;
				}
			}
		}
	}
}

//Function Number: 37
func_27D3(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	var_07 = spawn("script_model",param_02);
	var_07.var_1D = param_03;
	var_07.var_28D5 = 0;
	var_07.var_A22B = 0;
	if(function_0367())
	{
		var_07.var_1A7 = "any";
	}
	else
	{
		var_07.var_1A7 = param_00.var_1A7;
	}

	if(isdefined(param_00))
	{
		var_07.var_117 = param_00;
	}
	else
	{
		var_07.var_117 = undefined;
	}

	var_07.visualteam = "any";
	if(isdefined(param_06))
	{
		var_07.visualteam = param_06;
	}
	else if(isdefined(param_00))
	{
		var_07.visualteam = param_00.var_1A7;
	}

	var_07.var_944E = param_01;
	var_07.var_8F52 = param_05;
	var_07.var_1A5 = "care_package";
	var_07.var_3009 = spawn("script_model",var_07.var_116);
	var_07.var_65E1 = ::func_2D30;
	if(var_07.visualteam == "any")
	{
		var_07 setmodel("ger_carepackage_crate");
		var_07.var_3009 setmodel("ger_carepackage_crate");
		playfxontag(common_scripts\utility::func_44F5("care_package_axis_beacon"),var_07,"TAG_FX");
		var_07.visualteam = "axis";
	}
	else if(var_07.visualteam == "zm")
	{
		var_07 setmodel("zbw_carepackage_crate");
		var_07.var_3009 setmodel("zbw_carepackage_crate");
		playfxontag(common_scripts\utility::func_44F5("care_package_axis_beacon"),var_07,"TAG_FX");
		var_07.visualteam = "zm";
	}
	else
	{
		var_08 = maps\mp\gametypes\_teams::func_46C6(var_07.visualteam);
		var_07 setmodel(var_08);
		var_07.var_3009 setmodel(var_08);
		if(var_07.visualteam == "axis")
		{
			playfxontag(common_scripts\utility::func_44F5("care_package_axis_beacon"),var_07,"TAG_FX");
		}
		else
		{
			playfxontag(common_scripts\utility::func_44F5("care_package_allies_beacon"),var_07,"TAG_FX");
		}
	}

	var_07.var_3009 linkto(var_07,"tag_origin",(0,0,0),(0,0,0));
	var_07.var_3009 notsolid();
	var_07.var_54F5 = 0;
	if(param_04)
	{
		var_07 clonebrushmodeltoscriptmodel(level.var_1FFC);
	}

	var_07.var_5A2C = spawn("script_model",var_07.var_116 + (0,0,250));
	var_07.var_5A2C setscriptmoverkillcam("script_entity");
	var_07.var_5A2C method_80B1();
	return var_07;
}

//Function Number: 38
func_5A2E(param_00)
{
	param_00 endon("death");
	param_00 endon("hit_player");
	param_00 endon("physics_finished");
	self endon("death");
	var_01 = (0,0,250);
	self.var_116 = param_00.var_116 + var_01;
	var_02 = param_00.var_116;
	var_03 = 0;
	for(;;)
	{
		var_04 = param_00.var_116 - var_02;
		if(length(var_04) > 0.01)
		{
			var_05 = vectornormalize(var_04);
			var_06 = var_05 * -250;
			if(var_03 < 1)
			{
				var_07 = vectorlerp(var_01,var_06,var_03);
				var_03 = var_03 + 0.05;
			}
			else
			{
				var_07 = var_07;
			}

			self.var_116 = param_00.var_116 + var_07;
		}

		var_02 = param_00.var_116;
		wait 0.05;
	}
}

//Function Number: 39
func_275A(param_00)
{
	if(function_0367())
	{
		if(self.var_116[2] >= 90)
		{
			playfxontag(level.var_611["care_package_hit"],self,"tag_origin");
			common_scripts\utility::func_F93(level.var_1FFD,self);
			setomnvar("ui_fge_carepackages_remaining",level.var_1FFD.size);
			func_2D30(1,1,1);
		}
		else
		{
			var_01 = spawn("trigger_radius",self.var_116 + (0,0,-1),0,160,128);
			var_02 = maps\mp\gametypes\_gameobjects::func_2837("neutral",var_01,[self],(0,0,100));
			var_02 maps\mp\gametypes\_gameobjects::func_C30("enemy");
			var_02 maps\mp\gametypes\_gameobjects::func_8A5A(10);
			var_02 maps\mp\gametypes\_gameobjects::func_8A59(&"MP_SECURING_CRATE");
			var_02.var_6ABC = ::func_6AC0;
			var_02.var_6AFA = ::func_6AFD;
			level.var_76FD = 200;
			level.var_76FA = 5;
			self.var_321B = var_02;
			self hudoutlineenableforclients(level.var_744A,2,0);
			if(isdefined(level.var_320F))
			{
				self.var_320E = spawnfx(level.var_320F,self.var_116);
			}

			self notify("crate_start_countdown");
			return;
		}
	}

	self makeusable();
	if(self.var_1A7 == "any")
	{
		var_03 = maps\mp\gametypes\_gameobjects::func_45A9();
		objective_add(var_03,"invisible",(0,0,0));
		objective_position(var_03,self.var_116);
		objective_state(var_03,"active");
		function_01D1(var_03,"waypoint_empty_icon");
		function_036F(var_03,"scorestreak_minimap_care_package_crate");
		function_0370(var_03,maps\mp\gametypes\_gameobjects::func_446B("friendly"));
		objective_team(var_03,"none");
		self.var_698E = var_03;
	}
	else
	{
		if(level.var_984D || isdefined(self.var_117))
		{
			var_03 = maps\mp\gametypes\_gameobjects::func_45A9();
			objective_add(var_03,"invisible",(0,0,0));
			objective_position(var_03,self.var_116);
			objective_state(var_03,"active");
			function_01D1(var_03,"waypoint_empty_icon");
			function_036F(var_03,"scorestreak_minimap_care_package_crate");
			function_0370(var_03,maps\mp\gametypes\_gameobjects::func_446B("friendly"));
			if(!level.var_984D && isdefined(self.var_117))
			{
				objective_playerteam(var_03,self.var_117 getentitynumber());
			}
			else if(level.var_3FDC == "infect")
			{
				objective_team(var_03,"allies");
			}
			else
			{
				objective_team(var_03,self.var_1A7);
			}

			self.var_698E = var_03;
		}

		if(isdefined(self.var_117))
		{
			var_03 = maps\mp\gametypes\_gameobjects::func_45A9();
			objective_add(var_03,"invisible",(0,0,0));
			objective_position(var_03,self.var_116);
			objective_state(var_03,"active");
			function_01D1(var_03,"waypoint_empty_icon");
			function_036F(var_03,"scorestreak_minimap_care_package_crate");
			function_0370(var_03,maps\mp\gametypes\_gameobjects::func_446B("enemy"));
			if(!level.var_984D && isdefined(self.var_117))
			{
				objective_playerenemyteam(var_03,self.var_117 getentitynumber());
			}
			else
			{
				objective_team(var_03,level.var_6C63[self.var_1A7]);
			}

			self.var_698D = var_03;
		}
	}

	self.var_5022 = var_02;
	func_8A21(var_02);
}

//Function Number: 40
func_8A21(param_00,param_01)
{
	if(self.var_1A7 == "any")
	{
		foreach(var_03 in level.var_985B)
		{
			if(isdefined(param_00) && isarray(param_00))
			{
				func_869F(var_03,param_00);
				continue;
			}

			maps\mp\_entityheadicons::func_869E(var_03,param_00,(0,0,25),14,14,undefined,undefined,undefined,undefined,undefined,0,"tag_weapon",param_01);
		}

		return;
	}

	var_05 = self.var_944E;
	if(level.var_984D)
	{
		if(isdefined(param_00) && isarray(param_00))
		{
			func_869F(self.var_1A7,param_00);
			return;
		}

		maps\mp\_entityheadicons::func_869E(self.var_1A7,param_00,(0,0,25),14,14,undefined,undefined,undefined,undefined,undefined,0,"tag_weapon",param_01);
		return;
	}

	if(isdefined(self.var_117))
	{
		if(isdefined(param_00) && isarray(param_00))
		{
			func_869F(self.var_117,param_00);
			return;
		}

		maps\mp\_entityheadicons::func_869E(self.var_117,param_00,(0,0,25),14,14,undefined,undefined,undefined,undefined,undefined,0,"tag_weapon",param_01);
		return;
	}
}

//Function Number: 41
func_869F(param_00,param_01)
{
	var_02 = 10;
	var_03 = 0;
	self.var_5010 = [];
	foreach(var_05 in param_01)
	{
		self.var_5010[var_05] = common_scripts\utility::func_8FFC();
		self.var_5010[var_05] maps\mp\_entityheadicons::func_869E(param_00,var_05,(0,0,20 + var_03 * var_02),14,14,undefined,undefined,undefined,undefined,"tag_weapon",0);
		var_03++;
	}
}

//Function Number: 42
func_6AC0(param_00,param_01)
{
	if(!isdefined(self.var_7450))
	{
		self.var_7450 = 1;
		return;
	}

	self.var_7450++;
}

//Function Number: 43
func_6AFD(param_00,param_01,param_02)
{
	if(!param_02)
	{
		self.var_28D5 = 0;
		self.var_7450--;
		return;
	}

	var_03 = self.var_9AC3["allies"];
	foreach(var_05 in var_03)
	{
		var_05.var_721C thread maps\mp\gametypes\_missions::func_7750("ch_hq_aagun");
	}

	self.var_A582[0] notify("captured",param_01);
}

//Function Number: 44
func_2744()
{
	self endon("captured");
	while(isdefined(self))
	{
		self waittill("trigger",var_00);
		thread func_11C3(var_00);
	}
}

//Function Number: 45
preventactionslotspam()
{
	self method_8309(0);
	common_scripts\utility::func_A716("death","game_ended","disconnect","attemptCaptureEnd");
	self method_8309(1);
}

//Function Number: 46
func_11C3(param_00)
{
	if(param_00 method_83B8())
	{
		return;
	}

	if(!param_00 isonground() && !func_A7A0(param_00))
	{
		return;
	}

	if(!func_A276(param_00))
	{
		return;
	}

	if(level.var_3FDC == "infect" && isdefined(param_00.var_179) && param_00.var_179 == "axis")
	{
		return;
	}

	if(maps\mp\_utility::func_579B() || maps\mp\_utility::func_585F())
	{
		var_01 = 500;
	}
	else
	{
		var_01 = 3000;
		if(isdefined(self.var_117))
		{
			if(param_00 == self.var_117)
			{
				var_01 = 500;
			}
		}
		else if(param_00.var_1A7 == self.var_1A7)
		{
			var_01 = 500;
		}
	}

	param_00.var_56A1 = 1;
	param_00 thread preventactionslotspam();
	var_02 = func_2836();
	var_03 = var_02 func_A213(param_00,var_01,self);
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
		param_00 notify("attemptCaptureEnd");
		return;
	}

	self notify("captured",param_00);
	wait(0.2);
	param_00 notify("attemptCaptureEnd");
}

//Function Number: 47
func_A7A0(param_00)
{
	if(param_00 isonground())
	{
		return 0;
	}

	var_01 = param_00.var_116;
	var_02 = gettime();
	while(isdefined(param_00) && maps\mp\_utility::func_57A0(param_00) && !param_00 isonground() && var_01 == param_00.var_116 && param_00 usebuttonpressed())
	{
		var_03 = gettime() - var_02;
		if(var_03 >= 200)
		{
			return 1;
		}

		wait 0.05;
	}

	return 0;
}

//Function Number: 48
func_A276(param_00)
{
	var_01 = param_00 getcurrentprimaryweapon();
	if(maps\mp\_utility::func_579B() && issubstr(var_01,"flamethrower") || common_scripts\utility::func_73F5(param_00) && !maps\mp\_utility::playerhaskillstreak(param_00,"basic_training_serum"))
	{
		param_00 iclientprintlnbold(&"RAIDS_HAVE_AIRDROP_ITEM");
		return 0;
	}

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

//Function Number: 49
func_5A5F(param_00)
{
	self endon("death");
	var_01 = isdefined(self.var_117) && (self.var_117 maps\mp\_utility::func_649("specialty_unwrapper") || self.var_117 maps\mp\_utility::func_649("specialty_improvedstreaks")) && !maps\mp\_utility::func_579B();
	if(maps\mp\_utility::func_585F() || level.var_3FDC == "infect")
	{
		var_01 = 0;
	}

	var_02 = undefined;
	if(isdefined(game["strings"][param_00 + "_hint"]))
	{
		var_02 = game["strings"][param_00 + "_hint"];
	}
	else
	{
		var_02 = &"PLATFORM_GET_KILLSTREAK";
	}

	if(!maps\mp\_utility::func_585F())
	{
		func_275A(maps\mp\killstreaks\_killstreaks::func_4533(param_00));
	}

	if(isdefined(self.var_56C5) && self.var_56C5)
	{
		self waittill("physics_finished");
	}

	if(maps\mp\_utility::func_585F() && isdefined(level.zombiekillstreaksenabled) && level.zombiekillstreaksenabled)
	{
		if(isdefined(level.zombiecratecapturethink))
		{
			self thread [[ level.zombiecratecapturethink ]]();
		}
	}
	else
	{
		thread func_2744();
		var_03 = undefined;
		if(var_01)
		{
			var_04 = &"MP_PACKAGE_REROLL";
			self settertiaryhintstring(var_04);
			self sethintstringvisibleonlytoowner(1);
			thread func_2750();
		}

		self setcursorhint("HINT_NOICON");
		self sethintstring(var_02);
		self setsecondaryhintstring(&"MP_CARE_PACKAGE_PICKUP");
		self sethintstring2toenemyteam(1);
		if(level.var_3FDC == "infect")
		{
			self setsecondaryhintstring(&"INFECT_NO_CAPTURE_CRATE");
			self sethintstring2toenemyteam(1);
		}
	}

	for(;;)
	{
		self waittill("captured",var_05);
		if(function_0367())
		{
			level.var_2758++;
			common_scripts\utility::func_F93(level.var_1FFD,self);
			setomnvar("ui_fge_carepackages_secured",level.var_2758);
			setomnvar("ui_fge_carepackages_remaining",level.var_1FFD.size);
			foreach(var_05 in level.var_744A)
			{
				if(var_05.var_572A)
				{
					continue;
				}

				var_05 luinotifyeventextraplayer(&"delete_supply_drop_countdown",1,self);
			}
		}
		else if(maps\mp\_utility::func_585F())
		{
			if(isdefined(level.zombiecarepackageusefunc))
			{
				var_05 [[ level.zombiecarepackageusefunc ]](self);
			}

			continue;
		}
		else
		{
			if(isdefined(self.var_117))
			{
				if(var_05 == self.var_117)
				{
					if(isdefined(self.var_8F52))
					{
						if(self.var_8F52 == "carepackage" || self.var_8F52 == "raid_carepackage")
						{
							var_05 maps\mp\gametypes\_missions::func_7750("ch_streak_carepackage");
						}
						else if(self.var_8F52 == "emergency_carepackage")
						{
							var_05 maps\mp\gametypes\_missions::func_7750("ch_streak_emergencycare");
						}
					}
				}
				else if(!level.var_984D || var_05.var_1A7 != self.var_1A7)
				{
					var_05 thread maps\mp\_events::func_4D4F(self.var_117);
					if(isdefined(level.hijackeventfunc))
					{
						self [[ level.hijackeventfunc ]]();
					}
				}
				else
				{
					lib_0468::func_A1A("sharepackage",self.var_117,undefined,undefined,undefined);
					self.var_117 thread maps\mp\_events::func_8AD6();
				}
			}

			if(isdefined(self.visualteam))
			{
				var_05.raidcarepackageteam = self.visualteam;
			}

			lib_0380::func_6840("scavenger_pack_pickup",var_05);
			var_08 = undefined;
			if(maps\mp\_utility::func_579B())
			{
				if(var_05.var_1A7 == game["attackers"])
				{
					var_08 = "attacker_" + self.var_944E;
				}
				else
				{
					var_08 = "defender_" + self.var_944E;
				}
			}

			var_09 = var_05 maps\mp\killstreaks\_killstreaks::func_45A5(self.var_944E,0);
			var_05 thread maps\mp\gametypes\_hud_message::func_5A78(self.var_944E,undefined,undefined,var_09,var_08);
			var_05 thread maps\mp\killstreaks\_killstreaks::func_478D(self.var_944E,0,0,self.var_117);
			var_05 lib_0468::func_A28("packageCapped");
		}

		func_2D30(1);
	}
}

//Function Number: 50
func_2750()
{
	self.var_6DDE = 0;
	self.var_6DDF = 0;
	while(!level.var_3F9D && isdefined(self))
	{
		if(maps\mp\_utility::func_57A0(self.var_117))
		{
			var_00 = self.var_117 getusableentity();
			if(isdefined(var_00) && var_00 == self && self.var_117 usebuttonpressed())
			{
				self.var_6DDE++;
			}
			else if(self.var_6DDE > 0)
			{
				if(self.var_6DDE < 5)
				{
					if(self.var_6DDF == 1)
					{
						self notify("package_double_tap");
						var_01 = self.var_944E;
						var_02 = 0;
						while(self.var_944E == var_01 && var_02 < 100)
						{
							var_02++;
							self.var_944E = func_464D();
						}

						var_03 = game["strings"][self.var_944E + "_hint"];
						if(!isdefined(var_03))
						{
							var_03 = &"PLATFORM_GET_KILLSTREAK";
						}

						self sethintstring(var_03);
						self settertiaryhintstring("");
						self.var_5022 = maps\mp\killstreaks\_killstreaks::func_4533(self.var_944E);
						func_8A21(self.var_5022);
						lib_0380::func_6840("scavenger_pack_pickup",self.var_117);
						return 1;
					}
					else
					{
						self.var_6DDF = 1;
						thread func_97F9();
					}
				}

				self.var_6DDE = 0;
			}
		}

		wait 0.05;
	}
}

//Function Number: 51
func_97F9()
{
	level endon("game_ended");
	self endon("death");
	self endon("package_double_tap");
	wait(0.2);
	self.var_6DDF = 0;
}

//Function Number: 52
func_A213(param_00,param_01,param_02)
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
		param_00 thread func_6F82(self,param_01,param_02);
	}

	var_03 = func_A214(param_00,param_01);
	if(!isdefined(self))
	{
		return 0;
	}

	self notify("useHoldThinkLoopDone");
	self.var_54F5 = 0;
	self.var_28D5 = 0;
	return var_03;
}

//Function Number: 53
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

//Function Number: 54
func_6F82(param_00,param_01,param_02)
{
	self endon("disconnect");
	self setclientomnvar("ui_use_bar_text",1);
	self setclientomnvar("ui_use_bar_start_time",int(gettime()));
	var_03 = -1;
	while(maps\mp\_utility::func_57A0(self) && isdefined(param_00) && param_00.var_54F5 && !level.var_3F9D)
	{
		if(var_03 != param_00.var_A22B)
		{
			if(param_00.var_28D5 > param_01)
			{
				param_00.var_28D5 = param_01;
			}

			if(param_00.var_A22B > 0)
			{
				var_04 = int(param_02.var_116[0]);
				var_05 = int(param_02.var_116[1]);
				var_06 = int(param_02.var_116[2] + 25);
				self luinotifyevent(&"carepackage_icon_world_position",3,var_04,var_05,var_06);
				var_07 = gettime();
				var_08 = param_00.var_28D5 / param_01;
				var_09 = var_07 + 1 - var_08 * param_01 / param_00.var_A22B;
				self setclientomnvar("ui_use_bar_end_time",int(var_09));
				self setclientomnvar("ui_mp_carepackage_scorestreak",maps\mp\_utility::func_453F(param_02.var_944E));
				self setclientomnvar("ui_mp_carepackage_team",maps\mp\_utility::func_46D4(param_02.var_1A7));
				if(isdefined(param_02.var_117))
				{
					self setclientomnvar("ui_mp_carepackage_owner",param_02.var_117 getentitynumber());
				}

				param_02 func_8A21(param_02.var_5022,self);
			}

			var_03 = param_00.var_A22B;
		}

		wait 0.05;
	}

	if(isdefined(param_02))
	{
		param_02 func_8A21(param_02.var_5022);
	}

	self setclientomnvar("ui_use_bar_end_time",0);
}

//Function Number: 55
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

//Function Number: 56
func_2836()
{
	var_00 = spawn("script_origin",self.var_116);
	var_00.var_28D5 = 0;
	var_00.var_A22B = 0;
	var_00.var_54F5 = 0;
	var_00 thread func_2D57(self);
	return var_00;
}

//Function Number: 57
func_2D57(param_00)
{
	self endon("death");
	param_00 waittill("death");
	self delete();
}

//Function Number: 58
func_2D30(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
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

	if(isdefined(self.var_3009))
	{
		self.var_3009 delete();
	}

	if(param_00 && self.visualteam == "axis" || self.visualteam == "zm")
	{
		playfx(common_scripts\utility::func_44F5("care_package_axis_destroy"),self.var_116,anglestoforward(self.var_1D));
	}

	if(param_00 && self.visualteam == "allies")
	{
		playfx(common_scripts\utility::func_44F5("care_package_allies_destroy"),self.var_116,anglestoforward(self.var_1D));
	}

	if(param_01 && self.visualteam == "allies")
	{
		lib_0380::func_6842("ks_carepackage_open_allies",undefined,self.var_116);
	}

	if(param_01 && self.visualteam == "axis" || self.visualteam == "zm")
	{
		lib_0380::func_6842("ks_carepackage_open_axis",undefined,self.var_116);
	}

	if(isdefined(self.var_5010))
	{
		foreach(var_04 in self.var_5010)
		{
			var_04 delete();
		}
	}

	if(param_02 && self.visualteam == "axis" || self.visualteam == "zm")
	{
		thread func_27DF(self.var_116,self.var_1D);
	}

	if(function_0367() && isdefined(self.var_321B))
	{
		if(isdefined(self.var_320E))
		{
			self.var_320E delete();
		}

		if(isdefined(self.var_321B.var_9D65))
		{
			self.var_321B.var_9D65 delete();
		}

		self.var_321B maps\mp\gametypes\_gameobjects::func_2D58();
	}

	self delete();
}

//Function Number: 59
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

//Function Number: 60
func_27DF(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_03 = "ger_carepackage_crate_chunks";
	if(maps\mp\_utility::func_585F() && self.visualteam == "zm")
	{
		var_03 = "zbw_carepackage_crate_chunks";
	}

	var_02 setmodel(var_03);
	var_02.var_1D = param_01;
	var_02 method_805B();
	wait 0.05;
	physicsexplosionsphere(param_00,100,80,0.6);
	wait(2);
	var_02 delete();
}