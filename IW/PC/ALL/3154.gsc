/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3154.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 29
 * Decompile Time: 11 ms
 * Timestamp: 10/27/2023 12:26:18 AM
*******************************************************************/

//Function Number: 1
func_F130()
{
	var_00 = [];
	var_00["seekerMeleeGrab"] = %equip_seeker_attack_player;
	var_00["seekerMeleeGrab_win"] = %equip_seeker_attack_win_player;
	var_00["seekerMeleeGrab_lose"] = %equip_seeker_attack_lose_player;
	return var_00;
}

//Function Number: 2
func_F127(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_B55B.target;
	if(isplayer(var_04))
	{
		return 0;
	}

	self.var_B55B.var_13D8A = 1;
	var_04.var_B55B.var_13D8A = 0;
	var_05 = func_F14B(self,self.var_B55B.target);
	self.var_B55B.var_F2 = var_05[0];
	self.var_B55B.var_C364 = var_05[1];
	var_04.var_B55B.var_F2 = self.var_B55B.var_F2;
	var_06 = func_3EB4(param_00,param_02,self.var_B55B.var_F2);
	var_07 = vectortoyaw(self.origin - self.var_B55B.target.origin);
	var_08 = (0,self.var_B55B.var_C364 + var_07,0);
	self.var_B55B.var_10D6D = self.angles;
	var_04.var_B55B.var_10D6D = var_08;
	var_04.ignoreme = 1;
	self.ignoreme = 1;
	self notify("meleegrab_start");
	self.var_3135.var_1152B = 1;
	return 1;
}

//Function Number: 3
func_F14B(param_00,param_01)
{
	var_02 = param_01.angles;
	var_03 = param_01.origin;
	var_04 = param_00.origin;
	var_05 = vectortoangles(var_04 - var_03);
	var_06 = angleclamp(var_02[1] - var_05[1]);
	if(var_06 > 315 || var_06 < 45)
	{
		return ["front",0];
	}

	if(var_06 < 135)
	{
		return ["right",90];
	}

	if(var_06 > 225)
	{
		return ["left",-90];
	}

	return ["back",180];
}

//Function Number: 4
func_3EB4(param_00,param_01,param_02)
{
	return lib_0A1A::func_2358(param_01,"jump_" + param_02);
}

//Function Number: 5
func_3EB5(param_00,param_01,param_02)
{
	return lib_0A1A::func_2358(param_01,"loop_" + param_02);
}

//Function Number: 6
func_F172()
{
	var_00 = 0.7071;
	for(;;)
	{
		wait(0.05);
		if(scripts\common\utility::func_13D90(level.player geteye(),level.player getplayerangles(),self.origin,var_00))
		{
			self notify("on_screen");
			return;
		}
	}
}

//Function Number: 7
func_F836()
{
	self.var_2479 = 1;
}

//Function Number: 8
func_13132(param_00)
{
	switch(param_00)
	{
		case "w2":
		case "w1":
		case "w0":
		case "5":
		case "4":
		case "3":
		case "2":
		case "0":
		case "1":
		case "omr":
		case "slt":
			return 1;
	}

	return 0;
}

//Function Number: 9
func_D4CE(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self.var_B55B.var_312F = 1;
	var_04 = self.var_B55B.target;
	var_05 = func_3EB4(param_00,param_01,self.var_B55B.var_F2);
	lib_0A1A::func_232F("melee_attack","begin");
	lib_0F42::func_B5CB(param_01,1);
	if(!isdefined(var_04.var_F184))
	{
		var_04.var_F184 = 1;
		if(isdefined(var_04.var_46BC) && isdefined(var_04.var_C19D) && var_04.var_46BC == "UN" || var_04.var_46BC == "SD")
		{
			if(func_13132(var_04.var_C19D) && !isdefined(level.var_93A9))
			{
				var_06 = var_04.var_46BC + "_" + var_04.var_C19D + "_reaction_seeker_attack";
				var_04 playsound(var_06);
			}
		}
	}

	var_07 = [self];
	var_04 lib_0A1A::func_237C(param_01 + "_victim",var_07);
	function_0277("ent_" + self getentitynumber() + "_seeker_repulsor",-1,self,250,1,self.var_3135.var_652A);
	self method_8016("zonly_physics");
	self linktoblendtotag(self.var_B55B.target,"tag_sync",0,0);
	self method_806F(lib_0A1E::func_2339(),0);
	self method_82EA(param_01,var_05,1,0,1);
	scripts\common\utility::func_5127(0.25,::func_F836);
	var_08 = lib_0A1E::func_231F(param_00,param_01,::lib_0C64::func_B590);
	var_09 = func_3EB5(param_00,param_01,self.var_B55B.var_F2);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_09,1,param_02,1);
	childthread func_F172();
	scripts\common\utility::waittill_notify_or_timeout("on_screen",1.5);
	wait(0.4);
	function_0178("seeker_expl_beep",self.origin);
	wait(0.6);
	function_0278("ent_" + self getentitynumber() + "_seeker_repulsor");
	self.var_9BB9 = 1;
	thread lib_0E26::func_F11E();
}

//Function Number: 10
func_D4CF(param_00,param_01,param_02)
{
	function_0278("ent_" + self getentitynumber() + "_seeker_repulsor");
	if(isdefined(self.var_B55B.target))
	{
		if(isdefined(self.var_B55B.target.var_B55B))
		{
			self.var_B55B.target.var_B55B.var_2720 = 1;
		}

		self.var_B55B.target.ignoreme = 0;
	}
}

//Function Number: 11
func_F148(param_00,param_01,param_02,param_03)
{
	level.player.var_E0 = 1;
	self.var_55B1 = 1;
	self.ignoreme = 1;
	scripts\sp\_utility::func_9193("default_seeker");
	lib_0F3D::func_B60F();
	lib_0A1A::func_232F("melee_attack","begin");
	thread func_F153();
	lib_0A1E::func_2364(param_00,param_01,0);
}

//Function Number: 12
func_F153()
{
	if(isdefined(self.var_72CE))
	{
		var_00 = (0,self.var_72CE,0);
	}
	else
	{
		var_00 = vectortoangles(self.origin - level.player.origin);
		var_00 = (0,var_00[1],0);
	}

	var_01 = lib_0F3D::func_108F6();
	var_01.angles = var_00;
	self notify("jumped_on_player");
	function_0178("seeker_expl_beep",self.origin);
	level.player.var_B55B.var_C92C = self;
	level.player.var_B55B.var_E505 = var_01;
	var_02 = func_F130();
	var_03 = "meleeAnim";
	var_01 method_82E4(var_03,var_02["seekerMeleeGrab"],var_01.var_E6E5,1,0,1);
	thread func_F152(var_01);
	var_04 = getanimlength(var_02["seekerMeleeGrab"]);
	thread func_F142(1.25,0.75);
	var_01 thread lib_0B06::func_10CBF(var_01,var_03);
	var_01 scripts\anim\shared::func_592B(var_03);
}

//Function Number: 13
func_F142(param_00,param_01)
{
	level.player notifyonplayercommand("bash_pressed","+usereload");
	level.player notifyonplayercommand("bash_pressed","+activate");
	scripts\common\utility::waittill_notify_or_timeout_return("death",param_00);
	if(!isdefined(level.player.var_B55B))
	{
		return;
	}

	lib_0E46::func_48C4("j_body",undefined,undefined,undefined,1000,1000,1,1);
	var_02 = func_F13F(param_01);
	if(!isdefined(level.player) || !isdefined(level.player.var_B55B))
	{
		return;
	}

	level.player.var_B55B.var_46B6 = var_02;
	lib_0E46::func_DFE3();
}

//Function Number: 14
func_F13F(param_00)
{
	self endon("meleegrab_interupt");
	param_00 = param_00 * 1000;
	var_01 = 1;
	var_02 = 0.4;
	var_03 = var_01;
	var_04 = undefined;
	for(;;)
	{
		var_05 = level.player scripts\common\utility::waittill_notify_or_timeout_return("bash_pressed",var_03);
		if(isdefined(var_05) && var_05 == "timeout")
		{
			break;
		}

		if(!isdefined(var_04))
		{
			var_04 = gettime();
		}

		if(gettime() - var_04 > param_00)
		{
			return 1;
		}

		var_03 = var_02;
	}

	return 0;
}

//Function Number: 15
func_F146()
{
	self endon("meleegrab_interupt");
	for(;;)
	{
		level.player playrumbleonentity("damage_light");
		earthquake(0.15,0.1,level.player.origin,5000);
		wait(0.05);
	}
}

//Function Number: 16
func_F143()
{
	var_00 = spawn("script_model",self.origin);
	var_00 linkto(self,"j_hip_le",(0,0,0),(0,0,0));
	var_00 lib_0E46::func_48C4(undefined,undefined,"",undefined,undefined,undefined,1,1);
	self waittill("meleegrab_interupt");
	var_00 lib_0E46::func_DFE3();
}

//Function Number: 17
func_F141(param_00)
{
	level.player endon("meleegrab_interupt");
	var_01 = 0.2;
	var_02 = 0.3;
	wait(param_00 - var_01 - 0.05);
	if(isdefined(self.var_B55B.var_B5FE))
	{
		self.var_B55B.var_B5FE destroy();
	}

	self.var_B55B.var_B5FE = newclienthudelem(level.player);
	self.var_B55B.var_B5FE.color = (1,1,1);
	self.var_B55B.var_B5FE settext(&"SCRIPT_PLATFORM_HINT_MELEE_TAP");
	self.var_B55B.var_B5FE.x = 0;
	self.var_B55B.var_B5FE.y = 20;
	self.var_B55B.var_B5FE.alignx = "center";
	self.var_B55B.var_B5FE.aligny = "middle";
	self.var_B55B.var_B5FE.horzalign = "center";
	self.var_B55B.var_B5FE.vertalign = "middle";
	self.var_B55B.var_B5FE.foreground = 1;
	self.var_B55B.var_B5FE.alpha = 0;
	self.var_B55B.var_B5FE.fontscale = 0.5;
	self.var_B55B.var_B5FE.var_175 = 1;
	self.var_B55B.var_B5FE.sort = -1;
	self.var_B55B.var_B5FE endon("death");
	self.var_B55B.var_B5FE fadeovertime(var_01);
	self.var_B55B.var_B5FE changefontscaleovertime(var_01);
	self.var_B55B.var_B5FE.fontscale = 1.3;
	self.var_B55B.var_B5FE.alpha = 1;
	wait(var_01);
	if(!isdefined(self.var_B55B.var_B5FE))
	{
		return;
	}

	self.var_B55B.var_B5FE fadeovertime(var_02);
	self.var_B55B.var_B5FE changefontscaleovertime(var_02);
	self.var_B55B.var_B5FE.fontscale = 1.2;
}

//Function Number: 18
func_F152(param_00)
{
	var_01 = 0.3;
	param_00 thread func_F144(self);
	level.player playerlinktoblend(param_00,"tag_player",var_01,0,var_01);
	level.player method_83F6(5,self.origin);
	lib_0F3D::func_D394("seeker");
	self linktoblendtotag(param_00,"tag_sync",0,0);
	wait(var_01);
	if(!isalive(self))
	{
		return;
	}

	level.player method_84FE();
	thread lib_0F3D::func_5103(0.5,2,20,10,5,60,10,0.1);
	thread lib_0F3D::func_5103(1,2,20,4,50,90,10,0.1);
	thread lib_0F3D::func_510F(1,50,0.4);
	param_00 show();
	level.player thread lib_0F3D::func_D3A3();
	level.player playerlinktodelta(param_00,"tag_player",1,0,0,0,0,1);
	level.player method_81DF(0.4,0,0,15,20,30,0);
	thread func_F151();
}

//Function Number: 19
func_F151()
{
	wait(0.1);
	var_00 = level.player.origin + anglestoforward(level.player.angles) * -100;
	function_01A2(var_00,10,2,1,0.4,0.2,0.2,700,0.2,1,1);
	wait(0.5);
	var_00 = level.player.origin + anglestoforward(level.player.angles) * 100;
	function_01A2(var_00,10,2,1,0.6,0.3,0.3,700,0.2,1,1);
}

//Function Number: 20
func_F145(param_00)
{
	switch(param_00)
	{
		case "unlink":
			self unlink();
			break;

		case "disable_weapons":
			level.player method_80AA();
			level.player method_83F6(10,self.origin);
			break;
	}
}

//Function Number: 21
func_F144(param_00)
{
	self endon("death");
	level.player endon("bt_stop_meleegrab");
	while(!func_F140(param_00))
	{
		wait(0.05);
	}

	level.player notify("meleegrab_interupt");
	if(isdefined(level.player.var_B55B) && isdefined(level.player.var_B55B.var_B5FE))
	{
		level.player.var_B55B.var_B5FE destroy();
	}

	thread lib_0F3D::func_50E8(0.2);
	thread lib_0F3D::func_510F(0.25,65,0.4);
	lib_0F3D::func_D3D2();
	level.player.var_E0 = 0;
	level.player.ignoreme = 0;
	level.player setcandamage(1);
	level.player unlink();
	self delete();
}

//Function Number: 22
func_F140(param_00)
{
	if(!isalive(param_00))
	{
		return 1;
	}

	if(isdefined(param_00.var_2029))
	{
		return 1;
	}

	return 0;
}

//Function Number: 23
func_F149(param_00,param_01,param_02,param_03)
{
	var_04 = func_F130();
	var_05 = var_04["seekerMeleeGrab_win"];
	var_06 = level.player.var_B55B.var_E505;
	thread lib_0F3D::func_50E8(0.2);
	thread lib_0F3D::func_510F(0.2,65,0.4);
	var_06 method_82E4("meleeCounter",var_05,var_06.var_E6E5,1,0.2,1);
	var_06 thread lib_0B06::func_10CBF(var_06,"meleeCounter");
	var_06 thread scripts\anim\shared::func_592B("meleeCounter",::func_F145);
	var_07 = lib_0A1E::func_2336(param_00,param_01);
	self method_806F(lib_0A1E::func_2339(),param_02);
	function_0178("seeker_expl_beep",self.origin);
	thread func_F116();
	self method_82E7(param_01,var_07,1,param_02,1);
	thread lib_0B06::func_10CBF(self,param_01);
	lib_0A1E::func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
	func_F13E();
}

//Function Number: 24
func_F13E(param_00)
{
	if(isdefined(self.var_9BB9) && self.var_9BB9)
	{
		return;
	}

	level.player method_83F6(50,self.origin);
	level.player method_80D1();
	self.var_9BB9 = 1;
	thread lib_0E26::func_F11E(1,param_00);
	level.player thread post_meleeexplode();
}

//Function Number: 25
post_meleeexplode()
{
	wait(0.1);
	self method_80A1();
}

//Function Number: 26
func_F116()
{
	self endon("death");
	for(;;)
	{
		var_00 = self gettagorigin("j_body");
		wait(0.05);
		var_01 = scripts\common\trace::func_4956(1);
		var_02 = scripts\common\trace::func_DCED(var_00,self gettagorigin("j_body"),self,var_01);
		if(var_02["hittype"] != "hittype_none")
		{
			func_F13E(var_02["position"]);
			return;
		}
	}
}

//Function Number: 27
func_F147(param_00,param_01,param_02,param_03)
{
	level.player thread lib_0F3D::func_46B5();
	var_04 = func_F130();
	var_05 = var_04["seekerMeleeGrab_lose"];
	var_06 = level.player.var_B55B.var_E505;
	wait(0.8);
	if(isdefined(self))
	{
		self.var_9BB9 = 1;
		thread lib_0E26::func_F11E();
	}
}

//Function Number: 28
func_D4D0(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self.var_B55B.var_312F = 1;
	self method_8016("zonly_physics");
	self method_8221("face angle",self.var_B55B.var_10D6D[1]);
	lib_0F42::func_B5CB(param_01,0);
	thread lib_0C64::func_B5D7(param_01);
	var_04 = func_3EB4(param_00,param_01,self.var_B55B.var_F2);
	self method_806F(lib_0A1E::func_2339(),0);
	self method_82EA(param_01,var_04,1,0,1);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	scripts\anim\face::func_EB83("pain");
	var_05 = lib_0A1E::func_231F(param_00,param_01,::lib_0C64::func_B590);
	var_06 = func_3EB5(param_00,param_01,self.var_B55B.var_F2);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_06,1,param_02,1);
	childthread func_F16D();
	lib_0A1E::func_231F(param_00,param_01,::lib_0C64::func_B590);
}

//Function Number: 29
func_F16D()
{
	var_00 = self.var_B55B.var_C92C;
	for(;;)
	{
		if(!isdefined(self.var_B55B))
		{
			break;
		}

		if(!isdefined(self.var_B55B.var_C92C) || !isalive(self.var_B55B.var_C92C))
		{
			self.var_B55B.var_2720 = 1;
			break;
		}

		wait(0.05);
	}
}