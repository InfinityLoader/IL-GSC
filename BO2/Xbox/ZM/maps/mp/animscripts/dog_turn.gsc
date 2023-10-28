/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\dog_turn.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 10
 * Decompile Time: 1 ms
 * Timestamp: 10/28/2023 12:14:06 AM
*******************************************************************/

#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;

//Function Number: 1
main()
{
	self endon("killanimscript");
	debug_turn_print("dog_turn::main()");
	self setaimanimweights(0,0);
	self.safetochangescript = 0;
	deltayaw = self getdeltaturnyaw();
	if(need_to_turn_around(deltayaw))
	{
		turn_180(deltayaw);
	}
	else
	{
		turn_90(deltayaw);
	}

	move_out_of_turn();
	self.skipstartmove = 1;
	self.safetochangescript = 1;
}

//Function Number: 2
need_to_turn_around(deltayaw)
{
	angle = GetDvarFloat(#"91E9B846");
	if(deltayaw >= angle || deltayaw <= -1 * angle)
	{
		debug_turn_print("dog_turn::need_to_turn_around(): " + deltayaw + " YES");
		return 1;
	}

	debug_turn_print("dog_turn::need_to_turn_around(): " + deltayaw + " NO");
	return 0;
}

//Function Number: 3
do_turn_anim(stopped_anim,run_anim,wait_time,run_wait_time)
{
	speed = length(self getvelocity());
	do_anim = stopped_anim;
	if(level.dogrunturnspeed < speed)
	{
		do_anim = run_anim;
		wait_time = run_wait_time;
	}

	debug_turn_print("dog_turn::do_turn_anim() - Setting " + do_anim);
	self setanimstate(do_anim);
	maps/mp/animscripts/shared::donotetracksfortime(run_wait_time,"done");
	debug_turn_print("dog_turn::do_turn_anim() - done with " + do_anim + " wait time " + run_wait_time);
}

//Function Number: 4
turn_left()
{
	self do_turn_anim("move_turn_left","move_run_turn_left",0.5,0.5);
}

//Function Number: 5
turn_right()
{
	self do_turn_anim("move_turn_right","move_run_turn_right",0.5,0.5);
}

//Function Number: 6
turn_180_left()
{
	self do_turn_anim("move_turn_around_left","move_run_turn_around_left",0.5,0.7);
}

//Function Number: 7
turn_180_right()
{
	self do_turn_anim("move_turn_around_right","move_run_turn_around_right",0.5,0.7);
}

//Function Number: 8
move_out_of_turn()
{
	if(self.a.movement == "run")
	{
		debug_turn_print("dog_turn::move_out_of_turn() - Setting move_run");
		self setanimstate("move_run");
		maps/mp/animscripts/shared::donotetracksfortime(0.1,"done");
		debug_turn_print("dog_turn::move_out_of_turn() - move_run wait 0.1 done ");
	}
	else
	{
		debug_turn_print("dog_turn::move_out_of_turn() - Setting move_start ");
		self setanimstate("move_walk");
	}
}

//Function Number: 9
turn_90(deltayaw)
{
	self animmode("zonly_physics",0);
	debug_turn_print("dog_turn::turn_90() deltaYaw: " + deltayaw);
	if(deltayaw > 0)
	{
		debug_turn_print("dog_turn::turn_90() left",1);
		self turn_left();
	}
	else
	{
		debug_turn_print("dog_turn::turn_90() right",1);
		self turn_right();
	}
}

//Function Number: 10
turn_180(deltayaw)
{
	self animmode("zonly_physics",0);
	debug_turn_print("dog_turn::turn_180() deltaYaw: " + deltayaw);
	if(deltayaw > 0)
	{
		debug_turn_print("dog_turn::turn_180() left",1);
		self turn_180_left();
	}
	else
	{
		debug_turn_print("dog_turn::turn_180() right",1);
		self turn_180_right();
	}
}