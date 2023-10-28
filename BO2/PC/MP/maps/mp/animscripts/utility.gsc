/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\utility.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 1 ms
 * Timestamp: 10/28/2023 12:10:25 AM
*******************************************************************/

//Function Number: 1
anim_get_dvar_int(dvar,def)
{
	return int(anim_get_dvar(dvar,def));
}

//Function Number: 2
anim_get_dvar(dvar,def)
{
	if(GetDvar(dvar) != "")
	{
		return GetDvarFloat(dvar);
	}
	else
	{
		setdvar(dvar,def);
		return def;
	}
}

//Function Number: 3
set_orient_mode(mode,val1)
{
/#
	if(level.dog_debug_orient == self getentnum())
	{
		if(IsDefined(val1))
		{
			println("DOG:  Setting orient mode: " + mode + " " + val1 + " " + GetTime());
		}
		else
		{
			println("DOG:  Setting orient mode: " + mode + " " + GetTime());
		}
	}
#/
	if(IsDefined(val1))
	{
		self orientmode(mode,val1);
	}
	else
	{
		self orientmode(mode);
	}
}

//Function Number: 4
debug_anim_print(text)
{
/#
	if(level.dog_debug_anims)
	{
		println(text + " " + GetTime());
	}

	if(level.dog_debug_anims_ent == self getentnum())
	{
		println(text + " " + GetTime());
	}
#/
}

//Function Number: 5
debug_turn_print(text,line)
{
/#
	if(level.dog_debug_turns == self getentnum())
	{
		duration = 200;
		currentyawcolor = (1,1,1);
		lookaheadyawcolor = (1,0,0);
		desiredyawcolor = (1,1,0);
		currentyaw = AngleClamp180(self.angles[1]);
		desiredyaw = AngleClamp180(self.desiredangle);
		lookaheaddir = self.lookaheaddir;
		lookaheadangles = VectorToAngles(lookaheaddir);
		lookaheadyaw = AngleClamp180(lookaheadangles[1]);
		println(text + " " + GetTime() + " cur: " + currentyaw + " look: " + lookaheadyaw + " desired: " + desiredyaw);
	}
#/
}

//Function Number: 6
debug_allow_movement()
{
/#
	return anim_get_dvar_int("debug_dog_allow_movement","1");
#/
}

//Function Number: 7
debug_allow_combat()
{
/#
	return anim_get_dvar_int("debug_dog_allow_combat","1");
#/
}

//Function Number: 8
current_yaw_line_debug(duration)
{
/#
	currentyawcolor = [];
	currentyawcolor[0] = (0,0,1);
	currentyawcolor[1] = (1,0,1);
	current_color_index = 0;
	start_time = GetTime();
	if(!(IsDefined(level.lastdebugheight)))
	{
		level.lastdebugheight = 15;
	}

	while(GetTime() - start_time < 1000)
	{
		pos1 = (self.origin[0],self.origin[1],self.origin[2] + level.lastdebugheight);
		pos2 = current_color_index + 1 * 10 + VectorScale(AnglesToForward(self.angles));
		line(pos1,pos2,currentyawcolor[current_color_index],0.3,1,duration);
		current_color_index = current_color_index + 1 % currentyawcolor.size;
		wait(0.05);
	}

	if(level.lastdebugheight == 15)
	{
		level.lastdebugheight = 30;
	}
	else
	{
		level.lastdebugheight = 15;
	}
#/
}

//Function Number: 9
getanimdirection(damageyaw)
{
	if(damageyaw > 135 || damageyaw <= -135)
	{
		return "front";
	}
	else if(damageyaw > 45 && damageyaw <= 135)
	{
		return "right";
	}
	else if(damageyaw > -45 && damageyaw <= 45)
	{
		return "back";
	}
	else
	{
		return "left";
	}

	return "front";
}

//Function Number: 10
setfootstepeffect(name,fx)
{
/#
	assert(IsDefined(name),"Need to define the footstep surface type.");
#/
/#
	assert(IsDefined(fx),"Need to define the mud footstep effect.");
#/
	if(!(IsDefined(anim.optionalstepeffects)))
	{
		anim.optionalstepeffects = [];
	}

	anim.optionalstepeffects[anim.optionalstepeffects.size] = name;
	level._effect["step_" + name] = fx;
}