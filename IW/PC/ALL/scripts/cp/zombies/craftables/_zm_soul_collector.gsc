/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\craftables\_zm_soul_collector.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 792 ms
 * Timestamp: 10/27/2023 12:23:35 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["medusa_death"] = loadfx("vfx/core/base/vfx_alien_soul_fly.vfx");
	level._effect["medusa_crawler_death"] = loadfx("vfx/iw7/core/zombie/vfx_alien_soul_fly_crawler.vfx");
	level._effect["medusa_blast_lg"] = loadfx("vfx/core/base/vfx_alien_cortex_blast_01.vfx");
	level.var_B548 = [];
	var_00 = spawnstruct();
	var_00.var_11901 = 300;
	var_00.var_B91A = "zmb_medusa_energy_collector_01_empty";
	var_00.var_B924 = "zmb_medusa_energy_collector_01_empty";
	var_00.var_B925 = "zmb_medusa_energy_collector_bad";
	var_00.var_17B = &"COOP_CRAFTABLES_PICKUP";
	var_00.var_CC28 = &"COOP_CRAFTABLES_PLACE";
	var_00.var_38E3 = &"COOP_CRAFTABLES_CANNOT_PLACE";
	var_00.var_CC0A = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
	var_00.var_74BF = &"ZOMBIE_CRAFTING_SOUVENIRS_DETONATE";
	var_00.var_9F43 = 0;
	var_00.var_CC22 = 30;
	var_00.var_CC25 = 16;
	var_00.var_3AA7 = (0,0,25);
	var_00.var_3AA6 = (0,0,0);
	level.var_B53A = ::func_65F5;
	level.var_B540 = ::func_A630;
	level.var_B549 = [];
	level.var_B549["crafted_medusa"] = var_00;
}

//Function Number: 2
func_65F5(param_00)
{
	var_01 = 262144;
	if(level.var_B548.size < 1)
	{
		return undefined;
	}

	var_02 = [];
	foreach(var_04 in level.var_B548)
	{
		if(!isdefined(var_04) || var_04.var_74BE)
		{
			continue;
		}

		if(distancesquared(var_04.origin,param_00.origin) < var_01)
		{
			var_02[var_02.size] = var_04;
		}
	}

	if(var_02.size == 0)
	{
		return undefined;
	}

	var_06 = sortbydistance(var_02,param_00.origin);
	return var_06[0];
}

//Function Number: 3
func_A630(param_00,param_01,param_02)
{
	if(param_02)
	{
		var_03 = level._effect["medusa_crawler_death"];
		playfx(var_03,param_00);
	}
	else
	{
		var_03 = level._effect["medusa_death"];
		playfx(var_03,param_00 + (0,0,5));
	}

	scripts\common\utility::func_136F7();
	var_04 = spawn("script_model",param_00 + (0,0,40));
	var_04 setmodel("tag_origin_soultrail");
	if(!isdefined(param_01))
	{
		var_04 delete();
		return;
	}

	var_05 = param_01.origin;
	var_06 = distance(param_00 + (0,0,40),var_05 + (0,0,75));
	var_07 = 350;
	var_08 = var_06 / var_07;
	if(var_08 < 0.05)
	{
		var_08 = 0.05;
	}

	var_04 moveto(param_01 gettagorigin("tag_fx"),var_08);
	var_04 waittill("movedone");
	var_04 setscriptablepartstate("tag","collect");
	wait(0.5);
	var_04 delete();
	if(isdefined(param_01))
	{
		param_01 notify("soul_collected");
	}
}

//Function Number: 4
func_82B8(param_00,param_01)
{
	param_01.var_A039 = "crafted_medusa";
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_medusa");
	param_01 setclientomnvar("zom_crafted_weapon",3);
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	scripts\cp\_utility::func_F313("crafted_medusa",::func_82B8,param_01);
}

//Function Number: 5
func_13932()
{
	self endon("disconnect");
	self endon("death");
	self notify("craft_dpad_watcher");
	self endon("craft_dpad_watcher");
	self notifyonplayercommand("pullout_medusa","+actionslot 3");
	for(;;)
	{
		self waittill("pullout_medusa");
		if(scripts\common\utility::istrue(self.var_9D81))
		{
			continue;
		}

		if(scripts\common\utility::istrue(self.var_AD2C))
		{
			continue;
		}

		if(scripts\cp\_utility::is_valid_player())
		{
			break;
		}
	}

	thread func_837E(1);
}

//Function Number: 6
func_837E(param_00,param_01,param_02)
{
	self endon("disconnect");
	scripts\cp\_utility::clearlowermessage("msg_power_hint");
	var_03 = func_49E8(self);
	scripts\cp\_utility::func_E077();
	self.var_3AA5 = var_03;
	var_04 = func_F685(var_03,param_00,param_01,param_02);
	self.var_3AA5 = undefined;
	thread scripts\cp\_utility::func_1365D();
	self.var_9D81 = 0;
	if(isdefined(var_03))
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
func_F685(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	param_00 func_B543(self,param_01);
	scripts\common\utility::allow_weapon(0);
	self notifyonplayercommand("place_medusa","+attack");
	self notifyonplayercommand("place_medusa","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_medusa","+actionslot 3");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_medusa","+actionslot 5");
		self notifyonplayercommand("cancel_medusa","+actionslot 6");
		self notifyonplayercommand("cancel_medusa","+actionslot 7");
	}

	for(;;)
	{
		var_04 = scripts\common\utility::func_13734("place_medusa","cancel_medusa","force_cancel_placement");
		if(!isdefined(param_00))
		{
			scripts\common\utility::allow_weapon(1);
			return 1;
		}

		if(!isdefined(var_04))
		{
			var_04 = "force_cancel_placement";
		}

		if(var_04 == "cancel_medusa" || var_04 == "force_cancel_placement")
		{
			if(!param_01 && var_04 == "cancel_medusa")
			{
				continue;
			}

			scripts\common\utility::allow_weapon(1);
			param_00 func_B542();
			if(var_04 != "force_cancel_placement")
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

		param_00 func_B545(param_02,param_03,self);
		scripts\common\utility::allow_weapon(1);
		return 1;
	}
}

//Function Number: 8
func_49E8(param_00)
{
	var_01 = spawnturret("misc_turret",param_00.origin + (0,0,25),"sentry_minigun_mp");
	var_01.angles = param_00.angles;
	var_01.var_222 = param_00;
	var_01.name = "crafted_medusa";
	var_01 hide();
	var_01.var_3AA1 = spawn("script_model",var_01.origin + (0,0,25));
	var_01.var_3AA1 setmodel(level.var_B549["crafted_medusa"].var_B91A);
	var_01 method_81F5();
	var_01 method_835B(1);
	var_01 method_830F("sentry_offline");
	var_01 makeunusable();
	var_01 method_8336(param_00);
	var_01 func_B53F(param_00);
	return var_01;
}

//Function Number: 9
func_B53F(param_00)
{
	self.var_3872 = 1;
	func_B544();
}

//Function Number: 10
func_B53C(param_00)
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	func_B544();
	self playsound("sentry_explode");
	if(isdefined(self.var_3CBF))
	{
		self.var_3CBF delete();
	}

	func_E11F();
	if(isdefined(self))
	{
		playfxontag(scripts\common\utility::getfx("sentry_explode_mp"),self,"tag_origin");
		self playsound("sentry_explode_smoke");
		wait(0.1);
		if(isdefined(self))
		{
			self delete();
		}
	}
}

//Function Number: 11
func_B53D()
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

		if(self.var_74BE)
		{
			level thread func_B53B(self.origin,var_00);
			wait(0.6);
		}
		else
		{
			var_00 thread func_837E(0,self.var_AC71,self.var_3CC3);
			self playsound("trap_medusa_pickup");
		}

		if(isdefined(self.var_3CBF))
		{
			self.var_3CBF delete();
		}

		func_E11F();
		self delete();
	}
}

//Function Number: 12
func_B53B(param_00,param_01)
{
	playsoundatpos(param_00,"trap_medusa_explo");
	playfx(level._effect["medusa_blast_lg"],param_00);
	param_01.var_A039 = "crafted_medusa";
	wait(0.5);
	var_02 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_02 = sortbydistance(var_02,param_00);
	foreach(var_04 in var_02)
	{
		if(!isdefined(var_04) || !isdefined(var_04.agent_type))
		{
			continue;
		}

		if(var_04.agent_type == "zombie_grey" || var_04.agent_type == "zombie_ghost" || var_04.agent_type == "zombie_brute")
		{
			continue;
		}

		var_04 dodamage(var_04.health + 1000,var_04.origin);
		wait(0.1);
	}
}

//Function Number: 13
func_B545(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",self.origin + (0,0,0));
	var_03.angles = self.angles;
	var_03.name = "crafted_medusa";
	self.var_3AA1 delete();
	var_03 solid();
	if(!isdefined(param_02.var_B546))
	{
		param_02 iprintlnbold(&"ZOMBIE_CRAFTING_SOUVENIRS_KILL_NEAR_MEDUSA");
		param_02.var_B546 = 1;
	}

	var_04 = "zmb_medusa_energy_collector_01_empty";
	if(!isdefined(param_01))
	{
		var_04 = "zmb_medusa_energy_collector_01_empty";
	}
	else
	{
		if(param_01 > 3)
		{
			var_04 = "zmb_medusa_energy_collector_01_1";
		}

		if(param_01 > 5)
		{
			var_04 = "zmb_medusa_energy_collector_01_2";
		}

		if(param_01 > 7)
		{
			var_04 = "zmb_medusa_energy_collector_01_3";
		}

		if(param_01 > 9)
		{
			var_04 = "zmb_medusa_energy_collector_01";
		}
	}

	var_03 setmodel(var_04);
	self.var_3A9D method_80F3();
	self.var_3A9D = undefined;
	param_02.var_9D81 = 0;
	var_03.var_222 = param_02;
	var_03 thread func_B541(param_00,param_01);
	self notify("placed");
	self delete();
}

//Function Number: 14
func_B542()
{
	self.var_3A9D method_80F3();
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
	}

	self.var_3AA1 delete();
	self delete();
}

//Function Number: 15
func_B543(param_00,param_01)
{
	self setmodel(level.var_B549["crafted_medusa"].var_B924);
	self method_8335(param_00);
	self setcandamage(0);
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	if(param_01)
	{
		self.var_6DEC = 1;
	}

	param_00 thread scripts\cp\_utility::func_12E3F(self,self.var_3AA1,level.var_B549["crafted_medusa"]);
	thread scripts\cp\_utility::func_A025(param_00);
	thread scripts\cp\_utility::func_A026(param_00);
	thread scripts\cp\_utility::func_A027(param_00);
	func_B544();
	self notify("carried");
}

//Function Number: 16
func_B541(param_00,param_01)
{
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.var_B549["crafted_medusa"].var_17B);
	self makeusable();
	self method_84A7("tag_fx");
	self method_84A5(120);
	self method_84A2(96);
	thread func_B53C(self.var_222);
	thread scripts\cp\_utility::func_A021("medusa_handleOwner");
	thread scripts\cp\_utility::func_A030(param_00,level.var_B549["crafted_medusa"].var_11901);
	thread func_B53D();
	thread func_B547();
	self.var_3CC3 = 0;
	self.var_74BE = 0;
	if(isdefined(param_01))
	{
		self.var_3CC3 = param_01;
	}

	if(self.var_3CC3 >= 10)
	{
		self.var_74BE = 1;
		self sethintstring(level.var_B549["crafted_medusa"].var_74BF);
	}

	func_1862();
	if(!self.var_74BE)
	{
		self setscriptablepartstate("base","charge_level_1");
		return;
	}

	self setscriptablepartstate("base","charge_level_2");
}

//Function Number: 17
func_B547()
{
	self endon("death");
	for(;;)
	{
		self waittill("soul_collected");
		self.var_3CC3++;
		var_00 = "zmb_medusa_energy_collector_01_empty";
		if(self.var_3CC3 >= 3)
		{
			var_00 = "zmb_medusa_energy_collector_01_1";
		}

		if(self.var_3CC3 > 5)
		{
			var_00 = "zmb_medusa_energy_collector_01_2";
		}

		if(self.var_3CC3 > 7)
		{
			var_00 = "zmb_medusa_energy_collector_01_3";
		}

		if(self.var_3CC3 > 9)
		{
			var_00 = "zmb_medusa_energy_collector_01";
		}

		if(self.model != var_00)
		{
			self setmodel(var_00);
			if(self.var_3CC3 != 10)
			{
				self setscriptablepartstate("base","charge_level_1");
			}
			else
			{
				self sethintstring(level.var_B549["crafted_medusa"].var_74BF);
				self.var_74BE = 1;
				self setscriptablepartstate("base","charge_level_2");
			}

			self makeusable();
			self method_84A7("tag_fx");
			self method_84A5(120);
			self method_84A2(96);
		}
	}
}

//Function Number: 18
func_B544()
{
	self makeunusable();
	func_E11F();
}

//Function Number: 19
func_1862(param_00)
{
	level.var_B548 = scripts\common\utility::array_add_safe(level.var_B548,self);
	scripts\cp\_utility::func_1861();
}

//Function Number: 20
func_E11F(param_00)
{
	level.var_B548 = scripts\common\utility::func_22A9(level.var_B548,self);
	scripts\cp\_utility::func_E11E();
}

//Function Number: 21
func_B539()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(3);
		if(!isdefined(self.var_3A9D))
		{
			self playsound("sentry_gun_beep");
		}
	}
}