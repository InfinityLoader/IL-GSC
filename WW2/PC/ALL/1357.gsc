/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1357.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 89
 * Decompile Time: 130 ms
 * Timestamp: 10/27/2023 3:25:45 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	while(!isdefined(level.var_947C))
	{
		waittillframeend;
	}

	while(!isdefined(level.var_A41))
	{
		waittillframeend;
	}

	level.var_4752 = 128;
	level.var_4751 = ["weapon_grenade","weapon_projectile","killstreak"];
	level.var_A41["zombie"] = level.var_A41["player"];
	level.var_A41["zombie"]["onAIConnect"] = ::lib_0547::func_6AB7;
	level.var_A41["zombie"]["on_killed"] = ::func_6BD4;
	level.var_A41["zombie"]["on_damaged"] = ::func_6BD1;
	level.var_A41["zombie"]["on_damaged_finished"] = ::func_6BD3;
	level.var_A41["zombie"]["is_hit_weak_point"] = ::func_5714;
	level.var_A41["zombie"]["spawn"] = ::func_6BD7;
	level.var_A41["zombie"]["think"] = ::lib_0547::func_A58;
	level.var_A41["zombie"]["on_mutilate"] = ::func_AC35;
	level.var_A41["zombie"]["get_action_params"] = ::func_AC22;
	level.var_A41["zombie"]["move_mode"] = ::func_AC6E;
	level.var_A41["zombie"]["post_model"] = ::func_AC1E;
	level.var_A41["zombie"]["tesla_delayed_dmg"] = ::zombietesladelayeddmg;
	createthreatbiasgroup("zombies");
	level.var_87D = ["s2","t7","s1"];
	maps/mp/agents/_scripted_agent_anim_util::func_5159("zombie_generic");
	maps/mp/agents/_scripted_agent_anim_util::func_5159("zombie_boss");
	level.var_2775 = 0;
	level.var_2FDD = [];
	level.var_66BF = 0;
	lib_0566::func_D5();
	lib_0564::func_D5();
	lib_055C::func_D5();
	lib_0563::func_D5();
	lib_0567::func_D5();
	lib_056B::func_D5();
	if(isdefined(level.initnewzombietypes))
	{
		[[ level.initnewzombietypes ]]();
	}

	if(isdefined(level.var_AC1B))
	{
		[[ level.var_AC1B ]]();
	}

	if(isdefined(level.var_AC27))
	{
		[[ level.var_AC27 ]]();
	}

	if(isdefined(level.var_AC2F))
	{
		[[ level.var_AC2F ]]();
	}

	if(!isdefined(level.var_AC4F))
	{
		level.var_AC4F = [];
	}

	level.var_6F43 = 0;
	level thread func_6013();
	level thread func_63C7();
	level thread func_63C1();
	level thread func_5DE7();
	level thread lib_055A::func_6B3F();
	level thread func_63A6();
	level thread handlebadmeleevolumes();
	animscripts/notetracks_common::func_7BF0();
	level thread maps/mp/zombies/_zombies_event_mtx7::func_D5();
}

//Function Number: 2
register_grenadier_immune_zombie_equipment(param_00)
{
	if(!isdefined(level.zmb_grenadier_immune_weapons))
	{
		level.zmb_grenadier_immune_weapons = [];
	}

	level.zmb_grenadier_immune_weapons = common_scripts\utility::func_F6F(level.zmb_grenadier_immune_weapons,param_00);
}

//Function Number: 3
register_persistent_tactical_zombie_equipment(param_00)
{
	if(!isdefined(level.persistent_ammo_tacticals))
	{
		level.persistent_ammo_tacticals = [];
	}

	level.persistent_ammo_tacticals = common_scripts\utility::func_F6F(level.persistent_ammo_tacticals,param_00);
}

//Function Number: 4
func_6013()
{
	var_00 = getallnodes();
	var_01 = 0;
	while(var_00.size > 0)
	{
		var_02 = var_00[var_00.size - 1];
		if(isdefined(level.var_AC80))
		{
			var_03 = lib_055A::func_4562(var_02.var_116);
			if(isdefined(var_03))
			{
				var_02.var_AC66 = var_03;
			}
		}

		var_00[var_00.size - 1] = undefined;
		var_01++;
		if(var_01 % 20 == 0)
		{
			wait 0.05;
		}
	}

	level.var_2456 = 1;
}

//Function Number: 5
func_63C7()
{
	level endon("game_ended");
	if(!isdefined(level.var_AC80))
	{
		return;
	}

	var_00 = 0.05;
	for(;;)
	{
		var_01 = 0;
		foreach(var_03 in level.var_744A)
		{
			if(!isalive(var_03))
			{
				continue;
			}

			if(var_03.var_178 != "spectator" && var_03.var_178 != "intermission")
			{
				var_04 = var_03 lib_055A::func_462D();
				if(isdefined(var_04) && !lib_0547::func_5565(var_03.var_295A,var_04))
				{
					var_03 notify("zone_entered",var_04);
				}

				var_03.var_295A = var_04;
				wait(var_00);
				var_01 = var_01 + var_00;
			}
		}

		if(var_01 == 0)
		{
			wait(var_00);
		}
	}
}

//Function Number: 6
func_63C1()
{
	level endon("game_ended");
	if(!isdefined(level.var_AC80))
	{
		return;
	}

	var_00 = 0.5;
	var_01 = getentarray("zombie_ledge_exploit","targetname");
	var_02 = [];
	foreach(var_08, var_04 in level.var_AC80.var_ACB3)
	{
		var_02[var_08] = [];
		foreach(var_06 in var_01)
		{
			if(var_06.var_165 == var_08)
			{
				var_02[var_08][var_02[var_08].size] = var_06;
			}
		}
	}

	for(;;)
	{
		var_09 = 0;
		foreach(var_0B in level.var_744A)
		{
			if(!isalive(var_0B))
			{
				continue;
			}

			var_0B.var_571F = 0;
			var_0B.var_A27F = 0;
			if(var_0B.var_178 != "spectator" && var_0B.var_178 != "intermission")
			{
				if(isdefined(var_0B.var_295A) && length(var_0B getvelocity()) < 5)
				{
					var_0B.var_A27F = 1;
					foreach(var_06 in var_02[var_0B.var_295A])
					{
						if(var_0B istouching(var_06))
						{
							var_0B.var_571F = 1;
							break;
						}
					}
				}
			}

			if(isdefined(level.var_AB3B))
			{
				var_0B [[ level.var_AB3B ]](var_0B.var_571F,var_0B.var_A27F);
			}

			wait(var_00);
			var_09 = var_09 + var_00;
		}

		if(var_09 == 0)
		{
			wait(var_00);
		}
	}
}

//Function Number: 7
func_5DE7()
{
	level endon("game_ended");
	self.var_AC67 = 0;
	self.var_AC37 = 2;
	for(;;)
	{
		wait 0.05;
		self.var_AC67 = 0;
	}
}

//Function Number: 8
func_7B4B()
{
	var_00 = undefined;
	var_01 = 0;
	foreach(var_03 in maps/mp/agents/_agent_utility::func_43FD("all"))
	{
		if(!var_03.var_C29)
		{
			continue;
		}

		var_04 = 0;
		foreach(var_06 in level.var_744A)
		{
			var_07 = var_06.var_116 - var_03.var_116;
			var_08 = anglestoforward(var_06 geteyeangles());
			var_09 = 1 - vectordot(var_08,vectornormalize(var_07)) / 2;
			var_0A = common_scripts\utility::func_5D93(length(var_07),100,10000,0,1);
			if(var_03 common_scripts\utility::func_3794("zombie_passive"))
			{
				var_0B = 1;
			}
			else
			{
				var_0B = 0;
			}

			var_04 = var_04 + var_09 + var_0A + var_0B;
		}

		if(var_04 > var_01)
		{
			var_00 = var_03;
			var_01 = var_04;
		}
	}

	if(isdefined(var_00))
	{
		var_0E = maps/mp/agents/_agent_utility::func_45BB();
		var_00 lib_056D::func_5A86();
		return 1;
	}

	return 0;
}

//Function Number: 9
func_1F70(param_00)
{
	return isdefined(maps/mp/agents/_agent_utility::func_3B8C(param_00));
}

//Function Number: 10
func_90BA(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = spawnstruct();
	thread func_90BB(var_0A,param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	var_0A waittill("spawnZombie_return",var_0B);
	return var_0B;
}

//Function Number: 11
func_90BB(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	level.var_6F43 = level.var_6F43 + 1;
	wait 0.05;
	level.var_6F43 = level.var_6F43 - 1;
	if(!isdefined(param_08))
	{
		param_08 = 0;
	}

	if(!isdefined(param_09))
	{
		param_09 = level.var_A980;
	}

	if(isdefined(level.var_1CC0) && !isdefined(param_02) && isdefined(param_02.ignoreforcedzombietype))
	{
		param_01 = common_scripts\utility::func_7A33(level.var_1CC0);
	}

	var_0B = lib_0547::func_A51(param_01);
	param_06 = param_06 & !common_scripts\utility::func_562E(var_0B.var_2F9B);
	if(isdefined(level.var_1CBF))
	{
		param_02 = common_scripts\utility::func_7A33(level.var_1CBF);
	}

	if(isdefined(param_02))
	{
		var_0C = param_02;
		if(isdefined(var_0C.var_AC8A))
		{
			var_0D = var_0C.var_AC8A;
		}
		else
		{
			var_0D = lib_055A::func_4562(var_0D.var_116);
		}
	}
	else
	{
		var_0C = func_4696(param_03,isdefined(var_0D.var_907C),param_0A);
		var_0D = var_0D.var_AC8A;
	}

	if(!isdefined(var_0C))
	{
		param_00 notify("spawnZombie_return",undefined);
		return;
	}

	if(isdefined(var_0C.requirenavmesh))
	{
		param_04 = var_0C.requirenavmesh;
	}

	if(param_04 && !var_0C func_ABFD(var_0C.var_116,"not spawning because no navmesh"))
	{
		param_00 notify("spawnZombie_return",undefined);
		return;
	}

	if(!isdefined(var_0B))
	{
		param_00 notify("spawnZombie_return",undefined);
		return;
	}

	if(!common_scripts\utility::func_3C83("spawn_zombie_lock"))
	{
		common_scripts\utility::func_3C87("spawn_zombie_lock");
	}

	common_scripts\utility::func_3CA9("spawn_zombie_lock");
	common_scripts\utility::func_3C8F("spawn_zombie_lock");
	if(param_05 && !func_1F70(var_0B.var_A4B))
	{
		if(func_7B4B())
		{
			var_0E = 0;
			while(!func_1F70(var_0B.var_A4B))
			{
				wait 0.05;
				var_0E++;
				if(var_0E > 5)
				{
					break;
				}
			}
		}
	}

	common_scripts\utility::func_3C7B("spawn_zombie_lock");
	if(!func_1F70(var_0B.var_A4B))
	{
		param_00 notify("spawnZombie_return",undefined);
		return;
	}

	var_0F = gettime();
	if(isdefined(var_0B.var_5691) && var_0B.var_5691)
	{
		var_10 = lib_0547::func_902E(var_0C,var_0B,level.var_3772);
	}
	else
	{
		var_10 = lib_0547::func_90A0(var_0D,var_0C,level.var_3772,param_08,param_09,param_0A,var_0F);
	}

	if(!isdefined(var_10))
	{
		param_00 notify("spawnZombie_return",undefined);
		return;
	}

	var_10.var_60E2 = var_0B.var_60E2;
	var_10.var_FB = maps/mp/gametypes/zombies::func_1E59(var_0B,var_10.var_901F);
	if(common_scripts\utility::func_562E(level.zmb_red_skull_mode_activated))
	{
		level.zmb_global_zombie_health_multiplier = 2.7;
	}

	if(isdefined(level.zmb_global_zombie_health_multiplier) && isdefined(level.zmb_global_zombie_health_multiplier_wave_start) && level.var_A980 >= level.zmb_global_zombie_health_multiplier_wave_start)
	{
		var_10.var_FB = int(var_10.var_FB * level.zmb_global_zombie_health_multiplier);
	}

	if(isdefined(level.zmb_temp_zombie_health_buff))
	{
		var_10.var_FB = int(var_10.var_FB * level.zmb_temp_zombie_health_buff);
	}

	if(common_scripts\utility::func_562E(level.zmb_disable_all_hitreacts))
	{
		var_10.var_66EC = 1;
	}

	var_10.var_BC = int(var_10.var_FB);
	if(isdefined(param_0A))
	{
		if(isdefined(param_0A.var_6A37))
		{
			var_10.var_BC = int(clamp(param_0A.var_6A37,0,var_10.var_FB));
		}

		if(var_10.var_A4B == "zombie_generic")
		{
			if(isdefined(param_0A.var_3C70))
			{
				var_10.var_3C70 = param_0A.var_3C70;
			}

			if(isdefined(param_0A.var_6A3C))
			{
				var_10.var_6A3C = param_0A.var_6A3C;
			}

			if(isdefined(param_0A.var_6A3D))
			{
				var_10.var_6A3D = param_0A.var_6A3D;
			}

			if(isdefined(param_0A.var_6A3F))
			{
				var_10.var_6A3F = param_0A.var_6A3F;
			}

			if(isdefined(param_0A.var_6A2C))
			{
				foreach(var_12 in param_0A.var_6A2C)
				{
					var_10.var_1CF1 = param_0A.var_6A2C;
				}
			}
		}
	}

	var_10.var_6250 = 0;
	var_10.var_2FDA = 0;
	var_10.var_186 = var_0C;
	if(isdefined(var_0C))
	{
		var_0C func_A0DA();
		var_0C.var_AC3D[var_0C.var_AC3D.size] = var_10;
		if(common_scripts\utility::func_562E(var_0C.traversalvalidationfailed) || !common_scripts\utility::func_562E(var_0C.validitytestresult))
		{
			var_10 thread handlebrokenspawnervstraversalplacement();
		}
	}

	var_10.var_2B61 = param_03;
	var_10.var_C29 = param_06;
	var_10.var_5B89 = [];
	var_10 func_A135();
	if(function_02BF(var_10) && common_scripts\utility::func_562E(level.var_AC31))
	{
		setdvar("spawnZombiesWithEyes",1);
		var_10 thread lib_0547::func_ABF1("zmb_eye_glow");
	}

	var_10 setthreatbiasgroup("zombies");
	var_10 thread func_3219();
	if(function_02BF(var_10))
	{
		var_14 = common_scripts\utility::func_98E7(isdefined(var_0B.var_AC6D),var_0B.var_AC6D,param_01);
		var_10 method_8550(var_14);
	}

	level notify("zombie_spawned",var_10);
	if(isdefined(var_0C.var_8C95))
	{
		var_15 = undefined;
		var_16 = lib_0547::func_4282(var_0C);
		var_17 = var_16["height"];
		if(isdefined(var_17))
		{
			var_15 = int(var_17);
		}

		var_10 thread lib_0540::func_ABA4(var_0C.var_116,var_0C.var_1D,var_15,undefined,var_0C);
	}

	var_10 thread lib_054E::func_3102("spawn",var_10.var_A4B);
	param_00 notify("spawnZombie_return",var_10);
}

//Function Number: 12
func_A0DA()
{
	if(!isdefined(self.var_AC3D))
	{
		self.var_AC3D = [];
	}

	var_00 = [];
	foreach(var_02 in self.var_AC3D)
	{
		if(!isalive(var_02))
		{
			continue;
		}

		if(var_02 lib_0547::func_4B2C())
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	self.var_AC3D = var_00;
}

//Function Number: 13
func_A135()
{
	var_00 = 1;
	if(maps/mp/agents/humanoid/_humanoid_util::func_56BC())
	{
		var_00 = 0;
	}

	self setmeleechargevalid(1);
	lib_0542::set_invalid_melee_pairing_reason("crawler",!var_00);
}

//Function Number: 14
func_4696(param_00,param_01,param_02)
{
	var_03 = lib_055A::func_4696(param_00,param_01,param_02);
	if(isdefined(var_03))
	{
		return var_03;
	}

	return func_4650(param_00);
}

//Function Number: 15
func_4650(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_AC4F)
	{
		if(level.var_AC80.var_ACB3[var_03.var_AC8A].var_556E && var_03 lib_055A::func_905C(param_00,0))
		{
			var_01[var_01.size] = var_03;
		}
	}

	return common_scripts\utility::func_7A33(var_01);
}

//Function Number: 16
func_2AA5()
{
	self waittill("death",var_00,var_01,var_02);
	if(!isplayer(var_00))
	{
		return;
	}

	var_03 = var_00 getcurrentweapon();
	var_04 = maps\mp\_utility::func_472A(var_03);
	var_05 = distance(var_00.var_116,self.var_116);
	if(var_05 < level.var_4752 && var_04 == "weapon_shotgun")
	{
		func_2AA6(var_00);
		return;
	}

	if(common_scripts\utility::func_F79(level.var_4751,var_04))
	{
		func_2AAA();
	}
}

//Function Number: 17
func_2AA6(param_00)
{
	var_01 = self.var_116 + (0,0,32);
	playfx(common_scripts\utility::func_44F5("mutant_gib_death"),var_01);
	earthquake(0.45,0.35,var_01,350);
	if(!isdefined(param_00))
	{
		return;
	}

	param_00 setblurforplayer(3.25,0.1);
	wait(0.1);
	param_00 setblurforplayer(0,0.1);
}

//Function Number: 18
func_2AAA()
{
	var_00 = self.var_116 + (0,0,8);
	self.var_18A8 startragdoll();
	wait(0.1);
	physicsexplosionsphere(var_00,128,0,5,0);
}

//Function Number: 19
func_2A9E()
{
	self waittill("death");
	if(common_scripts\utility::func_24A6())
	{
		playfx(common_scripts\utility::func_44F5("mutant_blood_pool"),self.var_116);
	}
}

//Function Number: 20
func_AC15()
{
	thread func_ABCF();
	thread func_AB51();
	thread func_ABA5();
	thread func_ABEB();
	thread monitorstuckfortraversal();
	thread func_AC04();
}

//Function Number: 21
func_ABCF()
{
	if(func_56E1())
	{
		return;
	}

	var_00 = 55;
	self endon("death");
	level endon("game_ended");
	var_01 = self.var_116;
	var_02 = gettime();
	for(;;)
	{
		wait(5);
		if(func_56E1())
		{
			continue;
		}

		var_03 = distancesquared(self.var_116,var_01);
		var_04 = gettime() - var_02 / 1000;
		var_05 = var_03 > 16384;
		var_06 = function_02BF(self) && self.var_BA4 == "melee" && isdefined(self.var_28D2) && distancesquared(self.var_28D2.var_116,self.var_116) < 6400;
		var_07 = lib_0547::func_4B24();
		var_08 = 0;
		if(var_05 || var_06 || var_07 || lib_0547::func_585E() || var_08 || common_scripts\utility::func_3794("zombie_passive") || lib_0547::func_5565(self.var_A4B,"zombie_fireman") || isdefined(self.var_8E1) || common_scripts\utility::func_562E(self.var_509A))
		{
			var_01 = self.var_116;
			var_02 = gettime();
		}

		if(lib_0547::func_5565(self.var_A4B,"zombie_heavy"))
		{
			if(!maps\mp\_utility::iszombiegameshattermode() || maps\mp\_utility::iszombiegameshattermode() && common_scripts\utility::func_562E(self.var_6816))
			{
				var_01 = self.var_116;
				var_02 = gettime();
			}
		}

		if(var_04 > var_00)
		{
			break;
		}
	}

	lib_056D::func_5A86();
}

//Function Number: 22
func_ABEB()
{
	var_00 = 2;
	var_01 = 10;
	var_02 = 10;
	self endon("death");
	level endon("game_ended");
	wait(var_01);
	wait(randomfloat(var_00));
	var_03 = 0;
	for(;;)
	{
		var_04 = common_scripts\utility::func_562E(self.var_C29) && !func_0F0A(self);
		if(var_04)
		{
			var_03 = var_03 + var_00;
		}
		else
		{
			var_03 = 0;
		}

		if(var_03 >= var_02)
		{
			lib_056D::func_5A86();
		}

		wait(var_00);
	}
}

//Function Number: 23
func_0F0A(param_00)
{
	foreach(var_02 in level.var_744A)
	{
		if(var_02 func_7230(param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 24
func_7230(param_00)
{
	if(isdefined(param_00.var_5B89))
	{
		var_01 = param_00.var_5B89[self getentitynumber()];
		if(isdefined(var_01) && gettime() - var_01 < 5000)
		{
			return 1;
		}
	}

	if(lib_053A::func_AC2B(self))
	{
		return 1;
	}

	var_02 = 780;
	var_03 = cos(60);
	var_04 = cos(20);
	var_05 = self geteye();
	var_06 = param_00.var_116 + (0,0,48);
	var_07 = var_06 - var_05;
	if(length(var_07) < var_02)
	{
		return 1;
	}

	var_08 = anglestoforward(self getangles());
	var_09 = vectordot(vectornormalize(var_07),var_08);
	if(var_09 > var_04)
	{
		return 1;
	}

	if(var_09 < var_03)
	{
		return 0;
	}

	var_0A = sighttracepassed(var_05,var_06,0,self,param_00);
	return var_0A;
}

//Function Number: 25
func_ABA5()
{
	self endon("death");
	var_00 = -300;
	if(isdefined(level.var_ABD3))
	{
		var_00 = level.var_ABD3;
	}

	wait(1);
	var_01 = self.var_116;
	for(;;)
	{
		if(self isonground())
		{
			var_01 = self.var_116;
		}

		if(self.var_116[2] < var_00)
		{
			self.var_1DEB = 1;
			lib_056D::func_5A86();
		}

		wait(1);
	}
}

//Function Number: 26
monitorstuckfortraversal()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 30;
	if(isdefined(self.stuckfortraversalthreshold))
	{
		var_01 = self.stuckfortraversalthreshold;
	}
	else
	{
		var_01 = 8;
	}

	var_02 = 1;
	var_03 = self.var_116;
	for(;;)
	{
		wait(var_02);
		if(self.var_BA4 != "move")
		{
			continue;
		}

		var_04 = self method_8198();
		if(!isdefined(var_04))
		{
			continue;
		}

		var_05 = distance2d(var_03,self.var_116);
		var_03 = self.var_116;
		if(var_05 > var_01)
		{
			continue;
		}

		if(common_scripts\utility::func_562E(var_04.var_54F5))
		{
			continue;
		}

		var_06 = distance2d(self.var_116,var_04.var_116);
		if(var_06 > var_00)
		{
			continue;
		}

		if(isalive(var_04.var_98C3))
		{
			continue;
		}

		var_07 = getgroundposition(var_04.var_116,self.var_14F);
		if(!isdefined(var_07))
		{
			var_07 = var_04.var_116;
		}

		var_04.var_98C3 = self;
		self setorigin(var_07,0);
		wait(var_02);
		if(lib_0547::func_5565(var_04.var_98C3,self))
		{
			var_04.var_98C3 = undefined;
		}
	}
}

//Function Number: 27
func_6BD4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level notify("onZombieKilled");
	lib_0547::tackle_system_handle_zombie_death(self);
	if(!lib_0547::func_5767(self))
	{
		lib_0547::func_376A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		if(isplayer(param_01))
		{
			if(isdefined(param_01.var_AC5D[self.var_A4B]))
			{
				param_01.var_AC5D[self.var_A4B]++;
			}
		}

		if(isdefined(level.var_6BD5))
		{
			self [[ level.var_6BD5 ]](param_01);
		}

		if(param_04 == "drag_explosive_zombie_zm")
		{
			cp_zmb_mutilation_mask_func(param_01,param_00);
		}
	}
	else if(function_01EF(self) && lib_0547::func_5767(self))
	{
		lib_0547::check_allykilledfuncs(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	var_09 = lib_0547::func_AC4B(self.var_116,"killed");
	var_09 lib_0547::func_AC48("agent_type",self.var_A4B);
	var_09 lib_0547::func_AC48("sWeapon",param_04);
	var_09 lib_0547::func_AC44("iDamage",param_02);
	var_09 lib_0547::func_AC48("sMeansOfDeath",param_03);
	var_09 lib_0547::func_AC42("recycled",common_scripts\utility::func_562E(self.var_AC10));
	var_09 lib_0547::func_AC4D();
	thread lib_0541::func_6B4A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	thread lib_053C::func_6AA4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	self hudoutlinedisable();
	lib_0547::func_6B9E(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	if(lib_0547::should_play_zombie_fx())
	{
		func_90BC(self.var_8D9,param_03,param_04);
	}

	if(isdefined(param_01) && lib_0547::func_5767(param_01) && isplayer(param_01))
	{
		var_0A = spawnstruct();
		var_0A.var_721C = param_01;
		var_0A.var_ABE6 = level.var_5B95;
		var_0A.var_4DCF = param_06;
		var_0A.var_60B8 = param_03;
		var_0A.var_1D0 = param_04;
		lib_0378::func_8D74("onZombieKilled",var_0A);
	}

	if(isdefined(param_03))
	{
		if(param_03 == "MOD_MELEE")
		{
			if(isdefined(param_01.var_7F09))
			{
				param_01.var_7F09++;
			}
		}
		else if(isexplosivedamagemod(param_03))
		{
			if(isdefined(param_01.var_394C))
			{
				param_01.var_394C++;
			}

			if(param_03 == "MOD_GRENADE" || param_03 == "MOD_GRENADE_SPLASH")
			{
				if(isdefined(param_01.var_4868))
				{
					param_01.var_4868++;
				}
			}
		}
	}

	if(isdefined(param_01.equipmentkills) && isdefined(param_04) && lib_0547::func_585C(param_04))
	{
		param_01.equipmentkills++;
	}
}

//Function Number: 28
func_56E3(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	param_00 = tolower(param_00);
	switch(param_00)
	{
		case "mod_explosive":
		case "mod_projectile_splash":
		case "mod_projectile":
		case "mod_grenade_splash":
		case "mod_grenade":
		case "splash":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 29
cp_zmb_mutilation_mask_func(param_00,param_01)
{
	var_02 = undefined;
	if(isplayer(param_00))
	{
		var_02 = param_00;
	}

	if(isplayer(param_01))
	{
		var_02 = param_01;
	}

	if(!isplayer(var_02))
	{
		return;
	}

	if(!isdefined(var_02.var_18F2))
	{
		var_02.var_18F2 = 0;
	}

	var_03 = gettime();
	var_04 = gettime();
	if(isdefined(var_02.var_5B77))
	{
		var_04 = var_02.var_5B77;
	}

	var_02.var_18F2++;
	var_02.var_5B77 = var_03;
	if(var_03 - var_04 > 1000)
	{
		var_02.var_18F2 = 1;
		return;
	}

	if(var_02.var_18F2 >= 10 && maps\mp\_utility::func_4571() == "mp_zombie_nest_01")
	{
		var_02 maps/mp/gametypes/zombies::func_47C8("ZM_BOMBER_10");
	}
}

//Function Number: 30
func_4788(param_00,param_01)
{
	if(!isplayer(param_01) || !isdefined(param_00) || !lib_0547::func_5565(param_00.var_A4B,"zombie_heavy"))
	{
		return;
	}

	if(isdefined(param_00.var_A4B) && param_00.var_A4B == "zombie_heavy")
	{
		if(!isdefined(param_00.var_20ED))
		{
			param_00.var_20ED = 0;
		}

		param_00.var_20ED++;
		if(param_00.var_20ED >= 10 && maps\mp\_utility::func_4571() == "mp_zombie_nest_01")
		{
			param_01 maps/mp/gametypes/zombies::func_47C8("ZM_CHARGE_10");
		}
	}
}

//Function Number: 31
func_90BC(param_00,param_01,param_02)
{
	if(!isdefined(self.var_18A8))
	{
		return;
	}

	if(isdefined(level.var_90BD))
	{
		var_03 = self [[ level.var_90BD ]](param_01,param_02);
		if(var_03)
		{
			return;
		}
	}

	var_04 = self.var_7AD3;
	if(!isdefined(var_04))
	{
		return;
	}

	if(lib_0547::func_2696(var_04) >= 3)
	{
		thread func_9038(param_00);
		return;
	}

	func_90B0(self.var_18A8,var_04,param_00);
}

//Function Number: 32
func_90B0(param_00,param_01,param_02)
{
	while(param_01 > 0)
	{
		var_03 = param_01 & 0 - param_01;
		thread func_90AF(param_00,var_03,param_02);
		param_01 = param_01 - var_03;
	}
}

//Function Number: 33
func_90AF(param_00,param_01,param_02)
{
	if(common_scripts\utility::func_562E(param_00 lib_0541::func_4559(param_01,undefined,"noFx")))
	{
		return;
	}

	var_03 = param_00 lib_0541::func_4559(param_01,undefined,"torsoFX");
	var_04 = param_00 lib_0541::func_4559(param_01,undefined,"fxTagName");
	playfxontag(common_scripts\utility::func_44F5(var_03),param_00,var_04);
}

//Function Number: 34
func_9038(param_00)
{
	var_01 = 3;
	if(isdefined(level.var_910F) && level.var_910F)
	{
		var_01 = 1;
	}

	var_02 = level.var_3EFD < var_01;
	if(var_02)
	{
		level.var_3EFD++;
		var_03 = common_scripts\utility::func_44F5("gib_full_body");
	}
	else
	{
		var_03 = common_scripts\utility::func_44F5("gib_full_body_cheap");
	}

	var_04 = level.var_2FDE["full"]["fxTagName"];
	playfxontag(var_03,self.var_18A8,var_04);
	var_05 = lib_0547::func_4495();
	playclientsound(level.var_2FDE["full"][var_05],undefined,self.var_18A8.var_116);
	wait(3);
	if(isdefined(self.var_18A8))
	{
		stopfxontag(var_03,self.var_18A8,var_04);
	}

	if(var_02)
	{
		level.var_3EFD--;
	}
}

//Function Number: 35
func_AC35(param_00)
{
	lib_053C::func_4F94(param_00);
}

//Function Number: 36
func_5714(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_08) && param_08 == "head" || param_08 == "helmet")
	{
		return 1;
	}

	return 0;
}

//Function Number: 37
func_4136(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(param_00.var_116))
	{
		return param_00.var_116;
	}

	if(isdefined(param_00.var_117.var_116))
	{
		return param_00.var_117.var_116;
	}
}

//Function Number: 38
func_6BD1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(isdefined(self.zombie_shielding_func))
	{
		self thread [[ self.zombie_shielding_func ]](param_02);
		param_02 = 1;
	}

	if(isplayer(param_01) && !lib_0547::func_5565(param_04,"MOD_MELEE"))
	{
		self.has_taken_bullet_damage = 1;
	}

	var_0B = lib_0547::func_AC4B(self.var_116,"damaged");
	var_0B lib_0547::func_AC48("agent_type",self.var_A4B);
	var_0B lib_0547::func_AC48("sWeapon",param_05);
	var_0B lib_0547::func_AC44("iDamage",param_02);
	var_0B lib_0547::func_AC48("sMeansOfDeath",param_04);
	var_0B lib_0547::func_AC49("inflictor_pos",func_4136(param_00));
	var_0B lib_0547::func_AC49("attacker_pos",func_4136(param_01));
	var_0B lib_0547::func_AC42("attacker_is_player",isplayer(param_01) || isplayer(param_00));
	var_0B lib_0547::func_AC4D();
	func_2183(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	maps/mp/agents/_agents::func_6A73(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	if(isdefined(param_01) && isplayer(param_01))
	{
		var_0C = spawnstruct();
		var_0C.var_721C = param_01;
		var_0C.var_ABE6 = self.var_116;
		var_0C.var_4DD1 = param_06;
		var_0C.var_4DCF = param_08;
		var_0C.var_60B8 = param_04;
		var_0C.var_1D0 = param_05;
		lib_0378::func_8D74("onZombieDamaged",var_0C);
		param_01 thread checkhitzombies(param_05,self);
		if(maps\mp\_utility::func_4431(param_05) == param_01.var_76D8)
		{
			param_01.var_A9BA[param_01.var_76D9].var_4DDE = param_01.var_A9BA[param_01.var_76D9].var_4DDE + 1;
			return;
		}

		var_0D = lib_0547::func_4837(param_01,param_05);
		if(var_0D == -1)
		{
			param_01.var_76D8 = "";
			param_01.var_76D9 = -1;
			return;
		}

		param_01.var_A9BA[var_0D].var_4DDE = param_01.var_A9BA[var_0D].var_4DDE + 1;
		param_01.var_76D8 = maps\mp\_utility::func_4431(param_05);
		param_01.var_76D9 = var_0D;
		return;
	}
}

//Function Number: 39
checkhitzombies(param_00,param_01)
{
	self endon("disconnect");
	waittillframeend;
	if(!isdefined(param_00))
	{
		return;
	}

	if(lib_0547::func_5864(param_00) || issubstr(param_00,"turret") || lib_0547::func_5865(param_00) || lib_0547::func_585B(param_00) || lib_0547::func_585C(param_00) || lib_0547::iszombieindirectweapon(param_00))
	{
		return;
	}

	if(!isdefined(self.var_5BA9[param_00]))
	{
		self.var_5BA9[param_00] = 0;
	}

	if(self.var_5BA9[param_00] == gettime())
	{
		return;
	}

	self.var_5BA9[param_00] = gettime();
	self.var_8B33++;
}

//Function Number: 40
func_2183(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!isdefined(level.var_6BD2))
	{
		return;
	}

	for(var_0B = 0;var_0B < level.var_6BD2.size;var_0B++)
	{
		self thread [[ level.var_6BD2[var_0B] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	}
}

//Function Number: 41
func_7BC6(param_00)
{
	if(!isdefined(level.var_6BD2))
	{
		level.var_6BD2 = [];
	}

	level.var_6BD2[level.var_6BD2.size] = param_00;
}

//Function Number: 42
func_2D8D(param_00)
{
	if(isdefined(level.var_6BD2))
	{
		level.var_6BD2 = common_scripts\utility::func_F93(level.var_6BD2,param_00);
	}
}

//Function Number: 43
func_8BB0(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(common_scripts\utility::func_562E(self.nomutilate) && !common_scripts\utility::func_562E(self.must_gib_head))
	{
		return 0;
	}

	var_0B = isdefined(param_01) && self method_864D(param_01) && isdefined(maps/mp/agents/humanoid/_humanoid::func_45FB(param_05,param_01));
	if(var_0B)
	{
		return 0;
	}

	if(lib_0547::func_AC70())
	{
		return 0;
	}

	if(param_04 == "MOD_FALLING")
	{
		return 0;
	}

	switch(param_05)
	{
		case "teslagun_zm_death":
		case "zombie_water_trap_mp":
		case "repulsor_zombie_mp":
		case "zombie_vaporize_mp":
			return 0;
	}

	return 1;
}

//Function Number: 44
int_max(param_00,param_01)
{
	var_02 = int(param_00);
	var_03 = int(param_01);
	if(var_02 > var_03)
	{
		return var_02;
	}

	return var_03;
}

//Function Number: 45
func_6BD3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = self.var_BC;
	var_0C = 0;
	var_0D = func_8BB0(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	if(var_0D)
	{
		if(self.var_BC > 0)
		{
			var_0E = clamp(param_02 / self.var_BC,0,1);
		}
		else
		{
			var_0E = 1;
		}

		lib_0541::func_9E19(param_07,param_08,param_04);
		var_0C = lib_0541::func_9E1D(param_08,param_05,param_04,var_0E,param_01,param_07);
		if(var_0C && isdefined(param_01))
		{
			param_02 = self.var_BC + 1;
		}
	}

	if(isdefined(param_01) && isplayer(param_01) && !isdefined(self.var_94))
	{
		var_0F = self.var_BA4 != "melee";
		var_10 = isdefined(self.var_28D2) && self.var_28D2 == param_01;
		var_11 = isdefined(self.var_28D2) && !isplayer(self.var_28D2);
		if(var_0F || var_10 || var_11)
		{
			if(distancesquared(self.var_116,param_01.var_116) <= self.var_29BE)
			{
				maps/mp/agents/humanoid/_humanoid_util::func_867E(param_01);
				thread maps/mp/agents/humanoid/_humanoid::func_A909();
			}
		}
	}

	if(isdefined(param_01) && isplayer(param_01))
	{
		self.var_5B89[param_01 getentitynumber()] = gettime();
		self.var_5B88 = gettime();
		func_A144(self,param_01,param_00,param_05,param_02,param_06,param_07,param_08,param_09,param_04);
	}

	if(maps\mp\_utility::func_5697(param_04) && param_05 == "flamethrower_zm" && !common_scripts\utility::func_562E(self.is_flamethrower_immune))
	{
		if(common_scripts\utility::func_562E(self.is_flamethrower_resistent))
		{
			self setonfire(self.var_FB * 0.025,1,10,"none",0,param_01,param_05);
		}
		else
		{
			self setonfire(self.var_FB * 0.35,1,100,"none",0,param_01,param_05);
		}
	}

	if(maps\mp\_utility::func_5755(param_04))
	{
		thread lib_0541::func_2CD9();
	}

	if(!isdefined(self.var_6B53) || self.var_6B53)
	{
		self.var_6B53 = maps\mp\_utility::func_5755(param_04) || param_04 == "MOD_IMPACT";
	}

	thread lib_0541::func_6ADD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	thread lib_0537::func_6ADC(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	if(!lib_0547::func_1F4C() && self.var_BC - param_02 <= 0)
	{
		thread lib_0547::func_AC36(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		param_02 = int_max(0,self.var_BC - 1);
	}

	if(self.var_90DC == "dog")
	{
		self [[ level.var_AC1C ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}
	else
	{
		func_6ADE(param_02,param_04,param_05);
		maps/mp/agents/humanoid/_humanoid::func_6ADB(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}

	lib_054E::func_3102("pain",self.var_A4B);
	level notify("zombie_damaged",self,param_01);
	maps/mp/agents/_agents::func_A40(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	if(isalive(self))
	{
		if(isplayer(param_01) && common_scripts\utility::func_562E(param_01.var_5F5C) && param_01 lib_0547::func_4BA7("specialty_class_suppressive_fire_zm") && maps\mp\_utility::func_5694(param_04))
		{
			maps\mp\zombies\_zombies_perks::func_F38(param_01);
		}

		if(var_0C && !lib_0547::func_5774())
		{
			self suicide();
			return;
		}

		func_A135();
		return;
	}

	if(isdefined(param_01) && isdefined(param_01.var_5F5C) && param_01.var_5F5C)
	{
		thread lib_0538::func_6BD4(param_01,param_04,param_05,param_06,param_08);
	}
}

//Function Number: 46
func_5574(param_00,param_01)
{
	return !isdefined(param_00) != isdefined(param_01) || isdefined(param_00) && param_00 != param_01;
}

//Function Number: 47
func_A144(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = param_00.var_4DE4;
	if(isdefined(param_00.var_6730))
	{
		return;
	}

	if(isdefined(var_0A))
	{
		if(!func_5574(param_01,var_0A.var_E6) || !func_5574(param_02,var_0A.var_5BAE) || gettime() != var_0A.var_5C07 || param_08 != var_0A.var_5BC6 || param_03 != var_0A.var_5C10)
		{
			var_0A.var_5C++;
		}
	}
	else
	{
		var_0A = spawnstruct();
		var_0A.var_5C = 1;
		param_00.var_4DE4 = var_0A;
	}

	var_0A.var_E6 = param_01;
	var_0A.var_5BAE = param_02;
	var_0A.var_5C07 = gettime();
	var_0A.var_5BC6 = param_08;
	var_0A.var_5C10 = param_03;
}

//Function Number: 48
func_2EF2()
{
	return isdefined(self.var_4DE4) && self.var_4DE4.var_5C == 1;
}

//Function Number: 49
func_314F(param_00,param_01,param_02)
{
	var_03 = 6;
	var_04 = 20;
	var_05 = squared(30);
	var_06 = self method_85D5(param_02.var_F4B);
	var_07 = self method_85D5(param_02.var_F4B + var_03) - var_06;
	if(var_07 == (0,0,0))
	{
		return 0;
	}

	var_08 = abs(angleclamp180(self.var_1D[1] + param_02.var_AAEA - vectortoyaw(var_07)));
	if(var_08 > var_04)
	{
		return 0;
	}

	var_09 = self localtoworldcoords(param_02.var_64A2);
	if(distance2dsquared(var_06,var_09) > var_05 || !function_02E6(var_09,self))
	{
		return 0;
	}

	return 1;
}

//Function Number: 50
func_9031(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.var_5811 = 0;
	var_04 = maps/mp/agents/_scripted_agent_anim_util::func_87C(param_00,param_01);
	if(!isdefined(var_04))
	{
		return var_03;
	}

	var_05 = self method_83DB(var_04);
	var_06 = maps/mp/agents/_scripted_agent_anim_util::func_4416(param_02,var_05);
	var_07 = var_06 == int(var_05 * 0.5);
	if(var_07)
	{
		return var_03;
	}

	var_08 = self method_83D9(var_04,var_06);
	var_09 = self method_83D8(var_04,var_06);
	var_0A = 0;
	var_0B = 0;
	var_0C = 10;
	var_0D = 1 / var_0C;
	for(var_0E = 0;var_0E < var_0C;var_0E++)
	{
		var_0F = min(1,var_0B + var_0D);
		var_10 = getmovedelta(var_09,var_0B,var_0F);
		var_0A = var_0A + length(var_10);
		var_0B = var_0F;
	}

	var_11 = 0;
	if(var_05 > 1)
	{
		var_12 = var_05 - 1;
		var_13 = 360 / var_12;
		var_11 = -180 + var_06 * var_13;
	}

	var_03.var_5811 = 1;
	var_03.var_873 = param_00;
	var_03.var_EE8 = var_04;
	var_03.var_688B = var_05;
	var_03.var_37E2 = var_06;
	var_03.var_37E3 = var_08;
	var_03.var_F4B = var_0A;
	var_03.var_64A2 = getmovedelta(var_09,0,1);
	var_03.var_AAEA = var_11;
	return var_03;
}

//Function Number: 51
func_6704()
{
	var_00 = 113;
	if(isdefined(self.cornerlessturnmindegreeoverride))
	{
		var_00 = self.cornerlessturnmindegreeoverride;
	}

	var_01 = self method_83E6();
	if(var_01 == (0,0,0))
	{
		return;
	}

	var_02 = self.var_1D[1];
	var_03 = vectortoyaw(var_01);
	var_04 = angleclamp180(var_03 - var_02);
	if(abs(var_04) < var_00)
	{
		return;
	}

	var_05 = self [[ maps/mp/agents/_agent_utility::func_A59("get_action_params") ]]();
	var_06 = "turn_" + self.var_108;
	var_07 = maps/mp/agents/_scripted_agent_anim_util::func_87C(var_06,var_05);
	if(!isdefined(var_07))
	{
		return;
	}

	var_08 = self method_83DB(var_07);
	var_09 = maps/mp/agents/_scripted_agent_anim_util::func_4416(var_04,var_08);
	var_0A = var_09 == int(var_08 * 0.5);
	if(var_0A)
	{
		return;
	}

	var_0C = self method_83D8(var_07,var_09);
	var_0D = getmovedelta(var_0C);
	var_0E = var_04 - getangledelta(var_0C);
	var_0F = undefined;
	if(getdvarint("scr_zombieProjectedTurnLimiting") || common_scripts\utility::func_562E(self.useprojectedturnlimiting))
	{
		var_10 = self method_8198();
		if(isdefined(var_10))
		{
			var_11 = 60;
			var_12 = distance(self.var_116,var_10.var_116);
			if(var_12 <= var_11)
			{
				return;
			}
		}

		var_0F = self localtoworldcoords(rotatevector(var_0D,(0,var_0E,0)));
		var_13 = vectordot(var_01,var_0F - self.var_116);
		if(var_13 > 0)
		{
			var_14 = var_13 - distance(self method_85D5(var_13),self.var_116);
			var_15 = 3;
			if(var_14 > var_15)
			{
				return;
			}
		}
	}
	else
	{
		var_16 = length(var_0D);
		var_17 = self method_85D5(var_16);
		var_18 = distance(self.var_116,var_17);
		var_19 = 50;
		if(var_16 + var_19 > var_18)
		{
			return;
		}

		var_0F = self localtoworldcoords(var_0D);
	}

	var_1A = function_02E6(var_0F,self) && function_02DE(self.var_116,var_0F,self);
	if(!var_1A)
	{
		return;
	}

	var_1C = spawnstruct();
	var_1C.var_EE8 = var_07;
	var_1C.var_873 = var_06;
	var_1C.var_EC1 = var_09;
	var_1C.var_EC3 = "anim deltas";
	var_1C.var_6C37 = "face angle abs";
	var_1C.var_6C38 = (self.var_1D[0],self.var_1D[1] + var_0E,self.var_1D[2]);
	return var_1C;
}

//Function Number: 52
func_6BD0()
{
	var_00 = undefined;
	self.var_1E22 = undefined;
	var_01 = 0.1;
	var_02 = int(var_01 * 20);
	for(;;)
	{
		if(maps/mp/agents/humanoid/_humanoid_move::func_5810())
		{
			self.var_1E22 = undefined;
		}
		else
		{
			var_03 = func_6704();
			if(isdefined(var_03))
			{
				return var_03;
			}

			var_04 = self method_85D6();
			if(!isdefined(var_04))
			{
				self.var_1E22 = undefined;
			}
			else
			{
				var_05 = var_04["position"];
				var_06 = var_04["angle"];
				var_07 = distance2dsquared(self.var_116,var_05);
				if(var_07 > squared(150))
				{
				}
				else
				{
					var_0A = !isdefined(self.var_1E22) || self.var_1E22.var_266C != var_05 || abs(angleclamp180(self.var_1E22.var_266F - var_06)) > 20;
					if(var_0A)
					{
						if(level.var_AC67 == level.var_AC37)
						{
						}
						else
						{
							if(var_0A)
							{
								level.var_AC67++;
								self.var_1E22 = spawnstruct();
								self.var_1E22.var_266C = var_05;
								self.var_1E22.var_266F = var_06;
								var_0B = self [[ maps/mp/agents/_agent_utility::func_A59("get_action_params") ]]();
								var_0C = "turn_" + self.var_108;
								self.var_1E22.var_6748 = func_9031(var_0C,var_0B,var_06);
								var_0C = var_0C + "_quick";
								self.var_1E22.var_789D = func_9031(var_0C,var_0B,var_06);
							}

							var_00 = self.var_1E22.var_6748;
							if(var_00.var_5811)
							{
								if(func_314F(var_05,var_06,var_00))
								{
									break;
								}
							}

							var_00 = self.var_1E22.var_789D;
							if(var_00.var_5811)
							{
								if(func_314F(var_05,var_06,var_00))
								{
									break;
								}
							}
						}
					}
				}
			}
		}

		wait(var_01);
	}

	var_03 = spawnstruct();
	var_03.var_EE8 = var_00.var_EE8;
	var_03.var_873 = var_00.var_873;
	var_03.var_EC1 = var_00.var_37E2;
	var_03.var_EC3 = "code_move";
	var_03.var_6C37 = "face motion";
	return var_03;
}

//Function Number: 53
func_AC04()
{
	self endon("death");
	if(!isdefined(level.var_AC58))
	{
		level.var_AC58["walk"] = 100;
		level.var_AC58["run"] = 130;
		level.var_AC58["sprint"] = 130;
	}

	for(;;)
	{
		if(maps/mp/agents/_scripted_agent_anim_util::func_57E2() || self.var_BA4 == "traverse")
		{
			wait 0.05;
			continue;
		}

		self.var_64C2 = func_4440();
		self.var_672D = func_4440();
		self.var_9D0D = 1;
		self.var_4013 = 1;
		self.var_6481 = undefined;
		if(isdefined(self.var_297D))
		{
			self.var_108 = [[ self.var_297D ]]();
		}
		else if(!maps/mp/agents/humanoid/_humanoid_move::is_passive_exempt() && common_scripts\utility::func_3794("zombie_passive"))
		{
			self.var_108 = "walk";
		}
		else
		{
			self.var_108 = [[ maps/mp/agents/_agent_utility::func_A59("move_mode") ]]();
		}

		self.horzalign = level.var_AC58[self.var_108];
		if(maps/mp/agents/humanoid/_humanoid_util::func_56BC())
		{
			self.horzalign = 100;
			self.var_64C2 = self.var_4013;
		}

		common_scripts\utility::func_A71A(1,"speed_debuffs_changed");
	}
}

//Function Number: 54
func_3219()
{
	self endon("death");
	for(;;)
	{
		self waittill("move_loop",var_00);
		switch(var_00)
		{
			case "fx_blood":
				func_2773("J_MainRoot","gib_bloodpool");
				break;
	
			case "fx_dust":
				func_2773("J_MainRoot","crawl_dust");
				break;
		}
	}
}

//Function Number: 55
func_2773(param_00,param_01)
{
	var_02 = self gettagorigin(param_00);
	var_03 = self gettagangles(param_00);
	playfx(common_scripts\utility::func_44F5(param_01),var_02,anglestoforward(var_03),(0,0,1));
}

//Function Number: 56
func_099B(param_00,param_01)
{
	self.var_1CF1[param_00] = param_01;
}

//Function Number: 57
func_443F(param_00)
{
	if(!isdefined(self.var_1CF1) || !isdefined(self.var_1CF1[param_00]))
	{
		return undefined;
	}

	return self.var_1CF1[param_00];
}

//Function Number: 58
func_A0EC(param_00)
{
	if(!isdefined(param_00.var_1CF2))
	{
		return;
	}

	self [[ param_00.var_1CF2 ]](param_00);
}

//Function Number: 59
removebuffbyname(param_00)
{
	if(!isdefined(self.var_1CF1) || !isdefined(self.var_1CF1[param_00]))
	{
		return;
	}

	func_7CD3(self.var_1CF1[param_00],param_00);
}

//Function Number: 60
func_7CD3(param_00,param_01)
{
	if(!isdefined(param_00.var_1CF0))
	{
		return;
	}

	self [[ param_00.var_1CF0 ]](param_00);
	self.var_1CF1[param_01] = undefined;
}

//Function Number: 61
func_4441()
{
	return 0.1;
}

//Function Number: 62
func_A0EE()
{
	self notify("updateBuffs");
	self endon("updateBuffs");
	self endon("death");
	var_00 = func_4441();
	var_01 = 0;
	for(;;)
	{
		wait(var_00);
		if(!isdefined(self.var_1CF1))
		{
			continue;
		}

		foreach(var_04, var_03 in self.var_1CF1)
		{
			func_A0EC(var_03);
			if(!isdefined(var_03.var_5CC8))
			{
				continue;
			}

			var_03.var_5CC8 = var_03.var_5CC8 - var_00;
			if(var_03.var_5CC8 < 0)
			{
				func_7CD3(var_03,var_04);
			}
		}

		self.var_1CF1 = lib_0547::func_FBF(self.var_1CF1);
	}
}

//Function Number: 63
func_4440()
{
	var_00 = 1;
	if(!isdefined(self.var_1CF1))
	{
		return var_00;
	}

	foreach(var_02 in self.var_1CF1)
	{
		if(!isdefined(var_02.var_90F0))
		{
			continue;
		}

		var_00 = var_00 * var_02.var_90F0;
	}

	return var_00;
}

//Function Number: 64
func_A146()
{
	self notify("updatePainSensor");
	self endon("updatePainSensor");
	self endon("death");
	self.var_6DEA = spawnstruct();
	self.var_6DEA.var_5BC8 = gettime();
	self.var_6DEA.var_2994 = 0;
	var_00 = 0.05;
	var_01 = 5 * var_00;
	for(;;)
	{
		wait(var_00);
		if(gettime() > self.var_6DEA.var_5BC8 + 2000)
		{
			self.var_6DEA.var_2994 = self.var_6DEA.var_2994 - var_01;
		}

		self.var_6DEA.var_2994 = max(self.var_6DEA.var_2994,0);
		if(func_5786())
		{
			self.var_6DEA.var_2994 = 0;
		}
	}
}

//Function Number: 65
func_6ADE(param_00,param_01,param_02)
{
	if(isdefined(self.var_6ADF))
	{
		[[ self.var_6ADF ]](param_00,param_01,param_02);
	}

	if(isdefined(param_02) && param_02 == "dna_aoe_grenade_zombie_mp" || param_02 == "trap_zm_mp")
	{
		return;
	}

	if(isdefined(param_02) && isdefined(level.nopainweapons[param_02]))
	{
		return;
	}

	self.var_6DEA.var_5BC8 = gettime();
	self.var_6DEA.var_2994 = self.var_6DEA.var_2994 + param_00;
}

//Function Number: 66
func_4510()
{
	var_00 = clamp(level.var_A980 / 15,0,1);
	var_01 = lerp(0.1,0.5,1 - var_00);
	return var_01 * self.var_FB;
}

//Function Number: 67
func_8B9C()
{
	if(lib_0547::func_6720())
	{
		return 0;
	}

	if(!isdefined(self.var_6DEA))
	{
		return 1;
	}

	if(self.var_6DEA.var_2994 > func_4510())
	{
		return 1;
	}

	return 0;
}

//Function Number: 68
func_5786()
{
	if(isdefined(self.var_5382) && self.var_5382)
	{
		return 1;
	}

	if(isdefined(self.var_5381) && self.var_5381)
	{
		return 1;
	}

	return 0;
}

//Function Number: 69
func_AC22()
{
	var_00 = [];
	var_01 = lib_0547::func_A51(self.var_A4B);
	var_00["action_table"] = var_01.var_879;
	var_00["dismember_state"] = maps/mp/agents/_scripted_agent_anim_util::func_4156();
	var_00["zombie_subtype"] = self.var_A4B;
	var_00["source_project"] = level.var_87D[0];
	var_00["move_style"] = self.var_648E;
	if(common_scripts\utility::func_3794("zombie_passive") && !common_scripts\utility::func_562E(self.ispassiveexempt))
	{
		var_00["move_speed"] = "passive";
	}
	else
	{
		var_00["move_speed"] = self.var_108;
	}

	return var_00;
}

//Function Number: 70
func_6BD7(param_00,param_01,param_02)
{
	lib_0547::func_6BAA(param_00,param_01,param_02);
	self.var_220D = ::func_6BD0;
	self.var_648E = common_scripts\utility::func_7A33(getarraykeys(level.var_87E["zombie_generic"]["move_style"]));
	lib_0378::func_8D74("onZombieSpawn");
	thread lib_0547::func_4A58();
	var_03 = lib_0547::func_AC4B(self.var_116,"spawn");
	var_03 lib_0547::func_AC48("agent_type",self.var_A4B);
	var_03 lib_0547::func_AC4D();
	if(isdefined(level.var_AC60[self.var_A4B]))
	{
		level.var_AC60[self.var_A4B]++;
	}

	thread func_ABE0();
}

//Function Number: 71
func_ABE0()
{
	var_00 = 0.2;
	self endon("death");
	wait(randomfloat(var_00));
	for(;;)
	{
		function_00F6(self.var_116,"script_zombie_enemy_pos: agent_type %s, angles %v, game_time_ms %d",self.var_A4B,self.var_1D,gettime());
		wait(var_00);
	}
}

//Function Number: 72
func_AC1E()
{
}

//Function Number: 73
zombietesladelayeddmg(param_00,param_01,param_02)
{
	if(common_scripts\utility::func_562E(param_01))
	{
		param_00 = self.var_BC;
	}

	return param_00;
}

//Function Number: 74
func_AC6E()
{
	var_00 = self.var_901F;
	if(common_scripts\utility::func_562E(self.var_6941) && isdefined(level.var_ABDD))
	{
		return level.var_ABDD[level.var_ABDD.size - 1];
	}

	return func_957E(var_00);
}

//Function Number: 75
func_43ED()
{
	return gettime() - self.var_90AB * 0.001;
}

//Function Number: 76
func_4268()
{
	if(isdefined(self.var_3C70))
	{
		return gettime() - self.var_3C70 * 0.001;
	}

	return gettime() - self.var_90AB * 0.001;
}

//Function Number: 77
func_43D2()
{
	var_00 = gettime();
	if(isdefined(level.var_A98C))
	{
		var_00 = var_00 - level.var_A98C;
	}

	return var_00 * 0.001;
}

//Function Number: 78
custom_solo_zombie_sprint_rule()
{
	if(!isdefined(level.custom_solo_zombie_sprint_rule))
	{
		return 1;
	}

	return [[ level.custom_solo_zombie_sprint_rule ]]();
}

//Function Number: 79
func_957E(param_00)
{
	if(!isdefined(level.var_ABDE))
	{
		level.var_ABDE = [0,35,70,100];
		level.var_ABDD = ["walk","run","sprint"];
	}

	if(custom_solo_zombie_sprint_rule() && maps/mp/agents/_agent_utility::func_45BB("zombie_generic") == 1 && func_43D2() > 80)
	{
		self.var_A977 = param_00;
		self.var_A975 = "sprint";
		self.var_6481 = 1;
		return "sprint";
	}

	var_01 = 3;
	if(param_00 > 1)
	{
		var_02 = param_00 - 1;
	}
	else
	{
		var_02 = var_01;
	}

	var_03 = var_02 * var_01;
	if(param_00 < 4)
	{
		var_03 = 1;
	}

	if(!isdefined(self.var_6480))
	{
		self.var_6480 = 1;
	}

	var_04 = 0;
	if(self.var_A4B == "zombie_generic")
	{
		if(isdefined(level.var_64B6))
		{
			var_05 = self [[ level.var_64B6 ]](param_00);
			if(isdefined(var_05))
			{
				self.var_6480 = var_05;
				var_04 = 1;
			}
		}

		if(isdefined(self.var_6A3D))
		{
			self.var_A975 = self.var_6A3D;
			self.var_6A3D = undefined;
			self.var_A977 = param_00;
		}

		if(isdefined(self.var_6A3C))
		{
			self.var_6481 = self.var_6A3C;
			self.var_6A3C = undefined;
		}

		if(isdefined(self.var_6A3F))
		{
			self.var_A978 = self.var_6A3F;
			self.var_6A3F = undefined;
		}
	}

	if(!isdefined(self.var_A975) || self.var_A977 != param_00)
	{
		self.var_A977 = param_00;
		self.var_A978 = randomintrange(var_03,var_03 + 35);
		if(0)
		{
			if(self.var_A978 >= 70)
			{
				self.var_A978 = 69;
			}
		}

		for(var_06 = 0;var_06 < level.var_ABDD.size;var_06++)
		{
			if(self.var_A978 >= level.var_ABDE[var_06])
			{
				self.var_A975 = level.var_ABDD[var_06];
				self.var_A976 = common_scripts\utility::func_5D93(self.var_A978,level.var_ABDE[var_06],level.var_ABDE[var_06 + 1],0,1);
			}
		}
	}

	if(common_scripts\utility::func_562E(var_04))
	{
		var_04 = 0;
		self.var_A978 = self.var_A978 + self.var_6480;
		for(var_06 = 0;var_06 < level.var_ABDD.size;var_06++)
		{
			if(self.var_A978 >= level.var_ABDE[var_06])
			{
				self.var_A975 = level.var_ABDD[var_06];
				self.var_A976 = common_scripts\utility::func_5D93(self.var_A978,level.var_ABDE[var_06],level.var_ABDE[var_06 + 1],0,1);
			}
		}
	}

	if(isdefined(self.var_A976) && self.var_A976 == 1)
	{
		self.var_A976 = self.var_A976 - randomfloatrange(0,0.25);
	}

	self.var_6481 = self.var_A976;
	return self.var_A975;
}

//Function Number: 80
func_ABFD(param_00,param_01,param_02,param_03)
{
	var_04 = getclosestpointonnavmesh(param_00);
	var_05 = (0,1,1);
	if(!lib_0547::func_2436(param_00,var_04,8,64))
	{
		return 0;
	}

	if(!isdefined(getgroundposition(param_00,15,64,16,0)))
	{
		return 0;
	}

	if(isdefined(param_02))
	{
		var_07 = level.var_AC80.var_ACB3[param_02];
		if(!isdefined(var_07.var_74DC))
		{
			return 0;
		}

		var_08 = function_0326(param_00,var_07.var_74DC);
		if(!isdefined(var_08) || var_08.size == 0)
		{
			return 0;
		}

		if(isdefined(param_03) && param_03 == "closet")
		{
			var_09 = undefined;
			var_0A = [];
			var_0B = gettraversalsonpath(param_00,var_07.var_74DC);
			var_0C = isdefined(var_0B) && var_0B.size > 0;
			while(!isdefined(var_09))
			{
				var_0B = gettraversalsonpath(param_00,var_07.var_74DC);
				var_0A = common_scripts\utility::func_F73(var_0A,var_0B);
				foreach(var_0E in var_0B)
				{
					setnavlinkenabled(var_0E,0);
				}

				var_08 = function_0326(param_00,var_07.var_74DC);
				if(!isdefined(var_08) || var_08.size == 0)
				{
					var_09 = 1;
					continue;
				}

				if(!isdefined(var_0B) || var_0B.size == 0)
				{
					var_09 = 0;
				}
			}

			foreach(var_0E in var_0A)
			{
				setnavlinkenabled(var_0E,1);
			}

			if(!var_09)
			{
				self.traversalvalidationfailed = 1;
			}

			if(!var_0C)
			{
				return 0;
			}

			if(!isdefined(self.var_3C5B))
			{
				self.var_3C5B = var_0A[0];
			}
		}
	}

	return 1;
}

//Function Number: 81
func_5D9E(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_02))
	{
		param_02 = (1,1,1);
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}
}

//Function Number: 82
func_AB51()
{
	if(func_56E1())
	{
		return;
	}

	var_00 = 1;
	var_01 = 200;
	self endon("death");
	var_02 = undefined;
	var_03 = 0;
	for(;;)
	{
		self waittill("bad_path",var_04);
		var_05 = gettime() * 0.001;
		if(!common_scripts\utility::func_562E(self.var_57C0) && isdefined(var_02) && var_05 - var_02 < var_00 && !common_scripts\utility::func_562E(self.var_5748))
		{
			var_03++;
		}
		else
		{
			var_03 = 0;
		}

		var_02 = var_05;
		if(var_03 > var_01 && !func_56E1())
		{
			lib_056D::func_5A86();
		}
	}
}

//Function Number: 83
func_56E1()
{
	switch(self.var_A4B)
	{
		case "zombie_guardian":
		case "zombie_bob":
		case "zombie_boss_village":
			return 1;
	}

	if(common_scripts\utility::func_562E(self.var_56E1))
	{
		return 1;
	}

	var_00 = lib_0547::func_A51(self.var_A4B);
	if(isdefined(var_00) && common_scripts\utility::func_562E(var_00.exemptfromfailsafekill))
	{
		return 1;
	}

	return 0;
}

//Function Number: 84
func_63A6()
{
	setomnvar("ui_zm_last_alive_prompt",0);
	for(;;)
	{
		level common_scripts\utility::knock_off_battery("player_bleedout","player_disconnected","player_revived");
		var_00 = 0;
		var_01 = 0;
		foreach(var_03 in level.var_744A)
		{
			if(maps\mp\_utility::func_57A0(var_03))
			{
				var_00++;
			}

			var_01 = var_01 + var_03.var_6881 - var_03.var_178B;
		}

		if(var_00 == 1 && var_01 > 0)
		{
			setomnvar("ui_zm_last_alive_prompt",1);
			continue;
		}

		setomnvar("ui_zm_last_alive_prompt",0);
	}
}

//Function Number: 85
giveplayersexp(param_00,param_01)
{
	while(!isdefined(level.var_744A) || level.var_744A.size == 0)
	{
		wait 0.05;
	}

	if(isdefined(param_01))
	{
		var_02 = [param_01];
	}
	else
	{
		var_02 = level.var_744A;
	}

	foreach(param_01 in var_02)
	{
		param_01 maps\mp\zombies\_zombies_rank::func_AC23(param_00);
		param_01 lib_0378::func_8D74("objective_complete",param_00);
	}
}

//Function Number: 86
handlebrokenspawnervstraversalplacement()
{
	var_00 = self;
	var_00 endon("death");
	wait(10);
	if(!var_00 lib_0547::func_4B2C())
	{
		var_00 lib_0547::func_84CB();
	}
}

//Function Number: 87
handlebadmeleevolumes()
{
	var_00 = getentarray("bad_melee_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread badmeleevolumethink();
	}
}

//Function Number: 88
badmeleevolumethink()
{
	var_00 = self;
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(function_02BF(var_01) && isalive(var_01))
		{
			var_01 thread enteredbadmeleevolume();
		}
	}
}

//Function Number: 89
enteredbadmeleevolume()
{
	var_00 = self;
	var_00 notify("badMeleeVolume");
	var_00 endon("badMeleeVolume");
	var_00 endon("death");
	if(!common_scripts\utility::func_562E(var_00.badmeleevolume))
	{
		var_00.badmeleevolume = 1;
		var_00.nopairmelee = 1;
		var_00 lib_0542::set_invalid_melee_pairing_reason("badMeleeVolume",1);
	}

	wait 0.05;
	waittillframeend;
	var_00.badmeleevolume = undefined;
	var_00.nopairmelee = undefined;
	var_00 lib_0542::set_invalid_melee_pairing_reason("badMeleeVolume",0);
}