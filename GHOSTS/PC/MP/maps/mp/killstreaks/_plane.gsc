/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_plane.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 372 ms
 * Timestamp: 10/27/2023 1:21:25 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	if(!isdefined(level.planes))
	{
		level.planes = [];
	}

	if(!isdefined(level.planeconfigs))
	{
		level.planeconfigs = [];
	}

	level.fighter_deathfx = loadfx("vfx/gameplay/explosions/vehicle/hind_mp/vfx_x_mphnd_primary");
	level.fx_airstrike_afterburner = loadfx("vfx/gameplay/mp/killstreaks/vfx_air_superiority_afterburner");
	level.fx_airstrike_contrail = loadfx("vfx/gameplay/mp/killstreaks/vfx_aircraft_contrail");
	level.fx_airstrike_wingtip_light_green = loadfx("vfx/gameplay/mp/killstreaks/vfx_acraft_light_wingtip_green");
	level.fx_airstrike_wingtip_light_red = loadfx("vfx/gameplay/mp/killstreaks/vfx_acraft_light_wingtip_red");
}

//Function Number: 2
func_3AAE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = param_00 + param_01 * -1 * param_02;
	var_09 = param_00 + param_01 * param_02;
	if(param_03)
	{
		var_08 = var_08 * (1,1,0);
		var_09 = var_09 * (1,1,0);
	}

	var_08 = var_08 + (0,0,param_04);
	var_09 = var_09 + (0,0,param_04);
	var_0A = length(var_08 - var_09);
	var_0B = var_0A / param_05;
	var_0A = abs(0.5 * var_0A + param_06);
	var_0C = var_0A / param_05;
	var_0D["startPoint"] = var_08;
	var_0D["endPoint"] = var_09;
	var_0D["attackTime"] = var_0C;
	var_0D["flyTime"] = var_0B;
	return var_0D;
}

//Function Number: 3
func_2896(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = func_5C97(param_00,param_01,param_03,param_07,param_08);
	var_09 endon("death");
	var_0A = 150;
	var_0B = param_04 + (randomfloat(2) - 1 * var_0A,randomfloat(2) - 1 * var_0A,0);
	var_09 planemove(var_0B,param_06,param_05,param_08);
	var_09 func_5C92();
}

//Function Number: 4
func_5C97(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_01))
	{
	}

	var_05 = 100;
	var_06 = param_02 + (randomfloat(2) - 1 * var_05,randomfloat(2) - 1 * var_05,0);
	var_07 = level.planeconfigs[param_04];
	var_08 = undefined;
	var_08 = spawn("script_model",var_06);
	var_08.team = param_01.team;
	var_08.origin = var_06;
	var_08.angles = vectortoangles(param_03);
	var_08.lifeid = param_00;
	var_08.streakname = param_04;
	var_08.owner = param_01;
	var_08 setmodel(var_07.modelnames[param_01.team]);
	if(isdefined(var_07.compassiconfriendly))
	{
		var_08 func_7082(var_07.compassiconfriendly,var_07.compassiconenemy);
	}

	var_08 thread func_3F74();
	var_08 thread func_3F75();
	func_7AFA(var_08);
	if(!isdefined(var_07.nolightfx))
	{
		var_08 thread func_6034();
	}

	var_08 playloopsound(var_07.inboundsfx);
	var_08 createkillcam(param_04);
	return var_08;
}

//Function Number: 5
planemove(param_00,param_01,param_02,param_03)
{
	var_04 = level.planeconfigs[param_03];
	self moveto(param_00,param_01,0,0);
	if(isdefined(var_04.onattackdelegate))
	{
		self thread [[ var_04.onattackdelegate ]](param_00,param_01,param_02,self.owner,param_03);
	}

	if(isdefined(var_04.sonicboomsfx))
	{
		thread func_603D(var_04.sonicboomsfx,0.5 * param_01);
	}

	wait(0.65 * param_01);
	if(isdefined(var_04.outboundsfx))
	{
		self stoploopsound();
		self playloopsound(var_04.outboundsfx);
	}

	if(isdefined(var_04.outboundflightanim))
	{
		self scriptmodelplayanimdeltamotion(var_04.outboundflightanim);
	}

	wait(0.35 * param_01);
}

//Function Number: 6
func_5C92()
{
	var_00 = level.planeconfigs[self.streakname];
	if(isdefined(var_00.onflybycompletedelegate))
	{
		thread [[ var_00.onflybycompletedelegate ]](self.owner,self,self.streakname);
	}

	if(isdefined(self.friendlyteamid))
	{
		maps\mp\_utility::_objective_delete(self.friendlyteamid);
		maps\mp\_utility::_objective_delete(self.enemyteamid);
	}

	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	func_7C76(self);
	self notify("delete");
	self delete();
}

//Function Number: 7
handleemp(param_00)
{
	self endon("death");
	for(;;)
	{
		if(param_00 maps\mp\_utility::func_48B2())
		{
			self notify("death");
		}

		level waittill("emp_update");
	}
}

//Function Number: 8
func_3F75()
{
	level endon("game_ended");
	self endon("delete");
	self waittill("death");
	var_00 = anglestoforward(self.angles) * 200;
	playfx(level.fighter_deathfx,self.origin,var_00);
	thread func_5C92();
}

//Function Number: 9
func_3F74()
{
	self endon("end_remote");
	maps\mp\gametypes\_damage::func_537B(800,"helicopter",::handledeathdamage,::modifydamage,1);
}

//Function Number: 10
modifydamage(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_04 = maps\mp\gametypes\_damage::func_3F8A(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleapdamage(param_01,param_02,var_04,param_00);
	return var_04;
}

//Function Number: 11
handledeathdamage(param_00,param_01,param_02,param_03)
{
	var_04 = level.planeconfigs[self.streakname];
	maps\mp\gametypes\_damage::onkillstreakkilled(param_00,param_01,param_02,param_03,var_04.xppopup,var_04.destroyedvo,var_04.callout);
	maps\mp\gametypes\_missions::checkaachallenges(param_00,self,param_01);
}

//Function Number: 12
func_6034()
{
	self endon("death");
	wait(0.5);
	playfxontag(level.fx_airstrike_afterburner,self,"tag_engine_right");
	wait(0.5);
	playfxontag(level.fx_airstrike_afterburner,self,"tag_engine_left");
	wait(0.5);
	playfxontag(level.fx_airstrike_contrail,self,"tag_right_wingtip");
	wait(0.5);
	playfxontag(level.fx_airstrike_contrail,self,"tag_left_wingtip");
	wait(0.5);
	playfxontag(level.fx_airstrike_wingtip_light_red,self,"tag_right_wingtip");
	wait(0.5);
	playfxontag(level.fx_airstrike_wingtip_light_green,self,"tag_left_wingtip");
}

//Function Number: 13
func_3B92()
{
	var_00 = getent("airstrikeheight","targetname");
	if(isdefined(var_00))
	{
		return var_00.origin[2];
	}

	var_01 = 950;
	if(isdefined(level.airstrikeheightscale))
	{
		var_01 = var_01 * level.airstrikeheightscale;
	}

	return var_01;
}

//Function Number: 14
getplaneflightplan(param_00)
{
	var_01 = spawnstruct();
	var_01.height = func_3B92();
	var_02 = getent("airstrikeheight","targetname");
	if(isdefined(var_02) && isdefined(var_02.script_noteworthy) && var_02.script_noteworthy == "fixedposition")
	{
		var_01.targetpos = var_02.origin;
		var_01.flightdir = anglestoforward(var_02.angles);
		if(randomint(2) == 0)
		{
			var_01.flightdir = var_01.flightdir * -1;
		}
	}
	else
	{
		var_03 = anglestoforward(self.angles);
		var_04 = anglestoright(self.angles);
		var_01.targetpos = self.origin + param_00 * var_03;
		var_01.flightdir = -1 * var_04;
	}

	return var_01;
}

//Function Number: 15
getexplodedistance(param_00)
{
	var_01 = 850;
	var_02 = 1500;
	var_03 = var_01 / param_00;
	var_04 = var_03 * var_02;
	return var_04;
}

//Function Number: 16
func_7AFA(param_00)
{
	var_01 = param_00 getentitynumber();
	level.planes[var_01] = param_00;
}

//Function Number: 17
func_7C76(param_00)
{
	var_01 = param_00 getentitynumber();
	level.planes[var_01] = undefined;
}

//Function Number: 18
func_6D6F(param_00,param_01,param_02)
{
	var_03 = level.mapsize / 6.46875;
	if(level.splitscreen)
	{
		var_03 = var_03 * 1.5;
	}

	var_04 = level.planeconfigs[param_01];
	if(isdefined(var_04.selectlocationvo))
	{
		self playlocalsound(game["voice"][self.team] + var_04.selectlocationvo);
	}

	maps\mp\_utility::_beginlocationselection(param_01,"map_artillery_selector",var_04.choosedirection,var_03);
	self endon("stop_location_selection");
	self waittill("confirm_location",var_05,var_06);
	if(!var_04.choosedirection)
	{
		var_06 = randomint(360);
	}

	self setblurforplayer(0,0.3);
	if(isdefined(var_04.inboundvo))
	{
		self playlocalsound(game["voice"][self.team] + var_04.inboundvo);
	}

	self thread [[ param_02 ]](param_00,var_05,var_06,param_01);
	return 1;
}

//Function Number: 19
func_7082(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_02,"active",(0,0,0),param_00);
	objective_onentitywithrotation(var_02,self);
	self.friendlyteamid = var_02;
	var_03 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_03,"active",(0,0,0),param_01);
	objective_onentitywithrotation(var_03,self);
	self.enemyteamid = var_03;
	if(level.teambased)
	{
		objective_team(var_02,self.team);
		objective_team(var_03,maps\mp\_utility::getotherteam(self.team));
	}

	var_04 = self.owner getentitynumber();
	objective_playerteam(var_02,var_04);
	objective_playerenemyteam(var_03,var_04);
}

//Function Number: 20
func_603D(param_00,param_01)
{
	self endon("death");
	wait(param_01);
	self playsoundonmovingent(param_00);
}

//Function Number: 21
createkillcam(param_00)
{
	var_01 = level.planeconfigs[param_00];
	if(isdefined(var_01.killcamoffset))
	{
		var_02 = anglestoforward(self.angles);
		var_03 = spawn("script_model",self.origin + (0,0,100) - var_02 * 200);
		var_03.starttime = gettime();
		var_03 setscriptmoverkillcam("airstrike");
		var_03 linkto(self,"tag_origin",var_01.killcamoffset,(0,0,0));
		self.killcament = var_03;
	}
}