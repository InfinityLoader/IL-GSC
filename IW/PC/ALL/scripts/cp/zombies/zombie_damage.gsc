/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\zombie_damage.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 29
 * Decompile Time: 1379 ms
 * Timestamp: 10/27/2023 12:27:04 AM
*******************************************************************/

//Function Number: 1
func_375A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = self;
	if(!func_100AA(param_02,param_01,param_05,param_03))
	{
		return;
	}

	if(param_04 == "MOD_SUICIDE")
	{
		if(isdefined(level.var_C7E9[param_05]))
		{
			level thread [[ level.var_C7E9[param_05] ]](var_0C,param_05);
		}
	}

	var_0D = isdefined(param_04) && param_04 == "MOD_EXPLOSIVE" || param_04 == "MOD_GRENADE_SPLASH" || param_04 == "MOD_PROJECTILE_SPLASH";
	var_0E = isdefined(param_04) && param_04 == "MOD_EXPLOSIVE_BULLET";
	var_0F = isfriendlyfire(self,param_01);
	var_10 = scripts\cp\_utility::func_9BFB();
	var_11 = scripts\cp\_utility::has_zombie_perk("perk_machine_boom");
	var_12 = isdefined(param_01);
	var_13 = var_12 && isdefined(param_01.var_1096F) && param_01.var_1096F == "zombie";
	var_14 = var_12 && isdefined(param_01.var_1096F) && param_01.var_1096F == "zombie_grey";
	var_15 = var_12 && isdefined(param_01.agent_type) && param_01.agent_type == "zombie_brute";
	var_16 = var_12 && param_01 == self;
	var_17 = (var_16 || !var_12) && param_04 == "MOD_SUICIDE";
	if(var_12)
	{
		if(param_01 == self)
		{
			if(issubstr(param_05,"iw7_harpoon2_zm") || issubstr(param_05,"iw7_harpoon1_zm") || issubstr(param_05,"iw7_acid_rain_projectile_zm"))
			{
				param_02 = 0;
			}

			if(issubstr(param_05,"venomx"))
			{
				param_02 = 0;
			}

			if(var_0D)
			{
				var_18 = self getstance();
				if(var_11)
				{
					param_02 = 0;
				}
				else if(isdefined(self.has_fortified_passive) && self.has_fortified_passive && self method_81BE() || (var_18 == "crouch" || var_18 == "prone") && self isonground())
				{
					param_02 = 0;
				}
				else
				{
					param_02 = func_79A8(param_00,param_01,param_02,param_03,param_04,param_05);
				}
			}

			switch(param_05)
			{
				case "zmb_fireworksprojectile_mp":
				case "zmb_imsprojectile_mp":
				case "iw7_armageddonmeteor_mp":
					param_02 = 0;
					break;

				case "iw7_stunbolt_zm":
				case "iw7_bluebolts_zm":
				case "blackhole_grenade_zm":
				case "blackhole_grenade_mp":
					param_02 = 25;
					break;

				default:
					break;
			}
		}
		else if(var_0F)
		{
			if(var_10)
			{
				if(scripts\cp\_utility::func_9CA6())
				{
					if(isplayer(param_01) && isdefined(param_08) && param_08 != "shield")
					{
						if(isdefined(param_00))
						{
							param_01 dodamage(param_02,param_01.origin - (0,0,50),param_01,param_00,param_04);
						}
						else
						{
							param_01 dodamage(param_02,param_01.origin,param_01);
						}
					}

					param_02 = 0;
				}
			}
			else
			{
				param_02 = 0;
			}
		}
		else if(var_13)
		{
			if(param_04 != "MOD_EXPLOSIVE" && var_0C scripts\cp\_utility::func_9BA0("burned_out"))
			{
				if(!scripts\common\utility::istrue(param_01.var_9B81))
				{
					var_0C scripts\cp\_utility::func_C151("burned_out");
					param_01 thread scripts\cp\_utility::func_4D0D(param_01,var_0C,3,int(param_01.maxhealth + 1000),param_04,"incendiary_ammo_mp",undefined,"burning");
					param_01.faf_burned_out = 1;
				}
			}

			var_19 = gettime();
			if(!isdefined(self.var_A92D) || var_19 - self.var_A92D > 20)
			{
				self.var_A92D = var_19;
			}
			else
			{
				return;
			}

			var_1A = 500;
			if(getdvarint("zom_damage_shield_duration") != 0)
			{
				var_1A = getdvarint("zom_damage_shield_duration");
			}

			if(isdefined(param_01.var_A8A2[self.var_134FD]))
			{
				var_1B = param_01.var_A8A2[self.var_134FD];
				if(var_1B + var_1A > gettime())
				{
					param_02 = 0;
				}
				else
				{
					param_01.var_A8A2[self.var_134FD] = gettime();
				}
			}
			else
			{
				param_01.var_A8A2[self.var_134FD] = gettime();
			}
		}
		else if(var_14)
		{
			param_02 = func_791A(param_00,param_01,param_02,param_03,param_04,param_05);
		}

		if(var_0E)
		{
			var_18 = self getstance();
			if(var_11)
			{
				param_02 = 0;
			}
			else if(isdefined(self.has_fortified_passive) && self.has_fortified_passive && self method_81BE() || (var_18 == "crouch" || var_18 == "prone") && self isonground())
			{
				param_02 = 0;
			}
			else if(!var_10 || param_01 == self && param_08 == "none")
			{
				param_02 = 0;
			}
		}
	}
	else if(var_11 && param_04 == "MOD_SUICIDE")
	{
		if(param_05 == "frag_grenade_zm" || param_05 == "cluster_grenade_zm")
		{
			param_02 = 0;
		}
	}
	else
	{
		var_18 = self getstance();
		if(isdefined(self.has_fortified_passive) && self.has_fortified_passive && self method_81BE() || (var_18 == "crouch" || var_18 == "prone") && self isonground())
		{
			if(param_05 == "frag_grenade_zm" || param_05 == "cluster_grenade_zm")
			{
				param_02 = 0;
			}
		}
	}

	if(param_04 == "MOD_FALLING")
	{
		if(scripts\cp\_utility::_hasperk("specialty_falldamage"))
		{
			param_02 = 0;
		}
		else if(param_02 > 10)
		{
			if(param_02 > self.health * 0.15)
			{
				param_02 = int(self.health * 0.15);
			}
		}
		else
		{
			param_02 = 0;
		}
	}

	var_1C = 0;
	if(var_12 && param_01 scripts\cp\_utility::func_9D20() && scripts\common\utility::istrue(self.var_AD2D))
	{
		if(self.health - param_02 < 1)
		{
			param_02 = self.health - 1;
		}
	}

	if(var_13 || var_14 || var_15 || var_16 && !var_17)
	{
		param_02 = int(param_02 * var_0C scripts\cp\_utility::func_7E5C());
	}

	if(isdefined(self.var_AD2C))
	{
		param_02 = int(max(self.maxhealth / 2.75,param_02));
	}

	if(var_0C scripts\cp\_utility::func_9BA0("secret_service") && isalive(param_01))
	{
		var_1D = !isdefined(param_01.agent_type) || var_13 || !var_14 || !var_15 || scripts\common\utility::istrue(param_01.var_9CDD) || !scripts\common\utility::istrue(param_01.entered_playspace);
		var_1E = isdefined(param_01.agent_type) && var_13 && !var_14 || !var_15 || scripts\common\utility::istrue(param_01.var_9CDD) || !scripts\common\utility::istrue(param_01.entered_playspace);
		var_1E = 0;
		if(isdefined(param_01.agent_type) && param_01.agent_type != "generic_zombie" || !scripts\common\utility::istrue(param_01.entered_playspace))
		{
			var_1E = 0;
		}
		else if(param_01 scripts\cp\_utility::agentisfnfimmune())
		{
			var_1E = 0;
		}
		else if(isplayer(var_0C) && isplayer(param_01))
		{
			var_1E = 0;
		}
		else
		{
			var_1E = 1;
		}

		if(var_1E)
		{
			param_01 thread scripts\cp\zombies\craftables\_revocator::func_1299C(var_0C);
			var_0C scripts\cp\_utility::func_C151("secret_service");
		}
	}

	param_02 = int(param_02);
	if(!var_0F || var_10)
	{
		func_6CE1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_1C,param_0A,param_0B);
		self notify("player_damaged");
	}

	lib_0A54::func_12E04("personal","damage_taken",param_02);
	if(param_02 <= 0)
	{
		return;
	}

	thread scripts\cp\_utility::func_D222(param_01);
	thread func_CDBE(self);
	self playlocalsound("zmb_player_impact_hit");
	thread scripts\cp\_utility::func_D220();
	if(isdefined(param_01))
	{
		thread scripts\cp\_hud_util::func_13F0C();
		if(isagent(param_01))
		{
			if(!isdefined(param_01.var_4CE9))
			{
				param_01.var_4CE9 = 0;
			}
			else
			{
				param_01.var_4CE9 = param_01.var_4CE9 + param_02;
			}

			self.var_DDB9 = param_01;
			if(isdefined(level.var_4B4A))
			{
				self [[ level.custom_playerdamage_challenge_func ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
				return;
			}
		}
	}
}

//Function Number: 2
delete_entities_on_death()
{
	self notify("one_deletethread_instance_" + self.name);
	self endon("one_deletethread_instance_" + self.name);
	scripts\common\utility::waittill_any_3("death","disconnect");
	if(isdefined(self))
	{
		if(isdefined(self.scrnfx_obj))
		{
			self.scrnfx_obj delete();
		}
	}
}

//Function Number: 3
func_CDBE(param_00)
{
	param_00 notify("play_pain_photo");
	param_00 endon("disconnect");
	param_00 endon("last_stand");
	param_00 endon("play_pain_photo");
	if(scripts\cp\_laststand::player_in_laststand(param_00))
	{
		return;
	}

	lib_0D5B::func_F53F(param_00,"damaged");
	wait(4);
	lib_0D5B::func_F53F(param_00,"healthy");
}

//Function Number: 4
func_50F9(param_00)
{
	self endon("death");
	param_00 endon("death");
	wait(0.05);
	self dodamage(2,self.origin,param_00,undefined,"MOD_MELEE");
}

//Function Number: 5
func_79A8(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_05))
	{
		return param_02;
	}

	var_06 = getweaponbasename(param_05);
	if(!isdefined(var_06))
	{
		return param_02;
	}

	switch(var_06)
	{
		case "iw7_chargeshot_zm":
		case "throwingknifec4_mp":
		case "semtex_zm":
		case "frag_grenade_zm":
			var_07 = param_02 / 1200;
			param_02 = var_07 * 100;
			break;

		case "iw7_blackholegun_mp":
		case "c4_zm":
			var_07 = param_02 / 2000;
			param_02 = var_07 * 100;
			break;

		case "iw7_glprox_zm":
		case "cluster_grenade_zm":
			var_07 = param_02 / 800;
			param_02 = var_07 * 100;
			break;

		case "iw7_g18_zml":
		case "iw7_g18_zm":
		case "iw7_g18_zmr":
			if(scripts\cp\_weapon::func_7D62(var_06) <= 2)
			{
				var_07 = param_02 / 1800;
				param_02 = var_07 * 100;
				break;
			}
			else
			{
				param_02 = 0;
			}
			break;

		case "iw7_armageddonmeteor_mp":
			param_02 = 0;
			break;

		case "iw7_stunbolt_zm":
		case "iw7_bluebolts_zm":
			param_02 = param_02 * 0.33;
			param_02 = min(80,param_02);
			break;

		case "iw7_shredderdummy_zm":
		case "iw7_facemelterdummy_zm":
		case "iw7_dischorddummy_zm":
		case "iw7_headcutterdummy_zm":
		case "iw7_headcutter3_zm":
		case "iw7_headcutter2_zm":
		case "iw7_headcutter_zm_pap1":
		case "iw7_headcutter_zm":
		case "iw7_facemelter_zm_pap1":
		case "iw7_facemelter_zm":
		case "iw7_dischord_zm_pap1":
		case "iw7_dischord_zm":
		case "iw7_shredder_zm_pap1":
		case "iw7_shredder_zm":
			param_02 = 0;
			break;

		case "iw7_headcuttershards_mp":
			param_02 = 0;
			break;

		case "splash_grenade_zm":
		case "splash_grenade_mp":
			param_02 = min(10,param_02);
			break;

		default:
			break;
	}

	return min(80,param_02);
}

//Function Number: 6
func_791A(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_04))
	{
		switch(param_04)
		{
			case "MOD_EXPLOSIVE":
				return param_02;

			case "MOD_PROJECTILE_SPLASH":
			case "MOD_PROJECTILE":
				return min(80,param_02);

			case "MOD_UNKNOWN":
				return param_02;

			default:
				return param_02;
		}
	}

	return param_02;
}

//Function Number: 7
func_100B8(param_00)
{
	var_01 = 20;
	if(param_00 == 0)
	{
		return 0;
	}

	return self.var_8C4C && param_00 > self.health && param_00 < self.health + var_01;
}

//Function Number: 8
func_13119(param_00)
{
	var_01 = 0.2;
	var_02 = self.maxhealth * var_01;
	return scripts\cp\_utility::func_9FC6() && param_00 > self.health || self.health - param_00 <= var_02;
}

//Function Number: 9
func_1109B()
{
	self notify("stop_using_remote");
}

//Function Number: 10
func_1309B(param_00)
{
	self.health = param_00 + 1;
	self.var_8C4C = 0;
}

//Function Number: 11
func_100AA(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(level.disableplayerdamage))
	{
		return 0;
	}

	if((isdefined(param_02) && issubstr(param_02,"venomx") || param_02 == "zmb_imsprojectile_mp" || param_02 == "zmb_fireworksprojectile_mp") || param_02 == "sentry_minigun_mp" || param_02 == "zmb_robotprojectile_mp" || param_02 == "iw7_electrictrap_zm")
	{
		return 0;
	}

	if(isdefined(param_02) && param_02 == "bolasprayprojhome_mp")
	{
		return 0;
	}

	if(isdefined(param_03) && param_03 == 256 || param_03 == 258)
	{
		return 0;
	}

	if(isdefined(self.inlaststand) && self.inlaststand)
	{
		return 0;
	}

	if(gettime() < self.var_4D69)
	{
		return 0;
	}

	if(isdefined(self.ability_invulnerable))
	{
		return 0;
	}

	if(isdefined(param_01) && isdefined(param_01.is_neil))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_9C54))
	{
		return 0;
	}

	if(isdefined(self.var_9BE1))
	{
		return 0;
	}

	if(isdefined(self.var_AD2B))
	{
		return 0;
	}

	return 1;
}

//Function Number: 12
func_F29B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_01))
	{
		if(param_01 == "xm25_mp" && param_00 == "MOD_IMPACT")
		{
			param_02 = 95;
		}

		if(param_01 == "spider_beam_mp")
		{
			param_02 = param_02 * 15;
		}

		if(param_01 == "alienthrowingknife_mp" && param_00 == "MOD_IMPACT")
		{
			if(scripts\cp\_damage::func_381F(param_03,0,param_04,param_00,param_01,param_05,param_06,param_07,param_08,param_09))
			{
				param_02 = 20000;
			}
			else if(scripts\cp\_agent_utils::func_77D7(self) != "elite")
			{
				param_02 = 500;
			}
		}
	}

	return param_02;
}

//Function Number: 13
func_12DA8(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_01) && isdefined(param_01.var_222))
	{
		scripts\cp\_agent_utils::func_110A4(param_01.var_222,param_02 * 0.75);
	}
	else if(isdefined(param_01) && isdefined(param_01.var_CA80) && param_01.var_CA80 == 1)
	{
		scripts\cp\_agent_utils::func_110A4(param_01.var_222,param_02);
	}
	else
	{
		scripts\cp\_agent_utils::func_110A4(param_01,param_02);
	}

	if(isdefined(param_01) && isdefined(param_05))
	{
		level thread func_12E52(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,self);
	}

	func_12D87(param_01,param_02,param_04);
}

//Function Number: 14
func_12E52(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(scripts\common\utility::istrue(self.var_54CB))
	{
		return;
	}

	if(!isdefined(level.var_4B4A))
	{
		return;
	}

	if(isdefined(param_01) && isplayer(param_01))
	{
		var_0B = self [[ level.var_4C44 ]](param_00,param_01,param_02,param_04,param_05,param_07,param_08,param_09,param_0A);
		if(!scripts\common\utility::istrue(var_0B))
		{
			return;
		}
	}
}

//Function Number: 15
func_12D87(param_00,param_01,param_02)
{
	if(isdefined(level.var_12D87))
	{
		[[ level.var_12D87 ]](param_00,param_01,param_02);
		return;
	}

	func_12E01(param_00,param_01,param_02);
}

//Function Number: 16
func_12E01(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(param_00.classname) && param_00.classname == "script_vehicle")
	{
		return;
	}

	if(param_02 == "MOD_TRIGGER_HURT")
	{
		return;
	}

	lib_0A54::func_12E38(lib_0A54::func_7CE6(),"damage_done_on_alien",param_01);
	if(isplayer(param_00))
	{
		param_00 lib_0A54::func_12E04("personal","damage_done_on_alien",param_01);
		return;
	}

	if(isdefined(param_00.var_222))
	{
		param_00.var_222 lib_0A54::func_12E04("personal","damage_done_on_alien",param_01);
	}
}

//Function Number: 17
func_2189(param_00,param_01,param_02)
{
	return 1;
}

//Function Number: 18
func_11193(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(self.var_11192))
	{
		return 0;
	}

	var_07 = gettime();
	if(isdefined(self.var_A918) && !isdefined(param_05))
	{
		if(var_07 < self.var_A918)
		{
			return;
		}
	}

	self.var_A918 = var_07 + 500;
	var_08 = 0;
	var_09 = 0;
	var_0A = 4;
	if(!isdefined(param_04))
	{
		param_04 = 256;
	}

	var_0B = scripts\cp\_agent_utils::func_7DB0("axis");
	var_0C = scripts\common\utility::func_782F(param_01.origin,var_0B,undefined,var_0A,param_04,1);
	if(scripts\common\utility::func_2286(var_0C,param_01))
	{
		var_0C = scripts\common\utility::func_22A9(var_0C,param_01);
	}

	if(var_0C.size >= 1)
	{
		if(!isdefined(self.var_11192))
		{
			self.var_11192 = spawnstruct();
		}

		if(scripts\common\utility::istrue(param_05))
		{
			param_02 = int(param_02);
		}
		else
		{
			param_02 = int(param_02 * 0.5);
		}

		var_0D = ["j_crotch","j_hip_le","j_hip_ri"];
		if(issubstr(param_01.agent_type,"alien"))
		{
			param_00 = param_01 gettagorigin("j_spine4");
		}
		else
		{
			param_00 = param_01 gettagorigin(scripts\common\utility::random(var_0D));
		}

		foreach(var_0F in var_0C)
		{
			if(isdefined(var_0F) && var_0F != param_01 && isalive(var_0F) && !scripts\common\utility::istrue(var_0F.var_11196))
			{
				var_08 = 1;
				if(scripts\common\utility::istrue(param_05))
				{
					var_0F.shockmelee = 1;
				}

				var_0F func_1118C(self,param_02,param_03,param_00);
				var_09++;
				if(var_09 >= var_0A)
				{
					break;
				}
			}
		}

		wait(0.05);
		self.var_11192 = undefined;
	}

	if(scripts\common\utility::istrue(param_05))
	{
		scripts\cp\_utility::func_C151("shock_melee_upgrade");
		param_01.shockmelee = 1;
	}

	if(isdefined(param_06))
	{
		self notify(param_06);
	}

	return var_08;
}

//Function Number: 19
func_1118C(param_00,param_01,param_02,param_03)
{
	self endon("death");
	scripts\common\utility::func_136F7();
	var_04 = undefined;
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}

	var_05 = ["j_crotch","j_hip_le","j_hip_ri","j_shoulder_le","j_shoulder_ri","j_chest"];
	if(issubstr(self.agent_type,"alien"))
	{
		var_04 = self gettagorigin("j_spine4");
	}
	else
	{
		var_04 = self gettagorigin(scripts\common\utility::random(var_05));
	}

	if(isdefined(var_04))
	{
		function_02E0(level._effect["blue_ark_beam"],param_03,vectortoangles(param_03 - var_04),var_04);
		wait(0.05);
		if(isdefined(self) && param_02 == "MOD_MELEE")
		{
			self playsound("zombie_fence_shock");
		}

		wait(0.05);
		var_06 = int(param_01);
		scripts\common\fx::func_D484(level._effect["stun_shock"],var_04);
		if(isdefined(self))
		{
			thread func_1118E(param_00,param_02,var_06,"stun_ammo_mp");
		}
	}
}

//Function Number: 20
func_1118E(param_00,param_01,param_02,param_03)
{
	self endon("death");
	if(isdefined(param_02))
	{
		var_04 = param_02;
	}
	else
	{
		var_04 = 100;
	}

	if(isdefined(param_03))
	{
		var_05 = param_03;
	}
	else
	{
		var_05 = "iw7_stunbolt_zm";
	}

	if(!lib_0C75::func_9F87())
	{
		self.var_11196 = 1;
		thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
		self.var_11190 = gettime() + 1500;
	}

	thread func_E093(1);
	if(isdefined(param_00))
	{
		self dodamage(var_04,self.origin,param_00,param_00,param_01,var_05);
		return;
	}

	self dodamage(var_04,self.origin,undefined,undefined,param_01,var_05);
}

//Function Number: 21
func_E093(param_00)
{
	self endon("death");
	wait(param_00);
	if(!scripts\cp\_utility::func_FF18(self))
	{
		return;
	}

	self.var_11196 = undefined;
}

//Function Number: 22
func_B9C6(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	level endon("game_ended");
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	self setcandamage(1);
	self.health = 999999;
	self.maxhealth = param_00;
	self.var_E1 = 0;
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	for(var_06 = 1;var_06;var_06 = func_B9C7(var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10,param_01,param_02,param_03,param_04))
	{
		self waittill("damage",var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10);
		if(param_05)
		{
			self playrumbleonentity("damage_light");
		}

		if(isdefined(self.var_8DD9) && self.var_8DD9 == "littlebird")
		{
			if(!isdefined(self.var_2507))
			{
				self.var_2507 = [];
			}

			var_11 = "";
			if(isdefined(var_08) && isplayer(var_08))
			{
				var_11 = var_08 scripts\cp\_utility::func_81EC();
			}

			if(isdefined(self.var_2507[var_11]))
			{
				self.var_2507[var_11] = self.var_2507[var_11] + var_07;
			}
			else
			{
				self.var_2507[var_11] = var_07;
			}
		}
	}
}

//Function Number: 23
func_B9C7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(isdefined(param_01) && !scripts\cp\_utility::func_9E0E(param_01) && !isdefined(param_01.var_1C9F))
	{
		return 1;
	}

	return 1;
}

//Function Number: 24
isfriendlyfire(param_00,param_01)
{
	if(!level.teambased)
	{
		return 0;
	}

	if(!isdefined(param_01))
	{
		return 0;
	}

	if(!isplayer(param_01) && !isdefined(param_01.team))
	{
		return 0;
	}

	if(param_00.team != param_01.team)
	{
		return 0;
	}

	if(param_00 == param_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 25
func_6CE1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	if(!func_374A(param_00,param_01,param_02 - param_02 * param_0A,param_03,param_04,param_05,param_06,param_07,param_08,param_09))
	{
		return;
	}

	if(!isalive(self))
	{
		return;
	}

	if(isplayer(self))
	{
		self method_80EA(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
	}

	func_4D67(param_00,param_05,param_04,param_02,param_03,param_01);
}

//Function Number: 26
func_374A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(self.var_A970) && self.var_A970 && param_02 >= self.health && isdefined(self.var_4402) && self.var_4402 == "specialty_endgame")
	{
		scripts\cp\_utility::func_8387("specialty_endgame");
		return 0;
	}

	return 1;
}

//Function Number: 27
func_4D67(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread func_C5CB(param_00,param_01,param_02,param_03,param_05);
	if(!isai(self))
	{
		self playrumbleonentity("damage_heavy");
	}
}

//Function Number: 28
func_C5CB(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	self endon("disconnect");
	switch(param_01)
	{
		default:
			if(func_1CA7(param_01) && !isai(param_04))
			{
				scripts\cp\_weapon::func_FC6A(param_02,param_03);
			}
			break;
	}
}

//Function Number: 29
func_1CA7(param_00)
{
	if(isdefined(param_00))
	{
		switch(param_00)
		{
			case "iw7_zapper_grey":
				return 0;
		}
	}

	return 1;
}