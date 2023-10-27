/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\zm_move.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 82 ms
 * Timestamp: 10/27/2023 3:02:18 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;
#include maps/mp/animscripts/zm_run;
#include maps/mp/animscripts/zm_shared;
#include maps/mp/animscripts/zm_utility;

//Function Number: 1
main()
{
	self endon("killanimscript");
	self setaimanimweights(0,0);
	previousscript = self.a.script;
	maps/mp/animscripts/zm_utility::initialize("zombie_move");
	movemainloop();
}

//Function Number: 2
movemainloop()
{
	self endon("killanimscript");
	self endon("stop_soon");
	self.needs_run_update = 1;
	self notify("needs_run_update");
	self sidestepinit();
	self thread trysidestepthread();
	for(;;)
	{
		self maps/mp/animscripts/zm_run::moverun();
		if(IsDefined(self.zombie_can_sidestep) && self.zombie_can_sidestep)
		{
			self trysidestep();
		}
	}
}

//Function Number: 3
sidestepinit()
{
	self.a.steppeddir = 0;
	self.a.lastsidesteptime = GetTime();
}

//Function Number: 4
trysidestepthread()
{
	self endon("death");
	self notify("new_trySideStepThread");
	self endon("new_trySideStepThread");
	if(!(IsDefined(self.zombie_can_sidestep)))
	{
		return 0;
	}

	if(IsDefined(self.zombie_can_sidestep) && !self.zombie_can_sidestep)
	{
		return 0;
	}

	while(1)
	{
		self trysidestep();
		wait(0.05);
	}
}

//Function Number: 5
trysidestep()
{
	if(IsDefined(self.shouldsidestepfunc))
	{
		self.sidesteptype = self [[ self.shouldsidestepfunc ]]();
	}
	else
	{
		self.sidesteptype = shouldsidestep();
	}

	if(self.sidesteptype == "none")
	{
		if(IsDefined(self.zombie_can_forwardstep) && self.zombie_can_forwardstep)
		{
			self.sidesteptype = shouldforwardstep();
		}
	}

	if(self.sidesteptype == "none")
	{
		return 0;
	}

	self.desiredstepdir = getdesiredsidestepdir(self.sidesteptype);
	self.asd_name = "zm_" + self.sidesteptype + "_" + self.desiredstepdir;
	self.substate_index = self getanimsubstatefromasd(self.asd_name);
	self.stepanim = self getanimfromasd(self.asd_name,self.substate_index);
	if(!(self checkroomforanim(self.stepanim)))
	{
		return 0;
	}

	self.allowpain = 0;
	self animcustom(::dosidestep);
	self waittill("sidestep_done");
	self.allowpain = 1;
}

//Function Number: 6
getdesiredsidestepdir(sidesteptype)
{
	if(sidesteptype == "roll" || sidesteptype == "phase")
	{
		self.desiredstepdir = "forward";
		return self.desiredstepdir;
	}

/#
	assert(sidesteptype == "step","Unsupported SideStepType");
#/
	randomroll = randomfloat(1);
	if(self.a.steppeddir < 0)
	{
		self.desiredstepdir = "right";
	}
	else if(self.a.steppeddir > 0)
	{
		self.desiredstepdir = "left";
	}
	else if(randomroll < 0.5)
	{
		self.desiredstepdir = "right";
	}
	else
	{
		self.desiredstepdir = "left";
	}

	return self.desiredstepdir;
}

//Function Number: 7
checkroomforanim(stepanim)
{
	if(!(self maymovefrompointtopoint(self.origin,getanimendpos(stepanim))))
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
shouldsidestep()
{
	if(cansidestep() && isplayer(self.enemy) && self.enemy islookingat(self))
	{
		if(self.zombie_move_speed != "sprint" || randomfloat(1) < 0.7)
		{
			return "step";
		}
		else
		{
			return "roll";
		}
	}

	return "none";
}

//Function Number: 9
cansidestep()
{
	if(!IsDefined(self.zombie_can_sidestep) || !self.zombie_can_sidestep)
	{
		return 0;
	}

	if(GetTime() - self.a.lastsidesteptime < 2000)
	{
		return 0;
	}

	if(!(IsDefined(self.enemy)))
	{
		return 0;
	}

	if(self.a.pose != "stand")
	{
		return 0;
	}

	distsqfromenemy = distancesquared(self.origin,self.enemy.origin);
	if(distsqfromenemy < 4096)
	{
		return 0;
	}

	if(distsqfromenemy > 1000000)
	{
		return 0;
	}

	if(!IsDefined(self.pathgoalpos) || distancesquared(self.origin,self.pathgoalpos) < 4096)
	{
		return 0;
	}

	if(Abs(self getmotionangle()) > 15)
	{
		return 0;
	}

	yaw = getyawtoorigin(self.enemy.origin);
	if(Abs(yaw) > 45)
	{
		return 0;
	}

	return 1;
}

//Function Number: 10
shouldforwardstep()
{
	if(canforwardstep() && isplayer(self.enemy))
	{
		return "phase";
	}

	return "none";
}

//Function Number: 11
canforwardstep()
{
	if(IsDefined(self.a.lastsidesteptime) && GetTime() - self.a.lastsidesteptime < 2000)
	{
		return 0;
	}

	if(!(IsDefined(self.enemy)))
	{
		return 0;
	}

	if(self.a.pose != "stand")
	{
		return 0;
	}

	distsqfromenemy = distancesquared(self.origin,self.enemy.origin);
	if(distsqfromenemy < 14400)
	{
		return 0;
	}

	if(distsqfromenemy > 5760000)
	{
		return 0;
	}

	if(!IsDefined(self.pathgoalpos) || distancesquared(self.origin,self.pathgoalpos) < 4096)
	{
		return 0;
	}

	if(Abs(self getmotionangle()) > 15)
	{
		return 0;
	}

	yaw = getyawtoorigin(self.enemy.origin);
	if(Abs(yaw) > 45)
	{
		return 0;
	}

	return 1;
}

//Function Number: 12
dosidestep()
{
	self endon("death");
	self endon("killanimscript");
	self playsidestepanim(self.stepanim,self.sidesteptype);
	if(self.desiredstepdir == "left")
	{
		self.a.steppeddir--;
	}
	else
	{
		self.a.steppeddir++;
	}

	self.a.lastsidesteptime = GetTime();
	self notify("sidestep_done");
}

//Function Number: 13
playsidestepanim(stepanim,sidesteptype)
{
	self animmode("gravity",0);
	self orientmode("face angle",self.angles[1]);
	runblendouttime = 0.2;
	if(IsDefined(self.sidestepfunc))
	{
		self thread [[ self.sidestepfunc ]]("step_anim",stepanim);
	}

	self setanimstatefromasd(self.asd_name,self.substate_index);
	maps/mp/animscripts/zm_shared::donotetracks("step_anim");
	if(isalive(self))
	{
		self thread facelookaheadforabit();
	}
}

//Function Number: 14
facelookaheadforabit()
{
	self endon("death");
	self endon("killanimscript");
	lookaheadangles = VectorToAngles(self.lookaheaddir);
	self orientmode("face angle",lookaheadangles[1]);
	wait(0.2);
	self animmode("normal",0);
	self orientmode("face default");
}