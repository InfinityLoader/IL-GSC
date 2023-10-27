/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_shellshock.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 13
 * Decompile Time: 201 ms
 * Timestamp: 10/27/2023 1:31:33 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level._effect["slide_dust"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_tocam_slidedust_m");
	level._effect["hit_left"] = loadfx("vfx/gameplay/screen_effects/vfx_blood_hit_left");
	level._effect["hit_right"] = loadfx("vfx/gameplay/screen_effects/vfx_blood_hit_right");
	level._effect["melee_spray"] = loadfx("vfx/gameplay/screen_effects/vfx_melee_blood_spray");
}

//Function Number: 2
func_73FE(param_00,param_01)
{
	if(maps\mp\_flashgrenades::func_48C3())
	{
	}

	if(param_00 == "MOD_EXPLOSIVE" || param_00 == "MOD_GRENADE" || param_00 == "MOD_GRENADE_SPLASH" || param_00 == "MOD_PROJECTILE" || param_00 == "MOD_PROJECTILE_SPLASH")
	{
		if(param_01 > 10)
		{
			if(isdefined(self.shellshockreduction) && self.shellshockreduction)
			{
				self shellshock("frag_grenade_mp",self.shellshockreduction);
			}

			self shellshock("frag_grenade_mp",0.5);
		}
	}
}

//Function Number: 3
func_2DE0()
{
	self waittill("death");
	waittillframeend;
	self notify("end_explode");
}

//Function Number: 4
func_3DA7()
{
	self notify("grenade_earthQuake");
	self endon("grenade_earthQuake");
	thread func_2DE0();
	self endon("end_explode");
	self waittill("explode",var_00);
	playrumbleonposition("grenade_rumble",var_00);
	earthquake(0.5,0.75,var_00,800);
	foreach(var_02 in level.players)
	{
		if(var_02 maps\mp\_utility::func_4995())
		{
			continue;
		}

		if(distancesquared(var_00,var_02.origin) > 360000)
		{
			continue;
		}

		if(var_02 damageconetrace(var_00))
		{
			var_02 thread func_273F(var_00);
		}

		var_02 setclientomnvar("ui_hud_shake",1);
	}
}

//Function Number: 5
func_273F(param_00)
{
	self notify("dirtEffect");
	self endon("dirtEffect");
	self endon("disconnect");
	if(!maps\mp\_utility::func_4945(self))
	{
	}

	var_01 = vectornormalize(anglestoforward(self.angles));
	var_02 = vectornormalize(anglestoright(self.angles));
	var_03 = vectornormalize(param_00 - self.origin);
	var_04 = vectordot(var_03,var_01);
	var_05 = vectordot(var_03,var_02);
	var_06 = ["death","damage"];
	if(var_04 > 0 && var_04 > 0.5 && self getcurrentweapon() != "iw6_riotshield_mp")
	{
		common_scripts\utility::func_8B2C(var_06,2);
	}

	if(abs(var_04) < 0.866)
	{
		if(var_05 > 0)
		{
			common_scripts\utility::func_8B2C(var_06,2);
		}

		common_scripts\utility::func_8B2C(var_06,2);
	}
}

//Function Number: 6
func_1503(param_00)
{
	self endon("disconnect");
	if(!maps\mp\_utility::func_4945(self))
	{
	}

	var_01 = vectornormalize(anglestoforward(self.angles));
	var_02 = vectornormalize(anglestoright(self.angles));
	var_03 = vectornormalize(param_00 - self.origin);
	var_04 = vectordot(var_03,var_01);
	var_05 = vectordot(var_03,var_02);
	if(var_04 > 0 && var_04 > 0.5)
	{
	}

	if(abs(var_04) < 0.866)
	{
		var_06 = level._effect["hit_left"];
		if(var_05 > 0)
		{
			var_06 = level._effect["hit_right"];
		}

		var_07 = ["death","damage"];
		thread func_9392(var_06,var_07,7);
	}
}

//Function Number: 7
func_1504()
{
	self endon("disconnect");
	wait(0.5);
	var_00 = ["death"];
	thread func_9392(level._effect["melee_spray"],var_00,1.5);
}

//Function Number: 8
func_9392(param_00,param_01,param_02)
{
	self endon("disconnect");
	var_03 = botgetteamlimit(param_00,self geteye(),self);
	triggerfx(var_03);
	var_03 setscriptabledamageowner();
	common_scripts\utility::func_8B2C(param_01,param_02);
	var_03 delete();
}

//Function Number: 9
c4_earthquake()
{
	thread func_2DE0();
	self endon("end_explode");
	self waittill("explode",var_00);
	playrumbleonposition("grenade_rumble",var_00);
	earthquake(0.4,0.75,var_00,512);
	foreach(var_02 in level.players)
	{
		if(var_02 maps\mp\_utility::func_4995())
		{
			continue;
		}

		if(distance(var_00,var_02.origin) > 512)
		{
			continue;
		}

		if(var_02 damageconetrace(var_00))
		{
			var_02 thread func_273F(var_00);
		}

		var_02 setclientomnvar("ui_hud_shake",1);
	}
}

//Function Number: 10
barrel_earthquake()
{
	var_00 = self.origin;
	playrumbleonposition("grenade_rumble",var_00);
	earthquake(0.4,0.5,var_00,512);
	foreach(var_02 in level.players)
	{
		if(var_02 maps\mp\_utility::func_4995())
		{
			continue;
		}

		if(distance(var_00,var_02.origin) > 512)
		{
			continue;
		}

		if(var_02 damageconetrace(var_00))
		{
			var_02 thread func_273F(var_00);
		}

		var_02 setclientomnvar("ui_hud_shake",1);
	}
}

//Function Number: 11
func_0F3F()
{
	var_00 = self.origin;
	playrumbleonposition("artillery_rumble",self.origin);
	earthquake(0.7,0.5,self.origin,800);
	foreach(var_02 in level.players)
	{
		if(var_02 maps\mp\_utility::func_4995())
		{
			continue;
		}

		if(distance(var_00,var_02.origin) > 600)
		{
			continue;
		}

		if(var_02 damageconetrace(var_00))
		{
			var_02 thread func_273F(var_00);
		}

		var_02 setclientomnvar("ui_hud_shake",1);
	}
}

//Function Number: 12
func_7BE1(param_00)
{
	playrumbleonposition("grenade_rumble",param_00);
	earthquake(1,0.6,param_00,2000);
	foreach(var_02 in level.players)
	{
		if(var_02 maps\mp\_utility::func_4995())
		{
			continue;
		}

		if(distance(param_00,var_02.origin) > 1000)
		{
			continue;
		}

		if(var_02 damageconetrace(param_00))
		{
			var_02 thread func_273F(param_00);
		}

		var_02 setclientomnvar("ui_hud_shake",1);
	}
}

//Function Number: 13
airstrike_earthquake(param_00)
{
	playrumbleonposition("artillery_rumble",param_00);
	earthquake(0.7,0.75,param_00,1000);
	foreach(var_02 in level.players)
	{
		if(var_02 maps\mp\_utility::func_4995())
		{
			continue;
		}

		if(distance(param_00,var_02.origin) > 900)
		{
			continue;
		}

		if(var_02 damageconetrace(param_00))
		{
			var_02 thread func_273F(param_00);
		}

		var_02 setclientomnvar("ui_hud_shake",1);
	}
}