/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_juggernaut.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 779 ms
 * Timestamp: 10/27/2023 12:28:57 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_A4AD = [];
	level.var_A4AD["juggernaut"] = spawnstruct();
	level.var_A4AD["juggernaut"].var_10A41 = "used_juggernaut";
	level.var_A4AD["juggernaut_recon"] = spawnstruct();
	level.var_A4AD["juggernaut_recon"].var_10A41 = "used_juggernaut_recon";
	level.var_A4AD["juggernaut_maniac"] = spawnstruct();
	level.var_A4AD["juggernaut_maniac"].var_10A41 = "used_juggernaut_maniac";
	level thread func_13AB0();
}

//Function Number: 2
func_8371(param_00)
{
	self endon("death");
	self endon("disconnect");
	wait(0.05);
	if(isdefined(self.var_ACAE))
	{
		scripts\mp\perks\_perkfunctions::func_12CE5();
	}

	scripts\mp\_weapons::func_5608();
	if(scripts\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		scripts\mp\_utility::func_E150("specialty_explosivebullets");
	}

	self.health = self.maxhealth;
	var_01 = 1;
	switch(param_00)
	{
		case "juggernaut":
			self.var_9E59 = 1;
			self.var_A4AA = 0.8;
			scripts\mp\_class::func_8379(self.pers["team"],param_00,0);
			self.var_BCF6 = 0.8;
			scripts\mp\_utility::func_8387("specialty_scavenger");
			scripts\mp\_utility::func_8387("specialty_quickdraw");
			scripts\mp\_utility::func_8387("specialty_detectexplosive");
			scripts\mp\_utility::func_8387("specialty_sharp_focus");
			scripts\mp\_utility::func_8387("specialty_radarjuggernaut");
			break;

		case "juggernaut_recon":
			self.var_9E5E = 1;
			self.var_A4AA = 0.8;
			scripts\mp\_class::func_8379(self.pers["team"],param_00);
			self.var_BCF6 = 0.8;
			scripts\mp\_utility::func_8387("specialty_scavenger");
			scripts\mp\_utility::func_8387("specialty_coldblooded");
			scripts\mp\_utility::func_8387("specialty_noscopeoutline");
			scripts\mp\_utility::func_8387("specialty_detectexplosive");
			scripts\mp\_utility::func_8387("specialty_sharp_focus");
			scripts\mp\_utility::func_8387("specialty_radarjuggernaut");
			if(!isagent(self))
			{
				self method_81F3(self);
				scripts\mp\_missions::func_D992("ch_airdrop_juggernaut_recon");
			}
			break;

		case "juggernaut_maniac":
			self.var_9E5D = 1;
			self.var_A4AA = 1.15;
			scripts\mp\_class::func_8379(self.pers["team"],param_00,0);
			scripts\mp\_utility::func_8387("specialty_blindeye");
			scripts\mp\_utility::func_8387("specialty_coldblooded");
			scripts\mp\_utility::func_8387("specialty_noscopeoutline");
			scripts\mp\_utility::func_8387("specialty_detectexplosive");
			scripts\mp\_utility::func_8387("specialty_marathon");
			scripts\mp\_utility::func_8387("specialty_falldamage");
			self.var_BCF6 = 1.15;
			break;

		default:
			var_01 = self [[ level.var_B331 ]](param_00);
			break;
	}

	if(func_CA4E("specialty_hardline"))
	{
		scripts\mp\_utility::func_8387("specialty_hardline");
	}

	scripts\mp\_weapons::func_12ED5();
	self disableweaponpickup();
	if(!isagent(self))
	{
		if(var_01)
		{
			self setclientomnvar("ui_juggernaut",1);
			thread scripts\mp\_utility::func_115DE(level.var_A4AD[param_00].var_10A41,self);
			thread func_A4A9();
			thread func_139F1();
			thread func_13A13();
		}
	}

	if(self.var_110F4 == "specialist")
	{
		thread scripts\mp\killstreaks\_killstreaks::func_41C0();
	}

	thread func_A4AC();
	if(isdefined(self.var_3AF4))
	{
		wait(0.05);
		self attach(self.var_3AF4,"J_spine4",1);
	}

	level notify("juggernaut_equipped",self);
	scripts\mp\_matchdata::func_AFC9(param_00,self.origin);
}

//Function Number: 3
func_CA4E(param_00)
{
	var_01 = self.pers["loadoutPerks"];
	foreach(var_03 in var_01)
	{
		if(var_03 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 4
func_A4A9()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("jugg_removed");
	for(;;)
	{
		wait(3);
		scripts\mp\_utility::func_D4FB(self,"juggernaut_breathing_player","juggernaut_breathing_sound");
	}
}

//Function Number: 5
func_13AB0()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("host_migration_end");
		foreach(var_01 in level.players)
		{
			if(isai(var_01))
			{
				continue;
			}
			else
			{
				if(var_01 scripts\mp\_utility::func_9E59() && !isdefined(var_01.var_9E5C) && var_01.var_9E5C)
				{
					var_01 setclientomnvar("ui_juggernaut",1);
					continue;
				}

				var_01 setclientomnvar("ui_juggernaut",0);
			}
		}
	}
}

//Function Number: 6
func_A4AC()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("jugg_removed");
	thread func_A4AB();
	scripts\common\utility::waittill_any_3("death","joined_team","joined_spectators","lost_juggernaut");
	self enableweaponpickup();
	self.var_9E59 = 0;
	self.var_9E5A = 0;
	self.var_9E5B = 0;
	self.var_9E5E = 0;
	self.var_9E5D = 0;
	self.var_9E5C = 0;
	if(isplayer(self))
	{
		self setclientomnvar("ui_juggernaut",0);
	}

	self method_83CC("specialty_radarjuggernaut",1);
	self notify("jugg_removed");
}

//Function Number: 7
func_A4AB()
{
	self endon("disconnect");
	self endon("jugg_removed");
	level waittill("game_ended");
	if(isplayer(self))
	{
		self setclientomnvar("ui_juggernaut",0);
	}
}

//Function Number: 8
func_F766()
{
	if(isdefined(self.var_8C98))
	{
		self detach(self.var_8C98,"");
		self.var_8C98 = undefined;
	}

	self setmodel("mp_fullbody_juggernaut_heavy_black");
	self method_8369("viewhands_juggernaut_ally");
	self method_82C6("vestheavy");
}

//Function Number: 9
func_F767()
{
	if(isdefined(self.var_8C98))
	{
		self detach(self.var_8C98,"");
		self.var_8C98 = undefined;
	}

	self setmodel("mp_fullbody_heavy");
	self method_8369("viewhands_juggernaut_ally");
	self attach("mp_warfighter_head_1","",1);
	self.var_8C98 = "mp_warfighter_head_1";
	self method_82C6("nylon");
}

//Function Number: 10
func_55F4()
{
	if(scripts\mp\_utility::func_9E59())
	{
		self.var_A4A4 = 1;
		self setclientomnvar("ui_juggernaut",0);
	}
}

//Function Number: 11
func_626C()
{
	if(scripts\mp\_utility::func_9E59())
	{
		self.var_A4A4 = undefined;
		self setclientomnvar("ui_juggernaut",1);
	}
}

//Function Number: 12
func_139F1()
{
	self endon("death");
	self endon("disconnect");
	self endon("jugg_removed");
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(self.var_A4A4) && scripts\mp\_utility::func_9FC6())
		{
			self waittill("black_out_done");
			func_55F4();
		}

		wait(0.05);
	}
}

//Function Number: 13
func_13A13()
{
	self endon("death");
	self endon("disconnect");
	self endon("jugg_removed");
	level endon("game_ended");
	for(;;)
	{
		if(isdefined(self.var_A4A4) && !scripts\mp\_utility::func_9FC6())
		{
			func_626C();
		}

		wait(0.05);
	}
}

//Function Number: 14
func_988F(param_00,param_01,param_02,param_03)
{
	level.var_B331 = param_00;
	level.var_B333 = param_01;
	level.var_B332 = param_03;
	game["allies_model"]["JUGGERNAUT_CUSTOM"] = param_02;
	game["axis_model"]["JUGGERNAUT_CUSTOM"] = param_02;
}