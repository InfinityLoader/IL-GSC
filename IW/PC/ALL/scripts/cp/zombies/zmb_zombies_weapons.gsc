/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\zmb_zombies_weapons.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 72
 * Decompile Time: 3323 ms
 * Timestamp: 10/27/2023 12:27:25 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\cp\_spawn_plasma_projectile::func_10A34();
	func_8C64();
	func_6A78();
	level.facemelter_globs = [];
}

//Function Number: 2
func_1600(param_00)
{
	param_00 thread func_18F0(param_00);
}

//Function Number: 3
func_4DD8(param_00)
{
	param_00 unlink();
	if(isdefined(level.var_4DD9))
	{
		[[ level.var_4DD9 ]](param_00);
	}
}

//Function Number: 4
func_18F0(param_00)
{
	var_01 = 5;
	var_02 = bullettrace(param_00.origin,param_00.origin + (0,0,170),0,param_00);
	var_03 = var_02["position"];
	var_04 = var_03[2] - param_00.origin[2];
	var_05 = min(var_04,170) - 70;
	var_06 = spawn("script_origin",param_00.origin);
	var_06.angles = param_00.angles;
	param_00.do_immediate_ragdoll = 1;
	param_00 linkto(var_06);
	var_06 moveto(param_00.origin + (0,0,var_05),var_01);
	var_07 = var_06 scripts\cp\_utility::func_1372D(level,"deactivate zero g",param_00,"death");
	if(isdefined(param_00))
	{
		param_00.do_immediate_ragdoll = 0;
	}

	var_06 delete();
}

//Function Number: 5
func_75FA()
{
	self endon("death");
	self.var_11196 = 1;
	thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
	wait(0.5);
	self.var_11196 = undefined;
}

//Function Number: 6
func_1094D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(self.agent_type) && self.agent_type == "zombie_brute" || self.agent_type == "zombie_grey")
	{
		return;
	}

	var_0C = scripts\common\utility::istrue(param_01.inlaststand);
	var_0D = scripts\common\utility::istrue(self.var_9CDD);
	var_0E = getweaponbasename(param_05);
	if(!isdefined(var_0E))
	{
		return;
	}

	var_0F = 0;
	if(!var_0D)
	{
		switch(var_0E)
		{
			case "iw7_headcutter3_zm":
			case "iw7_headcutter2_zm":
			case "iw7_headcutter_zm_pap1":
			case "iw7_headcutter_zm":
				if(param_04 != "MOD_MELEE" && param_02 >= self.health && !scripts\common\utility::istrue(self.var_9E0C))
				{
					self.health = param_02 + 1;
					self.allowpain = 1;
					self.var_A64E = param_01;
					thread func_8C5D(param_01,param_06,param_08,param_02,param_05);
					var_0F = 1;
				}
				break;

			case "iw7_dischord_zm_pap1":
			case "iw7_dischord_zm":
				if(param_04 != "MOD_MELEE" && param_02 >= self.health && !scripts\common\utility::istrue(self.var_9E0C))
				{
					self.health = param_02 + 1;
					self.allowpain = 1;
					self.var_A64E = param_01;
					thread func_5622(param_01,param_06,param_08,param_02,param_05);
				}
				break;

			case "iw7_facemelter_zm_pap1":
			case "iw7_facemelter_zm":
				if(param_04 != "MOD_MELEE" && param_02 >= self.health && !scripts\common\utility::istrue(self.var_9E0C))
				{
					self.health = param_02 + 1;
					self.allowpain = 1;
					self.var_A64E = param_01;
					thread func_6A76(param_01,param_06,param_08,param_02,param_05);
				}
				break;

			case "iw7_shredder_zm_pap1":
			case "iw7_shredder_zm":
				if(param_04 != "MOD_MELEE" && param_02 >= self.health && !scripts\common\utility::istrue(self.var_9E0C))
				{
					self.health = param_02 + 1;
					self.allowpain = 1;
					self.var_A64E = param_01;
					thread func_10167(param_01,param_06,param_08,param_02);
				}
				break;

			default:
				break;
		}

		if(self.health - param_02 < 1)
		{
			if(isdefined(level.var_B53A))
			{
				var_10 = [[ level.var_B53A ]](self);
				if(isdefined(var_10))
				{
					self.nocorpse = 1;
					self.var_BE77 = var_10;
				}
				else
				{
					self.var_BE77 = undefined;
				}
			}

			if(isdefined(level.var_4ADD))
			{
				if(isplayer(param_01) && isdefined(param_05) && param_05 != "none")
				{
					var_11 = [[ level.var_4ADD ]](self,param_05);
					if(var_11)
					{
						self.nocorpse = 1;
						self.var_BE74 = 1;
					}
					else
					{
						self.var_BE74 = undefined;
					}
				}
				else
				{
					self.var_BE74 = undefined;
				}
			}
		}
	}

	if(self.health - param_02 < 1)
	{
		if(isdefined(level.lethaldamage_func))
		{
			[[ level.lethaldamage_func ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
		}

		if(!var_0C && !var_0F)
		{
			if(param_01 scripts\cp\_utility::func_9BA0("headshot_explosion"))
			{
				func_3DD7(param_01,param_06,param_02,param_04,param_05,param_08,var_0D);
				return;
			}

			if(param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_change"))
			{
				[[ level.change_chew_explosion_func ]](param_01,param_06,param_02,param_04,param_05,param_08);
				return;
			}

			return;
		}
	}
}

//Function Number: 7
func_5622(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self.var_AD05))
	{
		return;
	}

	self endon("death");
	if(scripts\common\utility::istrue(self.var_9BB0) || self.var_EF64)
	{
		self.do_immediate_ragdoll = 1;
		self dodamage(self.health + 1000,self.origin,param_00,param_00,"MOD_GRENADE_SPLASH","iw7_dischorddummy_zm");
	}

	self.var_EF64 = 1;
	var_05 = 0;
	var_06 = scripts\cp\_utility::func_13C90(param_04,"pap1");
	var_07 = 50;
	if(var_06)
	{
		var_07 = 100;
		self.var_12F77 = 1;
	}

	self.dischord_spin = 1;
	if(scripts\common\utility::istrue(self.var_9CEC))
	{
		thread func_5625(param_00,param_01,param_02,param_03,var_07,5);
		playfxontag(level._effect["dischord_tornado"],self,"tag_origin");
		var_05 = 1;
		while(scripts\common\utility::istrue(self.var_9CEC))
		{
			wait(0.1);
		}

		self notify("stop_spin");
	}

	thread kill_me_after_timeout(5,"ready_to_spin");
	if(!var_05)
	{
		self setscriptablepartstate("dischord_spin_fx","active",1);
	}

	self waittill("ready_to_spin");
	self.var_AD05 = spawn("script_origin",self.origin);
	self.var_AD05 thread func_A5F3(self);
	if(!var_06)
	{
		self linkto(self.var_AD05);
	}

	thread func_5625(param_00,param_01,param_02,param_03,var_07,0.5);
	self.var_AD05 rotateyaw(360,1);
	wait(0.5);
	thread func_5625(param_00,param_01,param_02,param_03,var_07,0.5);
	self.var_AD05 rotateyaw(720,1);
	wait(0.5);
	thread func_5625(param_00,param_01,param_02,param_03,var_07,1);
	self.var_AD05 rotateyaw(1080,1);
	wait(1);
	thread func_5625(param_00,param_01,param_02,param_03,var_07,1);
	self.var_AD05 rotateyaw(1240,1);
	wait(1);
	if(var_06)
	{
		thread func_5625(param_00,param_01,param_02,param_03,var_07,2);
		wait(2);
	}
	else
	{
		thread func_5625(param_00,param_01,param_02,param_03,var_07,0.1);
	}

	playsoundatpos(self.origin,"zombie_dischord_zmb_spin_explo");
	self.full_gib = 1;
	self.nocorpse = 1;
	self.var_828A = "dischord_explosion";
	self setscriptablepartstate("dischord_spin_fx","inactive",1);
	var_08 = 128;
	if(var_06)
	{
		var_08 = 256;
	}

	if(isdefined(param_00))
	{
		param_00 radiusdamage(self.origin,var_08,2000,2000,param_00,"MOD_GRENADE_SPLASH","iw7_dischorddummy_zm");
	}
	else
	{
		level.players[0] radiusdamage(self.origin,var_08,2000,2000,level.players[0],"MOD_GRENADE_SPLASH","iw7_dischorddummy_zm");
	}

	if(isdefined(self.var_AD05))
	{
		self.dischord_spin = 0;
		self.deathmethod = "dischord";
		self dodamage(self.health + 1000,self.origin,param_00,self.var_AD05,"MOD_GRENADE_SPLASH","iw7_dischorddummy_zm");
	}
}

//Function Number: 8
func_A5F3(param_00)
{
	param_00 waittill("death");
	wait(0.25);
	self delete();
}

//Function Number: 9
kill_me_after_timeout(param_00,param_01)
{
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	wait(param_00);
	self suicide();
}

//Function Number: 10
func_5625(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	self endon("stop_spin");
	var_06 = param_05;
	var_07 = 0.1;
	var_08 = 2;
	param_03 = 3000;
	if(param_04 == 100)
	{
		param_03 = 7000;
	}

	while(var_06 > 0)
	{
		var_09 = 0;
		var_0A = scripts\common\utility::func_782F(self.origin,level.spawned_enemies,[self],30,param_04);
		if(isdefined(var_0A))
		{
			foreach(var_0C in var_0A)
			{
				if(var_0C.agent_type == "zombie_brute" || var_0C.agent_type == "zombie_grey")
				{
					continue;
				}

				if(var_0C scripts\mp\agents\zombie\zmb_zombie_agent::func_5F70())
				{
					continue;
				}

				var_0D = undefined;
				if(scripts\common\utility::istrue(self.var_9CEC))
				{
					var_0D = 1;
				}

				if(!scripts\common\utility::istrue(var_0C.var_4C87))
				{
					var_09++;
					if(var_09 >= var_08)
					{
						var_0D = 1;
					}

					var_0C thread func_6F32(param_03,self.var_AD05,param_00,var_0D);
				}
			}
		}

		var_06 = var_06 - var_07;
		wait(var_07);
	}
}

//Function Number: 11
func_6F32(param_00,param_01,param_02,param_03)
{
	self.do_immediate_ragdoll = 1;
	self.var_4C87 = 1;
	self.disable_armor = 1;
	playfx(level._effect["blackhole_trap_death"],self.origin,anglestoforward((-90,0,0)),anglestoup((-90,0,0)));
	wait(0.05);
	if(scripts\common\utility::istrue(param_03))
	{
		self.nocorpse = 1;
		self.full_gib = 1;
		if(isdefined(param_02))
		{
			self dodamage(self.health + 1000,self.origin,param_02,param_02,"MOD_UNKNOWN","iw7_dischorddummy_zm");
			return;
		}

		self dodamage(self.health + 1000,self.origin,level.players[0],level.players[0],"MOD_UNKNOWN","iw7_dischorddummy_zm");
		return;
	}

	self setvelocity(vectornormalize(self.origin - param_01.origin) * 200 + (0,0,800));
	wait(0.1);
	if(isdefined(param_02))
	{
		self dodamage(self.health + 1000,param_01.origin,param_02,param_01,"MOD_UNKNOWN","iw7_dischorddummy_zm");
		return;
	}

	self dodamage(self.health + 1000,param_01.origin,param_01,param_01,"MOD_UNKNOWN","iw7_dischorddummy_zm");
}

//Function Number: 12
func_FFA6(param_00)
{
	var_01 = 3;
	if(param_00 scripts\cp\_utility::has_zombie_perk("perk_machine_more"))
	{
		var_01 = 4;
	}

	var_02 = param_00 getweaponslist("primary");
	return var_02.size >= var_01;
}

//Function Number: 13
func_6A78()
{
	level._effect["base_plasma_explosion_enemy"] = loadfx("vfx/iw7/_requests/mp/vfx_plasma_large_explosion_enemy.vfx");
	level._effect["glob_plasma_pool_enemy"] = loadfx("vfx/iw7/_requests/mp/vfx_plasma_med_flames_enemy.vfx");
	level._effect["glob_plasma_impact_enemy"] = loadfx("vfx/iw7/_requests/mp/vfx_plasma_small_explosion_enemy.vfx");
	level._effect["glob_plasma_trail_enemy"] = loadfx("vfx/iw7/_requests/mp/vfx_plasma_trail_enemy.vfx");
	level._effect["dischord_tornado"] = loadfx("vfx/iw7/core/zombie/weapon/dischord/vfx_zmb_dischord_energy_tornado.vfx");
	level._effect["player_plasma_enemy"] = loadfx("vfx/iw7/_requests/mp/power/vfx_splash_grenade_light_en.vfx");
	level._effect["player_plasma_friendly"] = loadfx("vfx/iw7/_requests/mp/power/vfx_splash_grenade_light_fr.vfx");
}

//Function Number: 14
func_6A76(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	if(isdefined(self.var_AD05))
	{
		return;
	}

	self.var_EF64 = 1;
	self.var_180 = 1;
	var_05 = scripts\cp\_utility::func_13C90(param_04,"pap1");
	if(isdefined(self.hasplayedvignetteanim) && !self.hasplayedvignetteanim)
	{
		level thread func_6A77(self,5,param_00);
		self.nocorpse = 1;
		self dodamage(self.health + 1000,self.origin,param_00,param_00,"MOD_GRENADE_SPLASH","iw7_facemelterdummy_zm");
		return;
	}
	else if(isdefined(self.var_9CEC))
	{
		self.rocket_feet = 1;
		level thread func_6A77(self,5,param_00,var_05,1);
		self setscriptablepartstate("burning","active",1);
		while(scripts\common\utility::istrue(self.var_9CEC))
		{
			wait(0.1);
		}
	}

	self.rocket_feet = 1;
	if(isdefined(self.pooltrigger))
	{
		self.pooltrigger notify("fire_pool_done");
	}

	thread func_E07F();
	level thread func_6A77(self,5,param_00,var_05);
	if(!scripts\common\utility::istrue(self.var_9BA7))
	{
		thread turn_on_rocket_feet();
		self waittill("ready_to_launch");
		self.var_AD05 = spawn("script_origin",self.origin);
		self.var_AD05.angles = self.angles;
		self.var_AD05 thread func_A5F3(self);
		self linkto(self.var_AD05);
		var_06 = self.origin + (0,0,200);
		var_07 = self method_8007(self.origin,self.origin + (0,0,200),15,60,1,1);
		var_08 = 1;
		if(isdefined(var_07) && isdefined(var_07["position"]))
		{
			var_06 = var_07["position"] + (0,0,-40);
			var_08 = var_06[2] - self.var_AD05.origin[2];
			if(var_08 < 20)
			{
				var_08 = 20;
				var_06 = (var_06[0],var_06[1],self.var_AD05.origin[2] + 20);
			}

			var_08 = var_08 / 200;
		}

		self.var_AD05 moveto(var_06,var_08);
		wait(0.1);
		self setscriptablepartstate("left_leg","detached",1);
		self setscriptablepartstate("right_leg","detached",1);
		wait(0.8 * var_08);
		self playsound("zombie_facemelter_rocket_launch");
	}
	else
	{
		wait(0.9);
		self.full_gib = 1;
		self.nocorpse = 1;
	}

	self setscriptablepartstate("rocket_explosion","active",1);
	wait(0.1);
	var_09 = self.origin;
	var_0A = param_00;
	var_0B = var_0A.team;
	if(var_05)
	{
		var_0C = 3;
		for(var_0D = 0;var_0D < var_0C;var_0D++)
		{
			var_0E = randomintrange(-200,200);
			var_0F = randomintrange(-200,200);
			var_10 = randomintrange(200,400);
			var_11 = var_09 + (var_0E,var_0F,var_10) - var_09;
			var_12 = param_00 method_8449("zmb_globproj_zm",var_09,var_11,8);
			var_12.var_222 = param_00;
			var_12.team = param_00.team;
			var_12.var_12816 = "zmb_globproj_zm";
			if(var_0D == 0)
			{
				var_12 setscriptablepartstate("explosion","active");
			}
			else
			{
				var_12 setscriptablepartstate("explosion","neutral");
			}

			var_12 setscriptablepartstate("trail","active");
			level.facemelter_globs = scripts\common\utility::array_add_safe(level.facemelter_globs,var_12);
			var_12 thread func_13A8B("iw7_facemelterdummy_zm",var_05);
			scripts\common\utility::func_136F7();
		}
	}

	var_13 = self.var_AD05;
	if(isalive(self))
	{
		self.rocket_feet = 0;
		self setscriptablepartstate("rocket_feet","inactive",1);
		self setscriptablepartstate("rocket_explosion","inactive",1);
		if(!isdefined(param_00))
		{
			param_00 = undefined;
		}

		self dodamage(self.health + 1000,self.origin,param_00,self.var_AD05,"MOD_GRENADE_SPLASH","iw7_facemelterdummy_zm");
	}

	if(isdefined(var_13))
	{
		var_13 delete();
	}
}

//Function Number: 15
turn_on_rocket_feet()
{
	self endon("death");
	self playsound("zombie_facemelter_rocket_feet");
	self waittill("facemelter_launch_chosen");
	if(scripts\common\utility::istrue(self.var_565C))
	{
		wait(0.3);
	}
	else
	{
		wait(0.1);
	}

	self setscriptablepartstate("rocket_feet","active",1);
}

//Function Number: 16
func_E07F()
{
	self endon("death");
	wait(6);
	self.rocket_feet = 0;
}

//Function Number: 17
func_6A77(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 75;
	var_06 = 30;
	if(isdefined(param_04))
	{
		wait(0.1);
		self.pooltrigger = spawn("trigger_rotatable_radius",param_00.origin,0,var_05,var_06);
		self.pooltrigger thread func_E7F5(param_00,param_01,param_02,param_03);
		self.pooltrigger thread func_6D1C(param_01);
		wait(param_01);
		return;
	}

	var_07 = spawnfx(level._effect["fire_pool_wide"],param_00.origin);
	var_07 playsound("zombie_facemelter_fire_pool");
	wait(0.1);
	var_08 = spawn("trigger_rotatable_radius",param_00.origin,0,var_05,var_06);
	var_08 thread func_E7F5(param_00,param_01,param_02,param_03);
	var_08 thread func_6D1C(param_01);
	var_07 method_82EC();
	triggerfx(var_07);
	wait(param_01);
	var_07 delete();
}

//Function Number: 18
func_E7F5(param_00,param_01,param_02,param_03)
{
	self endon("fire_pool_done");
	var_04 = param_01 * 10;
	for(;;)
	{
		self waittill("trigger",var_05);
		if(isdefined(var_05.rocket_feet))
		{
			wait(0.1);
			continue;
		}
		else if(isplayer(var_05))
		{
			if(param_02 == var_05 && !scripts\common\utility::istrue(param_03) && !isdefined(var_05.var_3294))
			{
				if(!scripts\common\utility::istrue(var_05.inlaststand))
				{
					var_05.var_3294 = 1;
					var_05 thread dodamageandunsetburnstate(var_05,self);
				}
			}

			wait(0.1);
			continue;
		}
		else if(isalive(var_05))
		{
			level thread scripts\cp\_utility::func_4D0D(var_05,param_02,5,var_05.health + 1000,undefined,"iw7_facemelterdummy_zm",0,"burning");
		}

		wait(0.1);
	}
}

//Function Number: 19
dodamageandunsetburnstate(param_00,param_01)
{
	param_00 notify("doDamageAndUnsetBurnState");
	param_00 endon("doDamageAndUnsetBurnState");
	param_00 endon("disconnect");
	if(isalive(param_00))
	{
		param_00 dodamage(int(param_00.maxhealth * 0.15),param_01.origin,param_01,param_01,"MOD_UNKNOWN","iw7_facemelterdummy_zm");
	}

	wait(1);
	param_00.var_3294 = undefined;
}

//Function Number: 20
func_6D1C(param_00)
{
	wait(param_00);
	self notify("fire_pool_done");
	self delete();
}

//Function Number: 21
func_10167(param_00,param_01,param_02,param_03)
{
	self endon("death");
	if(scripts\mp\agents\zombie\zmb_zombie_agent::func_5F70())
	{
		return;
	}

	self.shredder_death = 1;
	self.var_180 = 1;
	self method_841F();
	wait(0.1);
	var_04 = ["left_arm","right_arm"];
	var_04 = scripts\common\utility::array_randomize(var_04);
	if(!scripts\common\utility::istrue(self.var_9BA7))
	{
		foreach(var_06 in var_04)
		{
			self setscriptablepartstate(var_06,"disintegrate",1);
			wait(0.25);
		}

		var_04 = ["right_leg","left_leg"];
		var_04 = scripts\common\utility::array_randomize(var_04);
		foreach(var_06 in var_04)
		{
			self setscriptablepartstate(var_06,"disintegrate",1);
			wait(0.25);
		}

		self setscriptablepartstate("shredder_fx","active",1);
		wait(0.25);
		self setscriptablepartstate("head","detached",1);
	}
	else
	{
		foreach(var_06 in var_06)
		{
			self setscriptablepartstate(var_06,"disintegrate",1);
			wait(0.1);
		}

		var_04 = ["right_leg","left_leg"];
		var_04 = scripts\common\utility::array_randomize(var_04);
		foreach(var_06 in var_04)
		{
			self setscriptablepartstate(var_06,"disintegrate",1);
			wait(0.1);
		}

		self.full_gib = 1;
	}

	wait(0.1);
	self.nocorpse = 1;
	self.deathmethod = "shredder";
	self.shredder_death = 0;
	self dodamage(self.health + 1000,self.origin,param_00,undefined,"MOD_UNKNOWN","iw7_shredderdummy_zm");
}

//Function Number: 22
func_3DD7(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = scripts\common\utility::func_9D74(param_03) || param_03 == "MOD_EXPLOSIVE_BULLET" && param_05 != "none";
	if(!var_07)
	{
		return;
	}

	if(!scripts\cp\_utility::func_9E27(param_04,param_05,param_03,param_00))
	{
		return;
	}

	param_00 scripts\cp\_utility::func_C151("headshot_explosion");
	thread func_6996(param_00,param_05,param_02,"bloody_death",undefined,param_06);
}

//Function Number: 23
func_6996(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(scripts\mp\agents\zombie\zmb_zombie_agent::func_5F70())
	{
		return;
	}

	if(scripts\cp\_utility::agentisfnfimmune() || self.agent_type == "alien_goon" || self.agent_type == "skeleton")
	{
		return;
	}

	self.head_is_exploding = 1;
	param_04 = self gettagorigin("J_Spine4");
	playsoundatpos(self.origin,"zmb_fnf_headpopper_explo");
	playfx(level._effect[param_03],param_04);
	foreach(var_07 in level.players)
	{
		if(distance(var_07.origin,param_04) <= 350)
		{
			var_07 thread func_10142();
		}
	}

	if(isdefined(self.var_8C98))
	{
		self detach(self.var_8C98);
	}

	if(!param_05)
	{
		self setscriptablepartstate("head","hide");
	}
}

//Function Number: 24
func_10142()
{
	self notify("turn_on_screen_blood_on");
	self endon("turn_on_screen_blood_on");
	self setscriptablepartstate("on_screen_blood","on");
	scripts\common\utility::waittill_any_timeout_1(2,"death","last_stand");
	self setscriptablepartstate("on_screen_blood","neutral");
}

//Function Number: 25
func_8C64()
{
	level._effect["head_exploder"] = loadfx("vfx/iw7/_requests/coop/zmb_head_exploder.vfx");
	level._effect["head_expander"] = loadfx("vfx/iw7/_requests/coop/zmb_head_expander.vfx");
	level._effect["head_blood_explosion"] = loadfx("vfx/iw7/_requests/coop/zmb_head_blood_explosion.vfx");
}

//Function Number: 26
func_8C5D(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	if(scripts\mp\agents\zombie\zmb_zombie_agent::func_5F70())
	{
		return;
	}

	self.head_is_exploding = 1;
	wait(randomfloatrange(0,0.5));
	if(!scripts\common\utility::istrue(self.var_9BA7))
	{
		self setscriptablepartstate("eyes","headcutter_eyes");
	}

	self.var_180 = 1;
	self method_841F();
	wait(1);
	self setscriptablepartstate("eyes","eye_glow_off");
	wait(0.1);
	self setscriptablepartstate("headcutter_fx","active");
	wait(0.1);
	self setscriptablepartstate("head","hide",1);
	wait(0.1);
	param_01 = self gettagorigin("J_Spine4");
	param_00 thread func_6995(param_00,param_01,self,param_04);
	if(scripts\common\utility::istrue(self.var_9BA7))
	{
		self.full_gib = 1;
		self.nocorpse = 1;
	}

	self dodamage(self.health + 1000,self.origin,param_00,undefined,"MOD_UNKNOWN","iw7_headcutterdummy_zm");
}

//Function Number: 27
func_6995(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\cp\_utility::func_13C90(param_03,"pap1");
	var_05 = getweaponbasename(param_03);
	var_06 = "iw7_headcutterdummy_zm";
	var_07 = 15000;
	switch(var_05)
	{
		case "iw7_headcutter_zm_pap1":
		case "iw7_headcutter_zm":
			if(var_04)
			{
				var_06 = "iw7_headcutter2_zm+hcpap1";
			}
			else
			{
				var_06 = "iw7_headcutter2_zm";
			}
			break;

		case "iw7_headcutter2_zm":
			if(var_04)
			{
				var_06 = "iw7_headcutter3_zm+hcpap1";
			}
			else
			{
				var_06 = "iw7_headcutterdummy_zm";
			}
			break;
	}

	var_08 = [];
	var_08 = level.spawned_enemies;
	var_09 = [param_02];
	var_0A = 128;
	if(var_04)
	{
		var_0A = 256;
	}

	var_0B = scripts\common\utility::func_782F(param_01,var_08,var_09,undefined,var_0A,0);
	foreach(var_0D in var_0B)
	{
		if(isdefined(var_0D.agent_type) && var_0D.agent_type == "zombie_grey" || var_0D.agent_type == "zombie_brute")
		{
			var_0E = 100;
		}
		else
		{
			var_0E = 100000;
		}

		var_0D dodamage(var_0E,param_01,param_00,param_00,"MOD_EXPLOSIVE",var_06);
	}
}

//Function Number: 28
func_5120(param_00,param_01,param_02,param_03)
{
	param_03 endon("disconnect");
	wait(param_00);
	var_04 = magicbullet("iw7_headcuttershards_mp",param_01,param_02,param_03);
}

//Function Number: 29
func_13C66()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	self.var_26E1 = 0;
	self.var_C24F = 0;
	self.var_72F6 = 0;
	var_00 = getweaponbasename(self getcurrentprimaryweapon());
	var_01 = self getcurrentweapon();
	var_02 = undefined;
	for(;;)
	{
		if(isdefined(var_00) && var_00 == "iw7_axe_zm" && self.var_26E1 < 3)
		{
			scripts\cp\_utility::setlowermessage("msg_axe_hint",&"CP_ZOMBIE_AXE_HINT",4);
			self.var_26E1 = self.var_26E1 + 1;
		}
		else if(isdefined(var_00) && var_00 == "iw7_forgefreeze_zm" && self.var_72F6 < 5)
		{
			scripts\cp\_utility::setlowermessage("msg_axe_hint",&"CP_ZOMBIE_FORGEFREEZE_HINT",4);
			self.var_72F6 = self.var_72F6 + 1;
		}

		updatecamoscripts(var_01,var_02);
		var_02 = var_01;
		self waittill("weapon_change");
		wait(0.5);
		var_00 = getweaponbasename(self getcurrentprimaryweapon());
		var_01 = self getcurrentweapon();
	}
}

//Function Number: 30
updatecamoscripts(param_00,param_01)
{
	if(isdefined(param_00))
	{
		var_02 = function_00E5(param_00);
	}
	else
	{
		var_02 = undefined;
	}

	if(isdefined(param_01))
	{
		var_03 = function_00E5(param_01);
	}
	else
	{
		var_03 = undefined;
	}

	if(!isdefined(var_02))
	{
		var_02 = "none";
	}

	if(!isdefined(var_03))
	{
		var_03 = "none";
	}

	clearcamoscripts(param_01,var_03);
	runcamoscripts(param_00,var_02);
}

//Function Number: 31
runcamoscripts(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return;
	}

	switch(param_01)
	{
		case "camo32":
			self setscriptablepartstate("camo_32","loop");
			break;

		case "camo34":
			self setscriptablepartstate("camo_34","loop");
			break;

		case "camo211":
			self setscriptablepartstate("camo_211","reset");
			break;

		case "camo212":
			self setscriptablepartstate("camo_212","reset");
			break;

		case "camo204":
			self setscriptablepartstate("camo_204","activate");
			break;

		case "camo205":
			self setscriptablepartstate("camo_205","activate");
			break;

		case "camo84":
			thread blood_camo_84();
			break;

		case "camo222":
			thread blood_camo_222();
			break;

		case "camo92":
			self setscriptablepartstate("camo_92","reset");
			break;

		case "camo93":
			self setscriptablepartstate("camo_93","reset");
			break;

		case "camo31":
			thread mw2_camo_31();
			break;
	}
}

//Function Number: 32
clearcamoscripts(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return;
	}

	switch(param_01)
	{
		case "camo204":
			self setscriptablepartstate("camo_204","neutral");
			break;

		case "camo205":
			self setscriptablepartstate("camo_205","neutral");
			break;

		case "camo84":
			self notify("blood_camo_84");
			break;

		case "camo222":
			self notify("blood_camo_222");
			break;

		case "camo31":
			self notify("mw2_camo_31");
			break;
	}
}

//Function Number: 33
mw2_camo_31()
{
	self endon("disconnect");
	self endon("death");
	self endon("mw2_camo_31");
	if(!isdefined(self.mw2camokillcount))
	{
		self.mw2camokillcount = 0;
	}

	var_00 = int(self.mw2camokillcount / 5);
	self setscriptablepartstate("camo_31",var_00 + "_kills");
	for(;;)
	{
		self waittill("zombie_killed");
		self.mw2camokillcount = self.mw2camokillcount + 1;
		if(self.mw2camokillcount % 5 == 0)
		{
			var_00 = int(self.mw2camokillcount / 5);
			if(var_00 > 7)
			{
				var_00 = 0;
				self.mw2camokillcount = 0;
			}

			self setscriptablepartstate("camo_31",var_00 + "_kills");
		}
	}
}

//Function Number: 34
blood_camo_84()
{
	self endon("disconnect");
	self endon("death");
	self endon("blood_camo_84");
	if(!isdefined(self.bloodcamokillcount))
	{
		self.bloodcamokillcount = 0;
	}

	var_00 = 1;
	for(;;)
	{
		self waittill("zombie_killed");
		self.bloodcamokillcount = self.bloodcamokillcount + 1;
		if(self.bloodcamokillcount / 5 == var_00)
		{
			var_01 = int(self.bloodcamokillcount / 5);
			if(var_01 > 14)
			{
				break;
			}

			self setscriptablepartstate("camo_84",var_01 + "_kills");
			var_00++;
		}
	}
}

//Function Number: 35
blood_camo_222()
{
	self endon("disconnect");
	self endon("death");
	self endon("blood_camo_222");
	self.katanacamokillcount = 0;
	self setscriptablepartstate("camo_222","null_state");
	var_00 = 1;
	for(;;)
	{
		self waittill("zombie_killed");
		self.katanacamokillcount = self.katanacamokillcount + 1;
		if(self.katanacamokillcount / 5 == var_00)
		{
			var_01 = int(self.katanacamokillcount / 5);
			if(var_01 > 10)
			{
				break;
			}

			self setscriptablepartstate("camo_222",var_01 + "_kills");
			var_00++;
		}
	}
}

//Function Number: 36
func_26E0()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		self waittill("axe_melee_hit",var_00,var_01,var_02);
		var_03 = getweaponbasename(var_00);
		var_04 = scripts\cp\_weapon::func_7D62(var_03);
		var_05 = func_7AD8(var_03,var_04);
		var_06 = func_7AD9(var_03,var_04);
		var_07 = func_7ADA(var_03,var_04);
		var_08 = func_3E08(var_05,var_06,var_07);
		thread func_F653(self);
		foreach(var_0A in var_08)
		{
			if(var_0A == var_01)
			{
				continue;
			}

			var_0A thread func_26DF(var_0A,self,var_02,var_0A.origin,self.origin,var_00,0.5);
		}
	}
}

//Function Number: 37
func_F652(param_00)
{
	param_00 setscriptablepartstate("axe - idle","neutral");
	wait(0.5);
	param_00 setscriptablepartstate("axe - idle","level 1");
}

//Function Number: 38
func_F653(param_00)
{
	param_00 notify("setaxeblooddrip");
	param_00 endon("setaxeblooddrip");
	param_00 setscriptablepartstate("axe","neutral");
	wait(0.5);
	param_00 setscriptablepartstate("axe","blood on");
	wait(5);
	param_00 setscriptablepartstate("axe","neutral");
}

//Function Number: 39
func_7AD8(param_00,param_01)
{
	if(!isdefined(param_00) && !isdefined(param_01))
	{
		return 45;
	}

	switch(param_01)
	{
		case 2:
			return 52;

		case 3:
			return 60;

		default:
			return 45;
	}
}

//Function Number: 40
func_7AD9(param_00,param_01)
{
	if(!isdefined(param_00) && !isdefined(param_01))
	{
		return 125;
	}

	switch(param_01)
	{
		case 2:
			return 150;

		case 3:
			return 175;

		default:
			return 125;
	}
}

//Function Number: 41
func_7ADA(param_00,param_01)
{
	if(!isdefined(param_00) && !isdefined(param_01))
	{
		return 1;
	}

	switch(param_01)
	{
		case 2:
			return 8;

		case 3:
			return 24;

		default:
			return 4;
	}
}

//Function Number: 42
func_7ADB(param_00,param_01)
{
	if(!isdefined(param_00) && !isdefined(param_01))
	{
		return 1100;
	}

	switch(param_01)
	{
		case 2:
			return 1500;

		case 3:
			return 2000;

		default:
			return 1100;
	}
}

//Function Number: 43
func_48DD(param_00)
{
	var_01 = param_00 / 2;
	var_02 = vectornormalize(anglestoforward(self.angles));
	var_03 = var_02 * var_01;
	var_04 = self.origin + var_03;
	physicsexplosionsphere(var_04,var_01,1,2);
}

//Function Number: 44
func_D505()
{
	var_00 = function_01E1(level._effect["repulsor_view_red"],self gettagorigin("tag_eye"),self);
	triggerfx(var_00);
	var_00 thread scripts\cp\_utility::func_5106(1);
	playrumbleonposition("slide_collision",self.origin);
	self earthquakeforplayer(0.5,0.5,self.origin,62.5);
}

//Function Number: 45
func_3E08(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 6;
	}

	var_03 = cos(param_00);
	var_04 = [];
	var_05 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_06 = scripts\common\utility::func_782F(self.origin,var_05,undefined,24,param_01,1);
	foreach(var_08 in var_06)
	{
		var_09 = anglestoforward(self.angles);
		var_0A = vectornormalize(var_09) * -25;
		var_0B = 0;
		var_0C = var_08.origin;
		var_0D = scripts\common\utility::func_13D90(self geteye() + var_0A,self.angles,var_0C + (0,0,30),var_03);
		if(var_0D)
		{
			if(isdefined(param_01))
			{
				var_0E = distance2d(self.origin,var_0C);
				if(var_0E < param_01)
				{
					var_0B = 1;
				}
			}
			else
			{
				var_0B = 1;
			}
		}

		if(var_0B && var_04.size < param_02)
		{
			var_04[var_04.size] = var_08;
		}
	}

	return var_04;
}

//Function Number: 46
func_26DF(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_00 endon("death");
	if(param_00 lib_0CBC::func_9C50())
	{
		param_00.allowpain = 1;
	}

	param_00 dodamage(param_02,param_03,param_01,param_01,"MOD_MELEE",param_05);
	wait(param_06);
	if(scripts\common\utility::istrue(param_00.allowpain))
	{
		param_00.allowpain = 0;
	}
}

//Function Number: 47
func_DF57()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		self waittill("reload_start");
		self waittill("reload");
		if(scripts\cp\_utility::is_escape_gametype())
		{
			var_00 = self getcurrentweapon();
			var_01 = self getweaponammostock(var_00);
			var_02 = weaponclipsize(var_00);
			self setweaponammostock(var_00,var_01 + var_02);
		}
	}
}

//Function Number: 48
arcane_attachment_watcher(param_00)
{
	scripts\common\utility::flag_wait("doors_initialized");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("death");
	while(!isdefined(param_00.var_111BC))
	{
		wait(0.1);
	}

	param_00 thread unsetstatewhenadswithsniper(param_00);
	for(;;)
	{
		var_01 = param_00 scripts\common\utility::waittill_any_3("weapon_change","weapon_switch_started","ads_out");
		param_00 func_412B(param_00);
		param_00 func_12976();
		param_00 thread func_13642(param_00);
	}
}

//Function Number: 49
func_EF2F()
{
	scripts\common\utility::flag_wait("doors_initialized");
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("scriptableNotification",var_00,var_01,var_02);
		if(!isdefined(var_00))
		{
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 50
unsetstatewhenadswithsniper(param_00)
{
	param_00 endon("disconnect");
	param_00 notifyonplayercommand("ads_in","+speed_throw");
	param_00 notifyonplayercommand("ads_out","-speed_throw");
	for(;;)
	{
		var_01 = param_00 scripts\common\utility::func_13734("ads_in","ads_out");
		if(param_00 scripts\cp\_utility::func_4626(param_00 getcurrentweapon()) == "weapon_sniper")
		{
			if(var_01 == "ads_in")
			{
				param_00 clear_arcane_scriptable_effects(param_00);
				param_00.pause_arcane_logic = 1;
				continue;
			}

			param_00.pause_arcane_logic = undefined;
		}
	}
}

//Function Number: 51
clear_arcane_scriptable_effects(param_00)
{
	param_00 setscriptablepartstate("arcane","neutral",1);
}

//Function Number: 52
func_412B(param_00)
{
	param_00 setclientomnvar("zm_ui_specialammo",0);
	param_00.var_10932 = undefined;
	param_00 setscriptablepartstate("arcane","neutral",1);
	if(param_00 scripts\cp\_utility::_hasperk("specialty_explosivebullets"))
	{
		param_00 scripts\cp\_utility::func_1430("specialty_explosivebullets");
	}

	if(param_00 scripts\cp\_utility::_hasperk("specialty_armorpiercing"))
	{
		param_00 scripts\cp\_utility::func_1430("specialty_armorpiercing");
	}

	if(param_00 scripts\cp\_utility::_hasperk("specialty_bulletdamage"))
	{
		param_00 scripts\cp\_utility::func_1430("specialty_bulletdamage");
	}
}

//Function Number: 53
func_13642(param_00,param_01)
{
	level endon("game_ended");
	param_00 notify("wait_for_weapon_switch_done");
	param_00 endon("wait_for_weapon_switch_done");
	param_00 endon("disconnect");
	param_00 endon("weapon_switch_started");
	while(param_00 method_81C2())
	{
		wait(0.05);
	}

	var_02 = param_00 getcurrentweapon();
	param_00 notify("weapon_switch_done",var_02);
	param_00 func_23BB(param_00,undefined,var_02);
	param_00 func_896F(param_00,var_02);
}

//Function Number: 54
func_23BB(param_00,param_01,param_02)
{
	if(scripts\common\utility::istrue(param_00.pause_arcane_logic))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		if(!isdefined(param_02))
		{
			param_02 = self getcurrentweapon();
		}

		if(!issubstr(param_02,"ark"))
		{
			return;
		}

		var_03 = strtok(param_02,"+");
		foreach(var_05 in var_03)
		{
			if(issubstr(var_05,"ark"))
			{
				param_01 = var_05;
				break;
			}
		}
	}

	if(!isdefined(param_01))
	{
		param_01 = "blank";
	}

	switch(param_01)
	{
		case "arkblue_sm":
		case "arkblue_akimbo":
		case "blue":
		case "arkblue":
			self setclientomnvar("zm_ui_specialammo",1);
			self.var_10932 = "stun_ammo";
			self.special_ammo_weapon = param_02;
			if(!scripts\cp\_utility::_hasperk("specialty_bulletdamage"))
			{
				scripts\cp\_utility::func_8387("specialty_bulletdamage");
			}
	
			scripts\cp\_utility::func_1430("specialty_explosivebullets");
			scripts\cp\_utility::func_1430("specialty_armorpiercing");
			self setscriptablepartstate("arcane","blue_on",0);
			break;

		case "arkgreen_sm":
		case "arkgreen_akimbo":
		case "arkgreen":
		case "green":
			self.var_10932 = "poison_ammo";
			self setclientomnvar("zm_ui_specialammo",0);
			scripts\cp\_utility::func_1430("specialty_explosivebullets");
			scripts\cp\_utility::func_1430("specialty_armorpiercing");
			scripts\cp\_utility::func_1430("specialty_bulletdamage");
			self setscriptablepartstate("arcane","green_on",0);
			break;

		case "arkyellow_sm":
		case "arkyellow_akimbo":
		case "yellow":
		case "arkyellow":
			self setclientomnvar("zm_ui_specialammo",3);
			self.var_10932 = "explosive_ammo";
			if(!scripts\cp\_utility::_hasperk("specialty_explosivebullets"))
			{
				scripts\cp\_utility::func_8387("specialty_explosivebullets");
			}
	
			scripts\cp\_utility::func_1430("specialty_armorpiercing");
			scripts\cp\_utility::func_1430("specialty_bulletdamage");
			self setscriptablepartstate("arcane","yellow_on",0);
			break;

		case "arkred_sm":
		case "arkred_akimbo":
		case "arkred":
		case "red":
			self setclientomnvar("zm_ui_specialammo",2);
			self.var_10932 = "incendiary_ammo";
			scripts\cp\_utility::func_1430("specialty_explosivebullets");
			scripts\cp\_utility::func_1430("specialty_armorpiercing");
			scripts\cp\_utility::func_1430("specialty_bulletdamage");
			self setscriptablepartstate("arcane","red_on",0);
			break;

		case "arkpink_sm":
		case "arkpink_akimbo":
		case "arkpink_lmg":
		case "pink":
		case "arkpink":
			self setclientomnvar("zm_ui_specialammo",5);
			self.var_10932 = "combined_ammo";
			if(!scripts\cp\_utility::_hasperk("specialty_bulletdamage"))
			{
				scripts\cp\_utility::func_8387("specialty_bulletdamage");
			}
	
			if(!scripts\cp\_utility::_hasperk("specialty_armorpiercing"))
			{
				scripts\cp\_utility::func_8387("specialty_armorpiercing");
			}
	
			self setscriptablepartstate("arcane","pink_on",0);
			break;

		default:
			self setclientomnvar("zm_ui_specialammo",0);
			self.var_10932 = undefined;
			scripts\cp\_utility::func_1430("specialty_explosivebullets");
			scripts\cp\_utility::func_1430("specialty_armorpiercing");
			scripts\cp\_utility::func_1430("specialty_bulletdamage");
			self setscriptablepartstate("arcane","neutral",0);
			break;
	}
}

//Function Number: 55
func_896F(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = self getcurrentweapon();
	}

	var_02 = getweaponbasename(param_01);
	func_12976();
	if(isdefined(var_02))
	{
		switch(var_02)
		{
			case "iw7_facemelter_zm_pap1":
			case "iw7_facemelter_zm":
				self setscriptablepartstate("facemelter","active");
				break;

			case "iw7_headcutter_zm_pap1":
			case "iw7_headcutter_zm":
				self setscriptablepartstate("headcutter","active");
				break;

			case "iw7_dischord_zm_pap1":
			case "iw7_dischord_zm":
				self setscriptablepartstate("dischord","active");
				break;

			case "iw7_shredder_zm_pap1":
			case "iw7_shredder_zm":
				self setscriptablepartstate("shredder","active");
				break;
		}
	}
}

//Function Number: 56
func_12976()
{
	self setscriptablepartstate("headcutter","inactive");
	self setscriptablepartstate("facemelter","inactive");
	self setscriptablepartstate("dischord","inactive");
	self setscriptablepartstate("shredder","inactive");
}

//Function Number: 57
func_782A(param_00)
{
	var_01 = strtok(param_00,"+");
	foreach(var_03 in var_01)
	{
		var_04 = getsubstr(var_03,0,3);
		if(var_04 == "ark")
		{
			switch(var_03)
			{
				case "arkblueburst":
				case "arkblueshotgun":
				case "arkblueautospread":
				case "arkblueauto":
				case "arkbluesingle":
					return "arkblue";

				case "arkgreenburst":
				case "arkgreenshotgun":
				case "arkgreenautospread":
				case "arkgreenauto":
				case "arkgreensingle":
					return "arkgreen";

				case "arkyellowburst":
				case "arkyellowshotgun":
				case "arkyellowautospread":
				case "arkyellowauto":
				case "arkyellowsingle":
					return "arkyellow";

				case "arkpinkburst":
				case "arkpinkshotgun":
				case "arkpinkautospread":
				case "arkpinkauto":
				case "arkpinksingle":
					return "arkpink";

				case "arkredburst":
				case "arkredshotgun":
				case "arkredautospread":
				case "arkredauto":
				case "arkredsingle":
					return "arkred";

				case "arkwhiteburst":
				case "arkwhiteshotgun":
				case "arkwhiteautospread":
				case "arkwhiteauto":
				case "arkwhitesingle":
					return "arkwhite";
			}
		}
	}

	return undefined;
}

//Function Number: 58
func_13C1C(param_00)
{
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(var_03 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 59
func_13A8B(param_00,param_01)
{
	self endon("death");
	thread remove_from_glob_array_on_death();
	self waittill("missile_stuck",var_02);
	if(!isdefined(self.var_222))
	{
		return;
	}

	self setscriptablepartstate("trail","neutral");
	self setscriptablepartstate("explosion","active");
	playsoundatpos(self.origin,"plasma_grenade_impact");
	radiusdamage(self.origin,128,10,5,self.var_222,"MOD_EXPLOSIVE",param_00);
	if(level.facemelter_globs.size > 5)
	{
		self delete();
		return;
	}

	var_03 = spawn("trigger_rotatable_radius",self.origin,0,60,60);
	var_03.angles = self.angles;
	var_03.var_222 = self.var_222;
	var_03.team = self.var_222.team;
	var_03 thread func_13B0E(param_00,param_01);
	var_03 thread scripts\cp\_utility::func_5106(8);
	var_03 thread func_511D(0.1,"plasma_grenade_fire_glob");
	self.var_D654 = "poolGround";
	self setscriptablepartstate("poolGround","active");
	wait(8);
	self setscriptablepartstate(self.var_D654,"activeEnd",0);
	self delete();
}

//Function Number: 60
remove_from_glob_array_on_death()
{
	self waittill("death");
	level.facemelter_globs = scripts\common\utility::func_22A9(level.facemelter_globs,self);
}

//Function Number: 61
func_10D82(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	self endon("disconnect");
	param_01 endon("disconnect");
	self.var_10D94 = 1;
	self.var_10D93 = undefined;
	self.var_9B81 = 1;
	thread func_13A91();
	thread func_13B5A(param_00,param_01);
	if(isdefined(level.var_10A32) && isalive(self) && isdefined(self.var_1096F) && self.var_1096F == "zombie")
	{
		self thread [[ level.var_10A32 ]](self);
	}
	else
	{
	}

	thread func_10B72(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 62
func_CD19(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_03 = spawnfx(scripts\common\utility::getfx(param_01),param_00);
	if(isdefined(var_03))
	{
		triggerfx(var_03);
	}

	var_03 thread scripts\cp\_utility::func_5106(param_02);
	return var_03;
}

//Function Number: 63
func_13B0E(param_00,param_01)
{
	self endon("death");
	self.var_222 endon("disconnect");
	for(;;)
	{
		self waittill("trigger",var_02);
		if(scripts\cp\_utility::func_9F19(var_02) && !isdefined(var_02.var_10D94) && var_02.team != self.var_222.team || var_02 == self.var_222)
		{
			if(param_01)
			{
				if(var_02 == self.var_222)
				{
					continue;
				}
			}

			var_02 notify("start_plasma_stand");
			var_02 thread func_10D82(param_00,self.var_222,33,0.5,self);
			var_02 thread func_13AAB(self);
		}
	}
}

//Function Number: 64
func_13AAB(param_00)
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		if(!isdefined(param_00) || !self istouching(param_00))
		{
			self notify("plasma_dot_end");
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 65
func_13A91()
{
	level endon("game_ended");
	self endon("death");
	scripts\common\utility::waittill_any_3("plasma_dot_end");
	self.var_10D94 = undefined;
	self.var_10D93 = undefined;
	self.var_83E1 = undefined;
	self.var_9B81 = undefined;
	stopfxontag(scripts\common\utility::getfx("glob_plasma_trail_enemy"),self,"j_mainroot");
	stopfxontag(scripts\common\utility::getfx("player_plasma_enemy"),self,"j_mainroot");
	stopfxontag(scripts\common\utility::getfx("player_plasma_friendly"),self,"j_mainroot");
}

//Function Number: 66
func_13B5A(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("plasma_dot_end");
	param_01 endon("disconnect");
	self waittill("start_plasma_linger");
	var_02 = 1;
	var_03 = 25;
	var_04 = 1;
	self.var_10D94 = undefined;
	self.var_10D93 = 1;
	var_05 = function_01E1(scripts\common\utility::getfx("player_plasma_screen_linger"),self geteye(),self);
	triggerfx(var_05);
	var_05 thread scripts\cp\_utility::func_5106(1);
	var_05 thread scripts\cp\_utility::func_51C7(self);
	var_05 thread func_51CA(self);
	thread func_4D61(param_00,param_01,var_03,var_04,var_02,"start_plasma_stand","plasma_dot_end");
}

//Function Number: 67
func_51C3(param_00)
{
	self endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 waittill("plasma_dot_end");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 68
func_511B(param_00,param_01,param_02,param_03)
{
	param_02 endon("death");
	wait(param_00);
	if(isdefined(param_02) && isdefined(self))
	{
		playfxontagforclients(scripts\common\utility::getfx(param_01),param_02,param_03,self);
	}
}

//Function Number: 69
func_10B72(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	self endon("disconnect");
	param_01 endon("disconnect");
	if(isdefined(param_04))
	{
		param_04 endon("death");
	}

	var_05 = int(param_02 / 4);
	var_06 = param_03;
	childthread func_4D61(param_00,param_01,var_05,var_06,undefined,"start_stage2_plasma");
	wait(1);
	self notify("start_stage2_plasma");
	var_05 = int(param_02 / 2);
	var_06 = param_03 / 2;
	childthread func_4D61(param_00,param_01,var_05,var_06,undefined,"start_stage3_plasma");
	wait(0.5);
	self notify("start_stage3_plasma");
	var_05 = param_02;
	var_06 = param_03 / 4;
	childthread func_4D61(param_00,param_01,var_05,var_06);
}

//Function Number: 70
func_4D61(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	self endon("disconnect");
	if(isdefined(param_05))
	{
		self endon(param_05);
	}

	param_01 endon("disconnect");
	if(!isdefined(param_04))
	{
		for(;;)
		{
			self dodamage(param_02,self.origin,param_01,undefined,"MOD_EXPLOSIVE",param_00);
			self.var_6E82 = gettime() + 500;
			wait(param_03);
		}

		return;
	}

	if(param_03 > param_04)
	{
		return;
	}

	var_07 = param_02;
	if(self.health <= var_07)
	{
		self dodamage(param_02,self.origin,param_01,undefined,"MOD_EXPLOSIVE",param_00);
		self.var_6E82 = gettime() + 500;
	}

	while(param_04 > 0)
	{
		if(self.health > 15 && self.health - param_02 < 15)
		{
			param_02 = param_02 - 15 - self.health - param_02;
		}

		if(self.health > var_07 && self.health <= 15)
		{
			param_02 = 1;
		}

		if(param_02 > 0)
		{
			self dodamage(param_02,self.origin,param_01,undefined,"MOD_EXPLOSIVE",param_00);
			self.var_6E82 = gettime() + 500;
		}

		param_04 = param_04 - param_03;
		wait(param_03);
	}

	if(isdefined(param_06))
	{
		self notify(param_06);
	}
}

//Function Number: 71
func_51CA(param_00)
{
	self endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 waittill("start_plasma_stand");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 72
func_511D(param_00,param_01)
{
	self endon("death");
	wait(param_00);
	self playsound(param_01);
}