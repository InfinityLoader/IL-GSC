/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_damage.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 113
 * Decompile Time: 6253 ms
 * Timestamp: 10/27/2023 12:15:04 AM
*******************************************************************/

//Function Number: 1
func_374E(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	if(isdefined(param_01) && scripts\mp\_utility::func_9FB3(level.jittermodcheck) && level.jittermodcheck == 2 && scripts\mp\_utility::func_9FB3(param_01.ismodded))
	{
		param_03 = 0;
		return;
	}

	if(isdefined(param_01) && param_01.classname == "worldspawn")
	{
		param_01 = undefined;
	}

	if(isdefined(param_01) && isdefined(param_01.var_8712))
	{
		param_01 = param_01.var_8712;
	}

	if(!scripts\mp\_utility::func_766C("prematch_done"))
	{
		return "finished";
	}

	var_0E = gettime();
	var_0F = param_02.health;
	if(isplayer(param_02))
	{
		param_02.var_AA47 = param_02 getcurrentweapon();
		param_02.var_13905 = param_02 scripts\mp\_utility::func_9EE8();
		if(param_02.var_13905)
		{
			param_02.var_A98B = gettime();
		}
	}

	if(!level.tactical)
	{
		param_04 = param_04 | level.var_92C0;
	}

	if(func_B4CA(param_02,param_01,param_06))
	{
		return;
	}

	if(param_05 == "MOD_FALLING" && isdefined(param_02.var_115FC) && param_02.var_115FC)
	{
		param_01 = param_02.var_115FD;
	}

	var_10 = 0;
	if(param_04 & level.var_92CA)
	{
		var_10 = 0;
		param_03 = 0;
	}

	var_11 = func_6C19(param_00,param_01,param_02,param_03,param_05,param_06,param_09);
	if(isdefined(var_11))
	{
		return var_11;
	}

	var_12 = scripts\mp\_utility::func_24F0(param_02,param_01);
	if(var_12)
	{
		param_03 = func_89A7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_10,param_0B,param_0C);
		if(param_03 == 0)
		{
			return;
		}
	}

	if(scripts\mp\_utility::func_9FB3(param_02.var_10902))
	{
		var_13 = isdefined(param_01.classname) && param_01.classname == "trigger_hurt";
		if(!var_13)
		{
			func_898D(param_00,param_01,param_02,0,param_05,param_06,param_09,param_04,1,1);
			return "finished";
		}
	}

	var_14 = scripts\mp\_utility::func_7E9D(param_06);
	if(isdefined(var_14))
	{
		if(var_14 == "lethal")
		{
			param_03 = func_ABC3(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
		}
		else if(var_14 == "equipment_other")
		{
			if(param_06 == "bouncingbetty_mp")
			{
				if(!scripts\mp\_weapons::func_B767(param_00,param_02))
				{
					param_03 = 0;
				}
				else if(param_02 getstance() == "crouch" || param_02 getstance() == "prone")
				{
					param_03 = int(param_03 / 2);
				}
			}

			if(param_06 == "portal_grenade_mp" && param_03 != 400)
			{
				param_02 thread lib_0DFB::func_D68E(param_00,param_01);
			}
		}
	}

	var_15 = scripts\mp\_utility::func_8238(param_06);
	if(var_15 == "killstreak")
	{
		param_03 = func_A696(param_01,param_02,param_03,param_06,param_05);
		if(param_03 == 0)
		{
			return;
		}

		if(param_06 == "killstreak_jammer_mp")
		{
			return "sWeapon == killstreak_jammer_mp";
		}

		if(isdefined(level.var_1541) && isdefined(param_01) && level.var_1541 == param_01)
		{
			level notify("ai_pain",param_02);
		}
	}

	param_03 = func_B939(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	param_03 = func_89DD(param_00,param_02,param_01,param_03,param_05,param_06,param_07,param_08,param_09,param_04);
	if(isstring(param_03))
	{
		return param_03;
	}

	if(scripts\mp\_utility::func_9EF0(param_02))
	{
		param_03 = param_02 scripts\mp\killstreaks\_utility::func_7FBD(param_01,param_06,param_05,param_03,param_02.maxhealth,3,4,6,0);
		if(isdefined(param_01) && isplayer(param_01) && lib_0DF8::func_9DDF(param_01))
		{
			param_03 = 0;
		}
	}

	if(isplayer(param_01))
	{
		param_01 scripts\mp\perks\_weaponpassives::func_3E01();
	}

	var_16 = func_3696(param_02,param_01,param_03,param_05,param_06,param_07,param_08,param_09,param_00,0,param_04);
	param_03 = var_16[0];
	var_17 = var_16[1];
	var_18 = var_16[2];
	var_19 = var_17 != 0 || var_18 != 0;
	param_09 = var_16[3];
	if(isdefined(param_02.forcehitlocation))
	{
		param_09 = param_02.forcehitlocation;
	}

	scripts\mp\perks\_perkfunctions::func_324B(param_01,param_02,param_06,param_05);
	if((param_03 >= param_02.health && scripts\common\utility::string_starts_with(param_06,"iw7_penetrationrail_mp") && param_05 != "MOD_MELEE") || param_03 >= param_02.health && scripts\common\utility::string_starts_with(param_06,"iw7_nunchucks_mpl") && param_05 == "MOD_MELEE")
	{
		var_1A = scripts\mp\_weapons::impale_endpoint(param_07,param_08);
		var_1B = scripts\mp\_weapons::trace_impale(param_07,var_1A);
		if(var_1B["hittype"] != "hittype_world")
		{
			var_1C = (param_08[0],param_08[1],param_08[2]);
			if(var_1C[2] > -0.3 && var_1C[2] < 0.1)
			{
				var_1C = (var_1C[0],var_1C[1],0.1);
				vectornormalize(var_1C);
			}

			param_02 method_84DC(var_1C,650);
		}
	}

	if(isai(self))
	{
		self [[ level.var_2D9E["on_damaged"] ]](param_01,param_03,param_05,param_06,param_00,param_09);
	}

	if(isplayer(param_01) && param_06 == "smoke_grenade_mp" || param_06 == "throwingknife_mp" || param_06 == "throwingknifeteleport_mp" || param_06 == "throwingknifesmokewall_mp" || param_06 == "gas_grenade_mp" || param_06 == "throwingreaper_mp")
	{
		param_01 thread scripts\mp\_gamelogic::func_117B7(param_06,1,"hits");
	}

	if(param_05 == "MOD_FALLING")
	{
		param_02 thread func_612A(param_03);
	}

	if(!isdefined(param_08))
	{
		param_04 = param_04 | level.var_92C0;
	}

	if(isdefined(param_01) && param_01.classname == "script_origin" && isdefined(param_01.type) && param_01.type == "soft_landing")
	{
		return "soft_landing";
	}

	func_AF95(param_02,param_01,param_00,param_06,param_03,param_07,param_08,param_09,param_0A,param_05);
	if(isdefined(param_00) && isdefined(param_00.var_222) && param_00.var_222.team != param_02.team)
	{
		param_02.var_A970 = 1;
	}
	else
	{
		param_02.var_A970 = isdefined(param_01) && param_01 != param_02;
	}

	if(param_02.var_A970)
	{
		var_1D = gettime();
		param_01.var_4D44[param_02.var_86BD] = var_1D;
		param_02.var_A965 = var_1D;
	}

	param_02 func_12EFD(param_03,param_01,param_09,param_05);
	if(scripts\mp\_codcasterclientmatchdata::func_10036())
	{
		if(isplayer(param_01))
		{
			var_1E = scripts\mp\_codcasterclientmatchdata::func_7E39(param_01,"damageDone");
			scripts\mp\_codcasterclientmatchdata::func_F695(param_01,"damageDone",var_1E + param_03);
		}
	}

	param_02 thread scripts\mp\_missions::func_D378(param_00,param_01,param_03,param_05,param_06,param_09);
	if(isdefined(param_01) && param_03 != 0)
	{
		param_01 notify("victim_damaged",param_02,param_00,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
		param_01 scripts\mp\contractchallenges::contractplayerdamaged(param_03);
	}

	var_1F = param_08;
	if(isdefined(param_04) && param_04 & level.var_92C6 && param_03 < self.health)
	{
		var_1F = param_02.origin - param_01.origin;
	}

	param_02 func_6CE1(param_00,param_01,param_03,param_04,param_05,param_06,param_07,var_1F,param_09,param_0A,var_10,param_0B,param_0C,var_19);
	if(param_03 > 10 && isdefined(param_00) && !param_02 scripts\mp\_utility::func_9FC6() && isplayer(param_02))
	{
		param_02 thread scripts\mp\_shellshock::func_2BC2(param_00.origin);
		if(isplayer(param_00) && param_05 == "MOD_MELEE")
		{
			if(isalive(param_02) && !param_02 scripts\mp\_utility::_hasperk("specialty_stun_resistance"))
			{
				param_02 thread func_B645(0.75);
				param_02.var_904B = gettime();
			}

			param_00 thread scripts\mp\_shellshock::func_2BC3(param_06);
			param_02 playrumbleonentity("defaultweapon_melee");
			param_00 playrumbleonentity("defaultweapon_melee");
		}
	}

	if(isagent(self))
	{
		if(scripts\mp\_utility::func_9EF0(self))
		{
			if(param_03 >= self.health)
			{
				param_03 = self.health - 1;
				if(isdefined(self.var_222))
				{
					self.var_222 notify("player_killstreak_agent_death",self,param_00,param_01,param_03,param_04,param_05,param_06);
				}
			}
			else
			{
				self [[ lib_0D65::func_1908("on_damaged_finished") ]](param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
				if(self.var_165A == "remote_c8")
				{
					if(isdefined(self.var_222) && isdefined(self.var_222.var_4BE1) && self.var_222.var_4BE1 == "MANUAL")
					{
						self setclientomnvar("ui_remote_c8_health",self.health / self.maxhealth);
					}
				}
			}
		}
		else
		{
			self [[ lib_0D65::func_1908("on_damaged_finished") ]](param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
		}
	}

	func_898D(param_00,param_01,param_02,param_03,param_05,param_06,param_09,param_04,var_17,var_18);
	scripts\mp\_gamelogic::func_F73B(param_02,1);
	if(isdefined(param_01) && param_01 != param_02)
	{
		level.var_130DD = 0;
	}

	if(isplayer(param_01) && isdefined(param_01.pers["participation"]))
	{
		param_01.pers["participation"]++;
	}
	else if(isplayer(param_01))
	{
		param_01.pers["participation"] = 1;
	}

	if(isdefined(level.var_B3FC) && isplayer(param_02) && isdefined(param_00) && isplayer(param_00) && scripts\common\utility::func_9D74(param_05))
	{
		if(var_0F == param_02.maxhealth && param_02.health != self.maxhealth)
		{
			param_02.var_658D = gettime();
		}
	}

	if(func_1C7E(param_01,param_02,param_06,param_05,param_03))
	{
		param_02 func_1015A();
	}

	if(isdefined(param_01) && param_01 scripts\mp\_utility::_hasperk("specialty_mark_targets") && param_03 > 0)
	{
		param_01 thread scripts\mp\perks\_perk_mark_targets::func_B382(param_02,param_05);
	}

	return "finished";
}

//Function Number: 2
func_B645(param_00)
{
	self endon("death");
	self endon("disconnect");
	var_01 = newclienthudelem(self);
	var_01.x = 0;
	var_01.y = 0;
	var_01.alignx = "left";
	var_01.aligny = "top";
	var_01.sort = 1;
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01.alpha = 0;
	var_01.foreground = 1;
	var_01 setshader("black",640,480);
	thread func_B9F3(var_01);
	self shellshock("melee_mp",param_00);
	self earthquakeforplayer(0.35,0.5,self.origin,100);
	self setclientomnvar("ui_hud_shake",1);
	var_01 fadeovertime(0.1);
	var_01.alpha = 0.2;
	wait(0.1);
	var_01 fadeovertime(0.3);
	var_01.alpha = 0.4;
	wait(0.3);
	var_01 fadeovertime(0.6);
	var_01.alpha = 0;
}

//Function Number: 3
func_B9F3(param_00)
{
	scripts\common\utility::waittill_any_timeout_1(2,"death","disconnect");
	param_00 destroy();
}

//Function Number: 4
func_1C7E(param_00,param_01,param_02,param_03,param_04)
{
	if(param_04 == 0)
	{
		return 0;
	}

	if(func_112D2(param_00,param_01,param_02,param_03,param_04))
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
func_112D2(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_02))
	{
		switch(param_02)
		{
			case "super_trophy_mp":
				return lib_0E19::func_11286(param_00,param_01,param_02,param_03,param_04);
		}
	}

	return 0;
}

//Function Number: 6
func_3696(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(isplayer(param_00) && param_00 method_8568() || param_00 method_8569())
	{
		return [0,0,0,param_07];
	}

	param_00 notify("damage_begin",param_01);
	var_0B = 0;
	var_0C = 0;
	if(param_00 scripts\mp\_utility::func_9E59())
	{
		var_0C = level.var_A4A7;
		if(isdefined(self.var_9E5D) && self.var_9E5D)
		{
			var_0C = level.var_A4A6;
		}
	}

	if(scripts\common\utility::func_9D74(param_03))
	{
		if(isdefined(param_04) && scripts\mp\_utility::func_9D78(param_04) || scripts\mp\_utility::func_9D79(param_04))
		{
			if(func_9D67(param_01,param_00) && isplayer(param_00))
			{
				level thread scripts\mp\_battlechatter_mp::func_EB87(param_00,"plr_hit_back",undefined,0.1);
			}

			if(isdefined(param_01.var_C7E6) && param_01.var_C7E6)
			{
				var_0B = var_0B + param_02 * 0.3;
			}
		}

		if(isdefined(param_04) && issubstr(param_04,"iw7_gauss_mpl"))
		{
			var_0D = scripts\mp\_utility::func_13C90(param_04,"barrelrange");
			var_0E = scripts\common\utility::func_116D7(var_0D,2073600,1440000);
			var_0F = scripts\common\utility::func_116D7(var_0D,5760000,4000000);
			if((distance2dsquared(param_00.origin,param_01.origin) < var_0E && param_02 >= 70) || distance2dsquared(param_00.origin,param_01.origin) < var_0F && param_02 >= 54 || distance2dsquared(param_00.origin,param_01.origin) >= var_0F && param_02 >= 42)
			{
				param_00.hitbychargedshot = param_01;
			}
		}

		if(isdefined(param_04) && issubstr(param_04,"iw7_ba50cal_mpl_overkill"))
		{
			if(param_02 >= 200)
			{
				param_00.hitbychargedshot = param_01;
			}
		}

		if(isdefined(param_0A) && param_0A & level.var_92C6)
		{
			var_10 = scripts\mp\_utility::func_821D(param_04);
			if(var_10 != "none" && !scripts\mp\_utility::func_9F8D(var_10))
			{
				param_02 = param_02 * 0.4;
			}
		}

		if(scripts\mp\_utility::func_9DFF(param_04,param_03))
		{
			var_0C = var_0C * level.var_218B;
		}

		if(isplayer(param_01) && param_01 scripts\mp\_utility::_hasperk("specialty_paint_pro") && !scripts\mp\_utility::func_9E6C(param_04))
		{
			if(!param_00 scripts\mp\perks\_perkfunctions::func_9ED2())
			{
				param_01 scripts\mp\_missions::func_D992("ch_bulletpaint");
			}

			param_00 thread scripts\mp\perks\_perkfunctions::func_F7D5(param_01);
		}

		if(isplayer(param_01) && param_01 scripts\mp\_utility::_hasperk("specialty_bulletdamage") && param_00 scripts\mp\_utility::_hasperk("specialty_armorvest"))
		{
		}
		else if(isplayer(param_01) && param_01 scripts\mp\_utility::_hasperk("specialty_bulletdamage") || param_01 scripts\mp\_utility::_hasperk("specialty_moredamage"))
		{
			var_0B = var_0B + param_02 * level.var_3245;
		}
		else if(param_00 scripts\mp\_utility::_hasperk("specialty_armorvest"))
		{
			var_0B = var_0B - param_02 * level.var_21A3;
		}
		else if(param_00 scripts\mp\_utility::_hasperk("specialty_headgear") && scripts\mp\_utility::func_9E27(param_04,param_07,param_03,param_01) && !scripts\mp\_utility::func_9DFF(param_04,param_03))
		{
			var_0B = var_0B - param_02 * level.var_8C74;
			param_00 notify("headgear_save",param_01,param_03,param_04);
		}

		if(param_00 scripts\mp\_utility::func_9E59())
		{
			if(level.var_8B38 && isdefined(param_04) && weaponclass(param_04) == "spread")
			{
				param_02 = min(param_02,25) * var_0C;
				var_0B = min(param_02,25) * var_0C;
			}
			else
			{
				param_02 = param_02 * var_0C;
				var_0B = var_0B * var_0C;
			}
		}

		if(param_01 scripts\mp\_utility::_hasperk("passive_sonic") && param_01 method_81BE())
		{
			param_02 = param_02 * 1.25;
		}

		if(param_01 scripts\mp\_utility::_hasperk("passive_below_the_belt"))
		{
			var_11 = undefined;
			switch(param_00.var_AE62)
			{
				case "archetype_scout":
					var_11 = "torso_stabilizer";
					break;

				default:
					var_11 = "j_crotch";
					break;
			}

			if(isdefined(var_11))
			{
				var_12 = param_00 gettagorigin(var_11);
				var_13 = distance(var_12,param_05);
				var_14 = 7.5;
				if(var_13 <= var_14)
				{
					param_02 = param_02 * 1.35;
					param_01 scripts\mp\_utility::func_8387("specialty_moredamage");
				}
			}
		}

		if(scripts\mp\_weapons::func_A008(param_04))
		{
			param_00 thread scripts\mp\_weapons::func_20E4();
		}

		if(isdefined(param_00.var_FC99))
		{
			param_02 = 0;
		}
	}
	else if(function_0107(param_03))
	{
		param_02 = scripts\mp\_concussiongrenade::func_B92C(param_02,param_01,param_00,param_08,param_04);
		param_02 = lib_0DDB::func_B92C(param_02,param_01,param_00,param_08,param_04);
		param_02 = scripts\mp\_empgrenade::func_B92C(param_02,param_01,param_00,param_08,param_04);
		param_02 = scripts\mp\_weapons::glprox_modifieddamage(param_02,param_01,param_00,param_08,param_04,param_03,param_05);
		if(param_04 == "proximity_explosive_mp" && isdefined(param_08.origin))
		{
			var_15 = param_08.origin[2];
			var_16 = param_00.origin[2] + 24;
			if(var_15 < var_16 && !param_00 isonground())
			{
				param_02 = param_02 * 0.8;
			}
			else if(var_15 >= var_16 && param_00 getstance() == "crouch")
			{
				param_02 = param_02 * 0.9;
			}
			else if(var_15 >= var_16 && param_00 getstance() == "prone")
			{
				param_02 = param_02 * 0.65;
			}
		}

		if(isplayer(param_01))
		{
			if(param_01 != param_00 && param_01 isitemunlocked("specialty_paint","perk") && param_01 scripts\mp\_utility::_hasperk("specialty_paint") && !scripts\mp\_utility::func_9E6C(param_04))
			{
				param_00 thread scripts\mp\perks\_perkfunctions::func_F7D5(param_01);
			}
		}

		if(isdefined(param_00.var_1177D) && param_00.var_1177D)
		{
			var_0B = var_0B + int(param_02 * level.var_1177E);
		}

		if(isplayer(param_01) && function_0243(param_04) && param_01 scripts\mp\_utility::_hasperk("specialty_explosivedamage") && param_00 scripts\mp\_utility::_hasperk("specialty_blastshield"))
		{
		}
		else if(isplayer(param_01) && function_0243(param_04) && !scripts\mp\_utility::func_9E6C(param_04) && param_01 scripts\mp\_utility::_hasperk("specialty_explosivedamage"))
		{
			var_0B = var_0B + param_02 * level.var_69FE;
		}
		else if(param_00 scripts\mp\_utility::_hasperk("specialty_blastshield") && !scripts\mp\_utility::func_13C9A(param_04,param_07) && !scripts\mp\_utility::func_9F7E(param_00,param_08,param_04,param_03) && !param_03 == "MOD_PROJECTILE")
		{
			var_17 = scripts\mp\_weapons::glprox_modifiedblastshieldconst(level.var_2B68,param_04);
			var_17 = lib_0DE9::groundpound_modifiedblastshieldconst(var_17,param_04);
			var_18 = int(param_02 * var_17);
			if(param_01 != param_00)
			{
				var_18 = clamp(var_18,0,level.var_2B67);
			}

			var_0B = var_0B - param_02 - var_18;
		}

		if(param_00 scripts\mp\_utility::func_9E59())
		{
			var_0B = var_0B * var_0C;
			if(param_02 < 1000)
			{
				param_02 = param_02 * var_0C;
			}
		}

		if(isdefined(level.var_ABBF) && !scripts\mp\_weapons::func_ABC1())
		{
			param_02 = param_02 * level.var_8488;
		}

		if(isdefined(param_00.var_FC99))
		{
			param_02 = 0;
		}
	}
	else if(param_03 == "MOD_FALLING")
	{
		if(isdefined(param_00.var_115FC) && param_00.var_115FC)
		{
			param_02 = param_00.health + 100;
			param_01 thread lib_0DFB::func_468B(param_00,param_00.origin);
			param_00.var_115FC = 0;
			param_00.var_115FD = undefined;
			param_00.var_115FE = undefined;
		}
		else if(param_00 scripts\mp\_utility::func_9E59())
		{
			param_02 = param_02 * var_0C;
		}
		else if(lib_0DE9::func_8651(param_00))
		{
			param_02 = 0;
		}
		else
		{
			param_02 = int(max(33,param_02));
			if(param_02 >= param_00.health)
			{
				param_02 = int(max(0,param_00.health - 1));
			}
		}
	}
	else if(param_03 == "MOD_MELEE")
	{
		if(isdefined(param_08) && scripts\mp\_utility::func_9EF0(param_08) && param_08.var_165A == "remote_c8")
		{
			param_02 = self.health - 1;
		}
		else if(param_00 scripts\mp\_utility::func_9E59())
		{
			param_02 = 20;
			var_0B = 0;
		}
		else if(param_04 == "iw7_reaperblade_mp")
		{
			param_00 thread lib_0E17::func_A668();
		}
		else if(isdefined(param_00 scripts\mp\_supers::func_7E4F()) && param_00 scripts\mp\_supers::func_7E4F() == "super_reaper" && param_00 scripts\mp\_supers::func_9F88())
		{
			param_02 = int(min(param_02,lib_0E17::func_93D9()));
		}
		else if(scripts\mp\_utility::func_9E7D(param_08,param_00,param_04,param_03))
		{
			param_02 = param_00.health;
		}
		else if(func_9D67(param_01,param_00) && isdefined(param_08) && !scripts\mp\_utility::func_9EF0(param_08))
		{
			param_02 = int(max(param_02,100));
		}
		else
		{
			param_02 = 70;
		}
	}
	else if(param_03 == "MOD_IMPACT")
	{
		if(param_00 scripts\mp\_utility::func_9E59())
		{
			switch(param_04)
			{
				case "semtexproj_mp":
				case "gas_grenade_mp":
				case "gravity_grenade_mp":
				case "sensor_grenade_mp":
				case "smoke_grenadejugg_mp":
				case "flash_grenade_mp":
				case "shard_ball_mp":
				case "mortar_shelljugg_mp":
				case "semtex_mp":
				case "frag_grenade_mp":
				case "concussion_grenade_mp":
				case "smoke_grenade_mp":
				case "splash_grenade_mp":
				case "cluster_grenade_mp":
								param_02 = 5;
								break;

				default:
								if(param_02 < 1000)
								{
									param_02 = 25;
								}
								break;
			}

			var_0B = 0;
		}

		if(isdefined(param_00.var_FC99))
		{
			param_02 = 0;
		}

		if(isdefined(param_03) && param_03 == "MOD_IMPACT" && getweaponbasename(param_04) == "iw7_venomx_mp")
		{
			param_01 scripts\mp\_missions::func_D991("ch_iw7_venomx_direct");
		}
	}
	else if(param_03 == "MOD_UNKNOWN" || param_03 == "MOD_MELEE_DOG")
	{
		if(isagent(param_01) && isdefined(param_01.agent_type) && param_01.agent_type == "dog" && param_00 scripts\mp\_utility::func_9E59())
		{
			param_00 shellshock("dog_bite",2);
			param_02 = param_02 * var_0C;
		}
	}

	if(param_00 scripts\mp\_utility::_hasperk("specialty_combathigh"))
	{
		if(isdefined(self.var_4D2D) && !level.teambased || isdefined(param_01) && isdefined(param_01.team) && param_00.team != param_01.team)
		{
			var_19 = param_02 + var_0B;
			var_1A = var_19 - var_19 / 3;
			self.var_4D2D = self.var_4D2D + var_1A;
			if(self.var_4D2D >= 101)
			{
				self notify("combathigh_survived");
				self.var_4D2D = undefined;
			}
		}

		if(param_04 != "throwingknife_mp" && param_04 != "throwingknifejugg_mp" && param_04 != "throwingknifeteleport_mp" && param_04 != "throwingreaper_mp" && !param_04 == "throwingknife_mp" && param_03 == "MOD_IMPACT")
		{
			switch(param_03)
			{
				case "MOD_FALLING":
				case "MOD_MELEE":
					break;

				default:
					param_02 = int(param_02 / 3);
					var_0B = int(var_0B / 3);
					break;
			}
		}
	}

	param_02 = lib_0DDE::chargemode_modifieddamage(param_01,param_00,param_04,param_05,param_02);
	param_02 = lib_0DE6::explodingdrone_modifieddamage(param_01,param_00,param_04,param_08,param_02);
	param_02 = lib_0E19::func_11280(param_01,param_00,param_04,param_02);
	param_02 = lib_0DE9::func_8653(param_01,param_00,param_04,param_08,param_02);
	param_02 = scripts\mp\killstreaks\_venom::venommodifieddamage(param_01,param_00,param_04,param_08,param_02);
	var_1B = scripts\mp\_playertrophy_system::playertrophy_modifieddamage(param_01,param_00,param_04,param_08,param_02);
	var_1B = scripts\mp\_trophy_system::trophy_modifieddamage(param_01,param_00,param_04,param_02,var_0B);
	param_02 = var_1B[0];
	var_0B = var_1B[1];
	var_1C = 0;
	if(param_00 scripts\mp\_heavyarmor::func_8BFA())
	{
		var_1B = scripts\mp\_heavyarmor::func_8D07(param_00,param_01,param_02,var_0B,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		var_1C = var_1B[0] > 0;
		param_02 = var_1B[1];
		var_0B = var_1B[2];
	}

	var_1D = 0;
	if(scripts\mp\_lightarmor::func_8C07(param_00))
	{
		var_1B = scripts\mp\_lightarmor::func_ACA7(param_00,param_01,param_02,var_0B,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		var_1D = var_1B[0] > 0;
		param_02 = var_1B[1];
		var_0B = var_1B[2];
	}

	if(scripts\mp\_utility::func_8BF9(param_00))
	{
		param_02 = param_00 scripts\mp\_utility::func_7EF7(param_02);
	}

	if(param_02 <= 1)
	{
		param_02 = int(ceil(clamp(param_02,0,1)));
	}
	else
	{
		param_02 = int(param_02 + var_0B);
	}

	if(isdefined(param_00.var_FC99))
	{
		param_00.var_FC9A = param_02;
		param_02 = 0;
	}
	else if(param_07 == "shield" && param_00 scripts\mp\_utility::_hasperk("specialty_rearguard") && param_03 == "MOD_EXPLOSIVE" || param_03 == "MOD_PROJECTILE_SPLASH" || param_03 == "MOD_PROJECTILE" || isdefined(param_08.var_13C2E) && scripts\mp\_utility::func_9E6C(param_08.var_13C2E))
	{
		param_07 = "none";
	}

	if(isdefined(param_08) && isplayer(param_08) && isdefined(param_01) && isplayer(param_01) && param_01 != param_00)
	{
		thread scripts\mp\perks\_weaponpassives::func_12F60(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}

	return [param_02,var_1D,var_1C,param_07];
}

//Function Number: 7
func_B4CA(param_00,param_01,param_02)
{
	var_03 = 0;
	if(isdefined(param_01) && isdefined(param_00) && isdefined(param_02))
	{
		var_04 = getweaponbasename(param_02) == "iw7_mauler_mpr" || issubstr(param_02,"iw7_crdb_mp");
		var_05 = weaponclass(param_02) == "spread";
		if(!var_05 && !var_04)
		{
			return var_03;
		}

		var_06 = "" + gettime();
		var_07 = undefined;
		if(param_01 method_822E() > 0.8 && param_01 scripts\mp\_utility::_hasperk("passive_shotgun_focus"))
		{
			var_07 = 4;
		}
		else if(var_04)
		{
			var_07 = 4;
		}
		else if(param_01 method_819C())
		{
			var_07 = 5;
		}
		else if(issubstr(param_02,"iw7_mod2187_mpl"))
		{
			var_07 = 4;
		}
		else if(issubstr(param_02,"iw7_longshot_mp"))
		{
			var_08 = param_01 method_822E() > 0.95;
			var_09 = scripts\mp\_weapons::func_9D3E(param_02);
			if(!var_08 && !var_09)
			{
				var_07 = 1;
			}
			else if(var_08 && !var_09)
			{
				var_07 = 4;
			}
			else
			{
				var_07 = 3;
			}
		}
		else
		{
			var_07 = 3;
		}

		if(!isdefined(param_01.var_CA01) || !isdefined(param_01.var_CA01[var_06]))
		{
			param_01.var_CA01 = undefined;
			param_01.var_CA01[var_06] = [];
		}

		if(!isdefined(param_01.var_CA01[var_06][param_00.var_86BD]))
		{
			param_01.var_CA01[var_06][param_00.var_86BD] = 1;
		}
		else if(param_01.var_CA01[var_06][param_00.var_86BD] + 1 > var_07)
		{
			var_03 = 1;
		}
		else
		{
			param_01.var_CA01[var_06][param_00.var_86BD]++;
		}
	}

	return var_03;
}

//Function Number: 8
func_9D67(param_00,param_01)
{
	var_02 = vectornormalize((param_01.origin[0],param_01.origin[1],0) - (param_00.origin[0],param_00.origin[1],0));
	var_03 = anglestoforward((0,param_01.angles[1],0));
	return vectordot(var_02,var_03) > 0.4;
}

//Function Number: 9
func_9D68(param_00,param_01)
{
	var_02 = vectornormalize((param_01.origin[0],param_01.origin[1],0) - (param_00.origin[0],param_00.origin[1],0));
	var_03 = anglestoforward((0,param_01.angles[1],0));
	return vectordot(var_02,var_03) > 0.2;
}

//Function Number: 10
func_A696(param_00,param_01,param_02,param_03,param_04)
{
	if(param_03 == "hind_bomb_mp" || param_03 == "hind_missile_mp")
	{
		if(isdefined(param_00) && param_01 == param_00)
		{
			return 0;
		}
	}

	if(param_01 scripts\mp\_utility::isspawnprotected())
	{
		var_05 = int(max(param_01.health / 4,1));
		if(param_02 >= var_05 && scripts\mp\_utility::func_9E6C(param_03) && param_04 != "MOD_MELEE")
		{
			param_02 = var_05;
		}
	}

	return param_02;
}

//Function Number: 11
friendlyfire_ignoresdamageattacker(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	var_0E = 0;
	if(isdefined(param_06))
	{
		switch(param_06)
		{
			case "none":
				if(isdefined(param_00) && scripts\mp\_utility::isdronepackage(param_00))
				{
					var_0E = 1;
				}
				break;

			case "iw7_minigun_c8_mp":
			case "iw7_chargeshot_c8_mp":
			case "iw7_c8offhandshield_mp":
				var_0F = undefined;
				if(isdefined(param_01) && scripts\mp\_utility::func_9F22(param_01))
				{
					var_0F = param_01;
				}
				else if(isdefined(param_00) && scripts\mp\_utility::func_9F22(param_00))
				{
					var_0F = param_00;
				}
	
				if(isdefined(var_0F) && isdefined(var_0F.var_222))
				{
					if(!isdefined(var_0F.var_222.var_4BE1))
					{
						var_0E = 1;
					}
					else if(var_0F.var_222.var_4BE1 != "MANUAL")
					{
						var_0E = 1;
					}
				}
				break;

			case "ball_drone_gun_mp":
			case "jackal_fast_cannon_mp":
			case "jackal_turret_mp":
			case "jackal_cannon_mp":
			case "sentry_shock_mp":
			case "iw7_c8landing_mp":
			case "iw7_c8destruct_mp":
			case "super_trophy_mp":
			case "micro_turret_gun_mp":
			case "player_trophy_system_mp":
			case "trophy_mp":
				var_0E = 1;
				break;
		}
	}

	return var_0E;
}

//Function Number: 12
func_89A7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	if(isdefined(param_00) && !isplayer(param_00))
	{
		if(!isdefined(param_01))
		{
			if(isdefined(param_00.var_222))
			{
				param_01 = param_00.var_222;
			}
		}
		else if(!isplayer(param_01))
		{
			if(isdefined(param_00.var_222))
			{
				param_01 = param_00.var_222;
			}
		}
	}

	if(level.var_8B38)
	{
		if(param_01 scripts\mp\_utility::_hasperk("passive_softcore") && scripts\common\utility::func_9D74(param_05))
		{
			return 0;
		}

		if(isdefined(param_04) && param_04 & level.var_92C6 && scripts\common\utility::func_9D74(param_05))
		{
			param_03 = int(param_03 * 0.2);
		}
	}

	if(level.var_740A != 0)
	{
		if(scripts\mp\_utility::func_9FB3(param_02.var_9DBC) || scripts\mp\_utility::func_9FB3(param_02.var_9D7F))
		{
			param_03 = int(param_03 * 0.5);
			if(param_03 < 1)
			{
				param_03 = 1;
			}

			param_01.var_A970 = 0;
			func_4D2C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D);
			return 0;
		}
	}

	if(level.var_740A == 0 || !isplayer(param_01) && level.var_740A != 1 || param_06 == "bomb_site_mp")
	{
		if(param_06 == "artillery_mp" || param_06 == "stealth_bomb_mp")
		{
			param_02 func_4D67(param_00,param_06,param_05,param_03,param_04,param_01);
		}

		return 0;
	}
	else if(level.var_740A == 1)
	{
		if(param_03 < 1)
		{
			param_03 = 1;
		}

		if(param_02 scripts\mp\_utility::func_9E59())
		{
			var_0E = func_3696(param_02,param_01,param_03,param_05,param_06,param_07,param_08,param_09,param_00,0,param_04);
			param_03 = var_0E[0];
			var_0F = var_0E[1];
			var_10 = var_0E[2];
			param_09 = var_0E[3];
		}

		param_02.var_A970 = 0;
		param_02 func_6CE1(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D);
		param_01 func_898D(param_00,param_01,param_02,param_03,param_05,param_06,param_09,param_04,0,0);
		return 0;
	}
	else if(level.var_740A == 2)
	{
		param_03 = int(param_03 * 0.5);
		if(param_03 < 1)
		{
			param_03 = 1;
		}

		param_01.var_A970 = 0;
		if(!friendlyfire_ignoresdamageattacker(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D))
		{
			func_4D2C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D);
		}

		return 0;
	}
	else if(level.var_740A == 3)
	{
		param_03 = int(param_03 * 0.5);
		if(param_03 < 1)
		{
			param_03 = 1;
		}

		param_02.var_A970 = 0;
		param_01.var_A970 = 0;
		param_02 func_6CE1(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D);
		if(!friendlyfire_ignoresdamageattacker(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D))
		{
			func_4D2C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D);
		}

		param_01 func_898D(param_00,param_01,param_02,param_03,param_05,param_06,param_09,param_04,0,0);
		return 0;
	}
	else if(level.var_740A == 4)
	{
		var_11 = param_01.pers["teamkills"] >= level.var_B47A;
		if(var_11)
		{
			if(!friendlyfire_ignoresdamageattacker(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D))
			{
				param_03 = int(param_03 * 0.5);
				if(param_03 < 1)
				{
					param_03 = 1;
				}

				param_01.var_A970 = 0;
				func_4D2C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D);
			}

			return 0;
		}
	}

	return param_03;
}

//Function Number: 13
func_4D2C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	if(scripts\mp\_utility::func_9F19(param_01))
	{
		param_01.var_7408 = 1;
		param_01 func_6CE1(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D);
		param_01.var_7408 = undefined;
	}
}

//Function Number: 14
func_B939(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(param_05 == "MOD_EXPLOSIVE_BULLET" && param_03 != 1)
	{
		param_03 = param_03 * getdvarfloat("scr_explBulletMod");
		param_03 = int(param_03);
	}

	if(isdefined(level.var_B93A))
	{
		param_03 = [[ level.var_B93A ]](param_02,param_01,param_03,param_05,param_06,param_07,param_08,param_09);
	}

	param_03 = int(param_03 * param_02 scripts\mp\_utility::func_7E5C(param_00,param_01,param_02,param_03,param_05,param_06,param_09));
	if(scripts\mp\_utility::func_9E27(param_06,param_09,param_05,param_01))
	{
		param_05 = "MOD_HEAD_SHOT";
	}

	if(scripts\mp\_tweakables::func_81E7("game","onlyheadshots"))
	{
		if(param_05 == "MOD_HEAD_SHOT")
		{
			if(param_02 scripts\mp\_utility::func_9E59())
			{
				param_03 = 75;
			}
			else
			{
				param_03 = 150;
			}
		}
	}

	return param_03;
}

//Function Number: 15
func_89DD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(param_08 != "shield")
	{
		return param_03;
	}

	if(param_01 scripts\mp\_utility::_hasperk("specialty_rearguard"))
	{
		var_0A = scripts\common\utility::func_116D7(isdefined(param_00),param_00,param_02);
		if(isdefined(var_0A))
		{
			if(isplayer(var_0A) || scripts\mp\_utility::func_9EF0(var_0A))
			{
				if(func_9D68(var_0A,param_01))
				{
					if(scripts\common\utility::func_9D74(param_04) || param_04 == "MOD_EXPLOSIVE_BULLET")
					{
						param_02 scripts\mp\_damagefeedback::func_12E84("hitlightarmor");
					}
				}
			}
			else if((isdefined(param_05) && param_05 == "destructible_car" || scripts\mp\_utility::func_9E6C(param_05)) || function_0107(param_04) || param_04 == "MOD_PROJECTILE")
			{
				param_01.var_FC96 = param_01.var_FC96 + param_03;
				if(func_9D68(var_0A,param_01) && !param_01 scripts\mp\_utility::_hasperk("specialty_blastshield"))
				{
					return param_03 * 3;
				}
				else
				{
					return param_03;
				}
			}
		}
	}

	var_0B = scripts\mp\_utility::func_9FB3(param_01.var_9331);
	if(isdefined(param_01.var_222))
	{
		param_01 = param_01.var_222;
		if(param_02 == param_01)
		{
			return "hit shield";
		}
	}

	if(param_04 == "MOD_PISTOL_BULLET" || param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_EXPLOSIVE_BULLET")
	{
		if(isplayer(param_02))
		{
			param_02.var_A93F = param_01;
			param_02.var_A940 = gettime();
		}

		param_01 notify("shield_blocked");
		if(scripts\mp\_utility::func_9DE2(param_05))
		{
			var_0C = 25;
		}
		else if(param_02 scripts\mp\_utility::_hasperk("specialty_rearguard") && func_9D68(param_03,param_02))
		{
			var_0C = param_04;
		}
		else
		{
			var_0D = func_3696(param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_01,0,var_0B);
			var_0C = var_0D[0];
			var_0E = var_0D[1];
			var_0F = var_0D[2];
			param_08 = var_0D[3];
		}

		param_01.var_FC96 = param_01.var_FC96 + var_0C;
		param_01.var_FC97 = param_01.var_FC97 + var_0C;
		if(isplayer(param_02) && isdefined(param_01.rearguardattackers))
		{
			var_10 = param_02 getentitynumber();
			if(!isdefined(param_01.rearguardattackers[var_10]))
			{
				param_01.rearguardattackers[var_10] = var_0C;
			}
			else
			{
				param_01.rearguardattackers[var_10] = param_01.rearguardattackers[var_10] + var_0C;
			}
		}

		if(var_0B)
		{
			return "hit shield";
		}

		if(!scripts\mp\_utility::func_9DE2(param_05) || scripts\common\utility::func_4347())
		{
			param_01.var_FC95++;
		}

		if(param_01.var_FC95 >= level.var_E55D)
		{
			var_11 = 1;
			if(self.var_DDCC > 4)
			{
				var_11 = 1 / self.var_DDCC;
			}

			var_12 = scripts\mp\_rank::func_8104("shield_damage");
			var_13 = param_01 getcurrentweapon();
			param_01 thread scripts\mp\_utility::func_83B4("shield_damage",var_13,var_12 * var_11);
			param_01 thread func_839D();
			param_01 thread scripts\mp\_missions::func_D992("shield_damage",param_01.var_FC97);
			param_01 thread scripts\mp\_missions::func_D992("shield_bullet_hits",param_01.var_FC95);
			param_01.var_FC97 = 0;
			param_01.var_FC95 = 0;
		}
	}

	var_14 = isdefined(param_00) && isdefined(param_00.var_11180) && param_00.var_11180 == param_01;
	if(param_09 & level.var_92C7 && !param_01 scripts\mp\_utility::_hasperk("specialty_rearguard"))
	{
		param_01 thread scripts\mp\_missions::func_D992("shield_explosive_hits",1);
		param_08 = "none";
		if(!param_09 & level.var_92C8)
		{
			param_03 = 0;
		}
	}
	else if(param_09 & level.var_92C9)
	{
		if(scripts\mp\_utility::func_9F7F(param_01,param_00,param_05,param_04))
		{
			param_01.forcehitlocation = "none";
			param_03 = param_01.maxhealth;
		}

		if(!param_01 scripts\mp\_utility::_hasperk("specialty_rearguard"))
		{
			param_01 thread scripts\mp\_missions::func_D992("shield_explosive_hits",1);
			param_08 = "none";
		}
	}
	else
	{
		return "hit shield";
	}

	if(param_04 == "MOD_MELEE" && scripts\mp\_weapons::func_9F2D(param_05))
	{
		var_15 = 0;
		param_01 method_83B2(0);
	}

	return param_03;
}

//Function Number: 16
func_6C19(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(param_05 == "iw7_reaperblade_mp")
	{
		var_07 = gettime();
		if(isdefined(param_02.var_A9DA))
		{
			if(param_02.var_A9DA + 200 >= var_07)
			{
				return "invalidVictim";
			}
		}

		param_02.var_A9DA = var_07;
	}

	if(!param_03)
	{
		return "!iDamage";
	}

	if(isdefined(level.var_90A9))
	{
		return "level.hostMigrationTimer";
	}

	param_01 = scripts\mp\_utility::func_143A(param_01);
	if(!isdefined(param_01) && param_04 != "MOD_FALLING")
	{
		return "invalid attacker";
	}

	param_02 = scripts\mp\_utility::func_143B(param_02);
	if(!isdefined(param_02))
	{
		return "invalidVictim";
	}

	if(game["state"] == "postgame")
	{
		return "game[ state ] == postgame";
	}

	if(param_02.sessionteam == "spectator")
	{
		return "victim.sessionteam == spectator";
	}

	if(isdefined(param_02.var_389E) && !param_02.var_389E)
	{
		return "!victim.canDoCombat";
	}

	if(isdefined(param_01) && isplayer(param_01) && isdefined(param_01.var_389E) && !param_01.var_389E)
	{
		return "!eAttacker.canDoCombat";
	}

	var_08 = isdefined(param_01) && isdefined(param_00) && isdefined(param_02) && isplayer(param_01) && param_01 == param_00 && param_01 == param_02 && !isdefined(param_00.var_D64C);
	if(var_08)
	{
		return "attackerIsInflictorVictim";
	}

	if(scripts\mp\_tweakables::func_81E7("game","onlyheadshots"))
	{
		if(param_06 != "head")
		{
			if(param_04 == "MOD_PISTOL_BULLET" || param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_EXPLOSIVE_BULLET")
			{
				return "getTweakableValue( game, onlyheadshots )";
			}
		}
	}

	var_09 = isdefined(param_01) && !isdefined(param_01.var_8712) && param_01.classname == "script_vehicle" || param_01.classname == "misc_turret" || param_01.classname == "script_model";
	if(!level.teambased && var_09 && isdefined(param_01.var_222) && param_01.var_222 == param_02)
	{
		if(param_04 == "MOD_CRUSH")
		{
			param_02 scripts\mp\_utility::func_1417();
		}

		return "ffa suicide";
	}

	if(lib_0DF8::func_9DDF(param_02))
	{
		if(!isdefined(param_00))
		{
			return "outOfPhase";
		}

		if(!lib_0DF8::func_9DDF(param_00))
		{
			if(!isdefined(param_00.classname) || param_00.classname != "trigger_hurt")
			{
				return "outOfPhase";
			}

			return;
		}

		return;
	}

	if(isdefined(param_00) && !lib_0DF8::func_213D(param_00,param_02))
	{
		return "outOfPhase";
	}
}

//Function Number: 17
func_AF95(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_01) && isplayer(param_01))
	{
		func_17AC(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}

	if(isdefined(param_01) && !isplayer(param_01) && isdefined(param_01.var_222) && !isdefined(param_01.var_EC9B) || !param_01.var_EC9B)
	{
		func_17AC(param_00,param_01.var_222,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}
	else if(isdefined(param_01) && !isplayer(param_01) && isdefined(param_01.var_F0C5) && isdefined(param_01.var_EC9B) && param_01.var_EC9B)
	{
		func_17AC(param_00,param_01.var_F0C5,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}

	if(isdefined(param_02) && isdefined(param_02.var_222))
	{
		var_0A = param_02.var_222.team != param_00.team || level.var_740A == 1;
		if(var_0A && !isdefined(self.var_24E5[param_02.var_222.var_86BD]))
		{
			func_17AC(param_00,param_02.var_222,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		}
	}

	if(isdefined(param_01))
	{
		level.var_A9AC = param_01;
	}

	if(isdefined(param_01) && isplayer(param_01) && isdefined(param_03))
	{
		param_01 thread scripts\mp\_weapons::func_3E1E(param_03,param_00);
	}

	if(isdefined(param_01) && isplayer(param_01) && isdefined(param_03) && param_01 != param_00)
	{
		param_01 thread scripts\mp\_events::func_4D43(self,param_04,param_03);
		param_00.var_2502 = param_01.origin;
		return;
	}

	param_00.var_2502 = undefined;
}

//Function Number: 18
func_AF96(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(isdefined(param_02) && isplayer(param_02))
	{
		func_17AD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	}

	if(isdefined(param_02) && !isplayer(param_02) && isdefined(param_02.var_222) && !isdefined(param_02.var_EC9B) || !param_02.var_EC9B)
	{
		param_02 = param_02.var_222;
		func_17AD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	}
	else if(isdefined(param_02) && !isplayer(param_02) && isdefined(param_02.var_F0C5) && isdefined(param_02.var_EC9B) && param_02.var_EC9B)
	{
		param_02 = param_02.var_F0C5;
		func_17AD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	}

	if(isdefined(param_02))
	{
		level.var_A9AC = param_02;
	}

	if(isdefined(param_02) && isplayer(param_02) && isdefined(param_0A) && param_02 != param_00)
	{
		param_00.var_2502 = param_02.origin;
		return;
	}

	param_00.var_2502 = undefined;
}

//Function Number: 19
func_AFBC(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if((issubstr(param_04,"MOD_EXPLOSIVE") || issubstr(param_04,"MOD_PROJECTILE")) && isdefined(param_00) && isdefined(param_01))
	{
		param_02.var_6A00 = [];
		param_02.var_6A00["damageTime"] = gettime();
		param_02.var_6A00["damageId"] = param_00 getentitynumber();
		param_02.var_6A00["returnToSender"] = 0;
		param_02.var_6A00["counterKill"] = 0;
		param_02.var_6A00["chainKill"] = 0;
		param_02.var_6A00["cookedKill"] = 0;
		param_02.var_6A00["throwbackKill"] = 0;
		param_02.var_6A00["suicideGrenadeKill"] = 0;
		param_02.var_6A00["weapon"] = param_05;
		var_06 = issubstr(param_05,"frag_");
		if(param_01 != param_02)
		{
			if((issubstr(param_05,"c4_") || issubstr(param_05,"proximity_explosive_") || issubstr(param_05,"claymore_")) && isdefined(param_00.var_222))
			{
				param_02.var_6A00["returnToSender"] = param_00.var_222 == param_02;
				param_02.var_6A00["counterKill"] = isdefined(param_00.var_1390B);
				param_02.var_6A00["chainKill"] = isdefined(param_00.var_13908);
				param_02.var_6A00["bulletPenetrationKill"] = isdefined(param_00.var_1390E);
				param_02.var_6A00["cookedKill"] = 0;
			}

			if(isdefined(param_01.var_A991) && param_01.var_A991 >= gettime() - 50 && var_06)
			{
				param_02.var_6A00["suicideGrenadeKill"] = 1;
			}
		}

		if(var_06)
		{
			param_02.var_6A00["cookedKill"] = isdefined(param_00.var_9D93);
			param_02.var_6A00["throwbackKill"] = isdefined(param_00.var_117F3);
		}

		param_02.var_6A00["stickKill"] = isdefined(param_00.var_9F7D) && param_00.var_9F7D == "enemy";
		param_02.var_6A00["stickFriendlyKill"] = isdefined(param_00.var_9F7D) && param_00.var_9F7D == "friendly";
		if(isplayer(param_01) && param_01 != self && level.gametype != "aliens")
		{
			func_12EB3(param_00,param_01,param_05);
		}
	}

	if(issubstr(param_04,"MOD_IMPACT") && param_05 == "iw6_rgm_mp")
	{
		if(isplayer(param_01) && param_01 != self && level.gametype != "aliens")
		{
			func_12EB3(param_00,param_01,param_05);
		}
	}
}

//Function Number: 20
func_898D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = isdefined(param_01) && !isdefined(param_01.var_8712) && param_01.classname == "script_vehicle" || param_01.classname == "misc_turret" || param_01.classname == "script_model";
	if(var_0A && isdefined(param_01.var_8712))
	{
		var_0B = param_01.var_8712;
	}
	else
	{
		var_0B = param_02;
	}

	var_0C = "standard";
	if(isdefined(var_0B) && var_0B != param_02 && param_03 + param_08 + param_09 > 0 && !isdefined(param_06) || param_06 != "shield")
	{
		var_0D = !scripts\mp\_utility::func_9F19(param_02) || isagent(param_02) && param_03 >= param_02.health;
		if(param_02 scripts\mp\_heavyarmor::func_8BFA() || param_02 scripts\mp\_heavyarmor::func_8BFB())
		{
			var_0C = "hitjuggernaut";
		}
		else if(param_07 & level.var_92CA)
		{
			var_0C = "stun";
		}
		else if(function_0107(param_04) && isdefined(param_02.var_1177D) && param_02.var_1177D)
		{
			var_0C = "thermobaric_debuff";
		}
		else if(scripts\mp\_utility::func_9F93(param_05,param_04) && param_02 scripts\mp\_utility::_hasperk("specialty_stun_resistance"))
		{
			var_0C = "hittacresist";
		}
		else if(function_0107(param_04) && param_02 scripts\mp\_utility::_hasperk("specialty_blastshield") && !scripts\mp\_utility::func_13C9A(param_05,param_06) && !scripts\mp\_utility::func_9F7E(param_02,param_00,param_05,param_04))
		{
			var_0C = "hitblastshield";
		}
		else if(param_02 scripts\mp\_utility::_hasperk("specialty_combathigh"))
		{
			var_0C = "hitendgame";
		}
		else if(scripts\mp\_utility::func_8BF9(param_02))
		{
			var_0C = "hitlightarmor";
		}
		else if(param_08 > 0)
		{
			var_0C = "hitlightarmor";
		}
		else if(param_02 scripts\mp\_utility::func_9E59())
		{
			var_0C = "hitjuggernaut";
		}
		else if(param_02 scripts\mp\_utility::_hasperk("specialty_moreHealth"))
		{
			var_0C = "hitmorehealth";
		}
		else if(var_0B scripts\mp\_utility::_hasperk("specialty_moredamage"))
		{
			var_0C = "hitcritical";
			var_0B scripts\mp\_utility::func_E150("specialty_moredamage");
		}
		else if(param_02 scripts\mp\_utility::func_7E5C(param_00,param_01,param_02,param_03,param_04,param_05,param_06) < 0.95)
		{
			var_0C = "hitlowdamage";
		}
		else if(param_02 scripts\mp\_utility::isspawnprotected() && scripts\mp\_utility::func_9E6C(param_05))
		{
			var_0C = "hitspawnprotection";
		}
		else if(!func_100C1(param_05))
		{
			var_0C = "none";
		}

		var_0E = "high_damage";
		if(param_03 < 20)
		{
			var_0E = "low_damage";
		}

		var_0F = weaponclass(param_05) == "spread" || getweaponbasename(param_05) == "iw7_mauler_mpr" || issubstr(param_05,"iw7_crdb_mp");
		var_10 = !var_0F && scripts\mp\_utility::func_9E27(param_05,param_06,param_04,param_01);
		var_11 = 1;
		var_12 = param_04 == "MOD_MELEE";
		var_13 = "" + gettime();
		if(!var_12 && var_0F && isdefined(var_0B.var_CA01) && isdefined(var_0B.var_CA01[var_13]) && isdefined(var_0B.var_CA01[var_13][param_02.var_86BD]) && var_0B.var_CA01[var_13][param_02.var_86BD] > 1)
		{
			if(var_0D)
			{
				var_12 = 1;
			}
			else
			{
				var_11 = 0;
			}
		}

		if(var_11)
		{
			var_0B thread scripts\mp\_damagefeedback::func_12E84(var_0C,var_0D,var_10,var_0E,var_12);
		}
	}
}

//Function Number: 21
func_ABC3(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_00) && isdefined(param_00.var_4D3F))
	{
		param_01 = param_00.var_4D3F;
	}

	if(scripts\mp\_utility::func_9F7F(param_02,param_00,param_06,param_05))
	{
		param_03 = param_02.maxhealth;
	}

	if(isdefined(param_05) && param_05 != "MOD_IMPACT")
	{
		if(param_02 != param_01 && isdefined(param_00) && param_00.classname == "grenade" && param_02.var_A9F6 + 3500 > gettime() && isdefined(param_02.var_A9F4) && distance(param_00.origin,param_02.var_A9F4.origin) < 500)
		{
			param_03 = 0;
		}
	}

	if(param_03 < param_02.health)
	{
		param_02 notify("survived_explosion",param_01);
	}

	func_AFBC(param_00,param_01,param_02,param_03,param_05,param_06);
	return param_03;
}

//Function Number: 22
func_1177F()
{
	self endon("disconnect");
	level endon("game_ended");
	var_00 = gettime() + 5000;
	wait(0.05);
	self.var_1177D = 1;
	for(;;)
	{
		if(self.health == self.maxhealth)
		{
			self.var_1177D = 0;
			return;
		}

		if(gettime() >= var_00)
		{
			self.var_1177D = 0;
			return;
		}

		wait(0.05);
	}
}

//Function Number: 23
func_D3C4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = getweaponbasename(param_06);
	if(var_0C == "iw7_spas_mpr_focus")
	{
		var_0C = "iw7_spas_mpr";
	}
	else if(var_0C == "iw7_erad_mp_jump_spread")
	{
		var_0C = "iw7_erad_mp";
	}

	if(isdefined(var_0C))
	{
	}

	scripts\mp\_utility::func_D915("death",param_02);
	param_02 endon("spawned");
	param_02 notify("killed_player");
	param_02 func_1015A();
	var_0D = 0;
	self setblurforplayer(0,0);
	scripts\mp\_outline::func_C791(self);
	param_02.var_1519 = 0;
	param_02.var_CA55 = 0;
	param_02.var_4F = param_01;
	if(scripts\mp\_utility::func_7671(level.gametype))
	{
		if(param_02 != param_01 && param_05 == "MOD_CRUSH")
		{
			param_00 = param_02;
			param_01 = param_02;
			param_05 = "MOD_SUICIDE";
			param_06 = "none";
			param_08 = "none";
			param_02.var_2507 = [];
		}
	}

	if(param_06 == "none")
	{
		if(isdefined(param_00) && isdefined(param_00.var_28AF))
		{
			param_06 = param_00.var_28AF;
		}
	}

	if(isdefined(param_00) && !isplayer(param_00))
	{
		if(!isdefined(param_01))
		{
			if(isdefined(param_00.var_222))
			{
				param_01 = param_00.var_222;
			}
		}
		else if(!isplayer(param_01))
		{
			if(isdefined(param_00.var_222))
			{
				param_01 = param_00.var_222;
			}
		}
	}

	param_01 = scripts\mp\_utility::func_143A(param_01);
	if(isdefined(param_01))
	{
		param_01.var_23E8 = undefined;
	}

	if(isdefined(param_02.var_8C1F) && param_02.var_8C1F)
	{
		param_02 func_AAB5(param_03,param_05);
	}

	param_02 scripts\mp\_utility::func_E54E();
	scripts\mp\_weapons::func_DDEC();
	if(!param_0B)
	{
		if(isdefined(param_02.endgame))
		{
			scripts\mp\_utility::func_E2D8(2);
		}
		else
		{
			scripts\mp\_utility::func_E2D8(0);
			param_02 thermalvisionoff();
		}
	}
	else
	{
		param_02.var_6BA7 = 1;
		self notify("death");
	}

	if(game["state"] == "postgame")
	{
		return;
	}

	scripts\mp\perks\_perks::func_12E55(param_00,param_01,param_02,param_03,param_05,param_06,param_08,param_07);
	var_0E = 0;
	if(!isplayer(param_00) && isdefined(param_00.var_D8E1))
	{
		var_0F = param_00.var_D8E1;
	}
	else if(isdefined(param_02) && isplayer(param_02) && param_02 getcurrentprimaryweapon() != "none")
	{
		var_0F = param_02 getcurrentprimaryweapon();
	}
	else if(issubstr(param_07,"alt_"))
	{
		var_0F = getsubstr(param_07,4,param_07.size);
	}
	else
	{
		var_0F = undefined;
	}

	if(isdefined(param_02.var_1309F) || isdefined(param_02.var_AA0C) && param_05 == "MOD_SUICIDE")
	{
		param_02 func_65D2();
		param_02.var_1309F = undefined;
		param_00 = param_02.var_AA0C.var_6000;
		param_01 = param_02.var_AA0C.var_4F;
		param_03 = param_02.var_AA0C.var_92BA;
		param_05 = param_02.var_AA0C.var_10367;
		param_06 = param_02.var_AA0C.var_11329;
		var_0F = param_02.var_AA0C.var_10AA6;
		param_07 = param_02.var_AA0C.var_13190;
		param_08 = param_02.var_AA0C.var_FE38;
		var_0E = gettime() - param_02.var_AA0C.var_AA10 / 1000;
		param_02.var_AA0C = undefined;
		param_01 = scripts\mp\_utility::func_143A(param_01);
	}

	if(!isdefined(param_01) || param_01.classname == "trigger_hurt" || param_01.classname == "worldspawn" || param_01 == param_02)
	{
		var_10 = undefined;
		if(isdefined(self.var_2507) && self.var_2507.size > 0)
		{
			foreach(var_12 in self.var_2507)
			{
				if(!isdefined(scripts\mp\_utility::func_143A(var_12)))
				{
					continue;
				}

				if(!isdefined(param_02.var_24E5[var_12.var_86BD].var_DA))
				{
					continue;
				}

				if(var_12 == param_02 || level.teambased && var_12.team == param_02.team)
				{
					continue;
				}

				if(param_02.var_24E5[var_12.var_86BD].var_AA2D + 2500 < gettime() && param_01 != param_02 && isdefined(param_02.var_1B3) && param_02.var_1B3)
				{
					continue;
				}

				if(param_02.var_24E5[var_12.var_86BD].var_DA > 1 && !isdefined(var_10))
				{
					var_10 = var_12;
					continue;
				}

				if(isdefined(var_10) && param_02.var_24E5[var_12.var_86BD].var_DA > param_02.var_24E5[var_10.var_86BD].var_DA)
				{
					var_10 = var_12;
				}
			}
		}

		if(!isdefined(var_10))
		{
			if(isdefined(param_02.var_4EA0) && param_02.var_4EA0.size > 0)
			{
				var_14 = ["chargemode_mp","cryo_mine_mp","concussion_grenade_mp","super_trophy_mp","blackout_grenade_mp","blackhole_grenade_mp","power_spider_grenade_mp","emp_grenade_mp"];
				foreach(var_16 in var_14)
				{
					var_17 = scripts\mp\_gamescore::func_7E64(param_02,var_16);
					if(isdefined(var_17) && var_17.size > 0)
					{
						for(var_18 = var_17.size - 1;var_18 >= 0;var_18--)
						{
							var_19 = var_17[var_18];
							if(!isdefined(scripts\mp\_utility::func_143A(var_19)))
							{
								continue;
							}

							if(!scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(var_19,param_02)))
							{
								continue;
							}

							var_10 = var_19;
							if(!isdefined(param_02.var_24E5) || !isdefined(param_02.var_24E5[var_10.var_86BD]))
							{
								func_17AC(param_02,var_10,undefined,var_16,0,undefined,undefined,undefined,undefined,"MOD_EXPLOSIVE");
							}

							break;
						}
					}

					if(isdefined(var_10))
					{
						break;
					}
				}
			}
		}

		if(isdefined(var_10))
		{
			param_01 = var_10;
			param_01.var_23E8 = 1;
			param_06 = param_02.var_24E5[var_10.var_86BD].var_394;
			param_07 = param_02.var_24E5[var_10.var_86BD].var_13190;
			param_08 = param_02.var_24E5[var_10.var_86BD].var_FE38;
			param_09 = param_02.var_24E5[var_10.var_86BD].var_252;
			param_05 = param_02.var_24E5[var_10.var_86BD].var_10367;
			param_03 = param_02.var_24E5[var_10.var_86BD].var_DA;
			var_0F = param_02.var_24E5[var_10.var_86BD].var_10AA6;
			param_00 = param_01;
			var_0D = 1;
		}
	}

	lib_0E0B::func_13DFA(param_00,param_01,param_02,param_05,param_06);
	if(scripts\mp\_utility::func_9E27(param_06,param_08,param_05,param_01))
	{
		param_05 = "MOD_HEAD_SHOT";
	}
	else if(!isdefined(param_02.var_C1B7))
	{
		if(isdefined(level.var_4C4A))
		{
			[[ level.var_4C4A ]](param_02,param_05,param_00);
		}
		else if(param_05 != "MOD_MELEE")
		{
			param_02 scripts\mp\_utility::func_CF16();
		}
	}

	if(isdefined(level.var_4C47))
	{
		[[ level.var_4C47 ]](param_02,param_05,param_00);
	}

	if(isdefined(param_01) && isdefined(param_02) && param_05 == "MOD_MELEE")
	{
		var_1B = "defaultweapon_melee";
		if(getweaponbasename(param_06) == "iw7_nunchucks" || getweaponbasename(param_06) == "iw7_katana")
		{
			var_1B = "heavy_2s";
		}

		param_02 playrumbleonentity(var_1B);
		param_01 playrumbleonentity(var_1B);
	}

	var_1C = isfriendlyfire(param_02,param_01);
	if(isdefined(param_01))
	{
		if(param_01.var_9F == "script_vehicle" && isdefined(param_01.var_222))
		{
			param_01 = param_01.var_222;
		}

		if(param_01.var_9F == "misc_turret" && isdefined(param_01.var_222))
		{
			if(isdefined(param_01.var_131A0))
			{
				param_01.var_131A0 notify("killedPlayer",param_02);
			}

			param_01 = param_01.var_222;
		}

		if(isagent(param_01))
		{
			if(isdefined(param_01.agent_type))
			{
				if(param_01.agent_type == "dog")
				{
					param_06 = "guard_dog_mp";
				}
				else if(param_01.agent_type == "squadmate")
				{
					param_06 = "agent_support_mp";
				}
			}

			if(isdefined(param_01.var_222))
			{
				param_01 = param_01.var_222;
			}
		}

		if(param_01.var_9F == "script_model" && isdefined(param_01.var_222))
		{
			param_01 = param_01.var_222;
			if(!isfriendlyfire(param_02,param_01) && param_01 != param_02)
			{
				param_01 notify("crushed_enemy");
			}
		}
	}

	if(param_05 != "MOD_SUICIDE" && scripts\mp\_utility::func_9D2D(param_02) || scripts\mp\_utility::func_9D2D(param_01) && isdefined(level.var_2D9E) && isdefined(level.var_2D9E["get_attacker_ent"]))
	{
		var_1D = [[ level.var_2D9E["get_attacker_ent"] ]](param_01,param_00);
		if(isdefined(var_1D))
		{
			if(scripts\mp\_utility::func_9D2D(param_02))
			{
				param_02 botmemoryevent("death",param_06,var_1D.origin,param_02.origin,var_1D);
			}

			if(scripts\mp\_utility::func_9D2D(param_01))
			{
				var_1E = 1;
				if((var_1D.classname == "script_vehicle" && isdefined(var_1D.var_8DD9)) || var_1D.classname == "rocket" || var_1D.classname == "misc_turret")
				{
					var_1E = 0;
				}

				if(var_1E)
				{
					param_01 botmemoryevent("kill",param_06,var_1D.origin,param_02.origin,param_02);
				}
			}
		}
	}

	if(scripts\mp\_utility::func_9EF0(param_02))
	{
		param_02.var_D3E7 scripts\mp\_weapons::func_5D52(param_01);
		param_02.var_D3E7 [[ level.var_13C82 ]](param_01,param_05);
	}
	else
	{
		param_02 scripts\mp\_weapons::func_5D52(param_01,param_05);
		param_02 [[ level.var_13C82 ]](param_01,param_05);
	}

	if(!param_0B)
	{
		param_02 scripts\mp\_utility::func_12F19("dead");
		if(isplayer(param_01) && param_01 != param_02)
		{
			param_02 setclientomnvar("ui_killcam_killedby_id",param_01 getentitynumber());
		}
	}

	var_1F = isdefined(param_02.var_6BA7) && param_02.var_6BA7 && isdefined(param_02.var_11377) && param_02.var_11377;
	if(!var_1F)
	{
		param_02 scripts\mp\_playerlogic::func_E0FF();
	}

	if(!isdefined(param_02.var_11377))
	{
		var_20 = param_02;
		if(isdefined(param_02.var_4447))
		{
			var_20 = param_02.var_4447;
		}

		if(!isdefined(level.ignorescoring) && !var_1C)
		{
			var_20 scripts\mp\_utility::func_93DF("deaths",1,isdefined(level.ignorekdrstats));
			var_20.var_E9 = var_20 scripts\mp\_utility::getpersstat("deaths");
			var_20 scripts\mp\_utility::func_12EE8("kdRatio","kills","deaths",level.ignorekdrstats);
			var_20 scripts\mp\_persistence::func_10E56("round","deaths",var_20.var_E9,level.ignorekdrstats);
		}
	}

	if(isdefined(param_01) && isplayer(param_01))
	{
		param_01 func_3E23(param_02);
	}

	var_21 = param_06;
	var_22 = param_05;
	if(scripts\mp\_utility::func_9E6C(var_21) || isdefined(param_00.var_110E8))
	{
		var_23 = undefined;
		if(var_21 == "minijackal_assault_mp")
		{
			var_23 = 10042;
		}
		else if(isdefined(param_00.var_110E8))
		{
			if(isdefined(param_00.var_110E8.var_1318B) && param_00.var_110E8.var_1318B > 0)
			{
				var_23 = param_00.var_110E8.var_1318B;
			}
		}

		if(isdefined(var_23))
		{
			var_24 = level.var_110EC.rarity[var_23];
			var_25 = level.var_110EC.var_E76D[var_23];
			if(var_21 != "none")
			{
				var_21 = param_06 + "+loot" + var_25;
				var_22 = "MOD_SCORESTREAK";
			}

			param_02.killsteakvariantattackerinfo = spawnstruct();
			param_02.killsteakvariantattackerinfo.var_92B8 = var_23;
			param_02.killsteakvariantattackerinfo.rarity = var_24;
		}
	}

	if(isdefined(var_21) && scripts\mp\_utility::func_821D(var_21) == "iw7_axe_mp" && isdefined(param_01) && param_01 getweaponammoclip(var_21) > 0)
	{
		var_22 = "MOD_IMPACT";
	}

	obituary(param_02,param_01,var_21,var_22);
	var_26 = 0;
	var_27 = 1;
	param_02 scripts\mp\_clientmatchdata::func_AFD5(param_01);
	var_28 = param_02.var_B3E3;
	if(!isdefined(var_28))
	{
		var_28 = level.var_B4AF - 1;
	}

	param_02 scripts\mp\_matchdata::func_AFD5(var_28,param_01,param_03,param_05,param_06,var_0F,param_08);
	param_02 scripts\mp\_analyticslog::func_AFA7();
	param_02 scripts\mp\_analyticslog::func_AFA9(param_01,param_05,param_06);
	if(isplayer(param_01))
	{
		param_01 scripts\mp\_analyticslog::func_AFAA(param_02,param_05,param_06);
	}

	param_02 func_12E85(self.var_2507,self.var_24E5);
	param_02 func_41D5();
	param_02.deathspectatepos = undefined;
	if(param_02 func_9F91())
	{
		func_89F1();
	}
	else if(!isplayer(param_01) || isplayer(param_01) && param_05 == "MOD_FALLING" && !isdefined(param_02.var_115FC) && !param_02.var_115FC)
	{
		param_02.deathspectatepos = param_02.origin;
		func_89FC(param_01,var_28,param_05,param_08);
		if(isagent(param_01))
		{
			var_26 = 1;
		}
	}
	else if(param_01 == param_02 || !scripts\mp\_utility::playersareenemies(param_01,param_02) && scripts\mp\_utility::isdronepackage(param_00))
	{
		func_89ED(param_05,param_08);
	}
	else if(var_1C)
	{
		if(!isdefined(param_02.var_C1B7) || param_06 == "bomb_site_mp")
		{
			func_89A8(param_01);
		}
	}
	else
	{
		if(param_05 == "MOD_GRENADE" && param_00 == param_01)
		{
			func_17AC(param_02,param_01,param_00,param_06,param_03,(0,0,0),param_07,param_08,param_09,param_05);
		}

		if(param_01 scripts\mp\_utility::_hasperk("specialty_chain_reaction"))
		{
			if(param_05 == "MOD_EXPLOSIVE" || param_05 == "MOD_GRENADE_SPLASH" || param_05 == "MOD_GRENADE")
			{
				param_02 scripts\mp\perks\_perkfunctions::func_10D79(param_01);
			}
		}

		if(param_06 == "case_bomb_mp")
		{
			param_01 thread scripts\mp\_weapons::func_3B0D(param_02,param_02.origin);
		}

		var_26 = 1;
		if(isai(param_02) && isdefined(level.var_2D9E) && isdefined(level.var_2D9E["should_do_killcam"]))
		{
			var_26 = param_02 [[ level.var_2D9E["should_do_killcam"] ]]();
		}

		if(isdefined(level.var_5547) && level.var_5547)
		{
			var_26 = 0;
		}

		func_89CA(var_28,param_01,param_00,param_06,param_05,param_02,param_04);
		param_02 thread scripts\mp\_missions::func_D3C3(param_00,param_01,param_03,param_04,param_05,param_06,var_0F,param_08,param_01.var_B930);
		param_01 thread scripts\mp\_intelchallenges::func_99BA(param_02,param_00,param_06,param_05,param_01.var_B930);
		param_01 thread scripts\mp\contractchallenges::contractkillsimmediate(param_02,param_00,param_06,param_05,param_01.var_B930);
		param_02.pers["cur_death_streak"]++;
		if(isplayer(param_01) && param_02 scripts\mp\_utility::func_9E59())
		{
			if(isdefined(param_02.var_9E5D) && param_02.var_9E5D)
			{
				param_01 thread scripts\mp\_utility::func_115DE("callout_killed_maniac",param_01);
				if(param_05 == "MOD_MELEE")
				{
					param_01 scripts\mp\_missions::func_D992("ch_thisisaknife");
				}
			}
			else if(isdefined(param_02.var_9E5C) && param_02.var_9E5C)
			{
				param_01 thread scripts\mp\_utility::func_115DE(level.var_B332,param_01);
			}
			else
			{
				param_01 thread scripts\mp\_utility::func_115DE("callout_killed_juggernaut",param_01);
			}
		}
	}

	var_29 = 0;
	var_2A = undefined;
	if(isdefined(self.var_D8B0))
	{
		var_29 = 1;
		var_2A = self.var_D8B0;
		self.var_D8B0 = undefined;
	}

	if(isplayer(param_01) && param_01 != self && !level.teambased || level.teambased && self.team != param_01.team)
	{
		if(var_29 && isdefined(var_2A))
		{
			var_2B = var_2A;
		}
		else
		{
			var_2B = self.var_A978;
		}

		var_2B = scripts\mp\_utility::func_13CA1(var_2B,param_00);
		thread scripts\mp\_gamelogic::func_11AF7(var_2B,param_05);
		param_01 thread scripts\mp\_gamelogic::func_11AC8(param_06,param_05);
	}

	param_02 func_E264();
	param_02 resetplayeromnvarsonspawn();
	param_02.var_1B1 = param_01;
	param_02.var_A972 = param_02.origin;
	param_02.var_4E72 = gettime();
	param_02.var_138DD = 0;
	param_02.var_E4A8 = 0;
	param_02.var_EB14 = 0;
	param_02.var_110F4 = scripts\mp\_class::func_AE33(param_02.var_110F4);
	if(scripts\mp\killstreaks\_killstreaks::func_110F5(param_02.var_110F4))
	{
		if(!level.var_3B1E && !param_02 scripts\mp\_utility::_hasperk("specialty_support_killstreaks"))
		{
			param_02 scripts\mp\killstreaks\_killstreaks::func_E275();
		}
	}

	var_2C = undefined;
	if(var_0D || level.teambased && isdefined(param_01.team) && param_01.team == param_02.team)
	{
		var_26 = 0;
		var_27 = 0;
	}

	if(param_0B)
	{
		var_26 = 0;
		param_0A = param_02 method_8231(param_00,param_05,param_06,param_08,param_07);
	}

	if(isdefined(param_01) && isplayer(param_01) && isdefined(param_05) && isdefined(param_06) && isdefined(param_08) && isdefined(param_07))
	{
		var_2D = scripts\mp\_utility::func_8234(param_06);
		var_2E = param_01 method_8519(param_06);
		if(isdefined(var_2D) && var_2D == "iw7_rvn" && scripts\mp\_utility::func_9FB3(var_2E) && param_05 == "MOD_MELEE")
		{
			param_0A = param_02 method_8231(param_01,"MOD_EXPLOSIVE",param_06,param_08,param_07);
			var_2F = function_02C4(param_06);
			if(!isdefined(var_2F) || var_2F != 3 && var_2F != 35)
			{
				playsoundatpos(param_02.origin,"melee_user2_human_default_fatal_npc");
			}
		}
	}

	if(!isdefined(self.nocorpse))
	{
		param_02.var_2C09 = param_02 method_8086(param_0A);
		if(param_02 method_84CA())
		{
			param_02.var_2C09 setscriptablepartstate("chargeModeShieldDrop","active",0);
		}

		if(scripts\mp\_utility::func_9FB3(level.var_DC24))
		{
			thread scripts\mp\_weapons::throwingknife_detachknivesfromcorpse(param_02.var_2C09);
			thread scripts\mp\_weapons::axedetachfromcorpse(param_02.var_2C09);
		}
	}

	if(!isdefined(self.nocorpse) && isdefined(param_02.var_2C09))
	{
		param_02.var_2C09.var_336 = "player_corpse";
		if((scripts\common\utility::func_9D74(param_05) && scripts\mp\_utility::func_821D(param_06) == "iw7_atomizer_mp") || param_06 == "nuke_mp")
		{
			var_30 = undefined;
			if(param_06 == "nuke_mp")
			{
				var_30 = "ks_nuke_death_npc";
			}

			param_02.var_2C09 thread scripts\mp\archetypes\archassassin_utility::func_CEF1(var_30);
			param_02.var_2C09 hide(1);
		}

		enqueueweapononkillcorpsetablefuncs(param_01,param_02,param_00,param_06,param_05);
		param_02 thread callcorpsetablefuncs();
		if(param_0B)
		{
			param_02 method_8232();
			param_02 setsolid(0);
		}

		if(param_02 method_81B5() || param_02 ismantling() || !param_02 isonground() || isdefined(param_02.var_C1B7) || isdefined(param_02.var_4C87) || scripts\mp\_utility::func_9F13())
		{
			var_31 = 0;
			if(param_05 == "MOD_MELEE")
			{
				if((isdefined(param_02.var_9EE6) && param_02.var_9EE6) || isdefined(param_02.var_C1B7))
				{
					var_31 = 1;
				}
			}

			if(!var_31 || scripts\mp\_utility::func_9F13())
			{
				param_02.var_2C09 method_839A(1);
				param_02 notify("start_instant_ragdoll",param_05,param_00);
			}
		}

		if(!isdefined(param_02.var_11377))
		{
			if(isdefined(param_01) && isplayer(param_01) && !param_01 scripts\mp\_utility::_hasperk("specialty_silentkill"))
			{
				thread scripts\mp\_deathicons::func_17C1(param_02.var_2C09,param_02,param_02.team,5);
			}
		}

		thread func_5124(param_02.var_2C09,param_08,param_07,param_06,param_00,param_05);
	}
	else if(isdefined(self.nocorpse))
	{
		param_02.var_2C09 = param_02 method_8086(param_0A);
		param_02.var_2C09 hide(1);
		if(level.var_B335 == "mp_neon")
		{
			thread scripts\mp\_weapons::throwingknife_detachknivesfromcorpse(param_02.var_2C09);
			thread scripts\mp\_weapons::axedetachfromcorpse(param_02.var_2C09);
		}
	}

	param_02 thread scripts\mp\_supers::func_898E();
	updatecombatrecordkillstats(param_01,param_02,param_05,param_06);
	param_02 thread [[ level.var_C577 ]](param_00,param_01,param_03,param_05,param_06,param_07,param_08,param_09,param_0A,var_28);
	if(isai(param_02) && isdefined(level.var_2D9E) && isdefined(level.var_2D9E["on_killed"]))
	{
		param_02 thread [[ level.var_2D9E["on_killed"] ]](param_00,param_01,param_03,param_05,param_06,param_07,param_08,param_09,param_0A,var_28);
	}

	if(scripts\mp\_utility::func_9E0E(param_01))
	{
		var_32 = param_01 getentitynumber();
	}
	else
	{
		var_32 = -1;
	}

	if(!isdefined(var_2C))
	{
		var_2C = param_02 scripts\mp\_killcam::func_7F32(param_01,param_00,param_06);
	}

	if(isdefined(level.var_B3FC) && isdefined(param_00) && isplayer(param_00) && scripts\common\utility::func_9D74(param_05))
	{
		var_33 = param_00.origin - self.origin;
		var_34 = vectornormalize((var_33[0],var_33[1],0));
		var_35 = anglestoforward(self.angles);
		var_36 = vectornormalize((var_35[0],var_35[1],0));
		var_37 = clamp(var_36[0] * var_34[0] + var_36[1] * var_34[1],-1,1);
		var_38 = acos(var_37);
		if(!isdefined(self.var_D37E))
		{
			self.var_D37E = [];
		}

		self.var_D37E[self.var_D37E.size] = var_38;
		var_39 = 0;
		if(isdefined(self.var_658D))
		{
			var_39 = gettime() - self.var_658D;
		}

		if(!isdefined(self.var_658E))
		{
			self.var_658E = [];
		}

		self.var_658E[self.var_658E.size] = var_39;
		self.var_658D = undefined;
	}

	var_3A = -1;
	var_3B = 0;
	if(isdefined(var_2C))
	{
		var_3A = var_2C getentitynumber();
		var_3B = var_2C.var_64;
		if(!isdefined(var_3B))
		{
			var_3B = 0;
		}
	}

	var_3C = param_05 == "MOD_IMPACT" || param_05 == "MOD_HEADSHOT" && isdefined(param_00) || param_05 == "MOD_GRENADE" || isdefined(param_02) && isdefined(param_02.var_1117F) && isdefined(param_00) && param_02.var_1117F == param_00 || param_06 == "throwingknifec4_mp";
	if(!scripts\mp\_utility::func_9E6C(param_06))
	{
		scripts\mp\_killcam::func_F770(param_06,param_05,param_00);
	}

	if(level.var_DDEE && var_27)
	{
		if((!isdefined(level.var_5547) || !level.var_5547) && param_05 != "MOD_SUICIDE" && !!isdefined(param_01) || param_01.classname == "trigger_hurt" || param_01.classname == "worldspawn" || param_01 == param_02)
		{
			scripts\mp\_final_killcam::func_DDEE(5,param_02,param_01,var_32,param_00,var_3A,var_3B,var_3C,param_06,var_0E,param_09,param_05);
		}
	}

	param_02 setplayerdata("common","killCamHowKilled",0);
	switch(param_05)
	{
		case "MOD_HEAD_SHOT":
			param_02 setplayerdata("common","killCamHowKilled",1);
			break;

		default:
			break;
	}

	var_3D = undefined;
	if(var_26)
	{
		param_02 scripts\mp\_killcam::func_D83E(param_00,param_01);
		if(isdefined(param_00) && isagent(param_00))
		{
			var_3D = spawnstruct();
			var_3D.agent_type = param_00.agent_type;
			var_3D.var_A9F6 = param_00.var_A9F6;
		}
	}

	if(!param_0B)
	{
		self.var_E29A = gettime() + 1750;
		var_3E = scripts\mp\_playerlogic::func_1193A(1);
		if(var_3E < 1)
		{
			var_3E = 1;
		}

		param_02 thread scripts\mp\_playerlogic::func_D81E(var_3E);
		wait(1.75);
		if(var_26)
		{
			var_26 = !scripts\mp\_final_killcam::func_10266(0.5);
		}

		param_02 notify("death_delay_finished");
	}

	var_3F = gettime() - param_02.var_4E72 / 1000;
	self.var_E29A = gettime();
	var_26 = var_26 && !param_02 scripts\mp\_battlebuddy::func_3876();
	if(!isdefined(param_02.var_3881) && param_02.var_3881 && var_26 && level.var_A636 && game["state"] == "playing" && !param_02 scripts\mp\_utility::func_9FC6() && !level.var_10130)
	{
		var_40 = !scripts\mp\_utility::func_7ECE() && !param_02.pers["lives"];
		var_3E = scripts\mp\_playerlogic::func_1193A(1);
		var_41 = var_40 && var_3E <= 0;
		if(!var_40)
		{
			var_3E = -1;
			level notify("player_eliminated",param_02);
		}

		if(!isdefined(param_01))
		{
			var_42 = [];
		}
		else
		{
			var_42 = param_02.pers["loadoutPerks"];
		}

		var_43 = undefined;
		if(isdefined(param_02.killsteakvariantattackerinfo))
		{
			var_43 = param_02.killsteakvariantattackerinfo;
		}

		param_02 scripts\mp\_killcam::func_A636(param_00,var_3D,var_32,var_3A,var_3B,undefined,var_3C,param_06,var_3F + var_0E,param_09,var_3E,scripts\mp\_gamelogic::func_11939(),param_01,param_02,param_05,var_42,var_43);
	}

	if(game["state"] != "playing")
	{
		if(!level.var_10130)
		{
			param_02 scripts\mp\_utility::func_12F19("dead");
			param_02 scripts\mp\_utility::func_41BF();
		}

		return;
	}

	var_44 = scripts\mp\_utility::func_7ECE();
	var_45 = self.pers["lives"];
	if(self == param_02 && isdefined(param_02.var_28CC) && scripts\mp\_utility::func_9F19(param_02.var_28CC) && !scripts\mp\_utility::func_7ECE() || self.pers["lives"] && !param_02 scripts\mp\_utility::func_9FC6())
	{
		scripts\mp\_battlebuddy::func_136D6();
	}

	if(scripts\mp\_utility::func_9FD4(param_02.var_4004))
	{
		if(isdefined(level.var_1674) && level.var_1674.team == param_02.team)
		{
			param_02 scripts\mp\killstreaks\_orbital_deployment::func_10DD3("orbital_deployment",1);
		}
		else
		{
			param_02 thread scripts\mp\_playerlogic::func_1083A();
		}
	}

	param_02.var_4F = undefined;
}

//Function Number: 24
func_9F91()
{
	if(isdefined(self.var_11377))
	{
		return 1;
	}

	return 0;
}

//Function Number: 25
func_9FA0()
{
	var_00 = scripts\mp\_teams::func_46BB();
	var_00[self.var_AB33]--;
	var_00[self.var_A49E]++;
	return var_00[self.var_A49E] - var_00[self.var_AB33] < 2;
}

//Function Number: 26
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

//Function Number: 27
func_A656(param_00)
{
	if(!isplayer(param_00))
	{
		return 0;
	}

	if(param_00 != self)
	{
		return 0;
	}

	return 1;
}

//Function Number: 28
func_89F1()
{
	if(!level.teambased)
	{
		return;
	}

	if(self.var_A49E == "spectator" || !func_9FA0())
	{
		thread scripts\mp\_utility::func_83B4("suicide",undefined,undefined,1,1);
		scripts\mp\_utility::func_93DF("suicides",1);
		self.var_111BB = scripts\mp\_utility::getpersstat("suicides");
	}

	if(isdefined(level.var_C5B0))
	{
		[[ level.var_C5B0 ]](self);
	}
}

//Function Number: 29
func_89FC(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_00.team))
	{
		func_89ED(param_02,param_03);
		return;
	}

	if((level.teambased && param_00.team != self.team) || !level.teambased)
	{
		if(isdefined(level.var_C55E) && isplayer(param_00) || isagent(param_00) && param_00.team != "spectator")
		{
			if(!level.var_7669)
			{
				[[ level.var_C55E ]](self,param_00,param_01,param_02);
				return;
			}
		}
	}
}

//Function Number: 30
func_89ED(param_00,param_01)
{
	thread scripts\mp\_utility::func_83B4("suicide");
	scripts\mp\_utility::func_93DF("suicides",1);
	self.var_111BB = scripts\mp\_utility::getpersstat("suicides");
	var_02 = scripts\mp\_tweakables::func_81E7("game","suicidepointloss");
	scripts\mp\_gamescore::func_13D4(self,scripts\mp\_gamescore::func_12B4(self) - var_02);
	if(scripts\mp\_weapons::func_85BE() && param_00 == "MOD_SUICIDE" && param_01 == "none")
	{
		self.var_A991 = gettime();
	}

	if(isdefined(level.var_C5AA))
	{
		[[ level.var_C5AA ]](self);
	}

	if(isdefined(self.var_7408))
	{
		scripts\mp\_hud_message::func_10122("MP_FRIENDLY_FIRE_WILL_NOT");
	}
}

//Function Number: 31
func_89A8(param_00)
{
	param_00 thread scripts\mp\_rank::func_EC2D("teamkill");
	param_00.pers["teamkills"] = param_00.pers["teamkills"] + 1;
	param_00.var_115D5++;
	if(scripts\mp\_tweakables::func_81E7("team","teamkillpointloss"))
	{
		var_01 = scripts\mp\_rank::func_8104("kill");
		scripts\mp\_gamescore::func_13D4(param_00,scripts\mp\_gamescore::func_12B4(param_00) - var_01);
	}

	if(level.var_B47A < 0)
	{
		return;
	}

	if(level.ingraceperiod)
	{
		var_02 = 1;
		param_00.pers["teamkills"] = param_00.pers["teamkills"] + level.var_B47A;
	}
	else if(var_02.pers["teamkills"] > 1 && scripts\mp\_utility::func_81CB() < level.var_8487 * 1000 + 8000 + var_02.pers["teamkills"] * 1000)
	{
		var_02 = 1;
		param_00.pers["teamkills"] = param_00.pers["teamkills"] + level.var_B47A;
	}
	else
	{
		var_02 = var_02 scripts\mp\_playerlogic::func_115D4();
	}

	if(var_02 > 0)
	{
		param_00.pers["teamKillPunish"] = 1;
		param_00 scripts\mp\_utility::func_1417();
	}
}

//Function Number: 32
func_89CA(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_01 thread scripts\mp\_events::func_A651(param_00,self,param_03,param_04,param_06,param_02);
	if(param_04 == "MOD_HEAD_SHOT")
	{
		param_01 scripts\mp\_utility::func_93DF("headshots",1);
		param_01.var_8CA0 = param_01 scripts\mp\_utility::getpersstat("headshots");
		if(isdefined(param_01.var_1B3))
		{
			var_07 = scripts\mp\_rank::func_8104("kill") * 2;
		}
		else
		{
			var_07 = undefined;
		}

		param_01 playlocalsound("bullet_impact_headshot_plr");
		self playsound("bullet_impact_headshot");
	}
	else if(isdefined(param_02.var_1B3))
	{
		var_07 = scripts\mp\_rank::func_8104("kill") * 2;
	}
	else
	{
		var_07 = undefined;
	}

	var_08 = param_01;
	if(isdefined(param_01.var_4447))
	{
		var_08 = param_01.var_4447;
	}

	if(!scripts\mp\_utility::func_9FB3(level.ignorescoring) && !isfriendlyfire(param_05,param_01))
	{
		var_08 scripts\mp\_utility::func_93DF("kills",1,isdefined(level.ignorekdrstats));
		var_08.var_1AB = var_08 scripts\mp\_utility::getpersstat("kills");
		var_08 scripts\mp\_utility::func_12EE8("kdRatio","kills","deaths",level.ignorekdrstats);
		var_08 scripts\mp\_persistence::func_10E56("round","kills",var_08.var_1AB,level.ignorekdrstats);
	}

	self method_83FF();
	param_01 method_83FE();
	var_09 = param_01.pers["cur_kill_streak"];
	if(!scripts\mp\_utility::func_9FB3(level.ignorescoring) && isalive(param_01) || param_01.var_110F4 == "support")
	{
		if((param_04 == "MOD_MELEE" && !param_01 scripts\mp\_utility::func_9E59()) || param_01 scripts\mp\_utility::func_A679(param_03))
		{
			param_01 func_DEFA(param_03,param_04,1);
		}

		if(param_01.pers["cur_kill_streak"] > param_01 scripts\mp\_utility::getpersstat("longestStreak"))
		{
			param_01 scripts\mp\_utility::setpersstat("longestStreak",param_01.pers["cur_kill_streak"]);
		}
	}

	param_01.pers["cur_death_streak"] = 0;
	if(!scripts\mp\_utility::func_9FB3(level.ignorescoring) && param_01.pers["cur_kill_streak"] > param_01 scripts\mp\_persistence::func_10E35("round","killStreak"))
	{
		param_01 scripts\mp\_persistence::func_10E56("round","killStreak",param_01.pers["cur_kill_streak"]);
	}

	if(!scripts\mp\_utility::func_9FB3(level.ignorescoring) && param_01 scripts\mp\_utility::func_DCD5())
	{
		if(param_01.pers["cur_kill_streak"] > param_01.var_A61A)
		{
			param_01 scripts\mp\_persistence::func_10E54("killStreak",param_01.pers["cur_kill_streak"]);
			param_01.var_A61A = param_01.pers["cur_kill_streak"];
		}
	}

	if(!scripts\mp\_utility::func_9E6C(param_03))
	{
		param_01 thread scripts\mp\_utility::func_83B4("kill",param_03);
		if(param_01 scripts\mp\_utility::_hasperk("specialty_hardline") && isdefined(param_01.hardlineactive))
		{
			param_01 thread scripts\mp\_utility::givestreakpointswithtext("assist_hardline",param_03,undefined);
		}
	}

	var_0A = scripts\mp\_tweakables::func_81E7("game","deathpointloss");
	scripts\mp\_gamescore::func_13D4(self,scripts\mp\_gamescore::func_12B4(self) - var_0A);
	if(isdefined(level.var_1541) && level.var_1541 == param_01)
	{
		level notify("ai_killed",self,param_01,param_04,param_03);
	}

	if(isdefined(param_01.var_C2D3))
	{
		level notify("odin_killed_player",self);
	}

	level notify("player_got_killstreak_" + param_01.pers["cur_kill_streak"],param_01);
	param_01 notify("got_killstreak",param_01.pers["cur_kill_streak"]);
	param_01 notify("killed_enemy",self,param_03,param_04);
	if(isdefined(level.var_C55E) && param_01.pers["team"] != "spectator" && !isdefined(level.ignorescoring))
	{
		[[ level.var_C55E ]](self,param_01,param_00,param_04,param_03);
	}

	level thread scripts\mp\_battlechatter_mp::func_EB85(param_01,"kill",0.75);
	var_0B = undefined;
	switch(param_05.var_AE62)
	{
		case "archetype_assault":
			var_0B = "plr_killfirm_warfighter";
			break;

		case "archetype_assassin":
			var_0B = "plr_killfirm_ftl";
			break;

		case "archetype_heavy":
			var_0B = "plr_killfirm_merc";
			break;

		case "archetype_scout":
			var_0B = "plr_killfirm_c6";
			break;

		case "archetype_engineer":
			var_0B = "plr_killfirm_stryker";
			break;

		case "archetype_sniper":
			var_0B = "plr_killfirm_ghost";
			break;
	}

	if(isdefined(var_0B))
	{
		level thread scripts\mp\_battlechatter_mp::func_EB87(param_01,var_0B,"plr_killfirm_generic",0.75);
	}

	if(isdefined(self.var_A93F) && isdefined(self.var_A940) && self.var_A93F != param_01)
	{
		if(gettime() - self.var_A940 < 2500)
		{
			self.var_A93F thread scripts\mp\_gamescore::func_D9B5(self);
		}
		else if(isalive(self.var_A93F) && gettime() - self.var_A940 < 5000)
		{
			var_0C = vectornormalize(anglestoforward(self.angles));
			var_0D = vectornormalize(self.var_A93F.origin - self.origin);
			if(vectordot(var_0D,var_0C) > 0.925)
			{
				self.var_A93F thread scripts\mp\_gamescore::func_D9B5(self);
			}
		}
	}

	scripts\mp\_gamescore::func_26CD(param_01,self);
	if(isdefined(self.var_2507))
	{
		foreach(var_0F in self.var_2507)
		{
			if(!isdefined(scripts\mp\_utility::func_143A(var_0F)))
			{
				continue;
			}

			if(var_0F == param_01)
			{
				continue;
			}

			if(self == var_0F)
			{
				continue;
			}

			if(isdefined(level.var_23E9))
			{
				continue;
			}

			var_10 = undefined;
			if(isdefined(self.var_24E5))
			{
				var_11 = self.var_24E5[var_0F.var_86BD];
				if(isdefined(var_11))
				{
					var_10 = var_11.var_394;
				}
			}

			var_12 = 0;
			if(self.var_24E5[var_0F.var_86BD].var_DA >= 75)
			{
				var_12 = 1;
			}

			var_0F thread scripts\mp\_gamescore::func_D98C(self,var_10,var_12);
			if(var_0F scripts\mp\_utility::_hasperk("specialty_boom"))
			{
				param_05 thread scripts\mp\perks\_perkfunctions::func_F671(var_0F);
			}
		}
	}

	if(isdefined(self.var_B370))
	{
		foreach(var_0F in level.players)
		{
			if(var_0F.team == self.team)
			{
				continue;
			}

			if(scripts\common\utility::func_2286(self.var_2507,var_0F))
			{
				continue;
			}

			if(scripts\mp\_utility::func_2287(self.var_B370,var_0F scripts\mp\_utility::func_81EC()))
			{
				var_0F thread scripts\mp\_gamescore::func_D98C(self,param_03);
			}
		}
	}

	if(level.teambased)
	{
		if(isdefined(level.var_12AF3[param_01.team]) && level.var_12AF3[param_01.team].size > 0)
		{
			var_16 = [];
			foreach(var_18 in level.var_12AF3[param_01.team])
			{
				if(isdefined(var_18) && isdefined(var_18.var_222) && var_18.var_222 != param_01 && !scripts\common\utility::func_693B(var_16,var_18.var_12AFA))
				{
					var_19 = undefined;
					if(scripts\mp\killstreaks\_utility::func_A69F(var_18.var_110E8,"passive_extra_assist"))
					{
						var_19 = 20;
					}

					var_18.var_222 thread scripts\mp\_utility::func_83B4(var_18.var_12AFA + "_assist",undefined,var_19);
					var_16[var_16.size] = var_18.var_12AFA;
					scripts\mp\_missions::func_D9BC(var_18.var_222,var_18.var_12AFA);
					var_18.var_222 scripts\mp\_utility::func_316C("update_uav_assist_buffered");
					var_18.var_222 combatrecordkillstreakstat(var_18.var_12AFA);
				}
			}
		}
	}

	if(isdefined(self.var_12AF8))
	{
		self.var_12AF8 = [];
	}
}

//Function Number: 33
func_9EFE(param_00)
{
	if(weaponclass(param_00) == "non-player")
	{
		return 0;
	}

	if(weaponclass(param_00) == "turret")
	{
		return 0;
	}

	if(function_0244(param_00) == "primary" || function_0244(param_00) == "altmode")
	{
		return 1;
	}

	return 0;
}

//Function Number: 34
func_3751(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	func_D3C4(param_00,param_01,self,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,0);
}

//Function Number: 35
func_DB98(param_00)
{
	var_01 = 5;
	if(!isdefined(level.var_FCA4))
	{
		level.var_FCA4 = [];
	}

	if(level.var_FCA4.size >= var_01)
	{
		var_02 = level.var_FCA4.size - 1;
		level.var_FCA4[0] delete();
		for(var_03 = 0;var_03 < var_02;var_03++)
		{
			level.var_FCA4[var_03] = level.var_FCA4[var_03 + 1];
		}

		level.var_FCA4[var_02] = undefined;
	}

	level.var_FCA4[level.var_FCA4.size] = param_00;
}

//Function Number: 36
func_AAB5(param_00,param_01)
{
	if(isdefined(self.var_8C1F) && self.var_8C1F)
	{
		if(isdefined(self.var_E55A))
		{
			scripts\mp\_utility::func_E54F(1);
			return;
		}

		if(isdefined(self.var_E55B))
		{
			scripts\mp\_utility::func_E54F(0);
			return;
		}
	}
}

//Function Number: 37
func_3E0D()
{
	if(level.var_54CC != 1)
	{
		return 0;
	}

	if(!scripts\mp\_utility::func_7ECE())
	{
		return 0;
	}

	if(level.var_AD8D[self.team] > 0)
	{
		return 0;
	}

	foreach(var_01 in level.players)
	{
		if(!isalive(var_01))
		{
			continue;
		}

		if(var_01.team != self.team)
		{
			continue;
		}

		if(var_01 == self)
		{
			continue;
		}

		if(!var_01.inlaststand)
		{
			return 0;
		}
	}

	foreach(var_01 in level.players)
	{
		if(!isalive(var_01))
		{
			continue;
		}

		if(var_01.team != self.team)
		{
			continue;
		}

		if(var_01.inlaststand && var_01 != self)
		{
			var_01 func_AA07(0);
		}
	}

	return 1;
}

//Function Number: 38
func_3E23(param_00)
{
	if(scripts\mp\_utility::func_B3EC())
	{
		return;
	}

	var_01 = 0;
	var_02 = undefined;
	if(isdefined(param_00.var_24E5) && param_00.var_24E5.size > 1)
	{
		foreach(var_04 in param_00.var_24E5)
		{
			if(var_04.var_DA > var_01)
			{
				var_01 = var_04.var_DA;
				var_02 = var_04.var_24E7;
			}
		}
	}
}

//Function Number: 39
func_E264()
{
	self.var_11377 = undefined;
	self.var_A49E = undefined;
	self.var_AB33 = undefined;
	self.pers["cur_kill_streak"] = 0;
	self.pers["cur_kill_streak_for_nuke"] = 0;
	scripts\mp\_gameobjects::func_5397();
}

//Function Number: 40
resetplayeromnvarsonspawn()
{
	self setclientomnvar("ui_carrying_bomb",0);
	self setclientomnvar("ui_objective_state",0);
	self setclientomnvar("ui_securing",0);
	self setclientomnvar("ui_light_armor",0);
	self setclientomnvar("ui_juiced_end_milliseconds",0);
	self setclientomnvar("ui_killcam_end_milliseconds",0);
	self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",0);
	self setclientomnvar("ui_edge_glow",0);
}

//Function Number: 41
func_9039(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_05[0] = 2;
	var_05[1] = 3;
	var_05[2] = 5;
	var_05[3] = 7;
	if(!getdvarint("scr_hitloc_debug"))
	{
		return;
	}

	if(!isdefined(param_00.var_903A))
	{
		for(var_06 = 0;var_06 < 6;var_06++)
		{
			param_00 setclientdvar("ui_hitloc_" + var_06,"");
		}

		param_00.var_903A = 1;
	}

	if(level.splitscreen || !isplayer(param_00))
	{
		return;
	}

	var_07 = 6;
	if(!isdefined(param_00.var_4D53))
	{
		param_00.var_4D53 = [];
		for(var_06 = 0;var_06 < var_07;var_06++)
		{
			param_00.var_4D53[var_06] = spawnstruct();
			param_00.var_4D53[var_06].var_DA = 0;
			param_00.var_4D53[var_06].var_9038 = "";
			param_00.var_4D53[var_06].var_2F34 = 0;
			param_00.var_4D53[var_06].var_A4A1 = 0;
			param_00.var_4D53[var_06].var_43A6 = 0;
		}

		param_00.var_4D54 = 0;
		param_00.var_4D55 = undefined;
	}

	for(var_06 = var_07 - 1;var_06 > 0;var_06--)
	{
		param_00.var_4D53[var_06].var_DA = param_00.var_4D53[var_06 - 1].var_DA;
		param_00.var_4D53[var_06].var_9038 = param_00.var_4D53[var_06 - 1].var_9038;
		param_00.var_4D53[var_06].var_2F34 = param_00.var_4D53[var_06 - 1].var_2F34;
		param_00.var_4D53[var_06].var_A4A1 = param_00.var_4D53[var_06 - 1].var_A4A1;
		param_00.var_4D53[var_06].var_43A6 = param_00.var_4D53[var_06 - 1].var_43A6;
	}

	param_00.var_4D53[0].var_DA = param_02;
	param_00.var_4D53[0].var_9038 = param_03;
	param_00.var_4D53[0].var_2F34 = param_04 & level.var_92C4;
	param_00.var_4D53[0].var_A4A1 = param_01 scripts\mp\_utility::func_9E59();
	if(isdefined(param_00.var_4D55) && param_00.var_4D55 != param_01)
	{
		param_00.var_4D54++;
		if(param_00.var_4D54 == var_05.size)
		{
			param_00.var_4D54 = 0;
		}
	}

	param_00.var_4D55 = param_01;
	param_00.var_4D53[0].var_43A6 = param_00.var_4D54;
	for(var_06 = 0;var_06 < var_07;var_06++)
	{
		var_08 = "^" + var_05[param_00.var_4D53[var_06].var_43A6];
		if(param_00.var_4D53[var_06].var_9038 != "")
		{
			var_09 = var_08 + param_00.var_4D53[var_06].var_9038;
			if(param_00.var_4D53[var_06].var_2F34)
			{
				var_09 = var_09 + " (BP)";
			}

			if(param_00.var_4D53[var_06].var_A4A1)
			{
				var_09 = var_09 + " (Jugg)";
			}

			param_00 setclientdvar("ui_hitloc_" + var_06,var_09);
		}

		param_00 setclientdvar("ui_hitloc_damage_" + var_06,var_08 + param_00.var_4D53[var_06].var_DA);
	}
}

//Function Number: 42
func_839D()
{
	self endon("death");
	self endon("disconnect");
	self notify("giveRecentShieldXP");
	self endon("giveRecentShieldXP");
	self.var_DDCC++;
	wait(20);
	self.var_DDCC = 0;
}

//Function Number: 43
func_12EB3(param_00,param_01,param_02)
{
	if(!isdefined(param_00) || !isdefined(param_00.var_1D43) || !param_00.var_1D43 || !scripts\mp\_utility::func_9F56(param_02))
	{
		scripts\mp\_gamelogic::func_F759(param_00,param_01,param_02);
	}

	if(isdefined(param_00))
	{
		param_00.var_1D43 = 1;
	}
}

//Function Number: 44
func_100C1(param_00)
{
	switch(param_00)
	{
		case "stealth_bomb_mp":
		case "artillery_mp":
			return 0;
	}

	return 1;
}

//Function Number: 45
func_17AC(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_00.var_24E5))
	{
		param_00.var_24E5 = [];
	}

	if(!isdefined(param_00.var_24E5[param_01.var_86BD]))
	{
		param_00.var_2507[param_01.var_86BD] = param_01;
		param_00.var_24E5[param_01.var_86BD] = spawnstruct();
		param_00.var_24E5[param_01.var_86BD].var_DA = 0;
		param_00.var_24E5[param_01.var_86BD].var_24E7 = param_01;
		param_00.var_24E5[param_01.var_86BD].var_6DEF = gettime();
		param_00.var_24E5[param_01.var_86BD].var_9036 = 1;
	}
	else
	{
		param_00.var_24E5[param_01.var_86BD].var_9036++;
	}

	if(scripts\mp\_utility::func_9D78(param_03) && !scripts\mp\_utility::func_9D79(param_03))
	{
		param_00.var_24E5[param_01.var_86BD].var_54B4 = 1;
	}

	if(isdefined(param_09) && param_09 != "MOD_MELEE")
	{
		param_00.var_24E5[param_01.var_86BD].var_54BD = 1;
	}

	var_0A = scripts\mp\_utility::func_7E9D(param_03);
	if(isdefined(var_0A))
	{
		if(var_0A == "lethal")
		{
			param_00.var_24E5[param_01.var_86BD].var_54B3 = 1;
			param_01 scripts\mp\contractchallenges::contractequipmentdamagedplayer(param_00,param_03,param_02);
		}

		if(var_0A == "tactical")
		{
			param_00.var_24E5[param_01.var_86BD].var_54B5 = 1;
			param_01 scripts\mp\contractchallenges::contractequipmentdamagedplayer(param_00,param_03,param_02);
		}
	}

	param_00.var_24E5[param_01.var_86BD].var_DA = param_00.var_24E5[param_01.var_86BD].var_DA + param_04;
	param_00.var_24E5[param_01.var_86BD].var_394 = param_03;
	param_00.var_24E5[param_01.var_86BD].var_13557 = param_05;
	param_00.var_24E5[param_01.var_86BD].var_13190 = param_06;
	param_00.var_24E5[param_01.var_86BD].var_FE38 = param_07;
	param_00.var_24E5[param_01.var_86BD].var_252 = param_08;
	param_00.var_24E5[param_01.var_86BD].var_10367 = param_09;
	param_00.var_24E5[param_01.var_86BD].var_24E7 = param_01;
	param_00.var_24E5[param_01.var_86BD].var_AA2D = gettime();
	if(isdefined(param_02) && !isplayer(param_02) && isdefined(param_02.var_D8E1))
	{
		param_00.var_24E5[param_01.var_86BD].var_10AA6 = param_02.var_D8E1;
		return;
	}

	if(isdefined(param_01) && isplayer(param_01) && param_01 getcurrentprimaryweapon() != "none")
	{
		param_00.var_24E5[param_01.var_86BD].var_10AA6 = param_01 getcurrentprimaryweapon();
		return;
	}

	param_00.var_24E5[param_01.var_86BD].var_10AA6 = undefined;
}

//Function Number: 46
func_17AD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!isdefined(param_00.var_24E5))
	{
		param_00.var_24E5 = [];
	}

	if(!isdefined(param_00.var_24E5[param_02.var_86BD]))
	{
		param_00.var_2507[param_02.var_86BD] = param_02;
		param_00.var_24E5[param_02.var_86BD] = spawnstruct();
		param_00.var_24E5[param_02.var_86BD].var_DA = 0;
		param_00.var_24E5[param_02.var_86BD].var_24E7 = param_02;
		param_00.var_24E5[param_02.var_86BD].var_6DEF = gettime();
		param_00.var_24E5[param_02.var_86BD].var_9036 = 1;
	}

	param_00.var_24E5[param_02.var_86BD].var_DA = param_00.var_24E5[param_02.var_86BD].var_DA + param_01;
	param_00.var_24E5[param_02.var_86BD].var_394 = param_0A;
	param_00.var_24E5[param_02.var_86BD].var_13557 = param_04;
	param_00.var_24E5[param_02.var_86BD].var_13190 = param_03;
	param_00.var_24E5[param_02.var_86BD].var_22A = param_08;
	param_00.var_24E5[param_02.var_86BD].var_10367 = param_05;
	param_00.var_24E5[param_02.var_86BD].var_24E7 = param_02;
	param_00.var_24E5[param_02.var_86BD].var_AA2D = gettime();
	if(isdefined(param_02) && isplayer(param_02) && param_02 getcurrentprimaryweapon() != "none")
	{
		param_00.var_24E5[param_02.var_86BD].var_10AA6 = param_02 getcurrentprimaryweapon();
		return;
	}

	param_00.var_24E5[param_02.var_86BD].var_10AA6 = undefined;
}

//Function Number: 47
func_E247()
{
	self.var_2507 = [];
	self.var_24E5 = [];
}

//Function Number: 48
func_E143()
{
	self endon("damage");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!isdefined(self.var_2507))
	{
		return;
	}

	for(;;)
	{
		var_00 = gettime();
		foreach(var_03, var_02 in self.var_2507)
		{
			if(isdefined(var_02) && var_00 - self.var_24E5[var_03].var_AA2D < 2000)
			{
				continue;
			}

			self.var_2507[var_03] = undefined;
			self.var_24E5[var_03] = undefined;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 49
func_374D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = func_374E(param_00,param_01,self,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 50
func_6CE1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	if(!isdefined(param_0A))
	{
		param_0A = 0;
	}

	if(scripts\mp\_utility::func_9FC6() && param_02 >= self.health && !param_03 & level.var_92CA && func_1C92())
	{
		if(!isdefined(param_07))
		{
			param_07 = (0,0,0);
		}

		if(!isdefined(param_01))
		{
			param_01 = self;
		}

		if(!isdefined(param_00))
		{
			param_00 = param_01;
		}

		func_D3C4(param_00,param_01,self,param_02,param_03,param_04,param_05,param_07,param_08,param_09,0,1);
	}
	else
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
			if(!isdefined(param_0C))
			{
				param_0C = "";
			}

			if(!isdefined(param_0D))
			{
				param_0D = 0;
			}

			self method_80EA(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D);
		}
	}

	if(param_04 == "MOD_EXPLOSIVE_BULLET")
	{
		self shellshock("damage_mp",getdvarfloat("scr_csmode"));
	}

	func_4D67(param_00,param_05,param_04,param_02,param_03,param_01);
}

//Function Number: 51
func_3750(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	thread scripts\mp\_weapons::func_934E(param_00,self,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 52
func_1C92()
{
	if(!isdefined(level.var_1C92))
	{
		level.var_1C92 = 1;
	}

	return level.var_1C92;
}

//Function Number: 53
func_3752(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = spawnstruct();
	var_09.var_6000 = param_00;
	var_09.var_4F = param_01;
	var_09.var_92BA = param_02;
	var_09.var_2502 = param_01.origin;
	if(param_01 == self)
	{
		var_09.var_10367 = "MOD_SUICIDE";
	}
	else
	{
		var_09.var_10367 = param_03;
	}

	var_09.var_11329 = param_04;
	if(isdefined(param_01) && isplayer(param_01) && param_01 getcurrentprimaryweapon() != "none")
	{
		var_09.var_10AA6 = param_01 getcurrentprimaryweapon();
	}
	else
	{
		var_09.var_10AA6 = undefined;
	}

	var_09.var_13190 = param_05;
	var_09.var_FE38 = param_06;
	var_09.var_AA10 = gettime();
	var_0A = func_B4DC(param_04,param_03,param_06);
	if(isdefined(self.endgame))
	{
		var_0A = 0;
	}

	if(level.teambased && isdefined(param_01.team) && param_01.team == self.team)
	{
		var_0A = 0;
	}

	if(level.var_54CC)
	{
		if(level.var_115C6[self.team] <= 1)
		{
			var_0A = 0;
		}
		else if(scripts\mp\_utility::func_9F9B())
		{
			var_0A = 0;
			scripts\mp\_utility::func_A6C7(self.team);
		}
	}

	if(!var_0A)
	{
		self.var_AA0C = var_09;
		self.var_1309F = 1;
		scripts\mp\_utility::func_1417();
		return;
	}

	self.inlaststand = 1;
	var_0B = spawnstruct();
	if(scripts\mp\_utility::_hasperk("specialty_finalstand"))
	{
		var_0B.var_119A8 = game["strings"]["final_stand"];
		var_0B.var_92AE = "specialty_finalstand";
	}
	else if(scripts\mp\_utility::_hasperk("specialty_c4death"))
	{
		var_0B.var_119A8 = game["strings"]["c4_death"];
		var_0B.var_92AE = "specialty_c4death";
	}
	else
	{
		var_0B.var_119A8 = game["strings"]["last_stand"];
		var_0B.var_92AE = "specialty_finalstand";
	}

	var_0B.var_154 = (1,0,0);
	var_0B.var_10453 = "mp_last_stand";
	var_0B.var_5F36 = 2;
	self.health = 1;
	var_0C = "frag_grenade_mp";
	if(isdefined(level.var_1541) && isdefined(param_01) && level.var_1541 == param_01)
	{
		level notify("ai_crawling",self);
	}

	if(scripts\mp\_utility::_hasperk("specialty_finalstand"))
	{
		self.var_AA0C = var_09;
		self.var_94A2 = 1;
		var_0D = self getweaponslistexclusives();
		foreach(var_0F in var_0D)
		{
			scripts\mp\_utility::func_141E(var_0F);
		}

		scripts\common\utility::func_1C6E(0);
		thread func_626F();
		thread func_AA11(20,1);
		return;
	}

	if(scripts\mp\_utility::_hasperk("specialty_c4death"))
	{
		self.var_D8B0 = self.var_A978;
		self.var_AA0C = var_09;
		self method_83B7();
		self giveweapon("c4death_mp",0,0);
		scripts\mp\_utility::_switchtoweapon("c4death_mp");
		scripts\common\utility::func_1C6E(0);
		self.var_93BB = 1;
		thread func_AA11(20,0);
		thread func_53D3();
		thread func_53D2();
		return;
	}

	if(level.var_54CC)
	{
		param_01 thread scripts\mp\_utility::func_83B4("kill",param_04);
		self.var_AA0C = var_09;
		scripts\common\utility::allow_weapon(0);
		thread func_AA11(20,0);
		scripts\common\utility::func_1C6E(0);
		return;
	}

	self.var_AA0C = var_09;
	var_11 = undefined;
	var_12 = self getweaponslistprimaries();
	foreach(var_0F in var_12)
	{
		if(scripts\mp\_weapons::func_9F54(var_0F))
		{
			var_11 = var_0F;
		}
	}

	if(!isdefined(var_11))
	{
		var_11 = "iw6_p226_mp";
		scripts\mp\_utility::func_12C6(var_11);
	}

	self givemaxammo(var_11);
	self method_80AB();
	scripts\common\utility::func_1C6E(0);
	if(!scripts\mp\_utility::_hasperk("specialty_laststandoffhand"))
	{
		self method_80A4();
	}

	scripts\mp\_utility::_switchtoweapon(var_11);
	thread func_AA11(10,0);
}

//Function Number: 54
func_54C8(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	wait(param_00);
	self.var_1309F = 1;
	scripts\mp\_utility::func_1417();
}

//Function Number: 55
func_53D3()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self waittill("detonate");
	self.var_1309F = 1;
	func_3345();
}

//Function Number: 56
func_53D2()
{
	self endon("detonate");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self waittill("death");
	func_3345();
}

//Function Number: 57
func_3345()
{
	self playsound("detpack_explo_default");
	radiusdamage(self.origin,312,100,100,self);
	if(isalive(self))
	{
		scripts\mp\_utility::func_1417();
	}
}

//Function Number: 58
func_626F()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	scripts\mp\_utility::func_7385(1);
	wait(0.3);
	scripts\mp\_utility::func_7385(0);
}

//Function Number: 59
func_AA11(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	level notify("player_last_stand");
	thread func_AA16();
	self.var_1B3 = 1;
	if(!param_01 && !isdefined(self.var_93BB) || !self.var_93BB)
	{
		thread func_AA05();
		scripts\mp\_utility::setlowermessage("last_stand",&"PLATFORM_COWARDS_WAY_OUT",undefined,undefined,undefined,undefined,undefined,undefined,1);
		thread func_AA09();
	}

	if(level.var_54CC == 1 && level.var_54CC != 2)
	{
		var_02 = spawn("script_model",self.origin);
		var_02 setmodel("tag_origin");
		var_02 setcursorhint("HINT_NOICON");
		var_02 sethintstring(&"PLATFORM_REVIVE");
		var_02 func_E4AE(self);
		var_02 endon("death");
		var_03 = newteamhudelem(self.team);
		var_03 setshader("waypoint_revive",8,8);
		var_03 setwaypoint(1,1);
		var_03 settargetent(self);
		var_03 thread func_5321(var_02);
		var_03.color = (0.33,0.75,0.24);
		scripts\mp\_utility::func_CF16();
		if(param_01)
		{
			wait(param_00);
			if(self.var_94A2)
			{
				thread func_AA07(param_01,var_02);
			}
		}

		return;
	}
	else if(level.var_54CC == 2)
	{
		thread func_AA09();
		var_02 = spawn("script_model",self.origin);
		var_03 setmodel("tag_origin");
		var_03 setcursorhint("HINT_NOICON");
		var_03 sethintstring(&"PLATFORM_REVIVE");
		var_03 func_E4AE(self);
		var_03 endon("death");
		var_03 = newteamhudelem(self.team);
		var_03 setshader("waypoint_revive",8,8);
		var_03 setwaypoint(1,1);
		var_03 settargetent(self);
		var_03 thread func_5321(var_02);
		var_03.color = (0.33,0.75,0.24);
		scripts\mp\_utility::func_CF16();
		if(param_01)
		{
			wait(param_00);
			if(self.var_94A2)
			{
				thread func_AA07(param_01,var_02);
			}
		}

		wait(param_00 / 3);
		var_03.color = (1,0.64,0);
		while(var_02.var_9B04)
		{
			wait(0.05);
		}

		scripts\mp\_utility::func_CF16();
		wait(param_00 / 3);
		var_03.color = (1,0,0);
		while(var_02.var_9B04)
		{
			wait(0.05);
		}

		scripts\mp\_utility::func_CF16();
		wait(param_00 / 3);
		while(var_02.var_9B04)
		{
			wait(0.05);
		}

		wait(0.05);
		thread func_AA07(param_01);
		return;
	}

	thread func_AA09();
	wait(var_02);
	thread func_AA07(var_03);
}

//Function Number: 60
func_B4A2(param_00,param_01)
{
	self endon("stop_maxHealthOverlay");
	self endon("revive");
	self endon("death");
	for(;;)
	{
		self.health = self.health - 1;
		self.maxhealth = param_00;
		wait(0.05);
		self.maxhealth = 50;
		self.health = self.health + 1;
		wait(0.5);
	}
}

//Function Number: 61
func_AA07(param_00,param_01)
{
	if(param_00)
	{
		self.var_1B3 = undefined;
		self.var_94A2 = 0;
		self notify("revive");
		scripts\mp\_utility::clearlowermessage("last_stand");
		scripts\mp\_playerlogic::func_AA0D();
		if(isdefined(param_01))
		{
			param_01 delete();
			return;
		}

		return;
	}

	self.var_1309F = 1;
	self.var_2A8A = 0;
	scripts\mp\_utility::func_1417();
}

//Function Number: 62
func_AA05()
{
	self endon("death");
	self endon("disconnect");
	self endon("game_ended");
	self endon("revive");
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_00 = gettime();
			while(self usebuttonpressed())
			{
				wait(0.05);
				if(gettime() - var_00 > 700)
				{
					break;
				}
			}

			if(gettime() - var_00 > 700)
			{
				break;
			}
		}

		wait(0.05);
	}

	thread func_AA07(0);
}

//Function Number: 63
func_AA09()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	while(!level.var_7669)
	{
		self.health = 2;
		wait(0.05);
		self.health = 1;
		wait(0.5);
	}

	self.health = self.maxhealth;
}

//Function Number: 64
func_AA16()
{
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	self waittill("death");
	scripts\mp\_utility::clearlowermessage("last_stand");
	self.var_1B3 = undefined;
}

//Function Number: 65
func_B4DC(param_00,param_01,param_02)
{
	if(param_01 == "MOD_TRIGGER_HURT")
	{
		return 0;
	}

	if(param_01 != "MOD_PISTOL_BULLET" && param_01 != "MOD_RIFLE_BULLET" && param_01 != "MOD_FALLING" && param_01 != "MOD_EXPLOSIVE_BULLET")
	{
		return 0;
	}

	if(param_01 == "MOD_IMPACT" && scripts\mp\_weapons::func_9FA9(param_00))
	{
		return 0;
	}

	if(param_01 == "MOD_IMPACT" && param_00 == "m79_mp" || issubstr(param_00,"gl_"))
	{
		return 0;
	}

	if(scripts\mp\_utility::func_9E27(param_00,param_02,param_01))
	{
		return 0;
	}

	if(scripts\mp\_utility::func_9FC6())
	{
		return 0;
	}

	return 1;
}

//Function Number: 66
func_65D2()
{
	if(!isdefined(self.var_AA0C.var_4F))
	{
		self.var_AA0C.var_4F = self;
	}
}

//Function Number: 67
func_7F02(param_00)
{
	switch(param_00)
	{
		case "neck":
		case "helmet":
		case "head":
			return 60;

		case "left_hand":
		case "right_hand":
		case "left_arm_lower":
		case "right_arm_lower":
		case "left_arm_upper":
		case "right_arm_upper":
		case "torso_upper":
		case "gun":
			return 48;

		case "torso_lower":
			return 40;

		case "right_leg_upper":
		case "left_leg_upper":
			return 32;

		case "right_leg_lower":
		case "left_leg_lower":
			return 10;

		case "right_foot":
		case "left_foot":
			return 5;
	}

	return 48;
}

//Function Number: 68
func_5124(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_00))
	{
		var_06 = param_00 method_8112();
		if(animhasnotetrack(var_06,"ignore_ragdoll"))
		{
			return;
		}
	}

	if(isdefined(level.var_C08A) && level.var_C08A.size)
	{
		foreach(var_08 in level.var_C08A)
		{
			if(distancesquared(param_00.origin,var_08.origin) < 65536)
			{
				return;
			}
		}
	}

	wait(0.2);
	if(!isdefined(param_00))
	{
		return;
	}

	if(param_00 method_81B7())
	{
		return;
	}

	var_06 = param_00 method_8112();
	var_0A = 0.35;
	if(animhasnotetrack(var_06,"start_ragdoll"))
	{
		var_0B = getnotetracktimes(var_06,"start_ragdoll");
		if(isdefined(var_0B))
		{
			var_0A = var_0B[0];
		}
	}

	var_0C = var_0A * getanimlength(var_06);
	wait(var_0C);
	if(isdefined(param_00))
	{
		param_00 method_839A();
	}
}

//Function Number: 69
func_7FCA()
{
	var_00 = "";
	var_01 = 0;
	var_02 = getarraykeys(self.var_A64E);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(self.var_A64E[var_04] <= var_01)
		{
			continue;
		}

		var_01 = self.var_A64E[var_04];
		var_05 = var_04;
	}

	return var_00;
}

//Function Number: 70
func_7FC9()
{
	var_00 = "";
	var_01 = 0;
	var_02 = getarraykeys(self.var_A653);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(self.var_A653[var_04] <= var_01)
		{
			continue;
		}

		var_01 = self.var_A653[var_04];
		var_00 = var_04;
	}

	return var_00;
}

//Function Number: 71
func_4D67(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread scripts\mp\_weapons::func_C5CB(param_00,param_01,param_02,param_03,param_05);
	if(!isai(self) && scripts\common\utility::func_7E5E(param_02) != "bullet")
	{
		self playrumbleonentity("damage_heavy");
	}
}

//Function Number: 72
func_E4AE(param_00)
{
	var_01 = param_00.team;
	self linkto(param_00,"tag_origin");
	self.var_222 = param_00;
	self.var_9B04 = 0;
	self makeusable();
	func_12F56(var_01);
	thread func_11B0A(var_01);
	thread func_E4AF(var_01);
	thread func_51C9();
}

//Function Number: 73
func_51C9()
{
	self endon("death");
	self.var_222 scripts\common\utility::waittill_any_3("death","disconnect");
	self delete();
}

//Function Number: 74
func_12F56(param_00)
{
	foreach(var_02 in level.players)
	{
		if(param_00 == var_02.team && var_02 != self.var_222)
		{
			self enableplayeruse(var_02);
			continue;
		}

		self disableplayeruse(var_02);
	}
}

//Function Number: 75
func_11B0A(param_00)
{
	self endon("death");
	for(;;)
	{
		level waittill("joined_team");
		func_12F56(param_00);
	}
}

//Function Number: 76
func_11AF5(param_00)
{
	self endon("death");
	for(;;)
	{
		level waittill("player_last_stand");
		func_12F56(param_00);
	}
}

//Function Number: 77
func_E4AF(param_00)
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_01);
		self.var_222.var_2A8A = 1;
		if(isdefined(var_01.var_2A8A) && var_01.var_2A8A)
		{
			self.var_222.var_2A8A = 0;
			continue;
		}

		self makeunusable();
		self.var_222 scripts\mp\_utility::func_7385(1);
		var_02 = func_13093(var_01);
		self.var_222.var_2A8A = 0;
		if(!isalive(self.var_222))
		{
			self delete();
			return;
		}

		self.var_222 scripts\mp\_utility::func_7385(0);
		if(var_02)
		{
			var_01 thread scripts\mp\_hud_message::func_10151("reviver",scripts\mp\_rank::func_8104("reviver"));
			var_01 thread scripts\mp\_utility::func_83B4("reviver");
			self.var_222.var_1B3 = undefined;
			self.var_222 scripts\mp\_utility::clearlowermessage("last_stand");
			self.var_222.var_BCF6 = 1;
			if(self.var_222 scripts\mp\_utility::_hasperk("specialty_lightweight"))
			{
				self.var_222.var_BCF6 = scripts\mp\_utility::func_ACD8();
			}

			self.var_222 scripts\common\utility::allow_weapon(1);
			self.var_222.maxhealth = 100;
			self.var_222 scripts\mp\_weapons::func_12ED5();
			self.var_222 scripts\mp\_playerlogic::func_AA0D();
			self.var_222 scripts\mp\_utility::func_8387("specialty_pistoldeath");
			self.var_222.var_2A8A = 0;
			self delete();
			return;
		}

		self makeusable();
		func_12F56(param_00);
	}
}

//Function Number: 78
func_13093(param_00,param_01)
{
	var_02 = 3000;
	var_03 = spawn("script_origin",self.origin);
	var_03 hide();
	param_00 playerlinkto(var_03);
	param_00 playerlinkedoffsetenable();
	param_00 scripts\common\utility::allow_weapon(0);
	self.var_4B30 = 0;
	self.var_9B04 = 1;
	self.userate = 0;
	if(isdefined(param_01))
	{
		self.var_130EE = param_01;
	}
	else
	{
		self.var_130EE = var_02;
	}

	var_04 = func_13094(param_00);
	self.var_9B04 = 0;
	var_03 delete();
	if(isdefined(param_00) && scripts\mp\_utility::func_9F19(param_00))
	{
		param_00 unlink();
		param_00 scripts\common\utility::allow_weapon(1);
	}

	if(isdefined(var_04) && var_04)
	{
		self.var_222 thread scripts\mp\_hud_message::func_10151("revived",undefined,param_00);
		self.var_222.inlaststand = 0;
		return 1;
	}

	return 0;
}

//Function Number: 79
func_13094(param_00)
{
	level endon("game_ended");
	self.var_222 endon("death");
	self.var_222 endon("disconnect");
	while(scripts\mp\_utility::func_9F19(param_00) && param_00 usebuttonpressed() && self.var_4B30 < self.var_130EE && !isdefined(param_00.var_1B3) || !param_00.var_1B3)
	{
		self.var_4B30 = self.var_4B30 + 50 * self.userate;
		self.userate = 1;
		param_00 scripts\mp\_gameobjects::func_12F53(self,1);
		self.var_222 scripts\mp\_gameobjects::func_12F53(self,1);
		if(self.var_4B30 >= self.var_130EE)
		{
			self.var_9B04 = 0;
			param_00 scripts\mp\_gameobjects::func_12F53(self,0);
			self.var_222 scripts\mp\_gameobjects::func_12F53(self,0);
			return scripts\mp\_utility::func_9F19(param_00);
		}

		wait(0.05);
	}

	param_00 scripts\mp\_gameobjects::func_12F53(self,0);
	self.var_222 scripts\mp\_gameobjects::func_12F53(self,0);
	return 0;
}

//Function Number: 80
func_374A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(self.var_A970) && self.var_A970 && param_02 >= self.health && isdefined(self.var_4402) && self.var_4402 == "specialty_endgame")
	{
		scripts\mp\_utility::func_8387("specialty_endgame");
		return 0;
	}

	return 1;
}

//Function Number: 81
func_612A(param_00)
{
	physicsexplosionsphere(self.origin,64,64,1);
	var_01 = [];
	for(var_02 = 0;var_02 < 360;var_02 = var_02 + 30)
	{
		var_03 = cos(var_02) * 16;
		var_04 = sin(var_02) * 16;
		var_05 = bullettrace(self.origin + (var_03,var_04,4),self.origin + (var_03,var_04,-6),1,self);
		if(isdefined(var_05["entity"]) && isdefined(var_05["entity"].var_336) && var_05["entity"].var_336 == "destructible_vehicle" || var_05["entity"].var_336 == "destructible_toy")
		{
			var_01[var_01.size] = var_05["entity"];
		}
	}

	if(var_01.size)
	{
		var_06 = spawn("script_origin",self.origin);
		var_06 hide();
		var_06.type = "soft_landing";
		var_06.var_5379 = var_01;
		radiusdamage(self.origin,64,100,100,var_06);
		wait(0.1);
		var_06 delete();
	}
}

//Function Number: 82
func_9DF9(param_00,param_01)
{
	var_02 = anglestoforward(param_00.angles);
	var_02 = (var_02[0],var_02[1],0);
	var_02 = vectornormalize(var_02);
	var_03 = param_00.origin - param_01.origin;
	var_03 = (var_03[0],var_03[1],0);
	var_03 = vectornormalize(var_03);
	var_04 = vectordot(var_02,var_03);
	if(var_04 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 83
func_5321(param_00)
{
	param_00 waittill("death");
	self destroy();
}

//Function Number: 84
func_7678(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(isdefined(param_01) && isplayer(param_01) && isalive(param_01))
	{
		if(level.var_B40A)
		{
			param_02 = param_02 * level.var_B40A;
		}

		if(level.var_B410)
		{
			param_01.health = int(min(float(param_01.maxhealth),float(param_01.health + 20)));
		}

		if(level.tactical)
		{
			var_08 = weaponclass(param_04);
			if(var_08 == "sniper" || var_08 == "spread" || issubstr(param_04,"iw7_udm45_mpl"))
			{
				param_02 = param_02 * 0.7;
			}

			switch(param_07)
			{
				case "neck":
				case "helmet":
				case "head":
					if(var_08 != "spread")
					{
						param_02 = param_02 * 2;
					}
					break;

				case "torso_upper":
					break;

				case "left_hand":
				case "right_hand":
				case "left_arm_lower":
				case "right_arm_lower":
				case "left_arm_upper":
				case "right_arm_upper":
				case "gun":
					break;

				case "torso_lower":
					break;

				case "right_leg_upper":
				case "left_leg_upper":
					break;

				case "right_foot":
				case "right_leg_lower":
				case "left_foot":
				case "left_leg_lower":
					break;
			}
		}
	}

	return param_02;
}

//Function Number: 85
func_DEFA(param_00,param_01,param_02)
{
	var_03 = scripts\mp\_utility::func_9E6C(param_00) && !param_01 == "MOD_MELEE";
	if(!var_03)
	{
		self.pers["cur_kill_streak_for_nuke"]++;
	}

	self.pers["cur_kill_streak"]++;
	if(param_02)
	{
		self notify("kill_streak_increased");
	}

	var_04 = 25;
	if(scripts\mp\_utility::_hasperk("specialty_hardline"))
	{
		var_04--;
	}

	if(!var_03 && self.pers["cur_kill_streak_for_nuke"] == var_04 && !scripts\mp\_utility::func_9D46())
	{
		if(!isdefined(level.var_112C4) || level.var_112C4)
		{
			func_83B3(var_04);
		}
	}
}

//Function Number: 86
func_83B3(param_00)
{
}

//Function Number: 87
func_B9C6(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
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
	if(!isdefined(self.var_E1) || scripts\mp\_utility::func_9FB3(param_06))
	{
		self.var_E1 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	for(var_07 = 1;var_07;var_07 = func_B9C7(var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10,var_11,param_01,param_02,param_03,param_04))
	{
		self waittill("damage",var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10,var_11,var_12,var_13,var_14,var_15);
		var_11 = scripts\mp\_utility::func_13CA1(var_11,var_15);
		if(lib_0DF8::func_9DDF(var_09))
		{
			continue;
		}

		if(param_05)
		{
			self playrumbleonentity("damage_light");
		}

		if(param_04)
		{
			func_AF96(self,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10,var_11);
		}

		if(isdefined(self.var_8DD9) && self.var_8DD9 == "littlebird")
		{
			if(!isdefined(self.var_2507))
			{
				self.var_2507 = [];
			}

			var_16 = "";
			if(isdefined(var_09) && isplayer(var_09))
			{
				var_16 = var_09 scripts\mp\_utility::func_81EC();
			}

			if(isdefined(self.var_2507[var_16]))
			{
				self.var_2507[var_16] = self.var_2507[var_16] + var_08;
			}
			else
			{
				self.var_2507[var_16] = var_08;
			}
		}
	}
}

//Function Number: 88
func_B9C7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(lib_0DF8::func_9DDF(param_01))
	{
		return 0;
	}

	if(isdefined(param_01) && isdefined(param_01.var_222))
	{
		param_01 = param_01.var_222;
	}

	if(isdefined(param_01) && !scripts\mp\_utility::func_9E0E(param_01))
	{
		return 1;
	}

	if(isdefined(param_01) && !scripts\mp\_weapons::func_7415(self.var_222,param_01))
	{
		return 1;
	}

	if(isdefined(param_09) && scripts\mp\_weapons::isballweapon(param_09))
	{
		return 1;
	}

	var_0E = param_00;
	if(scripts\mp\_weapons::func_66AA(param_09,param_04))
	{
		return 1;
	}

	if(isdefined(param_09))
	{
		if(!isdefined(param_0C))
		{
			param_0C = ::func_B938;
		}

		var_0E = self [[ param_0C ]](param_01,param_09,param_04,param_00,param_08);
	}

	if(var_0E <= 0)
	{
		return 1;
	}

	self.var_1390B = 1;
	self.var_E1 = self.var_E1 + var_0E;
	if(isdefined(param_08) && param_08 & level.var_92C4)
	{
		self.var_1390E = 1;
	}

	if(isdefined(param_08) && param_08 & level.var_92C6)
	{
		self.var_1390F = 1;
	}

	if(param_0D)
	{
		scripts\mp\killstreaks\_killstreaks::func_A6A0(param_01,param_09,self,param_04);
	}

	if(isdefined(param_01))
	{
		if(isplayer(param_01))
		{
			param_01 scripts\mp\_damagefeedback::func_12E84(param_0A);
		}
	}

	if(self.var_E1 >= self.maxhealth)
	{
		self thread [[ param_0B ]](param_01,param_09,param_04,param_00);
		return 0;
	}

	return 1;
}

//Function Number: 89
func_B938(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04) && param_04 && level.var_92C6)
	{
		var_05 = 0.6 * param_03;
	}
	else
	{
		var_05 = param_04;
	}

	var_05 = func_8999(param_01,param_02,var_05);
	var_05 = func_89C6(param_01,param_02,var_05);
	var_05 = func_89AC(param_01,param_02,var_05);
	var_05 = func_8975(param_01,param_02,var_05);
	return var_05;
}

//Function Number: 90
func_89C6(param_00,param_01,param_02)
{
	param_00 = scripts\mp\_utility::func_821D(param_00);
	var_03 = param_02;
	switch(param_00)
	{
		case "maverick_projectile_mp":
		case "ac130_40mm_mp":
		case "ac130_105mm_mp":
		case "aamissile_projectile_mp":
		case "iw7_chargeshot_mp":
		case "iw7_lockon_mp":
		case "drone_hive_projectile_mp":
		case "bomb_site_mp":
			self.var_A859 = 1;
			var_03 = self.maxhealth + 1;
			break;

		case "remote_tank_projectile_mp":
		case "hind_missile_mp":
		case "hind_bomb_mp":
		case "switch_blade_child_mp":
			self.var_A859 = 0;
			var_03 = self.maxhealth + 1;
			break;

		case "a10_30mm_turret_mp":
		case "heli_pilot_turret_mp":
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

//Function Number: 91
func_89AC(param_00,param_01,param_02)
{
	if(function_0107(param_01))
	{
		switch(param_00)
		{
			case "iw6_rgm_mp":
			case "proximity_explosive_mp":
			case "c4_mp":
				param_02 = param_02 * 3;
				break;

			case "iw6_mk32_mp":
			case "semtexproj_mp":
			case "bouncingbetty_mp":
			case "semtex_mp":
			case "frag_grenade_mp":
				param_02 = param_02 * 4;
				break;

			default:
				if(scripts\mp\_utility::isstrstart(param_00,"alt_"))
				{
					param_02 = param_02 * 3;
				}
				break;
		}
	}

	return param_02;
}

//Function Number: 92
func_89C3(param_00,param_01,param_02)
{
	if(param_01 == "MOD_MELEE")
	{
		return self.maxhealth + 1;
	}

	return param_02;
}

//Function Number: 93
func_8999(param_00,param_01,param_02)
{
	return param_02;
}

//Function Number: 94
func_8975(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	var_05 = level.var_218B - 1;
	if(scripts\mp\_utility::func_9DFF(param_00,param_01))
	{
		var_04 = var_04 + var_05;
	}

	var_06 = level.armorpiercingmodks - 1;
	if(isdefined(param_03) && param_03 scripts\mp\_utility::_hasperk("specialty_armorpiercingks") && isdefined(self.var_110EA) && scripts\mp\_weapons::func_9F0E(param_00) && scripts\common\utility::func_9D74(param_01))
	{
		var_04 = var_04 + var_06;
	}

	return param_02 * var_04;
}

//Function Number: 95
func_89E2(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return param_02;
	}

	if(param_00 == "none")
	{
		return param_02;
	}

	if(scripts\mp\_utility::func_821D(param_00) == "iw7_claw_mp")
	{
		return param_02;
	}

	if(weaponclass(param_00) != "spread")
	{
		return param_02;
	}

	return int(min(150,param_02));
}

//Function Number: 96
func_C546(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(isdefined(param_01) && isdefined(self.var_222))
	{
		if(isdefined(param_01.var_222) && isplayer(param_01.var_222))
		{
			param_01 = param_01.var_222;
		}

		if(isplayer(param_01) && self.var_222 scripts\mp\_utility::func_9DD6(param_01))
		{
			var_04 = param_01;
		}
	}

	if(isdefined(var_04))
	{
		thread scripts\mp\_missions::func_A695(param_00,self.var_222,var_04,param_02,param_03);
	}
}

//Function Number: 97
func_C548(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = 0;
	var_0A = undefined;
	if(isdefined(param_01) && isdefined(self.var_222))
	{
		if(isdefined(param_01.var_222) && isplayer(param_01.var_222))
		{
			param_01 = param_01.var_222;
		}

		if(self.var_222 scripts\mp\_utility::func_9DD6(param_01))
		{
			var_0A = param_01;
		}
	}

	if(isdefined(var_0A))
	{
		var_0A notify("destroyed_killstreak",param_02);
		if(isdefined(param_07))
		{
			thread scripts\mp\_utility::func_115DE(param_07,var_0A);
		}

		scripts\mp\_missions::func_8375(self,var_0A);
		thread scripts\mp\_events::func_A650(param_00,var_0A);
		thread scripts\mp\_missions::func_A6A3(param_00,self.var_222,self,undefined,var_0A,param_04,param_03,param_02,param_05);
		var_09 = 1;
	}

	if(isdefined(self.var_222) && isdefined(param_06))
	{
		self.var_222 scripts\mp\_utility::func_D4B6(param_06,undefined,undefined,self.origin);
	}

	if(!scripts\mp\_utility::func_9FB3(param_08))
	{
		self notify("death");
	}

	return var_09;
}

//Function Number: 98
func_12EFD(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_DDBE))
	{
		self.var_DDBE = [];
	}

	if(self.health >= self.maxhealth)
	{
		func_41D5();
	}

	var_04 = undefined;
	if(self.var_DDBE.size < 4)
	{
		var_04 = spawnstruct();
		self.var_DDBE[self.var_DDBE.size] = var_04;
	}
	else
	{
		for(var_05 = 0;var_05 < 3;var_05++)
		{
			self.var_DDBE[var_05] = self.var_DDBE[var_05 + 1];
		}

		var_04 = spawnstruct();
		self.var_DDBE[self.var_DDBE.size - 1] = var_04;
	}

	if(param_03 == "MOD_MELEE" && param_02 == "head")
	{
		param_02 = "torso_upper";
	}

	var_04.var_DA = int(min(param_00,self.health));
	var_04.var_4F = param_01;
	var_04.var_AEC4 = param_02;
}

//Function Number: 99
func_41D5()
{
	self.var_DDBE = [];
}

//Function Number: 100
func_12E85(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(param_00) && isdefined(param_01))
	{
		foreach(var_06, var_04 in param_00)
		{
			if(!isplayer(var_04))
			{
				continue;
			}

			var_05 = var_04 getentitynumber();
			self setclientomnvar("ui_death_details_attacker_" + var_02,var_05);
			self setclientomnvar("ui_death_details_hits_" + var_02,int(min(param_01[var_06].var_9036,10)));
			var_02++;
			if(var_02 >= 4)
			{
				break;
			}
		}
	}

	for(var_07 = var_02;var_07 < 4;var_07++)
	{
		self setclientomnvar("ui_death_details_attacker_" + var_07,-1);
	}
}

//Function Number: 101
func_7F18(param_00)
{
	switch(param_00)
	{
		case "torso_upper":
			return 0;

		case "torso_lower":
			return 1;

		case "helmet":
			return 2;

		case "head":
			return 3;

		case "neck":
			return 4;

		case "left_arm_upper":
			return 5;

		case "left_arm_lower":
			return 6;

		case "left_hand":
			return 7;

		case "right_arm_upper":
			return 8;

		case "right_arm_lower":
			return 9;

		case "right_hand":
			return 10;

		case "left_leg_upper":
			return 11;

		case "left_leg_lower":
			return 12;

		case "left_foot":
			return 13;

		case "right_leg_upper":
			return 14;

		case "right_leg_lower":
			return 15;

		case "right_foot":
			return 16;

		case "gun":
			return 17;

		case "none":
			return 18;
	}

	return 0;
}

//Function Number: 102
func_1015A()
{
	self setclientomnvar("ui_damage_event",self.var_4D48);
}

//Function Number: 103
updatecombatrecordkillstats(param_00,param_01,param_02,param_03)
{
	if(!scripts\mp\_utility::canrecordcombatrecordstats())
	{
		return;
	}

	if(isdefined(param_00) && isplayer(param_00))
	{
		param_00 combatrecordarchetypekill(param_00.var_AE62);
		if(isdefined(param_03))
		{
			var_04 = scripts\mp\_utility::func_7E9D(param_03);
			if(isdefined(var_04) && var_04 == "lethal")
			{
				var_05 = scripts\mp\_powers::func_D737(param_03);
				param_00 combatrecordlethalkill(var_05);
			}
			else
			{
				var_06 = scripts\mp\_missions::func_7F48(param_03);
				if(isdefined(var_06))
				{
					if(function_02D9("mp","LethalScorestreakStatItems",var_06))
					{
						param_00 combatrecordkillstreakstat(var_06);
					}
				}

				if(scripts\mp\_utility::func_9FB3(param_00.var_CA7D))
				{
					param_00 combatrecordtacticalstat("power_periphVis");
				}

				if(scripts\mp\_utility::func_9FB3(param_00.var_8BC2))
				{
					param_00 combatrecordtacticalstat("power_adrenaline");
				}
			}
		}
	}

	if(isdefined(param_01) && isplayer(param_01))
	{
		param_01 combatrecordarchetypedeath(param_01.var_AE62);
	}
}

//Function Number: 104
combatrecordarchetypekill(param_00)
{
	if(!scripts\mp\_utility::canrecordcombatrecordstats())
	{
		return;
	}

	var_01 = self getplayerdata("mp","archetypeStats",param_00,"kills");
	self setplayerdata("mp","archetypeStats",param_00,"kills",var_01 + 1);
}

//Function Number: 105
combatrecordarchetypedeath(param_00)
{
	if(!scripts\mp\_utility::canrecordcombatrecordstats())
	{
		return;
	}

	var_01 = self getplayerdata("mp","archetypeStats",param_00,"deaths");
	self setplayerdata("mp","archetypeStats",param_00,"deaths",var_01 + 1);
}

//Function Number: 106
combatrecordlethalkill(param_00)
{
	if(!scripts\mp\_utility::canrecordcombatrecordstats())
	{
		return;
	}

	var_01 = self getplayerdata("mp","lethalStats",param_00,"kills");
	self setplayerdata("mp","lethalStats",param_00,"kills",var_01 + 1);
}

//Function Number: 107
combatrecordtacticalstat(param_00,param_01)
{
	if(!scripts\mp\_utility::canrecordcombatrecordstats())
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = self getplayerdata("mp","tacticalStats",param_00,"extraStat1");
	self setplayerdata("mp","tacticalStats",param_00,"extraStat1",var_02 + param_01);
}

//Function Number: 108
combatrecordkillstreakstat(param_00)
{
	if(!scripts\mp\_utility::canrecordcombatrecordstats())
	{
		return;
	}

	var_01 = scripts\mp\_utility::getstreakrecordtype(param_00);
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = self getplayerdata("mp",var_01,param_00,"extraStat1");
	self setplayerdata("mp",var_01,param_00,"extraStat1",var_02 + 1);
}

//Function Number: 109
enqueuecorpsetablefunc(param_00,param_01)
{
	if(!isdefined(self.corpsetablefuncs))
	{
		self.corpsetablefuncs = [];
		self.corpsetablefunccounts = [];
	}

	if(!isdefined(self.corpsetablefuncs[param_00]))
	{
		self.corpsetablefuncs[param_00] = param_01;
		self.corpsetablefunccounts[param_00] = 0;
	}

	self.corpsetablefunccounts[param_00]++;
}

//Function Number: 110
dequeuecorpsetablefunc(param_00)
{
	if(!isdefined(self.corpsetablefuncs))
	{
		return;
	}

	if(!isdefined(self.corpsetablefuncs[param_00]))
	{
		return;
	}

	self.corpsetablefunccounts[param_00]--;
	if(self.corpsetablefunccounts[param_00] <= 0)
	{
		self.corpsetablefuncs[param_00] = undefined;
		self.corpsetablefunccounts[param_00] = undefined;
	}
}

//Function Number: 111
callcorpsetablefuncs()
{
	if(!isdefined(self.corpsetablefuncs))
	{
		return;
	}

	var_00 = self.var_2C09;
	foreach(var_02 in self.corpsetablefuncs)
	{
		self thread [[ var_02 ]](var_00);
	}

	thread clearcorpsetablefuncs();
}

//Function Number: 112
clearcorpsetablefuncs()
{
	self notify("clearCorpsetableFuncs");
	self.corpsetablefuncs = undefined;
	self.corpsetablefunccounts = undefined;
}

//Function Number: 113
enqueueweapononkillcorpsetablefuncs(param_00,param_01,param_02,param_03,param_04)
{
	if(scripts\mp\_weapons::func_9F0E(param_03))
	{
		var_05 = scripts\mp\_utility::func_8234(param_03);
		var_06 = function_02C4(param_03);
		var_07 = param_00 method_8519(param_03);
		if(var_05 == "iw7_rvn" && scripts\mp\_utility::func_9FB3(var_07) && param_04 == "MOD_MELEE")
		{
			param_01 thread enqueuecorpsetablefunc("passive_melee_cone_expl",::scripts\mp\perks\_weaponpassives::meleeconeexplodevictimcorpsefx);
		}
	}
}