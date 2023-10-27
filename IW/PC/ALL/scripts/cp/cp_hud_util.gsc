/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_hud_util.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 766 ms
 * Timestamp: 10/27/2023 12:09:23 AM
*******************************************************************/

//Function Number: 1
func_BD6E(param_00)
{
	return self getplayerdata("cp","meritProgress",param_00);
}

//Function Number: 2
func_BD6F(param_00)
{
	return self getplayerdata("cp","meritState",param_00);
}

//Function Number: 3
func_BD75(param_00,param_01)
{
	if(param_00 == "mt_highest_round")
	{
		var_02 = func_BD6F("mt_highest_round");
		var_03 = func_BD70("mt_highest_round",var_02);
		if(level.wave_num >= var_03)
		{
			return self setplayerdata("cp","meritProgress",param_00,var_03);
		}

		return;
	}

	return self setplayerdata("cp","meritProgress",var_02,var_03);
}

//Function Number: 4
func_BD76(param_00,param_01)
{
	return self setplayerdata("cp","meritState",param_00,param_01);
}

//Function Number: 5
func_BD70(param_00,param_01)
{
	return int(tablelookup("cp/allMeritsTable.csv",0,param_00,10 + param_01 * 3));
}

//Function Number: 6
func_D4F6(param_00,param_01,param_02)
{
	if(scripts\cp\_utility::func_9FC6() && scripts\common\utility::istrue(self.var_13170))
	{
		return;
	}

	var_03 = func_7919(param_02);
	if(func_9CD1(param_01))
	{
		func_CE3E(var_03);
		return;
	}

	if(func_9CD0(param_01))
	{
		func_CE3E("center");
		return;
	}

	if(func_9BCA(param_00))
	{
		playfxontagforclients(level._effect["vfx_melee_blood_spray"],self,"tag_eye",self);
		return;
	}

	func_CCA5(var_03);
}

//Function Number: 7
func_7919(param_00)
{
	var_01 = 0.965;
	var_02 = ["left","center","right"];
	if(!isdefined(param_00))
	{
		return var_02[randomint(var_02.size)];
	}

	param_00 = param_00 * -1;
	var_03 = anglestoforward(self.angles);
	var_04 = vectordot(param_00,var_03);
	if(var_04 > var_01)
	{
		return "center";
	}

	var_05 = anglestoright(self.angles);
	var_06 = vectordot(param_00,var_05);
	if(var_06 > 0)
	{
		return "right";
	}

	return "left";
}

//Function Number: 8
func_9CD1(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	return param_00 == "alienspit_mp";
}

//Function Number: 9
func_9CD0(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	return param_00 == "alienspit_gas_mp";
}

//Function Number: 10
func_9BCA(param_00)
{
	if(!isdefined(param_00) || !param_00 scripts\cp\_agent_utils::func_9B5A())
	{
		return 0;
	}

	return scripts\cp\_agent_utils::func_77D7(param_00) == "elite";
}

//Function Number: 11
func_CE3E(param_00)
{
	if(!scripts\cp\_utility::func_8BB1(self.model,"tag_eye"))
	{
		return;
	}

	if(param_00 == "left")
	{
		playfxontagforclients(level._effect["vfx_alien_spitter_hit_left"],self,"tag_eye",self);
		return;
	}

	if(param_00 == "center")
	{
		playfxontagforclients(level._effect["vfx_alien_spitter_hit_center"],self,"tag_eye",self);
		return;
	}

	if(param_00 == "right")
	{
		playfxontagforclients(level._effect["vfx_alien_spitter_hit_right"],self,"tag_eye",self);
		return;
	}
}

//Function Number: 12
func_CCA5(param_00)
{
	var_01 = self;
	if(!isdefined(self.model) || self.model == "")
	{
		return;
	}

	if(!scripts\cp\_utility::func_8BB1(self.model,"tag_eye"))
	{
		return;
	}

	if(param_00 == "left")
	{
		playfxontagforclients(level._effect["vfx_blood_hit_left"],var_01,"tag_eye",self);
		return;
	}

	if(param_00 == "center")
	{
		playfxontagforclients(level._effect["vfx_melee_blood_spray"],var_01,"tag_eye",self);
		return;
	}

	if(param_00 == "right")
	{
		playfxontagforclients(level._effect["vfx_blood_hit_right"],var_01,"tag_eye",self);
		return;
	}
}

//Function Number: 13
func_13F0C()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	self setclientomnvarbit("player_damaged",1,1);
	wait(0.05);
	self setclientomnvarbit("player_damaged",1,0);
}

//Function Number: 14
func_13F0D()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	self setclientomnvarbit("player_damaged",2,0);
	var_00 = 0;
	var_01 = 1;
	for(;;)
	{
		if(self.health <= 45 && var_00 == 0)
		{
			if(!self issplitscreenplayer())
			{
				self method_82C3("painvision_cp",0.02,"mix","reverb","filter");
			}

			var_00 = 1;
		}

		if(var_00 && var_01)
		{
			if(!scripts\cp\_laststand::player_in_laststand(self))
			{
				self setclientomnvarbit("player_damaged",2,1);
			}

			var_01 = 0;
		}

		if(var_00 && self.health > 45)
		{
			self method_8070(0.3);
			var_00 = 0;
			self setclientomnvarbit("player_damaged",2,0);
			var_01 = 1;
		}

		wait(0.05);
	}
}

//Function Number: 15
introscreen_corner_line(param_00,param_01)
{
	if(!isdefined(level.var_9ACA))
	{
		level.var_9ACA = 0;
	}
	else
	{
		level.var_9ACA++;
	}

	var_02 = func_4666();
	var_03 = 1.6;
	if(level.splitscreen)
	{
		var_03 = 2;
	}

	var_04 = newhudelem();
	var_04.x = 20;
	var_04.y = var_02;
	var_04.alignx = "left";
	var_04.aligny = "bottom";
	var_04.horzalign = "left";
	var_04.vertalign = "bottom";
	var_04.sort = 3;
	var_04.foreground = 1;
	var_04 settext(param_00);
	var_04.alpha = 1;
	var_04.hidewheninmenu = 1;
	var_04.fontscale = var_03;
	var_04.color = (0.8,1,0.8);
	var_04.font = "default";
	var_04.var_154 = (0.3,0.6,0.3);
	var_04.var_153 = 1;
	return var_04;
}

//Function Number: 16
func_4666()
{
	var_00 = -92;
	if(level.splitscreen)
	{
		var_00 = -110;
	}

	return level.var_9ACA * 20 - 92;
}