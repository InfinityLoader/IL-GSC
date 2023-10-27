/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_autosentry.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 88
 * Decompile Time: 3928 ms
 * Timestamp: 10/27/2023 12:28:12 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_F26E = [];
	level.var_F26E["sentry_minigun"] = "sentry";
	level.var_F26E["sam_turret"] = "sam_turret";
	level.var_F26E["super_trophy"] = "super_trophy";
	level.var_F26E["sentry_shock"] = "sentry_shock";
	scripts\mp\killstreaks\_killstreaks::func_DEFB("sentry_shock",::func_12902);
	scripts\mp\_killstreak_loot::func_DF07("sentry_shock",["passive_extra_health","passive_increased_duration"]);
	level.var_F26B = [];
	level.var_F26B["super_trophy"] = spawnstruct();
	level.var_F26B["super_trophy"].health = 999999;
	level.var_F26B["super_trophy"].maxhealth = 100;
	level.var_F26B["super_trophy"].var_F269 = "sentry";
	level.var_F26B["super_trophy"].var_F268 = "sentry_offline";
	level.var_F26B["super_trophy"].var_39B = "sentry_laser_mp";
	level.var_F26B["super_trophy"].var_B91A = "super_trophy_mp";
	level.var_F26B["super_trophy"].var_B920 = "super_trophy_mp_placement";
	level.var_F26B["super_trophy"].var_B919 = "super_trophy_mp_placement_fail";
	level.var_F26B["super_trophy"].var_B91D = "super_trophy_mp";
	level.var_F26B["super_trophy"].var_17B = &"SENTRY_PICKUP";
	level.var_F26B["super_trophy"].var_16F = 1;
	level.var_F26B["super_trophy"].var_115EB = "used_super_trophy";
	level.var_F26B["super_trophy"].var_10085 = 0;
	level.var_F26B["super_trophy"].var_ACB6 = "tag_fx";
	level.var_F26B["sentry_shock"] = spawnstruct();
	level.var_F26B["sentry_shock"].health = 999999;
	level.var_F26B["sentry_shock"].maxhealth = 670;
	level.var_F26B["sentry_shock"].var_32C1 = 20;
	level.var_F26B["sentry_shock"].var_32C0 = 120;
	level.var_F26B["sentry_shock"].var_C9D3 = 0.15;
	level.var_F26B["sentry_shock"].var_C9D1 = 0.35;
	level.var_F26B["sentry_shock"].var_F269 = "sentry";
	level.var_F26B["sentry_shock"].var_F268 = "sentry_offline";
	level.var_F26B["sentry_shock"].var_11901 = 90;
	level.var_F26B["sentry_shock"].var_10A13 = 0.05;
	level.var_F26B["sentry_shock"].var_C7FB = 8;
	level.var_F26B["sentry_shock"].var_461D = 0.1;
	level.var_F26B["sentry_shock"].var_7645 = 0.3;
	level.var_F26B["sentry_shock"].var_110EA = "sentry_shock";
	level.var_F26B["sentry_shock"].var_39B = "sentry_shock_mp";
	level.var_F26B["sentry_shock"].var_289 = "ks_shock_sentry_mp";
	level.var_F26B["sentry_shock"].var_B91A = "shock_sentry_gun_wm";
	level.var_F26B["sentry_shock"].var_B920 = "shock_sentry_gun_wm_obj";
	level.var_F26B["sentry_shock"].var_B919 = "shock_sentry_gun_wm_obj_red";
	level.var_F26B["sentry_shock"].var_B91D = "shock_sentry_gun_wm_destroyed";
	level.var_F26B["sentry_shock"].var_17B = &"SENTRY_PICKUP";
	level.var_F26B["sentry_shock"].var_16F = 1;
	level.var_F26B["sentry_shock"].var_115EB = "used_shock_sentry";
	level.var_F26B["sentry_shock"].destroyedsplash = "callout_destroyed_sentry_shock";
	level.var_F26B["sentry_shock"].var_10085 = 1;
	level.var_F26B["sentry_shock"].var_13554 = "sentry_shock_timeout";
	level.var_F26B["sentry_shock"].var_13523 = "sentry_shock_destroy";
	level.var_F26B["sentry_shock"].var_EC44 = "destroyed_sentry";
	level.var_F26B["sentry_shock"].var_ACB6 = "tag_fx";
	level.var_F26B["sentry_shock"].var_9E63 = 1;
	level.var_F26B["sentry_shock"].var_8C7A = (0,0,75);
	level._effect["sentry_overheat_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_overheat_smoke");
	level._effect["sentry_explode_mp"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp_lg.vfx");
	level._effect["sentry_sparks_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion");
	level._effect["sentry_smoke_mp"] = loadfx("vfx/iw7/_requests/mp/vfx_gen_equip_dam_spark_runner.vfx");
	level._effect["sentry_shock_charge"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_charge_up.vfx");
	level._effect["sentry_shock_screen"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_screen");
	level._effect["sentry_shock_base"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_base");
	level._effect["sentry_shock_radius"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_radius");
	level._effect["sentry_shock_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_end.vfx");
	level._effect["sentry_shock_trail"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_proj_trail.vfx");
	level._effect["sentry_shock_arc"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_arc.vfx");
	var_00 = ["passive_fast_sweep","passive_decreased_health","passive_sam_turret","passive_no_shock","passive_mini_explosives","passive_slow_turret"];
	scripts\mp\_killstreak_loot::func_DF07("sentry_shock",var_00);
}

//Function Number: 2
func_128D9(param_00,param_01)
{
	var_02 = func_83A3("sentry_minigun");
	if(var_02)
	{
		scripts\mp\_matchdata::func_AFC9(level.var_F26B["sentry_minigun"].var_110EA,self.origin);
	}

	return var_02;
}

//Function Number: 3
func_12901(param_00,param_01)
{
	var_02 = func_83A3("sam_turret");
	if(var_02)
	{
		scripts\mp\_matchdata::func_AFC9(level.var_F26B["sam_turret"].var_110EA,self.origin);
	}

	return var_02;
}

//Function Number: 4
func_12902(param_00)
{
	var_01 = func_83A3("sentry_shock",undefined,param_00);
	if(var_01)
	{
		scripts\mp\_matchdata::func_AFC9(param_00.var_110EA,self.origin);
	}
	else
	{
		scripts\common\utility::func_136F7();
	}

	return var_01;
}

//Function Number: 5
func_83A3(param_00,param_01,param_02)
{
	self.var_A904 = param_00;
	if(!isdefined(self.var_CC14))
	{
		self.var_CC14 = [];
	}

	if(!isdefined(self.var_CC14[param_00]))
	{
		self.var_CC14[param_00] = [];
	}

	var_03 = 1;
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	var_04 = func_4A11(param_00,self,var_03,param_02);
	if(isdefined(param_02))
	{
		param_02.var_F265 = var_04;
	}

	func_E152();
	self.var_3AA5 = var_04;
	var_05 = func_F688(var_04,1,var_03);
	self.var_3AA5 = undefined;
	thread func_1370F();
	self.var_9D81 = 0;
	if(isdefined(var_04))
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
func_F688(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("disconnect");
	param_00 func_F255(self,param_02,param_03);
	scripts\common\utility::func_1C6E(0);
	func_1CB4(0);
	scripts\common\utility::func_1C53(0);
	if(!isai(self))
	{
		self notifyonplayercommand("place_sentry","+attack");
		self notifyonplayercommand("place_sentry","+attack_akimbo_accessible");
		self notifyonplayercommand("cancel_sentry","+actionslot 4");
		if(!level.console)
		{
			self notifyonplayercommand("cancel_sentry","+actionslot 5");
			self notifyonplayercommand("cancel_sentry","+actionslot 6");
			self notifyonplayercommand("cancel_sentry","+actionslot 7");
		}
	}

	for(;;)
	{
		var_04 = scripts\common\utility::func_13734("place_sentry","cancel_sentry","force_cancel_placement","apply_player_emp");
		if(!isdefined(param_00))
		{
			func_1CB4(1);
			scripts\common\utility::func_1C6E(1);
			thread func_6270();
			return 1;
		}

		if(var_04 == "cancel_sentry" || var_04 == "force_cancel_placement" || var_04 == "apply_player_emp")
		{
			if(!param_01 && var_04 == "cancel_sentry" || var_04 == "apply_player_emp")
			{
				continue;
			}

			param_00 func_F253(var_04 == "force_cancel_placement" && !isdefined(param_00.var_6DEC));
			return 0;
		}

		if(!param_00.var_3872)
		{
			continue;
		}

		param_00 func_F259(param_02);
		return 1;
	}
}

//Function Number: 7
func_6270()
{
	self endon("death");
	self endon("disconnect");
	wait(0.25);
	scripts\common\utility::func_1C53(1);
}

//Function Number: 8
func_E18E()
{
	if(self hasweapon("iw6_riotshield_mp"))
	{
		self.var_E2E6 = "iw6_riotshield_mp";
		scripts\mp\_utility::func_141E("iw6_riotshield_mp");
	}
}

//Function Number: 9
func_E152()
{
	if(scripts\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.var_E2DF = "specialty_explosivebullets";
		scripts\mp\_utility::func_E150("specialty_explosivebullets");
	}
}

//Function Number: 10
func_E2E8()
{
	if(isdefined(self.var_E2E6))
	{
		scripts\mp\_utility::func_12C6(self.var_E2E6);
		self.var_E2E6 = undefined;
	}
}

//Function Number: 11
func_E2E0()
{
	if(isdefined(self.var_E2DF))
	{
		scripts\mp\_utility::func_8387(self.var_E2DF);
		self.var_E2DF = undefined;
	}
}

//Function Number: 12
func_1370F()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_E2E0();
}

//Function Number: 13
func_4A11(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_F26B[param_00].var_39B;
	if(scripts\mp\killstreaks\_utility::func_A69F(param_03,"passive_fast_sweep"))
	{
		var_04 = "sentry_shock_fast_mp";
	}

	var_05 = spawnturret("misc_turret",param_01.origin,var_04);
	var_05.angles = param_01.angles;
	var_05.var_110E8 = param_03;
	var_05 func_F246(param_00,param_01,param_02);
	var_05 thread sentry_destroyongameend();
	return var_05;
}

//Function Number: 14
func_F246(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	self.var_F26E = param_00;
	self.var_3872 = 1;
	self setmodel(level.var_F26B[param_00].var_B91A);
	self method_8318(1);
	self method_8317(1);
	if(level.var_F26B[param_00].var_10085)
	{
		self.var_10085 = 1;
	}
	else
	{
		self.var_10085 = 0;
	}

	self.var_6DEC = 1;
	self setcandamage(1);
	switch(param_00)
	{
		case "gl_turret_4":
		case "gl_turret_3":
		case "gl_turret_2":
		case "gl_turret_1":
		case "gl_turret":
		case "minigun_turret_4":
		case "minigun_turret_3":
		case "minigun_turret_2":
		case "minigun_turret_1":
		case "minigun_turret":
			self method_82FB(80);
			self method_8330(80);
			self method_82B6(50);
			self method_82D1(0);
			self.var_C731 = param_01;
			break;

		case "scramble_turret":
		case "sam_turret":
			self method_81F5();
			self method_82FB(180);
			self method_8330(180);
			self method_8353(80);
			self method_82D1(-89);
			self.var_A86B = 0;
			var_04 = spawn("script_model",self gettagorigin("tag_laser"));
			var_04 linkto(self);
			self.var_A63A = var_04;
			self.var_A63A setscriptmoverkillcam("explosive");
			break;

		case "sentry_shock":
			self method_81F5();
			var_05 = anglestoforward(self.angles);
			var_06 = self gettagorigin("tag_laser") + (0,0,10);
			var_06 = var_06 - var_05 * 20;
			var_04 = spawn("script_model",var_06);
			var_04 linkto(self);
			self.var_A63A = var_04;
			break;

		default:
			self method_81F5();
			self method_82D1(-89);
			break;
	}

	self method_835B(1);
	func_F257();
	func_F258(param_01);
	if(param_03)
	{
		thread func_F261();
	}

	switch(param_00)
	{
		case "minigun_turret_4":
		case "minigun_turret_3":
		case "minigun_turret_2":
		case "minigun_turret_1":
		case "minigun_turret":
			self.var_B941 = 0;
			self.var_8CDE = 0;
			self.var_C7F9 = 0;
			thread func_F245();
			break;

		case "gl_turret_4":
		case "gl_turret_3":
		case "gl_turret_2":
		case "gl_turret_1":
		case "gl_turret":
			self.var_B941 = 0;
			self.var_8CDE = 0;
			self.var_4621 = 0;
			self.var_C7F9 = 0;
			thread func_12A00();
			thread func_129D7();
			break;

		case "scramble_turret":
		case "sam_turret":
		case "sentry_shock":
			self.var_B941 = 0;
			thread func_F244(param_02);
			thread func_F23A();
			break;

		case "super_trophy":
			thread func_F244(0);
			thread func_F23A();
			break;

		default:
			thread func_F244(param_02);
			thread func_F239();
			thread func_F23A();
			break;
	}
}

//Function Number: 15
func_F23E(param_00)
{
	if(isdefined(level.var_F26B[param_00].var_B91C))
	{
		var_01 = spawn("script_model",self.origin);
		var_01.angles = self.angles;
		var_01 hide();
		var_01 thread scripts\mp\_weapons::func_2C69(self.var_222);
		var_01 setmodel(level.var_F26B[param_00].var_B91C);
		var_01 linkto(self);
		var_01 method_82C7(0);
		self.var_2C68 = var_01;
		self waittill("death");
		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}
}

//Function Number: 16
sentry_setteamheadicon()
{
	var_00 = level.var_F26B[self.var_F26E].var_8C7A;
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(self.var_222))
	{
		return;
	}

	var_01 = self.var_222;
	var_02 = var_01.team;
	if(level.teambased && !scripts\mp\_utility::func_9FB3(self.var_115D1))
	{
		scripts\mp\_entityheadicons::func_F877(var_02,var_00);
		self.var_115D1 = 1;
		return;
	}

	if(!scripts\mp\_utility::func_9FB3(self.var_D3AA))
	{
		scripts\mp\_entityheadicons::func_F7F2(var_01,var_00);
		self.var_D3AA = 1;
	}
}

//Function Number: 17
sentry_clearteamheadicon()
{
	var_00 = level.var_F26B[self.var_F26E].var_8C7A;
	if(!isdefined(var_00))
	{
		return;
	}

	if(scripts\mp\_utility::func_9FB3(self.var_115D1))
	{
		scripts\mp\_entityheadicons::func_F877("none",(0,0,0));
		self.var_115D1 = undefined;
	}

	if(scripts\mp\_utility::func_9FB3(self.var_D3AA))
	{
		scripts\mp\_entityheadicons::func_F7F2(undefined,(0,0,0));
		self.var_D3AA = undefined;
	}
}

//Function Number: 18
sentry_destroyongameend()
{
	self endon("death");
	level scripts\common\utility::waittill_any_3("bro_shot_start","game_ended");
	self notify("death");
}

//Function Number: 19
func_F241()
{
	self endon("carried");
	var_00 = level.var_F26B[self.var_F26E].maxhealth;
	if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_fast_sweep"))
	{
		var_00 = int(var_00 / 1.25);
	}

	var_01 = 0;
	if(self.var_222 scripts\mp\_utility::_hasperk("specialty_rugged_eqp"))
	{
		var_02 = self.var_13C2E;
		if(isdefined(var_02))
		{
			switch(var_02)
			{
				default:
					break;
			}
		}
	}

	var_00 = var_00 + int(var_01);
	scripts\mp\_damage::func_B9C6(var_00,"sentry",::func_F266,::func_F26A,1);
}

//Function Number: 20
func_F26A(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	if(param_02 == "MOD_MELEE")
	{
		var_05 = self.maxhealth * 0.34;
	}

	var_05 = scripts\mp\killstreaks\_utility::func_7FBD(param_00,param_01,param_02,var_05,self.maxhealth,2,3,4);
	if(isdefined(param_00) && isplayer(param_00) && lib_0DF8::func_9DDF(param_00))
	{
		var_05 = 0;
	}

	return var_05;
}

//Function Number: 21
func_F266(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_F26B[self.var_F26E];
	if(var_04.var_9E63)
	{
		if(isdefined(param_01) && param_01 == "concussion_grenade_mp")
		{
			if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,param_00)))
			{
				param_00 scripts\mp\_missions::func_D991("ch_tactical_emp_eqp");
			}
		}

		var_05 = var_04.destroyedsplash;
		var_06 = scripts\mp\_killstreak_loot::getrarityforlootitem(self.var_110E8.var_1318B);
		if(var_06 != "")
		{
			var_05 = var_05 + "_" + var_06;
		}

		var_07 = scripts\mp\_damage::func_C548(var_04.var_110EA,param_00,param_01,param_02,param_03,var_04.var_EC44,var_04.var_13523,var_05);
		if(var_07)
		{
			param_00 notify("destroyed_equipment");
			return;
		}

		return;
	}

	var_08 = undefined;
	var_09 = param_00;
	if(isdefined(var_09) && isdefined(self.var_222))
	{
		if(isdefined(param_00.var_222) && isplayer(param_00.var_222))
		{
			var_09 = param_00.var_222;
		}

		if(self.var_222 scripts\mp\_utility::func_9DD6(var_09))
		{
			var_08 = var_09;
		}
	}

	if(isdefined(var_08))
	{
		var_08 thread scripts\mp\_events::func_11265(self.var_222);
		var_08 notify("destroyed_equipment");
	}

	self notify("death");
}

//Function Number: 22
func_F263()
{
	self endon("carried");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01,var_02,var_03,var_04);
		scripts\mp\killstreaks\_utility::dodamagetokillstreak(100,var_00,var_00,self.team,var_02,var_04,var_03);
		if(!scripts\mp\_utility::func_9FB3(self.var_55BA))
		{
			thread disablesentry(var_01);
		}
	}
}

//Function Number: 23
disablesentry(param_00)
{
	self endon("carried");
	self endon("death");
	level endon("game_ended");
	self.var_55BA = 1;
	scripts\mp\_weapons::func_11061();
	self method_82D1(40);
	self method_830F(level.var_F26B[self.var_F26E].var_F268);
	self method_807E();
	self setscriptablepartstate("coil","neutral");
	self setscriptablepartstate("muzzle","neutral",0);
	self setscriptablepartstate("stunned","active");
	sentry_clearteamheadicon();
	scripts\mp\_hostmigration::func_13708(param_00);
	self method_82D1(-89);
	self method_830F(level.var_F26B[self.var_F26E].var_F269);
	thread scripts\mp\_weapons::func_57EB(level.var_F26B[self.var_F26E].var_ACB6);
	self setscriptablepartstate("coil","idle");
	self setscriptablepartstate("stunned","neutral");
	sentry_setteamheadicon();
	self.var_55BA = undefined;
}

//Function Number: 24
func_F242()
{
	self endon("carried");
	self waittill("death");
	if(isdefined(self.var_222))
	{
		self.var_222.var_CC14[self.var_F26E] = scripts\common\utility::func_22A9(self.var_222.var_CC14[self.var_F26E],self);
	}

	if(!isdefined(self))
	{
		return;
	}

	self method_807E();
	self method_81D8();
	self setmodel(level.var_F26B[self.var_F26E].var_B91D);
	if(isdefined(self.var_7627) && self.var_7627.size > 0)
	{
		foreach(var_01 in self.var_7627)
		{
			if(isdefined(var_01))
			{
				var_01 delete();
			}
		}

		self.var_7627 = undefined;
	}

	func_F257();
	self method_82D1(40);
	self method_8336(undefined);
	if(isdefined(self.var_9B05))
	{
		self useby(self.var_9B05);
	}

	self method_835A(0);
	if(isdefined(self.var_C840))
	{
		self.var_C840 delete();
	}

	self playsound("mp_equip_destroyed");
	switch(self.var_F26E)
	{
		case "gl_turret":
		case "minigun_turret":
			self.var_72B5 = 1;
			self method_83C6();
			break;

		default:
			break;
	}

	if(isdefined(self.var_9B05))
	{
		playfxontag(scripts\common\utility::getfx("sentry_explode_mp"),self,"tag_origin");
		playfxontag(scripts\common\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
		self.var_9B05.var_12A1A scripts\mp\_hud_util::destroyelem();
		self.var_9B05 func_E2E0();
		self.var_9B05 func_E2E8();
		self notify("deleting");
		wait(1);
		stopfxontag(scripts\common\utility::getfx("sentry_explode_mp"),self,"tag_origin");
		stopfxontag(scripts\common\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
	}
	else
	{
		self playsound("sentry_explode_smoke");
		self setscriptablepartstate("destroyed","sparks");
		wait(5);
		playfx(scripts\common\utility::getfx("sentry_explode_mp"),self.origin + (0,0,10));
		self notify("deleting");
	}

	scripts\mp\_weapons::func_66A8();
	if(isdefined(self.var_A63A))
	{
		self.var_A63A delete();
	}

	if(isdefined(self.airlookatent))
	{
		self.airlookatent delete();
	}

	scripts\mp\_utility::func_D915("killstreak ended - shock_sentry",self.var_222);
	self delete();
}

//Function Number: 25
func_F244(param_00)
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_01);
		if(!scripts\mp\_utility::func_9F19(var_01))
		{
			continue;
		}

		if(self.var_F26E == "sam_turret" || self.var_F26E == "scramble_turret" || self.var_F26E == "sentry_shock" && scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_sam_turret"))
		{
			self method_830F(level.var_F26B[self.var_F26E].var_F268);
		}

		var_01.var_CC14[self.var_F26E] = scripts\common\utility::func_22A9(var_01.var_CC14[self.var_F26E],self);
		var_01 func_F688(self,0,param_00);
	}
}

//Function Number: 26
func_129FD(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	if(!isdefined(param_00.var_C840))
	{
		return;
	}

	var_01 = 0;
	for(;;)
	{
		if(isalive(self) && self istouching(param_00.var_C840) && !isdefined(param_00.var_9B05) && !isdefined(param_00.var_3A9D) && self isonground())
		{
			if(self usebuttonpressed())
			{
				if(isdefined(self.var_13107) && self.var_13107)
				{
					continue;
				}

				var_01 = 0;
				while(self usebuttonpressed())
				{
					var_01 = var_01 + 0.05;
					wait(0.05);
				}

				if(var_01 >= 0.5)
				{
					continue;
				}

				var_01 = 0;
				while(!self usebuttonpressed() && var_01 < 0.5)
				{
					var_01 = var_01 + 0.05;
					wait(0.05);
				}

				if(var_01 >= 0.5)
				{
					continue;
				}

				if(!scripts\mp\_utility::func_9F19(self))
				{
					continue;
				}

				if(isdefined(self.var_13107) && self.var_13107)
				{
					continue;
				}

				param_00 method_830F(level.var_F26B[param_00.var_F26E].var_F268);
				thread func_F688(param_00,0);
				param_00.var_C840 delete();
				return;
			}
		}

		wait(0.05);
	}
}

//Function Number: 27
func_129FF()
{
	self notify("turret_handluse");
	self endon("turret_handleuse");
	self endon("deleting");
	level endon("game_ended");
	self.var_72B5 = 0;
	var_00 = (1,0.9,0.7);
	var_01 = (1,0.65,0);
	var_02 = (1,0.25,0);
	for(;;)
	{
		self waittill("trigger",var_03);
		if(isdefined(self.var_3A9D))
		{
			continue;
		}

		if(isdefined(self.var_9B05))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9F19(var_03))
		{
			continue;
		}

		var_03 func_E152();
		var_03 func_E18E();
		self.var_9B05 = var_03;
		self method_830F(level.var_F26B[self.var_F26E].var_F268);
		func_F258(var_03);
		self method_830F(level.var_F26B[self.var_F26E].var_F269);
		var_03 thread func_12A31(self);
		var_03.var_12A1A = var_03 scripts\mp\_hud_util::createbar(var_00,100,6);
		var_03.var_12A1A scripts\mp\_hud_util::setpoint("CENTER","BOTTOM",0,-70);
		var_03.var_12A1A.alpha = 0.65;
		var_03.var_12A1A.bar.alpha = 0.65;
		var_04 = 0;
		for(;;)
		{
			if(!scripts\mp\_utility::func_9F19(var_03))
			{
				self.var_9B05 = undefined;
				var_03.var_12A1A scripts\mp\_hud_util::destroyelem();
				break;
			}

			if(!var_03 isusingturret())
			{
				self notify("player_dismount");
				self.var_9B05 = undefined;
				var_03.var_12A1A scripts\mp\_hud_util::destroyelem();
				var_03 func_E2E0();
				var_03 func_E2E8();
				self sethintstring(level.var_F26B[self.var_F26E].var_17B);
				self method_830F(level.var_F26B[self.var_F26E].var_F268);
				func_F258(self.var_C731);
				self method_830F(level.var_F26B[self.var_F26E].var_F269);
				break;
			}

			if(self.var_8CDE >= level.var_F26B[self.var_F26E].var_C7FB)
			{
				var_05 = 1;
			}
			else
			{
				var_05 = self.var_8CDE / level.var_F26B[self.var_F26E].var_C7FB;
			}

			var_03.var_12A1A scripts\mp\_hud_util::updatebar(var_05);
			if(scripts\common\utility::string_starts_with(self.var_F26E,"minigun_turret"))
			{
				var_06 = "minigun_turret";
			}

			if(self.var_72B5 || self.var_C7F9)
			{
				self method_83C6();
				var_03.var_12A1A.bar.color = var_02;
				var_04 = 0;
			}
			else if(self.var_8CDE > level.var_F26B[self.var_F26E].var_C7FB * 0.75 && scripts\common\utility::string_starts_with(self.var_F26E,"minigun_turret"))
			{
				var_03.var_12A1A.bar.color = var_01;
				if(randomintrange(0,10) < 6)
				{
					self method_83C7();
				}
				else
				{
					self method_83C6();
				}

				if(!var_04)
				{
					var_04 = 1;
					thread func_D497();
				}
			}
			else
			{
				var_03.var_12A1A.bar.color = var_00;
				self method_83C7();
				var_04 = 0;
				self notify("not_overheated");
			}

			wait(0.05);
		}

		self method_82D1(0);
	}
}

//Function Number: 28
func_F243()
{
	self endon("death");
	level endon("game_ended");
	self notify("sentry_handleOwner");
	self endon("sentry_handleOwner");
	self.var_222 waittill("killstreak_disowned");
	self notify("death");
}

//Function Number: 29
func_F258(param_00)
{
	self.var_222 = param_00;
	self method_8336(self.var_222);
	self method_835A(1,self.var_F26E);
	if(level.teambased)
	{
		self.team = self.var_222.team;
		self method_835E(self.team);
	}

	thread func_F243();
}

//Function Number: 30
func_F24B(param_00)
{
	self notify("death");
}

//Function Number: 31
func_F259(param_00)
{
	if(isdefined(self.var_222))
	{
		var_01 = self.var_222.var_CC14[self.var_F26E].size;
		self.var_222.var_CC14[self.var_F26E][var_01] = self;
		if(var_01 + 1 > 2)
		{
			self.var_222.var_CC14[self.var_F26E][0] notify("death");
		}

		self.var_222 func_1CB4(1);
		self.var_222 scripts\common\utility::func_1C6E(1);
		self.var_222 thread func_6270();
		self.var_222 method_85BD(1);
	}

	var_02 = level.var_F26B[self.var_F26E].var_B91A;
	var_03 = scripts\mp\_killstreak_loot::getrarityforlootitem(self.var_110E8.var_1318B);
	if(var_03 != "")
	{
		var_02 = var_02 + "_" + var_03;
	}

	self setmodel(var_02);
	if(self method_813D() == "manual")
	{
		self method_830F(level.var_F26B[self.var_F26E].var_F268);
	}

	if(self.var_F26E == "sentry_shock")
	{
		self setscriptablepartstate("coil","idle");
	}

	thread func_F241();
	thread func_F242();
	self method_8335(undefined);
	self setcandamage(1);
	switch(self.var_F26E)
	{
		case "gl_turret_4":
		case "gl_turret_3":
		case "gl_turret_2":
		case "gl_turret_1":
		case "gl_turret":
		case "minigun_turret_4":
		case "minigun_turret_3":
		case "minigun_turret_2":
		case "minigun_turret_1":
		case "minigun_turret":
			if(param_00)
			{
				self.angles = self.var_3A9D.angles;
				if(isalive(self.var_C731))
				{
					self.var_C731 scripts\mp\_utility::setlowermessage("pickup_hint",level.var_F26B[self.var_F26E].var_C837,3,undefined,undefined,undefined,undefined,undefined,1);
				}
	
				self.var_C840 = spawn("trigger_radius",self.origin + (0,0,1),0,105,64);
				self.var_C840 enablelinkto();
				self.var_C840 linkto(self);
				self.var_C731 thread func_129FD(self);
				thread func_129FF();
			}
			break;

		default:
			break;
	}

	func_F24A();
	if(isdefined(self.var_2C68))
	{
		self.var_2C68 show();
		level notify("update_bombsquad");
	}

	self.var_3A9D method_80F3();
	self.var_3A9D = undefined;
	self.var_6DEC = undefined;
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
		self.var_222 notify("new_sentry",self);
	}

	func_F252(param_00);
	var_04 = spawnstruct();
	if(isdefined(self.var_BD3B))
	{
		var_04.var_AD39 = self.var_BD3B;
	}

	var_04.var_6371 = "carried";
	var_04.var_4E53 = ::func_F24B;
	thread scripts\mp\_movers::func_892F(var_04);
	if(self.var_F26E != "multiturret")
	{
		self playsound("sentry_gun_plant");
	}

	thread scripts\mp\_weapons::func_57EB(level.var_F26B[self.var_F26E].var_ACB6);
	self notify("placed");
}

//Function Number: 32
func_F253(param_00)
{
	if(isdefined(self.var_3A9D))
	{
		var_01 = self.var_3A9D;
		var_01 method_80F3();
		var_01.var_9D81 = undefined;
		var_01.var_3AA0 = undefined;
		var_01 func_1CB4(1);
		var_01 scripts\common\utility::func_1C6E(1);
		var_01 thread func_6270();
		var_01 method_85BD(1);
		if(isdefined(self.var_2C68))
		{
			self.var_2C68 delete();
		}
	}

	if(isdefined(param_00) && param_00)
	{
		scripts\mp\_weapons::func_66A8();
	}

	self delete();
}

//Function Number: 33
func_F255(param_00,param_01,param_02)
{
	if(isdefined(self.var_C731))
	{
	}
	else
	{
	}

	if(self.var_F26E == "sentry_shock")
	{
		self setscriptablepartstate("coil","neutral");
		self setscriptablepartstate("muzzle","neutral",0);
	}

	self setmodel(level.var_F26B[self.var_F26E].var_B920);
	self method_8335(param_00);
	self setcandamage(0);
	func_F249();
	param_00 method_85BD(0);
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	self.var_CB40 = param_01;
	thread sentry_oncarrierdeathoremp(param_00,param_02);
	param_00 thread func_12F16(self);
	thread func_F24E(param_00);
	thread func_F24C(param_00);
	thread func_F24F();
	self method_82D1(-89);
	func_F257();
	if(isdefined(self getlinkedparent()))
	{
		self unlink();
	}

	self notify("carried");
	if(isdefined(self.var_2C68))
	{
		self.var_2C68 hide();
	}
}

//Function Number: 34
func_12F16(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("placed");
	param_00 endon("death");
	param_00.var_3872 = 1;
	var_01 = -1;
	for(;;)
	{
		var_02 = self canplayerplacesentry(1,40);
		param_00.origin = var_02["origin"];
		param_00.angles = var_02["angles"];
		var_03 = scripts\common\utility::array_combine(level.var_12A83,level.var_B726,level.var_11267.var_12801,level.var_B779);
		var_04 = param_00 getistouchingentities(var_03);
		param_00.var_3872 = self isonground() && var_02["result"] && abs(param_00.origin[2] - self.origin[2]) < 30 && !scripts\mp\_utility::func_9FAE(self) && var_04.size == 0;
		if(isdefined(var_02["entity"]))
		{
			param_00.var_BD3B = var_02["entity"];
		}
		else
		{
			param_00.var_BD3B = undefined;
		}

		if(param_00.var_3872 != var_01)
		{
			if(param_00.var_3872)
			{
				param_00 setmodel(level.var_F26B[param_00.var_F26E].var_B920);
				param_00 func_CC1B();
			}
			else
			{
				param_00 setmodel(level.var_F26B[param_00.var_F26E].var_B919);
				param_00 func_38E2();
			}
		}

		var_01 = param_00.var_3872;
		wait(0.05);
	}
}

//Function Number: 35
sentry_oncarrierdeathoremp(param_00,param_01)
{
	self endon("placed");
	self endon("death");
	param_00 endon("disconnect");
	param_00 scripts\common\utility::waittill_any_3("death","apply_player_emp");
	if(self.var_3872 && !scripts\mp\_utility::func_9FB3(param_01))
	{
		func_F259(self.var_CB40);
		return;
	}

	func_F253(0);
}

//Function Number: 36
func_F24E(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("disconnect");
	self delete();
}

//Function Number: 37
func_F24C(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 scripts\common\utility::waittill_any_3("joined_team","joined_spectators");
	self delete();
}

//Function Number: 38
func_F24F(param_00)
{
	self endon("placed");
	self endon("death");
	level waittill("game_ended");
	self delete();
}

//Function Number: 39
func_F252(param_00)
{
	self method_830F(level.var_F26B[self.var_F26E].var_F269);
	if(param_00)
	{
		self setcursorhint("HINT_NOICON");
		self sethintstring(level.var_F26B[self.var_F26E].var_17B);
		self makeusable();
	}

	sentry_setteamheadicon();
	foreach(var_02 in level.players)
	{
		switch(self.var_F26E)
		{
			case "gl_turret_4":
			case "gl_turret_3":
			case "gl_turret_2":
			case "gl_turret_1":
			case "gl_turret":
			case "minigun_turret_4":
			case "minigun_turret_3":
			case "minigun_turret_2":
			case "minigun_turret_1":
			case "minigun_turret":
				if(param_00)
				{
					self enableplayeruse(var_02);
				}
				break;

			default:
				scripts\mp\killstreaks\_utility::func_1843(self.var_F26E,"Killstreak_Ground",self.var_222,1,"carried");
				if(var_02 == self.var_222 && param_00)
				{
					self enableplayeruse(var_02);
				}
				else
				{
					self disableplayeruse(var_02);
				}
				break;
		}
	}

	var_04 = level.var_F26B[self.var_F26E].var_115EB;
	var_05 = scripts\mp\_killstreak_loot::getrarityforlootitem(self.var_110E8.var_1318B);
	if(var_05 != "")
	{
		var_04 = var_04 + "_" + var_05;
	}

	if(self.var_10085)
	{
		level thread scripts\mp\_utility::func_115DE(var_04,self.var_222);
		self.var_10085 = 0;
	}

	if(self.var_F26E == "sam_turret")
	{
		thread func_EB09();
	}

	if(self.var_F26E == "scramble_turret")
	{
		thread func_ECA3();
	}

	if(self.var_F26E == "sentry_shock")
	{
		thread func_F26D();
	}

	thread func_F263();
}

//Function Number: 40
func_F257()
{
	self method_830F(level.var_F26B[self.var_F26E].var_F268);
	self makeunusable();
	scripts\mp\_weapons::func_11061();
	sentry_clearteamheadicon();
}

//Function Number: 41
func_F24A()
{
	self method_81F7();
}

//Function Number: 42
func_F249()
{
	self method_82C7(0);
}

//Function Number: 43
func_9E0A(param_00)
{
	if(level.teambased && self.team == param_00.team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 44
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

//Function Number: 45
func_F261()
{
	self endon("death");
	level endon("game_ended");
	var_00 = level.var_F26B[self.var_F26E].var_11901;
	if(isdefined(var_00) && var_00 == 0)
	{
		return;
	}

	while(var_00)
	{
		wait(1);
		scripts\mp\_hostmigration::func_13834();
		if(!isdefined(self.var_3A9D))
		{
			var_00 = max(0,var_00 - 1);
		}
	}

	if(isdefined(self.var_222))
	{
		if(isdefined(level.var_F26B[self.var_F26E].var_13554))
		{
			self.var_222 scripts\mp\_utility::func_D4B6(level.var_F26B[self.var_F26E].var_13554,undefined,undefined,self.var_222.origin);
		}
	}

	self notify("death");
}

//Function Number: 46
func_F260()
{
	self endon("death");
	self playsound("sentry_gun_beep");
	wait(0.1);
	self playsound("sentry_gun_beep");
	wait(0.1);
	self playsound("sentry_gun_beep");
}

//Function Number: 47
func_F25C()
{
	thread func_F260();
	while(self.var_B941 < level.var_F26B[self.var_F26E].var_10A13)
	{
		self.var_B941 = self.var_B941 + 0.1;
		wait(0.1);
	}
}

//Function Number: 48
func_F25B()
{
	self.var_B941 = 0;
}

//Function Number: 49
func_F248()
{
	self endon("death");
	self endon("stop_shooting");
	level endon("game_ended");
	func_F25C();
	var_00 = function_0240(level.var_F26B[self.var_F26E].var_39B);
	var_01 = level.var_F26B[self.var_F26E].var_32C1;
	var_02 = level.var_F26B[self.var_F26E].var_32C0;
	if(isdefined(self.var_112C5) && self.var_112C5)
	{
		var_00 = 0.05;
		var_03 = 50;
	}
	else
	{
		var_01 = 0.5 / self.var_AD80.size + 1;
		var_03 = var_02;
	}

	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_05 = self method_8166(1);
		if(!isdefined(var_05))
		{
			break;
		}

		self method_837E();
		wait(var_00);
	}

	self notify("doneFiring");
	self method_807E();
}

//Function Number: 50
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

//Function Number: 51
func_F23C()
{
	self notify("stop_shooting");
}

//Function Number: 52
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
		param_00.var_8CDE = param_00.var_8CDE + var_01;
		param_00.var_4621 = var_01;
	}
}

//Function Number: 53
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
				case "minigun_turret_4":
				case "minigun_turret_3":
				case "minigun_turret_2":
				case "minigun_turret_1":
				case "minigun_turret":
					playfxontag(scripts\common\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
					break;
	
				default:
					break;
			}

			while(self.var_8CDE)
			{
				self.var_8CDE = max(0,self.var_8CDE - var_04);
				wait(0.1);
			}

			self.var_C7F9 = 0;
			self notify("not_overheated");
		}

		var_01 = self.var_8CDE;
		wait(0.05);
	}
}

//Function Number: 54
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

//Function Number: 55
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

//Function Number: 56
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

//Function Number: 57
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

//Function Number: 58
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

//Function Number: 59
func_EB09()
{
	self endon("carried");
	self endon("death");
	level endon("game_ended");
	self.var_EB19 = undefined;
	self.var_EB16 = [];
	for(;;)
	{
		self.var_EB19 = func_EB08();
		func_EB0C();
		wait(0.05);
	}
}

//Function Number: 60
func_EB08()
{
	var_00 = self gettagorigin("tag_laser");
	if(!isdefined(self.var_EB19))
	{
		if(level.teambased)
		{
			var_01 = [];
			if(level.multiteambased)
			{
				foreach(var_03 in level.teamnamelist)
				{
					if(var_03 != self.team)
					{
						foreach(var_05 in level.var_12AF3[var_03])
						{
							var_01[var_01.size] = var_05;
						}
					}
				}
			}
			else
			{
				var_01 = level.var_12AF3[level.var_C74B[self.team]];
			}

			foreach(var_09 in var_01)
			{
				if(isdefined(var_09.var_9E78) && var_09.var_9E78)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_09.origin,0,self))
				{
					return var_09;
				}
			}

			foreach(var_0C in level.var_AD8B)
			{
				if(isdefined(var_0C.team) && var_0C.team == self.team)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_0C.origin,0,self))
				{
					return var_0C;
				}
			}

			foreach(var_0F in level.var_8DD3)
			{
				if(isdefined(var_0F.team) && var_0F.team == self.team)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_0F.origin,0,self))
				{
					return var_0F;
				}
			}

			foreach(var_09 in level.var_DF74)
			{
				if(!isdefined(var_09))
				{
					continue;
				}

				if(isdefined(var_09.team) && var_09.team == self.team)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_09.origin,0,self,var_09))
				{
					return var_09;
				}
			}
		}
		else
		{
			foreach(var_09 in level.var_12AF3)
			{
				if(isdefined(var_09.var_9E78) && var_09.var_9E78)
				{
					continue;
				}

				if(isdefined(var_09.var_222) && isdefined(self.var_222) && var_09.var_222 == self.var_222)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_09.origin,0,self))
				{
					return var_09;
				}
			}

			foreach(var_0C in level.var_AD8B)
			{
				if(isdefined(var_0C.var_222) && isdefined(self.var_222) && var_0C.var_222 == self.var_222)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_0C.origin,0,self))
				{
					return var_0C;
				}
			}

			foreach(var_0F in level.var_8DD3)
			{
				if(isdefined(var_0F.var_222) && isdefined(self.var_222) && var_0F.var_222 == self.var_222)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_0F.origin,0,self))
				{
					return var_0F;
				}
			}

			foreach(var_09 in level.var_DF74)
			{
				if(!isdefined(var_09))
				{
					continue;
				}

				if(isdefined(var_09.var_222) && isdefined(self.var_222) && var_09.var_222 == self.var_222)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_09.origin,0,self,var_09))
				{
					return var_09;
				}
			}
		}

		self method_807E();
		return undefined;
	}

	if(!sighttracepassed(var_0F,self.var_EB19.origin,0,self))
	{
		self method_807E();
		return undefined;
	}

	return self.var_EB19;
}

//Function Number: 61
func_EB0C()
{
	if(isdefined(self.var_EB19))
	{
		if(self.var_EB19 == level.var_1537.var_CC44 && !isdefined(level.var_1541))
		{
			self.var_EB19 = undefined;
			self method_807E();
			return;
		}

		self method_8347(self.var_EB19);
		self waittill("turret_on_target");
		if(!isdefined(self.var_EB19))
		{
			return;
		}

		if(!self.var_A86B)
		{
			thread func_EB0E();
			thread func_EB0D();
			thread func_EB0F();
			thread func_EB10();
		}

		wait(2);
		if(!isdefined(self.var_EB19))
		{
			return;
		}

		if(self.var_EB19 == level.var_1537.var_CC44 && !isdefined(level.var_1541))
		{
			self.var_EB19 = undefined;
			self method_807E();
			return;
		}

		var_00 = [];
		var_00[0] = self gettagorigin("tag_le_missile1");
		var_00[1] = self gettagorigin("tag_le_missile2");
		var_00[2] = self gettagorigin("tag_ri_missile1");
		var_00[3] = self gettagorigin("tag_ri_missile2");
		var_01 = self.var_EB16.size;
		for(var_02 = 0;var_02 < 4;var_02++)
		{
			if(!isdefined(self.var_EB19))
			{
				return;
			}

			if(isdefined(self.var_3A9D))
			{
				return;
			}

			self method_837E();
			var_03 = scripts\mp\_utility::func_1309("sam_projectile_mp",var_00[var_02],self.var_EB19.origin,self.var_222);
			var_03 missile_settargetent(self.var_EB19);
			var_03 missile_setflightmodedirect();
			var_03.var_EB1A = self;
			var_03.var_EB15 = var_01;
			self.var_EB16[var_01][var_02] = var_03;
			level notify("sam_missile_fired",self.var_222,var_03,self.var_EB19);
			if(var_02 == 3)
			{
				break;
			}

			wait(0.25);
		}

		level notify("sam_fired",self.var_222,self.var_EB16[var_01],self.var_EB19);
		wait(3);
	}
}

//Function Number: 62
func_EB10()
{
	level endon("game_ended");
	self endon("death");
	while(isdefined(self.var_EB19) && isdefined(self method_8166(1)) && self method_8166(1) == self.var_EB19)
	{
		var_00 = self gettagorigin("tag_laser");
		if(!sighttracepassed(var_00,self.var_EB19.origin,0,self,self.var_EB19))
		{
			self method_807E();
			self.var_EB19 = undefined;
			break;
		}

		wait(0.05);
	}
}

//Function Number: 63
func_EB0E()
{
	self endon("death");
	self method_81D9();
	self.var_A86B = 1;
	while(isdefined(self.var_EB19) && isdefined(self method_8166(1)) && self method_8166(1) == self.var_EB19)
	{
		wait(0.05);
	}

	self method_81D8();
	self.var_A86B = 0;
}

//Function Number: 64
func_EB0D()
{
	self endon("death");
	self.var_EB19 endon("death");
	if(!isdefined(self.var_EB19.var_8DD9))
	{
		return;
	}

	self.var_EB19 waittill("crashing");
	self method_807E();
	self.var_EB19 = undefined;
}

//Function Number: 65
func_EB0F()
{
	self endon("death");
	self.var_EB19 endon("death");
	if(!isdefined(self.var_EB19.model))
	{
		return;
	}

	if(self.var_EB19.model == "vehicle_uav_static_mp")
	{
		self.var_EB19 waittill("leaving");
		self method_807E();
		self.var_EB19 = undefined;
	}
}

//Function Number: 66
func_ECA3()
{
	self endon("carried");
	self endon("death");
	level endon("game_ended");
	self.var_ECA1 = undefined;
	for(;;)
	{
		self.var_ECA1 = func_EC96();
		if(isdefined(self.var_ECA1) && isdefined(self.var_ECA1.var_EC9B) && !self.var_ECA1.var_EC9B)
		{
			func_ECA0();
		}

		wait(0.05);
	}
}

//Function Number: 67
func_EC96()
{
	return func_EB08();
}

//Function Number: 68
func_ECA0()
{
	if(isdefined(self.var_ECA1))
	{
		if(self.var_ECA1 == level.var_1537.var_CC44 && !isdefined(level.var_1541))
		{
			self.var_ECA1 = undefined;
			self method_807E();
			return;
		}

		self method_8347(self.var_ECA1);
		self waittill("turret_on_target");
		if(!isdefined(self.var_ECA1))
		{
			return;
		}

		if(!self.var_A86B)
		{
			thread func_EC98();
			thread func_EC97();
			thread func_EC99();
			thread func_EC9A();
		}

		wait(2);
		if(!isdefined(self.var_ECA1))
		{
			return;
		}

		if(self.var_ECA1 == level.var_1537.var_CC44 && !isdefined(level.var_1541))
		{
			self.var_ECA1 = undefined;
			self method_807E();
			return;
		}

		if(!isdefined(self.var_ECA1))
		{
			return;
		}

		if(isdefined(self.var_3A9D))
		{
			return;
		}

		self method_837E();
		thread func_F82E();
		self notify("death");
	}
}

//Function Number: 69
func_F82E()
{
	var_00 = self.var_ECA1;
	var_00 notify("scramble_fired",self.var_222);
	var_00 endon("scramble_fired");
	var_00 endon("death");
	var_00 thread scripts\mp\killstreaks\_helicopter::func_8D99();
	var_00.var_EC9B = 1;
	var_00.var_F0C5 = self.var_222;
	var_00 notify("findNewTarget");
	wait(30);
	if(isdefined(var_00))
	{
		var_00.var_EC9B = 0;
		var_00.var_F0C5 = undefined;
		var_00 thread scripts\mp\killstreaks\_helicopter::func_8D99();
	}
}

//Function Number: 70
func_EC9A()
{
	level endon("game_ended");
	self endon("death");
	while(isdefined(self.var_ECA1) && isdefined(self method_8166(1)) && self method_8166(1) == self.var_ECA1)
	{
		var_00 = self gettagorigin("tag_laser");
		if(!sighttracepassed(var_00,self.var_ECA1.origin,0,self,self.var_ECA1))
		{
			self method_807E();
			self.var_ECA1 = undefined;
			break;
		}

		wait(0.05);
	}
}

//Function Number: 71
func_EC98()
{
	self endon("death");
	self method_81D9();
	self.var_A86B = 1;
	while(isdefined(self.var_ECA1) && isdefined(self method_8166(1)) && self method_8166(1) == self.var_ECA1)
	{
		wait(0.05);
	}

	self method_81D8();
	self.var_A86B = 0;
}

//Function Number: 72
func_EC97()
{
	self endon("death");
	self.var_ECA1 endon("death");
	if(!isdefined(self.var_ECA1.var_8DD9))
	{
		return;
	}

	self.var_ECA1 waittill("crashing");
	self method_807E();
	self.var_ECA1 = undefined;
}

//Function Number: 73
func_EC99()
{
	self endon("death");
	self.var_ECA1 endon("death");
	if(!isdefined(self.var_ECA1.model))
	{
		return;
	}

	if(self.var_ECA1.model == "vehicle_uav_static_mp")
	{
		self.var_ECA1 waittill("leaving");
		self method_807E();
		self.var_ECA1 = undefined;
	}
}

//Function Number: 74
func_F26D()
{
	self endon("death");
	self endon("carried");
	level endon("game_ended");
	thread func_13B37();
	self.airlookatent = scripts\common\utility::spawn_tag_origin(self.origin,self.angles);
	self.airlookatent linkto(self,"tag_flash");
	for(;;)
	{
		var_00 = scripts\common\utility::waittill_any_timeout_1(1,"turret_on_target");
		if(var_00 == "timeout")
		{
			if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_sam_turret"))
			{
				self.sentryshocksamtarget = thread searchforshocksentryairtarget();
				if(isdefined(self.sentryshocksamtarget))
				{
					thread shootshocksentrysamtarget(self.sentryshocksamtarget,self.airlookatent);
					self waittill("done_firing");
				}
			}

			continue;
		}

		self.var_F26C = self method_8166(1);
		if(isdefined(self.var_F26C) && scripts\mp\_utility::func_9F19(self.var_F26C))
		{
			thread func_FE4F(self.var_F26C);
			self waittill("done_firing");
		}
	}
}

//Function Number: 75
searchforshocksentryairtarget()
{
	if(isdefined(level.var_12AF3))
	{
		if(level.teambased)
		{
			foreach(var_01 in level.var_12AF3[scripts\mp\_utility::getotherteam(self.var_222.team)])
			{
				if(targetvisibleinfront(var_01))
				{
					return var_01;
				}
			}
		}
		else
		{
			foreach(var_01 in level.var_12AF3)
			{
				if(var_01.var_222 == self.var_222)
				{
					continue;
				}

				if(targetvisibleinfront(var_01))
				{
					return var_01;
				}
			}
		}
	}

	if(isdefined(level.var_27EF))
	{
		foreach(var_06 in level.var_27EF)
		{
			if(var_06.var_110EA != "ball_drone_backup")
			{
				continue;
			}

			if(level.teambased && var_06.team == self.var_222.team)
			{
				continue;
			}

			if(!level.teambased && var_06.var_222 == self.var_222)
			{
				continue;
			}

			if(targetvisibleinfront(var_06))
			{
				return var_06;
			}
		}
	}

	if(isdefined(level.var_8DD3))
	{
		foreach(var_09 in level.var_8DD3)
		{
			if(var_09.var_110EA != "jackal")
			{
				continue;
			}

			if(level.teambased && var_09.team == self.var_222.team)
			{
				continue;
			}

			if(!level.teambased && var_09.var_222 == self.var_222)
			{
				continue;
			}

			if(targetvisibleinfront(var_09))
			{
				return var_09;
			}
		}
	}

	if(isdefined(level.var_DA61))
	{
		foreach(var_0C in level.var_DA61)
		{
			if(var_0C.var_110EA != "thor")
			{
				continue;
			}

			if(isdefined(var_0C.team))
			{
				if(level.teambased && var_0C.team == self.var_222.team)
				{
					continue;
				}
			}

			if(!level.teambased && var_0C.var_222 == self.var_222)
			{
				continue;
			}

			if(targetvisibleinfront(var_0C))
			{
				return var_0C;
			}
		}
	}

	if(isdefined(level.var_105EA))
	{
		foreach(var_0C in level.var_105EA)
		{
			if(var_0C.var_110EA != "minijackal")
			{
				continue;
			}

			if(isdefined(var_0C.team))
			{
				if(level.teambased && var_0C.team == self.var_222.team)
				{
					continue;
				}
			}

			if(!level.teambased && var_0C.var_222 == self.var_222)
			{
				continue;
			}

			if(targetvisibleinfront(var_0C))
			{
				return var_0C;
			}
		}
	}
}

//Function Number: 76
targetvisibleinfront(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = 0;
	var_02 = self gettagorigin("tag_flash");
	var_03 = param_00.origin;
	var_04 = vectornormalize(var_03 - var_02);
	var_05 = anglestoforward(self.angles);
	var_06 = [self,self.var_222,param_00];
	var_07 = physics_createcontents(["physicscontents_solid","physicscontents_glass","physicscontents_water","physicscontents_vehicle","physicscontents_item"]);
	if(scripts\common\trace::func_DCF1(var_02,var_03,var_06,var_07) && vectordot(var_05,var_04) > 0.25 && distance2dsquared(var_02,var_03) > 10000)
	{
		var_01 = 1;
	}

	return var_01;
}

//Function Number: 77
shootshocksentrysamtarget(param_00,param_01)
{
	self endon("death");
	self endon("carried");
	level endon("game_ended");
	self method_830F("manual");
	thread setshocksamtargetent(param_00,param_01);
	self.sentryshocksamtarget = undefined;
	self waittill("turret_on_target");
	thread func_B383(param_00);
	self playsound("shock_sentry_charge_up");
	playfxontag(scripts\common\utility::getfx("sentry_shock_charge"),self,"tag_laser");
	func_F25C();
	stopfxontag(scripts\common\utility::getfx("sentry_shock_charge"),self,"tag_laser");
	self notify("start_firing");
	self setscriptablepartstate("coil","active");
	var_02 = 2;
	var_03 = 1;
	while(isdefined(param_00) && targetvisibleinfront(param_00))
	{
		var_04 = self gettagorigin("tag_flash");
		var_05 = scripts\mp\_utility::func_1309("sentry_shock_missile_mp",var_04,param_00.origin,self.var_222);
		var_05 missile_settargetent(param_00);
		var_05 missile_setflightmodedirect();
		var_05.var_A63A = self.var_A63A;
		var_05.var_110E8 = self.var_110E8;
		self setscriptablepartstate("muzzle","fire" + var_03,0);
		level notify("laserGuidedMissiles_incoming",self.var_222,var_05,param_00);
		var_03++;
		if(var_03 > 2)
		{
			var_03 = 1;
		}

		wait(var_02);
	}

	self setscriptablepartstate("muzzle","neutral",0);
	self notify("sentry_lost_target");
	param_01 unlink();
	param_01.origin = self gettagorigin("tag_flash");
	param_01 linkto(self,"tag_flash");
	self method_830F("sentry");
	self method_807E();
	self setscriptablepartstate("coil","idle");
	func_F25B();
	self notify("done_firing");
}

//Function Number: 78
setshocksamtargetent(param_00,param_01)
{
	self endon("death");
	self endon("carried");
	self endon("sentry_lost_target");
	param_00 endon("death");
	level endon("game_ended");
	for(;;)
	{
		var_02 = self gettagorigin("tag_aim");
		var_03 = param_00.origin;
		var_04 = vectornormalize(var_03 - var_02);
		var_05 = var_02 + var_04 * 500;
		param_01 unlink();
		param_01.origin = var_05;
		param_01 linkto(self);
		self method_8347(param_01);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 79
func_13B37()
{
	self endon("death");
	for(;;)
	{
		self waittill("carried");
		if(isdefined(self.var_F26C))
		{
			self.var_F26C = undefined;
		}

		if(isdefined(self.sentryshocksamtarget))
		{
			self.sentryshocksamtarget = undefined;
		}

		self method_807E();
	}
}

//Function Number: 80
func_FE4F(param_00)
{
	self endon("death");
	self endon("carried");
	if(!isdefined(param_00))
	{
		return;
	}

	thread func_B383(param_00);
	if(!scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_sam_turret"))
	{
		thread func_13B3C(param_00);
	}

	self playsound("shock_sentry_charge_up");
	playfxontag(scripts\common\utility::getfx("sentry_shock_charge"),self,"tag_laser");
	func_F25C();
	stopfxontag(scripts\common\utility::getfx("sentry_shock_charge"),self,"tag_laser");
	self notify("start_firing");
	self setscriptablepartstate("coil","active");
	level thread scripts\mp\_battlechatter_mp::func_EB87(param_00,"plr_killstreak_target");
	var_01 = function_0240(level.var_F26B[self.var_F26E].var_39B);
	while(isdefined(param_00) && scripts\mp\_utility::func_9F19(param_00) && isdefined(self method_8166(1)) && self method_8166(1) == param_00 && !scripts\mp\_utility::func_C7A0(self gettagorigin("tag_flash"),param_00 geteye()))
	{
		if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_mini_explosives"))
		{
			thread missileburstfire(param_00);
			var_01 = 1.5;
			continue;
		}

		self method_837E();
		wait(var_01);
	}

	self setscriptablepartstate("coil","idle");
	self setscriptablepartstate("muzzle","neutral",0);
	self.var_F26C = undefined;
	self method_807E();
	func_F25B();
	self notify("done_firing");
}

//Function Number: 81
missileburstfire(param_00)
{
	self endon("death");
	self endon("carried");
	var_01 = 3;
	var_02 = 1;
	while(var_01 > 0)
	{
		if(!isdefined(param_00))
		{
			return;
		}

		if(!isdefined(self.var_222))
		{
			return;
		}

		var_03 = scripts\mp\_utility::func_1309("sentry_shock_grenade_mp",self gettagorigin("tag_flash"),param_00.origin,self.var_222);
		if(scripts\mp\killstreaks\_utility::manualmissilecantracktarget(param_00))
		{
			var_03 missile_settargetent(param_00,gettargetoffset(param_00));
			param_00 thread watchtarget(var_03);
		}

		var_03.var_A63A = self.var_A63A;
		var_03.var_110E8 = self.var_110E8;
		self setscriptablepartstate("muzzle","fire" + var_02,0);
		var_02++;
		if(var_02 > 2)
		{
			var_02 = 1;
		}

		var_01--;
		wait(0.2);
	}
}

//Function Number: 82
gettargetoffset(param_00)
{
	var_01 = (0,0,40);
	var_02 = param_00 getstance();
	switch(var_02)
	{
		case "stand":
			var_01 = (0,0,40);
			break;

		case "crouch":
			var_01 = (0,0,20);
			break;

		case "prone":
			var_01 = (0,0,5);
			break;
	}

	return var_01;
}

//Function Number: 83
watchtarget(param_00)
{
	self endon("disconnect");
	for(;;)
	{
		if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(self))
		{
			break;
		}

		if(!isdefined(param_00))
		{
			break;
		}

		scripts\common\utility::func_136F7();
	}

	if(isdefined(param_00))
	{
		param_00 missile_cleartarget();
	}
}

//Function Number: 84
func_B383(param_00)
{
	self endon("death");
	self method_81D9();
	self.var_A86B = 1;
	scripts\common\utility::waittill_any_3("done_firing","carried");
	self method_81D8();
	self.var_A86B = 0;
}

//Function Number: 85
func_13B3C(param_00)
{
	self endon("death");
	self endon("done_firing");
	var_01 = undefined;
	for(;;)
	{
		self waittill("victim_damaged",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		if(var_02 == param_00)
		{
			var_0C = 100;
			var_0D = scripts\mp\_utility::func_807D(var_08,var_0C,var_02.team,self.var_222);
			playfx(scripts\common\utility::getfx("sentry_shock_explosion"),var_08);
			if(var_0D.size > 0)
			{
				foreach(var_0F in var_0D)
				{
					if(var_0F.player != var_02)
					{
						var_0F.player dodamage(5,var_08,self.var_222,self,var_06,var_07);
						var_10 = undefined;
						var_11 = undefined;
						if(var_0F.visiblelocations.size > 1)
						{
							var_11 = randomint(var_0F.visiblelocations.size);
							var_10 = var_0F.visiblelocations[var_11];
						}
						else
						{
							var_10 = var_0F.visiblelocations[0];
						}

						function_02E0(scripts\common\utility::getfx("sentry_shock_arc"),var_08,vectortoangles(var_10 - var_08),var_10);
					}
				}
			}
		}
	}
}

//Function Number: 86
func_1CB4(param_00)
{
	if(param_00)
	{
		scripts\common\utility::allow_weapon(1);
		thread scripts\mp\_supers::func_12D6C();
		return;
	}

	thread scripts\mp\_supers::func_1CAB();
	scripts\common\utility::allow_weapon(0);
}

//Function Number: 87
func_CC1B()
{
	var_00 = self.var_F26E;
	if(var_00 == "super_trophy")
	{
		self.var_222 method_80F4(&"LUA_MENU_MP_PLACE_SUPER_TROPHY");
		return;
	}

	self.var_222 method_80F4(&"SENTRY_PLACE");
}

//Function Number: 88
func_38E2()
{
	var_00 = self.var_F26E;
	if(var_00 == "super_trophy")
	{
		self.var_222 method_80F4(&"LUA_MENU_MP_CANNOT_PLACE_SUPER_TROPHY");
		return;
	}

	self.var_222 method_80F4(&"SENTRY_CANNOT_PLACE");
}