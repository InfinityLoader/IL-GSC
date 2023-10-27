/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_weapon_autosentry.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 1807 ms
 * Timestamp: 10/27/2023 12:10:15 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["sentry_overheat_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_overheat_smoke");
	level._effect["sentry_explode_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_ims_explosion");
	level._effect["sentry_smoke_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
	level.var_F26B = [];
	level.var_F26B["crafted_autosentry"] = spawnstruct();
	level.var_F26B["crafted_autosentry"].health = 999999;
	level.var_F26B["crafted_autosentry"].maxhealth = 300;
	level.var_F26B["crafted_autosentry"].var_32C1 = 20;
	level.var_F26B["crafted_autosentry"].var_32C0 = 40;
	level.var_F26B["crafted_autosentry"].var_C9D3 = 0.15;
	level.var_F26B["crafted_autosentry"].var_C9D1 = 0.25;
	level.var_F26B["crafted_autosentry"].var_F269 = "sentry";
	level.var_F26B["crafted_autosentry"].var_F268 = "sentry_offline";
	level.var_F26B["crafted_autosentry"].var_11901 = 90;
	level.var_F26B["crafted_autosentry"].var_10A13 = 1;
	level.var_F26B["crafted_autosentry"].var_C7FB = 15;
	level.var_F26B["crafted_autosentry"].var_461D = 0.2;
	level.var_F26B["crafted_autosentry"].var_7645 = 0.3;
	level.var_F26B["crafted_autosentry"].var_39B = "alien_sentry_minigun_4_mp";
	level.var_F26B["crafted_autosentry"].var_B91A = "weapon_sentry_chaingun";
	level.var_F26B["crafted_autosentry"].var_B924 = "weapon_sentry_chaingun";
	level.var_F26B["crafted_autosentry"].var_B925 = "weapon_sentry_chaingun_obj_red";
	level.var_F26B["crafted_autosentry"].var_B91D = "weapon_sentry_chaingun_destroyed";
	level.var_F26B["crafted_autosentry"].var_17B = &"COOP_CRAFTABLES_PICKUP";
	level.var_F26B["crafted_autosentry"].var_16F = 1;
	level.var_F26B["crafted_autosentry"].var_13523 = "sentry_destroyed";
	level.var_F26B["crafted_autosentry"].var_9F43 = 0;
}

//Function Number: 2
func_82BA(param_00,param_01)
{
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_autosentry");
	param_01 setclientomnvar("zom_crafted_weapon",1);
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	scripts\cp\_utility::func_F313("crafted_autosentry",::func_82BA,param_01);
}

//Function Number: 3
func_13932()
{
	self endon("disconnect");
	self endon("death");
	self notify("craft_dpad_watcher");
	self endon("craft_dpad_watcher");
	self notifyonplayercommand("pullout_sentry","+actionslot 3");
	for(;;)
	{
		self waittill("pullout_sentry");
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

	thread func_83A3("crafted_autosentry");
}

//Function Number: 4
func_83A3(param_00)
{
	self endon("disconnect");
	self.var_A904 = param_00;
	scripts\cp\_utility::clearlowermessage("msg_power_hint");
	var_01 = func_4A11(param_00,self);
	self.var_A039 = param_00;
	scripts\cp\_utility::func_E077();
	self.var_3AA5 = var_01;
	var_02 = func_F688(var_01,1);
	self.var_3AA5 = undefined;
	thread scripts\cp\_utility::func_1365D();
	self.var_9D81 = 0;
	if(isdefined(var_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_F688(param_00,param_01)
{
	self endon("disconnect");
	if(isdefined(level.forceturretplacement))
	{
		param_01 = 0;
	}

	param_00 func_F255(self,param_01);
	scripts\common\utility::allow_weapon(0);
	self notifyonplayercommand("place_sentry","+attack");
	self notifyonplayercommand("place_sentry","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_sentry","+actionslot 3");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_sentry","+actionslot 5");
		self notifyonplayercommand("cancel_sentry","+actionslot 6");
		self notifyonplayercommand("cancel_sentry","+actionslot 7");
	}

	for(;;)
	{
		var_02 = scripts\common\utility::func_13734("place_sentry","cancel_sentry","force_cancel_placement");
		if(!isdefined(param_00))
		{
			scripts\common\utility::allow_weapon(1);
			return 1;
		}

		if(!isdefined(var_02))
		{
			var_02 = "force_cancel_placement";
		}

		if(var_02 == "cancel_sentry" || var_02 == "force_cancel_placement")
		{
			if(!param_01 && var_02 == "cancel_sentry")
			{
				continue;
			}

			scripts\common\utility::allow_weapon(1);
			param_00 func_F253();
			if(var_02 != "force_cancel_placement")
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

		param_00 func_F259();
		scripts\common\utility::allow_weapon(1);
		return 1;
	}
}

//Function Number: 6
func_4A11(param_00,param_01)
{
	var_02 = spawnturret("misc_turret",param_01.origin,level.var_F26B[param_00].var_39B);
	var_02.angles = param_01.angles;
	var_02.name = "crafted_autosentry";
	var_02 func_F246(param_00,param_01);
	return var_02;
}

//Function Number: 7
func_F246(param_00,param_01)
{
	self.var_F26E = param_00;
	self.var_3872 = 1;
	self setmodel(level.var_F26B[self.var_F26E].var_B91A);
	self.var_10085 = 1;
	self setcandamage(1);
	switch(param_00)
	{
		case "crafted_autosentry":
		default:
			self method_81F5();
			self method_82FB(100);
			self method_8330(100);
			self method_82B6(90);
			self method_8353(60);
			self method_82C9(0.3,"pitch");
			self method_82C9(0.3,"yaw");
			self method_82C8(0.65);
			self method_82D1(-89);
			break;
	}

	self method_835B(1);
	func_F257();
	func_F258(param_01);
	thread func_F242(param_01);
	thread scripts\cp\_utility::func_A030(undefined,level.var_F26B[self.var_F26E].var_11901);
	thread func_F244();
	thread func_F239();
	thread func_F23A();
}

//Function Number: 8
func_F242(param_00)
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	self setmodel(level.var_F26B[self.var_F26E].var_B91D);
	func_F257();
	self method_82D1(40);
	if(isdefined(self.var_3A9D))
	{
		self method_8335(undefined);
	}

	self method_8336(undefined);
	self playsound("sentry_explode");
	if(isdefined(self))
	{
		thread func_F23F();
	}
}

//Function Number: 9
func_F23F()
{
	self notify("sentry_delete_turret");
	self endon("sentry_delete_turret");
	if(isdefined(self.var_9B05))
	{
		playfxontag(scripts\common\utility::getfx("sentry_explode_mp"),self,"tag_origin");
		playfxontag(scripts\common\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
		self.var_9B05 scripts\cp\_utility::func_E2CC();
		self notify("deleting");
		self useby(self.var_9B05);
		wait(1);
	}
	else
	{
		wait(1.5);
		playfxontag(scripts\common\utility::getfx("sentry_explode_mp"),self,"tag_aim");
		playfxontag(scripts\common\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
		self playsound("sentry_explode_smoke");
		wait(0.1);
		self notify("deleting");
	}

	if(isdefined(self.var_A63A))
	{
		self.var_A63A delete();
	}

	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 10
func_F244()
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

		if(scripts\common\utility::istrue(var_00.kung_fu_mode))
		{
			continue;
		}

		var_00 func_F688(self,0);
	}
}

//Function Number: 11
func_F258(param_00)
{
	param_00.var_4BAE = self;
	self.var_222 = param_00;
	self method_8336(self.var_222);
	self.team = self.var_222.team;
	self method_835E(self.team);
	thread scripts\cp\_utility::func_A021("sentry_handleOwner");
}

//Function Number: 12
func_F259()
{
	self setmodel(level.var_F26B[self.var_F26E].var_B91A);
	if(self method_813D() == "manual")
	{
		self method_830F(level.var_F26B[self.var_F26E].var_F268);
	}

	self method_8335(undefined);
	func_F24A();
	self.var_3A9D method_80F3();
	self.var_3A9D = undefined;
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
		if(level.var_F26B[self.var_F26E].var_9F43)
		{
			scripts\cp\_utility::func_B268(self.var_222.team);
		}

		self.var_222 notify("new_sentry",self);
	}

	func_F252();
	self playsound("sentry_gun_plant");
	self method_81D9();
	self notify("placed");
}

//Function Number: 13
func_F253()
{
	self.var_3A9D method_80F3();
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
	}

	self delete();
}

//Function Number: 14
func_F255(param_00,param_01)
{
	self setmodel(level.var_F26B[self.var_F26E].var_B924);
	self method_8335(param_00);
	self setcandamage(0);
	self method_81D8();
	func_F249();
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	param_00 thread func_12F16(self,param_01);
	thread scripts\cp\_utility::func_A025(param_00);
	thread scripts\cp\_utility::func_A026(param_00);
	thread scripts\cp\_utility::func_A027(param_00);
	self method_80F7();
	self method_82D1(-89);
	func_F257();
	self notify("carried");
}

//Function Number: 15
func_12F16(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("placed");
	param_00 endon("death");
	param_00.var_3872 = 1;
	var_02 = -1;
	for(;;)
	{
		param_00.var_3872 = func_3834(param_00);
		if(param_00.var_3872 != var_02)
		{
			if(param_00.var_3872)
			{
				param_00 setmodel(level.var_F26B[param_00.var_F26E].var_B924);
				if(!param_01)
				{
					self method_80F4(&"COOP_CRAFTABLES_PLACE");
				}
				else
				{
					self method_80F4(&"COOP_CRAFTABLES_PLACE_CANCELABLE");
				}
			}
			else
			{
				param_00 setmodel(level.var_F26B[param_00.var_F26E].var_B925);
				self method_80F4(&"COOP_CRAFTABLES_CANNOT_PLACE");
			}
		}

		var_02 = param_00.var_3872;
		wait(0.05);
	}
}

//Function Number: 16
func_3834(param_00)
{
	var_01 = self canplayerplacesentry();
	param_00.origin = var_01["origin"];
	param_00.angles = var_01["angles"];
	if(scripts\cp\_utility::func_65F0(param_00))
	{
		return 0;
	}

	return self isonground() && var_01["result"] && abs(param_00.origin[2] - self.origin[2]) < 10;
}

//Function Number: 17
func_F252()
{
	self method_830F(level.var_F26B[self.var_F26E].var_F269);
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.var_F26B[self.var_F26E].var_17B);
	self makeusable();
	self method_84A5(120);
	self method_84A2(96);
	foreach(var_01 in level.players)
	{
		switch(self.var_F26E)
		{
			case "crafted_autosentry":
				var_02 = self getentitynumber();
				func_1862(var_02,var_01);
				break;
		}
	}
}

//Function Number: 18
func_F257()
{
	self method_830F(level.var_F26B[self.var_F26E].var_F268);
	self makeunusable();
	var_00 = self getentitynumber();
	func_E11F(var_00);
}

//Function Number: 19
func_F24A()
{
	self method_81F7();
}

//Function Number: 20
func_F249()
{
	self method_82C7(0);
}

//Function Number: 21
func_1862(param_00,param_01)
{
	level.var_12A83 = scripts\common\utility::array_add_safe(level.var_12A83,self);
	if(level.var_12A83.size > 4)
	{
		if(isdefined(level.var_12A83[0]))
		{
			level.var_12A83[0] notify("death");
			param_01 playlocalsound("ww_magicbox_laughter");
		}
	}
}

//Function Number: 22
func_E11F(param_00)
{
	level.var_12A83 = scripts\common\utility::func_22A9(level.var_12A83,self);
}

//Function Number: 23
func_F239()
{
	self endon("death");
	level endon("game_ended");
	self.var_B941 = 0;
	self.var_8CDE = 0;
	self.var_C7F9 = 0;
	thread func_F245();
	for(;;)
	{
		scripts\common\utility::waittill_either("turretstatechange","cooled");
		if(self method_81A0())
		{
			thread func_F23B();
			continue;
		}

		func_F25B();
		thread func_F23C();
	}
}

//Function Number: 24
func_F260()
{
	self endon("death");
	self playsound("sentry_gun_target_lock_beep");
	wait(0.19);
	self playsound("sentry_gun_target_lock_beep");
	wait(0.19);
	self playsound("sentry_gun_target_lock_beep");
}

//Function Number: 25
func_F25C()
{
	thread func_F260();
	while(self.var_B941 < level.var_F26B[self.var_F26E].var_10A13)
	{
		self.var_B941 = self.var_B941 + 0.1;
		wait(0.1);
	}
}

//Function Number: 26
func_F25B()
{
	self.var_B941 = 0;
}

//Function Number: 27
func_F23B()
{
	self endon("death");
	self endon("stop_shooting");
	level endon("game_ended");
	func_F25C();
	var_00 = function_0240(level.var_F26B[self.var_F26E].var_39B);
	var_01 = level.var_F26B[self.var_F26E].var_32C1;
	var_02 = level.var_F26B[self.var_F26E].var_32C0;
	var_03 = level.var_F26B[self.var_F26E].var_C9D3;
	var_04 = level.var_F26B[self.var_F26E].var_C9D1;
	for(;;)
	{
		var_05 = randomintrange(var_01,var_02 + 1);
		for(var_06 = 0;var_06 < var_05 && !self.var_C7F9;var_06++)
		{
			self method_837E();
			self notify("bullet_fired");
			self.var_8CDE = self.var_8CDE + var_00;
			wait(var_00);
		}

		wait(randomfloatrange(var_03,var_04));
	}
}

//Function Number: 28
func_F23C()
{
	self notify("stop_shooting");
}

//Function Number: 29
func_12A31(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("player_dismount");
	var_01 = function_0240(level.var_F26B[param_00.var_F26E].var_39B);
	for(;;)
	{
		param_00 waittill("turret_fire");
		param_00 method_8165() notify("turret_fire");
		param_00.var_8CDE = param_00.var_8CDE + var_01;
		param_00.var_4621 = var_01;
	}
}

//Function Number: 30
func_F245()
{
	self endon("death");
	var_00 = function_0240(level.var_F26B[self.var_F26E].var_39B);
	var_01 = 0;
	var_02 = 0;
	var_03 = level.var_F26B[self.var_F26E].var_C7FB;
	var_04 = level.var_F26B[self.var_F26E].var_461D;
	for(;;)
	{
		if(self.var_8CDE != var_01)
		{
			wait(var_00);
		}
		else
		{
			self.var_8CDE = max(0,self.var_8CDE - 0.05);
		}

		if(self.var_8CDE > var_03)
		{
			self.var_C7F9 = 1;
			thread func_D497();
			switch(self.var_F26E)
			{
				case "crafted_autosentry":
					playfxontag(scripts\common\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
					break;
	
				default:
					break;
			}

			while(self.var_8CDE)
			{
				self.var_8CDE = max(0,self.var_8CDE - 0.1);
				wait(0.1);
			}

			self.var_C7F9 = 0;
			self notify("not_overheated");
		}

		var_01 = self.var_8CDE;
		wait(0.05);
	}
}

//Function Number: 31
func_12A00()
{
	self endon("death");
	var_00 = level.var_F26B[self.var_F26E].var_C7FB;
	for(;;)
	{
		if(self.var_8CDE > var_00)
		{
			self.var_C7F9 = 1;
			thread func_D497();
			switch(self.var_F26E)
			{
				case "gl_turret":
					playfxontag(scripts\common\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
					break;
	
				default:
					break;
			}

			while(self.var_8CDE)
			{
				wait(0.1);
			}

			self.var_C7F9 = 0;
			self notify("not_overheated");
		}

		wait(0.05);
	}
}

//Function Number: 32
func_129D7()
{
	self endon("death");
	for(;;)
	{
		if(self.var_8CDE > 0)
		{
			if(self.var_4621 <= 0)
			{
				self.var_8CDE = max(0,self.var_8CDE - 0.05);
			}
			else
			{
				self.var_4621 = max(0,self.var_4621 - 0.05);
			}
		}

		wait(0.05);
	}
}

//Function Number: 33
func_D497()
{
	self endon("death");
	self endon("not_overheated");
	level endon("game_ended");
	self notify("playing_heat_fx");
	self endon("playing_heat_fx");
	for(;;)
	{
		playfxontag(scripts\common\utility::getfx("sentry_overheat_mp"),self,"tag_flash");
		wait(level.var_F26B[self.var_F26E].var_7645);
	}
}

//Function Number: 34
func_D51F()
{
	self endon("death");
	self endon("not_overheated");
	level endon("game_ended");
	for(;;)
	{
		playfxontag(scripts\common\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
		wait(0.4);
	}
}

//Function Number: 35
func_F23A()
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