/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _hms_door_interact.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 197 ms
 * Timestamp: 4/22/2024 2:21:24 AM
*******************************************************************/

//Function Number: 1
precachedooranimations()
{
	level.scr_anim["DoorOpenNPC"]["door_kick_in"] = %door_kick_in;
	level.scr_anim["DoorOpenNPC"]["slow_door_open"] = %hunted_open_barndoor;
	level.scr_anim["DoorOpenNPC"]["charge_door_open"] = %africa_soap_shoulder_charge_door;
	level.scr_anim["DoorOpenNPC"]["shoot_hinge_door_open"] = %shotgunbreach_v1_shoot_hinge_runin;
	level.scr_anim["BreachGuy1"]["hms_greece_cc_meeting_breach_idle_start"][0] = %hms_greece_cc_meeting_breach_idle_start_npc;
	level.scr_anim["BreachGuy1"]["hms_greece_cc_meeting_breach"] = %hms_greece_cc_meeting_breach_npc;
	level.scr_anim["BreachGuy1"]["hms_greece_cc_meeting_breach_idle_hold"][0] = %hms_greece_cc_meeting_breach_idle_hold_npc;
	level.scr_anim["BreachGuy1"]["hms_greece_cc_meeting_bodycheck"] = %hms_greece_cc_meeting_bodycheck_npc;
	level.scr_anim["BreachGuy2"]["hms_greece_cc_meeting_breach_idle_start"][0] = %hms_greece_cc_meeting_breach_idle_start_npc1;
	level.scr_anim["BreachGuy2"]["hms_greece_cc_meeting_breach"] = %hms_greece_cc_meeting_breach_npc1;
	level.scr_anim["BreachGuy2"]["hms_greece_cc_meeting_breach_idle_hold"][0] = %hms_greece_cc_meeting_breach_idle_hold_npc1;
	level.scr_anim["BreachGuy2"]["hms_greece_cc_meeting_bodycheck"] = %hms_greece_cc_meeting_bodycheck_npc1;
}

//Function Number: 2
opendoor(param_00,param_01,param_02)
{
	if(param_01 != "pop" && param_01 != "fast" && !isdefined(param_02))
	{
	}

	if(isdefined(param_02))
	{
		foreach(var_04 in param_02)
		{
			if(!isai(var_04))
			{
			}
		}
	}

	var_06 = common_scripts\utility::getstruct(param_00,"targetname");
	var_07 = var_06.target;
	var_08 = getentarray(var_06.target,"targetname");
	foreach(var_0A in var_08)
	{
		if(var_0A.script_noteworthy == "door")
		{
			var_0B = var_0A;
			var_08 = common_scripts\utility::array_remove(var_08,var_0B);
			if(!isdefined(var_0B.state))
			{
				var_0B.state = "closed";
			}

			if(param_01 == "pop")
			{
				var_0B thread _popopen();
			}
			else if(param_01 == "fast")
			{
				var_0B thread _fastopen(0);
			}
			else if(isdefined(param_02) && isarray(param_02))
			{
				thread _setupdooranimstyle(var_0B,var_08,param_01,param_02);
			}
			else
			{
				_setupdooranimstyle(var_0B,var_08,param_01);
			}

			return var_0B;
		}
	}
}

//Function Number: 3
_setupdooranimstyle(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02) || !isstring(param_02))
	{
		param_02 = "slow";
	}

	switch(param_02)
	{
		case "slow":
			var_04 = "slow_door_open";
			var_05 = _returnanimorigin(param_01,param_02);
			thread _startdooropen(param_00,var_05,var_04,param_02);
			break;

		case "kick":
			var_04 = "door_kick_in";
			var_05 = _returnanimorigin(param_01,param_02);
			thread _startdooropen(param_00,var_05,var_04,param_02);
			break;

		case "charge":
			var_04 = "charge_door_open";
			var_05 = _returnanimorigin(param_01,param_02);
			thread _startdooropen(param_00,var_05,var_04,param_02);
			break;

		case "hinge":
			var_04 = "shoot_hinge_door_open";
			var_05 = _returnanimorigin(param_01,param_02);
			thread _startdooropen(param_00,var_05,var_04,param_02);
			break;

		case "cc_breach":
			var_05 = _returnanimorigin(param_01,param_02);
			thread _squaddoorbreach(param_00,var_05,param_03);
			break;
	}
}

//Function Number: 4
_returnanimorigin(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(param_01 == var_03.script_noteworthy)
		{
			var_04 = var_03;
			return var_04;
		}
	}
}

//Function Number: 5
_startdooropen(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("dying");
	var_04 = self.goalradius;
	self.goalradius = 32;
	var_05 = self.animname;
	self.animname = "DoorOpenNPC";
	param_01 maps\_anim::anim_reach_solo(self,param_02);
	if(param_03 == "kick")
	{
		param_00 thread _fastopen(2.15);
	}
	else if(param_03 == "slow")
	{
		param_00 thread _slowopen(1.8);
	}
	else if(param_03 == "charge")
	{
		param_00 thread _fastopen(2.45);
	}
	else if(param_03 == "hinge")
	{
		param_00 thread _fastopen(1.82);
	}

	param_01 maps\_anim::anim_single_solo_run(self,param_02);
	self.animname = var_05;
	self.goalradius = var_04;
	param_00 notify("Open");
}

//Function Number: 6
_squaddoorbreach(param_00,param_01,param_02)
{
	var_03 = 1;
	foreach(var_05 in param_02)
	{
		var_05.oldgoalradius = var_05.goalradius;
		var_05.previousgoalnode = var_05.last_set_goalnode;
		var_05.oldgrenadeawareness = var_05.grenadeawareness;
		var_05.goalradius = 32;
		var_05.oldanimname = var_05.animname;
		var_05.animname = "BreachGuy" + var_03;
		var_05 maps\_utility::setflashbangimmunity(1);
		var_05.grenadeawareness = 0;
		var_03++;
	}

	var_07 = "hms_greece_cc_meeting_breach_idle_start";
	var_08 = "hms_greece_cc_meeting_breach";
	var_09 = "hms_greece_cc_meeting_breach_idle_hold";
	var_0A = "hms_greece_cc_meeting_bodycheck";
	param_01 thread maps\_anim::anim_loop(param_02,var_07,"stop_idle_start");
	level waittill("cc_final_breach");
	param_01 notify("stop_idle_start");
	param_00 thread _fastopen(0.96);
	thread _handlebreachgrenade(param_00,param_01,param_02);
	param_01 maps\_anim::anim_single(param_02,var_08);
	param_01 thread maps\_anim::anim_loop(param_02,var_09,"stop_idle_hold");
	level waittill("cc_bodycheck");
	param_01 notify("stop_idle_hold");
	param_01 maps\_anim::anim_single_run(param_02,var_0A);
	foreach(var_05 in param_02)
	{
		var_05.animname = var_05.oldanimname;
		var_05.goalradius = var_05.oldgoalradius;
		var_05 maps\_utility::setflashbangimmunity(0);
		var_05.grenadeawareness = var_05.oldgrenadeawareness;
	}
}

//Function Number: 7
_handlebreachgrenade(param_00,param_01,param_02)
{
	foreach(var_04 in param_02)
	{
		if(var_04.animname == "BreachGuy2")
		{
			var_05 = anglestoright(param_01.angles);
			var_06 = param_01.origin;
			var_07 = var_06 + var_05 * 256;
			var_08 = var_04 _delaygrenadethrow(2.1,var_07);
			var_08 waittill("death");
			param_00 notify("flashbang_done");
		}
	}
}

//Function Number: 8
_delaygrenadethrow(param_00,param_01)
{
	var_02 = "tag_eye";
	if(isdefined(param_00) && param_00 > 0)
	{
		wait(param_00);
		var_03 = self gettagorigin(var_02);
		var_04 = self gettagangles(var_02);
		var_05 = anglestoforward(var_04);
		var_06 = var_03 + var_05 * 16;
		var_07 = magicgrenade("flash_grenade",var_06,param_01,1.5);
		return var_07;
	}
}

//Function Number: 9
_fastopen(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 120;
	}

	if(isdefined(param_00) && param_00 > 0)
	{
		wait(param_00);
	}

	self rotateto(self.angles + (0,param_01,0),0.35,0,0.35);
	earthquake(0.25,0.2,self.origin,256);
	if(self.classname != "script_model")
	{
		self connectpaths();
	}

	self.state = "open";
	self notify("Open");
}

//Function Number: 10
_slowopen(param_00)
{
	if(isdefined(param_00) && param_00 > 0)
	{
		wait(param_00);
	}

	self rotateto(self.angles + (0,100,0),2,0.5,0);
	if(self.classname != "script_model")
	{
		self connectpaths();
	}

	self.state = "open";
	self notify("Open");
}

//Function Number: 11
_popopen()
{
	if(self.state == "closed")
	{
		self rotateto(self.angles + (0,100,0),0.1,0,0);
		if(self.classname != "script_model")
		{
			self connectpaths();
		}

		self.state = "open";
	}

	self notify("Open");
}