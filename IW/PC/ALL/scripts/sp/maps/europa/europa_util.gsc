/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\maps\europa\europa_util.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 151
 * Decompile Time: 5799 ms
 * Timestamp: 10/27/2023 12:23:11 AM
*******************************************************************/

//Function Number: 1
func_10690(param_00)
{
	if(!isdefined(param_00))
	{
		foreach(var_02 in scripts\common\utility::getstructarray("corpse_struct","targetname"))
		{
			var_02 func_1068F();
		}

		return;
	}

	foreach(var_04 in scripts\common\utility::getstructarray("corpse_struct","targetname"))
	{
		if(isdefined(var_04.script_noteworthy) && var_04.script_noteworthy == var_02)
		{
			var_04 func_1068F();
		}
	}
}

//Function Number: 2
func_1068F()
{
	getspawner("corpse_worker","targetname").var_C1 = 100;
	if(self.script_noteworthy == "base_exterior" || self.script_noteworthy == "office_fight")
	{
		var_00 = func_B285();
		var_00.var_1FBB = "script_model_corpse";
		var_00 scripts\sp\_utility::func_23B7();
		scripts\sp\_utility::func_16AE(var_00,self.script_noteworthy);
	}
	else
	{
		if(self.script_noteworthy == "base_exterior" || self.script_noteworthy == "base_entrance")
		{
			var_00 = scripts\sp\_utility::func_107EA("corpse_security",1);
		}
		else
		{
			var_00 = scripts\sp\_utility::func_107EA("corpse_worker",1);
		}

		var_00.var_1FBB = "generic";
		var_00 scripts\sp\_utility::func_86E4();
	}

	lib_0B06::func_1EC3(var_00,self.var_1FA2);
	if(self.script_noteworthy == "base_exterior")
	{
		var_00 linkto(level.var_CC5B);
		return;
	}
	else if(self.script_noteworthy == "office_fight")
	{
		return;
	}

	wait(0.05);
	thread scripts\sp\maps\europa\europa_anim::func_C7C7(var_00);
	if(isdefined(self.var_EE79))
	{
		wait(0.05);
		var_00 method_839A();
	}
}

//Function Number: 3
func_8243()
{
	var_00 = [];
	var_00[var_00.size] = "head_bg_var_head_bg_male_06_head_sc_lee_blast_damage";
	var_00[var_00.size] = "head_bg_var_head_bg_engineering_mate_head_male_bc_01_blast_damage";
	var_00[var_00.size] = "head_bg_var_head_bg_engineering_mate_head_male_bc_04_blast_damage";
	var_00[var_00.size] = "head_bg_var_head_bg_engineering_mate_head_male_bc_05_blast_damage";
	var_00[var_00.size] = "head_bg_var_head_bg_male_06_head_male_bc_04_blast_damage";
	var_00[var_00.size] = "head_bg_var_head_bg_male_07_head_male_bc_03_blast_damage";
	var_00[var_00.size] = "head_bg_var_head_bg_male_07_head_male_bc_04_blast_damage";
	var_00[var_00.size] = "head_bg_var_head_bg_male_07_head_male_bc_05_blast_damage";
	var_00[var_00.size] = "head_bg_var_head_bg_male_07_head_sc_engineering_mate_blast_damage";
	return var_00;
}

//Function Number: 4
func_B285()
{
	var_00 = spawn("script_model",self.origin);
	var_01 = undefined;
	var_02 = undefined;
	if(self.script_noteworthy == "base_exterior")
	{
		var_03 = ["body_un_moon_guards_loadout_a","body_un_moon_guards_loadout_b"];
		var_01 = ::func_810D;
		var_02 = "europa_security";
	}
	else
	{
		var_03 = ["body_civ_facility_worker_lt","body_civ_facility_worker_drk"];
		var_01 = ::func_8243;
		var_02 = "europa_worker";
	}

	var_00 scripts\code\character::func_F7A1(var_03);
	var_00 scripts\code\character::func_2483(var_02,[[ var_01 ]]());
	return var_00;
}

//Function Number: 5
func_810D()
{
	var_00[0] = "head_bg_var_head_bg_engineering_mate_head_hero_gator_blast_damage";
	var_00[1] = "head_bg_var_head_bg_engineering_mate_head_male_bc_01_blast_damage";
	var_00[2] = "head_bg_var_head_bg_engineering_mate_head_male_bc_02_blast_damage";
	var_00[3] = "head_bg_var_head_bg_engineering_mate_head_male_bc_03_blast_damage";
	var_00[4] = "head_bg_var_head_bg_engineering_mate_head_male_bc_04_blast_damage";
	var_00[5] = "head_bg_var_head_bg_engineering_mate_head_male_bc_04_beard_blast_damage";
	var_00[6] = "head_bg_var_head_bg_engineering_mate_head_male_bc_05_blast_damage";
	var_00[7] = "head_bg_var_head_bg_engineering_mate_head_male_bc_06_blast_damage";
	var_00[8] = "head_bg_var_head_bg_engineering_mate_head_male_bc_07_blast_damage";
	var_00[9] = "head_bg_var_head_bg_engineering_mate_head_sc_lee_blast_damage";
	var_00[10] = "head_bg_male_06_blast_damage";
	var_00[11] = "head_bg_var_head_bg_male_06_head_male_bc_04_blast_damage";
	var_00[12] = "head_bg_var_head_bg_male_06_head_male_bc_04_beard_blast_damage";
	var_00[13] = "head_bg_var_head_bg_male_06_head_male_bc_05_blast_damage";
	var_00[14] = "head_bg_var_head_bg_male_06_head_sc_lee_blast_damage";
	var_00[15] = "head_bg_male_07_blast_damage";
	var_00[16] = "head_bg_var_head_bg_male_07_head_male_bc_03_blast_damage";
	var_00[17] = "head_bg_var_head_bg_male_07_head_male_bc_04_blast_damage";
	var_00[18] = "head_bg_var_head_bg_male_07_head_male_bc_04_beard_blast_damage";
	var_00[19] = "head_bg_var_head_bg_male_07_head_male_bc_05_blast_damage";
	var_00[20] = "head_bg_var_head_bg_male_07_head_male_bc_06_blast_damage";
	var_00[21] = "head_bg_var_head_bg_male_07_head_sc_engineering_mate_blast_damage";
	var_00[22] = "head_bg_var_head_bg_male_07_head_sc_lee_blast_damage";
	return var_00;
}

//Function Number: 6
func_119B1(param_00)
{
	var_01 = getentarray("base_reveal_vista","targetname");
	if(param_00)
	{
		scripts\common\utility::func_227D(var_01,::show);
		return;
	}

	scripts\common\utility::func_227D(var_01,::hide);
}

//Function Number: 7
func_100CA(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	if(getdvarint("debug_europa"))
	{
		iprintln("showing " + var_01.size + "brushes with targetname " + param_00);
	}

	foreach(var_03 in var_01)
	{
		var_03 show();
	}
}

//Function Number: 8
func_8E72(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	if(getdvarint("debug_europa"))
	{
		iprintln("Hiding " + var_01.size + "brushes with targetname " + param_00);
	}

	foreach(var_03 in var_01)
	{
		var_03 hide();
	}
}

//Function Number: 9
func_D2DC(param_00)
{
	level endon("stop_player_stay_behind");
	var_01 = scripts\common\utility::func_116D7(!isdefined(param_00),22500,param_00 * param_00);
	var_02 = 0.5;
	var_03 = 0.7;
	if(!isdefined(level.player.var_BCF5))
	{
		level.player.var_BCF5 = 1;
	}

	for(;;)
	{
		var_04 = distancesquared(level.player.origin,self.origin);
		var_05 = lib_0B4D::func_C097(0,var_01,var_04);
		var_05 = clamp(var_05,var_03,1);
		var_06 = var_05 - level.player.var_BCF5;
		var_07 = var_06 * var_02;
		var_08 = level.player.var_BCF5 + var_07;
		level.player setmovespeedscale(var_08);
		level.player.var_BCF5 = var_08;
		wait(0.05);
	}
}

//Function Number: 10
func_10181()
{
	function_01C5("player_sprintspeedscale",1.4);
	level notify("stop_player_stay_behind");
	thread scripts\sp\_utility::func_2B77(1);
}

//Function Number: 11
func_D24C(param_00)
{
	var_01 = level.player scripts\sp\_utility::func_D08C("ges_radio");
	if(var_01)
	{
		level.player scripts\common\utility::delaycall(0.5,::playsound,"ges_plr_radio_on");
		level.player method_8012(0);
		wait(0.8);
	}

	func_48BD(param_00);
	if(var_01)
	{
		level.player playsound("ges_plr_radio_off");
		level.player stopgestureviewmodel("ges_radio",1);
		level.player method_8012(1);
	}
}

//Function Number: 12
func_134B7(param_00)
{
	level.player endon("death");
	var_01 = strtok(param_00,"_");
	switch(var_01[1])
	{
		case "sip":
			level.var_EBBB scripts\sp\_utility::func_10346(param_00);
			break;

		case "tee":
			level.var_EBBC scripts\sp\_utility::func_10346(param_00);
			break;

		case "plr":
			if(isalive(level.player))
			{
				level.player scripts\sp\_utility::func_1034D(param_00);
			}
			break;

		case "war":
		case "cmp":
		case "rpr":
			level.player scripts\sp\_utility::func_CE2F(param_00);
			break;

		case "default":
			break;
	}
}

//Function Number: 13
func_48BD(param_00,param_01)
{
	if(isdefined(param_01))
	{
		level endon(param_01);
	}

	foreach(var_03 in param_00)
	{
		func_134B7(var_03);
		wait(randomfloatrange(0.1,0.15));
	}
}

//Function Number: 14
func_8E46(param_00)
{
	level.var_EBBB thread func_8E34(param_00);
	level.var_EBBC thread func_8E34(param_00);
	wait(0.1);
	scripts\common\utility::array_thread(level.var_EBCA,::func_13013,param_00);
}

//Function Number: 15
func_8E34(param_00)
{
	if(param_00 && isdefined(self.var_9F63))
	{
		return;
	}

	if(param_00)
	{
		if(self == level.player)
		{
			self.var_9F63 = 1;
			level.player method_8369("viewmodel_un_jackal_pilots_frost");
			if(getdvarint("debug_europa"))
			{
				iprintln("Swapping player  to snow gear");
			}

			return;
		}
		else
		{
			self.var_9F63 = 1;
			var_01 = scripts\common\utility::func_116D7(self == level.var_10214,"body_hero_sipes_frost","body_hero_t_frost");
			var_02 = scripts\common\utility::func_116D7(self == level.var_10214,"helmet_head_hero_sipes_frost","head_hero_t_helmet_frost");
			var_03 = "pack_un_jackal_pilots_frost";
			if(getdvarint("debug_europa"))
			{
				iprintln(self.var_1FBB + " swapping to snow gear");
			}
		}
	}
	else
	{
		if(!isdefined(self.var_9F63))
		{
			return;
		}

		if(self == level.player)
		{
			self.var_9F63 = undefined;
			level.player method_8369("viewmodel_un_jackal_pilots");
			if(getdvarint("debug_europa"))
			{
				iprintln("Swapping player to non-snow gear");
			}

			return;
		}
		else
		{
			self.var_9F63 = undefined;
			var_01 = scripts\common\utility::func_116D7(self == level.var_10214,"body_hero_sipes","body_hero_t");
			var_02 = scripts\common\utility::func_116D7(self == level.var_10214,"helmet_head_hero_sipes","head_hero_t_helmet");
			var_03 = "pack_un_jackal_pilots_zerog";
			if(getdvarint("debug_europa"))
			{
				iprintln(self.var_1FBB + " swapping to non-snow gear");
			}
		}
	}

	self setmodel(var_01);
	self detach(self.var_8C43);
	self.var_8C43 = var_02;
	self attach(self.var_8C43);
	self detach(self.var_A489);
	self.var_A489 = var_03;
	self attach(self.var_A489);
}

//Function Number: 16
func_13013(param_00,param_01)
{
	if(isai(self))
	{
		var_02 = scripts\common\utility::func_116D7(param_00 == 1,"iw7_fhr_snow+reflexsmg+silencersmg_snow","iw7_fhr+reflexsmg+silencersmg");
		scripts\sp\_utility::func_72EC(var_02,"primary");
		return;
	}

	var_03 = level.player getcurrentprimaryweapon();
	var_04 = issubstr(var_03,"m4");
	var_05 = issubstr(level.player getcurrentweapon(),"alt_");
	var_06 = undefined;
	var_07 = scripts\sp\_utility::func_7D74(1);
	var_08 = 0;
	foreach(var_02 in var_07)
	{
		func_119C6(var_02,param_00);
	}

	if(!isdefined(param_01))
	{
		return;
	}

	if(isdefined(param_01) && !param_01)
	{
		return;
	}

	var_0B = scripts\sp\_utility::func_7D74(1);
	foreach(var_0D in var_0B)
	{
		if(var_04)
		{
			if(issubstr(var_0D,"m4"))
			{
				var_06 = var_0D;
				break;
			}

			continue;
		}

		if(issubstr(var_0D,"fhr"))
		{
			var_06 = var_0D;
			break;
		}
	}

	if(var_05)
	{
		var_06 = "alt_" + var_06;
	}

	level.player method_83B6(var_06);
}

//Function Number: 17
func_119C6(param_00,param_01)
{
	var_02 = strtok(param_00,"+");
	if(param_01)
	{
		var_03["iw7_m4"] = 1;
		var_03["iw7_fhr"] = 1;
	}
	else
	{
		param_00["iw7_m4_snow"] = 1;
		var_03["iw7_fhr_snow"] = 1;
	}

	if(isdefined(var_03[var_02[0]]))
	{
		var_04 = level.player method_80FB(param_00);
		var_05 = level.player getweaponammoclip(param_00);
		if(param_01)
		{
			var_06 = var_02[0] + "_snow";
		}
		else
		{
			var_06 = scripts\common\utility::func_116D7(var_03[0] == "iw7_m4_snow","iw7_m4","iw7_fhr");
		}

		if(getdvarint("debug_europa"))
		{
			iprintln("Swapping player weapon from " + var_02[0] + " to " + var_06);
		}

		for(var_07 = 0;var_07 < var_02.size;var_07++)
		{
			if(var_07 == 0)
			{
				continue;
			}

			if(issubstr(var_02[var_07],"silencer"))
			{
				var_02[var_07] = func_B935(var_02[var_07],param_01);
			}

			if(issubstr(var_02[var_07],"hybrid"))
			{
				var_02[var_07] = scripts\common\utility::func_116D7(param_01,"hybrid_snow","hybrid");
			}

			if(issubstr(var_02[var_07],"reflexsmg"))
			{
				var_02[var_07] = scripts\common\utility::func_116D7(param_01,"reflexsmg_snow","reflexsmg");
			}

			var_06 = var_06 + "+" + var_02[var_07];
		}

		if(level.player hasweapon("alt_" + param_00))
		{
			level.player takeweapon("alt_" + param_00);
		}

		level.player takeweapon(param_00);
		level.player giveweapon(var_06);
		level.player setweaponammoclip(var_06,var_05);
		level.player setweaponammostock(var_06,var_04);
		return var_06;
	}

	return undefined;
}

//Function Number: 18
func_B935(param_00,param_01)
{
	if(param_01)
	{
		if(issubstr(param_00,"smg"))
		{
			param_00 = "silencersmg_snow";
		}
		else
		{
			param_00 = "silencer_snow";
		}
	}
	else if(issubstr(param_00,"smg"))
	{
		param_00 = "silencersmg";
	}
	else
	{
		param_00 = "silencer";
	}

	return param_00;
}

//Function Number: 19
func_8CA5()
{
	self endon("stop_headtrack_when_close");
	var_00 = squared(60);
	for(;;)
	{
		if(distance2dsquared(self.origin,level.player.origin) <= var_00)
		{
			thread scripts\sp\_utility::func_7799(level.player,2,2);
			thread scripts\sp\_utility::func_7792(level.player);
			wait(2);
			while(distance2dsquared(self.origin,level.player.origin) <= var_00)
			{
				wait(0.05);
			}

			scripts\sp\_utility::func_77B9(1.25);
			wait(3);
		}

		wait(0.1);
	}
}

//Function Number: 20
func_11003()
{
	self notify("stop_headtrack_when_close");
	scripts\sp\_utility::func_77B9(0.25);
}

//Function Number: 21
func_D85C()
{
	level.player.var_C39D = level.player getcurrentweapon();
	level.player method_80AA();
	level.player setstance("stand");
	level.player allowprone(0);
	level.player allowcrouch(0);
	level.player method_84FE();
}

//Function Number: 22
func_DF3E()
{
	level.player unlink(1);
	level.player allowprone(1);
	level.player allowcrouch(1);
	level.player enableweapons();
	level.player method_84FD();
	var_00 = undefined;
	if(isdefined(level.player.var_C39D))
	{
		var_00 = level.player.var_C39D;
	}
	else
	{
		var_00 = level.player getweaponslistprimaries()[0];
	}

	level.player method_83B6(var_00);
}

//Function Number: 23
func_51E2(param_00)
{
	if(isdefined(self.var_51E3) && self.var_51E3 == param_00)
	{
		return;
	}

	if(isdefined(self.var_51E3) && self.var_51E3 == "cqb")
	{
		scripts\sp\_utility::func_5514();
	}

	scripts\sp\_utility::func_51E1(param_00);
}

//Function Number: 24
func_1968()
{
	self endon("death");
	if(!isdefined(self.var_EE79))
	{
		iprintln("ai gesture trig has no script_paramaters");
	}

	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isdefined(var_00) || isplayer(var_00))
		{
			continue;
		}

		var_01 = strtok(self.var_EE79," ");
		if(var_01.size > 1)
		{
			var_02 = scripts\common\utility::random(var_01);
		}
		else
		{
			var_02 = var_02[0];
		}

		var_00 thread func_193C(var_02,self);
	}
}

//Function Number: 25
func_193C(param_00,param_01)
{
	if(isdefined(self.var_4B79) && self.var_4B79 == param_01)
	{
		return;
	}

	if(!isdefined(self.var_4B79) || self.var_4B79 != param_01)
	{
		self.var_4B79 = param_01;
	}

	scripts\sp\_utility::func_77B7(param_00);
}

//Function Number: 26
func_5F7C(param_00)
{
	level endon("stop_catching_up");
	level.player endon("death");
	scripts\common\utility::array_thread(param_00,::scripts\sp\_utility::func_61E7);
	for(;;)
	{
		foreach(var_02 in param_00)
		{
			param_00 = scripts\sp\_utility::func_22BB(param_00);
			if(!param_00.size)
			{
				return;
			}

			if(isdefined(var_02.var_C9BD))
			{
				wait(0.05);
				continue;
			}

			var_03 = 0;
			var_04 = var_02 func_9B77();
			var_05 = distance2dsquared(var_02.origin,level.player.origin);
			if(var_05 >= 10000 && var_04)
			{
				var_03 = 1;
				if(isdefined(var_02.var_51E3) && var_02.var_51E3 == "cqb")
				{
					if(isalive(var_02))
					{
						var_02 scripts\sp\_utility::func_51E1("sprint");
					}
				}

				continue;
			}

			if(!isdefined(var_02.var_51E3) || var_02.var_51E3 != "cqb")
			{
				if(isalive(var_02))
				{
					var_02 scripts\sp\_utility::func_61E7();
				}
			}
		}

		wait(0.1);
	}
}

//Function Number: 27
func_9B77()
{
	if(!isalive(self))
	{
		return 0;
	}

	var_00 = anglestoforward(self.angles);
	var_01 = vectornormalize(level.player.origin - self.origin);
	var_02 = vectordot(var_00,var_01);
	if(var_02 < 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 28
func_10FE5(param_00)
{
	level notify("stop_catching_up");
	scripts\common\utility::array_thread(param_00,::scripts\sp\_utility::func_5514);
}

//Function Number: 29
func_10FC2()
{
	scripts\sp\_utility::func_1F53();
	self notify("new_anim_reach");
	self.var_15C = 32;
}

//Function Number: 30
func_107C5()
{
	func_107C2();
	func_107C3();
	level.var_EBCA = [level.var_EBBB,level.var_EBBC];
	scripts\common\utility::flag_set("scars_spawned");
}

//Function Number: 31
func_107C2()
{
	var_00 = scripts\common\utility::get_target_ent("scar_1");
	var_00.var_C1 = 1;
	level.var_EBBB = var_00 scripts\sp\_utility::func_10619(1);
	level.var_EBBB thread scripts\sp\_utility::func_5131();
	level.var_EBBB.var_1FBB = "scar1";
	level.var_EBBB.script_noteworthy = "scar1";
	level.var_EBBB scripts\sp\_utility::func_F3B5("r");
	level.var_EBBB scripts\sp\_utility::func_F2DA(0);
	level.var_EBBB.var_C062 = 1;
	level.var_EBBB scripts\sp\_utility::func_F417(1);
	level.var_EBBB scripts\sp\_utility::func_72EC("iw7_fhr+reflexsmg+silencersmg","primary");
	level.var_EBBB scripts\sp\_utility::func_F3E6(0);
	level.var_EBBB.var_15C = 32;
	level.var_EBBB.var_C065 = 1;
	level.var_10214 = level.var_EBBB;
}

//Function Number: 32
func_107C3()
{
	var_00 = scripts\common\utility::get_target_ent("scar_2");
	var_00.var_C1 = 1;
	level.var_EBBC = var_00 scripts\sp\_utility::func_10619(1);
	level.var_EBBC thread scripts\sp\_utility::func_5131();
	level.var_EBBC.var_1FBB = "scar2";
	level.var_EBBC.script_noteworthy = "scar2";
	level.var_EBBC scripts\sp\_utility::func_F3B5("r");
	level.var_EBBC scripts\sp\_utility::func_F2DA(0);
	level.var_EBBC.var_C062 = 1;
	level.var_EBBC scripts\sp\_utility::func_F417(1);
	level.var_EBBC scripts\sp\_utility::func_72EC("iw7_fhr+reflexsmg+silencersmg","primary");
	level.var_EBBC scripts\sp\_utility::func_F3E6(0);
	level.var_EBBC.var_15C = 32;
	level.var_EBBC.var_C065 = 1;
	level.var_113AD = level.var_EBBC;
}

//Function Number: 33
func_EBC7()
{
	level.var_EBBB scripts\sp\_utility::func_F3B5("r");
	level.var_EBBC scripts\sp\_utility::func_F3B5("b");
}

//Function Number: 34
func_EBC4()
{
	level.var_EBBB scripts\sp\_utility::func_F3B5("r");
	level.var_EBBC scripts\sp\_utility::func_F3B5("r");
}

//Function Number: 35
func_EBCE(param_00)
{
	if(param_00)
	{
		foreach(var_02 in level.var_EBCA)
		{
			var_02.var_43A9 = ::func_D965;
		}

		return;
	}

	foreach(var_02 in level.var_EBCA)
	{
		var_02.var_43A9 = undefined;
	}
}

//Function Number: 36
func_D965(param_00)
{
	wait(2);
	self waittill("goal");
	if(isdefined(param_00.var_ED9E))
	{
		scripts\common\utility::flag_set(param_00.var_ED9E);
	}

	if(isdefined(param_00.var_ED80))
	{
		scripts\sp\_utility::func_65E1(param_00.var_ED80);
	}

	if(isdefined(param_00.var_ED9B))
	{
		scripts\common\utility::func_6E2A(param_00.var_ED9B);
	}

	if(isdefined(param_00.var_EDC7))
	{
		thread scripts\sp\_utility::func_77B7(param_00.var_EDC7);
	}
}

//Function Number: 37
func_19DB()
{
	self endon("death");
	var_00 = 250;
	var_01 = distance(self.origin,level.player.origin);
	for(;;)
	{
		wait(level.var_F106);
		self.var_15C = var_01;
		self method_82ED(level.player);
		var_01 = var_01 - 175;
		if(var_01 < var_00)
		{
			var_01 = var_00;
			return;
		}
	}
}

//Function Number: 38
func_C120(param_00,param_01)
{
	if(!isdefined(self.script_noteworthy))
	{
		return 0;
	}

	param_00 = tolower(param_00);
	var_02 = tolower(self.script_noteworthy);
	if(!isdefined(param_01))
	{
		if(var_02 == param_00)
		{
			return 1;
		}

		return 0;
	}

	var_03 = strtok(var_02,param_01);
	foreach(var_05 in var_03)
	{
		if(var_05 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 39
func_C8ED(param_00,param_01)
{
	if(!isdefined(self.var_EE79))
	{
		return 0;
	}

	param_00 = tolower(param_00);
	var_02 = tolower(self.var_EE79);
	if(!isdefined(param_01))
	{
		if(var_02 == param_00)
		{
			return 1;
		}

		return 0;
	}

	var_03 = strtok(var_02,param_01);
	foreach(var_05 in var_03)
	{
		if(var_05 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 40
func_F5B1(param_00)
{
	var_01 = scripts\common\utility::getstructarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		switch(var_03.script_noteworthy)
		{
			case "player":
				level.player setorigin(var_03.origin);
				level.player setplayerangles(var_03.angles);
				break;

			case "salter":
				level.var_EA2C method_80F1(var_03.origin,var_03.angles);
				level.var_EA2C method_82EF(var_03.origin);
				if(isdefined(var_03.var_1FA2))
				{
					var_03 thread lib_0B06::func_1EC7(level.var_EA2C,var_03.var_1FA2);
				}
	
				if(isdefined(var_03.target))
				{
					var_03 = var_03 scripts\common\utility::get_target_ent();
					level.var_EA2C thread scripts\sp\_utility::func_7227(var_03);
				}
				break;

			case "mccallum":
				level.var_B4F1 method_80F1(var_03.origin,var_03.angles);
				level.var_B4F1 method_82EF(var_03.origin);
				if(isdefined(var_03.var_1FA2))
				{
					var_03 thread lib_0B06::func_1EC7(level.var_B4F1,var_03.var_1FA2);
				}
	
				if(isdefined(var_03.target))
				{
					var_03 = var_03 scripts\common\utility::get_target_ent();
					level.var_B4F1 thread scripts\sp\_utility::func_7227(var_03);
				}
				break;
		}
	}
}

//Function Number: 41
func_1F8A()
{
	var_00 = self.var_1FA2;
	if(isdefined(self.var_EDA0))
	{
		scripts\common\utility::flag_wait(self.var_EDA0);
	}

	scripts\sp\_utility::script_delay();
	self method_83D0(#animtree);
	thread lib_0B06::func_1ECC(self,var_00);
	if(isdefined(self.var_EE2C))
	{
		scripts\common\utility::func_136F7();
		self method_82B1(scripts\sp\_utility::func_7DC3(var_00)[0],self.var_EE2C);
	}

	if(isdefined(self.var_ED48))
	{
		scripts\common\utility::flag_wait(self.var_ED48);
		self delete();
	}
}

//Function Number: 42
func_5168()
{
	self waittill("trigger");
	var_00 = scripts\sp\_utility::func_7A8F();
	scripts\sp\_utility::func_228A(var_00);
}

//Function Number: 43
func_67C4(param_00)
{
	var_01 = getent(param_00,"targetname");
	var_02 = [level.var_B4F1,level.var_EA2C];
	while(isdefined(var_01.target))
	{
		var_03 = getent(var_01.target,"targetname");
		func_13865(var_01,var_03,var_02);
		var_01 scripts\common\utility::trigger_off();
		var_01 = var_03;
	}

	foreach(var_05 in var_02)
	{
		var_05.var_51E3 = undefined;
	}
}

//Function Number: 44
func_13865(param_00,param_01,param_02)
{
	param_01 endon("trigger");
	for(;;)
	{
		foreach(var_04 in param_02)
		{
			var_05 = anglestoforward(var_04.angles);
			var_06 = vectornormalize(var_04.origin - level.player.origin);
			var_07 = vectordot(var_05,var_06);
			if(var_07 > 0)
			{
				var_04.var_51E3 = "casual_gun";
				continue;
			}

			var_04.var_51E3 = undefined;
		}

		wait(0.1);
	}
}

//Function Number: 45
func_1F38(param_00,param_01,param_02,param_03)
{
	lib_0B06::func_1F35(param_00,param_01);
	thread lib_0B06::func_1EEA(param_00,param_02);
	if(isdefined(param_03))
	{
		self notify("sNotify");
	}
}

//Function Number: 46
func_1F15(param_00,param_01,param_02,param_03,param_04)
{
	lib_0B06::func_1F17(param_00,param_01);
	lib_0B06::func_1F35(param_00,param_01);
	thread lib_0B06::func_1EEA(param_00,param_02,param_03);
	if(isdefined(param_04))
	{
		self notify(param_04);
	}
}

//Function Number: 47
func_9E47(param_00)
{
	var_01 = anglestoforward(param_00.angles);
	var_02 = vectornormalize(param_00.origin - self.origin);
	var_03 = vectordot(var_01,var_02);
	if(var_03 <= 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 48
func_9D64(param_00)
{
	var_01 = anglestoforward(param_00.angles);
	var_02 = vectornormalize(param_00.origin - self.origin);
	var_03 = vectordot(var_01,var_02);
	if(var_03 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 49
func_61DC()
{
	scripts\sp\_utility::func_61F7();
	scripts\sp\_utility::func_61DB();
}

//Function Number: 50
func_5505()
{
	scripts\sp\_utility::func_5528();
	scripts\sp\_utility::func_5504();
}

//Function Number: 51
func_13815(param_00)
{
	var_01 = getent(param_00,"targetname");
	var_01 waittill("trigger");
}

//Function Number: 52
func_13814(param_00)
{
	var_01 = getent(param_00,"script_noteworthy");
	var_01 waittill("trigger");
}

//Function Number: 53
func_127B6(param_00)
{
	self endon("death");
	param_00 endon("death");
	for(;;)
	{
		self waittill("trigger",var_01);
		if(var_01 == param_00)
		{
			break;
		}
	}
}

//Function Number: 54
func_127B5(param_00)
{
	for(;;)
	{
		var_01 = 1;
		foreach(var_03 in param_00)
		{
			if(!var_03 istouching(self))
			{
				var_01 = 0;
				break;
			}
		}

		if(var_01)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 55
func_83C7()
{
	var_00 = getglass(self.target);
	self waittill("trigger",var_01);
	var_02 = anglestoforward(var_01.angles);
	destroyglass(var_00,var_02);
}

//Function Number: 56
func_519D(param_00)
{
	var_01 = getent(param_00,"targetname");
	var_01 delete();
}

//Function Number: 57
func_1144C()
{
	var_00 = level.player getweaponslist("offhand");
	foreach(var_02 in var_00)
	{
		if(issubstr(var_02,"frag"))
		{
			level.player takeweapon(var_02);
		}
	}
}

//Function Number: 58
func_1144E()
{
	var_00 = level.player getweaponslist("offhand");
	foreach(var_02 in var_00)
	{
		if(issubstr(var_02,"retractableshield"))
		{
			level.player takeweapon(var_02);
		}
	}
}

//Function Number: 59
func_67C2()
{
	if(getdvarint("ai_iw7") == 0)
	{
		self method_83A1();
		return;
	}

	lib_0A1E::func_2386();
}

//Function Number: 60
func_79CE(param_00,param_01,param_02)
{
	var_03 = vectornormalize(param_02 - param_00);
	var_04 = anglestoforward(param_01);
	var_05 = vectordot(var_04,var_03);
	return var_05;
}

//Function Number: 61
func_E45E(param_00,param_01,param_02)
{
	var_03 = param_01 * randomfloat(1);
	var_04 = randomfloat(360);
	var_05 = sin(var_04);
	var_06 = cos(var_04);
	var_07 = var_03 * var_06;
	var_08 = var_03 * var_05;
	var_09 = 0;
	if(isdefined(param_02))
	{
		var_09 = randomfloatrange(param_02 * -1,param_02);
	}

	var_07 = var_07 + param_00[0];
	var_08 = var_08 + param_00[1];
	var_09 = var_09 + param_00[2];
	return (var_07,var_08,var_09);
}

//Function Number: 62
func_36DF(param_00,param_01,param_02,param_03)
{
	var_04 = param_00[0];
	var_05 = param_00[1];
	var_06 = param_00[2];
	var_07 = param_01[0];
	var_08 = param_01[1];
	var_09 = param_01[2];
	var_0A = [param_00,param_01];
	var_0B = func_7ADF(var_0A,param_02);
	var_0C = var_0B[0];
	var_0D = var_0B[1];
	var_0E = var_0B[2];
	var_0F = [];
	for(var_10 = 1;var_10 <= param_03;var_10++)
	{
		var_11 = var_10 / param_03;
		var_12 = int(1 - var_11 * 1 - var_11 * var_04 + 2 * 1 - var_11 * var_11 * var_0C + var_11 * var_11 * var_07);
		var_13 = int(1 - var_11 * 1 - var_11 * var_05 + 2 * 1 - var_11 * var_11 * var_0D + var_11 * var_11 * var_08);
		var_14 = int(1 - var_11 * 1 - var_11 * var_06 + 2 * 1 - var_11 * var_11 * var_0E + var_11 * var_11 * var_09);
		var_0F[var_10] = (var_12,var_13,var_14);
	}

	return var_0F;
}

//Function Number: 63
func_7ADF(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	for(var_05 = 0;var_05 < param_00.size;var_05++)
	{
		var_02 = var_02 + param_00[var_05][0];
		var_03 = var_03 + param_00[var_05][1];
		var_04 = var_04 + param_00[var_05][2];
	}

	return (var_02 / param_00.size,var_03 / param_00.size,var_04 / param_00.size + param_01);
}

//Function Number: 64
func_1776(param_00)
{
	if(!isdefined(level.var_67B9))
	{
		level.var_67B9 = [];
	}

	if(!isdefined(level.var_67B9[param_00]))
	{
	}

	var_01 = spawnstruct();
	level.var_67B9[param_00] = scripts\common\utility::array_add(level.var_67B9[param_00],var_01);
	var_01 waittill("queue_hit");
	return var_01;
}

//Function Number: 65
func_48F4(param_00,param_01,param_02)
{
	level.var_67B9[param_00] = [];
	thread func_7766(param_00,param_01);
}

//Function Number: 66
func_7766(param_00,param_01,param_02)
{
	for(;;)
	{
		var_03 = level.var_67B9[param_00];
		if(!var_03.size)
		{
		}
		else
		{
			var_03[0] notify("queue_hit");
			if(isdefined(param_01))
			{
				wait(param_01);
			}

			if(isdefined(param_02))
			{
				var_03[0] waittill("continue_queue");
			}

			level.var_67B9[param_00] = scripts\common\utility::func_22A9(level.var_67B9[param_00],var_03[0]);
		}

		wait(0.1);
	}
}

//Function Number: 67
func_BC50(param_00)
{
	if(isstring(param_00))
	{
		param_00 = func_7988(param_00);
	}

	var_01 = undefined;
	var_02 = (0,0,110);
	if(isdefined(level.var_133EC))
	{
		if(isdefined(level.var_133EC.var_12F97))
		{
			if(isdefined(level.var_133EC.var_12F97[0]))
			{
				var_01 = level.var_133EC.var_12F97[0].var_10229;
			}
		}
	}

	var_01 moveto(param_00.origin + var_02,0.05);
	if(isdefined(param_00.angles))
	{
		var_01.angles = param_00.angles;
	}
}

//Function Number: 68
func_7988(param_00)
{
	var_01 = getent(param_00,"targetname");
	if(isdefined(var_01))
	{
		return var_01;
	}

	var_01 = scripts\common\utility::getstruct(param_00,"targetname");
	if(isdefined(var_01))
	{
		return var_01;
	}

	var_01 = [[ level.var_7FF9 ]](param_00,"targetname");
	if(isdefined(var_01))
	{
		return var_01;
	}

	var_01 = getvehiclenode(param_00,"targetname");
	if(isdefined(var_01))
	{
		return var_01;
	}
}

//Function Number: 69
func_AFF1()
{
	self notify("end_look_at_node");
	self endon("end_look_at_node");
	self endon("stop_look_at_next_node");
	while(!isdefined(self.var_4BF7))
	{
		wait(0.05);
	}

	self method_8379("instant");
	self.var_F472 = 1;
	self.var_B00A = spawn("script_origin",(0,0,0));
	self method_8305(self.var_B00A);
	for(;;)
	{
		if(!isdefined(self.var_4BF7.target))
		{
			break;
		}

		var_00 = scripts\common\utility::getstruct(self.var_4BF7.target,"targetname");
		self.var_B00A.origin = var_00.origin;
		self waittill("reached_current_node");
	}
}

//Function Number: 70
func_11017()
{
	self notify("stop_look_at_next_node");
	self method_8076();
	self.var_F472 = 0;
	self.var_B00A delete();
}

//Function Number: 71
func_D83D()
{
	var_00 = scripts\common\utility::get_target_ent("interior_base_speed_volume");
	var_00 hide();
}

//Function Number: 72
func_1330E()
{
	self notify("disable_jackal_dust_vfx");
	self endon("disable_jackal_dust_vfx");
	for(;;)
	{
		if(level.var_133EC.var_D1A4.var_BD69 <= 70 && level.var_133EC.var_D1A4.var_BD69 >= 20)
		{
		}
		else if(level.var_133EC.var_D1A4.var_BD69 >= 140)
		{
		}
		else if(level.var_133EC.var_D1A4.var_BD69 <= 19)
		{
		}
		else
		{
		}

		wait(0.1);
	}
}

//Function Number: 73
func_116B5()
{
	level notify("temp_player_speed");
	level endon("temp_player_speed");
	wait(5);
	for(;;)
	{
		iprintln(level.var_133EC.var_D1A4.var_BD69);
		wait(1);
	}
}

//Function Number: 74
func_11690()
{
	level notify("temp_flight_hack");
	level endon("temp_flight_hack");
	level.var_133EC.var_D1A4 scripts\sp\_utility::func_65E1("auto_boost_on");
	wait(1);
	level.var_133EC.var_D1A4 scripts\sp\_utility::func_65DD("auto_boost_on");
}

//Function Number: 75
func_8578()
{
	setdvarifuninitialized("grenade_indicator",0);
	function_01C5("r_hudoutlineEnable",1);
	if(getdvarint("grenade_indicator") != 1)
	{
		return;
	}

	var_00 = function_00C8();
	scripts\sp\_utility::func_22C7(var_00,::func_857A);
}

//Function Number: 76
func_857A()
{
	self endon("death");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_00 thread func_8579();
	}
}

//Function Number: 77
func_8579()
{
	self method_818E(1,0,0);
	function_020B(self);
	function_0214(self,"hud_grenadethrowback");
	var_00 = 0;
	while(isdefined(self))
	{
		var_01 = distance(self.origin,level.player.origin);
		if(var_01 > 250 && var_00 == 0)
		{
			var_00 = 1;
			self method_818B();
			function_0206(self,level.player);
			continue;
		}

		if(var_01 <= 250 && var_00 == 1)
		{
			var_00 = 0;
			self method_818E(1,0,0);
			function_0215(self,level.player);
		}

		wait(0.1);
	}
}

//Function Number: 78
func_4ED5()
{
	for(;;)
	{
		if(!getdvarint("debug_ent_count"))
		{
			wait(0.2);
			continue;
		}

		var_00 = 110;
		var_01 = scripts\sp\_hud_util::createfontstring("default",1.5);
		var_01.x = 580;
		var_01.y = var_00;
		var_00 = var_00 + 15;
		var_02 = scripts\sp\_hud_util::createfontstring("default",1.5);
		var_02.x = 580;
		var_02.y = var_00;
		var_00 = var_00 + 15;
		var_03 = scripts\sp\_hud_util::createfontstring("default",1.5);
		var_03.x = 580;
		var_03.y = var_00;
		var_00 = var_00 + 15;
		var_04 = scripts\sp\_hud_util::createfontstring("default",1.5);
		var_04.x = 580;
		var_04.y = var_00;
		var_00 = var_00 + 15;
		var_05 = scripts\sp\_hud_util::createfontstring("default",1.5);
		var_05.x = 580;
		var_05.y = var_00;
		var_00 = var_00 + 15;
		var_06 = scripts\sp\_hud_util::createfontstring("default",1.5);
		var_06.x = 580;
		var_06.y = var_00;
		var_00 = var_00 + 15;
		var_07 = scripts\sp\_hud_util::createfontstring("default",1.5);
		var_07.x = 580;
		var_07.y = var_00;
		thread func_65D8(var_03,var_04,var_05,var_06,var_07);
		while(getdvarint("debug_ent_count"))
		{
			wait(0.1);
			continue;
		}

		level notify("stop_ai_drone_debug");
		var_02 destroy();
		var_01 destroy();
		var_03 destroy();
		var_04 destroy();
		var_05 destroy();
		var_06 destroy();
		var_07 destroy();
	}
}

//Function Number: 79
func_4EA2(param_00,param_01)
{
	level endon("stop_ai_drone_debug");
	for(;;)
	{
		var_02 = level.var_13267["allies"];
		var_02 = scripts\common\utility::array_combine(var_02,level.var_13267["axis"]);
		var_03 = function_0072();
		param_00 settext("Vehicles : " + var_02.size);
		param_01 settext("AI : " + var_03.size);
		wait(0.05);
	}
}

//Function Number: 80
func_65D8(param_00,param_01,param_02,param_03,param_04)
{
	level endon("stop_ai_drone_debug");
	var_05 = 0;
	var_06 = 50;
	var_07 = 0;
	var_08 = 0;
	var_09 = 0;
	for(;;)
	{
		var_0A = getentarray("script_model","classname");
		var_0B = getentarray("script_origin","classname");
		param_00 settext("models : " + var_0A.size);
		param_01 settext("origins : " + var_0B.size);
		var_0C = var_0A.size + var_0B.size;
		param_02 settext("total : " + var_0C);
		var_07 = var_07 + var_0C;
		param_03 settext("average : " + var_05);
		var_08++;
		if(var_08 == var_06)
		{
			var_05 = int(var_07 / var_06);
			var_07 = 0;
			var_08 = 0;
		}

		if(var_0C > var_09)
		{
			var_09 = var_0C;
			param_04 settext("highest :" + var_09);
		}

		wait(0.05);
	}
}

//Function Number: 81
func_16DD(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_02 thread [[ param_01 ]]();
}

//Function Number: 82
func_1368F(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_03 = var_02 scripts\sp\_utility::func_77E3("axis");
	var_04 = var_03.size;
	while(var_04 > param_01)
	{
		var_03 = var_02 scripts\sp\_utility::func_77E3("axis");
		var_04 = var_03.size;
		if(var_04 - param_01 < 3)
		{
			foreach(var_06 in var_03)
			{
				if(var_06 scripts\sp\_utility::func_58DA() || var_06.var_EB)
				{
					var_04--;
				}
			}
		}

		wait(0.2);
	}
}

//Function Number: 83
func_A761(param_00,param_01,param_02)
{
	if(!isdefined(level.var_5A91))
	{
		level.var_5A91 = [];
	}

	var_03 = scripts\common\utility::getstructarray(param_00,"targetname");
	foreach(var_05 in var_03)
	{
		var_05 thread func_A764(param_00,param_01,param_02);
	}
}

//Function Number: 84
func_A764(param_00,param_01,param_02)
{
	self endon("disable_spawn");
	if(isdefined(param_01))
	{
		param_01 waittill("trigger");
	}

	var_03 = func_10752();
	var_03 scripts\sp\_utility::func_F2A8(1);
	var_03 setcandamage(1);
	var_03 scripts\sp\_utility::func_1101B();
	var_03 endon("death");
	if(!isdefined(level.var_5A91[param_00]))
	{
		level.var_5A91[param_00] = [];
	}

	level.var_5A91[param_00] = scripts\common\utility::array_add(level.var_5A91[param_00],var_03);
	if(!isdefined(self.angles))
	{
		self.angles = (0,0,0);
	}

	lib_0B06::func_1EC3(var_03,"robot_power_on");
	var_04 = undefined;
	if(isdefined(self.target))
	{
		var_05 = getentarray(self.target,"targetname");
		var_04 = undefined;
		foreach(var_07 in var_05)
		{
			if(var_07 func_C120("delete_robot"))
			{
				thread func_A762(var_07);
				continue;
			}

			var_04 = var_07;
		}
	}

	if(isdefined(var_04))
	{
		var_04 scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,"trigger");
	}

	if(isdefined(param_02) && param_02)
	{
		var_03 scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,"awaken");
	}

	if(isdefined(var_04) || isdefined(param_02) && param_02)
	{
		scripts\sp\_utility::func_57D6();
	}

	var_03 notify("awaken");
	if(isdefined(self.var_EDCF))
	{
		var_09 = self.var_EDCF;
		var_0A = function_00B3(self.target,"targetname");
		if(isdefined(var_0A))
		{
			var_03 method_82F0(level.var_8438[var_09]);
		}
		else
		{
			var_03 method_82F1(level.var_8438[var_09]);
		}
	}
	else
	{
		var_03.var_BC = "no_cover";
	}

	var_03 method_82EF(var_03.origin);
	var_03 func_A78D();
	lib_0B06::func_1F35(var_03,"robot_power_on");
}

//Function Number: 85
func_A762(param_00)
{
	self endon("death");
	self endon("awaken");
	param_00 waittill("trigger");
	self delete();
}

//Function Number: 86
func_A763(param_00)
{
	self endon("spawned");
	param_00 waittill("trigger");
	self notify("disable_spawn");
}

//Function Number: 87
func_E59D(param_00,param_01,param_02,param_03)
{
	self endon("robot_locker_opened");
	if(isdefined(param_01))
	{
		param_01 waittill("trigger");
	}

	var_04 = scripts\sp\_utility::func_10639("robot",self.origin);
	var_05 = scripts\sp\_utility::func_10639("locker_arm",self.origin);
	self.var_AF1E = var_05;
	self.var_6B53 = var_04;
	var_06 = [var_05,var_04];
	lib_0B06::func_1EC1(var_06,"robot_locker_on");
	if(isdefined(self.script_noteworthy))
	{
		thread func_E59A();
	}

	if(isdefined(param_03))
	{
		param_03 waittill("trigger");
		if(isdefined(self.var_AF1E))
		{
			self.var_AF1E delete();
		}

		if(isdefined(self.var_6B53))
		{
			self.var_6B53 delete();
		}
	}
}

//Function Number: 88
func_E59C(param_00)
{
	if(isdefined(param_00))
	{
		param_00 waittill("trigger");
	}

	var_01 = func_10752();
	var_02 = [self.var_AF1E,var_01];
	lib_0B06::func_1EC3(self.var_AF1E,"robot_locker_on");
	thread lib_0B06::func_1EEA(var_01,"robot_locker_idle");
	if(isdefined(self.var_6B53))
	{
		self.var_6B53 delete();
	}

	var_03 = anglestoforward(self.angles);
	var_04 = self.origin + var_03 * 15;
	playfx(scripts\common\utility::getfx("robot_locker_open"),var_04,var_03);
	func_E59B();
	var_05 = 2.2;
	var_06 = 1;
	foreach(var_08 in self.var_5A2B)
	{
		function_0178("robot_locker_open",self.origin);
		var_09 = 45;
		if(var_08.var_EE79 == "left")
		{
			var_09 = var_09 * -1;
		}

		var_08 rotateyaw(var_09,var_05,var_05 / 2,var_05 / 2);
		if(isdefined(var_06) && !var_06)
		{
			wait(randomfloatrange(0.1,0.3));
		}

		var_06 = undefined;
	}

	wait(var_05 / 2);
	self notify("stop_loop");
	var_01 method_83A1();
	lib_0B06::func_1F2C(var_02,"robot_locker_on");
	var_03 = anglestoforward(self.angles);
	var_0B = scripts\common\utility::spawn_tag_origin(var_01.origin);
	var_01 linkto(var_0B);
	var_0C = var_0B.origin + var_03 * 40;
	var_0B moveto(var_0C,0.2);
	wait(0.2);
	var_01 unlink();
	var_0B delete();
	var_01 scripts\sp\_utility::func_1101B();
	var_01 scripts\sp\_utility::func_6224();
	var_01.var_180 = 0;
	var_01.ignoreme = 0;
	var_01 method_82EF(var_01.origin);
	if(isdefined(self.var_EDCF))
	{
		var_01 method_82F1(level.var_8438[self.var_EDCF]);
	}

	self notify("robot_locker_opened");
	return var_01;
}

//Function Number: 89
func_E59A()
{
	if(!isdefined(self.script_noteworthy))
	{
		return;
	}

	var_00 = 0;
	switch(self.script_noteworthy)
	{
		case "open_full":
			self.var_6B53 delete();
			self.var_6B53 = func_10752();
			var_01 = [self.var_AF1E,self.var_6B53];
			thread lib_0B06::func_1F2C(var_01,"robot_locker_on");
			scripts\common\utility::func_136F7();
			var_02 = 2;
			foreach(var_04 in var_01)
			{
				var_05 = var_04 scripts\sp\_utility::func_7DC1("robot_locker_on");
				var_06 = getanimlength(var_05);
				var_07 = var_02 / var_06;
				var_04 method_82B0(var_05,var_07);
			}
	
			lib_0B06::func_1F27(var_01,"robot_locker_on",0);
			var_00 = 1;
			break;

		case "open_empty":
			self.var_6B53 delete();
			var_01 = [self.var_AF1E];
			thread lib_0B06::func_1F2C(var_01,"robot_locker_on");
			scripts\common\utility::func_136F7();
			lib_0B06::func_1F2A(var_01,"robot_locker_on",0.6);
			lib_0B06::func_1F27(var_01,"robot_locker_on",0);
			var_00 = 1;
			break;
	}

	func_E59B();
	if(var_00)
	{
		foreach(var_0A in self.var_5A2B)
		{
			var_0B = 45;
			if(var_0A.var_EE79 == "left")
			{
				var_0B = var_0B * -1;
			}

			var_0A rotateyaw(var_0B,0.05);
		}
	}
}

//Function Number: 90
func_E59B()
{
	if(isdefined(self.var_5A2B))
	{
		return;
	}

	var_00 = scripts\sp\_utility::func_7A8F();
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03.classname == "script_brushmodel")
		{
			var_01 = scripts\common\utility::array_add(var_01,var_03);
		}
	}

	self.var_5A2B = var_01;
	return self;
}

//Function Number: 91
func_10752(param_00,param_01)
{
	func_1776("lab_robot");
	if(scripts\common\utility::func_4347())
	{
		level.var_E5AD.var_C1 = 999;
		var_02 = level.var_E5AD scripts\sp\_utility::func_10619(1);
	}
	else
	{
		var_03 = randomintrange(0,100);
		if(var_03 <= 80)
		{
			level.var_E5AF.var_C1 = 999;
			var_02 = level.var_E5AF scripts\sp\_utility::func_10619(1);
		}
		else
		{
			level.var_E5AE.var_C1 = 999;
			var_02 = level.var_E5AE scripts\sp\_utility::func_10619(1);
		}
	}

	var_02 scripts\sp\_utility::func_B14F(1);
	var_02 scripts\sp\_utility::func_F2DA(0);
	var_02 scripts\sp\_utility::func_5564();
	if(isdefined(level.var_E5C0))
	{
		var_02 thread [[ level.var_E5C0 ]]();
	}

	var_02.var_1FBB = "robot";
	if(isdefined(param_00))
	{
		var_02 method_82F1(level.var_8438[param_00]);
	}

	if(isdefined(self.var_EDD2))
	{
		var_02.var_162 = self.var_EDD2;
	}

	if(!isdefined(param_01))
	{
		if(isdefined(self.var_ECE7))
		{
			param_01 = self.var_ECE7;
		}
	}

	if(isdefined(param_01))
	{
		if(!isdefined(level.var_1162[param_01]))
		{
			lib_0B77::func_1A12(param_01);
		}

		var_02 thread lib_0B77::func_1A14(level.var_1162[param_01]);
	}

	self notify("spawned");
	return var_02;
}

//Function Number: 92
func_E598()
{
	self waittill("death");
	if(!isdefined(self))
	{
	}
}

//Function Number: 93
func_E5B0()
{
	self endon("entitydeleted");
	scripts\common\utility::waittill_either("death","awaken");
}

//Function Number: 94
func_A78D()
{
	self.ignoreme = 0;
	self.var_180 = 0;
	scripts\sp\_utility::func_6224();
	if(isdefined(self.var_B14F))
	{
		scripts\sp\_utility::func_1101B();
	}
}

//Function Number: 95
func_6473()
{
	var_00 = [level.var_EBBB,level.var_EBBC];
	var_01 = [];
	var_02 = [0,1];
	foreach(var_06, var_04 in var_00)
	{
		var_05 = spawn("script_model",(0,0,0));
		var_05 setmodel("tag_origin");
		var_05 linkto(var_04,"j_Head",(0,0,0),anglestoforward(var_04.angles) + (-180,90,0),1);
		var_01 = scripts\common\utility::array_add(var_01,var_05);
		playfxontag(level._effect["friendly_flashlight"],var_05,"tag_origin");
		wait(var_02[var_06]);
	}
}

//Function Number: 96
func_A796()
{
	var_00 = [level.var_EBBB,level.var_EBBC];
	var_01 = [];
	var_02 = [0,1];
	foreach(var_06, var_04 in var_00)
	{
		var_05 = spawn("script_model",(0,0,0));
		var_05 setmodel("tag_origin");
		var_05 linkto(var_04,"j_Head",(0,0,0),anglestoforward(var_04.angles) + (-180,90,0),1);
		var_01 = scripts\common\utility::array_add(var_01,var_05);
		playfxontag(level._effect["friendly_flashlight"],var_05,"tag_origin");
		wait(var_02[var_06]);
	}

	wait(0.4);
	var_07 = scripts\common\utility::spawn_tag_origin();
	var_07 show();
	var_07 method_81E2(level.player,"tag_flash",(60,0,-5),(0,0,0),1);
	playfxontag(level._effect["player_flashlight"],var_07,"tag_origin");
	level.player thread scripts\sp\_utility::func_CE2F("flashlight_on");
	scripts\common\utility::flag_wait("flashlights_off");
	level.player thread scripts\sp\_utility::func_CE2F("flashlight_off");
	stopfxontag(level._effect["player_flashlight"],var_07,"tag_origin");
	scripts\common\utility::func_136F7();
	var_07 delete();
	foreach(var_09 in var_01)
	{
		var_09 delete();
	}
}

//Function Number: 97
func_6244(param_00)
{
	if(isdefined(param_00) && param_00 == 1)
	{
		if(!isdefined(level.var_EBBB))
		{
			wait(0.05);
		}

		if(!isdefined(level.var_EBBC))
		{
			wait(0.05);
		}
	}

	var_01 = [level.var_EBBB,level.var_EBBC];
	foreach(var_03 in var_01)
	{
		var_03 scripts\sp\_utility::func_61E7(1);
	}
}

//Function Number: 98
func_558F(param_00)
{
	if(isdefined(param_00) && param_00 == 1)
	{
		if(!isdefined(level.var_EBBB))
		{
			wait(0.05);
		}

		if(!isdefined(level.var_EBBC))
		{
			wait(0.05);
		}
	}

	var_01 = [level.var_EBBB,level.var_EBBC];
	foreach(var_03 in var_01)
	{
		var_03 scripts\sp\_utility::func_5514();
	}
}

//Function Number: 99
func_C807(param_00)
{
	level.player scripts\sp\_utility::func_CE2F(param_00);
}

//Function Number: 100
func_133A1()
{
	level.player freezecontrols(1);
	level.player method_80AA();
	level.player allowstand(1);
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player allowjump(0);
	level.player method_8012(0);
}

//Function Number: 101
func_133A2()
{
	level.player freezecontrols(0);
	level.player enableweapons();
	level.player allowstand(1);
	level.player allowcrouch(1);
	level.player allowprone(1);
	level.player allowjump(1);
	level.player method_8012(1);
}

//Function Number: 102
func_10F59(param_00,param_01,param_02)
{
	level endon("stealthtakedownComplete");
	var_03 = spawnstruct();
	if(isdefined(param_02))
	{
		level endon(param_02);
		var_03.var_C6BA = param_02;
	}

	if(!isarray(param_01))
	{
		param_01 = [param_01];
	}

	var_03.var_639D = param_00;
	var_03.var_2E = param_01;
	var_03.var_D435 = undefined;
	var_03.var_7423 = undefined;
	var_03.var_10D8F = 0;
	var_03.var_6CD8 = 0;
	var_03.var_D3C9 = 0;
	level childthread func_10F56(var_03);
	level childthread func_10F57(var_03);
	level childthread func_10F54(var_03);
	scripts\common\utility::array_thread(var_03.var_639D,::func_10F53,var_03);
	level.var_4BC1 = var_03;
	level waittill("stealthtakedownComplete");
}

//Function Number: 103
func_10F57(param_00)
{
	for(;;)
	{
		wait(0.5);
		foreach(var_02 in param_00.var_639D)
		{
			if(!isalive(var_02))
			{
				continue;
			}

			if(isdefined(var_02.var_10E6D))
			{
				if(var_02.var_10E6D.var_10E19 != 0 && !isdefined(param_00.var_D435))
				{
					param_00.var_10D8F = 1;
					if(!param_00.var_D3C9)
					{
						param_00.var_D435 = var_02;
					}

					param_00 thread func_10F58(var_02);
					param_00 notify("cleartoengage");
					return;
				}

				continue;
			}

			if(isdefined(var_02.var_10F49))
			{
				if(isdefined(var_02.var_10F49.var_2521) && var_02.var_10F49.var_2521 && !isdefined(param_00.var_D435))
				{
					param_00.var_10D8F = 1;
					if(!param_00.var_D3C9)
					{
						param_00.var_D435 = var_02;
					}

					param_00 thread func_10F58(var_02);
					param_00 notify("cleartoengage");
					return;
				}
			}
		}
	}
}

//Function Number: 104
func_10F58(param_00)
{
	wait(1);
	if(isalive(param_00))
	{
		self.var_10306 = 1;
	}
}

//Function Number: 105
func_10F52(param_00)
{
	for(;;)
	{
		param_00.var_639D = scripts\sp\_utility::func_22BB(param_00.var_639D);
		if(param_00.var_639D.size < 2)
		{
			return;
		}

		foreach(var_02 in param_00.var_639D)
		{
			if(func_D35D(var_02))
			{
				wait(1);
				if(func_D35D(var_02) && !param_00.var_10D8F)
				{
					thread scripts\sp\_utility::func_16C5("Wolf","Target in sight.");
					return;
				}
			}
		}

		wait(0.5);
	}
}

//Function Number: 106
func_10F53(param_00)
{
	if(isdefined(param_00.var_C6BA))
	{
		self endon(param_00.var_C6BA);
	}

	for(;;)
	{
		self waittill("damage",var_01,var_02);
		param_00.var_10D8F = 1;
		if(!isdefined(param_00.var_D435) && isdefined(var_02) && var_02 == level.player || isdefined(var_02.var_238F) && var_02.var_238F == "seeker")
		{
			param_00.var_D435 = self;
			param_00.var_D3C9 = 1;
			if(isalive(self))
			{
				self method_81D0(self.origin,level.player);
			}
		}

		param_00 notify("cleartoengage");
	}
}

//Function Number: 107
func_10F56(param_00)
{
	param_00 waittill("cleartoengage");
	level notify("stealthtakedown_start");
	wait(0.65);
	var_01 = undefined;
	var_02 = 0;
	var_03 = param_00.var_639D.size;
	var_04 = 0.5;
	var_05 = 2;
	foreach(var_07 in param_00.var_639D)
	{
		var_03--;
		if(param_00.var_D435 == var_07)
		{
			continue;
		}
		else
		{
			if(isdefined(param_00.var_2E[var_02]))
			{
				var_01 = param_00.var_2E[var_02];
			}
			else
			{
				var_01 = param_00.var_2E[0];
			}

			param_00.var_7423 = var_07;
			var_01 func_10F55(param_00.var_7423);
			var_02++;
		}

		var_08 = scripts\common\utility::func_116D7(var_03 == 2,var_05,var_04);
		wait(var_08);
	}

	param_00 notify("friendlies_done_attacking");
}

//Function Number: 108
func_10F55(param_00)
{
	self endon("death");
	var_01 = 5000;
	var_02 = gettime() + var_01;
	while(gettime() < var_02)
	{
		if(scripts\sp\_detonategrenades::func_385C(self geteye(),param_00))
		{
			break;
		}

		wait(0.05);
	}

	if(isalive(param_00))
	{
		magicbullet(self.var_394,self gettagorigin("tag_flash"),param_00 geteye());
	}

	wait(0.25);
	if(isalive(param_00))
	{
		param_00 method_81D0(param_00.origin,self);
	}
}

//Function Number: 109
func_10F54(param_00)
{
	for(;;)
	{
		if(param_00.var_10D8F)
		{
			param_00 waittill("friendlies_done_attacking");
			if(!param_00.var_D3C9)
			{
				param_00.var_10306 = 1;
				scripts\common\utility::random(param_00.var_2E) func_10F55(param_00.var_D435);
				wait(0.5);
				thread func_134B7("europa_sip_stayfocusedwolf");
			}
			else
			{
				wait(0.35);
			}

			param_00.var_6CD8 = 1;
			level notify("stealthtakedownComplete");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 110
func_D35D(param_00)
{
	if(!isalive(param_00))
	{
		return 0;
	}

	if(level.player adsbuttonpressed() && scripts\common\utility::func_13D90(level.player.origin,level.player getplayerangles(),param_00.origin,cos(5)))
	{
		if(scripts\sp\_detonategrenades::func_385C(level.player geteye(),param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 111
func_10F49()
{
	self endon("shutdown_stealthlight");
	self endon("death");
	setdvarifuninitialized("debug_stealthlight",0);
	self.var_10F49 = spawnstruct();
	self.var_10F49.var_2521 = 0;
	self method_8000("gunshot");
	self method_8000("gunshot_teammate");
	self method_8000("bulletwhizby");
	self method_8000("projectile_impact");
	self method_8000("explode");
	self method_8000("silenced_shot");
	function_01C5("ai_eventdistsilencedshot",800);
	self.var_180 = 1;
	childthread func_10F4D();
	childthread func_10F4C();
	childthread func_10F4B();
	self waittill("stealthlight_attack");
	self.var_10F49.var_2521 = 1;
	func_10FC2();
	self.var_180 = 0;
	foreach(var_01 in function_0075("axis","soldier"))
	{
		if(distance(self.origin,var_01.origin) < 800 && !var_01 func_10F4A())
		{
			var_01 thread scripts\sp\_utility::func_C12D("stealthlight_attack",randomfloatrange(0.4,2));
		}
	}

	self method_8260("bulletwhizby");
	self method_8260("explode");
	function_01C5("ai_eventdistsilencedshot",128);
	self notify("shutdown_stealthlight");
}

//Function Number: 112
func_10F4B()
{
	for(;;)
	{
		self waittill("ai_events",var_00);
		if(getdvarint("debug_stealthlight"))
		{
		}

		self notify("stealthlight_attack");
	}
}

//Function Number: 113
func_10F4F()
{
	for(;;)
	{
		self waittill("gunshot");
		if(getdvarint("debug_stealthlight"))
		{
		}

		self notify("stealthlight_attack");
	}
}

//Function Number: 114
func_10F4E()
{
	for(;;)
	{
		self waittill("explode");
		if(getdvarint("debug_stealthlight"))
		{
		}

		self notify("stealthlight_attack");
	}
}

//Function Number: 115
func_10F4D()
{
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(isdefined(var_01) && var_01 == level.player)
		{
			if(getdvarint("debug_stealthlight"))
			{
			}

			self notify("stealthlight_attack");
		}
	}
}

//Function Number: 116
func_10F4C()
{
	var_00 = 400;
	for(;;)
	{
		if(distancesquared(self.origin,level.player.origin) < var_00 * var_00)
		{
			if(self method_805F(level.player))
			{
				if(getdvarint("debug_stealthlight"))
				{
				}

				self notify("stealthlight_attack");
			}
		}

		wait(1);
	}
}

//Function Number: 117
func_10F50()
{
	for(;;)
	{
		self waittill("bulletwhizby");
		if(getdvarint("debug_stealthlight"))
		{
		}

		self notify("stealthlight_attack");
	}
}

//Function Number: 118
func_10F4A()
{
	if(isdefined(self.var_10F49) && self.var_10F49.var_2521)
	{
		return 1;
	}

	return 0;
}

//Function Number: 119
func_1108E()
{
	self method_8260("bulletwhizby");
	self method_8260("explode");
	self notify("shutdown_stealthlight");
	self.var_180 = 0;
}

//Function Number: 120
func_D988(param_00)
{
	if(isdefined(level.var_116B1))
	{
		return;
	}

	var_01 = lib_0B4D::func_6A8E(-298,-376,param_00);
	level.player setclientomnvar("ui_helmet_meter_temperature",int(var_01));
}

//Function Number: 121
func_982F(param_00)
{
	level.var_116B1 = 1;
	var_01 = gettime() + param_00 * 1000;
	var_02 = -297;
	while(gettime() < var_01)
	{
		level.player setclientomnvar("ui_helmet_meter_temperature",int(var_02));
		var_02 = var_02 - 1;
		wait(1.5);
	}

	level.var_116B1 = undefined;
}

//Function Number: 122
func_12992()
{
	if(isdefined(level.var_11695) && level.var_11695)
	{
		return;
	}

	level.player setclientomnvar("ui_show_temperature_gauge",1);
	level.var_11695 = 1;
	level.player playsound("ui_europa_temperature_warning");
}

//Function Number: 123
func_12970()
{
	if(isdefined(level.var_11695) && !level.var_11695)
	{
		return;
	}

	level.player setclientomnvar("ui_show_temperature_gauge",0);
	level.var_11695 = 0;
}

//Function Number: 124
func_5F32(param_00)
{
	var_01 = spawnstruct();
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	return var_01;
}

//Function Number: 125
func_203B(param_00)
{
	foreach(var_02 in param_00)
	{
		if(scripts\common\utility::flag(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 126
func_117FF(param_00)
{
	var_01 = level.player getweaponslist("primary");
	if(var_01.size > 1)
	{
		var_02 = level.player getcurrentprimaryweapon();
		foreach(var_04 in var_01)
		{
			if(var_02 != var_04)
			{
				level.player takeweapon(var_04);
				func_11801(var_04,param_00);
				break;
			}
		}
	}
}

//Function Number: 127
func_11801(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = level.player geteye();
	}

	if(!isdefined(param_01))
	{
		param_01 = 500;
	}

	var_03 = anglestoforward(level.player getplayerangles());
	var_04 = param_02 + (0,0,-10) + var_03 * 16;
	var_05 = spawn("weapon_" + param_00,var_04);
	var_03 = anglestoforward(level.player getplayerangles() + (-20,0,0));
	var_06 = var_03 * param_01;
	var_05 physicslaunchserveritem(var_05.origin,var_06);
}

//Function Number: 128
func_BE3C(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	self endon("stop_nag_thread");
	if(!isdefined(param_02))
	{
		param_02 = 3;
	}

	if(!isdefined(param_03))
	{
		param_03 = 5;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	var_05 = 2;
	if(!isarray(param_01))
	{
		param_01 = [param_01];
	}

	wait(3);
	var_06 = 0;
	var_07 = 0;
	if(isarray(param_00[0]))
	{
		if(function_02A6(param_00[0][0]))
		{
			var_07 = 1;
			var_08 = param_00[0][1];
		}
		else
		{
			var_07 = 1;
			var_08 = param_01[0][1];
		}
	}
	else
	{
		var_08 = "";
	}

	for(;;)
	{
		if(func_203B(param_01))
		{
			break;
		}

		param_00 = scripts\common\utility::array_randomize(param_00);
		if(var_06 || var_07)
		{
			if(param_00.size > 1)
			{
				while(param_00[0][1] == var_08)
				{
					param_00 = scripts\common\utility::array_randomize(param_00);
					wait(0.05);
				}
			}
		}
		else if(param_00.size > 1)
		{
			while(param_00[0] == var_08)
			{
				param_00 = scripts\common\utility::array_randomize(param_00);
				wait(0.05);
			}
		}

		foreach(var_0A in param_00)
		{
			if(var_06)
			{
				thread scripts\sp\_utility::func_16C5(var_0A[0],var_0A[1]);
				var_08 = var_0A[1];
			}
			else if(var_07)
			{
				var_0A[0] scripts\sp\_utility::func_10346(var_0A[1]);
				var_08 = var_0A[1];
			}
			else
			{
				scripts\sp\_utility::func_10346(var_0A);
				var_08 = var_0A;
			}

			wait(randomfloatrange(param_02,param_03));
			if(param_04)
			{
				var_05 = var_05 + 3;
				param_02 = min(param_02 + var_05,20);
				param_03 = min(param_03 + var_05,30);
			}
			else
			{
				param_02 = min(param_02,20);
				param_03 = min(param_03,30);
			}

			if(func_203B(param_01))
			{
				break;
			}
		}
	}
}

//Function Number: 129
func_6F30()
{
	func_95E7();
	var_00 = scripts\common\utility::getstructarray("fling_object","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread func_6F2E();
	}
}

//Function Number: 130
func_95E7(param_00)
{
	level.var_6F2F = [];
	level.var_6F2F[level.var_6F2F.size] = "blackice_coupler_gray";
	level.var_6F2F[level.var_6F2F.size] = "boots_civ_miner_burnt_01_left";
	level.var_6F2F[level.var_6F2F.size] = "boots_civ_miner_burnt_01_right";
	level.var_6F2F[level.var_6F2F.size] = "clk_lab_compoundanalyzer_01_device03";
	level.var_6F2F[level.var_6F2F.size] = "cnd_laptop_001_open_off";
	level.var_6F2F[level.var_6F2F.size] = "com_extinguisher_wallmount";
	level.var_6F2F[level.var_6F2F.size] = "com_office_book_red_flat";
	level.var_6F2F[level.var_6F2F.size] = "com_studiolight_hanging_off";
	level.var_6F2F[level.var_6F2F.size] = "conduit_metal_outlet_box_cover";
	level.var_6F2F[level.var_6F2F.size] = "conduit_metal_outlet_plug_b";
	level.var_6F2F[level.var_6F2F.size] = "conduit_metal_outlet_plug_e";
	level.var_6F2F[level.var_6F2F.size] = "conduit_metal_outlet_plug_g2";
	level.var_6F2F[level.var_6F2F.size] = "consumer_grade_pc_opened";
	level.var_6F2F[level.var_6F2F.size] = "consumer_grade_pc_tower";
	level.var_6F2F[level.var_6F2F.size] = "container_ammo_box_01";
	level.var_6F2F[level.var_6F2F.size] = "ctl_biometric_lock";
	level.var_6F2F[level.var_6F2F.size] = "cup_paper_open_iw6";
	level.var_6F2F[level.var_6F2F.size] = "emergency_stop_box_01";
	level.var_6F2F[level.var_6F2F.size] = "equipment_aid_oxygen_tank_01";
	level.var_6F2F[level.var_6F2F.size] = "equipment_computer_screen_01_arm";
	level.var_6F2F[level.var_6F2F.size] = "equipment_field_computer_01";
	level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_access_keypad_01";
	level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_hand_clamp_01";
	level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_pliers_01";
	level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_power_drill_01";
	level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_rivet_tool_01";
	level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_screwdriver_02";
	level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_toolbox_01";
	level.var_6F2F[level.var_6F2F.size] = "equipment_industrial_wrench_01";
	level.var_6F2F[level.var_6F2F.size] = "equipment_memory_chip_01";
	level.var_6F2F[level.var_6F2F.size] = "equipment_wall_mounted_phone_01_white";
	level.var_6F2F[level.var_6F2F.size] = "equipment_wall_mounted_phone_01_yellow";
	level.var_6F2F[level.var_6F2F.size] = "fac_keyboard";
	level.var_6F2F[level.var_6F2F.size] = "fire_extinguisher_digital";
	level.var_6F2F[level.var_6F2F.size] = "furniture_exam_stool_01";
	level.var_6F2F[level.var_6F2F.size] = "hjk_clipboard_wpaper";
	level.var_6F2F[level.var_6F2F.size] = "hjk_plane_debris_cable_sml_2";
	level.var_6F2F[level.var_6F2F.size] = "ind_pipe_metal_hp_4_coupling";
	level.var_6F2F[level.var_6F2F.size] = "ind_railing_01_32_d";
	level.var_6F2F[level.var_6F2F.size] = "industrial_conduit_metal_1_body_bend_elbow_white";
	level.var_6F2F[level.var_6F2F.size] = "industrial_conduit_metal_1_body_end_white";
	level.var_6F2F[level.var_6F2F.size] = "industrial_conduit_metal_1_body_joint_c_white";
	level.var_6F2F[level.var_6F2F.size] = "industrial_conduit_metal_1_coupling_screw";
	level.var_6F2F[level.var_6F2F.size] = "industrial_conduit_metal_1_coupling_screw_white";
	level.var_6F2F[level.var_6F2F.size] = "lab_microscope";
	level.var_6F2F[level.var_6F2F.size] = "light_ceiling_corridor_01";
	level.var_6F2F[level.var_6F2F.size] = "loki_wif_socket";
	level.var_6F2F[level.var_6F2F.size] = "misc_duffelbag_03";
	level.var_6F2F[level.var_6F2F.size] = "misc_interior_multi_tool_01";
	level.var_6F2F[level.var_6F2F.size] = "misc_operations_manual_black";
	level.var_6F2F[level.var_6F2F.size] = "misc_operations_manual_blue";
	level.var_6F2F[level.var_6F2F.size] = "misc_operations_manual_red";
	level.var_6F2F[level.var_6F2F.size] = "mp_weapon_crate";
	level.var_6F2F[level.var_6F2F.size] = "office_paper_piece01_iw6";
	level.var_6F2F[level.var_6F2F.size] = "p7_chain_metal_str_64_hook";
	level.var_6F2F[level.var_6F2F.size] = "p7_desk_metal_military_03_tablet";
	level.var_6F2F[level.var_6F2F.size] = "portable_battery_pack_01";
	level.var_6F2F[level.var_6F2F.size] = "sign_ind_misc_03";
	level.var_6F2F[level.var_6F2F.size] = "sign_ind_misc_12";
	level.var_6F2F[level.var_6F2F.size] = "space_aid_supplybag_01";
	level.var_6F2F[level.var_6F2F.size] = "space_bracket_01_metal_painted";
	level.var_6F2F[level.var_6F2F.size] = "space_interior_handle_med_blue";
	level.var_6F2F[level.var_6F2F.size] = "space_interior_pack_square";
	level.var_6F2F[level.var_6F2F.size] = "tank_nitrogen_01_green";
	level.var_6F2F[level.var_6F2F.size] = "tank_nitrogen_01_orange";
	level.var_6F2F[level.var_6F2F.size] = "tank_nitrogen_01_white";
	if(isdefined(param_00))
	{
		foreach(var_02 in level.var_6F2F)
		{
			precachemodel(var_02);
		}

		level.var_6F2F = undefined;
	}
}

//Function Number: 131
func_6F2E()
{
	var_00 = 200;
	var_01 = [];
	for(var_02 = self;isdefined(var_02.target);var_02 = var_03)
	{
		var_01[var_01.size] = var_02;
		var_03 = scripts\common\utility::getstruct(var_02.target,"targetname");
		var_02.var_2B3 = 300;
	}

	self.var_C94F = func_4AF3(var_01,1);
	self.var_C96D = self.var_C94F.var_F18B[self.var_C94F.var_F18B.size - 1].var_630D;
	var_04 = 2000;
	for(;;)
	{
		thread func_6F31(var_04);
		wait(randomfloatrange(0.2,1));
	}
}

//Function Number: 132
func_6F31(param_00)
{
	var_01 = spawn("script_model",self.origin);
	var_01 setmodel(level.var_6F2F[randomint(level.var_6F2F.size)]);
	var_01 notsolid();
	var_02 = randomintrange(300,500);
	var_03 = randomintrange(-30,30);
	var_04 = randomintrange(-50,50);
	var_01 rotatevelocity((var_02,var_03,var_04),100);
	var_05 = 0;
	var_06 = 50;
	param_00 = param_00 * 0.05;
	while(var_05 < self.var_C96D)
	{
		var_05 = var_05 + param_00;
		var_07 = func_4AEA(self.var_C94F,var_05);
		var_01.origin = var_07["pos"];
		wait(0.05);
	}

	var_01 delete();
}

//Function Number: 133
func_6F2C()
{
	self endon("death");
	var_00 = 100;
	for(;;)
	{
		var_01 = self.var_C94F.var_F18B[self.var_C94F.var_F18B.size - 1].var_630D;
		var_02 = func_4AEA(self.var_C94F,0);
		var_03 = var_02["pos"];
		var_04 = 0;
		while(var_04 < var_01)
		{
			var_04 = var_04 + var_00;
			var_02 = func_4AEA(self.var_C94F,var_04);
			var_03 = var_02["pos"];
		}

		wait(0.05);
	}
}

//Function Number: 134
func_AC90(param_00,param_01)
{
	var_02 = int(param_01 * 20);
	var_03 = self method_8134();
	var_04 = param_00 - var_03 / var_02;
	for(var_05 = 0;var_05 < var_02;var_05++)
	{
		thread func_AC91(param_00);
		self setlightintensity(var_03 + var_05 * var_04);
		wait(0.05);
	}

	var_06[0] = self;
	if(isdefined(self.var_AD22))
	{
		var_06 = scripts\common\utility::array_combine(var_06,self.var_AD22);
	}

	foreach(var_08 in var_06)
	{
		var_08 thread func_AC91(param_00);
		var_08 setlightintensity(param_00);
	}
}

//Function Number: 135
func_AC91(param_00)
{
	if(!isdefined(self.var_EEE3))
	{
		return;
	}

	var_01 = param_00 > self.var_EEE3;
	foreach(var_03 in self.var_AD83)
	{
		if(var_01 && !var_03.var_13438)
		{
			var_03.var_13438 = var_01;
			var_03 show();
			if(isdefined(var_03.var_5FDF))
			{
				var_03.var_5FDF thread scripts\sp\_utility::func_E2B0();
			}

			continue;
		}

		if(!var_01 && var_03.var_13438)
		{
			var_03.var_13438 = var_01;
			var_03 hide();
			if(isdefined(var_03.var_5FDF))
			{
				var_03.var_5FDF thread scripts\common\utility::func_C9CF();
			}
		}
	}

	foreach(var_03 in self.var_12BB6)
	{
		if(!var_01 && !var_03.var_13438)
		{
			var_03.var_13438 = 1;
			var_03 show();
			continue;
		}

		if(var_01 && var_03.var_13438)
		{
			var_03.var_13438 = 0;
			var_03 hide();
		}
	}
}

//Function Number: 136
func_AC87(param_00)
{
	func_AC90(param_00,0.5);
}

//Function Number: 137
func_AC86()
{
	func_AC90(0,0.5);
}

//Function Number: 138
func_EF3F(param_00,param_01,param_02,param_03)
{
	foreach(var_05 in param_00)
	{
		if(!isdefined(var_05.var_9BB1))
		{
			if(var_05 method_8551(param_01) == param_02)
			{
				var_05 setscriptablepartstate(param_01,param_03);
			}
		}
	}
}

//Function Number: 139
func_4AF3(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05.var_F18B = [];
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	var_06 = 0;
	var_07 = [];
	var_08 = distance(param_00[0].origin,param_00[1].origin);
	while(isdefined(param_00[var_05.var_F18B.size + 2]))
	{
		var_09 = var_05.var_F18B.size;
		var_0A = param_00[var_09].origin;
		var_0B = param_00[var_09 + 1].origin;
		var_0C = param_00[var_09 + 2].origin;
		var_0D = var_08;
		var_08 = distance(param_00[var_09 + 1].origin,param_00[var_09 + 2].origin);
		var_0E = var_07;
		var_07 = func_4AE5(var_0A,var_0C,var_0D,var_08,0.5);
		if(var_09 == 0)
		{
			if(isdefined(param_02))
			{
				var_0E["outgoing"] = param_02 * var_0D;
			}
			else
			{
				var_0E = func_4AE6(var_0A,var_0B,var_07["incoming"]);
			}
		}

		if(param_04)
		{
			var_05.var_F18B[var_09] = func_4AFC(var_0A,var_0B,var_0E["outgoing"],var_07["incoming"],var_0D);
			var_06 = var_06 + var_05.var_F18B[var_09].var_630D;
			continue;
		}

		var_05.var_F18B[var_09] = func_4AFB(var_0A,var_0B,var_0E["outgoing"],var_07["incoming"]);
		var_06 = var_06 + var_0D;
		var_05.var_F18B[var_09].var_630D = var_06;
	}

	var_09 = var_05.var_F18B.size;
	var_0A = param_00[var_09].origin;
	var_0B = param_00[var_09 + 1].origin;
	var_0D = var_08;
	var_0E = var_07;
	if(var_09 == 0 && isdefined(param_02))
	{
		var_0E["outgoing"] = param_02 * var_0D;
	}

	if(isdefined(param_03))
	{
		var_07["incoming"] = param_03 * var_0D;
	}
	else
	{
		var_07 = func_4AE6(var_0A,var_0B,var_0E["outgoing"]);
	}

	if(var_09 == 0 && !isdefined(param_02))
	{
		var_0E = func_4AE6(var_0A,var_0B,var_07["incoming"]);
	}

	if(param_04)
	{
		var_05.var_F18B[var_09] = func_4AFC(var_0A,var_0B,var_0E["outgoing"],var_07["incoming"],var_0D);
		var_06 = var_06 + var_05.var_F18B[var_09].var_630D;
	}
	else
	{
		var_05.var_F18B[var_09] = func_4AFB(var_0A,var_0B,var_0E["outgoing"],var_07["incoming"]);
		var_06 = var_06 + var_0D;
	}

	var_05.var_F18B[var_09].var_630D = var_06;
	if(param_01)
	{
		var_0F = 0;
		var_10 = 0;
		for(var_09 = 0;var_09 < var_05.var_F18B.size;var_09++)
		{
			if(!isdefined(param_00[var_09 + 1].var_2B3))
			{
				param_00[var_09 + 1].var_2B3 = param_00[var_09].var_2B3;
			}

			var_0D = var_05.var_F18B[var_09].var_630D - var_10;
			var_11 = 2 * var_0D / param_00[var_09].var_2B3 + param_00[var_09 + 1].var_2B3 / 20;
			var_0F = var_0F + var_11;
			var_05.var_F18B[var_09].var_6393 = var_0F;
			var_10 = var_05.var_F18B[var_09].var_630D;
			var_05.var_F18B[var_09].var_109B1 = param_00[var_09].var_2B3 / 20;
			var_05.var_F18B[var_09].var_109A8 = param_00[var_09 + 1].var_2B3 / 20;
		}
	}
	else
	{
		for(var_09 = 0;var_09 < var_05.var_F18B.size;var_09++)
		{
			var_05.var_F18B[var_09].var_6393 = var_05.var_F18B[var_09].var_630D;
			var_05.var_F18B[var_09].var_109B1 = 1;
			var_05.var_F18B[var_09].var_109A8 = 1;
		}
	}

	return var_05;
}

//Function Number: 140
func_4AE5(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_06 = [];
	for(var_07 = 0;var_07 < 3;var_07++)
	{
		var_05[var_07] = 1 - param_04 * param_01[var_07] - param_00[var_07];
		var_06[var_07] = var_05[var_07];
		var_05[var_07] = var_05[var_07] * 2 * param_02 / param_02 + param_03;
		var_06[var_07] = var_06[var_07] * 2 * param_03 / param_02 + param_03;
	}

	var_08 = [];
	var_08["incoming"] = (var_05[0],var_05[1],var_05[2]);
	var_08["outgoing"] = (var_06[0],var_06[1],var_06[2]);
	return var_08;
}

//Function Number: 141
func_4AE6(param_00,param_01,param_02)
{
	var_03 = 3;
	var_04 = [];
	var_05 = [];
	if(isdefined(param_02))
	{
		for(var_06 = 0;var_06 < var_03;var_06++)
		{
			var_04[var_06] = -3 * param_00[var_06] + 3 * param_01[var_06] - param_02[var_06] / 2;
			var_05[var_06] = var_04[var_06];
		}
	}
	else
	{
		for(var_06 = 0;var_06 < var_03;var_06++)
		{
			var_04[var_06] = param_01[var_06] - param_00[var_06];
			var_05[var_06] = param_01[var_06] - param_00[var_06];
		}
	}

	var_07 = [];
	var_07["incoming"] = (var_04[0],var_04[1],var_04[2]);
	var_07["outgoing"] = (var_05[0],var_05[1],var_05[2]);
	return var_07;
}

//Function Number: 142
func_4AFB(param_00,param_01,param_02,param_03)
{
	var_04 = 3;
	var_05 = spawnstruct();
	var_05.var_BE20 = [];
	var_05.var_BE1F = [];
	var_05.var_BE21 = [];
	var_05.var_365F = [];
	for(var_06 = 0;var_06 < var_04;var_06++)
	{
		var_05.var_BE20[var_06] = 2 * param_00[var_06] - 2 * param_01[var_06] + param_02[var_06] + param_03[var_06];
		var_05.var_BE1F[var_06] = -3 * param_00[var_06] + 3 * param_01[var_06] - 2 * param_02[var_06] - param_03[var_06];
		var_05.var_BE21[var_06] = param_02[var_06];
		var_05.var_365F[var_06] = param_00[var_06];
	}

	return var_05;
}

//Function Number: 143
func_4AFC(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_4AFB(param_00,param_01,param_02,param_03);
	var_06 = func_4AFE(var_05,param_04);
	if(var_06 > 1)
	{
		param_04 = param_04 * var_06;
		param_02 = param_02 / var_06;
		param_03 = param_03 / var_06;
		var_05 = func_4AFB(param_00,param_01,param_02,param_03);
	}

	var_05.var_630D = param_04;
	return var_05;
}

//Function Number: 144
func_4AFE(param_00,param_01)
{
	var_02 = func_4AFF(param_00,param_01);
	return var_02;
}

//Function Number: 145
func_4AFF(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	for(var_08 = 0;var_08 < 3;var_08++)
	{
		var_02 = var_02 + param_00.var_BE20[var_08] * param_00.var_BE20[var_08];
		var_03 = var_03 + param_00.var_BE20[var_08] * param_00.var_BE1F[var_08];
		var_04 = var_04 + param_00.var_BE20[var_08] * param_00.var_BE21[var_08];
		var_05 = var_05 + param_00.var_BE1F[var_08] * param_00.var_BE1F[var_08];
		var_06 = var_06 + param_00.var_BE1F[var_08] * param_00.var_BE21[var_08];
		var_07 = var_07 + param_00.var_BE21[var_08] * param_00.var_BE21[var_08];
	}

	var_09 = 36 * var_02;
	var_0A = 36 * var_03;
	var_0B = 12 * var_04 + 8 * var_05;
	var_0C = 4 * var_06;
	var_0D = [];
	var_0D[0] = 0;
	if(var_09 == 0)
	{
		if(var_0A == 0 && var_0B == 0 && var_0C == 0)
		{
			return sqrt(var_07) / param_01;
		}

		var_0E = func_E6EB(var_0A,var_0B,var_0C);
		if(isdefined(var_0E[0]) && var_0E[0] > 0 && var_0E[0] < 1)
		{
			var_0F = 2 * var_0A * var_0E[0] + var_0B;
			if(var_0F < 0)
			{
				var_0D[var_0D.size] = var_0E[0];
			}
		}

		if(isdefined(var_0E[1]) && var_0E[1] > 0 && var_0E[1] < 1)
		{
			var_0F = 2 * var_0A * var_0E[0] + var_0B;
			if(var_0F < 0)
			{
				var_0D[var_0D.size] = var_0E[1];
			}
		}
	}
	else
	{
		var_10 = func_E6EB(3 * var_09,2 * var_0A,var_0B);
		var_11 = 0;
		var_12[0] = 0;
		for(var_11 = 0;var_11 < var_10.size;var_11++)
		{
			if(var_10[var_11] > 0 && var_10[var_11] < 1)
			{
				var_12[var_12.size] = var_10[var_11];
			}
		}

		var_12[var_12.size] = 1;
		for(var_11 = 1;var_11 < var_12.size;var_11++)
		{
			var_13 = var_12[var_11 - 1];
			var_14 = var_12[var_11];
			var_15 = var_09 * var_13 * var_13 * var_13 + var_0A * var_13 * var_13 + var_0B * var_13 + var_0C;
			var_16 = var_09 * var_14 * var_14 * var_14 + var_0A * var_14 * var_14 + var_0B * var_14 + var_0C;
			if(var_15 > 0 && var_16 < 0)
			{
				var_0D[var_0D.size] = func_BF2D(var_13,var_14,var_09,var_0A,var_0B,var_0C,0.02);
			}
		}
	}

	var_0D[var_0D.size] = 1;
	var_09 = 9 * var_02;
	var_0A = 12 * var_03;
	var_0B = 6 * var_04 + 4 * var_05;
	var_0C = 4 * var_06;
	var_17 = var_07;
	var_18 = 0;
	foreach(var_1A in var_0D)
	{
		var_1B = var_09 * var_1A * var_1A * var_1A * var_1A + var_0A * var_1A * var_1A * var_1A + var_0B * var_1A * var_1A + var_0C * var_1A + var_17;
		if(var_1B > var_18)
		{
			var_18 = var_1B;
		}
	}

	return sqrt(var_18) / param_01;
}

//Function Number: 146
func_4AEA(param_00,param_01,param_02)
{
	if(param_01 <= 0)
	{
		var_03 = param_00.var_F18B[0].var_630D;
		var_04 = func_4B02(param_00.var_F18B[0],0,var_03,param_00.var_F18B[0].var_109B1);
		return var_04;
	}

	if(var_03 >= param_02.var_F18B[param_02.var_F18B.size - 1].var_630D)
	{
		if(param_02.var_F18B.size > 1)
		{
			var_03 = param_02.var_F18B[param_02.var_F18B.size - 1].var_630D - param_02.var_F18B[param_02.var_F18B.size - 2].var_630D;
		}
		else
		{
			var_03 = param_02.var_F18B[param_02.var_F18B.size - 1].var_630D;
		}

		var_04 = func_4B02(param_01.var_F18B[param_01.var_F18B.size - 1],1,var_04,param_01.var_F18B[param_01.var_F18B.size - 1].var_109A8);
		return var_04;
	}

	for(var_05 = 0;param_02.var_F18B[var_05].var_630D < var_03;var_05++)
	{
	}

	if(var_05 > 0)
	{
		var_06 = param_02.var_F18B[var_05 - 1].var_630D;
	}
	else
	{
		var_06 = 0;
	}

	var_03 = param_02.var_F18B[var_05].var_630D - var_06;
	var_07 = param_02 - var_05 / var_06;
	var_08 = undefined;
	if(isdefined(var_03) && var_03)
	{
		var_08 = func_4AF7(param_01.var_F18B[var_04].var_109B1,param_01.var_F18B[var_04].var_109A8,var_07);
	}

	var_04 = func_4B02(param_01.var_F18B[var_04],var_07,var_06,var_08);
	return var_08;
}

//Function Number: 147
func_4AF7(param_00,param_01,param_02)
{
	var_03 = param_02;
	var_04 = param_01 - param_00 * param_01 + param_00 / 2;
	return sqrt(2 * var_04 * var_03 + param_00 * param_00);
}

//Function Number: 148
func_4B02(param_00,param_01,param_02,param_03)
{
	var_04 = 3;
	var_05 = [];
	var_06 = [];
	var_07 = [];
	var_08 = [];
	for(var_09 = 0;var_09 < var_04;var_09++)
	{
		var_05[var_09] = param_00.var_BE20[var_09] * param_01 * param_01 * param_01 + param_00.var_BE1F[var_09] * param_01 * param_01 + param_00.var_BE21[var_09] * param_01 + param_00.var_365F[var_09];
		var_06[var_09] = 3 * param_00.var_BE20[var_09] * param_01 * param_01 + 2 * param_00.var_BE1F[var_09] * param_01 + param_00.var_BE21[var_09];
		var_07[var_09] = 6 * param_00.var_BE20[var_09] * param_01 + 2 * param_00.var_BE1F[var_09];
	}

	var_08["pos"] = (var_05[0],var_05[1],var_05[2]);
	var_08["vel"] = (var_06[0],var_06[1],var_06[2]);
	var_08["acc"] = (var_07[0],var_07[1],var_07[2]);
	if(isdefined(param_02))
	{
		var_08["vel"] = var_08["vel"] / param_02;
		var_08["acc"] = var_08["acc"] / param_02 * param_02;
	}

	if(isdefined(param_03))
	{
		var_08["vel"] = var_08["vel"] * param_03;
		var_08["acc"] = var_08["acc"] * param_03 * param_03;
	}

	var_08["speed"] = param_03;
	return var_08;
}

//Function Number: 149
func_BF2D(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = 5;
	var_08 = param_00 + param_01 / 2;
	var_09 = param_06 + 1;
	while(abs(var_09) > param_06 && var_07 > 0)
	{
		var_0A = param_02 * var_08 * var_08 * var_08 + param_03 * var_08 * var_08 + param_04 * var_08 + param_05;
		var_0B = 3 * param_02 * var_08 * var_08 + 2 * param_03 * var_08 + param_04;
		var_09 = -1 * var_0A / var_0B;
		var_0C = var_08;
		var_08 = var_08 + var_09;
		if(var_08 > param_01)
		{
			var_08 = var_0C + 3 * param_01 / 4;
			continue;
		}

		if(var_08 < param_00)
		{
			var_08 = var_0C + 3 * param_00 / 4;
		}

		var_07--;
	}

	return var_08;
}

//Function Number: 150
func_E6EB(param_00,param_01,param_02)
{
	while(abs(param_00) > 65536 || abs(param_01) > 65536 || abs(param_02) > 65536)
	{
		param_00 = param_00 / 10;
		param_01 = param_01 / 10;
		param_02 = param_02 / 10;
	}

	var_03 = [];
	if(param_00 == 0)
	{
		if(param_01 != 0)
		{
			var_03[0] = -1 * param_02 / param_01;
		}
	}
	else
	{
		var_04 = param_01 * param_01 - 4 * param_00 * param_02;
		if(var_04 > 0)
		{
			var_03[0] = -1 * param_01 - sqrt(var_04) / 2 * param_00;
			var_03[1] = -1 * param_01 + sqrt(var_04) / 2 * param_00;
		}
		else if(var_04 == 0)
		{
			var_03[0] = -1 * param_01 / 2 * param_00;
		}
	}

	return var_03;
}

//Function Number: 151
func_67B6(param_00,param_01,param_02,param_03)
{
	function_014E(param_00,param_01);
	function_0164(param_00,param_02);
	if(!isdefined(param_03))
	{
		return;
	}

	scripts\common\utility::flag_wait(param_03);
	function_0162(param_00,"done");
}