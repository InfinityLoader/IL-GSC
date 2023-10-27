/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_helicopter.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 73
 * Decompile Time: 3314 ms
 * Timestamp: 10/27/2023 12:28:40 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = getentarray("heli_start","targetname");
	var_01 = getentarray("heli_loop_start","targetname");
	if(!var_00.size && !var_01.size)
	{
		return;
	}

	level.var_3F14 = undefined;
	level.var_8D96 = getentarray("heli_start","targetname");
	level.var_8D6F = getentarray("heli_loop_start","targetname");
	level.var_110D1 = scripts\common\utility::getstructarray("strafe_path","targetname");
	level.var_8D67 = getentarray("heli_leave","targetname");
	level.var_8D3E = getentarray("heli_crash_start","targetname");
	level.var_8D75 = 5;
	level.var_8D73 = 2000;
	level.var_8D43 = 0;
	level.var_8D9A = 0.5;
	level.var_8D9F = 1.5;
	level.var_8D9E = 60;
	level.var_8DA2 = 3700;
	level.var_8D98 = 5;
	level.var_8D97 = 0.5;
	level.var_8D74 = 256;
	level.var_8D76 = 0.3;
	level.var_8D2C = 0.3;
	level.var_8D2E = 1000;
	level.var_8D2D = 4096;
	level.var_8D2B = 90;
	level.var_8D56 = 0;
	level func_D80F();
	level.var_3F19["damage"]["light_smoke"] = loadfx("vfx/core/smktrail/smoke_trail_white_heli_emitter");
	level.var_3F19["damage"]["heavy_smoke"] = loadfx("vfx/core/mp/killstreaks/vfx_helo_damage.vfx");
	level.var_3F19["damage"]["on_fire"] = loadfx("vfx/core/expl/fire_smoke_trail_l_emitter");
	level.var_3F19["light"]["left"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_3F19["light"]["right"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_3F19["light"]["belly"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_3F19["light"]["tail"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_3F19["explode"]["medium"] = loadfx("vfx/core/expl/aerial_explosion");
	level.var_3F19["explode"]["large"] = loadfx("vfx/core/expl/helicopter_explosion_secondary_small");
	level.var_3F19["smoke"]["trail"] = loadfx("vfx/core/smktrail/smoke_trail_white_heli");
	level.var_3F19["explode"]["death"] = [];
	level.var_3F19["explode"]["death"]["apache"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_3F19["explode"]["air_death"]["apache"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_ACB5["apache"] = ::func_503F;
	level.var_ACB5["cobra"] = ::func_503F;
	level.var_3F19["explode"]["death"]["littlebird"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_3F19["explode"]["air_death"]["littlebird"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_ACB5["littlebird"] = ::func_503F;
	level._effect["vehicle_flares"] = loadfx("vfx/iw7/core/mp/killstreaks/vfx_warden_em_flares.vfx");
	level.var_3F19["fire"]["trail"]["medium"] = loadfx("vfx/core/expl/fire_smoke_trail_l_emitter");
	scripts\mp\killstreaks\_killstreaks::func_DEFB("helicopter",::func_13090);
	level.var_8DB6["tracking"][0] = "ac130_fco_moreenemy";
	level.var_8DB6["tracking"][1] = "ac130_fco_getthatguy";
	level.var_8DB6["tracking"][2] = "ac130_fco_guyrunnin";
	level.var_8DB6["tracking"][3] = "ac130_fco_gotarunner";
	level.var_8DB6["tracking"][4] = "ac130_fco_personnelthere";
	level.var_8DB6["tracking"][5] = "ac130_fco_rightthere";
	level.var_8DB6["tracking"][6] = "ac130_fco_tracking";
	level.var_8DB6["locked"][0] = "ac130_fco_lightemup";
	level.var_8DB6["locked"][1] = "ac130_fco_takehimout";
	level.var_8DB6["locked"][2] = "ac130_fco_nailthoseguys";
	level.var_A99A = 0;
	level.var_8DA6 = [];
	var_02 = spawnstruct();
	var_02.var_EC44 = "destroyed_helicopter";
	var_02.var_3774 = "callout_destroyed_helicopter";
	var_02.var_EB11 = 0.09;
	var_02.var_65D0 = "tag_engine_left";
	level.var_8DA6["helicopter"] = var_02;
	var_02 = spawnstruct();
	var_02.var_EC44 = "destroyed_little_bird";
	var_02.var_3774 = "callout_destroyed_little_bird";
	var_02.var_EB11 = 0.09;
	var_02.var_65D0 = "tag_engine_left";
	level.var_8DA6["airdrop"] = var_02;
	var_02 = spawnstruct();
	var_02.var_EC44 = "destroyed_dronedrop";
	var_02.var_52DA = "dronedrop_destroyed";
	var_02.var_3774 = "callout_destroyed_dronedrop";
	level.var_8DA6["dronedrop"] = var_02;
	var_02 = spawnstruct();
	var_02.var_EC44 = "destroyed_pavelow";
	var_02.var_3774 = "callout_destroyed_helicopter_flares";
	var_02.var_EB11 = 0.07;
	var_02.var_65D0 = "tag_engine_left";
	level.var_8DA6["flares"] = var_02;
	scripts\mp\_utility::func_DB8D("helicopter");
}

//Function Number: 2
func_B2A8(param_00,param_01,param_02)
{
	level.var_3F19["explode"]["death"][param_00] = loadfx(param_01);
	level.var_ACB5[param_00] = param_02;
}

//Function Number: 3
func_179D(param_00,param_01)
{
	level.var_3F19["explode"]["air_death"][param_00] = loadfx(param_01);
}

//Function Number: 4
func_503F()
{
	playfxontag(level.var_3F19["light"]["left"],self,"tag_light_L_wing");
	wait(0.05);
	playfxontag(level.var_3F19["light"]["right"],self,"tag_light_R_wing");
	wait(0.05);
	playfxontag(level.var_3F19["light"]["belly"],self,"tag_light_belly");
	wait(0.05);
	playfxontag(level.var_3F19["light"]["tail"],self,"tag_light_tail");
}

//Function Number: 5
func_13090(param_00,param_01)
{
	return func_128E6(param_00,"helicopter");
}

//Function Number: 6
func_128E6(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(level.var_3F14))
	{
		var_03 = 1;
	}
	else
	{
		var_03 = 0;
	}

	if(isdefined(level.var_3F14) && var_03)
	{
		self iprintlnbold(&"KILLSTREAKS_HELI_IN_QUEUE");
		if(isdefined(param_01) && param_01 != "helicopter")
		{
			var_04 = "helicopter_" + param_01;
		}
		else
		{
			var_04 = "helicopter";
		}

		var_05 = spawn("script_origin",(0,0,0));
		var_05 hide();
		var_05 thread func_51C2(self,"disconnect");
		var_05.player = self;
		var_05.var_AC68 = param_00;
		var_05.var_8DD9 = param_01;
		var_05.var_110EA = var_04;
		scripts\mp\_utility::func_DB8B("helicopter",var_05);
		var_06 = undefined;
		if(!self hasweapon(scripts\common\utility::getlastweapon()))
		{
			var_06 = scripts\mp\killstreaks\_utility::func_7EB7();
		}
		else
		{
			var_06 = scripts\common\utility::getlastweapon();
		}

		var_07 = scripts\mp\_utility::func_7F55("helicopter");
		return 0;
	}
	else if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA + var_06 >= scripts\mp\_utility::func_B4D2())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	var_06 = 1;
	func_10DA2(var_04,var_05);
	return 1;
}

//Function Number: 7
func_51C2(param_00,param_01)
{
	self endon("death");
	param_00 waittill(param_01);
	self delete();
}

//Function Number: 8
func_10DA2(param_00,param_01)
{
	scripts\mp\_utility::func_93FA();
	var_02 = undefined;
	if(!isdefined(param_01))
	{
		param_01 = "";
	}

	var_03 = "helicopter";
	var_04 = self.pers["team"];
	var_02 = level.var_8D96[randomint(level.var_8D96.size)];
	scripts\mp\_matchdata::func_AFC9(var_03,self.origin);
	thread func_8D9B(param_00,self,var_02,self.pers["team"],param_01);
}

//Function Number: 9
func_D80F()
{
	level.var_8D8A["allies"]["hit"] = "cobra_helicopter_hit";
	level.var_8D8A["allies"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
	level.var_8D8A["allies"]["damaged"] = "cobra_helicopter_damaged";
	level.var_8D8A["allies"]["spinloop"] = "cobra_helicopter_dying_loop";
	level.var_8D8A["allies"]["spinstart"] = "cobra_helicopter_dying_layer";
	level.var_8D8A["allies"]["crash"] = "exp_helicopter_fuel";
	level.var_8D8A["allies"]["missilefire"] = "weap_cobra_missile_fire";
	level.var_8D8A["axis"]["hit"] = "cobra_helicopter_hit";
	level.var_8D8A["axis"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
	level.var_8D8A["axis"]["damaged"] = "cobra_helicopter_damaged";
	level.var_8D8A["axis"]["spinloop"] = "cobra_helicopter_dying_loop";
	level.var_8D8A["axis"]["spinstart"] = "cobra_helicopter_dying_layer";
	level.var_8D8A["axis"]["crash"] = "exp_helicopter_fuel";
	level.var_8D8A["axis"]["missilefire"] = "weap_cobra_missile_fire";
}

//Function Number: 10
func_8D5C()
{
	var_00 = self.team;
	if(level.multiteambased)
	{
		var_00 = "axis";
	}

	return var_00;
}

//Function Number: 11
func_1072E(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnhelicopter(param_00,param_01,param_02,param_03,param_04);
	if(!isdefined(var_05))
	{
		return undefined;
	}

	if(param_04 == "vehicle_battle_hind")
	{
		var_05.var_8DA0 = "cobra";
	}
	else
	{
		var_05.var_8DA0 = level.var_8DA1[param_04];
	}

	var_05 thread [[ level.var_ACB5[var_05.var_8DA0] ]]();
	var_05 func_184E();
	var_05.var_13F0A = (0,0,var_05 gettagorigin("tag_origin")[2] - var_05 gettagorigin("tag_ground")[2]);
	var_05.var_2550 = missile_createattractorent(var_05,level.var_8D2E,level.var_8D2D);
	return var_05;
}

//Function Number: 12
func_8DB6(param_00)
{
	if(gettime() - level.var_A99A < 6000)
	{
		return;
	}

	level.var_A99A = gettime();
	var_01 = randomint(level.var_8DB6[param_00].size);
	var_02 = level.var_8DB6[param_00][var_01];
	var_03 = scripts\mp\_teams::func_81BC(self.team) + var_02;
	self playlocalsound(var_03);
}

//Function Number: 13
func_12E60(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_03.var_1314F = [];
		var_03.var_C056 = 0;
	}

	foreach(var_06 in level.players)
	{
		if(!isalive(var_06))
		{
			continue;
		}

		if(var_06.team == self.team)
		{
			continue;
		}

		foreach(var_03 in param_00)
		{
			if(distancesquared(var_06.origin,var_03.origin) > 1048576)
			{
				continue;
			}

			var_03.var_1314F[var_03.var_1314F.size] = var_06;
		}
	}

	var_0A = param_00[0];
	foreach(var_03 in param_00)
	{
		var_0C = getent(var_03.target,"targetname");
		foreach(var_06 in var_03.var_1314F)
		{
			var_03.var_C056 = var_03.var_C056 + 1;
			if(bullettracepassed(var_06.origin + (0,0,32),var_0C.origin,0,var_06))
			{
				var_03.var_C056 = var_03.var_C056 + 3;
			}
		}

		if(var_03.var_C056 > var_0A.var_C056)
		{
			var_0A = var_03;
		}
	}

	return getent(var_0A.target,"targetname");
}

//Function Number: 14
func_8D9B(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_02.origin;
	var_06 = param_02.angles;
	var_07 = "cobra_mp";
	var_08 = "vehicle_battle_hind";
	var_09 = func_1072E(param_01,var_05,var_06,var_07,var_08);
	if(!isdefined(var_09))
	{
		return;
	}

	level.var_3F14 = var_09;
	if(param_03 == "allies")
	{
		level.var_1C29 = var_09;
	}
	else
	{
		level.var_26F5 = var_09;
	}

	var_09.var_8DD9 = param_04;
	var_09.var_AC68 = param_00;
	var_09.team = param_03;
	var_09.pers["team"] = param_03;
	var_09.var_222 = param_01;
	var_09 method_831F(param_01);
	var_09.var_10DCD = param_02;
	var_09.maxhealth = level.var_8D73;
	var_09.var_11568 = level.var_8D9A;
	var_09.var_D8DF = undefined;
	var_09.var_F0C3 = undefined;
	var_09.var_4F = undefined;
	var_09.var_4C07 = "ok";
	var_09 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air",param_01);
	var_09.var_61A3 = 0;
	if(param_04 == "flares" || param_04 == "minigun")
	{
		var_09 thread scripts\mp\killstreaks\_flares::func_6EAD(1);
	}

	var_09 thread func_8D69(param_01);
	var_09 thread func_8D68(param_01);
	var_09 thread func_8D6A(param_01);
	var_09 thread func_8D40(param_04);
	var_09 thread func_8DA5();
	var_09 thread func_8DA4();
	var_09 thread func_8D49();
	var_09 endon("helicopter_done");
	var_09 endon("crashing");
	var_09 endon("leaving");
	var_09 endon("death");
	var_0A = getentarray("heli_attack_area","targetname");
	var_0B = undefined;
	var_0B = level.var_8D6F[randomint(level.var_8D6F.size)];
	var_09 func_8D53(param_02);
	var_09 thread func_8D99();
	var_09 thread func_8D6D(60);
	var_09 thread func_8D52(var_0B);
}

//Function Number: 15
func_8D49()
{
	var_00 = self getentitynumber();
	scripts\common\utility::waittill_any_3("death","crashing","leaving");
	func_E109(var_00);
	self notify("helicopter_done");
	self notify("helicopter_removed");
	var_01 = undefined;
	var_02 = scripts\mp\_utility::func_DB94("helicopter");
	if(!isdefined(var_02))
	{
		level.var_3F14 = undefined;
		return;
	}

	var_01 = var_02.player;
	var_03 = var_02.var_AC68;
	var_04 = var_02.var_110EA;
	var_05 = var_02.var_8DD9;
	var_02 delete();
	if(isdefined(var_01) && var_01.sessionstate == "playing" || var_01.sessionstate == "dead")
	{
		var_01 func_10DA2(var_03,var_05);
		return;
	}

	level.var_3F14 = undefined;
}

//Function Number: 16
func_8D99()
{
	self notify("heli_targeting");
	self endon("heli_targeting");
	self endon("death");
	self endon("helicopter_done");
	for(;;)
	{
		var_00 = [];
		self.var_D8DF = undefined;
		self.var_F0C3 = undefined;
		foreach(var_02 in level.var_3CB5)
		{
			wait(0.05);
			if(!func_3922(var_02))
			{
				continue;
			}

			var_00[var_00.size] = var_02;
		}

		if(var_00.size)
		{
			for(var_04 = func_7E00(var_00);!isdefined(var_04);var_04 = func_7E00(var_00))
			{
				wait(0.05);
			}

			self.var_D8DF = var_04;
			self notify("primary acquired");
		}

		if(isdefined(self.var_D8DF))
		{
			func_6D7A(self.var_D8DF);
			continue;
		}

		wait(0.25);
	}
}

//Function Number: 17
func_3922(param_00)
{
	var_01 = 1;
	if(!isalive(param_00) || isdefined(param_00.sessionstate) && param_00.sessionstate != "playing")
	{
		return 0;
	}

	if(self.var_8DD9 == "remote_mortar")
	{
		if(param_00 method_838A(self.origin,self) < 1)
		{
			return 0;
		}
	}

	if(distance(param_00.origin,self.origin) > level.var_8DA2)
	{
		return 0;
	}

	if(!self.var_222 scripts\mp\_utility::func_9DD6(param_00))
	{
		return 0;
	}

	if(isdefined(param_00.var_10916) && gettime() - param_00.var_10916 / 1000 <= 5)
	{
		return 0;
	}

	if(param_00 scripts\mp\_utility::_hasperk("specialty_blindeye"))
	{
		return 0;
	}

	var_02 = self.origin + (0,0,-160);
	var_03 = anglestoforward(self.angles);
	var_04 = var_02 + 144 * var_03;
	if(param_00 method_838A(var_04,self) < level.var_8D97)
	{
		return 0;
	}

	return var_01;
}

//Function Number: 18
func_7E00(param_00)
{
	foreach(var_02 in param_00)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		func_12E10(var_02);
	}

	var_04 = 0;
	var_05 = undefined;
	var_06 = getentarray("minimap_corner","targetname");
	foreach(var_02 in param_00)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		if(var_06.size == 2)
		{
			var_08 = var_06[0].origin;
			var_09 = var_06[0].origin;
			if(var_06[1].origin[0] > var_09[0])
			{
				var_09 = (var_06[1].origin[0],var_09[1],var_09[2]);
			}
			else
			{
				var_08 = (var_06[1].origin[0],var_08[1],var_08[2]);
			}

			if(var_06[1].origin[1] > var_09[1])
			{
				var_09 = (var_09[0],var_06[1].origin[1],var_09[2]);
			}
			else
			{
				var_08 = (var_08[0],var_06[1].origin[1],var_08[2]);
			}

			if(var_02.origin[0] < var_08[0] || var_02.origin[0] > var_09[0] || var_02.origin[1] < var_08[1] || var_02.origin[1] > var_09[1])
			{
				continue;
			}
		}

		if(var_02.var_117E9 < var_04)
		{
			continue;
		}

		if(!bullettracepassed(var_02.origin + (0,0,32),self.origin,0,self))
		{
			wait(0.05);
			continue;
		}

		var_04 = var_02.var_117E9;
		var_05 = var_02;
	}

	return var_05;
}

//Function Number: 19
func_12E10(param_00)
{
	param_00.var_117E9 = 0;
	var_01 = distance(param_00.origin,self.origin);
	param_00.var_117E9 = param_00.var_117E9 + level.var_8DA2 - var_01 / level.var_8DA2 * 100;
	if(isdefined(self.var_4F) && param_00 == self.var_4F)
	{
		param_00.var_117E9 = param_00.var_117E9 + 100;
	}

	if(isplayer(param_00))
	{
		param_00.var_117E9 = param_00.var_117E9 + param_00.var_278 * 4;
	}

	if(isdefined(param_00.var_202C))
	{
		param_00.var_117E9 = param_00.var_117E9 - param_00.var_202C;
	}

	if(param_00.var_117E9 <= 0)
	{
		param_00.var_117E9 = 1;
	}
}

//Function Number: 20
func_8D82()
{
	self method_807F();
	self method_8075();
	self method_83E5(80,35);
	self method_8378(75,45,45);
	self method_830A(30,30);
	self method_8316(256);
	self method_8354(0.9);
}

//Function Number: 21
func_181D(param_00)
{
	self endon("death");
	self.var_DDBF = self.var_DDBF + param_00;
	wait(4);
	self.var_DDBF = self.var_DDBF - param_00;
}

//Function Number: 22
func_B938(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_00))
	{
		if((isdefined(self.var_222) && param_00 == self.var_222 && self.var_110EA == "heli_sniper") || isdefined(param_00.var_4004) && param_00.var_4004 == "worldspawn" || param_00 == self)
		{
			return -1;
		}
	}

	var_05 = param_03;
	var_06 = 2;
	var_07 = 3;
	var_08 = 4;
	if(isdefined(self.var_8DD9) && self.var_8DD9 == "dronedrop")
	{
		var_06 = 1;
		var_07 = 1;
		var_08 = 2;
	}

	var_05 = scripts\mp\killstreaks\_utility::func_7FBD(param_00,param_01,param_02,var_05,self.maxhealth,var_06,var_07,var_08);
	thread func_181D(var_05);
	self notify("heli_damage_fx");
	if(lib_0DF8::func_9DDF(param_00))
	{
		var_05 = 0;
	}

	return var_05;
}

//Function Number: 23
func_898F(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00))
	{
		var_04 = level.var_8DA6[self.var_110EA];
		var_05 = "";
		if(isdefined(self.var_110E8))
		{
			var_05 = scripts\mp\_killstreak_loot::getrarityforlootitem(self.var_110E8.var_1318B);
		}

		var_06 = var_04.var_3774;
		if(var_05 != "")
		{
			var_06 = var_06 + "_" + var_05;
		}

		var_07 = scripts\mp\_damage::func_C548(self.var_110EA,param_00,param_01,param_02,param_03,var_04.var_EC44,var_04.var_52DA,var_06);
		if(var_07)
		{
			param_00 notify("destroyed_helicopter");
			self.var_A667 = param_00;
		}

		if(param_01 == "heli_pilot_turret_mp")
		{
			param_00 scripts\mp\_missions::func_D992("ch_enemy_down");
		}

		scripts\mp\_missions::func_3DE3(param_00,self,param_01);
	}
}

//Function Number: 24
func_8D40(param_00,param_01,param_02)
{
	self endon("crashing");
	self endon("leaving");
	self.var_110EA = param_00;
	self.var_DDBF = 0;
	if(!scripts\mp\_utility::func_9FB3(param_02))
	{
		thread func_8D61();
	}

	scripts\mp\_damage::func_B9C6(self.maxhealth,"helicopter",::func_898F,::func_B938,1,param_01);
}

//Function Number: 25
func_8DA5()
{
	self endon("death");
	self endon("leaving");
	self endon("crashing");
	self.var_222 endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		self.var_61A3 = 1;
		if(isdefined(self.var_B6C0))
		{
			self.var_B6C0 notify("stop_shooting");
		}

		if(isdefined(self.var_B6C1))
		{
			self.var_B6C1 notify("stop_shooting");
		}

		wait(var_01);
		self.var_61A3 = 0;
		if(isdefined(self.var_B6C0))
		{
			self.var_B6C0 notify("turretstatechange");
		}

		if(isdefined(self.var_B6C1))
		{
			self.var_B6C1 notify("turretstatechange");
		}
	}
}

//Function Number: 26
func_8D61()
{
	self endon("leaving");
	self endon("crashing");
	self.var_4C07 = "ok";
	self.var_AA1B = "ok";
	self method_82CE(3);
	var_00 = 3;
	self method_82CE(var_00);
	var_01 = level.var_8DA6[self.var_110EA];
	for(;;)
	{
		self waittill("heli_damage_fx");
		if(var_00 > 0 && self.var_E1 >= self.maxhealth)
		{
			var_00 = 0;
			self method_82CE(var_00);
			stopfxontag(level.var_3F19["damage"]["heavy_smoke"],self,var_01.var_65D0);
			self notify("death");
			break;
		}
		else
		{
			if(var_00 > 1 && self.var_E1 >= self.maxhealth * 0.66)
			{
				var_00 = 1;
				self method_82CE(var_00);
				self.var_4C07 = "heavy smoke";
				stopfxontag(level.var_3F19["damage"]["light_smoke"],self,var_01.var_65D0);
				playfxontag(level.var_3F19["damage"]["heavy_smoke"],self,var_01.var_65D0);
				continue;
			}

			if(var_00 > 2 && self.var_E1 >= self.maxhealth * 0.33)
			{
				var_00 = 2;
				self method_82CE(var_00);
				self.var_4C07 = "light smoke";
				playfxontag(level.var_3F19["damage"]["light_smoke"],self,var_01.var_65D0);
			}
		}
	}
}

//Function Number: 27
func_8DA4()
{
	level endon("game_ended");
	self endon("gone");
	self waittill("death");
	if(isdefined(self.var_A859) && self.var_A859)
	{
		thread func_8D4C(1);
		return;
	}

	var_00 = level.var_8DA6[self.var_110EA];
	playfxontag(level.var_3F19["damage"]["on_fire"],self,var_00.var_65D0);
	thread func_8D33();
}

//Function Number: 28
func_8D33()
{
	self notify("crashing");
	self method_8076();
	var_00 = level.var_8D3E[randomint(level.var_8D3E.size)];
	if(isdefined(self.var_B6C0))
	{
		self.var_B6C0 notify("stop_shooting");
	}

	if(isdefined(self.var_B6C1))
	{
		self.var_B6C1 notify("stop_shooting");
	}

	thread func_8D8B(180);
	thread func_8D83();
	func_8D53(var_00);
	thread func_8D4C();
}

//Function Number: 29
func_8D83()
{
	var_00 = func_8D5C();
	var_01 = level.var_8DA6[self.var_110EA];
	playfxontag(level.var_3F19["explode"]["large"],self,var_01.var_65D0);
	self playsound(level.var_8D8A[var_00]["hitsecondary"]);
	wait(3);
	if(!isdefined(self))
	{
		return;
	}

	playfxontag(level.var_3F19["explode"]["large"],self,var_01.var_65D0);
	self playsound(level.var_8D8A[var_00]["hitsecondary"]);
}

//Function Number: 30
func_8D8B(param_00)
{
	self endon("death");
	var_01 = func_8D5C();
	self playsound(level.var_8D8A[var_01]["hit"]);
	thread func_10A11();
	self method_8378(param_00,param_00,param_00);
	while(isdefined(self))
	{
		self method_8348(self.angles[1] + param_00 * 0.9);
		wait(1);
	}
}

//Function Number: 31
func_10A11()
{
	self endon("death");
	wait(0.25);
	var_00 = func_8D5C();
	self stoploopsound();
	wait(0.05);
	self playloopsound(level.var_8D8A[var_00]["spinloop"]);
	wait(0.05);
	self playloopsound(level.var_8D8A[var_00]["spinstart"]);
}

//Function Number: 32
func_8D4C(param_00)
{
	self notify("death");
	if(isdefined(param_00) && isdefined(level.var_3F19["explode"]["air_death"][self.var_8DA0]))
	{
		var_01 = self gettagangles("tag_deathfx");
		playfx(level.var_3F19["explode"]["air_death"][self.var_8DA0],self gettagorigin("tag_deathfx"),anglestoforward(var_01),anglestoup(var_01));
	}
	else
	{
		var_02 = self.origin;
		var_03 = self.origin + (0,0,1) - self.origin;
		playfx(level.var_3F19["explode"]["death"][self.var_8DA0],var_02,var_03);
	}

	var_04 = func_8D5C();
	self playsound(level.var_8D8A[var_04]["crash"]);
	wait(0.05);
	if(isdefined(self.var_A63A))
	{
		self.var_A63A delete();
	}

	scripts\mp\_utility::func_4FC1();
	self delete();
}

//Function Number: 33
func_3DBF()
{
	if(!isdefined(self.var_222) || !isdefined(self.var_222.pers["team"]) || self.var_222.pers["team"] != self.team)
	{
		thread func_8D66();
		return 0;
	}

	return 1;
}

//Function Number: 34
func_8D69(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	param_00 waittill("disconnect");
	thread func_8D66();
}

//Function Number: 35
func_8D68(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	if(scripts\mp\_utility::func_2DD9())
	{
		return;
	}

	param_00 scripts\common\utility::waittill_any_3("joined_team","joined_spectators");
	thread func_8D66();
}

//Function Number: 36
func_8D6C(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	param_00 waittill("spawned");
	thread func_8D66();
}

//Function Number: 37
func_8D6A(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	level waittill("game_ended");
	thread func_8D66();
}

//Function Number: 38
func_8D6D(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	scripts\mp\_hostmigration::func_13708(param_00);
	thread func_8D66();
}

//Function Number: 39
func_6D7A(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	var_01 = 15;
	var_02 = 0;
	var_03 = 0;
	foreach(var_05 in level.var_8D6F)
	{
		var_02++;
		var_03 = var_03 + var_05.origin[2];
	}

	var_07 = var_03 / var_02;
	self notify("newTarget");
	if(isdefined(self.var_F0C3) && self.var_F0C3.var_E1 < self.var_F0C3.maxhealth)
	{
		return;
	}

	if(isdefined(self.var_9EDC) && self.var_9EDC)
	{
		return;
	}

	var_08 = self.var_D8DF;
	var_08.var_202C = 0;
	var_09 = self.var_D8DF.origin * (1,1,0);
	var_0A = self.origin * (0,0,1);
	var_0B = var_09 + var_0A;
	var_0C = distance2d(self.origin,var_08.origin);
	if(var_0C < 1000)
	{
		var_01 = 600;
	}

	var_0D = anglestoforward(var_08.angles);
	var_0D = var_0D * (1,1,0);
	var_0E = var_0B + var_01 * var_0D;
	var_0F = var_0E - var_0B;
	var_10 = vectortoangles(var_0F);
	var_10 = var_10 * (1,1,0);
	thread func_2513(var_08);
	self method_83E5(80);
	if(distance2d(self.origin,var_0E) < 1000)
	{
		var_0E = var_0E * 1.5;
	}

	var_0E = var_0E * (1,1,0);
	var_0E = var_0E + (0,0,var_07);
	func_13E0(var_0E,1,1);
	self waittill("near_goal");
	if(!isdefined(var_08) || !isalive(var_08))
	{
		return;
	}

	self method_8305(var_08);
	thread func_9DEC(10,var_08);
	scripts\common\utility::waittill_any_timeout_1(4,"facing");
	if(!isdefined(var_08) || !isalive(var_08))
	{
		return;
	}

	self method_8076();
	var_11 = var_0B + var_01 * anglestoforward(var_10);
	self method_830A(40,30);
	func_13E0(var_11,1,1);
	self method_830A(30,30);
	if(isdefined(var_08) && isalive(var_08))
	{
		if(isdefined(var_08.var_202C))
		{
			var_08.var_202C = var_08.var_202C + 100;
		}
		else
		{
			var_08.var_202C = 100;
		}
	}

	scripts\common\utility::waittill_any_timeout_1(3,"near_goal");
}

//Function Number: 40
func_2513(param_00)
{
	self notify("attackGroundTarget");
	self endon("attackGroundTarget");
	self stoploopsound();
	self.var_9D5A = 1;
	self method_835C(param_00);
	func_1370A(param_00,3);
	if(!isalive(param_00))
	{
		self.var_9D5A = 0;
		return;
	}

	var_01 = distance2dsquared(self.origin,param_00.origin);
	if(var_01 < 640000)
	{
		thread func_5D24(param_00);
		self.var_9D5A = 0;
		return;
	}

	if(func_3E21(50,param_00) && scripts\common\utility::func_4347())
	{
		thread func_6D75(param_00);
		self.var_9D5A = 0;
		return;
	}

	var_02 = function_0240("cobra_20mm_mp");
	var_03 = 0;
	var_04 = 0;
	for(var_05 = 0;var_05 < level.var_8D9E;var_05++)
	{
		if(!isdefined(self))
		{
			break;
		}

		if(self.var_61A3)
		{
			break;
		}

		if(!isdefined(param_00))
		{
			break;
		}

		if(!isalive(param_00))
		{
			break;
		}

		if(self.var_E1 >= self.maxhealth)
		{
			continue;
		}

		if(!func_3E21(55,param_00))
		{
			self stoploopsound();
			var_04 = 0;
			wait(var_02);
			var_05--;
			continue;
		}

		if(var_05 < level.var_8D9E - 1)
		{
			wait(var_02);
		}

		if(!isdefined(param_00) || !isalive(param_00))
		{
			break;
		}

		if(!var_04)
		{
			self playloopsound("weap_hind_20mm_fire_npc");
			var_04 = 1;
		}

		self method_8365("cobra_20mm_mp");
		self method_80EB("tag_flash",param_00);
	}

	if(!isdefined(self))
	{
		return;
	}

	self stoploopsound();
	var_04 = 0;
	self.var_9D5A = 0;
}

//Function Number: 41
func_3E21(param_00,param_01)
{
	self endon("death");
	self endon("leaving");
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}

	var_02 = anglestoforward(self.angles);
	var_03 = param_01.origin - self.origin;
	var_02 = var_02 * (1,1,0);
	var_03 = var_03 * (1,1,0);
	var_03 = vectornormalize(var_03);
	var_02 = vectornormalize(var_02);
	var_04 = vectordot(var_03,var_02);
	var_05 = cos(param_00);
	if(var_04 >= var_05)
	{
		return 1;
	}

	return 0;
}

//Function Number: 42
func_9DEC(param_00,param_01)
{
	self endon("death");
	self endon("leaving");
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}

	while(isalive(param_01))
	{
		var_02 = anglestoforward(self.angles);
		var_03 = param_01.origin - self.origin;
		var_02 = var_02 * (1,1,0);
		var_03 = var_03 * (1,1,0);
		var_03 = vectornormalize(var_03);
		var_02 = vectornormalize(var_02);
		var_04 = vectordot(var_03,var_02);
		var_05 = cos(param_00);
		if(var_04 >= var_05)
		{
			self notify("facing");
			break;
		}

		wait(0.1);
	}
}

//Function Number: 43
func_1370A(param_00,param_01)
{
	self endon("death");
	self endon("helicopter_done");
	param_00 endon("death");
	param_00 endon("disconnect");
	scripts\common\utility::waittill_notify_or_timeout("turret_on_target",param_01);
}

//Function Number: 44
func_6D75(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	if(level.var_DADB)
	{
		var_01 = 1;
	}
	else
	{
		var_01 = 2;
	}

	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		if(!isdefined(param_00))
		{
			return;
		}

		if(scripts\common\utility::func_4347())
		{
			var_03 = scripts\mp\_utility::func_1309("hind_missile_mp",self gettagorigin("tag_missile_right") - (0,0,64),param_00.origin,self.var_222);
			var_03.var_131D8 = self;
		}
		else
		{
			var_03 = scripts\mp\_utility::func_1309("hind_missile_mp",self gettagorigin("tag_missile_left") - (0,0,64),param_00.origin,self.var_222);
			var_03.var_131D8 = self;
		}

		var_03 missile_settargetent(param_00);
		var_03.var_222 = self;
		var_03 missile_setflightmodedirect();
		wait(0.5 / var_01);
	}
}

//Function Number: 45
func_5D24(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	if(!isdefined(param_00))
	{
		return;
	}

	for(var_01 = 0;var_01 < randomintrange(2,5);var_01++)
	{
		if(scripts\common\utility::func_4347())
		{
			var_02 = scripts\mp\_utility::func_1309("hind_bomb_mp",self gettagorigin("tag_missile_left") - (0,0,45),param_00.origin,self.var_222);
			var_02.var_131D8 = self;
		}
		else
		{
			var_02 = scripts\mp\_utility::func_1309("hind_bomb_mp",self gettagorigin("tag_missile_right") - (0,0,45),param_00.origin,self.var_222);
			var_02.var_131D8 = self;
		}

		wait(randomfloatrange(0.35,0.65));
	}
}

//Function Number: 46
func_8025(param_00)
{
	var_01 = self.origin;
	var_02 = param_00.origin;
	var_03 = 0;
	var_04 = 40;
	var_05 = (0,0,-196);
	for(var_06 = bullettrace(var_01 + var_05,var_02 + var_05,0,self);distancesquared(var_06["position"],var_02 + var_05) > 10 && var_03 < var_04;var_06 = bullettrace(var_01 + var_05,var_02 + var_05,0,self))
	{
		if(var_01[2] < var_02[2])
		{
			var_01 = var_01 + (0,0,128);
		}
		else if(var_01[2] > var_02[2])
		{
			var_02 = var_02 + (0,0,128);
		}
		else
		{
			var_01 = var_01 + (0,0,128);
			var_02 = var_02 + (0,0,128);
		}

		var_03++;
	}

	var_07 = [];
	var_07["start"] = var_01;
	var_07["end"] = var_02;
	return var_07;
}

//Function Number: 47
func_126C2(param_00)
{
	var_01 = func_8025(param_00);
	if(var_01["start"] != self.origin)
	{
		self method_83E5(75,35);
		func_13E0(var_01["start"] + (0,0,30),0);
		self method_82F2(param_00.angles[1] + level.var_8D2B);
		self waittill("goal");
	}

	if(var_01["end"] != param_00.origin)
	{
		if(isdefined(param_00.var_ECEA) && isdefined(param_00.var_ECE2))
		{
			var_02 = param_00.var_ECEA;
			var_03 = param_00.var_ECE2;
		}
		else
		{
			var_02 = 30 + randomint(20);
			var_03 = 15 + randomint(15);
		}

		self method_83E5(75,35);
		func_13E0(var_01["end"] + (0,0,30),0);
		self method_82F2(param_00.angles[1] + level.var_8D2B);
		self waittill("goal");
	}
}

//Function Number: 48
func_13E0(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	param_02 = 0;
	if(param_02)
	{
		thread func_13E2(param_00,param_01);
		return;
	}

	self method_8362(param_00,param_01);
}

//Function Number: 49
func_13E2(param_00,param_01)
{
	self endon("death");
	self endon("leaving");
	self endon("crashing");
	var_02 = param_00;
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		if(scripts\common\utility::func_56F4(self.origin,var_02) < 65536)
		{
			self method_8362(var_02,param_01);
			break;
		}

		var_03 = vectortoangles(var_02 - self.origin);
		var_04 = anglestoforward(var_03);
		var_05 = self.origin + var_04 * (1,1,0) * 250;
		var_06 = (0,0,2500);
		var_07 = var_05 + scripts\mp\_utility::func_7EF9() + var_06;
		var_08 = var_05 + scripts\mp\_utility::func_7EF9() - var_06;
		var_09 = bullettrace(var_07,var_08,0,self,0,0,1);
		var_0A = var_09;
		if(isdefined(var_09["entity"]) && var_09["entity"] == self && var_09["normal"][2] > 0.1)
		{
			var_0B = var_09["position"][2] - 4400;
			var_0C = var_0B - self.origin[2];
			if(var_0C > 256)
			{
				var_09["position"] = var_09["position"] * (1,1,0);
				var_09["position"] = var_09["position"] + (0,0,self.origin[2] + 256);
			}
			else if(var_0C < -256)
			{
				var_09["position"] = var_09["position"] * (1,1,0);
				var_09["position"] = var_09["position"] + (0,0,self.origin[2] - 256);
			}

			var_0A = var_09["position"] - scripts\mp\_utility::func_7EF9() + (0,0,600);
		}
		else
		{
			var_0A = var_02;
		}

		self method_8362(var_0A,0);
		wait(0.15);
	}
}

//Function Number: 50
func_8D53(param_00)
{
	self endon("death");
	self endon("leaving");
	self notify("flying");
	self endon("flying");
	func_8D82();
	for(var_01 = param_00;isdefined(var_01.target);var_01 = var_02)
	{
		var_02 = getent(var_01.target,"targetname");
		if(isdefined(var_01.var_ECEA) && isdefined(var_01.var_ECE2))
		{
			var_03 = var_01.var_ECEA;
			var_04 = var_01.var_ECE2;
		}
		else
		{
			var_03 = 30 + randomint(20);
			var_04 = 15 + randomint(15);
		}

		if(isdefined(self.var_9D5A) && self.var_9D5A)
		{
			wait(0.05);
			continue;
		}

		if(isdefined(self.var_9EDC) && self.var_9EDC)
		{
			wait(0.05);
			continue;
		}

		self method_83E5(75,35);
		if(!isdefined(var_02.target))
		{
			func_13E0(var_02.origin + self.var_13F0A,1);
			self waittill("near_goal");
			continue;
		}

		func_13E0(var_02.origin + self.var_13F0A,0);
		self waittill("near_goal");
		self method_82F2(var_02.angles[1]);
		self waittillmatch("goal");
	}
}

//Function Number: 51
func_8D52(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self notify("flying");
	self endon("flying");
	func_8D82();
	thread func_8D71(param_00);
	for(var_01 = param_00;isdefined(var_01.target);var_01 = var_02)
	{
		var_02 = getent(var_01.target,"targetname");
		if(isdefined(self.var_9EDC) && self.var_9EDC)
		{
			wait(0.25);
			continue;
		}

		if(isdefined(self.var_9D5A) && self.var_9D5A)
		{
			wait(0.1);
			continue;
		}

		if(isdefined(var_01.var_ECEA) && isdefined(var_01.var_ECE2))
		{
			self.var_5275 = var_01.var_ECEA;
			self.var_526F = var_01.var_ECE2;
		}
		else
		{
			self.var_5275 = 30 + randomint(20);
			self.var_526F = 15 + randomint(15);
		}

		if(self.var_8DD9 == "flares")
		{
			self.var_5275 = self.var_5275 * 0.5;
			self.var_526F = self.var_526F * 0.5;
		}

		if(isdefined(var_02.script_delay) && isdefined(self.var_D8DF) && !func_8D64())
		{
			func_13E0(var_02.origin + self.var_13F0A,1,1);
			self waittill("near_goal");
			wait(var_02.script_delay);
			continue;
		}

		func_13E0(var_02.origin + self.var_13F0A,0,1);
		self waittill("near_goal");
		self method_82F2(var_02.angles[1]);
		self waittillmatch("goal");
	}
}

//Function Number: 52
func_8D71(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	if(isdefined(param_00.var_ECEA) && isdefined(param_00.var_ECE2))
	{
		self.var_5275 = param_00.var_ECEA;
		self.var_526F = param_00.var_ECE2;
	}
	else
	{
		self.var_5275 = 30 + randomint(20);
		self.var_526F = 15 + randomint(15);
	}

	var_01 = 0;
	var_02 = 0;
	for(;;)
	{
		var_03 = self.var_5275;
		var_04 = self.var_526F;
		if(isdefined(self.var_9D5A) && self.var_9D5A)
		{
			wait(0.05);
			continue;
		}

		if(self.var_8DD9 != "flares" && isdefined(self.var_D8DF) && !func_8D64())
		{
			var_03 = var_03 * 0.25;
		}

		if(var_01 != var_03 || var_02 != var_04)
		{
			self method_83E5(75,35);
			var_01 = var_03;
			var_02 = var_04;
		}

		wait(0.05);
	}
}

//Function Number: 53
func_8D64()
{
	if(self.var_DDBF > 50)
	{
		return 1;
	}

	if(self.var_4C07 == "heavy smoke")
	{
		return 1;
	}

	return 0;
}

//Function Number: 54
func_8D55(param_00)
{
	self notify("flying");
	self endon("flying");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		if(isdefined(self.var_9D5A) && self.var_9D5A)
		{
			wait(0.05);
			continue;
		}

		var_01 = func_785E(param_00);
		func_126C2(var_01);
		if(isdefined(var_01.var_ECEA) && isdefined(var_01.var_ECE2))
		{
			var_02 = var_01.var_ECEA;
			var_03 = var_01.var_ECE2;
		}
		else
		{
			var_02 = 30 + randomint(20);
			var_03 = 15 + randomint(15);
		}

		self method_83E5(75,35);
		func_13E0(var_01.origin + self.var_13F0A,1);
		self method_82F2(var_01.angles[1] + level.var_8D2B);
		if(level.var_8D56 != 0)
		{
			self waittill("near_goal");
			wait(level.var_8D56);
			continue;
		}

		if(!isdefined(var_01.script_delay))
		{
			self waittill("near_goal");
			wait(5 + randomint(5));
			continue;
		}

		self waittillmatch("goal");
		wait(var_01.script_delay);
	}
}

//Function Number: 55
func_785E(param_00)
{
	return func_12E60(param_00);
}

//Function Number: 56
func_8D66(param_00)
{
	self notify("leaving");
	self method_8076();
	if(isdefined(self.var_8DD9) && self.var_8DD9 == "osprey" && isdefined(self.var_C96C))
	{
		func_13E0(self.var_C96C,1);
		scripts\common\utility::waittill_any_timeout_1(5,"goal");
	}

	if(!isdefined(param_00))
	{
		var_01 = level.var_8D67[randomint(level.var_8D67.size)];
		param_00 = var_01.origin;
	}

	var_02 = spawn("script_origin",param_00);
	if(isdefined(var_02))
	{
		self method_8305(var_02);
		var_02 thread func_13589(3);
	}

	var_03 = param_00 - self.origin * 2000;
	func_8D82();
	self method_83E5(180,45);
	func_13E0(var_03,1);
	scripts\common\utility::waittill_any_timeout_1(12,"goal");
	self notify("gone");
	self notify("death");
	wait(0.05);
	if(isdefined(self.var_A63A))
	{
		self.var_A63A delete();
	}

	scripts\mp\_utility::func_4FC1();
	self delete();
}

//Function Number: 57
func_13589(param_00)
{
	self endon("death");
	level endon("game_ended");
	wait(param_00);
	self delete();
}

//Function Number: 58
func_4F09(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(level.var_8D43) && level.var_8D43 == 1)
	{
		thread func_5B64(param_00,param_01,param_02,param_03,param_04);
	}
}

//Function Number: 59
func_4F0A(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.var_8D43) && level.var_8D43 == 1)
	{
		if(isdefined(param_03))
		{
			thread func_5B64(param_00,(0.8,0.8,0.8),param_01,param_02,param_03);
			return;
		}

		thread func_5B64(param_00,(0.8,0.8,0.8),param_01,param_02,0);
	}
}

//Function Number: 60
func_4EEE(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.var_8D43) && level.var_8D43 == 1 && !isdefined(param_03))
	{
		thread func_5B4A(param_00,param_01,param_02);
		return;
	}

	if(isdefined(level.var_8D43) && level.var_8D43 == 1)
	{
		thread func_5B4A(param_00,param_01,param_02,param_03);
	}
}

//Function Number: 61
func_5B64(param_00,param_01,param_02,param_03,param_04)
{
	if(param_04 == 0)
	{
		while(isdefined(param_02))
		{
			wait(0.05);
		}

		return;
	}

	for(var_05 = 0;var_05 < param_04;var_05++)
	{
		if(!isdefined(param_02))
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 62
func_5B4A(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		for(var_04 = 0;var_04 < param_03;var_04++)
		{
			wait(0.05);
		}

		return;
	}

	wait(0.05);
}

//Function Number: 63
func_184E()
{
	level.var_8DD3[self getentitynumber()] = self;
}

//Function Number: 64
func_E109(param_00)
{
	level.var_8DD3[param_00] = undefined;
}

//Function Number: 65
func_1852(param_00)
{
	if(isdefined(param_00) && param_00 == "lbSniper")
	{
		level.var_AAC8 = self;
	}

	level.var_AD8B[self getentitynumber()] = self;
}

//Function Number: 66
func_E111(param_00)
{
	var_01 = self getentitynumber();
	self waittill("death");
	if(isdefined(param_00) && param_00 == "lbSniper")
	{
		level.var_AAC8 = undefined;
	}

	level.var_AD8B[var_01] = undefined;
}

//Function Number: 67
func_68C3(param_00)
{
	if(level.var_AD8B.size >= 4 || level.var_AD8B.size >= 2 && param_00 == "littlebird_flock")
	{
		return 1;
	}

	return 0;
}

//Function Number: 68
func_C9D8()
{
	self endon("death");
	self endon("disconnect");
	self playlocalsound(game["voice"][self.team] + "KS_hqr_pavelow");
	wait(3.5);
	self playlocalsound(game["voice"][self.team] + "KS_pvl_inbound");
}

//Function Number: 69
func_AAC7()
{
	self endon("gone");
	if(!isdefined(self))
	{
		return;
	}

	self notify("crashing");
	if(isdefined(self.var_A859) && self.var_A859)
	{
		scripts\common\utility::func_136F7();
	}
	else
	{
		self method_83E5(25,5);
		thread func_AAC9(randomintrange(180,220));
		wait(randomfloatrange(1,2));
	}

	func_AAC6();
}

//Function Number: 70
func_AAC9(param_00)
{
	self endon("explode");
	playfxontag(level.var_3F19["explode"]["medium"],self,"tail_rotor_jnt");
	thread func_11B0F(level.var_3F19["smoke"]["trail"],"tail_rotor_jnt","stop tail smoke");
	self method_8378(param_00,param_00,param_00);
	while(isdefined(self))
	{
		self method_8348(self.angles[1] + param_00 * 0.9);
		wait(1);
	}
}

//Function Number: 71
func_AAC6()
{
	var_00 = self.origin + (0,0,1) - self.origin;
	var_01 = self gettagangles("tag_deathfx");
	playfx(level.var_3F19["explode"]["air_death"]["littlebird"],self gettagorigin("tag_deathfx"),anglestoforward(var_01),anglestoup(var_01));
	self playsound("exp_helicopter_fuel");
	self notify("explode");
	func_E139();
}

//Function Number: 72
func_11B0F(param_00,param_01,param_02)
{
	self notify(param_02);
	self endon(param_02);
	self endon("death");
	for(;;)
	{
		playfxontag(param_00,self,param_01);
		wait(0.05);
	}
}

//Function Number: 73
func_E139()
{
	if(isdefined(self.var_B6C0))
	{
		if(isdefined(self.var_B6C0.var_A63A))
		{
			self.var_B6C0.var_A63A delete();
		}

		self.var_B6C0 delete();
	}

	if(isdefined(self.var_B6C1))
	{
		if(isdefined(self.var_B6C1.var_A63A))
		{
			self.var_B6C1.var_A63A delete();
		}

		self.var_B6C1 delete();
	}

	if(isdefined(self.var_B377))
	{
		self.var_B377 delete();
	}

	if(isdefined(level.var_8D79[self.team]) && level.var_8D79[self.team] == self)
	{
		level.var_8D79[self.team] = undefined;
	}

	scripts\mp\_utility::func_4FC1();
	self delete();
}