/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\crafted_trap_hypnosis.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 1357 ms
 * Timestamp: 10/27/2023 12:10:21 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["boombox_explode"] = loadfx("vfx/iw7/_requests/coop/vfx_ghetto_blast.vfx");
	var_00 = spawnstruct();
	var_00.var_11901 = 18;
	var_00.var_B924 = "cp_town_hypnosis_device_good";
	var_00.var_B925 = "cp_town_hypnosis_device_bad";
	var_00.var_CC12 = "cp_town_hypnosis_device";
	var_00.var_CC28 = &"COOP_CRAFTABLES_PLACE";
	var_00.var_38E3 = &"COOP_CRAFTABLES_CANNOT_PLACE";
	var_00.var_CC0A = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
	var_00.var_CC22 = 30;
	var_00.var_CC25 = 16;
	var_00.var_3AA7 = (0,0,35);
	var_00.var_3AA6 = (0,-90,0);
	level.crafted_hypnosis_settings = [];
	level.crafted_hypnosis_settings["crafted_hypnosis"] = var_00;
}

//Function Number: 2
give_crafted_hypnosis(param_00,param_01)
{
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_hypnosis");
	param_01 setclientomnvar("zom_crafted_weapon",14);
	scripts\cp\_utility::func_F313("crafted_hypnosis",::give_crafted_hypnosis,param_01);
}

//Function Number: 3
func_13932()
{
	self endon("disconnect");
	self endon("death");
	self notify("craft_dpad_watcher");
	self endon("craft_dpad_watcher");
	self notifyonplayercommand("pullout_hypnosis","+actionslot 3");
	for(;;)
	{
		self waittill("pullout_hypnosis");
		if(scripts\common\utility::istrue(self.var_9D81))
		{
			continue;
		}

		if(scripts\common\utility::istrue(self.var_AD2C))
		{
			continue;
		}

		if(isdefined(self.allow_carry) && self.allow_carry == 0)
		{
			continue;
		}

		if(scripts\cp\_utility::is_valid_player())
		{
			break;
		}
	}

	thread give_hypnosis(1);
}

//Function Number: 4
give_hypnosis(param_00,param_01)
{
	self endon("disconnect");
	scripts\cp\_utility::clearlowermessage("msg_power_hint");
	var_02 = createhypnosisforplayer(self);
	self.var_A039 = var_02.name;
	func_E152();
	var_02 = createhypnosisforplayer(self);
	self.var_3AA5 = var_02;
	var_02.var_6DEC = 1;
	var_03 = setcarryinghypnosis(var_02,param_00,param_01);
	self.var_3AA5 = undefined;
	thread func_1370F();
	self.var_9D81 = 0;
	if(isdefined(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
setcarryinghypnosis(param_00,param_01,param_02)
{
	self endon("disconnect");
	param_00 hypnosis_setcarried(self,param_01);
	scripts\common\utility::allow_weapon(0);
	self notifyonplayercommand("place_hypnosis","+attack");
	self notifyonplayercommand("place_hypnosis","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_hypnosis","+actionslot 3");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_hypnosis","+actionslot 5");
		self notifyonplayercommand("cancel_hypnosis","+actionslot 6");
		self notifyonplayercommand("cancel_hypnosis","+actionslot 7");
	}

	for(;;)
	{
		var_03 = scripts\common\utility::func_13734("place_hypnosis","cancel_hypnosis","force_cancel_placement");
		if(!isdefined(param_00))
		{
			scripts\common\utility::allow_weapon(1);
			return 1;
		}

		if(!isdefined(var_03))
		{
			var_03 = "force_cancel_placement";
		}

		if(var_03 == "cancel_hypnosis" || var_03 == "force_cancel_placement")
		{
			if(!param_01 && var_03 == "cancel_hypnosis")
			{
				continue;
			}

			scripts\common\utility::allow_weapon(1);
			param_00 hypnosis_setcancelled();
			if(var_03 != "force_cancel_placement")
			{
				thread func_13932();
			}
			else if(param_01)
			{
				scripts\cp\_utility::func_DFE0(self);
			}

			return 0;
		}

		if(!param_00.var_3872)
		{
			continue;
		}

		if(param_01)
		{
			scripts\cp\_utility::func_DFE0(self);
		}

		param_00 hypnosis_setplaced(param_02,self);
		scripts\common\utility::allow_weapon(1);
		return 1;
	}
}

//Function Number: 6
func_E18E()
{
	if(self.var_8C1E)
	{
		var_00 = scripts\cp\_utility::func_E55C();
		self.var_E2E6 = var_00;
		self.var_E556 = self method_80FB(var_00);
		self takeweapon(var_00);
	}
}

//Function Number: 7
func_E152()
{
	if(scripts\cp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.var_E2DF = "specialty_explosivebullets";
		scripts\cp\_utility::func_1430("specialty_explosivebullets");
	}
}

//Function Number: 8
func_E2E8()
{
	if(isdefined(self.var_E2E6))
	{
		scripts\cp\_utility::func_12C6(self.var_E2E6);
		if(self.var_8C1E)
		{
			var_00 = scripts\cp\_utility::func_E55C();
			self setweaponammoclip(var_00,self.var_E556);
		}
	}

	self.var_E2E6 = undefined;
}

//Function Number: 9
func_E2E0()
{
	if(isdefined(self.var_E2DF))
	{
		scripts\cp\_utility::func_8387(self.var_E2DF);
		self.var_E2DF = undefined;
	}
}

//Function Number: 10
func_1370F()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_E2E0();
}

//Function Number: 11
createhypnosisforplayer(param_00)
{
	var_01 = spawnturret("misc_turret",param_00.origin + (0,0,25),"sentry_minigun_mp");
	var_01.angles = param_00.angles;
	var_01.var_222 = param_00;
	var_01.name = "crafted_hypnosis";
	var_01.carriedhypnosis = spawn("script_model",var_01.origin);
	var_01.carriedhypnosis.angles = param_00.angles;
	var_01 method_81F5();
	var_01 method_835B(1);
	var_01 method_830F("sentry_offline");
	var_01 makeunusable();
	var_01 method_8336(param_00);
	var_01 hypnosis_inithypnosis(param_00);
	return var_01;
}

//Function Number: 12
hypnosis_inithypnosis(param_00)
{
	self.var_3872 = 1;
	hypnosis_setinactive();
}

//Function Number: 13
hypnosis_handledeath(param_00)
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	hypnosis_setinactive();
	self playsound("sentry_explode");
	if(isdefined(self.var_3CBF))
	{
		self.var_3CBF delete();
	}

	if(isdefined(self.var_13E61))
	{
		self.var_13E61 delete();
	}

	scripts\cp\_utility::func_E11E();
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 14
hypnosis_setplaced(param_00,param_01)
{
	var_02 = self.carriedhypnosis.origin - (0,0,35);
	var_03 = self.carriedhypnosis.angles;
	self.var_3A9D method_80F3();
	self.var_3A9D = undefined;
	param_01.var_9D81 = 0;
	self.carriedhypnosis delete();
	self delete();
	var_04 = spawn("script_model",var_02);
	var_04.angles = var_03;
	var_04.var_222 = param_01;
	var_04.team = "allies";
	var_04 setmodel(level.crafted_hypnosis_settings["crafted_hypnosis"].var_CC12);
	var_04.name = "crafted_hypnosis";
	var_04.lastkilltime = gettime();
	var_04.lastmultikilltime = gettime();
	var_04 thread hypnosis_setactive(param_00);
	var_04 playsound("trap_boom_box_drop");
	self notify("placed");
}

//Function Number: 15
hypnosis_setcancelled()
{
	self.var_3A9D method_80F3();
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
	}

	self.carriedhypnosis delete();
	self delete();
}

//Function Number: 16
hypnosis_setcarried(param_00,param_01)
{
	if(isdefined(self.var_C731))
	{
	}
	else
	{
	}

	self setmodel(level.crafted_hypnosis_settings["crafted_hypnosis"].var_B924);
	self hide();
	self method_8335(param_00);
	self setcandamage(0);
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	param_00 thread scripts\cp\_utility::func_12E3F(self,self.carriedhypnosis,level.crafted_hypnosis_settings["crafted_hypnosis"],1);
	thread scripts\cp\_utility::func_A025(param_00);
	thread scripts\cp\_utility::func_A026(param_00);
	thread scripts\cp\_utility::func_A027(param_00);
	hypnosis_setinactive();
	self notify("carried");
}

//Function Number: 17
hypnosis_setactive(param_00)
{
	wait(0.5);
	playfxontag(level._effect["hypnosis_active"],self,"tag_origin");
	func_48A7((1,1,0),0,15,36);
	thread hypnosis_handledeath(self.var_222);
	thread scripts\cp\_utility::func_A021("elechypnosis_handleOwner");
	thread scripts\cp\_utility::func_A030(param_00,level.crafted_hypnosis_settings["crafted_hypnosis"].var_11901,"explode");
	thread hypnosis_trap_enemies();
	thread hypnosis_sfx();
	thread hypnosis_explode();
	scripts\cp\_utility::func_1861();
}

//Function Number: 18
hypnosis_setinactive()
{
	self stoploopsound("trap_medusa_charging_lp");
	scripts\cp\_utility::func_E11E();
}

//Function Number: 19
hypnosis_trap_enemies()
{
	self endon("death");
	self endon("explode");
	self.var_4D7E = [];
	var_00 = 262144;
	for(;;)
	{
		var_01 = scripts\cp\_agent_utils::func_7DB0("axis");
		var_01 = scripts\common\utility::func_782F(self.origin,var_01);
		foreach(var_03 in var_01)
		{
			if(!scripts\cp\_utility::func_FF18(var_03) || scripts\common\utility::istrue(var_03.var_152C) || scripts\common\utility::istrue(var_03.controlled))
			{
				continue;
			}

			if(var_03.agent_type == "crab_mini" || var_03.agent_type == "crab_brute")
			{
				continue;
			}

			if(distancesquared(self.origin,var_03.origin) < var_00)
			{
				var_04 = func_78AD(self,var_03);
				var_03 thread func_841C(self,var_04);
				var_03 thread func_DF44(self);
				scripts\common\utility::func_136F7();
			}
		}

		wait(0.1);
	}
}

//Function Number: 20
hypnosis_sfx()
{
	self playloopsound("town_hypnosis_tone_lp");
	self waittill("explode");
	self playsound("town_hypnosis_build_up_to_explode");
	wait(0.25);
	self playloopsound("town_hypnosis_tone_head_crush_lp");
	wait(1.15);
	if(isdefined(self))
	{
		self stoploopsound();
	}

	thread func_66A7();
}

//Function Number: 21
func_841C(param_00,param_01)
{
	param_00 endon("death");
	self endon("death");
	self endon("turned");
	param_00 endon("explode");
	self.var_152C = 1;
	self.var_EF64 = 1;
	self.var_C37F = self.var_15C;
	self.var_15C = 32;
	self.og_movemode = self.var_1F5;
	self.var_1F5 = "sprint";
	var_02 = param_00.origin - param_01.origin;
	var_03 = vectortoangles(var_02);
	self.var_5273 = (0,var_03[1],0);
	self method_82EF(param_01.origin);
	scripts\common\utility::waittill_any_3("goal","goal_reached");
	self setscriptablepartstate("eyes","hypnotized");
	self.var_CF80 = param_00.var_222;
	self.var_9BB0 = 1;
	param_00.var_4D7E[param_00.var_4D7E.size] = self;
}

//Function Number: 22
func_DF44(param_00)
{
	self endon("death");
	param_00 scripts\common\utility::waittill_any_3("death","explode");
	if(isdefined(self.var_C37F))
	{
		self.var_15C = self.var_C37F;
	}

	self.var_1F5 = self.og_movemode;
	self.var_C37F = undefined;
	self.var_152C = 0;
	self.var_EF64 = 0;
}

//Function Number: 23
hypnosis_explode()
{
	self waittill("explode");
	var_00 = self.var_4D7E;
	foreach(var_03, var_02 in var_00)
	{
		var_02 thread hypnosis_delayed_death(var_03,self);
		if(isdefined(self.var_222))
		{
			self.var_222 scripts\cp\_merits::func_D9AD("mt_dlc3_crafted_kills");
		}
	}
}

//Function Number: 24
func_66A7()
{
	self playsound("trap_boom_box_explode");
	playfx(level._effect["violet_light_explode"],self.origin);
	wait(0.1);
	radiusdamage(self.origin + (0,0,40),200,500,250,self,"MOD_EXPLOSIVE","zmb_imsprojectile_mp");
	self hide();
	wait(0.65);
	physicsexplosionsphere(self.origin,256,256,2);
	wait(0.1);
	self delete();
}

//Function Number: 25
hypnosis_delayed_death(param_00,param_01)
{
	self endon("death");
	wait(param_00 * 0.05);
	self.deathmethod = "hypnosis";
	if(!scripts\common\utility::istrue(self.var_9BAC))
	{
		lib_0A1A::func_237C("hypnosisdeath");
		return;
	}

	lib_0A1A::func_237C("hypnosisdeathcrawling");
}

//Function Number: 26
func_78AD(param_00,param_01)
{
	var_02 = sortbydistance(param_00.var_254B,param_01.origin);
	foreach(var_04 in var_02)
	{
		if(!var_04.var_C2CF)
		{
			var_04.var_C2CF = 1;
			return var_04;
		}
	}

	return var_02[0];
}

//Function Number: 27
func_48A7(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = -27120;
	var_05 = 0;
	var_06 = 360 / param_02;
	self.var_254B = [];
	for(var_07 = param_01;var_07 < 360 + param_01;var_07 = var_07 + var_06)
	{
		var_08 = param_00 * param_03;
		var_09 = (cos(var_07) * var_08[0] - sin(var_07) * var_08[1],sin(var_07) * var_08[0] + cos(var_07) * var_08[1],var_08[2]);
		var_0A = getclosestpointonnavmesh(self.origin + var_09 + (0,0,10));
		if(!scripts\cp\zombies\_powerups::is_in_active_volume(var_0A))
		{
			continue;
		}

		if(isdefined(var_0A) && distancesquared(var_0A,self.origin) > var_04)
		{
			continue;
		}
		else
		{
			if(abs(var_0A[2] - self.origin[2]) < 60)
			{
				var_0B = spawnstruct();
				var_0B.origin = var_0A;
				var_0B.var_C2CF = 0;
				self.var_254B[self.var_254B.size] = var_0B;
				continue;
			}

			var_05++;
		}
	}

	for(var_07 = param_01;var_07 < 360 + param_01;var_07 = var_07 + var_06)
	{
		var_08 = param_00 * param_03 + 56;
		var_09 = (cos(var_07) * var_08[0] - sin(var_07) * var_08[1],sin(var_07) * var_08[0] + cos(var_07) * var_08[1],var_08[2]);
		var_0A = getclosestpointonnavmesh(self.origin + var_09 + (0,0,10));
		if(!scripts\cp\zombies\_powerups::is_in_active_volume(var_0A))
		{
			continue;
		}

		if(isdefined(var_0A) && distancesquared(var_0A,self.origin) > var_04)
		{
			continue;
		}
		else
		{
			if(abs(var_0A[2] - self.origin[2]) < 60)
			{
				var_0B = spawnstruct();
				var_0B.origin = var_0A;
				var_0B.var_C2CF = 0;
				self.var_254B[self.var_254B.size] = var_0B;
				continue;
			}

			var_05++;
		}
	}

	return var_05;
}