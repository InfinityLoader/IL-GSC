/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\craftables\_revocator.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 850 ms
 * Timestamp: 10/27/2023 12:23:41 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["revocator_idle"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_revocator_idle.vfx");
	level._effect["revocator_activate"] = loadfx("vfx/iw7/_requests/coop/vfx_revocator_use.vfx");
	var_00 = spawnstruct();
	var_00.var_11901 = 30;
	var_00.var_B91A = "revocator";
	var_00.var_B924 = "revocator";
	var_00.var_B925 = "revocator_bad";
	var_00.var_CC12 = "revocator";
	var_00.var_17B = &"COOP_CRAFTABLES_PICKUP";
	var_00.var_CC28 = &"COOP_CRAFTABLES_PLACE";
	var_00.var_38E3 = &"COOP_CRAFTABLES_CANNOT_PLACE";
	var_00.var_CC0A = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
	var_00.var_CC22 = 30;
	var_00.var_CC25 = 24;
	var_00.var_3AA7 = (0,0,25);
	var_00.var_3AA6 = (0,0,0);
	level.var_47B1 = [];
	level.var_47B1["crafted_revocator"] = var_00;
}

//Function Number: 2
func_82B9(param_00,param_01)
{
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_revocator");
	param_01 setclientomnvar("zom_crafted_weapon",6);
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	scripts\cp\_utility::func_F313("crafted_revocator",::func_82B9,param_01);
}

//Function Number: 3
func_13932()
{
	self endon("disconnect");
	self endon("death");
	self notify("craft_dpad_watcher");
	self endon("craft_dpad_watcher");
	self notifyonplayercommand("pullout_revocator","+actionslot 3");
	for(;;)
	{
		self waittill("pullout_revocator");
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

	thread func_8329(1);
}

//Function Number: 4
func_8329(param_00,param_01,param_02)
{
	self endon("disconnect");
	scripts\cp\_utility::clearlowermessage("msg_power_hint");
	var_03 = func_4A08(self,param_02);
	self.var_A039 = var_03.name;
	func_E152();
	self.var_3AA5 = var_03;
	if(param_00)
	{
		var_03.var_6DEC = 1;
	}

	var_04 = func_F687(var_03,param_00,param_01);
	self.var_3AA5 = undefined;
	thread func_1370F();
	self.var_9D81 = 0;
	if(isdefined(var_03))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_F687(param_00,param_01,param_02)
{
	self endon("disconnect");
	param_00 func_E4B7(self,param_01);
	scripts\common\utility::allow_weapon(0);
	self notifyonplayercommand("place_revocator","+attack");
	self notifyonplayercommand("place_revocator","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_revocator","+actionslot 3");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_revocator","+actionslot 5");
		self notifyonplayercommand("cancel_revocator","+actionslot 6");
		self notifyonplayercommand("cancel_revocator","+actionslot 7");
	}

	for(;;)
	{
		var_03 = scripts\common\utility::func_13734("place_revocator","cancel_revocator","force_cancel_placement");
		if(!isdefined(param_00))
		{
			scripts\common\utility::allow_weapon(1);
			return 1;
		}

		if(!isdefined(var_03))
		{
			var_03 = "force_cancel_placement";
		}

		if(var_03 == "cancel_revocator" || var_03 == "force_cancel_placement")
		{
			if(!param_01 && var_03 == "cancel_revocator")
			{
				continue;
			}

			scripts\common\utility::allow_weapon(1);
			param_00 func_E4B6();
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

		param_00 func_E4B9(param_02,self);
		scripts\common\utility::allow_weapon(1);
		return 1;
	}
}

//Function Number: 6
func_E152()
{
	if(scripts\cp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.var_E2DF = "specialty_explosivebullets";
		scripts\cp\_utility::func_1430("specialty_explosivebullets");
	}
}

//Function Number: 7
func_E2E0()
{
	if(isdefined(self.var_E2DF))
	{
		scripts\cp\_utility::func_8387(self.var_E2DF);
		self.var_E2DF = undefined;
	}
}

//Function Number: 8
func_1370F()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_E2E0();
}

//Function Number: 9
func_4A08(param_00,param_01)
{
	var_02 = spawnturret("misc_turret",param_00.origin + (0,0,25),"sentry_minigun_mp");
	var_02.angles = param_00.angles;
	var_02.var_222 = param_00;
	var_02.name = "crafted_revocator";
	var_02.var_3AA4 = spawn("script_model",var_02.origin);
	var_02.var_3AA4.angles = param_00.angles;
	var_02 method_81F5();
	var_02 method_835B(1);
	var_02 method_830F("sentry_offline");
	var_02 makeunusable();
	var_02 method_8336(param_00);
	if(!isdefined(param_01))
	{
		var_02.var_130D2 = 1;
	}
	else
	{
		var_02.var_130D2 = param_01;
	}

	var_02 func_E4B4(param_00);
	return var_02;
}

//Function Number: 10
func_E4B4(param_00)
{
	self.var_3872 = 1;
	func_E4B8();
}

//Function Number: 11
func_E4B1(param_00)
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	func_E4B8();
	playsoundatpos(self.origin,"trap_revocator_deactivate");
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

//Function Number: 12
func_E4B9(param_00,param_01)
{
	var_02 = spawn("script_model",self.origin + (0,0,1));
	var_02.angles = self.angles;
	var_02 solid();
	var_02 setmodel(level.var_47B1["crafted_revocator"].var_CC12);
	self.var_3A9D method_80F3();
	self.var_3A9D = undefined;
	param_01.var_9D81 = 0;
	var_02.var_222 = param_01;
	var_02.var_130D2 = self.var_130D2;
	var_02.name = "crafted_revocator";
	var_02 thread func_E4B5(param_00);
	var_02 playsound("trap_revocator_activate");
	self notify("placed");
	self.var_3AA4 delete();
	self delete();
}

//Function Number: 13
func_E4B6()
{
	self.var_3A9D method_80F3();
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
	}

	self.var_3AA4 delete();
	self delete();
}

//Function Number: 14
func_E4B7(param_00,param_01)
{
	self setmodel(level.var_47B1["crafted_revocator"].var_B924);
	self hide();
	self method_8335(param_00);
	self setcandamage(0);
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	param_00 thread scripts\cp\_utility::func_12E3F(self,self.var_3AA4,level.var_47B1["crafted_revocator"]);
	thread scripts\cp\_utility::func_A025(param_00);
	thread scripts\cp\_utility::func_A026(param_00);
	thread scripts\cp\_utility::func_A027(param_00);
	func_E4B8();
	self notify("carried");
}

//Function Number: 15
func_E4B5(param_00)
{
	self endon("death");
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.var_47B1["crafted_revocator"].var_17B);
	self makeusable();
	self method_84A7("tag_fx");
	self method_84A5(120);
	self method_84A2(96);
	thread func_E4B1(self.var_222);
	thread scripts\cp\_utility::func_A021("elecrevocator_handleOwner");
	thread scripts\cp\_utility::func_A030(param_00,level.var_47B1["crafted_revocator"].var_11901);
	thread func_E4B2();
	thread func_E4BA();
	scripts\cp\_utility::func_1861();
	wait(1);
	self setscriptablepartstate("base","idle");
}

//Function Number: 16
func_E4B2()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!var_00 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_00.var_9D81))
		{
			continue;
		}

		self playsound("trap_revocator_pickup");
		var_00 thread func_8329(0,self.var_AC71,self.var_130D2);
		if(isdefined(self.var_3CBF))
		{
			self.var_3CBF delete();
		}

		scripts\cp\_utility::func_E11E();
		self delete();
	}
}

//Function Number: 17
func_E4B8()
{
	self makeunusable();
	scripts\cp\_utility::func_E11E();
}

//Function Number: 18
func_E4BA()
{
	self endon("death");
	var_00 = 0;
	var_01 = 1600;
	while(self.var_130D2 > 0)
	{
		var_02 = scripts\cp\_agent_utils::func_7DAF();
		var_02 = scripts\common\utility::func_782F(self.origin,var_02);
		foreach(var_04 in var_02)
		{
			if(!isdefined(var_04.agent_type))
			{
				continue;
			}

			if(var_04.agent_type == "superslasher" || var_04.agent_type == "slasher" || var_04.agent_type == "zombie_sasquatch" || var_04.agent_type == "lumberjack" || scripts\common\utility::istrue(var_04.is_skeleton))
			{
				continue;
			}

			if(!isdefined(var_04) || !isalive(var_04) || !var_04.entered_playspace || scripts\common\utility::istrue(var_04.var_B36E) || var_04.agent_type == "zombie_brute" || var_04.agent_type == "zombie_grey" || var_04.agent_type == "zombie_ghost" || var_04.team == "allies")
			{
				continue;
			}

			if(distancesquared(self.origin,var_04.origin) < var_01)
			{
				self setscriptablepartstate("base","active");
				if(scripts\common\utility::istrue(var_04.var_9CDD) || scripts\common\utility::istrue(var_04.var_9BB0) || scripts\common\utility::func_6E34("defense_sequence_active") && scripts\common\utility::flag("defense_sequence_active"))
				{
					var_04 dodamage(var_04.health + 50,self.origin);
				}
				else
				{
					var_04 func_1299C(self.var_222);
				}

				self.var_130D2--;
				wait(1);
				self setscriptablepartstate("base","idle");
				if(self.var_130D2 <= 0)
				{
					break;
				}
			}
		}

		wait(0.1);
	}

	self notify("death");
}

//Function Number: 19
func_1299C(param_00)
{
	var_01 = self;
	var_01.team = "allies";
	var_01.var_1F5 = "sprint";
	var_01.var_9CA2 = 1;
	var_01.var_9CEF = 1;
	var_01.maxhealth = 900;
	var_01.health = 900;
	var_01.allowpain = 0;
	var_01 notify("turned");
	if(scripts\common\utility::istrue(var_01.var_152C))
	{
		if(isdefined(var_01.var_C37F))
		{
			var_01.var_15C = var_01.var_C37F;
		}

		var_01.var_C37F = undefined;
		var_01.var_152C = 0;
		var_01.var_EF64 = 0;
	}

	var_01.var_B57A = int(scripts\cp\zombies\zombies_spawning::func_3728("generic_zombie") * 0.5);
	level.spawned_enemies = scripts\common\utility::func_22A9(level.spawned_enemies,var_01);
	level.var_4B6E++;
	level.var_4B95--;
	var_01 setscriptablepartstate("eyes","turned_eyes");
	var_01 setscriptablepartstate("pet","active");
	var_01 thread func_A626(180);
	var_01 thread func_E0B2();
	if(isdefined(param_00))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_turned_zombies");
	}

	func_B2EB(var_01);
}

//Function Number: 20
func_B2EB(param_00)
{
	if(!isdefined(level.var_1299F))
	{
		level.var_1299F = [];
	}

	level.var_1299F[level.var_1299F.size] = param_00;
	if(level.var_1299F.size > 6)
	{
		param_00 = level.var_1299F[0];
		level.var_1299F = scripts\common\utility::func_22A9(level.var_1299F,param_00);
		param_00 dodamage(param_00.health + 100,param_00.origin);
	}
}

//Function Number: 21
func_A626(param_00)
{
	self endon("death");
	while(param_00 > 0)
	{
		wait(1);
		param_00--;
	}

	self dodamage(self.health + 100,self.origin);
}

//Function Number: 22
func_E0B2()
{
	self waittill("death");
	level.var_1299F = scripts\common\utility::func_22A9(level.var_1299F,self);
	scripts\cp\zombies\zombies_spawning::func_4FB8(1);
}