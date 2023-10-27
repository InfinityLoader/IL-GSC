/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_disco\ratking_damage.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 651 ms
 * Timestamp: 10/27/2023 12:04:44 AM
*******************************************************************/

//Function Number: 1
cp_ratking_callbacks()
{
	level.agent_funcs["ratking"]["on_damaged"] = ::onratkingdamaged;
	level.agent_funcs["ratking"]["on_damage_finished"] = ::onratkingdamagefinished;
	level.agent_funcs["ratking"]["on_killed"] = ::onratkingkilled;
}

//Function Number: 2
onratkingdamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = self;
	if(!isdefined(self.agent_type))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		return;
	}

	if(!isplayer(param_01))
	{
		if(!isdefined(param_01.var_222) || isdefined(param_01.var_222) && !isplayer(param_01.var_222))
		{
			return;
		}
	}

	var_0D = gettime();
	param_02 = 4 - level.players.size - 1;
	param_02 = weapondamageadjustments(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	param_02 = fnfdamageadjustments(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	if(scripts\common\utility::istrue(level.rat_king.disabledamage))
	{
		self.fake_damage = param_02;
		param_02 = 0;
	}

	if(isdefined(level.rat_king.shouldteleportthreshold))
	{
		if(isdefined(self.next_forced_teleport_time) && var_0D >= self.next_forced_teleport_time)
		{
			level.rat_king.shouldteleportthreshold++;
			if(level.rat_king.shouldteleportthreshold >= 1)
			{
				self.next_forced_teleport_time = var_0D + 10000;
				level.rat_king.shouldteleportthreshold = 0;
				scripts\cp\maps\cp_disco\rat_king_fight::forcerkteleport();
			}
		}
	}

	if(isdefined(self.next_pain_time) && var_0D >= self.next_pain_time)
	{
		self.next_pain_time = var_0D + 1250;
		self notify("pain");
	}

	if(scripts\aitypes\ratking\behaviors::rkisblocking())
	{
		if(isdefined(self.next_block_fx_time) && isdefined(param_06) && isdefined(param_07) && var_0D >= self.next_block_fx_time)
		{
			self.next_block_fx_time = var_0D + 250;
			playfx(level._effect["rk_blocking"],param_06 + param_07 * -50,param_07 * -150);
		}

		if(!scripts\common\utility::func_2286(level.kungfu_weapons[1],getweaponbasename(param_05)))
		{
			param_02 = 0;
		}
	}

	param_02 = int(min(param_02,self.health));
	if(isplayer(param_01))
	{
		if(isdefined(level.var_12EDE))
		{
			level thread [[ level.var_12EDE ]](param_01,param_05,self);
		}

		param_01 thread scripts\cp\_utility::add_to_notify_queue("rat_king_damaged",self,param_01,param_05,param_02,param_08,param_04);
		param_01 thread lib_0CBC::func_12EC5(getweaponbasename(param_05));
		if(!isdefined(param_01.var_FF0A[getweaponbasename(param_05)]))
		{
			param_01.var_FF0A[getweaponbasename(param_05)] = 1;
		}
		else
		{
			param_01.var_FF0A[getweaponbasename(param_05)]++;
		}
	}

	level thread scripts\cp\_utility::add_to_notify_queue("rat_king_damaged",self,param_01,param_05,param_02,param_08,param_04);
	lib_0D5A::func_12D84(param_01,param_02,param_04);
	scripts\cp\_agent_utils::func_D96D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_0C);
	rkprocessdamagefeedback(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_0C);
	scripts\cp\_agent_utils::func_110A4(param_01,param_02);
	thread lib_0CBC::func_BF05(param_01);
	var_0C [[ level.agent_funcs[var_0C.agent_type]["on_damaged_finished"] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,0,param_0A,param_0B);
}

//Function Number: 3
rkprocessdamagefeedback(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(scripts\common\utility::istrue(param_0A.outofplayspace))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_0A.disabledamage))
	{
		if(scripts\common\utility::func_6E34("relic_active"))
		{
			if(!scripts\common\utility::flag("relic_active"))
			{
				return;
			}
		}
		else
		{
			return;
		}
	}

	if(!scripts\common\utility::func_9D74(param_04))
	{
		if(scripts\cp\_utility::func_9CEB(param_00,param_05))
		{
			return;
		}

		var_0B = gettime();
		if(isdefined(param_01.var_BF85) && param_01.var_BF85 > var_0B)
		{
			return;
		}
		else
		{
			param_01.var_BF85 = var_0B + 250;
		}
	}

	var_0C = "standard";
	var_0D = undefined;
	if(param_0A.health <= param_02)
	{
		var_0D = 1;
	}

	var_0E = scripts\cp\_utility::func_9E27(param_05,param_08,param_04,param_01);
	if(var_0E)
	{
		var_0C = "hitcritical";
	}

	var_0F = scripts\common\utility::func_9D74(param_04);
	var_10 = var_0E && param_01 scripts\cp\_utility::func_9BA0("sharp_shooter_upgrade");
	var_11 = var_0F && param_01 scripts\cp\_utility::func_9BA0("bonus_damage_on_last_bullets");
	var_12 = var_0F && param_01 scripts\cp\_utility::func_9BA0("damage_booster_upgrade");
	var_13 = scripts\common\utility::istrue(param_01.inlaststand);
	var_14 = !var_13 && var_0E && var_0F && param_01 scripts\cp\_utility::func_9BA0("headshot_explosion");
	var_15 = !scripts\cp\_utility::func_9F19(param_0A) || isagent(param_0A) && param_02 >= param_0A.health;
	var_16 = param_04 == "MOD_EXPLOSIVE_BULLET" || param_04 == "MOD_EXPLOSIVE" || param_04 == "MOD_GRENADE_SPLASH" || param_04 == "MOD_PROJECTILE" || param_04 == "MOD_PROJECTILE_SPLASH";
	var_17 = param_04 == "MOD_MELEE";
	if(param_0A scripts\aitypes\ratking\behaviors::rkisblocking())
	{
		var_0C = "hitalienarmor";
	}
	else if(var_10 || var_11 || var_12 || var_14)
	{
		var_0C = "card_boosted";
	}
	else if(isplayer(param_01) && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_boom") && var_16)
	{
		var_0C = "high_damage";
	}
	else if(isplayer(param_01) && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_smack") && var_17)
	{
		var_0C = "high_damage";
	}
	else if(isplayer(param_01) && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_rat_a_tat") && var_0F)
	{
		var_0C = "high_damage";
	}
	else if(isplayer(param_01) && scripts\common\utility::istrue(param_01.deadeye_charge) && var_0F)
	{
		var_0C = "special_weapon";
	}

	if(isdefined(param_01))
	{
		if(isdefined(param_01.var_222))
		{
			param_01.var_222 thread rkupdatedamagefeedback(var_0C,var_0D,param_02,param_0A.var_E54C);
			return;
		}

		param_01 thread rkupdatedamagefeedback(var_0C,var_0D,param_02,param_0A.var_E54C);
	}
}

//Function Number: 4
rkupdatedamagefeedback(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
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

		case "none":
			break;

		default:
			break;
	}

	rkupdatehitmarker(var_07,var_08,param_02,param_03,param_01);
}

//Function Number: 5
rkupdatehitmarker(param_00,param_01,param_02,param_03,param_04)
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
adjustrkcooldowns()
{
	var_00 = gettime();
	if(scripts\common\utility::istrue(scripts\aitypes\ratking\behaviors::rk_shouldbeonplatform()))
	{
		scripts\cp\maps\cp_disco\rat_king_fight::forcerkteleport();
	}
}

//Function Number: 7
onratkingdamagefinished(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	if(scripts\aitypes\ratking\behaviors::rkisblocking())
	{
		param_02 = param_02 * 0.1;
		param_02 = int(param_02);
	}

	scripts\mp\agents\ratking\ratking_agent::accumulatedamage(param_02,param_07);
	scripts\mp\agents\ratking\ratking_agent::ratking_on_damage_finished(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,0,param_0B,param_0C);
}

//Function Number: 8
onratkingkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	lib_0CBC::func_D97C(param_00,param_01,self,param_06,param_03,param_04);
	lib_0CBC::func_D95F(param_01);
	scripts\cp\_weaponrank::func_12861(param_01,param_04,param_06,param_03,self.agent_type);
	if(isdefined(level.death_challenge_update_func))
	{
		[[ level.death_challenge_update_func ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}
	else
	{
		scripts\cp\_challenge::func_12DA9(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	scripts\cp\_merits::func_D95D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	scripts\cp\_agent_utils::func_4DDB();
	level.rat_king = undefined;
	level notify("zombie_killed",self.origin,param_04,param_03);
	level notify("rat_king_killed",self.origin);
	if(isplayer(param_01))
	{
		if(param_01.var_134FD == "p5_")
		{
			param_01 thread scripts\cp\_vo::try_to_play_vo("ww_ratking_death","rave_ww_vo","highest",70,0,0,1);
			return;
		}

		param_01 thread scripts\cp\_vo::try_to_play_vo("ww_ratking_death_p5","rave_ww_vo","highest",70,0,0,1);
	}
}

//Function Number: 9
weapondamageadjustments(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = 0;
	if(isplayer(param_01))
	{
		var_0D = scripts\cp\_utility::func_821F(param_05);
		var_0E = scripts\common\utility::func_9D74(param_04) || param_04 == "MOD_EXPLOSIVE_BULLET" && param_08 != "none";
		var_0F = param_04 == "MOD_MELEE";
		if(!var_0F)
		{
			switch(var_0D)
			{
				case "weapon_assault":
					break;

				case "weapon_smg":
					break;

				case "weapon_lmg":
					break;

				case "weapon_shotgun":
					break;

				case "weapon_pistol":
					break;

				case "other":
					break;
			}
		}

		var_10 = var_0E && scripts\cp\_utility::func_9E27(param_05,param_08,param_04,param_01);
		var_11 = isexplosivedamage(param_04,param_08);
		var_12 = !lib_0CBC::checkaltmodestatus(param_05) && param_01 scripts\cp\_utility::func_4626(param_05) == "weapon_sniper";
		var_13 = param_01 scripts\cp\_weapon::func_7D62(param_05);
		param_02 = param_02 * var_13;
		if(var_12)
		{
			var_0C = var_0C + 5;
		}

		if(var_10)
		{
			var_0C = var_0C + 5;
		}

		var_0C = returnkungfuweaponadjustments(param_05,var_0C);
	}

	return param_02 + var_0C;
}

//Function Number: 10
returnkungfuweaponadjustments(param_00,param_01)
{
	if(scripts\common\utility::func_2286(level.kungfu_weapons[0],getweaponbasename(param_00)))
	{
		param_01 = param_01 + 5;
	}
	else if(scripts\common\utility::func_2286(level.kungfu_weapons[2],getweaponbasename(param_00)))
	{
		param_01 = param_01 + 20;
		scripts\cp\maps\cp_disco\rat_king_fight::forcerkteleport();
	}
	else if(scripts\common\utility::func_2286(level.kungfu_weapons[1],getweaponbasename(param_00)))
	{
		param_01 = param_01 + 10;
		var_02 = lib_0A1A::func_233A("ratking");
		if(isdefined(var_02) && var_02 == "staff_stomp" || var_02 == "staff_projectile")
		{
			thread scripts\aitypes\ratking\behaviors::retrievestaffaftertime();
		}
		else if(scripts\aitypes\ratking\behaviors::rkissummoning())
		{
			if(scripts\common\utility::flag("relic_active"))
			{
				thread scripts\aitypes\ratking\behaviors::retrieveshieldaftertime(5);
			}
			else
			{
				thread scripts\aitypes\ratking\behaviors::retrieveshieldaftertime();
			}
		}
		else if(scripts\aitypes\ratking\behaviors::rkisblocking())
		{
			if(scripts\common\utility::flag("relic_active"))
			{
				thread scripts\aitypes\ratking\behaviors::retrieveshieldaftertime(5);
			}
			else
			{
				thread scripts\aitypes\ratking\behaviors::retrieveshieldaftertime();
			}
		}
	}

	return param_01;
}

//Function Number: 11
isexplosivedamage(param_00,param_01)
{
	if((param_00 == "MOD_EXPLOSIVE_BULLET" && isdefined(param_01) && param_01 == "none") || param_00 == "MOD_EXPLOSIVE" || param_00 == "MOD_GRENADE_SPLASH" || param_00 == "MOD_PROJECTILE" || param_00 == "MOD_PROJECTILE_SPLASH")
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
fnfdamageadjustments(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isplayer(param_01))
	{
	}

	return param_02;
}