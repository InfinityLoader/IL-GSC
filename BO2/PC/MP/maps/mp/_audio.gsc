/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_audio.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 1 ms
 * Timestamp: 10/28/2023 12:10:50 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;

//Function Number: 1
init()
{
}

//Function Number: 2
wait_until_first_player()
{
	players = get_players();
	if(!(IsDefined(players[0])))
	{
		level waittill("first_player_ready");
	}

	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		players[i] thread monitor_player_sprint();
	}
}

//Function Number: 3
stand_think(trig)
{
	killtext = "kill_stand_think" + trig getentitynumber();
	self endon("disconnect");
	self endon("death");
	self endon(killtext);
	while(1)
	{
		if(self.player_is_moving)
		{
			trig playsound(trig.script_label);
		}

		wait(1);
	}
}

//Function Number: 4
monitor_player_sprint()
{
	self endon("disconnect");
	self thread monitor_player_movement();
	self._is_sprinting = 0;
	while(1)
	{
		self waittill("sprint_begin");
		self._is_sprinting = 1;
		self waittill("sprint_end");
		self._is_sprinting = 0;
	}
}

//Function Number: 5
monitor_player_movement()
{
	self endon("disconnect");
	while(1)
	{
		org_1 = self.origin;
		wait(1);
		org_2 = self.origin;
		distancemoved = distancesquared(org_1,org_2);
		if(distancemoved > 4096)
		{
			self.player_is_moving = 1;
			continue;
		}

		self.player_is_moving = 0;
	}
}

//Function Number: 6
thread_enter_exit_sound(trig)
{
	self endon("death");
	self endon("disconnect");
	trig.touchingplayers[self getentitynumber()] = 1;
	if(IsDefined(trig.script_sound) && trig.script_activated && self._is_sprinting)
	{
		self playsound(trig.script_sound);
	}

	self thread stand_think(trig);
	while(self istouching(trig))
	{
		wait(0.1);
	}

	self notify("kill_stand_think" + trig getentitynumber());
	self playsound(trig.script_noteworthy);
	trig.touchingplayers[self getentitynumber()] = 0;
}

//Function Number: 7
thread_step_trigger()
{
	if(!(IsDefined(self.script_activated)))
	{
		self.script_activated = 1;
	}

	if(!(IsDefined(self.touchingplayers)))
	{
		self.touchingplayers = [];
		for(i = 0;i < 4;i++)
		{
			self.touchingplayers[i] = 0;
		}
	}

	while(1)
	{
		self waittill("trigger",who);
		if(self.touchingplayers[who getentitynumber()] == 0)
		{
			who thread thread_enter_exit_sound(self);
		}
	}
}

//Function Number: 8
disable_bump_trigger(triggername)
{
	triggers = getentarray("audio_bump_trigger","targetname");
	if(IsDefined(triggers))
	{
		for(i = 0;i < triggers.size;i++)
		{
			if(IsDefined(triggers[i].script_label) && triggers[i].script_label == triggername)
			{
				triggers[i].script_activated = 0;
			}
		}
	}
}

//Function Number: 9
get_player_index_number(player)
{
	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		if(players[i] == player)
		{
			return i;
		}
	}

	return 1;
}