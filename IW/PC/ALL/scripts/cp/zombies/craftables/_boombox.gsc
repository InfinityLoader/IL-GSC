/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\craftables\_boombox.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 992 ms
 * Timestamp: 10/27/2023 12:23:36 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["boombox_c4light"] = loadfx("vfx/iw7/_requests/coop/vfx_boombox_blink");
	level._effect["boombox_explode"] = loadfx("vfx/iw7/_requests/coop/vfx_ghetto_blast.vfx");
	var_00 = spawnstruct();
	var_00.var_11901 = 18;
	var_00.var_B91A = "boom_box_c4_wm";
	var_00.var_B924 = "boom_box_c4_wm";
	var_00.var_B925 = "boom_box_c4_wm_bad";
	var_00.var_CC12 = "boom_box_c4_wm";
	var_00.var_CC28 = &"COOP_CRAFTABLES_PLACE";
	var_00.var_38E3 = &"COOP_CRAFTABLES_CANNOT_PLACE";
	var_00.var_CC0A = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
	var_00.var_CC22 = 30;
	var_00.var_CC25 = 16;
	var_00.var_3AA7 = (0,0,35);
	var_00.var_3AA6 = (0,180,0);
	level.var_47AE = [];
	level.var_47AE["crafted_boombox"] = var_00;
}

//Function Number: 2
func_82B4(param_00,param_01)
{
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_boombox");
	param_01 setclientomnvar("zom_crafted_weapon",5);
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	scripts\cp\_utility::func_F313("crafted_boombox",::func_82B4,param_01);
}

//Function Number: 3
func_13932()
{
	self endon("disconnect");
	self endon("death");
	self notify("craft_dpad_watcher");
	self endon("craft_dpad_watcher");
	self notifyonplayercommand("pullout_boombox","+actionslot 3");
	for(;;)
	{
		self waittill("pullout_boombox");
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

	thread func_82A8(1);
}

//Function Number: 4
func_82A8(param_00,param_01)
{
	self endon("disconnect");
	scripts\cp\_utility::clearlowermessage("msg_power_hint");
	var_02 = func_4989(self);
	self.var_A039 = var_02.name;
	func_E152();
	var_02 = func_4989(self);
	self.var_3AA5 = var_02;
	var_02.var_6DEC = 1;
	var_03 = func_F682(var_02,param_00,param_01);
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
func_F682(param_00,param_01,param_02)
{
	self endon("disconnect");
	param_00 func_2CA3(self,param_01);
	scripts\common\utility::allow_weapon(0);
	self notifyonplayercommand("place_boombox","+attack");
	self notifyonplayercommand("place_boombox","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_boombox","+actionslot 3");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_boombox","+actionslot 5");
		self notifyonplayercommand("cancel_boombox","+actionslot 6");
		self notifyonplayercommand("cancel_boombox","+actionslot 7");
	}

	for(;;)
	{
		var_03 = scripts\common\utility::func_13734("place_boombox","cancel_boombox","force_cancel_placement");
		if(!isdefined(param_00))
		{
			scripts\common\utility::allow_weapon(1);
			return 1;
		}

		if(!isdefined(var_03))
		{
			var_03 = "force_cancel_placement";
		}

		if(var_03 == "cancel_boombox" || var_03 == "force_cancel_placement")
		{
			if(!param_01 && var_03 == "cancel_boombox")
			{
				continue;
			}

			scripts\common\utility::allow_weapon(1);
			param_00 func_2CA2();
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

		param_00 func_2CA5(param_02,self);
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
func_4989(param_00)
{
	var_01 = spawnturret("misc_turret",param_00.origin + (0,0,25),"sentry_minigun_mp");
	var_01.angles = param_00.angles;
	var_01.var_222 = param_00;
	var_01.name = "crafted_boombox";
	var_01.var_3A9C = spawn("script_model",var_01.origin);
	var_01.var_3A9C.angles = param_00.angles;
	var_01 method_81F5();
	var_01 method_835B(1);
	var_01 method_830F("sentry_offline");
	var_01 makeunusable();
	var_01 method_8336(param_00);
	var_01 func_2CA0(param_00);
	return var_01;
}

//Function Number: 12
func_2CA0(param_00)
{
	self.var_3872 = 1;
	func_2CA4();
}

//Function Number: 13
func_2C9E(param_00)
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	func_2CA4();
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
func_2CA5(param_00,param_01)
{
	var_02 = getgroundposition(self.var_3A9C.origin,4);
	var_03 = spawn("script_model",self.var_3A9C.origin);
	var_03.angles = self.var_3A9C.angles;
	var_03 solid();
	var_03 setmodel(level.var_47AE["crafted_boombox"].var_CC12);
	var_03 physicslaunchserver(var_03.origin,(0,0,1));
	self.var_3A9D method_80F3();
	self.var_3A9D = undefined;
	param_01.var_9D81 = 0;
	self.var_3A9C delete();
	self delete();
	var_03 moveto(var_02,0.5);
	wait(0.6);
	var_04 = spawn("script_model",var_03.origin);
	var_04.angles = var_03.angles;
	var_04.var_222 = param_01;
	var_04.team = "allies";
	var_04 setmodel(level.var_47AE["crafted_boombox"].var_CC12);
	var_04.name = "crafted_boombox";
	var_03 delete();
	var_04.lastkilltime = gettime();
	var_04.lastmultikilltime = gettime();
	var_04 thread func_2CA1(param_00);
	var_04 playsound("trap_boom_box_drop");
	self notify("placed");
}

//Function Number: 15
func_2CA2()
{
	self.var_3A9D method_80F3();
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
	}

	self.var_3A9C delete();
	self delete();
}

//Function Number: 16
func_2CA3(param_00,param_01)
{
	if(isdefined(self.var_C731))
	{
	}
	else
	{
	}

	self setmodel(level.var_47AE["crafted_boombox"].var_B924);
	self hide();
	self method_8335(param_00);
	self setcandamage(0);
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	param_00 thread scripts\cp\_utility::func_12E3F(self,self.var_3A9C,level.var_47AE["crafted_boombox"],1);
	thread scripts\cp\_utility::func_A025(param_00);
	thread scripts\cp\_utility::func_A026(param_00);
	thread scripts\cp\_utility::func_A027(param_00);
	func_2CA4();
	self notify("carried");
}

//Function Number: 17
func_2CA1(param_00)
{
	func_48A7((1,1,0),0,10,48);
	thread func_2C9E(self.var_222);
	thread scripts\cp\_utility::func_A021("elecboombox_handleOwner");
	thread scripts\cp\_utility::func_A030(param_00,level.var_47AE["crafted_boombox"].var_11901,"explode");
	thread func_2CA6();
	thread func_2C9D();
	scripts\cp\_utility::func_1861();
	wait(1);
	playfxontag(level._effect["boombox_c4light"],self,"c4_fx_tag");
}

//Function Number: 18
func_2CA4()
{
	scripts\cp\_utility::func_E11E();
}

//Function Number: 19
func_2CA6()
{
	self endon("death");
	self endon("boombox_explode");
	self.var_4D7E = [];
	self playloopsound("mus_zombies_boombox");
	var_00 = 262144;
	for(;;)
	{
		var_01 = scripts\cp\_agent_utils::func_7DB0("axis");
		var_01 = scripts\common\utility::func_782F(self.origin,var_01);
		foreach(var_03 in var_01)
		{
			if(!scripts\cp\_utility::func_FF18(var_03) || var_03.var_152C)
			{
				continue;
			}

			if(scripts\common\utility::istrue(self.var_9CDD))
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
func_841C(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("boombox_explode");
	self endon("death");
	self endon("turned");
	self.var_152C = 1;
	self.var_EF64 = 1;
	self.var_C37F = self.var_15C;
	self.var_15C = 32;
	var_02 = param_00.origin - param_01.origin;
	var_03 = vectortoangles(var_02);
	self.var_5273 = (0,var_03[1],0);
	self method_82EF(param_01.origin);
	scripts\common\utility::waittill_any_3("goal","goal_reached");
	self.var_9BB0 = 1;
	param_00.var_4D7E[param_00.var_4D7E.size] = self;
}

//Function Number: 21
func_DF44(param_00)
{
	self endon("death");
	param_00 scripts\common\utility::waittill_any_3("boombox_explode","death");
	if(isdefined(self.var_C37F))
	{
		self.var_15C = self.var_C37F;
	}

	self.var_C37F = undefined;
	self.var_152C = 0;
	self.var_EF64 = 0;
}

//Function Number: 22
func_2C9D()
{
	self waittill("explode");
	self playsound("mus_zombies_boombox_slow_down");
	self stoploopsound();
	self playsound("trap_boombox_warning");
	self notify("boombox_explode");
	wait(lookupsoundlength("mus_zombies_boombox_slow_down") / 1000);
	self playsound("trap_boom_box_explode");
	playfx(level._effect["boombox_explode"],self.origin);
	physicsexplosionsphere(self.origin,256,256,2);
	var_00 = self.var_4D7E;
	var_01 = 0;
	var_02 = 65536;
	foreach(var_04 in var_00)
	{
		if(var_01 > 5)
		{
			var_04.nocorpse = 1;
			var_04.full_gib = 1;
			var_04.deathmethod = "boombox";
			var_04 dodamage(var_04.health + 100,self.origin,self,self,"MOD_EXPLOSIVE","zmb_imsprojectile_mp");
			continue;
		}

		var_04 setvelocity(vectornormalize(var_04.origin - self.origin) * 400 + (0,0,200));
		var_04.do_immediate_ragdoll = 1;
		var_04.var_4C87 = 1;
		var_04 thread func_2C9C(self);
		var_01++;
	}

	scripts\common\utility::func_136F7();
	radiusdamage(self.origin + (0,0,40),350,1000000,1000000,self,"MOD_EXPLOSIVE","zmb_imsprojectile_mp");
	self hide();
	wait(3);
	self notify("death");
}

//Function Number: 23
func_2C9C(param_00)
{
	self endon("death");
	wait(0.1);
	self dodamage(self.health + 100,self.origin,param_00,param_00,"MOD_EXPLOSIVE","zmb_imsprojectile_mp");
}

//Function Number: 24
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

//Function Number: 25
func_48A7(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = -27120;
	var_05 = 0;
	var_06 = 360 / param_02;
	self.var_254B = [];
	self.var_C2D1 = 0;
	self.var_563E = 0;
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
				if(level.script != "cp_disco")
				{
					if(function_010F(var_0A,level.var_4D7C))
					{
						if(isdefined(level.var_563D))
						{
							continue;
						}
						else if(!self.var_563E)
						{
							self.var_563E = 1;
							var_0B = scripts\common\utility::getstructarray("interaction_discoballtrap","script_noteworthy");
							level thread scripts\cp\_interaction::func_9A0D(var_0B[0],30);
						}
					}
				}

				var_0C = spawnstruct();
				var_0C.origin = var_0A;
				var_0C.var_C2CF = 0;
				self.var_254B[self.var_254B.size] = var_0C;
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
				var_0C = spawnstruct();
				var_0C.origin = var_0A;
				var_0C.var_C2CF = 0;
				self.var_254B[self.var_254B.size] = var_0C;
				continue;
			}

			var_05++;
		}
	}

	return var_05;
}