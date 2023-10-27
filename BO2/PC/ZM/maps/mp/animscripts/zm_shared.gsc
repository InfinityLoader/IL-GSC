/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\zm_shared.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 205 ms
 * Timestamp: 10/27/2023 3:02:23 AM
*******************************************************************/

#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;
#include maps/mp/animscripts/zm_utility;

//Function Number: 1
deleteatlimit()
{
	wait(30);
	self delete();
}

//Function Number: 2
lookatentity(looktargetentity,lookduration,lookspeed,eyesonly,interruptothers)
{
}

//Function Number: 3
lookatposition(looktargetpos,lookduration,lookspeed,eyesonly,interruptothers)
{
/#
	assert(isai(self),"Can only call this function on an AI character");
#/
/#
	assert(self.a.targetlookinitilized == 1,"LookAtPosition called on AI that lookThread was not called on");
#/
/#
	assert(lookspeed == "casual" || lookspeed == "alert","lookSpeed must be casual or alert");
#/
	if(!IsDefined(interruptothers) || interruptothers == "interrupt others" || GetTime() > self.a.lookendtime)
	{
		self.a.looktargetpos = looktargetpos;
		self.a.lookendtime = GetTime() + lookduration * 1000;
		if(lookspeed == "casual")
		{
			self.a.looktargetspeed = 800;
		}
		else
		{
			self.a.looktargetspeed = 1600;
		}

		if(IsDefined(eyesonly) && eyesonly == "eyes only")
		{
			self notify("eyes look now");
		}
		else
		{
			self notify("look now");
		}
	}
}

//Function Number: 4
lookatanimations(leftanim,rightanim)
{
	self.a.lookanimationleft = leftanim;
	self.a.lookanimationright = rightanim;
}

//Function Number: 5
handledogsoundnotetracks(note)
{
	if(note == "sound_dogstep_run_default" || note == "dogstep_rf" || note == "dogstep_lf")
	{
		self playsound("fly_dog_step_run_default");
		return 1;
	}

	prefix = getsubstr(note,0,5);
	if(prefix != "sound")
	{
		return 0;
	}

	alias = "aml" + getsubstr(note,5);
	if(isalive(self))
	{
		self thread play_sound_on_tag_endon_death(alias,"tag_eye");
	}
	else
	{
		self thread play_sound_in_space(alias,self gettagorigin("tag_eye"));
	}

	return 1;
}

//Function Number: 6
growling()
{
	return IsDefined(self.script_growl);
}

//Function Number: 7
registernotetracks()
{
	anim.notetracks["anim_pose = \"stand\"] = ::notetrackposestand;
	anim.notetracks["anim_pose = \"crouch\"] = ::notetrackposecrouch;
	anim.notetracks["anim_movement = \"stop\"] = ::notetrackmovementstop;
	anim.notetracks["anim_movement = \"walk\"] = ::notetrackmovementwalk;
	anim.notetracks["anim_movement = \"run\"] = ::notetrackmovementrun;
	anim.notetracks["anim_alertness = causal"] = ::notetrackalertnesscasual;
	anim.notetracks["anim_alertness = alert"] = ::notetrackalertnessalert;
	anim.notetracks["gravity on"] = ::notetrackgravity;
	anim.notetracks["gravity off"] = ::notetrackgravity;
	anim.notetracks["gravity code"] = ::notetrackgravity;
	anim.notetracks["bodyfall large"] = ::notetrackbodyfall;
	anim.notetracks["bodyfall small"] = ::notetrackbodyfall;
	anim.notetracks["footstep"] = ::notetrackfootstep;
	anim.notetracks["step"] = ::notetrackfootstep;
	anim.notetracks["footstep_right_large"] = ::notetrackfootstep;
	anim.notetracks["footstep_right_small"] = ::notetrackfootstep;
	anim.notetracks["footstep_left_large"] = ::notetrackfootstep;
	anim.notetracks["footstep_left_small"] = ::notetrackfootstep;
	anim.notetracks["footscrape"] = ::notetrackfootscrape;
	anim.notetracks["land"] = ::notetrackland;
	anim.notetracks["start_ragdoll"] = ::notetrackstartragdoll;
}

//Function Number: 8
notetrackstopanim(note,flagname)
{
}

//Function Number: 9
notetrackstartragdoll(note,flagname)
{
	if(IsDefined(self.noragdoll))
	{
		return;
	}

	self unlink();
	self startragdoll();
}

//Function Number: 10
notetrackmovementstop(note,flagname)
{
	if(issentient(self))
	{
		self.a.movement = "stop";
	}
}

//Function Number: 11
notetrackmovementwalk(note,flagname)
{
	if(issentient(self))
	{
		self.a.movement = "walk";
	}
}

//Function Number: 12
notetrackmovementrun(note,flagname)
{
	if(issentient(self))
	{
		self.a.movement = "run";
	}
}

//Function Number: 13
notetrackalertnesscasual(note,flagname)
{
	if(issentient(self))
	{
		self.a.alertness = "casual";
	}
}

//Function Number: 14
notetrackalertnessalert(note,flagname)
{
	if(issentient(self))
	{
		self.a.alertness = "alert";
	}
}

//Function Number: 15
notetrackposestand(note,flagname)
{
	self.a.pose = "stand";
	self notify("entered_pose" + "stand");
}

//Function Number: 16
notetrackposecrouch(note,flagname)
{
	self.a.pose = "crouch";
	self notify("entered_pose" + "crouch");
	if(self.a.crouchpain)
	{
		self.a.crouchpain = 0;
		self.health = 150;
	}
}

//Function Number: 17
notetrackgravity(note,flagname)
{
	if(issubstr(note,"on"))
	{
		self animmode("gravity");
	}
	else if(issubstr(note,"off"))
	{
		self animmode("nogravity");
		self.nogravity = 1;
	}
	else if(issubstr(note,"code"))
	{
		self animmode("none");
		self.nogravity = undefined;
	}
}

//Function Number: 18
notetrackbodyfall(note,flagname)
{
	if(IsDefined(self.groundtype))
	{
		groundtype = self.groundtype;
	}
	else
	{
		groundtype = "dirt";
	}

	if(issubstr(note,"large"))
	{
		self playsound("fly_bodyfall_large_" + groundtype);
	}
	else if(issubstr(note,"small"))
	{
		self playsound("fly_bodyfall_small_" + groundtype);
	}
}

//Function Number: 19
notetrackfootstep(note,flagname)
{
	if(issubstr(note,"left"))
	{
		playfootstep("J_Ball_LE");
	}
	else
	{
		playfootstep("J_BALL_RI");
	}

	if(!(level.clientscripts))
	{
		self playsound("fly_gear_run");
	}
}

//Function Number: 20
notetrackfootscrape(note,flagname)
{
	if(IsDefined(self.groundtype))
	{
		groundtype = self.groundtype;
	}
	else
	{
		groundtype = "dirt";
	}

	self playsound("fly_step_scrape_" + groundtype);
}

//Function Number: 21
notetrackland(note,flagname)
{
	if(IsDefined(self.groundtype))
	{
		groundtype = self.groundtype;
	}
	else
	{
		groundtype = "dirt";
	}

	self playsound("fly_land_npc_" + groundtype);
}

//Function Number: 22
handlenotetrack(note,flagname,customfunction,var1)
{
	if(isai(self) && self.isdog)
	{
		if(handledogsoundnotetracks(note))
		{
			return;
		}
	}
	else
	{
		notetrackfunc = anim.notetracks[note];
		if(IsDefined(notetrackfunc))
		{
			return [[ notetrackfunc ]](note,flagname);
		}
	}

	switch(note)
	{
		case "end":
		case "finish":
		case "undefined":
			return note;
	isai(self) && self.a.pose == "back"
			break;

		case "swish small":
			self thread play_sound_in_space("fly_gear_enemy",self gettagorigin("TAG_WEAPON_RIGHT"));
			break;

		case "swish large":
			self thread play_sound_in_space("fly_gear_enemy_large",self gettagorigin("TAG_WEAPON_RIGHT"));
			break;

		case "no death":
			self.a.nodeath = 1;
			break;

		case "no pain":
			self.allowpain = 0;
			break;

		case "allow pain":
			self.allowpain = 1;
			break;

		case "anim_melee = \"right\":
		case "anim_melee = right":
			self.a.meleestate = "right";
			break;

		case "anim_melee = \"left\":
		case "anim_melee = left":
			self.a.meleestate = "left";
			break;

		case "swap taghelmet to tagleft":
			self detach(self.helmetsidemodel,"TAG_HELMETSIDE");
			self.helmetsidemodel = undefined;
			self detach(self.hatmodel,"");
			self attach(self.hatmodel,"TAG_WEAPON_LEFT");
			self.hatmodel = undefined;
			break;
	IsDefined(self.helmetsidemodel)
	IsDefined(self.hatmodel)
			break;

		default:
			return [[ customfunction ]](note);
			return [[ customfunction ]](note,var1);
	Stack-Empty ? IsDefined(customfunction) : IsDefined(var1)
			break;
	}
}

//Function Number: 23
donotetracks(flagname,customfunction,var1)
{
	for(;;)
	{
		self waittill(flagname,note);
		if(!(IsDefined(note)))
		{
			note = "undefined";
		}

		val = self handlenotetrack(note,flagname,customfunction,var1);
		if(IsDefined(val))
		{
			return val;
		}
	}
}

//Function Number: 24
donotetracksforeverproc(notetracksfunc,flagname,killstring,customfunction,var1)
{
	if(IsDefined(killstring))
	{
		self endon(killstring);
	}

	self endon("killanimscript");
	for(;;)
	{
		time = GetTime();
		returnednote = [[ notetracksfunc ]](flagname,customfunction,var1);
		timetaken = GetTime() - time;
		if(timetaken < 0.05)
		{
			time = GetTime();
			returnednote = [[ notetracksfunc ]](flagname,customfunction,var1);
			timetaken = GetTime() - time;
			if(timetaken < 0.05)
			{
/#
				println(GetTime() + " mapsmpanimscriptsshared::DoNoteTracksForever is trying to cause an infinite loop on anim " + flagname + ", returned " + returnednote + ".");
#/
				wait(0.05 - timetaken);
			}
		}
	}
}

//Function Number: 25
donotetracksforever(flagname,killstring,customfunction,var1)
{
	donotetracksforeverproc(::donotetracks,flagname,killstring,customfunction,var1);
}

//Function Number: 26
donotetracksfortimeproc(donotetracksforeverfunc,time,flagname,customfunction,ent,var1)
{
	ent endon("stop_notetracks");
	[[ donotetracksforeverfunc ]](flagname,undefined,customfunction,var1);
}

//Function Number: 27
donotetracksfortime(time,flagname,customfunction,var1)
{
	ent = spawnstruct();
	ent thread donotetracksfortimeendnotify(time);
	donotetracksfortimeproc(::donotetracksforever,time,flagname,customfunction,ent,var1);
}

//Function Number: 28
donotetracksfortimeendnotify(time)
{
	wait(time);
	self notify("stop_notetracks");
}

//Function Number: 29
playfootstep(foot)
{
	if(!(level.clientscripts))
	{
		if(!(isai(self)))
		{
			self playsound("fly_step_run_dirt");
			return;
		}
	}

	groundtype = undefined;
	if(!(IsDefined(self.groundtype)))
	{
		if(!(IsDefined(self.lastgroundtype)))
		{
			if(!(level.clientscripts))
			{
				self playsound("fly_step_run_dirt");
			}

			return;
		}

		groundtype = self.lastgroundtype;
	}
	else
	{
		groundtype = self.groundtype;
		self.lastgroundtype = self.groundtype;
	}

	if(!(level.clientscripts))
	{
		self playsound("fly_step_run_" + groundtype);
	}

	[[ anim.optionalstepeffectfunction ]](foot,groundtype);
}

//Function Number: 30
playfootstepeffect(foot,groundtype)
{
	if(level.clientscripts)
	{
		return;
	}

	for(i = 0;i < anim.optionalstepeffects.size;i++)
	{
		if(IsDefined(self.fire_footsteps) && self.fire_footsteps)
		{
			groundtype = "fire";
		}

		if(groundtype != anim.optionalstepeffects[i])
		{
		}
		else
		{
			org = self gettagorigin(foot);
			playfx(level._effect["step_" + anim.optionalstepeffects[i]],org,100 + VectorScale((0,0,1)));
			return;
		}
	}
}

//Function Number: 31
movetooriginovertime(origin,time)
{
	self endon("killanimscript");
	if(distancesquared(self.origin,origin) > 256 && !self maymovetopoint(origin))
	{
/#
		println("^1Warning: AI starting behavior for node at " + origin + " but could not move to that point.");
#/
		return;
	}

	self.keepclaimednodeingoal = 1;
	offset = self.origin - origin;
	frames = int(time * 20);
	offsetreduction = VectorScale(offset);
	for(i = 0;i < frames;i++)
	{
		offset = offset - offsetreduction;
		self teleport(origin + offset);
		wait(0.05);
	}

	self.keepclaimednodeingoal = 0;
}

//Function Number: 32
returntrue()
{
	return 1;
}