/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_timer.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:11:56 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_utility;

//Function Number: 1
init()
{
	precacheshader("zombie_stopwatchneedle");
	precacheshader("zombie_stopwatch");
	precacheshader("zombie_stopwatch_glass");
	if(!(IsDefined(level.stopwatch_length_width)))
	{
		level.stopwatch_length_width = 96;
	}
}

//Function Number: 2
start_timer(time,stop_notify)
{
	self notify("stop_prev_timer");
	self endon("stop_prev_timer");
	if(!(IsDefined(self.stopwatch_elem)))
	{
		self.stopwatch_elem = newclienthudelem(self);
		self.stopwatch_elem.horzalign = "left";
		self.stopwatch_elem.vertalign = "top";
		self.stopwatch_elem.alignx = "left";
		self.stopwatch_elem.aligny = "top";
		self.stopwatch_elem.x = 10;
		self.stopwatch_elem.alpha = 0;
		self.stopwatch_elem.sort = 2;
		self.stopwatch_elem_glass = newclienthudelem(self);
		self.stopwatch_elem_glass.horzalign = "left";
		self.stopwatch_elem_glass.vertalign = "top";
		self.stopwatch_elem_glass.alignx = "left";
		self.stopwatch_elem_glass.aligny = "top";
		self.stopwatch_elem_glass.x = 10;
		self.stopwatch_elem_glass.alpha = 0;
		self.stopwatch_elem_glass.sort = 3;
		self.stopwatch_elem_glass setshader("zombie_stopwatch_glass",level.stopwatch_length_width,level.stopwatch_length_width);
	}

	self thread update_hud_position();
	if(IsDefined(stop_notify))
	{
		self thread wait_for_stop_notify(stop_notify);
	}

	if(time > 60)
	{
		time = 0;
	}

	self.stopwatch_elem setclock(time,60,"zombie_stopwatch",level.stopwatch_length_width,level.stopwatch_length_width);
	self.stopwatch_elem.alpha = 1;
	self.stopwatch_elem_glass.alpha = 1;
	wait(time);
	self notify("countdown_finished");
	wait(1);
	self.stopwatch_elem.alpha = 0;
	self.stopwatch_elem_glass.alpha = 0;
}

//Function Number: 3
wait_for_stop_notify(stop_notify)
{
	self endon("stop_prev_timer");
	self endon("countdown_finished");
	self waittill(stop_notify);
	self.stopwatch_elem.alpha = 0;
	self.stopwatch_elem_glass.alpha = 0;
}

//Function Number: 4
update_hud_position()
{
	self endon("disconnect");
	self endon("stop_prev_timer");
	self endon("countdown_finished");
	while(1)
	{
		self.stopwatch_elem.y = 20;
		self.stopwatch_elem_glass.y = 20;
		wait(0.05);
	}
}