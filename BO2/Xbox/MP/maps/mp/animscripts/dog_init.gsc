/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\dog_init.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:13:29 AM
*******************************************************************/

#include maps/mp/animscripts/dog_move;
#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;

//Function Number: 1
main()
{
	level.dog_debug_orient = 0;
	level.dog_debug_anims = 0;
	level.dog_debug_anims_ent = 0;
	level.dog_debug_turns = 0;
	debug_anim_print("dog_init::main() ");
	maps/mp/animscripts/dog_move::setup_sound_variables();
	anim_get_dvar_int("debug_dog_sound","0");
	anim_get_dvar_int("debug_dog_notetracks","0");
	anim_get_dvar_int("dog_force_walk",0);
	anim_get_dvar_int("dog_force_run",0);
	self.ignoresuppression = 1;
	self.chatinitialized = 0;
	self.nododgemove = 1;
	level.dogattackplayerdist = 50;
	level.dogattackplayercloserangedist = 50;
	level.dogrunturnspeed = 20;
	level.dogrunpainspeed = 20;
	self.meleeattackdist = 0;
	self thread setmeleeattackdist();
	self.a = spawnstruct();
	self.a.pose = "stand";
	self.a.nextstandinghitdying = 0;
	self.a.movement = "run";
	set_anim_playback_rate();
	self.suppressionthreshold = 1;
	self.disablearrivals = 0;
	level.dogstoppingdistsq = 3416.82;
	self.stopanimdistsq = level.dogstoppingdistsq;
	self.pathenemyfightdist = 512;
	self settalktospecies("dog");
	level.lastdogmeleeplayertime = 0;
	level.dogmeleeplayercounter = 0;
	if(!(IsDefined(level.dog_hits_before_kill)))
	{
		level.dog_hits_before_kill = 1;
	}
}

//Function Number: 2
set_anim_playback_rate()
{
	self.animplaybackrate = 0.9 + randomfloat(0.2);
	self.moveplaybackrate = 1;
}

//Function Number: 3
setmeleeattackdist()
{
	self endon("death");
	while(1)
	{
		if(IsDefined(self.enemy))
		{
			if(isplayer(self.enemy))
			{
				stance = self.enemy getstance();
				if(stance == "prone")
				{
					self.meleeattackdist = level.dogattackplayercloserangedist;
					continue;
				}

				self.meleeattackdist = level.dogattackplayerdist;
			}
			else
			{
				self.meleeattackdist = level.dogattackplayerdist;
			}
		}

		wait(1);
	}
}