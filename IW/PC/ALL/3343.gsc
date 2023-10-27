/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3343.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 18 ms
 * Timestamp: 10/27/2023 12:26:36 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level.var_F26B))
	{
		level.var_F26B = [];
	}

	level._effect["microturret_lockon"] = loadfx("vfx/iw7/_requests/mp/super/vfx_microturret_lockon.vfx");
	if(!isdefined(level.var_B726))
	{
		level.var_B726 = [];
	}

	level._effect["shoulder_cannon_charge"] = loadfx("vfx/old/misc/shoulder_cannon_charge");
	level.var_F26B["sentry_microturret"] = spawnstruct();
	level.var_F26B["sentry_microturret"].health = 999999;
	level.var_F26B["sentry_microturret"].maxhealth = 300;
	level.var_F26B["sentry_microturret"].var_32C1 = 10;
	level.var_F26B["sentry_microturret"].var_32C0 = 20;
	level.var_F26B["sentry_microturret"].var_C9D3 = 0.5;
	level.var_F26B["sentry_microturret"].var_C9D1 = 0.75;
	level.var_F26B["sentry_microturret"].var_F269 = "sentry";
	level.var_F26B["sentry_microturret"].var_F268 = "sentry_offline";
	level.var_F26B["sentry_microturret"].var_11901 = 90;
	level.var_F26B["sentry_microturret"].var_10A13 = 0.2;
	level.var_F26B["sentry_microturret"].var_C7FB = 8;
	level.var_F26B["sentry_microturret"].var_461D = 0.1;
	level.var_F26B["sentry_microturret"].var_7645 = 0.3;
	level.var_F26B["sentry_microturret"].var_110EA = "sentry";
	level.var_F26B["sentry_microturret"].var_39B = "micro_turret_gun_zm";
	level.var_F26B["sentry_microturret"].var_B91A = "vehicle_drone_backup_buddy_gun";
	level.var_F26B["sentry_microturret"].var_B924 = "weapon_sentry_chaingun_obj";
	level.var_F26B["sentry_microturret"].var_B925 = "weapon_sentry_chaingun_obj_red";
	level.var_F26B["sentry_microturret"].var_B91D = "vehicle_drone_backup_buddy_gun";
	level.var_F26B["sentry_microturret"].var_17B = &"SENTRY_PICKUP";
	level.var_F26B["sentry_microturret"].var_16F = 1;
	level.var_F26B["sentry_microturret"].var_115EB = "used_sentry";
	level.var_F26B["sentry_microturret"].var_10085 = 0;
	level.var_F26B["sentry_microturret"].var_13523 = "sentry_destroyed";
	level.var_F26B["sentry_microturret"].var_EC44 = "destroyed_sentry";
	level.var_F26B["sentry_microturret"].var_ACB6 = "tag_fx";
}

//Function Number: 2
func_E13D()
{
	self notify("remove_microTurret");
}

//Function Number: 3
func_B719(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("remove_microTurret");
	var_01 = "power_microTurret";
	if(!scripts\cp\_utility::func_9F19(self))
	{
		param_00 delete();
		return;
	}

	param_00 waittill("missile_stuck",var_02);
	if(isdefined(var_02) && isdefined(var_02.var_222))
	{
		thread func_CC21(param_00);
		return;
	}

	if(!scripts\cp\_weapon::func_9E54(param_00.origin,level.var_9B0B,self,undefined,0))
	{
		thread func_CC21(param_00);
		return;
	}

	self notify("powers_microTurret_used");
	self playlocalsound("trophy_turret_plant_plr");
	self playsoundtoteam("trophy_turret_plant_npc","allies",self);
	self playsoundtoteam("trophy_turret_plant_npc","axis",self);
	var_03 = spawnturret("misc_turret",param_00.origin,"micro_turret_gun_zm");
	var_03 setmodel("micro_turret_wm");
	var_03.angles = param_00.angles;
	var_03.var_222 = self;
	var_03.team = self.team;
	var_03.var_13C2E = "micro_turret_zm";
	var_03 method_81F5();
	var_03 makeunusable();
	self.var_131A0 = var_03;
	var_03.var_1E2D = 100;
	if(level.teambased)
	{
		var_03 method_835E(self.team);
	}

	var_03.var_F26E = "sentry_microturret";
	var_03 method_830F("sentry_offline");
	var_03 method_8336(self);
	var_03 method_82FB(180);
	var_03 method_8330(180);
	var_03 method_82B6(90);
	var_03 method_8353(45);
	var_03 method_82C9(0.3,"pitch");
	var_03 method_82C9(0.3,"yaw");
	var_03 method_82C8(0.65);
	var_03 thread func_B6EA();
	var_03 method_831F(self);
	if(isdefined(var_02))
	{
		var_03 scripts\cp\_weapon::func_69FF(var_02);
	}

	var_03.var_1A4A = scripts\common\utility::spawn_tag_origin(var_03.origin,var_03.angles);
	var_03.var_1A4A linkto(var_03,"tag_origin",(0,0,0),(0,0,0));
	var_03 thread func_F241();
	var_03 thread func_F242();
	var_03 thread func_13A7A(self);
	var_03 setcandamage(0);
	var_03.var_11196 = 0;
	var_03 thread func_139C8();
	thread func_13A59(var_03);
	param_00 delete();
}

//Function Number: 4
func_F241()
{
	self endon("death");
	level endon("game_ended");
	self.health = level.var_F26B[self.var_F26E].health;
	self.maxhealth = level.var_F26B[self.var_F26E].maxhealth;
	self.var_E1 = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!scripts\cp\_damage::func_7415(self.var_222,var_01,0))
		{
			continue;
		}

		if(isdefined(var_08) && var_08 & level.var_92C4)
		{
			self.var_1390E = 1;
		}

		if(var_04 == "MOD_MELEE")
		{
			self.var_E1 = self.var_E1 + self.maxhealth;
		}

		var_0A = var_00;
		if(isplayer(var_01))
		{
			var_01 scripts\cp\_damage::func_12E84("sentry");
			if(var_01 scripts\cp\_utility::_hasperk("specialty_armorpiercing"))
			{
				var_0A = var_00 * level.var_218B;
			}
		}

		if(isdefined(var_01.var_222) && isplayer(var_01.var_222))
		{
			var_01.var_222 scripts\cp\_damage::func_12E84("sentry");
		}

		self.var_E1 = self.var_E1 + var_0A;
		if(self.var_E1 >= self.maxhealth)
		{
			if(isplayer(var_01) && !isdefined(self.var_222) || var_01 != self.var_222)
			{
				var_01 notify("destroyed_killstreak");
			}

			if(isdefined(self.var_222))
			{
				self.var_222 thread scripts\cp\_utility::func_AAEC(level.var_F26B[self.var_F26E].var_13523,undefined,undefined,self.origin);
			}

			self notify("death");
			return;
		}
	}
}

//Function Number: 5
func_F242()
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	self method_80F7();
	self setmodel(level.var_F26B[self.var_F26E].var_B91D);
	func_F257();
	self method_82D1(40);
	if(isdefined(self.var_3A9D))
	{
		self method_8335(undefined);
	}

	self method_8336(undefined);
	self method_835A(0);
	if(isdefined(self.var_C840))
	{
		self.var_C840 delete();
	}

	self playsound("sentry_explode");
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

	if(isdefined(self))
	{
		thread func_F23F();
	}
}

//Function Number: 6
func_F257()
{
	self method_830F(level.var_F26B[self.var_F26E].var_F268);
	self makeunusable();
	var_00 = self getentitynumber();
	switch(self.var_F26E)
	{
		case "gl_turret":
			break;

		default:
			func_E11F(var_00);
			break;
	}

	if(level.teambased)
	{
		scripts\cp\_utility::func_F877("none",(0,0,0));
		return;
	}

	if(isdefined(self.var_222))
	{
		scripts\cp\_utility::func_F7F2(undefined,(0,0,0));
	}
}

//Function Number: 7
func_E11F(param_00)
{
	level.var_12A83[param_00] = undefined;
}

//Function Number: 8
func_F23F()
{
	self notify("sentry_delete_turret");
	self endon("sentry_delete_turret");
	if(isdefined(self.var_9B05))
	{
		self.var_9B05 func_E2E0();
		self.var_9B05 func_E2E8();
		self notify("deleting");
		self useby(self.var_9B05);
		wait(1);
	}
	else
	{
		wait(1.5);
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
func_E2E8()
{
	if(isdefined(self.var_E2E6))
	{
		scripts\cp\_utility::func_12C6(self.var_E2E6);
		self.var_E2E6 = undefined;
	}
}

//Function Number: 11
func_13A59(param_00)
{
	self notify("turret_deleted");
	self endon("turret_deleted");
	param_00 endon("death");
	scripts\common\utility::waittill_any_3("death","disconnect");
	param_00 delete();
	self notify("microTurret_update",-1);
}

//Function Number: 12
func_13A7A(param_00)
{
	self waittill("death");
	param_00 notify("microTurret_update",-1);
}

//Function Number: 13
func_139C8()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		func_B713(var_01);
	}
}

//Function Number: 14
func_B713()
{
	self method_830F("sentry_offline");
	func_B6F1();
}

//Function Number: 15
func_B6EA()
{
	self endon("death");
	level endon("game_ended");
	self.var_1E2D = 100;
	wait(1);
	for(;;)
	{
		if(!self.var_11196 && !func_B701())
		{
			func_B717();
		}

		if(!self.var_11196 && func_B701())
		{
			func_B6EB();
		}

		if(self.var_11196)
		{
			func_B713();
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 16
func_B701()
{
	return isdefined(self.var_1A4A) && isdefined(self.var_1A4A.var_23EA);
}

//Function Number: 17
func_B717()
{
	self endon("stunned");
	self endon("death");
	if(isdefined(self.var_222))
	{
		self.var_222 endon("disconnect");
	}

	self method_830F("manual");
	self method_81D8();
	if(func_B701())
	{
		func_B6F1();
	}

	for(;;)
	{
		var_00 = anglestoforward(self gettagangles("tag_flash"));
		var_01 = scripts\cp\_agent_utils::func_7DB0("axis");
		var_02 = [];
		var_03 = [];
		foreach(var_05 in var_01)
		{
			if(!func_B71A(var_05))
			{
				continue;
			}

			var_06 = var_05.origin - self gettagorigin("tag_dummy");
			var_07 = vectornormalize(var_06);
			var_08 = vectordot(var_06,var_07);
			var_09 = scripts\common\utility::func_1E7E(var_00,var_07);
			var_0A = 1 - var_08 / 800;
			var_0B = 1 - var_09 / 180;
			var_0C = var_0A * 0.5 + var_0B * 0.8;
			var_02[var_02.size] = var_05;
			var_03[var_03.size] = var_0C;
		}

		for(;;)
		{
			var_0E = 0;
			for(var_0F = 0;var_0F < var_02.size - 1;var_0F++)
			{
				var_10 = var_02[var_0F];
				var_11 = var_03[var_0F];
				if(var_11 < var_03[var_0F])
				{
					var_02[var_0F] = var_02[var_0F + 1];
					var_03[var_0F] = var_03[var_0F + 1];
					var_02[var_0F + 1] = var_10;
					var_03[var_0F + 1] = var_11;
					var_0E = 1;
				}
			}

			if(!var_0E)
			{
				break;
			}
		}

		for(var_0F = 0;var_0F < var_02.size;var_0F++)
		{
			var_12 = var_02[var_0F];
			var_13 = func_B714(var_12);
			if(isdefined(var_13))
			{
				func_B70D(var_12,var_13);
				return;
			}
		}

		wait(0.1);
	}
}

//Function Number: 18
func_B70D(param_00,param_01)
{
	if(!isdefined(self.var_1A4A))
	{
		return 0;
	}

	self.var_1A4A.var_23EA = param_00;
	self.var_1A4A.var_23EB = param_01;
	self.var_1A4A linkto(param_00,param_01,(0,0,0),(0,0,0));
	self method_8347(self.var_1A4A);
}

//Function Number: 19
func_B714(param_00)
{
	var_01 = undefined;
	var_02 = physics_createcontents(["physicscontents_solid","physicscontents_vehicle","physicscontents_glass","physicscontents_ainosight","physicscontents_sky"]);
	var_03 = self gettagorigin("tag_dummy");
	if(isdefined(param_00.agent_type) && param_00.agent_type == "zombie_brute")
	{
		return undefined;
	}

	if(isplayer(param_00) || isagent(param_00))
	{
		var_04 = "j_spine4";
		var_05 = param_00 gettagorigin(var_04);
		if(!isdefined(var_01))
		{
			var_06 = function_0287(var_03,var_05,var_02,self,0,"physicsquery_closest");
			var_07 = !isdefined(var_06) || var_06.size == 0;
			var_01 = scripts\common\utility::func_116D7(var_07,var_04,var_01);
		}

		if(!isdefined(var_01))
		{
			if(!scripts\cp\_utility::func_8BB1(param_00.model,"tag_eye"))
			{
				return undefined;
			}

			var_04 = "tag_eye";
			var_05 = param_00 gettagorigin(var_04);
			if(!isdefined(var_01))
			{
				var_06 = function_0287(var_03,var_05,var_02,self,0,"physicsquery_closest");
				var_07 = !isdefined(var_06) || var_06.size == 0;
				var_01 = scripts\common\utility::func_116D7(var_07,var_04,var_01);
			}
		}

		if(!isdefined(var_01))
		{
			var_05 = param_00.origin;
			if(!isdefined(var_01))
			{
				var_06 = function_0287(var_03,var_05,var_02,self,0,"physicsquery_closest");
				var_07 = !isdefined(var_06) || var_06.size == 0;
				var_01 = scripts\common\utility::func_116D7(var_07,var_04,var_01);
			}
		}
	}
	else
	{
		var_04 = "tag_origin";
		var_05 = var_01 gettagorigin(var_05);
		if(!isdefined(var_01))
		{
			var_06 = function_0287(var_03,var_05,var_02,self,0,"physicsquery_closest");
			var_07 = !isdefined(var_06) || var_06.size == 0;
			var_01 = scripts\common\utility::func_116D7(var_07,var_04,var_01);
		}
	}

	return var_01;
}

//Function Number: 20
func_B6F1()
{
	if(isdefined(self.var_1A4A))
	{
		self.var_1A4A linkto(self,"tag_origin",(0,0,0),(0,0,0));
		self.var_1A4A.var_23EA = undefined;
		self.var_1A4A.var_23EB = undefined;
	}

	self method_807E();
}

//Function Number: 21
func_B71A(param_00)
{
	if(isplayer(param_00) || isagent(param_00))
	{
		if(!isalive(param_00))
		{
			return 0;
		}
	}

	if(self.team == param_00.team)
	{
		return 0;
	}

	if(distancesquared(param_00.origin,self.origin) > 640000)
	{
		return 0;
	}

	return 1;
}

//Function Number: 22
func_B6EB()
{
	self endon("stunned");
	self endon("lostTarget");
	self method_830F("manual");
	self method_81D9();
	thread func_B721();
	func_B704();
	func_B6EC();
}

//Function Number: 23
func_B6EC()
{
	var_00 = function_0240("micro_turret_gun_zm");
	for(;;)
	{
		if(func_B701())
		{
			var_01 = self method_8161(0);
			if(!isdefined(self.var_1A4A))
			{
				self method_8347(self.var_1A4A);
			}

			if(func_B715())
			{
				self method_837E();
				self.var_1E2D--;
				if(self.var_1E2D <= 0)
				{
					self.var_222 thread func_B6F4(self);
				}
			}

			wait(var_00);
			continue;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 24
func_B715()
{
	return isdefined(self.var_1A4A) && isdefined(self.var_1A4A.var_23EB);
}

//Function Number: 25
func_B6F4(param_00)
{
	param_00 notify("death");
}

//Function Number: 26
func_B6F5()
{
	self notify("microTurret_destroyAll");
	if(isdefined(self.var_B726))
	{
		foreach(var_01 in self.var_B726)
		{
			func_B6F4(var_01);
		}
	}

	self.var_B726 = undefined;
}

//Function Number: 27
func_B721()
{
	self endon("death");
	self endon("stunned");
	level endon("game_ended");
	func_B722();
	func_B6F1();
	self notify("lostTarget");
}

//Function Number: 28
func_B704()
{
	playfxontag(scripts\common\utility::getfx("microturret_lockon"),self,"tag_flash");
	var_00 = func_B6FD();
	if(isplayer(var_00) || isagent(var_00))
	{
		thread func_B705(var_00);
	}

	wait(0.6);
	self notify("lockOnEnded");
}

//Function Number: 29
func_B705(param_00)
{
	self endon("lockOnEnded");
	param_00 endon("death");
	param_00 endon("disconnect");
	var_01 = 0;
	var_02 = 0.2;
	for(;;)
	{
		param_00 playlocalsound("ball_drone_targeting");
		wait(var_02);
		var_01 = var_01 + var_02;
	}

	param_00 playlocalsound("ball_drone_lockon");
}

//Function Number: 30
func_B6FD()
{
	if(func_B701())
	{
		return self.var_1A4A.var_23EA;
	}

	return undefined;
}

//Function Number: 31
func_B722()
{
	var_00 = func_B6FD();
	var_00 endon("death");
	var_00 endon("disconnect");
	var_01 = undefined;
	var_02 = func_B6FD();
	while(isdefined(var_02) && var_02 == var_00)
	{
		var_02 = func_B6FD();
		if(!isdefined(var_02) || var_02 != var_00)
		{
			break;
		}

		if(var_02 scripts\cp\_utility::_hasperk("specialty_blindeye"))
		{
			break;
		}

		if(isdefined(var_01) && gettime() > var_01)
		{
			break;
		}

		var_03 = func_B714(var_02);
		if(!isdefined(var_03))
		{
			if(!isdefined(var_01))
			{
				var_01 = gettime() + 1000;
			}

			wait(0.1);
			continue;
		}

		func_B70D(var_02,var_03);
		var_01 = undefined;
		wait(0.1);
	}
}

//Function Number: 32
func_B6EE(param_00)
{
	self endon("turret_toggle");
	self endon("death");
	self endon("stop_shooting");
	level endon("game_ended");
	var_01 = self;
	var_02 = level._effect["shoulder_cannon_charge"];
	var_03 = function_0240("micro_turret_gun_zm");
	var_04 = 0.01;
	while(self.var_1E2D > 0)
	{
		if(self.var_1E2D <= 20)
		{
			var_05 = self.var_1E2D;
		}
		else
		{
			var_05 = randomintrange(10,20);
		}

		for(var_06 = 0;var_06 < var_05;var_06++)
		{
			if(isdefined(var_01.var_93AF) && var_01.var_93AF)
			{
				break;
			}

			var_07 = self method_8166(1);
			if(isdefined(var_07) && func_3874(var_07))
			{
				self method_837E();
				wait(var_03);
				self.var_1E2D--;
				if(self.var_1E2D < 0)
				{
					self.var_1E2D = 0;
				}

				param_00 notify("microTurret_update",self.var_1E2D * var_04);
				if(isdefined(param_00.var_38D8))
				{
					param_00.var_38D8 delete();
				}
			}
		}

		wait(randomfloatrange(0.5,0.75));
	}

	if(self.var_1E2D <= 0)
	{
		waittillframeend;
		param_00 notify("turret_deleted");
		self delete();
	}
}

//Function Number: 33
func_58ED(param_00,param_01)
{
	var_02 = level._effect["shoulder_cannon_charge"];
	playfxontag(var_02,self,"tag_flash");
	var_03 = self method_8166(0);
	while(param_00 > 0)
	{
		param_01 playlocalsound("ball_drone_targeting");
		wait(0.2);
		param_00 = param_00 - 0.2;
	}

	param_01 playlocalsound("ball_drone_lockon");
}

//Function Number: 34
func_B6EF()
{
	self notify("stop_shooting");
	if(isdefined(self.var_92FD))
	{
		self method_8305(self.var_92FD);
	}
}

//Function Number: 35
func_3874(param_00)
{
	var_01 = 1;
	if(isplayer(param_00))
	{
		if(!scripts\cp\_utility::func_9F19(param_00) || param_00.sessionstate != "playing")
		{
			return 0;
		}
	}

	if(level.teambased && isdefined(param_00.team) && param_00.team == self.team)
	{
		return 0;
	}

	if(isdefined(param_00.team) && param_00.team == "spectator")
	{
		return 0;
	}

	if(isplayer(param_00) && param_00 == self.var_222)
	{
		return 0;
	}

	if(isplayer(param_00) && isdefined(param_00.var_10916) && gettime() - param_00.var_10916 / 1000 <= 5)
	{
		return 0;
	}

	if(isplayer(param_00) && param_00 scripts\cp\_utility::_hasperk("specialty_blindeye"))
	{
		return 0;
	}

	if(distancesquared(param_00.origin,self.origin) > 4000000)
	{
		return 0;
	}

	if(isdefined(param_00.var_9EE2) && param_00.var_9EE2)
	{
		return 0;
	}

	return var_01;
}

//Function Number: 36
func_CC21(param_00)
{
	self notify("powers_microTurret_used",0);
	scripts\cp\_weapon::func_CC16(param_00.var_13C2E,1,param_00.origin);
	param_00 delete();
}