/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_spiderbot.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 742 ms
 * Timestamp: 10/27/2023 12:29:41 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["spider_explode"] = loadfx("vfx/core/expl/grenadeexp_default");
	scripts\mp\killstreaks\_killstreaks::func_DEFB("spiderbot",::func_1288A);
}

//Function Number: 2
func_1288A(param_00)
{
	var_01 = 0;
	if(!var_01)
	{
		return 0;
	}

	func_10DF3(param_00.var_110EA);
	thread func_13B56();
	thread func_13B57();
	thread func_13B55();
	return 1;
}

//Function Number: 3
func_13B56()
{
	self endon("disconnect");
	self endon("detonate_spiderbot");
	self notifyonplayercommand("manual_explode","+attack");
	self notifyonplayercommand("manual_explode","+attack_akimbo_accessible");
	self waittill("manual_explode");
	self notify("detonate_spiderbot");
}

//Function Number: 4
func_13B58()
{
	self endon("disconnect");
	self endon("detonate_spiderbot");
	self notifyonplayercommand("toggle_thermal","+smoke");
	var_00 = 0;
	for(;;)
	{
		self waittill("toggle_thermal");
		if(!var_00)
		{
			self thermalvisionon();
			var_00 = 1;
			continue;
		}

		self thermalvisionoff();
		var_00 = 0;
	}
}

//Function Number: 5
func_13B57()
{
	self endon("disconnect");
	self endon("detonate_spiderbot");
	self notifyonplayercommand("shoot_web","+speed_throw");
	for(;;)
	{
		self waittill("shoot_web");
		if(!isdefined(self.var_13CE7))
		{
			self.var_13CE7 = 1;
			var_00 = anglestoforward(self getplayerangles());
			var_01 = self geteye() + var_00 * 20 + (0,0,20);
			var_02 = var_01 + var_00;
			var_03 = scripts\mp\_utility::func_1309("iw7_webhook_mp",var_01,var_02,self);
			thread func_13BB0(var_03,var_01);
			thread func_13BB1(2,var_03);
		}
	}
}

//Function Number: 6
func_13BAF()
{
	self notifyonplayercommand("web_cut","+gostand");
	self waittill("web_cut");
	if(isdefined(self.var_13CE7))
	{
		self.var_AD32 = undefined;
		self.var_13CE7 = undefined;
		self unlink();
	}
}

//Function Number: 7
func_13BB0(param_00,param_01)
{
	self endon("disconnect");
	self endon("detonate_spiderbot");
	self endon("web_cut");
	param_00 waittill("explode",var_02);
	var_03 = scripts\common\utility::spawn_tag_origin();
	var_03.var_1155F = func_7F05(var_02,50,1,50);
	var_03.origin = var_02;
	var_04 = scripts\common\utility::spawn_tag_origin();
	var_04.origin = param_01;
	var_04.angles = vectortoangles(var_02 - var_04.origin);
	self.var_AD32 = var_04;
	self playerlinktoblend(var_04,"tag_origin",0.5);
	if(isdefined(var_03.var_1155F) && isplayer(var_03.var_1155F))
	{
		var_03 linkto(var_03.var_1155F);
		thread func_13B79(var_03);
		var_05 = 0.5;
		while(distance2dsquared(var_04.origin,var_03.origin) > 400 || !isdefined(var_03.var_1155F))
		{
			var_04 rotateto(vectortoangles(var_03.origin - var_04.origin),0.3);
			var_04 moveto(var_03.origin,var_05);
			wait(var_05);
			var_05 = var_05 - 0.25;
			var_05 = max(0.05,var_05);
		}

		self notify("detonate_spiderbot");
		return;
	}

	var_04 moveto(var_03.origin,0.5);
	var_04 thread func_13AD8(var_03.origin,self);
}

//Function Number: 8
func_13B79(param_00)
{
	param_00 endon("death");
	self endon("detonate_spiderbot");
	param_00.var_1155F scripts\common\utility::waittill_any_3("phase_shift_power_activated","rewind_activated","powers_teleport_used","powers_transponder_used","orbital_deployment_action","death","disconnect");
	param_00.var_1155F = undefined;
}

//Function Number: 9
func_13AD8(param_00,param_01)
{
	param_01 endon("disconnect");
	param_01 endon("detonate_spiderbot");
	param_01 endon("web_cut");
	while(self.origin != param_00)
	{
		scripts\common\utility::func_136F7();
	}

	param_01 notify("detonate_spiderbot");
}

//Function Number: 10
func_13BB1(param_00,param_01)
{
	self endon("disconnect");
	self endon("detonate_spiderbot");
	param_01 endon("explode");
	wait(param_00);
	self.var_13CE7 = undefined;
}

//Function Number: 11
func_13B55()
{
	self endon("disconnect");
	level endon("game_ended");
	self waittill("detonate_spiderbot",var_00);
	var_01 = self.origin;
	var_02 = 500;
	var_03 = 200;
	if(!isdefined(var_00))
	{
		radiusdamage(var_01,256,var_02,var_03,self,"MOD_EXPLOSIVE","killstreak_spiderbot_mp");
	}

	playfx(scripts\common\utility::getfx("spider_explode"),var_01);
	playsoundatpos(var_01,"frag_grenade_explode");
	playrumbleonposition("grenade_rumble",var_01);
	earthquake(0.5,0.75,var_01,800);
	foreach(var_05 in level.players)
	{
		if(var_05 scripts\mp\_utility::func_9FC6())
		{
			continue;
		}

		if(distancesquared(var_01,var_05.origin) > 360000)
		{
			continue;
		}

		var_05 setclientomnvar("ui_hud_shake",1);
	}

	func_1108D();
}

//Function Number: 12
func_10DF3(param_00)
{
	self setclientomnvar("ui_spiderbot_controls",1);
	self thermalvisionon();
	self thermalvisionfofoverlayon();
	func_511C(0.05,"spiderbot_steps");
	scripts\common\utility::allow_weapon(0);
	scripts\common\utility::func_1C6E(0);
	self method_845A("spiderbot_mp");
	self setmodel("alien_minion");
	self allowslide(0);
	self method_8422(0);
	self allowcrouch(0);
	self allowprone(0);
	self method_8012(0);
	self method_8412(1);
	self method_8454(8);
	self setscriptablepartstate("CompassIcon","spiderbot");
	return 1;
}

//Function Number: 13
func_1108D()
{
	self setclientomnvar("ui_spiderbot_controls",0);
	self thermalvisionoff();
	self thermalvisionfofoverlayoff();
	self method_83AD();
	scripts\common\utility::allow_weapon(1);
	scripts\common\utility::func_1C6E(1);
	if(isdefined(self.var_13CE7))
	{
		self.var_AD32 = undefined;
		self.var_13CE7 = undefined;
		self unlink();
	}

	self setscriptablepartstate("CompassIcon","defaulticon");
}

//Function Number: 14
func_7F05(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	var_05 = undefined;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_06 = param_01 * param_01;
	foreach(var_08 in level.players)
	{
		if(func_38C1(var_08,param_00,var_06,param_02,param_03))
		{
			var_05 = var_08;
			break;
		}
	}

	return var_05;
}

//Function Number: 15
func_38C1(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_00.origin;
	var_06 = distance2dsquared(param_01,var_05);
	return var_06 < param_02 && !param_03 || scripts\mp\_weapons::func_13C7E(param_01,var_05,param_04,param_00);
}

//Function Number: 16
func_511C(param_00,param_01)
{
	self endon("death");
	wait(param_00);
	self playloopsound(param_01);
}