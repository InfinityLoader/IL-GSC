/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1379.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 42 ms
 * Timestamp: 10/27/2023 3:25:54 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_A41["zombie_exploder"] = level.var_A41["zombie"];
	level.var_A41["zombie_exploder"]["think"] = ::func_ABA0;
	level.var_A41["zombie_exploder"]["spawn"] = ::func_AB9F;
	level.var_A41["zombie_exploder"]["on_damaged_finished"] = ::func_AB99;
	level.var_A41["zombie_exploder"]["is_hit_weak_point"] = ::func_AB95;
	level.var_A41["zombie_exploder"]["on_killed"] = ::func_AB9A;
	level.var_A41["zombie_exploder"]["get_action_params"] = ::func_AB91;
	level.var_A41["zombie_exploder"]["move_mode"] = ::func_AB97;
	level.var_A41["zombie_exploder"]["on_damaged"] = ::func_AB9B;
	level.var_62B3["drag_explosive_zm"] = ::func_62A2;
	level.var_ABA1 = spawn("script_origin",(0,0,0));
	level.var_ABA1.var_1A7 = "allies";
	var_00 = spawnstruct();
	var_00.var_A4B = "zombie_exploder";
	var_00.var_EAE = "zombie_animclass";
	var_00.var_E88 = "zombie_generic";
	var_00.var_879 = "zombie_generic";
	var_00.var_5ED2["bomber"]["whole_body"] = "zom_bomber_base";
	var_00.var_5ED2["bomber"]["drag_weapons"] = ["zom_bomb"];
	var_00.var_4C12 = 2;
	var_00.var_60E2 = 20;
	var_00.var_8302 = 65;
	var_00.var_8303 = 15;
	var_00.parenttype = "zombie_generic";
	var_00.suppressive_fire_speed_multiplier = 0.3;
	var_00.tacklebymelee = 1;
	var_00.tacklebycharge = 1;
	var_00.knockbyravensword = 1;
	var_00.shockbyteslablood = 1;
	var_00.energyhold = 1;
	var_00.energyslowsecondary = 1;
	var_00.throwable = 1;
	if(isdefined(level.var_62AB))
	{
		var_00 = [[ level.var_62AB ]](var_00);
	}

	lib_0547::func_A52(var_00,"zombie_exploder");
	level.var_393E = [];
}

//Function Number: 2
func_AB94(param_00)
{
	if(!isdefined(self.var_4BF4))
	{
		return;
	}

	foreach(var_02 in self.var_4BF4)
	{
		if(var_02.var_95A6 == param_00)
		{
			return var_02;
		}
	}
}

//Function Number: 3
func_AB9F(param_00,param_01,param_02)
{
	lib_054D::func_6BD7(param_00,param_01,param_02);
	self.var_4BF4 = [];
	self method_85A1("zombie_exploder");
	foreach(var_04 in ["j_headb"])
	{
		var_05 = spawnstruct();
		var_05.var_95A6 = var_04;
		var_05.var_FB = 0.3 * self.var_FB;
		var_05.var_BC = var_05.var_FB;
		self.var_4BF4 = common_scripts\utility::func_F6F(self.var_4BF4,var_05);
	}

	self.var_4B34 = 0;
	self.var_A99D = "TAG_WEAPON_CHEST";
	thread func_51C4();
}

//Function Number: 4
func_ABA0()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	lib_0566::func_ABB5();
	var_00 = 1;
	for(;;)
	{
		if(var_00)
		{
			var_01 = randomfloat(0.2);
			var_00 = 0;
		}
		else
		{
			var_01 = 0.2;
		}

		wait(var_01);
		if(lib_053C::func_4F8C())
		{
			continue;
		}

		if(lib_053C::func_4F84())
		{
			continue;
		}

		if(lib_053C::func_4F9B())
		{
			continue;
		}

		if(lib_053C::func_4F9A())
		{
			continue;
		}

		lib_053C::func_647();
	}
}

//Function Number: 5
func_51C4()
{
	self endon("death");
	waittillframeend;
	var_00 = lib_0547::func_A51("zombie_exploder");
	self.var_3391 = common_scripts\utility::func_7A33(var_00.var_5ED2[self.var_18B0]["drag_weapons"]);
	var_01 = spawnstruct();
	self attach(self.var_3391,self.var_A99D);
	self.var_3937 = var_01;
	var_02 = maps/mp/gametypes/zombies::func_1E59(lib_0547::func_A51("zombie_exploder"),self.var_901F);
	var_01.var_6280 = self;
	var_01.var_3935 = int(0.2 * var_02);
	var_01.var_3F22 = 0;
	var_01.var_117 = self;
	var_01.var_72A1 = 0;
	var_01.var_5B3C = 0;
	self.var_392C = 1;
	self.var_1723 = 1;
	thread func_AB96();
}

//Function Number: 6
func_AB9A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(common_scripts\utility::func_562E(self.var_392C))
	{
		if(common_scripts\utility::func_562E(self.var_6734))
		{
			self.var_3937 func_3940();
		}
		else
		{
			thread func_AB90();
		}

		if(isplayer(param_01) && issubstr(param_04,"shovel") && maps\mp\_utility::func_4571() == "mp_zombie_nest_01")
		{
			param_01 maps/mp/gametypes/zombies::func_47C8("ZM_SHOVEL");
		}
	}

	level notify("zombie_exploder_killed");
	self setmodel("zom_bomber_base");
	lib_054D::func_6BD4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 7
func_AB99(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!common_scripts\utility::func_562E(self.exploder_godmode) && lib_0547::func_5565(param_0A,tolower("TAG_WEAPON")))
	{
		if(common_scripts\utility::func_562E(self.var_392C))
		{
			if(isdefined(param_05) && isdefined(param_08) && isdefined(param_01) && isplayer(param_01))
			{
				var_0B = param_01 method_850B(param_05,param_08);
				if(var_0B != 0)
				{
					param_02 = int(param_02 / var_0B);
				}
			}

			self.var_3937 func_3943(param_02,param_01,param_05,param_04);
		}

		return;
	}

	if(common_scripts\utility::func_562E(self.sgvip) && func_AB95(self,param_00,param_01,param_02,param_04,param_05,param_06,param_07,param_08,param_0A))
	{
		param_02 = int(param_02 * 1.1);
	}

	if(!common_scripts\utility::func_562E(self.exploder_godmode) && !self.var_4B34)
	{
		var_0C = func_AB94(param_0A);
		if(isdefined(var_0C) && var_0C.var_BC > 0)
		{
			var_0C.var_BC = var_0C.var_BC - param_02;
			if(var_0C.var_BC <= 0)
			{
				var_0C.var_BC = 0;
				self.var_4B34 = 1;
				self notify(func_40E3(var_0C.var_95A6));
				var_0D = var_0C.var_95A6 + " taken out";
				switch(var_0C.var_95A6)
				{
					case "j_head":
						var_0D = "\nExploder can\'t melee";
						self.var_1723 = 1;
						break;

					case "j_headb":
						self.var_1723 = undefined;
						if(common_scripts\utility::func_562E(self.var_392C) && !common_scripts\utility::func_562E(self.escort_zombie))
						{
							var_0D = "\nExploder dropped bomb";
							func_AB90();
							if(isplayer(param_01) && !lib_0547::func_577E(param_01))
							{
								param_01 thread lib_054E::func_18EC();
							}
	
							self.var_6CC4 = "scripted_pain_drop_bomb";
						}
						break;
				}
			}
		}
	}

	lib_054D::func_6BD3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	self.var_6CC4 = undefined;
}

//Function Number: 8
func_AB95(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	param_00 = self;
	if(common_scripts\utility::func_562E(self.var_392C) && lib_0547::func_5565(param_09,tolower("TAG_WEAPON")))
	{
		return 1;
	}

	if(common_scripts\utility::func_562E(self.sgvip) && zombie_vib_exploder_is_weak_point(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09))
	{
		return 1;
	}

	return lib_054D::func_5714(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 9
zombie_vib_exploder_is_weak_point(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = 0;
	var_0B = "";
	switch(param_08)
	{
		case "j_headb":
		case "neck":
		case "helmet":
		case "j_head":
		case "head":
			var_0A = 1;
			break;
	}

	return var_0A;
}

//Function Number: 10
func_AB9D()
{
	self method_802E(self.var_3391,self.var_A99D);
	self.var_3937.var_117 = undefined;
	self.var_3937 = undefined;
	self.var_392C = 0;
	var_00 = func_AB94("j_headb");
	if(var_00.var_BC > 0)
	{
		var_00.var_BC = 0;
		self.var_4B34 = 1;
		self setmodel("zom_bomber_base_dead_phys");
	}

	self.var_1723 = 0;
}

//Function Number: 11
func_5F07()
{
	self.var_6280 delete();
}

//Function Number: 12
func_AB90()
{
	self notify("dropped_explosive");
	self.var_349C = spawn("script_model",(0,0,0));
	self.var_349C setmodel(self.var_3391);
	self.var_349C.var_A99D = "TAG_WEAPON";
	func_0BBF(self.var_349C,self.var_349C.var_A99D,self,self.var_A99D);
	self.var_349C lib_0547::init_damageable_script_model();
	self.var_349C setcanradiusdamage(1);
	self.var_349C.var_BC = self.var_3937.var_3935;
	self.var_349C.var_3937 = self.var_3937;
	self.var_3937.var_6280 = self.var_349C;
	func_AB9D();
	self.var_349C physicslaunchserver();
	self.var_349C thread func_A88A();
	self.var_349C thread func_6282();
	self setmodel("zom_bomber_base_dead_phys");
}

//Function Number: 13
func_3940()
{
	self notify("exploder_shutdown");
	if(isdefined(self.var_117) && common_scripts\utility::func_562E(self.var_117.var_392C))
	{
		self.var_117 func_AB9D();
		return;
	}

	func_5F07();
}

//Function Number: 14
func_3943(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_02) && param_02 == "drag_explosive_zm")
	{
		return;
	}

	if(isdefined(param_03) && param_03 == "MOD_MELEE")
	{
		return;
	}

	if(isplayer(param_01) && param_03 != "MOD_EXPLOSIVE" && self.var_5B3C != gettime())
	{
		self.var_72A1++;
		self.var_5B3C = gettime();
	}

	self.var_3935 = self.var_3935 - param_00;
	if(self.var_3935 <= 0 || self.var_72A1 >= 4)
	{
		thread func_0893(param_01,param_02);
	}
}

//Function Number: 15
zombie_exploder_attempt_detonate(param_00,param_01)
{
	var_02 = self;
	if(common_scripts\utility::func_562E(self.var_392C))
	{
		self.var_3937 thread func_0893(param_00,param_01);
	}
}

//Function Number: 16
func_A88A()
{
	self endon("entitydeleted");
	self.var_3937 endon("detonate");
	self.var_3937 endon("exploder_shutdown");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		self.var_3937 func_3943(var_00,var_01,var_09,var_04);
	}
}

//Function Number: 17
func_4183()
{
	var_00 = self;
	var_01 = var_00.var_6280 gettagorigin(var_00.var_6280.var_A99D);
	return var_01;
}

//Function Number: 18
func_0893(param_00,param_01)
{
	self notify("detonate");
	var_02 = func_4183();
	func_AB98(var_02);
	var_03 = spawn("script_origin",var_02);
	if(isdefined(param_00))
	{
		var_03.var_9DBF = param_01;
		var_03 detonateusingweapon("drag_explosive_zm",param_00);
	}
	else
	{
		var_03 detonateusingweapon("drag_explosive_zm");
	}

	var_04 = level.var_ABA1;
	if(isdefined(param_00) && isplayer(param_00))
	{
		var_04.var_117 = param_00;
		var_04.var_9DBF = param_01;
	}
	else
	{
		var_04 = undefined;
	}

	if(isdefined(self.var_117) && common_scripts\utility::func_562E(self.var_117.var_392C))
	{
		self.var_117 thread zombie_exploder_ensure_die_from_attached_explosion(var_04);
	}

	func_3940();
	func_AB9C(var_02,var_04);
	func_AB9E(var_02);
	wait(5);
	var_03 delete();
}

//Function Number: 19
zombie_exploder_ensure_die_from_attached_explosion(param_00)
{
	var_01 = self;
	var_01 endon("death");
	wait 0.05;
	if(isdefined(param_00) && !isplayer(param_00.var_117))
	{
		param_00 = undefined;
	}

	if(isalive(var_01))
	{
		var_01 dodamage(var_01.var_FB + 666,var_01.var_116,param_00,undefined,"MOD_EXPLOSIVE","drag_explosive_zombie_zm");
	}
}

//Function Number: 20
func_AB9C(param_00,param_01)
{
	var_02 = maps/mp/gametypes/zombies::func_1E59(lib_0547::func_A51("zombie_exploder"),level.var_A980);
	var_03 = int(1.1 * var_02);
	var_04 = int(0.5 * var_02);
	radiusdamage(param_00,92,var_03,var_04,param_01,"MOD_EXPLOSIVE","drag_explosive_zombie_zm");
}

//Function Number: 21
func_AB9E(param_00)
{
	if(!isdefined(level.var_744A))
	{
		return;
	}

	foreach(var_02 in level.var_744A)
	{
		if(distance(param_00,var_02.var_116) <= 92)
		{
			var_02 shellshock("ear_ring_mp",1.25,0,0);
		}
	}
}

//Function Number: 22
func_AB97()
{
	var_00 = "walk";
	var_01 = 1;
	var_02 = func_AB94("j_headb");
	if(isdefined(var_02) && var_02.var_BC <= 0)
	{
		var_01 = 1;
		var_00 = [[ level.var_A41["zombie"]["move_mode"] ]]();
		if(var_00 == "walk")
		{
			var_00 = "run";
		}
	}

	self.var_64C2 = var_01 * lib_054D::func_4440();
	self.var_2FA4 = var_00 != "walk";
	return var_00;
}

//Function Number: 23
func_AB91()
{
	var_00 = lib_054D::func_AC22();
	if(common_scripts\utility::func_562E(self.var_392C))
	{
		if(self.var_3937.var_3F22 == 1)
		{
			var_00["script_var"] = "tick_bomb";
		}
		else
		{
			var_00["script_var"] = "held_bomb";
		}
	}
	else
	{
		var_00["script_var"] = "drop_bomb";
	}

	return var_00;
}

//Function Number: 24
func_40E3(param_00)
{
	return param_00 + "_braindead";
}

//Function Number: 25
func_AB96()
{
	self endon("death");
	self endon("dropped_explosive");
	self endon(func_40E3("j_headb"));
	self.var_3937 endon("short_fuse");
	self.var_3937 endon("detonate");
	wait 0.05;
	thread func_6309(self,self.var_3937);
	for(;;)
	{
		wait(1);
		if(lib_0547::is_zombie_stunned())
		{
			continue;
		}

		if(self.var_3937.var_3F22 == 1)
		{
			continue;
		}

		if(common_scripts\utility::func_562E(self.escort_zombie))
		{
			continue;
		}

		var_00 = lib_053C::func_4F88()[0];
		if(!isdefined(var_00))
		{
			continue;
		}

		var_01 = distancesquared(self.var_116,var_00.var_116);
		if(var_01 > squared(func_AB92()))
		{
			continue;
		}

		if(!lib_0547::func_4B2C())
		{
			continue;
		}

		if(isplayer(var_00) && !self agentcanseesentient(var_00))
		{
			continue;
		}

		self.var_3937 thread func_3942();
	}
}

//Function Number: 26
func_3932()
{
	var_00 = self;
	if(!common_scripts\utility::func_562E(var_00.var_5759))
	{
		return;
	}

	var_00 notify("killanimscript");
	var_00 thread maps/mp/agents/humanoid/_humanoid_move::func_2603();
}

//Function Number: 27
func_3942()
{
	self notify("short_fuse");
	self endon("detonate");
	self endon("exploder_shutdown");
	self endon("exploder_interrupt");
	var_00 = self.var_117;
	var_00 endon("death");
	var_00 endon("dropped_explosive");
	self.var_3F22 = 1;
	self.var_3F23 = gettime();
	var_00 func_3932();
	var_01 = var_00 lib_053C::func_4F88()[0];
	if(isdefined(var_01))
	{
		var_02 = 1 - distance(var_01.var_116,var_00.var_116) / func_AB92();
		if(var_02 > 0.2)
		{
			var_03 = 2.3 * var_02;
			wait(var_03);
		}
	}

	wait(1.25);
	for(;;)
	{
		var_04 = level.var_744A;
		if(common_scripts\utility::func_562E(var_00.ismooncontrolled))
		{
			var_04 = var_00 lib_053C::func_4F88();
		}

		if(var_00 should_explode(self,var_04))
		{
			break;
		}

		wait(0.1);
	}

	thread func_0893();
}

//Function Number: 28
should_explode(param_00,param_01)
{
	if(lib_0547::func_5565(self.var_BA4,"traverse"))
	{
		return 0;
	}

	if(lib_0547::func_5565(self.var_BA4,"scripted"))
	{
		return 0;
	}

	if(isdefined(common_scripts\utility::func_4461(param_00 func_4183(),param_01,92)))
	{
		return 1;
	}

	return 0;
}

//Function Number: 29
func_630A(param_00)
{
	param_00 endon("exploder_interrupt");
	var_01 = self;
	for(;;)
	{
		wait(1);
		var_02 = lib_053C::func_4F88();
		if(var_02.size == 0)
		{
			break;
		}

		var_03 = var_02[0];
		var_04 = distance(var_01.var_116,var_03.var_116);
		if(var_04 > func_AB93())
		{
			break;
		}
	}

	var_01 notify("player_dist_reset");
}

//Function Number: 30
func_6309(param_00,param_01)
{
	param_01 endon("exploder_shutdown");
	param_01 endon("death");
	param_01 endon("detonate");
	param_00 endon("death");
	param_00 endon("dropped_explosive");
	param_01 waittill("short_fuse");
	param_00 childthread func_630A(param_01);
	var_02 = param_00 common_scripts\utility::func_A715("stun_burst","player_dist_reset","dropped_explosive","zombie_stunned");
	param_01 notify("exploder_interrupt");
	param_01.var_3F22 = 0;
	param_00 func_3932();
	param_00 thread func_AB96();
}

//Function Number: 31
func_0BBF(param_00,param_01,param_02,param_03)
{
	var_04 = param_00 gettagorigin(param_01);
	var_05 = param_00 gettagangles(param_01);
	var_06 = param_02 gettagorigin(param_03);
	var_07 = param_02 gettagangles(param_03);
	var_08 = transformmove(var_06,var_07,var_04,var_05,param_00.var_116,param_00.var_1D);
	param_00.var_116 = var_08["origin"];
	param_00.var_1D = var_08["angles"];
}

//Function Number: 32
func_2AD8(param_00,param_01,param_02,param_03,param_04)
{
	self endon(param_04);
	var_05 = [];
	var_05["forward"] = (1,0,0);
	var_05["up"] = (0,0,1);
	var_05["right"] = (0,1,0);
	var_06 = anglestoaxis(param_01);
	foreach(var_09, var_08 in var_06)
	{
		var_06[var_09] = var_08 * param_02 * 0.5;
	}

	for(;;)
	{
		foreach(var_09, var_08 in var_06)
		{
			thread maps\mp\_utility::func_33D8(param_00,param_00 + var_08,1,param_03);
			thread maps\mp\_utility::func_33D8(param_00 + var_08,param_00 + var_08 * 2,1,var_05[var_09]);
		}

		wait(1);
	}
}

//Function Number: 33
func_62A2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	return 0;
}

//Function Number: 34
func_6282()
{
	level.var_393E = common_scripts\utility::func_F6F(level.var_393E,self);
	thread func_6281();
	waittillframeend;
	if(level.var_393E.size > 12)
	{
		var_00 = level.var_393E.size - 12;
		var_01 = [];
		for(var_02 = 0;var_02 < var_00;var_02++)
		{
			var_01[var_02] = level.var_393E[var_02];
		}

		foreach(var_04 in var_01)
		{
			var_04.var_3937 func_3940();
		}
	}
}

//Function Number: 35
func_6281()
{
	self waittill("entitydeleted");
	level.var_393E = common_scripts\utility::func_F93(level.var_393E,self);
}

//Function Number: 36
func_AB92()
{
	if(common_scripts\utility::func_562E(level.zmb_exploder_always_chases))
	{
		return 99999;
	}

	return 350;
}

//Function Number: 37
func_AB93()
{
	if(common_scripts\utility::func_562E(level.zmb_exploder_always_chases))
	{
		return 999990;
	}

	return 450;
}

//Function Number: 38
func_AB98(param_00)
{
	level notify("objective_zombie_exploder_detonation",param_00,92);
}

//Function Number: 39
func_AB9B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if((!common_scripts\utility::func_562E(self.var_55AB) && param_05 == "panzerschreck_zm") || param_05 == "bazooka_zm")
	{
		if(common_scripts\utility::func_562E(self.sgvip))
		{
			param_02 = int(self.var_FB / 5);
		}
		else
		{
			param_02 = self.var_FB;
		}
	}

	if(common_scripts\utility::func_562E(self.sgvip) && isdefined(level.zmb_boss_damage_reduction_func))
	{
		param_02 = [[ level.zmb_boss_damage_reduction_func ]](param_05,param_02);
	}

	if(isdefined(self.on_took_damage_func))
	{
		self thread [[ self.on_took_damage_func ]](anglestoforward(self.var_1D),param_08,param_05,param_04,param_02,param_00,param_01);
	}

	lib_054D::func_6BD1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
}