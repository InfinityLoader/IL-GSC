/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/killstreaks/_drone_carepackage.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 182 ms
 * Timestamp: 10/27/2023 1:51:39 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.carepackagedrone = spawnstruct();
	level.carepackagedrone.health = 999999;
	level.carepackagedrone.maxhealth = 200;
	level.carepackagedrone.fxid_explode = loadfx("vfx/explosion/tracking_drone_explosion");
	level.carepackagedrone.sound_explode = "veh_tracking_drone_explode";
	level.carepackagedrone.releasestring = &"KILLSTREAKS_DRONE_CAREPACKAGE_RELEASE";
	level.carepackagedrones = [];
}

//Function Number: 2
setupcarepackagedrone(param_00,param_01)
{
	param_00 common_scripts\utility::make_entity_sentient_mp(self.team);
	param_00 makevehiclenotcollidewithplayers(1);
	param_00 addtocarepackagedronelist();
	param_00 thread removefromcarepackagedronelistondeath();
	param_00.health = level.carepackagedrone.health;
	param_00.maxhealth = level.carepackagedrone.maxhealth;
	param_00.damagetaken = 0;
	param_00.speed = 15;
	param_00.followspeed = 15;
	param_00.owner = self;
	param_00.team = self.team;
	param_00 vehicle_setspeed(param_00.speed,10,10);
	param_00 setyawspeed(120,90);
	param_00 setneargoalnotifydist(64);
	param_00 sethoverparams(4,5,5);
	param_00.fx_tag0 = "tag_body";
	if(param_01)
	{
		param_00.usableent = spawn("script_model",param_00.origin + (0,0,1));
		param_00.usableent setmodel("tag_origin");
		param_00.usableent.owner = self;
		param_00.usableent maps\mp\_utility::makegloballyusablebytype("killstreakRemote",level.carepackagedrone.releasestring,self);
	}

	var_02 = 45;
	var_03 = 45;
	param_00 setmaxpitchroll(var_02,var_03);
	var_04 = 10000;
	var_05 = 150;
	param_00.attractor = missile_createattractorent(param_00,var_04,var_05);
	param_00.stunned = 0;
	param_00 thread carepackagedrone_watchdeath();
	param_00 thread carepackagedrone_watchownerloss();
	param_00 thread carepackagedrone_watchroundend();
}

//Function Number: 3
carepackagedrone_deleteonactivate()
{
	self endon("death");
	var_00 = self.owner;
	self.usableent waittill("trigger");
	carepackagedrone_delete();
}

//Function Number: 4
carepackagedrone_watchdeath()
{
	level endon("game_ended");
	self endon("gone");
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	carepackagedrone_leave();
}

//Function Number: 5
carepackagedrone_watchownerloss()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	self notify("owner_gone");
	thread carepackagedrone_leave();
}

//Function Number: 6
carepackagedrone_watchroundend()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("disconnect");
	self endon("owner_gone");
	level common_scripts\utility::waittill_any("round_end_finished","game_ended");
	thread carepackagedrone_leave();
}

//Function Number: 7
carepackagedrone_leave()
{
	self endon("death");
	self notify("leaving");
	carepackagedrone_explode();
}

//Function Number: 8
carepackagedrone_explode()
{
	if(isdefined(level.carepackagedrone.fxid_explode))
	{
		playfx(level.carepackagedrone.fxid_explode,self.origin);
	}

	if(isdefined(level.carepackagedrone.sound_explode))
	{
		self playsound(level.carepackagedrone.sound_explode);
	}

	if(isdefined(self.usableent))
	{
		self.usableent maps\mp\_utility::makegloballyunusablebytype();
		self.usableent delete();
	}

	self notify("explode");
	carepackagedrone_remove();
}

//Function Number: 9
carepackagedrone_delete()
{
	if(isdefined(self.usableent))
	{
		self.usableent maps\mp\_utility::makegloballyunusablebytype();
		self.usableent delete();
	}

	self notify("explode");
	carepackagedrone_remove();
}

//Function Number: 10
carepackagedrone_remove()
{
	maps\mp\_utility::decrementfauxvehiclecount();
	self delete();
}

//Function Number: 11
addtocarepackagedronelist()
{
	level.carepackagedrones[level.carepackagedrones.size] = self;
}

//Function Number: 12
removefromcarepackagedronelistondeath()
{
	var_00 = self getentitynumber();
	self waittill("death");
	level.carepackagedrones = common_scripts\utility::array_remove(level.carepackagedrones,self);
}