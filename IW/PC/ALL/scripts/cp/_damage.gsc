/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\_damage.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 1302 ms
 * Timestamp: 10/27/2023 12:23:31 AM
*******************************************************************/

//Function Number: 1
func_12E84(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(level.var_73A6) && [[ level.var_73A6 ]](param_04,param_05,param_06))
	{
		return;
	}

	if(!isplayer(self))
	{
		return;
	}

	var_07 = "standard_cp";
	var_08 = undefined;
	if(isdefined(param_01) && param_01)
	{
		self playlocalsound("cp_hit_alert_strong");
	}
	else if(scripts\common\utility::istrue(self.deadeye_charge))
	{
		self playlocalsound("cp_hit_alert_perk");
	}
	else
	{
		self playlocalsound("cp_hit_alert");
	}

	switch(param_00)
	{
		case "hitalienarmor":
			self setclientomnvar("damage_feedback_icon",param_00);
			self setclientomnvar("damage_feedback_icon_notify",gettime());
			param_03 = 1;
			break;

		case "hitcritical":
		case "hitaliensoft":
			var_08 = 1;
			break;

		case "stun":
		case "meleestun":
			if(!isdefined(self.var_B649))
			{
				self playlocalsound("crate_impact");
				self.var_B649 = 1;
			}
	
			self setclientomnvar("damage_feedback_icon","hitcritical");
			self setclientomnvar("damage_feedback_icon_notify",gettime());
			wait(0.2);
			self.var_B649 = undefined;
			break;

		case "high_damage":
			var_07 = "high_damage_cp";
			break;

		case "special_weapon":
			var_07 = "wor_weapon_cp";
			break;

		case "card_boosted":
			var_07 = "fnf_card_damage_cp";
			break;

		case "red_arcane_cp":
			var_07 = "red_arcane_cp";
			break;

		case "blue_arcane_cp":
			var_07 = "blue_arcane_cp";
			break;

		case "yellow_arcane_cp":
			var_07 = "yellow_arcane_cp";
			break;

		case "green_arcane_cp":
			var_07 = "green_arcane_cp";
			break;

		case "pink_arcane_cp":
			var_07 = "pink_arcane_cp";
			break;

		case "dewdrops_cp":
			var_07 = "dewdrops_cp";
			break;

		case "none":
			break;

		default:
			break;
	}

	func_12EA8(var_07,var_08,param_02,param_03,param_01);
}

//Function Number: 2
onplayertouchkilltrigger(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(level.var_7669 == 1)
	{
		return;
	}

	if(func_A624())
	{
		return;
	}

	func_F446(self,1);
	scripts\cp\_laststand::func_373E(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,scripts\cp\_globallogic::func_7F56());
}

//Function Number: 3
func_A624()
{
	return scripts\common\utility::istrue(self.var_A623);
}

//Function Number: 4
func_F446(param_00,param_01)
{
	self.var_A623 = param_01;
}

//Function Number: 5
func_12EA8(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	self setclientomnvar("damage_scale_type","standard");
	if(param_04)
	{
		self setclientomnvar("damage_feedback_kill",1);
	}
	else
	{
		self setclientomnvar("damage_feedback_kill",0);
	}

	if(param_03)
	{
		self setclientomnvar("damage_scale_type","hitalienarmor");
	}

	if(param_01)
	{
		self setclientomnvar("damage_scale_type","hitaliensoft");
		self setclientomnvar("damage_feedback_headshot",1);
	}
	else
	{
		self setclientomnvar("damage_feedback_headshot",0);
	}

	if(isdefined(param_02))
	{
		self setclientomnvar("ui_damage_amount",int(param_02));
	}

	self setclientomnvar("damage_feedback",param_00);
	self setclientomnvar("damage_feedback_notify",gettime());
}

//Function Number: 6
func_1118C(param_00,param_01,param_02)
{
	scripts\common\utility::func_136F7();
	playfxontag(level._effect["stun_attack"],param_00.var_11192.var_24B2,"TAG_ORIGIN");
	playfxontag(level._effect["stun_shock"],param_00.var_11192.var_24B2,"TAG_ORIGIN");
	var_03 = undefined;
	if(isdefined(self.agent_type) && scripts\cp\_agent_utils::func_77D7(self) == "seeder_spore")
	{
		var_03 = self gettagorigin("J_Spore_46");
	}
	else if(isdefined(self) && isalive(self) && scripts\cp\_utility::func_8BB1(self.model,"J_SpineUpper"))
	{
		var_03 = self gettagorigin("J_SpineUpper");
	}

	if(isdefined(var_03))
	{
		param_00.var_11192.var_24B2 moveto(var_03,0.05);
		wait(0.05);
		if(isdefined(self) && param_02 == "MOD_MELEE")
		{
			self playsound("trap_electric_shock");
		}

		wait(0.05);
		var_04 = int(param_01 / 2);
		if(isdefined(self))
		{
			var_05 = self;
			if(isdefined(self.agent_type) && scripts\cp\_agent_utils::func_77D7(self) == "seeder_spore")
			{
				var_05 = self.var_4353;
			}

			if(isdefined(var_05))
			{
				var_05 dodamage(var_04,self.origin,param_00,param_00.var_11192.var_24B2,param_02);
			}
		}
	}

	stopfxontag(level._effect["stun_attack"],param_00.var_11192.var_24B2,"TAG_ORIGIN");
}

//Function Number: 7
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
			if(func_381F(param_03,0,param_04,param_00,param_01,param_05,param_06,param_07,param_08,param_09))
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

//Function Number: 8
func_381F(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(self.var_38E0) && self.var_38E0)
	{
		return 0;
	}

	switch(self.agent_type)
	{
		case "seeder":
		case "locust":
		case "spitter":
		case "brute":
		case "goon4":
		case "goon3":
		case "goon2":
		case "goon":
			return 1;

		case "elite":
			if(param_00 scripts\cp\_utility::func_9CF3("hypno_rhino_upgrade") || param_01)
			{
				return 1;
			}
	
			break;

		default:
			return 0;
	}
}

//Function Number: 9
func_EB9D(param_00,param_01,param_02,param_03)
{
	var_04 = 1.05;
	if(scripts\common\utility::func_9D74(param_02) && !func_9D39(param_03) && !func_9DB8(param_03))
	{
		if(!func_9D39(param_03))
		{
			param_01 = int(param_01 * param_00 lib_0CFC::func_CA32());
		}
		else if(func_9D38(param_03))
		{
			param_01 = int(param_01 * param_00 lib_0CFC::func_CA43());
		}

		if(isdefined(param_00.var_1517))
		{
			param_01 = int(param_01 * param_00.var_1517);
		}
	}

	if(param_02 == "MOD_EXPLOSIVE")
	{
		param_01 = int(param_01 * param_00 lib_0CFC::func_CA36());
	}

	if(param_02 == "MOD_MELEE")
	{
		if(func_FF75(param_00))
		{
			playfxontag(level._effect["melee_blood"],param_00,"tag_weapon_right");
		}

		param_01 = int(param_01 * param_00 lib_0CFC::func_CA3A());
		if(isdefined(param_00.var_1518))
		{
			param_01 = int(param_01 * param_00.var_1518);
		}
	}

	if(param_00 scripts\cp\_utility::func_9CF3("damage_booster_upgrade"))
	{
		param_01 = int(param_01 * var_04);
	}

	return param_01;
}

//Function Number: 10
func_FF75(param_00)
{
	if(isdefined(level.var_FF76))
	{
		return [[ level.var_FF76 ]](param_00);
	}

	return 1;
}

//Function Number: 11
func_9D39(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "ball_drone_gun_mp":
		case "turret_minigun_alien_shock":
		case "alientank_rigger_turret_mp":
		case "alientank_turret_mp":
		case "turret_minigun_alien_grenade":
		case "turret_minigun_alien_railgun":
		case "turret_minigun_alien":
		case "alien_manned_minigun_turret4_mp":
		case "alien_manned_minigun_turret3_mp":
		case "alien_manned_minigun_turret2_mp":
		case "alien_manned_minigun_turret1_mp":
		case "alien_manned_minigun_turret_mp":
		case "alien_manned_gl_turret4_mp":
		case "alien_manned_gl_turret3_mp":
		case "alien_manned_gl_turret2_mp":
		case "alien_manned_gl_turret1_mp":
		case "alien_manned_gl_turret_mp":
		case "sentry_minigun_mp":
		case "alien_sentry_minigun_4_mp":
		case "alien_sentry_minigun_3_mp":
		case "alien_sentry_minigun_2_mp":
		case "alien_sentry_minigun_1_mp":
		case "alienvulture_mp":
		case "alien_ball_drone_gun4_mp":
		case "alien_ball_drone_gun3_mp":
		case "alien_ball_drone_gun2_mp":
		case "alien_ball_drone_gun1_mp":
		case "alien_ball_drone_gun_mp":
			return 1;

		default:
			return 0;
	}

	return 0;
}

//Function Number: 12
func_9DB8(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "iw6_alienminigun4_mp":
		case "iw6_alienminigun3_mp":
		case "iw6_alienminigun2_mp":
		case "iw6_alienminigun1_mp":
		case "iw6_alienminigun_mp":
			return 1;

		default:
			return 0;
	}

	return 0;
}

//Function Number: 13
func_9D38(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "alientank_rigger_turret_mp":
		case "alientank_turret_mp":
		case "turret_minigun_alien_grenade":
		case "turret_minigun_alien_railgun":
		case "turret_minigun_alien":
			return 1;

		default:
			return 0;
	}

	return 0;
}

//Function Number: 14
func_EB9F(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04) && param_04 != "none")
	{
		param_01 = func_3D84(self,param_01,param_00,param_03,param_02);
	}

	if(isdefined(param_02) && param_02 == "MOD_EXPLOSIVE_BULLET" && param_04 != "none")
	{
		if(scripts\cp\_utility::func_4626(param_03) == "weapon_shotgun")
		{
			param_01 = param_01 + int(param_01 * level.var_FEFD);
		}
		else
		{
			param_01 = param_01 + int(param_01 * level.var_69D8);
		}
	}

	return param_01;
}

//Function Number: 15
func_EB9E(param_00,param_01)
{
	if(isplayer(param_00))
	{
		var_02 = param_00 lib_0CFF::func_D880();
		param_01 = param_01 * var_02;
		param_01 = int(param_01);
	}

	return param_01;
}

//Function Number: 16
func_3D84(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 500;
	if(!isdefined(param_00) || !scripts\cp\_utility::func_9F19(param_00))
	{
		return param_01;
	}

	if(!isdefined(param_02) || !isplayer(param_02) || param_04 != "MOD_EXPLOSIVE_BULLET")
	{
		return param_01;
	}

	if(scripts\cp\_utility::func_4626(param_03) == "weapon_shotgun")
	{
		var_06 = distance(param_02.origin,param_00.origin);
		var_07 = max(1,var_06 / var_05);
		var_08 = param_01 * 8;
		var_09 = var_08 * var_07;
		if(var_06 > var_05)
		{
			return param_01;
		}

		return int(var_09);
	}

	return var_05;
}

//Function Number: 17
func_3D9D(param_00,param_01,param_02)
{
	if(param_02 == "MOD_MELEE" && function_024C(param_01) != "riotshield")
	{
		return;
	}

	if(isdefined(param_01) && param_01 == "alienims_projectile_mp")
	{
		return;
	}

	if(!isdefined(param_00.var_9B81) && isalive(param_00))
	{
		if((scripts\cp\_utility::func_D0C6(self,"incendiary_ammo") || scripts\cp\_utility::func_D0C6(self,"combined_ammo")) && param_02 != "MOD_UNKNOWN")
		{
			param_00 thread func_3B23(self,undefined,undefined,1);
		}
		else if(param_01 == "iw5_alienriotshield4_mp" && self.var_6D82 == 1)
		{
			param_00 thread func_3B23(self);
		}
		else if((scripts\common\utility::istrue(self.var_8B86) || scripts\common\utility::istrue(self.var_8BAC)) && param_02 != "MOD_UNKNOWN")
		{
			param_00 thread func_3B23(self,undefined,undefined,1);
		}

		switch(param_01)
		{
			case "iw6_alienmk323_mp":
			case "iw6_alienmk324_mp":
			case "iw6_alienminigun4_mp":
			case "iw6_alienminigun3_mp":
			case "alien_manned_gl_turret4_mp":
			case "alienvulture_mp":
				param_00 thread func_3B23(self);
				break;
		}

		return;
	}

	var_03 = scripts\cp\_utility::func_80D8(param_01);
	if(isdefined(self.var_10935) && isdefined(self.var_10935[var_03]) && self.var_10935[var_03] > 0)
	{
	}
}

//Function Number: 18
func_3B23(param_00,param_01,param_02,param_03)
{
	self endon("death");
	func_1B6A();
	func_4CDC(param_00,param_01,param_02,param_03);
	func_1B69();
}

//Function Number: 19
func_4CDC(param_00,param_01,param_02,param_03)
{
	self endon("death");
	if(!isdefined(param_01) && !isdefined(param_02))
	{
		var_04 = scripts\cp\_agent_utils::func_77D7(self);
		switch(var_04)
		{
			case "goon4":
			case "goon3":
			case "goon2":
			case "goon":
				param_02 = 75;
				param_01 = 3;
				break;

			case "brute4":
			case "brute3":
			case "brute2":
			case "brute":
				param_02 = 100;
				param_01 = 4;
				break;

			case "spitter":
				param_02 = 133;
				param_01 = 4;
				break;

			case "elite_boss":
			case "elite":
				param_02 = 500;
				param_01 = 4;
				break;

			case "minion":
				param_02 = 100;
				param_01 = 2;
				break;

			default:
				param_02 = self.maxhealth * 0.5;
				param_01 = 3;
				break;
		}
	}
	else
	{
		if(!isdefined(param_02))
		{
			param_02 = 150;
		}

		if(!isdefined(param_01))
		{
			param_01 = 3;
		}
	}

	if(isdefined(param_00) && isdefined(param_03) && param_00 scripts\cp\_utility::func_9CF3("incendiary_ammo_upgrade") && isdefined(param_03))
	{
		param_02 = param_02 * 1.2;
	}

	param_02 = param_02 * level.var_1B71[level.players.size];
	var_05 = 0;
	var_06 = 6;
	var_07 = param_01 / var_06;
	var_08 = param_02 / var_06;
	for(var_09 = 0;var_09 < var_06;var_09++)
	{
		wait(var_07);
		if(isalive(self))
		{
			self dodamage(var_08,self.origin,param_00,param_00,"MOD_UNKNOWN");
		}
	}
}

//Function Number: 20
func_1B6A()
{
	if(!isdefined(self.var_9B81))
	{
		self.var_9B81 = 0;
	}

	self.var_9B81++;
	if(self.var_9B81 == 1 && self.var_1096F == "alien")
	{
		if(isdefined(self.agent_type) && self.agent_type != "minion")
		{
			self setscriptablepartstate("animpart","burning");
		}
	}
}

//Function Number: 21
func_1B69()
{
	self.var_9B81--;
	if(self.var_9B81 > 0)
	{
		return;
	}

	self.var_9B81 = undefined;
	self notify("fire_off");
	if(self.var_1096F == "alien")
	{
		self setscriptablepartstate("animpart","normal");
	}
}

//Function Number: 22
func_12DA8(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(level.var_24B8) || param_01 != level.var_24B8)
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
			if(isdefined(level.var_12D86))
			{
				level thread [[ level.var_12D86 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,self);
			}
		}
	}

	func_12D87(param_01,param_02,param_04);
}

//Function Number: 23
func_12D87(param_00,param_01,param_02)
{
	if(isdefined(level.var_12D87))
	{
		[[ level.var_12D87 ]](param_00,param_01,param_02);
	}
}

//Function Number: 24
func_89C6(param_00,param_01,param_02)
{
	var_03 = param_02;
	switch(param_00)
	{
		case "iw6_panzerfaust3_mp":
		case "aamissile_projectile_mp":
		case "maverick_projectile_mp":
		case "drone_hive_projectile_mp":
		case "bomb_site_mp":
		case "ac130_40mm_mp":
		case "ac130_105mm_mp":
		case "odin_projectile_small_rod_mp":
		case "odin_projectile_large_rod_mp":
			self.var_A859 = 1;
			var_03 = self.maxhealth + 1;
			break;

		case "hind_missile_mp":
		case "hind_bomb_mp":
		case "remote_tank_projectile_mp":
		case "switch_blade_child_mp":
			self.var_A859 = 0;
			var_03 = self.maxhealth + 1;
			break;

		case "heli_pilot_turret_mp":
		case "a10_30mm_turret_mp":
			self.var_A859 = 0;
			var_03 = var_03 * 2;
			break;

		case "sam_projectile_mp":
			self.var_A859 = 1;
			var_03 = param_02;
			break;
	}

	return var_03;
}

//Function Number: 25
func_89AC(param_00,param_01,param_02)
{
	if(function_0107(param_01))
	{
		switch(param_00)
		{
			case "iw6_rgm_mp":
			case "proximity_explosive_mp":
			case "c4_zm":
				param_02 = param_02 * 3;
				break;

			case "iw6_mk32_mp":
			case "semtexproj_mp":
			case "bouncingbetty_mp":
			case "semtex_zm":
			case "semtex_mp":
			case "frag_grenade_mp":
				param_02 = param_02 * 4;
				break;

			default:
				if(scripts\cp\_utility::isstrstart(param_00,"alt_"))
				{
					param_02 = param_02 * 3;
				}
				break;
		}
	}

	return param_02;
}

//Function Number: 26
func_8975(param_00,param_01,param_02,param_03)
{
	if(param_01 == "MOD_RIFLE_BULLET" || param_01 == "MOD_PISTOL_BULLET")
	{
		if(param_03 scripts\cp\_utility::_hasperk("specialty_armorpiercing") || scripts\cp\_utility::func_9DFF(param_00,param_01,param_03))
		{
			return param_02 * level.var_218B;
		}
	}

	return param_02;
}

//Function Number: 27
func_C548(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = 0;
	var_08 = undefined;
	if(isdefined(param_00) && isdefined(self.var_222))
	{
		if(isdefined(param_00.var_222) && isplayer(param_00.var_222))
		{
			param_00 = param_00.var_222;
		}

		if(self.var_222 scripts\cp\_utility::func_9DD6(param_00))
		{
			var_08 = param_00;
		}
	}

	if(isdefined(var_08))
	{
		var_08 notify("destroyed_killstreak",param_01);
		var_09 = 100;
		var_07 = 1;
	}

	if(isdefined(self.var_222) && isdefined(param_05))
	{
		self.var_222 thread scripts\cp\_utility::func_AAEC(param_05,undefined,undefined,self.origin);
	}

	self notify("death");
	return var_07;
}

//Function Number: 28
func_89C3(param_00,param_01,param_02)
{
	if(param_01 == "MOD_MELEE")
	{
		return self.maxhealth + 1;
	}

	return param_02;
}

//Function Number: 29
func_8999(param_00,param_01,param_02)
{
	if(param_00 == "emp_grenade_mp" && param_01 == "MOD_GRENADE_SPLASH")
	{
		self notify("emp_damage",param_00.var_222,8);
		return 0;
	}

	return param_02;
}

//Function Number: 30
func_3343()
{
	self endon("death");
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	var_00 = undefined;
	for(;;)
	{
		self waittill("damage",var_01,var_00,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!isplayer(var_00) && !isagent(var_00))
		{
			continue;
		}

		if(!func_7415(self.var_222,var_00))
		{
			continue;
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "ztransponder_mp":
				case "transponder_mp":
				case "concussion_grenade_mp":
				case "smoke_grenade_mp":
				case "flash_grenade_mp":
					break;
			}
		}

		break;
	}

	if(level.var_334B)
	{
		wait(0.1 + randomfloat(0.4));
	}
	else
	{
		wait(0.05);
	}

	if(!isdefined(self))
	{
		return;
	}

	level.var_334B = 1;
	thread func_E24B();
	if(isdefined(var_04) && issubstr(var_04,"MOD_GRENADE") || issubstr(var_04,"MOD_EXPLOSIVE"))
	{
		self.var_13908 = 1;
	}

	if(isdefined(var_08) && var_08 & level.var_92C4)
	{
		self.var_1390E = 1;
	}

	self.var_1390B = 1;
	if(isdefined(var_00))
	{
		self.var_4D3F = var_00;
	}

	if(isplayer(var_00))
	{
		var_00 func_12E84("c4");
	}

	if(level.teambased)
	{
		if(isdefined(var_00) && isdefined(self.var_222))
		{
			var_0A = var_00.pers["team"];
			var_0B = self.var_222.pers["team"];
			if(isdefined(var_0A) && isdefined(var_0B) && var_0A != var_0B)
			{
				var_00 notify("destroyed_equipment");
			}
		}
	}
	else if(isdefined(self.var_222) && isdefined(var_00) && var_00 != self.var_222)
	{
		var_00 notify("destroyed_equipment");
	}

	if(self.var_13C2E == "transponder_mp" || self.var_13C2E == "ztransponder_mp")
	{
		self.var_222 notify("transponder_update",0);
	}

	waittillframeend;
	self notify("detonateExplosive",var_00);
}

//Function Number: 31
func_7415(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return 1;
	}

	if(!level.teambased)
	{
		return 1;
	}

	var_03 = param_01.team;
	var_04 = level.var_740A;
	if(isdefined(param_02))
	{
		var_04 = param_02;
	}

	if(var_04 != 0)
	{
		return 1;
	}

	if(param_01 == param_00)
	{
		return 0;
	}

	if(!isdefined(var_03))
	{
		return 1;
	}

	if(var_03 != param_00.team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
func_E24B()
{
	wait(0.05);
	level.var_334B = 0;
}

//Function Number: 33
func_20B9()
{
	thread func_20BA();
}

//Function Number: 34
func_20BA()
{
	self notify("stop_applyAlienSnare");
	self endon("stop_applyAlienSnare");
	self endon("disconnect");
	self endon("death");
	self.var_1BD8++;
	self.var_1BD9 = pow(0.68,self.var_1BD8 + 1 * 0.35);
	self.var_1BD9 = max(0.58,self.var_1BD9);
	lib_0CFD::func_12E78();
	wait(0.8);
	self.var_1BD8 = 0;
	self.var_1BD9 = 1;
	lib_0CFD::func_12E78();
}

//Function Number: 35
func_9BE5(param_00,param_01,param_02)
{
	if(isdefined(param_02) && scripts\cp\_utility::func_9CEB(param_02))
	{
		return 0;
	}

	if(param_00 == "MOD_UNKNOWN" && param_01 != "none")
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
func_A010(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = getweaponbasename(param_00);
	switch(var_01)
	{
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
			return 1;

		default:
			return 0;
	}

	return 0;
}