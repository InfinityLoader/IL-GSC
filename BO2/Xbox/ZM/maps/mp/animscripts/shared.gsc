/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\shared.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 12
 * Decompile Time: 2 ms
 * Timestamp: 10/28/2023 12:14:06 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/animscripts/utility;

//Function Number: 1
handledogsoundnotetracks(note)
{
	if(note == "sound_dogstep_run_default")
	{
		return 1;
	}

	prefix = getsubstr(note,0,5);
	if(prefix != "sound")
	{
		return 0;
	}

	return 1;
}

//Function Number: 2
growling()
{
	return IsDefined(self.script_growl);
}

//Function Number: 3
handlenotetrack(note,flagname,customfunction,var1)
{
/#
	if(GetDvarInt(#"6EBEB982"))
	{
		println("dog notetrack: " + flagname + " " + note + " " + GetTime());
	}
#/
	if(isai(self) && self.type == "dog")
	{
		if(handledogsoundnotetracks(note))
		{
			return;
		}
	}

	switch(note)
	{
		case "€GSC\r\n":
		case "€GSC\r\n":
		case "€GSC\r\n":
			return note;

		default:
			return [[ customfunction ]](note);
			return [[ customfunction ]](note,var1);
	IsDefined(var1)
	IsDefined(customfunction)
			break;
	}
}

//Function Number: 4
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

//Function Number: 5
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

//Function Number: 6
donotetracksforever(flagname,killstring,customfunction,var1)
{
	donotetracksforeverproc(::donotetracks,flagname,killstring,customfunction,var1);
}

//Function Number: 7
donotetracksfortimeproc(donotetracksforeverfunc,time,flagname,customfunction,ent,var1)
{
	ent endon("stop_notetracks");
	[[ donotetracksforeverfunc ]](flagname,undefined,customfunction,var1);
}

//Function Number: 8
donotetracksfortime(time,flagname,customfunction,var1)
{
	ent = spawnstruct();
	ent thread donotetracksfortimeendnotify(time);
	donotetracksfortimeproc(::donotetracksforever,time,flagname,customfunction,ent,var1);
}

//Function Number: 9
donotetracksfortimeendnotify(time)
{
	wait(time);
	self notify("stop_notetracks");
}

//Function Number: 10
trackloop()
{
	players = get_players();
	deltachangeperframe = 5;
	aimblendtime = 0.05;
	prevyawdelta = 0;
	prevpitchdelta = 0;
	maxyawdeltachange = 5;
	maxpitchdeltachange = 5;
	pitchadd = 0;
	yawadd = 0;
	if(self.type == "dog" || self.type == "zombie" || self.type == "zombie_dog")
	{
		domaxanglecheck = 0;
		self.shootent = self.enemy;
	}
	else
	{
		domaxanglecheck = 1;
		if(self.a.script == "cover_crouch" && IsDefined(self.a.covermode) && self.a.covermode == "lean")
		{
			pitchadd = -1 * anim.covercrouchleanpitch;
		}

		if((self.a.script == "cover_left" || self.a.script == "cover_right") && IsDefined(self.a.cornermode) && self.a.cornermode == "lean")
		{
			yawadd = self.covernode.angles[1] - self.angles[1];
		}
	}

	yawdelta = 0;
	pitchdelta = 0;
	firstframe = 1;
	for(;;)
	{
		incranimaimweight();
		selfshootatpos = (self.origin[0],self.origin[1],self geteye()[2]);
		shootpos = undefined;
		if(IsDefined(self.enemy))
		{
			shootpos = self.enemy getshootatpos();
		}

		if(!(IsDefined(shootpos)))
		{
			yawdelta = 0;
			pitchdelta = 0;
		}
		else
		{
			vectortoshootpos = shootpos - selfshootatpos;
			anglestoshootpos = VectorToAngles(vectortoshootpos);
			pitchdelta = 360 - anglestoshootpos[0];
			pitchdelta = AngleClamp180(pitchdelta + pitchadd);
			yawdelta = self.angles[1] - anglestoshootpos[1];
			yawdelta = AngleClamp180(yawdelta + yawadd);
		}

		if(domaxanglecheck && Abs(yawdelta) > 60 || Abs(pitchdelta) > 60)
		{
			yawdelta = 0;
			pitchdelta = 0;
		}
		else
		{
			if(yawdelta > self.rightaimlimit)
			{
				yawdelta = self.rightaimlimit;
			}
			else if(yawdelta < self.leftaimlimit)
			{
				yawdelta = self.leftaimlimit;
			}

			if(pitchdelta > self.upaimlimit)
			{
				pitchdelta = self.upaimlimit;
			}
			else if(pitchdelta < self.downaimlimit)
			{
				pitchdelta = self.downaimlimit;
			}
		}

		if(firstframe)
		{
			firstframe = 0;
		}
		else
		{
			yawdeltachange = yawdelta - prevyawdelta;
			if(Abs(yawdeltachange) > maxyawdeltachange)
			{
				yawdelta = prevyawdelta + maxyawdeltachange * sign(yawdeltachange);
			}

			pitchdeltachange = pitchdelta - prevpitchdelta;
			if(Abs(pitchdeltachange) > maxpitchdeltachange)
			{
				pitchdelta = prevpitchdelta + maxpitchdeltachange * sign(pitchdeltachange);
			}
		}

		prevyawdelta = yawdelta;
		prevpitchdelta = pitchdelta;
		updown = 0;
		leftright = 0;
		if(yawdelta > 0)
		{
/#
			assert(yawdelta <= self.rightaimlimit);
#/
			weight = yawdelta / self.rightaimlimit * self.a.aimweight;
			leftright = weight;
		}
		else if(yawdelta < 0)
		{
/#
			assert(yawdelta >= self.leftaimlimit);
#/
			weight = yawdelta / self.leftaimlimit * self.a.aimweight;
			leftright = -1 * weight;
		}

		if(pitchdelta > 0)
		{
/#
			assert(pitchdelta <= self.upaimlimit);
#/
			weight = pitchdelta / self.upaimlimit * self.a.aimweight;
			updown = weight;
		}
		else if(pitchdelta < 0)
		{
/#
			assert(pitchdelta >= self.downaimlimit);
#/
			weight = pitchdelta / self.downaimlimit * self.a.aimweight;
			updown = -1 * weight;
		}

		self setaimanimweights(updown,leftright);
		wait(0.05);
	}
}

//Function Number: 11
setanimaimweight(goalweight,goaltime)
{
	if(!IsDefined(goaltime) || goaltime <= 0)
	{
		self.a.aimweight = goalweight;
		self.a.aimweight_start = goalweight;
		self.a.aimweight_end = goalweight;
		self.a.aimweight_transframes = 0;
	}
	else
	{
		self.a.aimweight = goalweight;
		self.a.aimweight_start = self.a.aimweight;
		self.a.aimweight_end = goalweight;
		self.a.aimweight_transframes = int(goaltime * 20);
	}

	self.a.aimweight_t = 0;
}

//Function Number: 12
incranimaimweight()
{
	if(self.a.aimweight_t < self.a.aimweight_transframes)
	{
		self.a.aimweight_t++;
		t = 1 * self.a.aimweight_t / self.a.aimweight_transframes;
		self.a.aimweight = self.a.aimweight_start * 1 - t + self.a.aimweight_end * t;
	}
}