/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\assault_turret_network.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 1776 ms
 * Timestamp: 10/27/2023 12:12:15 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level.var_23AB))
	{
		level.var_23AB = [];
	}

	var_00 = spawnstruct();
	var_00.var_39B = "sentry_minigun_mp";
	var_00.var_B91A = "weapon_ceiling_sentry_temp";
	var_00.var_B91C = "weapon_sentry_chaingun_bombsquad";
	var_00.var_B91D = "weapon_sentry_chaingun_destroyed";
	var_00.maxhealth = 670;
	var_00.var_32C1 = 20;
	var_00.var_32C0 = 120;
	var_00.var_C9D3 = 0.15;
	var_00.var_C9D1 = 0.35;
	var_00.var_11901 = 90;
	var_00.var_10A13 = 0.05;
	var_00.var_C7FB = 4;
	var_00.var_461D = 0.1;
	var_00.var_7645 = 0.3;
	var_00.var_ACB6 = "tag_fx";
	level.var_23AB["turret"] = var_00;
}

//Function Number: 2
func_FAF1(param_00,param_01)
{
	wait(5);
	var_02 = getent(param_01,"targetname");
	var_03 = getentarray(param_00,"targetname");
	var_02.var_F88D = level.var_23AB["turret"];
	var_02.var_12A83 = [];
	var_02.team = "";
	var_04 = 0;
	foreach(var_06 in var_03)
	{
		var_02.var_12A83[var_04] = func_108E9(var_06,var_02);
		var_04++;
	}

	func_45CC(var_02);
}

//Function Number: 3
func_108E9(param_00,param_01)
{
	var_02 = spawnturret("misc_turret",param_00.origin - (0,0,32),param_01.var_F88D.var_39B);
	var_02.angles = param_00.angles;
	if(param_00.model != "")
	{
		param_00 delete();
	}

	var_02 setmodel(param_01.var_F88D.var_B91A);
	var_02.var_45C3 = param_01;
	var_02.var_222 = param_01;
	var_02 method_82FB(80);
	var_02 method_8330(80);
	var_02 method_82B6(60);
	var_02 method_82D1(15);
	var_03 = spawn("script_model",var_02 gettagorigin("tag_laser"));
	var_03 linkto(var_02);
	var_02.var_A63A = var_03;
	var_02.var_A63A setscriptmoverkillcam("explosive");
	var_02 method_835B(1);
	var_02 thread func_12A6A();
	var_02 thread func_12A6B();
	var_02 thread func_12A9B();
	var_02 setcandamage(1);
	var_02 thread func_12A5C(param_01.var_F88D.var_B91C);
	return var_02;
}

//Function Number: 4
func_12A53(param_00)
{
	self method_82D1(15);
	self method_830F("sentry");
	self.var_222 = param_00;
	self method_8336(param_00);
	self.team = self.var_222.team;
	self method_835E(self.team);
	thread func_12A59();
	if(isdefined(self.team))
	{
		scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground",param_00);
	}

	thread func_12A5A();
	thread scripts\mp\_weapons::func_57EB(self.var_45C3.var_F88D.var_ACB6);
	func_12A8E();
	self method_835A(1,"sentry");
	func_1862(self getentitynumber());
}

//Function Number: 5
func_12A5D()
{
	self method_82D1(40);
	self method_830F("sentry_offline");
	self method_8336(undefined);
	scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool,self.sentientpoolindex);
	self.var_222 = undefined;
	self.team = undefined;
	var_00 = self getentitynumber();
	func_E11F(var_00);
	self method_835A(0,"sentry");
	func_12A6F();
	scripts\mp\_weapons::func_11061();
	self notify("deactivated");
}

//Function Number: 6
func_12A59()
{
	self endon("death");
	level endon("game_ended");
	self.var_B941 = 0;
	var_00 = self.var_45C3.var_F88D;
	thread func_12A6E(function_0240(var_00.var_39B),var_00.var_C7FB,var_00.var_461D);
	for(;;)
	{
		scripts\common\utility::waittill_either("turretstatechange","cooled");
		if(self method_81A0())
		{
			self method_81D9();
			thread func_F23B();
			continue;
		}

		self method_81D8();
		func_F25B();
		thread func_F23C();
	}
}

//Function Number: 7
func_F23B()
{
	self endon("death");
	self endon("stop_shooting");
	level endon("game_ended");
	func_F25C();
	var_00 = self.var_45C3.var_F88D;
	var_01 = function_0240(var_00.var_39B);
	var_02 = var_00.var_32C1;
	var_03 = var_00.var_32C0;
	var_04 = var_00.var_C9D3;
	var_05 = var_00.var_C9D1;
	for(;;)
	{
		var_06 = randomintrange(var_02,var_03 + 1);
		for(var_07 = 0;var_07 < var_06 && !self.var_C7F9;var_07++)
		{
			self method_837E();
			self notify("bullet_fired");
			self.var_8CDE = self.var_8CDE + var_01;
			wait(var_01);
		}

		wait(randomfloatrange(var_04,var_05));
	}
}

//Function Number: 8
func_F23C()
{
	self notify("stop_shooting");
}

//Function Number: 9
func_F25C()
{
	thread func_12A98();
	while(self.var_B941 < self.var_45C3.var_F88D.var_10A13)
	{
		self.var_B941 = self.var_B941 + 0.1;
		wait(0.1);
	}
}

//Function Number: 10
func_F25B()
{
	self.var_B941 = 0;
}

//Function Number: 11
func_12A6E(param_00,param_01,param_02)
{
	self endon("death");
	self.var_8CDE = 0;
	self.var_C7F9 = 0;
	var_03 = 0;
	var_04 = 0;
	for(;;)
	{
		if(self.var_8CDE != var_03)
		{
			wait(param_00);
		}
		else
		{
			self.var_8CDE = max(0,self.var_8CDE - 0.05);
		}

		if(self.var_8CDE > param_01)
		{
			self.var_C7F9 = 1;
			playfxontag(scripts\common\utility::getfx("sentry_smoke_mp"),self,"tag_flash");
			while(self.var_8CDE)
			{
				self.var_8CDE = max(0,self.var_8CDE - param_02);
				wait(0.1);
			}

			self.var_C7F9 = 0;
			self notify("cooled");
		}

		var_03 = self.var_8CDE;
		wait(0.05);
	}
}

//Function Number: 12
func_12A5C(param_00)
{
	var_01 = spawn("script_model",self.origin);
	var_01.angles = self.angles;
	var_01 hide();
	var_01 thread scripts\mp\_weapons::func_2C69(self.var_222);
	var_01 setmodel(param_00);
	var_01 linkto(self);
	var_01 method_82C7(0);
	self.var_2C68 = var_01;
	level notify("update_bombsquad");
	self waittill("death");
	if(isdefined(var_01))
	{
		var_01 delete();
	}
}

//Function Number: 13
func_12A8E()
{
	if(isdefined(self.var_2C68))
	{
		self.var_2C68 show();
		level notify("update_bombsquad");
	}
}

//Function Number: 14
func_12A6F()
{
	if(isdefined(self.var_2C68))
	{
		self.var_2C68 hide();
		level notify("update_bombsquad");
	}
}

//Function Number: 15
func_12A6A(param_00)
{
	scripts\mp\_damage::func_B9C6(param_00,"sentry",::func_12A6C,::func_12A79,1);
}

//Function Number: 16
func_12A79(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	if(param_02 == "MOD_MELEE")
	{
		var_05 = self.maxhealth * 0.34;
	}

	var_05 = scripts\mp\_damage::func_89C6(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_89AC(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8975(param_01,param_02,var_05);
	return var_05;
}

//Function Number: 17
func_12A6C(param_00,param_01,param_02,param_03)
{
}

//Function Number: 18
func_12A9B()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		scripts\mp\_weapons::func_11061();
		playfxontag(scripts\common\utility::getfx("emp_stun"),self,"tag_aim");
		self method_82D1(40);
		self method_830F("sentry_offline");
		wait(var_01);
		self method_82D1(15);
		self method_830F("sentry");
		thread scripts\mp\_weapons::func_57EB(self.var_45C3.var_F88D.var_ACB6);
	}
}

//Function Number: 19
func_12A6B()
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	func_12A5D();
	self setmodel(self.var_45C3.var_F86F.var_B91D);
	self method_82D1(40);
	if(isdefined(self.var_9B05))
	{
		self useby(self.var_9B05);
	}

	self playsound("sentry_explode");
	if(isdefined(self.var_9B05))
	{
		playfxontag(scripts\common\utility::getfx("sentry_explode_mp"),self,"tag_origin");
		playfxontag(scripts\common\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
		self notify("deleting");
		wait(1);
		stopfxontag(scripts\common\utility::getfx("sentry_explode_mp"),self,"tag_origin");
		stopfxontag(scripts\common\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
	}
	else
	{
		playfxontag(scripts\common\utility::getfx("sentry_sparks_mp"),self,"tag_aim");
		self playsound("sentry_explode_smoke");
		var_00 = 8;
		while(var_00 > 0)
		{
			playfxontag(scripts\common\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
			wait(0.4);
			var_00 = var_00 - 0.4;
		}

		playfx(scripts\common\utility::getfx("sentry_explode_mp"),self.origin + (0,0,10));
		self notify("deleting");
	}

	scripts\mp\_weapons::func_66A8();
	if(isdefined(self.var_A63A))
	{
		self.var_A63A delete();
	}

	self delete();
}

//Function Number: 20
func_12A5A()
{
	self endon("death");
	self endon("deactivated");
	level endon("game_ended");
	for(;;)
	{
		wait(3);
		self playsound("sentry_gun_beep");
	}
}

//Function Number: 21
func_12A98()
{
	self endon("death");
	self playsound("sentry_gun_beep");
	wait(0.1);
	self playsound("sentry_gun_beep");
	wait(0.1);
	self playsound("sentry_gun_beep");
}

//Function Number: 22
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
		wait(self.var_45C3.var_F88D.var_7645);
	}
}

//Function Number: 23
func_1862(param_00)
{
	level.var_12A83[param_00] = self;
}

//Function Number: 24
func_E11F(param_00)
{
	level.var_12A83[param_00] = undefined;
}

//Function Number: 25
func_45CC(param_00)
{
	var_01 = undefined;
	if(isdefined(param_00.script_noteworthy))
	{
		var_01 = getent(param_00.script_noteworthy,"targetname");
	}

	if(!isdefined(var_01))
	{
		var_01 = spawn("script_model",param_00.origin);
		var_01 setmodel("laptop_toughbook_open_on_iw6");
		var_01.angles = param_00.angles;
	}

	var_01.health = 99999;
	param_00.visuals = var_01;
	var_02 = scripts\mp\_gameobjects::func_4A2E("axis",param_00,[var_01],(0,0,64));
	var_02.label = "control_panel_" + param_00.var_336;
	var_02.var_92B8 = "use";
	var_02 func_45CD();
	param_00.var_767B = var_02;
}

//Function Number: 26
func_45CF(param_00)
{
	self.var_222 = param_00;
	self.team = param_00.team;
	self.visuals.var_222 = param_00;
	foreach(var_02 in self.var_12A83)
	{
		if(isdefined(var_02) && isalive(var_02))
		{
			var_02 thread func_12A53(param_00);
		}
	}

	self.visuals thread scripts\mp\_weapons::func_57EB("tag_fx");
	thread func_45CA();
}

//Function Number: 27
func_45CB()
{
	foreach(var_01 in self.var_12A83)
	{
		if(isdefined(var_01) && isalive(var_01))
		{
			var_01 thread func_12A5D();
		}
	}

	self.visuals scripts\mp\_weapons::func_11061();
	self.visuals.var_222 = undefined;
	self.var_222 = undefined;
	self.team = undefined;
}

//Function Number: 28
func_45CA()
{
	self endon("death");
	level endon("game_ended");
	self notify("sentry_handleOwner");
	self endon("sentry_handleOwner");
	self.var_222 scripts\common\utility::waittill_any_3("disconnect","joined_team","joined_spectators");
	self.var_767B func_45C9(undefined);
}

//Function Number: 29
func_45C6(param_00)
{
}

//Function Number: 30
func_45C7(param_00,param_01,param_02)
{
}

//Function Number: 31
func_45C8(param_00)
{
	func_E27D(param_00);
	self.trigger func_45CF(param_00);
	func_45CE();
}

//Function Number: 32
func_45C9(param_00)
{
	func_E27D(param_00);
	self.trigger func_45CB();
	func_45CD();
}

//Function Number: 33
func_45CD()
{
	scripts\mp\_gameobjects::func_1CAF("friendly");
	scripts\mp\_gameobjects::func_FB08(1);
	scripts\mp\_gameobjects::func_FB14(1);
	scripts\mp\_gameobjects::func_FB07(&"MP_BREACH_OPERATE_TURRET_ON_ACTION");
	scripts\mp\_gameobjects::func_FB06(&"MP_BREACH_OPERATE_TURRET_ON");
	self.var_C4CB = ::func_45C6;
	self.var_C50D = ::func_45C7;
	self.var_C5BB = ::func_45C8;
}

//Function Number: 34
func_45CE()
{
	scripts\mp\_gameobjects::func_1CAF("enemy");
	scripts\mp\_gameobjects::func_FB08(2);
	scripts\mp\_gameobjects::func_FB14(1);
	scripts\mp\_gameobjects::func_FB07(&"MP_BREACH_OPERATE_TURRET_OFF_ACTION");
	scripts\mp\_gameobjects::func_FB06(&"MP_BREACH_OPERATE_TURRET_OFF");
	self.var_C4CB = ::func_45C6;
	self.var_C50D = ::func_45C7;
	self.var_C5BB = ::func_45C9;
}

//Function Number: 35
func_E27D(param_00)
{
	if(isdefined(param_00))
	{
		param_00 setclientomnvar("ui_securing_progress",1);
		param_00 setclientomnvar("ui_securing",0);
		param_00.var_12B26 = undefined;
	}
}