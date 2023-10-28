/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\dog_move.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 6
 * Decompile Time: 7 ms
 * Timestamp: 10/28/2023 12:14:05 AM
*******************************************************************/

#include maps/mp/animscripts/dog_stop;
#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;

//Function Number: 1
setup_sound_variables()
{
	level.dog_sounds["far"] = spawnstruct();
	level.dog_sounds["close"] = spawnstruct();
	level.dog_sounds["close"].minrange = 0;
	level.dog_sounds["close"].maxrange = 500;
	level.dog_sounds["close"].sound = "aml_dog_bark_close";
	level.dog_sounds["close"].soundlengthplaceholder = 0.2;
	level.dog_sounds["close"].aftersoundwaitmin = 0.1;
	level.dog_sounds["close"].aftersoundwaitmax = 0.3;
	level.dog_sounds["close"].minrangesqr = level.dog_sounds["close"].minrange * level.dog_sounds["close"].minrange;
	level.dog_sounds["close"].maxrangesqr = level.dog_sounds["close"].maxrange * level.dog_sounds["close"].maxrange;
	level.dog_sounds["far"].minrange = 500;
	level.dog_sounds["far"].maxrange = 0;
	level.dog_sounds["far"].sound = "aml_dog_bark";
	level.dog_sounds["far"].soundlengthplaceholder = 0.2;
	level.dog_sounds["far"].aftersoundwaitmin = 0.1;
	level.dog_sounds["far"].aftersoundwaitmax = 0.3;
	level.dog_sounds["far"].minrangesqr = level.dog_sounds["far"].minrange * level.dog_sounds["far"].minrange;
	level.dog_sounds["far"].maxrangesqr = level.dog_sounds["far"].maxrange * level.dog_sounds["far"].maxrange;
}

//Function Number: 2
main()
{
	self endon("killanimscript");
	debug_anim_print("dog_move::main()");
	self setaimanimweights(0,0);
	do_movement = 1;
/#
	if(!(debug_allow_movement()))
	{
		do_movement = 0;
	}
#/
	if(IsDefined(level.hostmigrationtimer))
	{
		do_movement = 0;
	}

	if(!IsDefined(self.traversecomplete) && !IsDefined(self.skipstartmove) && self.a.movement == "run" && do_movement)
	{
		self startmove();
		blendtime = 0;
	}
	else
	{
		blendtime = 0.2;
	}

	self.traversecomplete = undefined;
	self.skipstartmove = undefined;
	if(do_movement)
	{
		if(shouldrun())
		{
			debug_anim_print("dog_move::main() - Setting move_run");
			self setanimstate("move_run");
			maps/mp/animscripts/shared::donotetracksfortime(0.1,"done");
			debug_anim_print("dog_move::main() - move_run wait 0.1 done ");
		}
		else
		{
			debug_anim_print("dog_move::main() - Setting move_start ");
			self setanimstate("move_walk");
			maps/mp/animscripts/shared::donotetracksfortime(0.1,"done");
		}
	}

	self thread maps/mp/animscripts/dog_stop::lookattarget("normal");
	while(1)
	{
		self moveloop();
		if(self.a.movement == "run")
		{
			if(self.disablearrivals == 0)
			{
				self thread stopmove();
			}

			self waittill("run");
		}
	}
}

//Function Number: 3
moveloop()
{
	self endon("killanimscript");
	self endon("stop_soon");
	while(1)
	{
		do_movement = 1;
/#
		if(!(debug_allow_movement()))
		{
			do_movement = 0;
		}
#/
		if(IsDefined(level.hostmigrationtimer))
		{
			do_movement = 0;
		}

		if(!(do_movement))
		{
			self setaimanimweights(0,0);
			self setanimstate("stop_idle");
			maps/mp/animscripts/shared::donotetracks("done");
			continue;
		}

		if(self.disablearrivals)
		{
			self.stopanimdistsq = 0;
		}
		else
		{
			self.stopanimdistsq = level.dogstoppingdistsq;
		}

		if(shouldrun())
		{
			debug_anim_print("dog_move::moveLoop() - Setting move_run");
			self setanimstate("move_run");
			maps/mp/animscripts/shared::donotetracksfortime(0.2,"done");
			debug_anim_print("dog_move::moveLoop() - move_run wait 0.2 done ");
			continue;
		}

		debug_anim_print("dog_move::moveLoop() - Setting move_walk ");
		self setanimstate("move_walk");
		maps/mp/animscripts/shared::donotetracksfortime(0.2,"done");
		debug_anim_print("dog_move::moveLoop() - move_walk wait 0.2 done ");
	}
}

//Function Number: 4
startmove()
{
	debug_anim_print("dog_move::startMove() - Setting move_start ");
	self setanimstate("move_start");
	maps/mp/animscripts/shared::donotetracks("done");
	debug_anim_print("dog_move::startMove() - move_start notify done.");
	self animmode("none",0);
	self set_orient_mode("face motion");
}

//Function Number: 5
stopmove()
{
	self endon("killanimscript");
	self endon("run");
	debug_anim_print("dog_move::stopMove() - Setting move_stop");
	self setanimstate("move_stop");
	maps/mp/animscripts/shared::donotetracks("done");
	debug_anim_print("dog_move::stopMove() - move_stop notify done.");
}

//Function Number: 6
shouldrun()
{
/#
	if(GetDvarInt(#"DFB12081") != 0)
	{
		return 1;
	}
	else if(GetDvarInt(#"D5D7999B") != 0)
	{
		return 0;
	}
#/
	if(IsDefined(self.enemy))
	{
		return 1;
	}

	if(self.lookaheaddist <= 90)
	{
		return 0;
	}

	angles = VectorToAngles(self.lookaheaddir);
	yaw_desired = absangleclamp180(angles[1]);
	yaw = absangleclamp180(self.angles[1]);
	if(Abs(yaw_desired - yaw) >= 8)
	{
		return 0;
	}
}