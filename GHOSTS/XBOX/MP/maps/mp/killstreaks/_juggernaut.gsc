/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_juggernaut.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 14
 * Decompile Time: 226 ms
 * Timestamp: 10/27/2023 1:32:49 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.juggsettings = [];
	level.juggsettings["juggernaut"] = addstruct();
	level.juggsettings["juggernaut"].splashusedname = "used_juggernaut";
	level.juggsettings["juggernaut_recon"] = addstruct();
	level.juggsettings["juggernaut_recon"].splashusedname = "used_juggernaut_recon";
	level.juggsettings["juggernaut_maniac"] = addstruct();
	level.juggsettings["juggernaut_maniac"].splashusedname = "used_juggernaut_maniac";
	level thread watchjugghostmigrationfinishedinit();
}

//Function Number: 2
givejuggernaut(param_00)
{
	self endon("death");
	self endon("disconnect");
	wait(0.05);
	if(isdefined(self.lightarmorhp))
	{
		maps\mp\perks\_perkfunctions::unsetlightarmor();
	}

	maps\mp\gametypes\_weapons::disableplantedequipmentuse();
	if(maps\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		maps\mp\_utility::_unsetperk("specialty_explosivebullets");
	}

	self.health = self.maxhealth;
	var_01 = 1;
	switch(param_00)
	{
		case "juggernaut":
			self.isjuggernaut = 1;
			self.juggmovespeedscaler = 0.8;
			maps\mp\gametypes\_class::giveloadout(self.pers["team"],param_00,0);
			self.movespeedscaler = 0.8;
			maps\mp\_utility::func_3CFB("specialty_scavenger",0);
			maps\mp\_utility::func_3CFB("specialty_quickdraw",0);
			maps\mp\_utility::func_3CFB("specialty_detectexplosive",0);
			maps\mp\_utility::func_3CFB("specialty_sharp_focus",0);
			maps\mp\_utility::func_3CFB("specialty_radarjuggernaut",0);
			break;

		case "juggernaut_recon":
			self.isjuggernautrecon = 1;
			self.juggmovespeedscaler = 0.8;
			maps\mp\gametypes\_class::giveloadout(self.pers["team"],param_00,0);
			self.movespeedscaler = 0.8;
			maps\mp\_utility::func_3CFB("specialty_scavenger",0);
			maps\mp\_utility::func_3CFB("specialty_coldblooded",0);
			maps\mp\_utility::func_3CFB("specialty_noscopeoutline",0);
			maps\mp\_utility::func_3CFB("specialty_detectexplosive",0);
			maps\mp\_utility::func_3CFB("specialty_sharp_focus",0);
			maps\mp\_utility::func_3CFB("specialty_radarjuggernaut",0);
			if(!isbot(self))
			{
				self makeportableradar(self);
				maps\mp\gametypes\_missions::func_61CE("ch_airdrop_juggernaut_recon");
			}
			break;

		case "juggernaut_maniac":
			self.isjuggernautmaniac = 1;
			self.juggmovespeedscaler = 1.15;
			maps\mp\gametypes\_class::giveloadout(self.pers["team"],param_00,0);
			maps\mp\_utility::func_3CFB("specialty_blindeye",0);
			maps\mp\_utility::func_3CFB("specialty_coldblooded",0);
			maps\mp\_utility::func_3CFB("specialty_noscopeoutline",0);
			maps\mp\_utility::func_3CFB("specialty_detectexplosive",0);
			maps\mp\_utility::func_3CFB("specialty_marathon",0);
			maps\mp\_utility::func_3CFB("specialty_falldamage",0);
			self.movespeedscaler = 1.15;
			break;

		default:
			var_01 = self [[ level.mapcustomjuggfunc ]](param_00);
			break;
	}

	if(perkcheck("specialty_hardline"))
	{
		maps\mp\_utility::func_3CFB("specialty_hardline",0);
	}

	maps\mp\gametypes\_weapons::func_8707();
	self disableweaponpickup();
	if(!isbot(self))
	{
		if(var_01)
		{
			self setclientomnvar("ui_juggernaut",1);
			thread maps\mp\_utility::func_7FA0(level.juggsettings[param_00].splashusedname,self);
			thread func_4A2A();
			thread func_8CD9();
			thread func_8CE0();
		}
	}

	if(self.streaktype == "specialist")
	{
		thread maps\mp\killstreaks\_killstreaks::clearkillstreaks();
	}
	else
	{
		thread maps\mp\killstreaks\_killstreaks::func_86F7(1);
	}

	thread func_4A2D();
	if(isdefined(self.carryflag))
	{
		wait(0.05);
		self attach(self.carryflag,"J_spine4",1);
	}

	level notify("juggernaut_equipped",self);
	maps\mp\_matchdata::func_4F1D(param_00,self.origin);
}

//Function Number: 3
perkcheck(param_00)
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
func_4A2A()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("jugg_removed");
	for(;;)
	{
		wait(3);
		maps\mp\_utility::playplayerandnpcsounds(self,"juggernaut_breathing_player","juggernaut_breathing_sound");
	}
}

//Function Number: 5
watchjugghostmigrationfinishedinit()
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
				if(var_01 maps\mp\_utility::isjuggernaut() && !isdefined(var_01.isjuggernautlevelcustom) && var_01.isjuggernautlevelcustom)
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
func_4A2D()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("jugg_removed");
	thread func_4A2C();
	common_scripts\utility::func_8B2A("death","joined_team","joined_spectators","lost_juggernaut");
	self enableweaponpickup();
	self.isjuggernaut = 0;
	self.isjuggernautdef = 0;
	self.isjuggernautgl = 0;
	self.isjuggernautrecon = 0;
	self.isjuggernautmaniac = 0;
	self.isjuggernautlevelcustom = 0;
	if(isplayer(self))
	{
		self setclientomnvar("ui_juggernaut",0);
	}

	self unsetperk("specialty_radarjuggernaut",1);
	self notify("jugg_removed");
}

//Function Number: 7
func_4A2C()
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
setjugg()
{
	if(isdefined(self.headmodel))
	{
		self detach(self.headmodel,"");
		self.headmodel = undefined;
	}

	self setmodel("mp_fullbody_juggernaut_heavy_black");
	self setviewmodel("viewhands_juggernaut_ally");
	self setclothtype("vestheavy");
}

//Function Number: 9
func_705A()
{
	if(isdefined(self.headmodel))
	{
		self detach(self.headmodel,"");
		self.headmodel = undefined;
	}

	self setmodel("mp_body_juggernaut_light_black");
	self setviewmodel("viewhands_juggernaut_ally");
	self attach("head_juggernaut_light_black","",1);
	self.headmodel = "head_juggernaut_light_black";
	self setclothtype("nylon");
}

//Function Number: 10
func_27B1()
{
	if(maps\mp\_utility::isjuggernaut())
	{
		self.juggernaut_disabled = 1;
		self setclientomnvar("ui_juggernaut",0);
	}
}

//Function Number: 11
enablejuggernaut()
{
	if(maps\mp\_utility::isjuggernaut())
	{
		self.juggernaut_disabled = undefined;
		self setclientomnvar("ui_juggernaut",1);
	}
}

//Function Number: 12
func_8CD9()
{
	self endon("death");
	self endon("disconnect");
	self endon("jugg_removed");
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(self.juggernaut_disabled) && maps\mp\_utility::func_4995())
		{
			self waittill("black_out_done");
			func_27B1();
		}

		wait(0.05);
	}
}

//Function Number: 13
func_8CE0()
{
	self endon("death");
	self endon("disconnect");
	self endon("jugg_removed");
	level endon("game_ended");
	for(;;)
	{
		if(isdefined(self.juggernaut_disabled) && !maps\mp\_utility::func_4995())
		{
			enablejuggernaut();
		}

		wait(0.05);
	}
}

//Function Number: 14
initlevelcustomjuggernaut(param_00,param_01,param_02,param_03)
{
	level.mapcustomjuggfunc = param_00;
	level.mapcustomjuggsetclass = param_01;
	level.mapcustomjuggkilledsplash = param_03;
	game["allies_model"]["JUGGERNAUT_CUSTOM"] = param_02;
	game["axis_model"]["JUGGERNAUT_CUSTOM"] = param_02;
}