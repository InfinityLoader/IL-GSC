/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\crafted_trap_mower.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 1392 ms
 * Timestamp: 10/27/2023 12:10:25 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["electric_trap_idle"] = loadfx("vfx/iw7/_requests/coop/generator_idle.vfx");
	level._effect["electric_trap_attack"] = loadfx("vfx/iw7/core/zombie/vfx_electrap_shock_beam.vfx");
	level._effect["electric_trap_shock"] = loadfx("vfx/iw7/core/zombie/traps/electric_trap/vfx_zmb_hit_shock.vfx");
	level._effect["mower_spray"] = loadfx("vfx/iw7/core/zombie/rave/mower_spray.vfx");
	level._effect["mower_blade"] = loadfx("vfx/iw7/core/zombie/rave/mower_blade.vfx");
	var_00 = spawnstruct();
	var_00.var_11901 = 90;
	var_00.var_B91A = "cp_rave_equipment_lawnmower_01";
	var_00.var_B924 = "tag_origin";
	var_00.var_B925 = "tag_origin";
	var_00.var_17B = &"COOP_CRAFTABLES_PICKUP";
	var_00.var_9F43 = 0;
	var_00.var_17B = &"COOP_CRAFTABLES_PICKUP";
	var_00.var_CC28 = &"CP_RAVE_MOWER_PLACEMENT";
	var_00.var_38E3 = &"COOP_CRAFTABLES_CANNOT_PLACE";
	var_00.var_CC0A = &"CP_RAVE_PLACE_CANCELABLE";
	var_00.var_CC22 = 48;
	var_00.var_CC25 = 32;
	var_00.var_3AA7 = (0,0,35);
	var_00.var_3AA6 = (90,270,90);
	if(!isdefined(level.var_47B3))
	{
		level.var_47B3 = [];
	}

	level.var_47B3["crafted_trap_mower"] = var_00;
}

//Function Number: 2
func_82BB(param_00,param_01)
{
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_trap_mower");
	param_01 setclientomnvar("zom_crafted_weapon",10);
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	scripts\cp\_utility::func_F313("crafted_trap_mower",::func_82BB,param_01);
}

//Function Number: 3
func_13932()
{
	self endon("disconnect");
	self endon("death");
	self notify("craft_dpad_watcher");
	self endon("craft_dpad_watcher");
	self notifyonplayercommand("pullout_trap","+actionslot 3");
	for(;;)
	{
		self waittill("pullout_trap");
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

	thread func_8342(1);
}

//Function Number: 4
func_8342(param_00,param_01)
{
	self endon("disconnect");
	scripts\cp\_utility::clearlowermessage("msg_power_hint");
	var_02 = func_4A2A(self);
	self.var_A039 = var_02.name;
	func_E152();
	self.var_3AA5 = var_02;
	if(param_00)
	{
		var_02.var_6DEC = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = level.var_47B3["crafted_trap_mower"].var_11901;
	}

	var_03 = func_F68A(var_02,param_00,param_01);
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
func_F68A(param_00,param_01,param_02)
{
	self endon("disconnect");
	param_00 func_126A8(self,param_01,param_02);
	self.switch_to_weapon_after_mower = scripts\cp\_utility::getvalidtakeweapon();
	self giveweapon("iw7_lawnmower_zm");
	self switchtoweapon("iw7_lawnmower_zm");
	scripts\common\utility::func_1C76(0);
	self notifyonplayercommand("place_trap","+attack");
	self notifyonplayercommand("place_trap","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_trap","+actionslot 3");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_trap","+actionslot 5");
		self notifyonplayercommand("cancel_trap","+actionslot 6");
		self notifyonplayercommand("cancel_trap","+actionslot 7");
	}

	for(;;)
	{
		var_03 = scripts\common\utility::func_13734("place_trap","cancel_trap","force_cancel_placement");
		if(!isdefined(param_00))
		{
			scripts\common\utility::func_1C76(1);
			self takeweapon("iw7_lawnmower_zm");
			self switchtoweapon(self.switch_to_weapon_after_mower);
			return 1;
		}

		if(!isdefined(var_03))
		{
			var_03 = "force_cancel_placement";
		}

		if(var_03 == "cancel_trap" || var_03 == "force_cancel_placement")
		{
			if(!param_01 && var_03 == "cancel_trap")
			{
				continue;
			}

			self takeweapon("iw7_lawnmower_zm");
			self.var_3AA5.var_3A9B playsound("craftable_lawn_mower_end");
			scripts\common\utility::func_1C76(1);
			if(!scripts\cp\_laststand::player_in_laststand(self))
			{
				self switchtoweapon(self.switch_to_weapon_after_mower);
			}

			if(scripts\common\utility::istrue(self.var_55E1))
			{
				scripts\common\utility::func_1C67(1);
			}

			self.customweaponspeedscalar = 1;
			scripts\cp\maps\cp_rave\cp_rave::cp_rave_updatemovespeedscale();
			param_00 func_126A7();
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

		param_00 func_126AA(param_02,self);
		if(scripts\common\utility::istrue(self.var_55E1))
		{
			scripts\common\utility::func_1C67(1);
		}

		self.customweaponspeedscalar = 1;
		scripts\cp\maps\cp_rave\cp_rave::cp_rave_updatemovespeedscale();
		self takeweapon("iw7_lawnmower_zm");
		scripts\common\utility::func_1C76(1);
		self switchtoweapon(self.switch_to_weapon_after_mower);
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
func_4A2A(param_00)
{
	var_01 = spawnturret("misc_turret",param_00.origin + (0,0,40),"sentry_minigun_mp");
	var_01.angles = param_00.angles;
	var_01.var_222 = param_00;
	var_01.name = "crafted_trap_mower";
	var_01.var_3A9B = spawn("script_model",var_01.origin);
	var_01.var_3A9B.angles = param_00.angles;
	var_01 method_81F5();
	var_01 method_835B(1);
	var_01 method_830F("sentry_offline");
	var_01 makeunusable();
	var_01 method_8336(param_00);
	var_01 func_126A2(param_00);
	return var_01;
}

//Function Number: 12
func_126A2(param_00)
{
	self.var_3872 = 1;
}

//Function Number: 13
func_126A0(param_00)
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	func_126A9();
	self playsound("sentry_explode");
	scripts\cp\_utility::func_E11E();
	if(isdefined(self))
	{
		playfx(scripts\common\utility::getfx("sentry_explode_mp"),self.origin);
		self playsound("sentry_explode_smoke");
		wait(0.1);
		if(isdefined(self))
		{
			if(isdefined(self.var_3A9B))
			{
				self.var_3A9B delete();
			}

			self delete();
		}
	}
}

//Function Number: 14
func_126A1()
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

		var_00 thread func_8342(0,self.var_AC71);
		if(isdefined(self.var_3CBF))
		{
			self.var_3CBF delete();
		}

		playsoundatpos(self.origin,"craftable_lawn_mower_end");
		scripts\cp\_utility::func_E11E();
		self delete();
	}
}

//Function Number: 15
delayfx()
{
	self endon("death");
	wait(1);
	playfxontag(level._effect["mower_blade"],self,"tag_fx");
}

//Function Number: 16
func_126AA(param_00,param_01)
{
	var_02 = spawn("script_model",self.origin + (0,0,10));
	var_02.angles = self.angles + (0,0,-15);
	var_02 solid();
	var_02 setmodel(level.var_47B3["crafted_trap_mower"].var_B91A);
	self.var_3A9D method_80F3();
	self.var_3A9D = undefined;
	var_02.repulsor = function_0277("mower_repulsor",0,var_02.origin,32,1);
	param_01.var_9D81 = 0;
	var_02.var_222 = param_01;
	var_02.name = "crafted_trap_mower";
	var_02 thread delayfx();
	if(isdefined(self.var_3A9B.timeused))
	{
		if(isdefined(param_00))
		{
			param_00 = param_00 - self.var_3A9B.timeused;
			if(param_00 < 1)
			{
				param_00 = 1;
			}
		}
	}

	var_02 thread func_126A6(param_00);
	self notify("placed");
	self.var_3A9B delete();
	self delete();
}

//Function Number: 17
func_126A7()
{
	self.var_3A9D method_80F3();
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
	}

	if(isdefined(self.repulsor))
	{
		function_0278(self.repulsor);
	}

	self.var_3A9B delete();
	self delete();
}

//Function Number: 18
func_126A8(param_00,param_01,param_02)
{
	self method_8335(param_00);
	self setcandamage(0);
	self stoploopsound();
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	param_00 thread scripts\cp\_utility::func_12E3F(self,self.var_3A9B,level.var_47B3["crafted_trap_mower"]);
	thread scripts\cp\_utility::func_A025(param_00);
	thread scripts\cp\_utility::func_A026(param_00);
	thread scripts\cp\_utility::func_A027(param_00);
	param_00 thread adswatcher(self.var_3A9B,param_02,param_01);
	func_126A9();
	self notify("carried");
}

//Function Number: 19
adswatcher(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("placed");
	param_00 endon("death");
	var_03 = gettime();
	param_00.timeused = 0;
	var_04 = 0;
	if(scripts\common\utility::istrue(param_02))
	{
		param_00 playsound("craftable_lawn_mower_start");
	}

	param_00 playloopsound("craftable_lawn_mower_lp");
	var_05 = gettime();
	for(;;)
	{
		wait(0.05);
		param_00.timeused = param_00.timeused + 0.05;
		if(self adsbuttonpressed(1))
		{
			if(var_03 <= gettime())
			{
				param_00 stoploopsound();
				self earthquakeforplayer(0.23,1,self.origin,128);
				self playrumbleonentity("heavy_3s");
				param_00 playsound("craftable_lawn_mower_high_start");
				param_00 playloopsound("craftable_lawn_mower_high_lp");
				var_03 = gettime() + 30000;
				param_00.timeused = param_00.timeused + 0.05;
				if(isdefined(param_01))
				{
					if(param_01 - param_00.timeused <= 0)
					{
						param_00 method_83AD();
						playfx(scripts\common\utility::getfx("sentry_explode_mp"),param_00.origin);
						param_00 playsound("sentry_explode_smoke");
						wait(0.5);
						self notify("force_cancel_placement");
						return;
					}
				}
			}
			else
			{
				self earthquakeforplayer(0.23,0.25,self.origin,128);
				if(isdefined(param_01))
				{
					param_00.timeused = param_00.timeused + 0.05;
					if(param_01 - param_00.timeused <= 0)
					{
						param_00 method_83AD();
						playfx(scripts\common\utility::getfx("sentry_explode_mp"),param_00.origin);
						param_00 playsound("sentry_explode_smoke");
						wait(0.5);
						self notify("force_cancel_placement");
						return;
					}
				}
			}

			if(!var_04)
			{
				if(scripts\common\utility::istrue(self.var_55E1))
				{
					scripts\common\utility::func_1C67(0);
				}

				self.customweaponspeedscalar = 0.5;
				scripts\cp\maps\cp_rave\cp_rave::cp_rave_updatemovespeedscale();
				var_04 = 1;
			}

			var_06 = scripts\common\utility::getclosest(self.origin,level.spawned_enemies,64);
			if(!isdefined(var_06))
			{
				continue;
			}

			if(scripts\common\utility::func_13D90(self.origin,self.angles,var_06.origin,cos(75)))
			{
				var_06.nocorpse = 1;
				var_06.var_180 = 1;
				var_06.full_gib = 1;
				if(gettime() > var_05)
				{
					self earthquakeforplayer(0.35,1.5,var_06.origin,128);
					self playrumbleonentity("heavy_1s");
					self setscriptablepartstate("mower_death","on");
					var_05 = gettime() + 1000;
				}

				var_06.disable_armor = 1;
				var_07 = var_06.health + 100;
				if(isdefined(var_06.is_skeleton))
				{
					param_00.timeused = param_00.timeused + 15;
				}
				else if(isdefined(var_06.agent_type))
				{
					if(var_06.agent_type == "zombie_sasquatch")
					{
						param_00.timeused = param_00.timeused + 15;
					}
					else if(var_06.agent_type == "lumberjack")
					{
						param_00.timeused = param_00.timeused + 20;
					}
					else if(var_06.agent_type == "slasher" || var_06.agent_type == "superslasher")
					{
						var_07 = 0;
					}
				}

				if(var_07 > 0)
				{
					var_06.shared_damage_points = 1;
					var_06 dodamage(var_06.health + 100,param_00.origin,self,self,"MOD_MELEE","iw7_lawnmower_zm");
				}
			}

			continue;
		}

		if(!isdefined(param_01))
		{
			param_01 = level.var_47B3["crafted_trap_mower"].var_AC71;
		}

		if(param_01 - param_00.timeused <= 0)
		{
			param_00 method_83AD();
			playfx(scripts\common\utility::getfx("sentry_explode_mp"),param_00.origin);
			param_00 playsound("sentry_explode_smoke");
			self notify("force_cancel_placement");
			wait(0.5);
			return;
		}

		var_03 = 0;
		if(var_04)
		{
			if(scripts\common\utility::istrue(self.var_55E1))
			{
				scripts\common\utility::func_1C67(1);
			}

			self.customweaponspeedscalar = 1;
			scripts\cp\maps\cp_rave\cp_rave::cp_rave_updatemovespeedscale();
			var_04 = 0;
			param_00 playsound("craftable_lawn_mower_high_end");
			param_00 stoploopsound();
			param_00 playloopsound("craftable_lawn_mower_lp");
		}
	}
}

//Function Number: 20
func_126A6(param_00)
{
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.var_47B3["crafted_trap_mower"].var_17B);
	self makeusable();
	self method_84A7("tag_fx");
	self method_84A5(120);
	self method_84A2(96);
	thread func_126A0(self.var_222);
	thread scripts\cp\_utility::func_A021("electrap_handleOwner");
	thread scripts\cp\_utility::func_A030(param_00,level.var_47B3["crafted_trap_mower"].var_11901);
	thread func_126A1();
	thread trap_grind_enemies();
	scripts\cp\_utility::func_1861();
}

//Function Number: 21
func_126A9()
{
	self makeunusable();
	if(isdefined(self.repulsor))
	{
		function_0278(self.repulsor);
	}

	if(isdefined(self.dmg_trigger))
	{
		self.dmg_trigger notify("stop_dmg");
		self.dmg_trigger delete();
	}

	if(isdefined(self.var_FB2F))
	{
		self.var_FB2F stoploopsound();
		self.var_FB2F delete();
	}

	scripts\cp\_utility::func_E11E();
}

//Function Number: 22
trap_grind_enemies()
{
	self endon("death");
	wait(1);
	var_00 = anglestoup(self.angles) * -1;
	self.dmg_trigger = spawn("trigger_radius",self.origin + var_00 * 35,0,35,45);
	self.dmg_trigger.angles = var_00;
	self.dmg_trigger thread func_A631(self.var_222,self);
}

//Function Number: 23
func_A631(param_00,param_01)
{
	self endon("stop_dmg");
	self endon("death");
	param_01 endon("death");
	for(;;)
	{
		self waittill("trigger",var_02);
		if(!scripts\cp\_utility::func_FF18(var_02) || isdefined(var_02.flung))
		{
			continue;
		}

		if(var_02.agent_type == "slasher" || var_02.agent_type == "superslasher" || var_02.agent_type == "zombie_sasquatch" || var_02.agent_type == "zombie_lumberjack")
		{
			continue;
		}

		if(isdefined(var_02.is_skeleton))
		{
			continue;
		}

		var_02.flung = 1;
		var_02 thread release_zombie_on_trap_death(param_01);
		level thread func_111B0(var_02,param_00,param_01);
	}
}

//Function Number: 24
release_zombie_on_trap_death(param_00)
{
	self endon("death");
	param_00 waittill("death");
	self.var_EF64 = 0;
	self.nocorpse = undefined;
	self.flung = undefined;
	self.var_180 = 0;
	if(isdefined(self.anchor))
	{
		self.anchor delete();
	}
}

//Function Number: 25
func_111B0(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_02 endon("death");
	param_00.var_EF64 = 1;
	param_00.nocorpse = 1;
	param_00.var_180 = 1;
	param_00.anchor = spawn("script_origin",param_00.origin);
	param_00.anchor.angles = param_00.angles;
	param_00 linkto(param_00.anchor);
	param_00.anchor moveto(param_02.origin + (0,0,-10),0.15);
	wait(0.15);
	playfx(level._effect["woodchipper_entry"],param_00.origin,anglestoforward((0,0,0)),anglestoup((0,0,0)));
	param_00.anchor delete();
	param_00.disable_armor = 1;
	level thread woodchipper_spray(param_02);
	if(isdefined(param_01))
	{
		param_00 dodamage(param_00.health + 100,param_02.origin,param_01,param_01,"MOD_UNKNOWN","iw7_lawnmower_zm");
		return;
	}

	param_00 dodamage(param_00.health + 100,param_02.origin,undefined,undefined,"MOD_UNKNOWN","iw7_lawnmower_zm");
}

//Function Number: 26
woodchipper_spray(param_00)
{
	param_00 endon("death");
	if(scripts\common\utility::istrue(param_00.spraying))
	{
		return;
	}

	param_00.spraying = 1;
	param_00 setscriptablepartstate("guts","grind");
	wait(3);
	if(isdefined(param_00))
	{
		param_00.spraying = 0;
	}
}