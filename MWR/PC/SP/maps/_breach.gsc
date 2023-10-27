/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_breach.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 650 ms
 * Timestamp: 10/27/2023 2:47:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["_breach_doorbreach_detpack"] = loadfx("fx/explosions/exp_pack_doorbreach");
	level._effect["_breach_doorbreach_kick"] = loadfx("fx/dust/door_kick");
	level.scr_sound["_breach_doorbreach_detpack"] = "detpack_explo_main";
	level.scr_sound["breach_wooden_door"] = "";
	level.scr_sound["breach_wood_door_kick"] = "wood_door_kick";
	common_scripts\utility::array_call(getentarray("breached_door","script_noteworthy"),::hide);
	common_scripts\utility::array_call(getentarray("breached_door","script_noteworthy"),::notsolid);
	common_scripts\utility::flag_init("begin_the_breach");
}

//Function Number: 2
breach_think(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("breach_abort");
	if(isdefined(param_05) && param_05 == 0)
	{
		level.fire_notetrack_functions["scripted"] = ::breach_fire_straight;
	}

	self.flashthrown = 0;
	self.closestai = undefined;
	self.animent = undefined;
	self.breached = 0;
	self.breachers = 0;
	self.breachersready = 0;
	self.singlebreacher = 0;
	self.readytobreach = 0;
	self.aiareintheroom = 0;
	self.abouttobebreached = 0;
	self.cleared = 0;
	self.hasdoor = 1;
	self.hasflashbangs = 0;
	self.hostilesspawned = 0;
	var_06 = getentarray(self.targetname,"targetname");
	var_07 = self.targetname;
	self.sbadplacename = "badplace_" + var_07;
	self.badplace = getent("badplace_" + var_07,"targetname");
	if(isdefined(self.badplace))
	{
	}

	self.breachtrigger = getent("trigger_" + var_07,"targetname");
	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(isdefined(self.breachtrigger))
	{
		switch(self.breachtrigger.classname)
		{
			case "trigger_use":
				break;

			case "trigger_use_touch":
				break;

			case "trigger_radius":
				break;

			case "trigger_multiple":
				break;

			default:
				break;
		}
	}
}

//Function Number: 3
breach_dont_fire()
{
	while(self.breaching == 1)
	{
		self waittillmatch("fire","single anim");
		self.a.lastshoottime = gettime();
	}
}

//Function Number: 4
breacher_think(param_00,param_01,param_02)
{
	self.breaching = 1;
	self.breachdonotfire = undefined;
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	self pushplayer(1);
	thread give_infinite_ammo();
	param_00 endon("breach_abort");
	self.ender = "stop_idle_" + self getentitynumber();
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	if(self == param_00.closestai)
	{
		var_03 = "01";
	}
	else
	{
		var_03 = "02";
	}

	if(param_00.singlebreacher == 1 && param_01 == "explosive_breach_left")
	{
		var_03 = "02";
	}

	switch(param_01)
	{
		case "explosive_breach_left":
			break;

		case "shotgunhinges_breach_left":
			break;

		case "flash_breach_no_door_right":
			break;

		default:
			break;
	}
}

//Function Number: 5
breach_fire_straight()
{
	if(isdefined(self.breachdonotfire))
	{
		return;
	}

	animscripts\notetracks::fire_straight();
}

//Function Number: 6
detcord_logic(param_00)
{
	thread sound_effect_play(param_00);
	self waittillmatch("attach prop right","single anim");
	var_01 = "TAG_INHAND";
	self attach("weapon_detcord",var_01);
	self waittillmatch("detach prop right","single anim");
	var_02 = self gettagorigin(var_01);
	var_03 = self gettagangles(var_01);
	self detach("weapon_detcord",var_01);
	var_04 = spawn("script_model",var_02);
	var_04 setmodel("weapon_detcord");
	var_04.angles = var_03;
	param_00 waittill("detpack_detonated");
	radiusdamage(var_04.origin,64,50,25);
	var_04 delete();
}

//Function Number: 7
sound_effect_play(param_00)
{
	self waittillmatch("sound effect","single anim");
	thread common_scripts\utility::play_sound_in_space("detpack_plant_arming",param_00.edoorpivot.origin);
}

//Function Number: 8
breach_enemies_stunned(param_00)
{
	self endon("death");
	param_00 endon("breach_aborted");
	param_00 waittill("detpack_detonated");
	if(distance(self.origin,param_00.edoorpivot.origin) <= level.detpackstunradius)
	{
		level.stunnedanimnumber++;
		if(level.stunnedanimnumber > 2)
		{
			level.stunnedanimnumber = 1;
		}

		var_01 = "exposed_flashbang_v" + level.stunnedanimnumber;
		self.allowdeath = 1;
		maps\_anim::anim_generic_custom_animmode(self,"gravity",var_01);
		breach_reset_animname();
	}
}

//Function Number: 9
breach_trigger_think(param_00)
{
	param_00 endon("execute_the_breach");
	param_00 endon("breach_aborted");
	thread breach_trigger_cleanup(param_00);
	self waittill("trigger");
	param_00 notify("execute_the_breach");
}

//Function Number: 10
breach_trigger_cleanup(param_00)
{
	param_00 waittill("execute_the_breach");
	common_scripts\utility::trigger_off();
	if(isdefined(param_00.ebreachmodel))
	{
		param_00.ebreachmodel delete();
	}
}

//Function Number: 11
breach_abort(param_00)
{
	self endon("breach_complete");
	self waittill("breach_abort");
	self.cleared = 1;
	thread breach_cleanup(param_00);
}

//Function Number: 12
breach_cleanup(param_00)
{
	while(!self.cleared)
	{
		wait(0.05);
	}

	if(isdefined(self.badplace))
	{
		badplace_delete(self.sbadplacename);
	}

	while(!self.cleared)
	{
		wait(0.05);
	}

	common_scripts\utility::array_thread(param_00,::breach_ai_reset,self);
}

//Function Number: 13
breach_ai_reset(param_00)
{
	self endon("death");
	breach_reset_animname();
	breach_reset_goaladius();
	param_00.animent notify(self.ender);
	self notify("stop_infinite_ammo");
	self pushplayer(0);
}

//Function Number: 14
breach_play_fx(param_00,param_01)
{
	self endon("breach_aborted");
	self endon("breach_complete");
	switch(param_00)
	{
		case "explosive_breach_left":
			break;

		case "shotgunhinges_breach_left":
			break;

		case "flash_breach_no_door_right":
			break;

		default:
			break;
	}
}

//Function Number: 15
spawnhostile(param_00)
{
	var_01 = param_00 dospawn();
	maps\_utility::spawn_failed(var_01);
	return var_01;
}

//Function Number: 16
spawnbreachhostiles(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = spawnhostile(param_00[var_02]);
		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 17
give_infinite_ammo()
{
	self endon("death");
	self endon("stop_infinite_ammo");
	while(isdefined(self.weapon))
	{
		if(isdefined(self.weapon) && self.weapon == "none")
		{
			break;
		}

		self.bulletsinclip = weaponclipsize(self.weapon);
		wait(0.5);
	}
}

//Function Number: 18
door_animation(param_00,param_01)
{
	var_02 = "breach_door";
	if(!isdefined(level.scr_anim[var_02]))
	{
		return;
	}

	var_03 = undefined;
	switch(param_00)
	{
		case "explosive":
			break;

		case "shotgun":
			break;
	}
}

//Function Number: 19
door_open(param_00,param_01,param_02)
{
	var_03 = self;
	if(isdefined(param_01.ebreacheddoor))
	{
		self hide();
		self notsolid();
		param_01.ebreacheddoor show();
		param_01.ebreacheddoor solid();
		var_03 = param_01.ebreacheddoor;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_02 == 1)
	{
		self playsound(level.scr_sound["breach_wood_door_kick"]);
	}

	switch(param_00)
	{
		case "explosive":
			break;

		case "shotgun":
			break;
	}
}

//Function Number: 20
door_connectpaths()
{
	if(self.classname == "script_brushmodel")
	{
		self connectpaths();
		return;
	}

	var_00 = getent(self.target,"targetname");
	var_00 hide();
	var_00 notsolid();
	var_00 connectpaths();
}

//Function Number: 21
door_fall_over(param_00)
{
	var_01 = undefined;
	if(self.classname == "script_model")
	{
		var_01 = anglestoforward(self.angles);
	}
	else if(self.classname == "script_brushmodel")
	{
		var_01 = self.vector;
	}
	else
	{
	}

	var_02 = (var_01[0] * 20,var_01[1] * 20,var_01[2] * 20);
	self moveto(self.origin + var_02,0.5,0,0.5);
	var_03 = spawn("script_origin",(0,0,0));
	var_03.angles = param_00.angles;
	var_03.origin = (self.origin[0],self.origin[1],param_00.origin[2]);
	self linkto(var_03);
	var_03 rotatepitch(90,0.45,0.4);
	wait(0.45);
	var_03 rotatepitch(-4,0.2,0,0.2);
	wait(0.2);
	var_03 rotatepitch(4,0.15,0.15);
	wait(0.15);
	self unlink();
	var_03 delete();
}

//Function Number: 22
breach_set_goaladius(param_00)
{
	if(!isdefined(self.old_goalradius))
	{
		self.old_goalradius = self.goalradius;
	}

	self.goalradius = param_00;
}

//Function Number: 23
breach_reset_goaladius()
{
	if(isdefined(self.old_goalradius))
	{
		self.goalradius = self.old_goalradius;
	}

	self.old_goalradius = undefined;
}

//Function Number: 24
breach_set_animname(param_00)
{
	if(!isdefined(self.old_animname))
	{
		self.old_animname = self.animname;
	}

	self.animname = param_00;
}

//Function Number: 25
breach_reset_animname()
{
	if(isdefined(self.old_animname))
	{
		self.animname = self.old_animname;
	}

	self.old_animname = undefined;
}