/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_juggernaut.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 7
 * Decompile Time: 144 ms
 * Timestamp: 10/27/2023 2:27:03 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.juggsettings = [];
	level.juggsettings["juggernaut"] = spawnstruct();
	level.juggsettings["juggernaut"].splashusedname = "used_juggernaut";
	level.juggsettings["juggernaut"].overlay = "goggles_overlay";
	level.juggsettings["juggernaut_recon"] = spawnstruct();
	level.juggsettings["juggernaut_recon"].splashusedname = "used_juggernaut";
	level.juggsettings["juggernaut_recon"].overlay = "goggles_overlay";
	foreach(var_01 in level.juggsettings)
	{
		precacheshader(var_01.overlay);
	}
}

//Function Number: 2
func_2DD1(param_00)
{
	self endon("death");
	self endon("disconnect");
	wait 0.05;
	if(isdefined(self.haslightarmor) && self.haslightarmor == 1)
	{
		maps\mp\perks\_perkfunctions::removelightarmor(self.previousmaxhealth);
	}

	if(maps\mp\_utility::func_27AF("specialty_explosivebullets"))
	{
		maps\mp\_utility::func_282E("specialty_explosivebullets");
	}

	self.health = self.maxhealth;
	switch(param_00)
	{
		case "juggernaut":
			self.isjuggernaut = 1;
			self.juggmovespeedscaler = 0.65;
			maps\mp\gametypes\_class::func_2A52(self.pers["team"],param_00,0,0);
			self.movespeedscaler = 0.65;
			break;

		case "juggernaut_recon":
			self.isjuggernautrecon = 1;
			self.juggmovespeedscaler = 0.75;
			maps\mp\gametypes\_class::func_2A52(self.pers["team"],param_00,0,0);
			self.movespeedscaler = 0.75;
			var_01 = spawn("script_model",self.origin);
			var_01.team = self.team;
			var_01 makeportableradar(self);
			self.personalradar = var_01;
			thread func_2DD8(var_01);
			break;
	}

	maps\mp\gametypes\_weapons::func_2884();
	self disableweaponpickup();
	if(!getdvarint("camera_thirdPerson"))
	{
		self.juggernautoverlay = newclienthudelem(self);
		self.juggernautoverlay.x = 0;
		self.juggernautoverlay.y = 0;
		self.juggernautoverlay.alignx = "left";
		self.juggernautoverlay.aligny = "top";
		self.juggernautoverlay.horzalign = "fullscreen";
		self.juggernautoverlay.vertalign = "fullscreen";
		self.juggernautoverlay setshader(level.juggsettings[param_00].overlay,640,480);
		self.juggernautoverlay.sort = -10;
		self.juggernautoverlay.archived = 1;
		self.juggernautoverlay.hidein3rdperson = 1;
	}

	thread func_2DD7();
	self setperk("specialty_radarjuggernaut",1,0);
	thread maps\mp\_utility::teamplayercardsplash(level.juggsettings[param_00].splashusedname,self);
	if(self.streaktype == "specialist")
	{
		thread maps\mp\killstreaks\_killstreaks::func_2DD6();
	}
	else
	{
		thread maps\mp\killstreaks\_killstreaks::updatekillstreaks(1);
	}

	thread func_2DD9();
	if(isdefined(self.carryflag))
	{
		wait 0.05;
		self attach(self.carryflag,"J_spine4",1);
	}

	level notify("juggernaut_equipped",self);
	maps\mp\_matchdata::logkillstreakevent("juggernaut",self.origin);
}

//Function Number: 3
func_2DD7()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("jugg_removed");
	for(;;)
	{
		wait 3;
		self playsound("juggernaut_breathing_sound");
	}
}

//Function Number: 4
func_2DD8(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("jugg_removed");
	self endon("jugdar_removed");
	for(;;)
	{
		param_00 moveto(self.origin,0.05);
		wait 0.05;
	}
}

//Function Number: 5
func_2DD9()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("jugg_removed");
	thread func_2DDC();
	thread func_80F6();
	common_scripts\utility::waittill_any("death","joined_team","joined_spectators","lost_juggernaut");
	self enableweaponpickup();
	self.isjuggernaut = 0;
	self.isjuggernautdef = 0;
	self.isjuggernautgl = 0;
	self.isjuggernautrecon = 0;
	if(isdefined(self.juggernautoverlay))
	{
		self.juggernautoverlay destroy();
	}

	self unsetperk("specialty_radarjuggernaut",1);
	if(isdefined(self.personalradar))
	{
		self notify("jugdar_removed");
		level maps\mp\gametypes\_portable_radar::deleteportableradar(self.personalradar);
		self.personalradar = undefined;
	}

	self notify("jugg_removed");
}

//Function Number: 6
func_2DDC()
{
	self endon("disconnect");
	self endon("jugg_removed");
	level waittill("game_ended");
	if(isdefined(self.juggernautoverlay))
	{
		self.juggernautoverlay destroy();
	}
}

//Function Number: 7
func_80F6()
{
	self endon("jugg_removed");
	level endon("game_ended");
	var_00 = self.personalradar;
	self waittill("disconnect");
	if(isdefined(var_00))
	{
		level maps\mp\gametypes\_portable_radar::deleteportableradar(var_00);
	}
}