/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\traverse\shared.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 1 ms
 * Timestamp: 10/28/2023 12:10:22 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;

//Function Number: 1
init_traverse()
{
	point = getent(self.target,"targetname");
	if(IsDefined(point))
	{
		self.traverse_height = point.origin[2];
		point delete();
	}
	else
	{
		point = getstruct(self.target,"targetname");
		if(IsDefined(point))
		{
			self.traverse_height = point.origin[2];
		}
	}
}

//Function Number: 2
teleportthread(verticaloffset)
{
	self endon("killanimscript");
	self notify("endTeleportThread");
	self endon("endTeleportThread");
	reps = 5;
	offset = (0,0,verticaloffset / reps);
	for(i = 0;i < reps;i++)
	{
		self teleport(self.origin + offset);
		wait(0.05);
	}
}

//Function Number: 3
teleportthreadex(verticaloffset,delay,frames)
{
	self endon("killanimscript");
	self notify("endTeleportThread");
	self endon("endTeleportThread");
	if(verticaloffset == 0)
	{
		return;
	}

	wait(delay);
	amount = verticaloffset / frames;
	if(amount > 10)
	{
		amount = 10;
	}
	else if(amount < -10)
	{
		amount = -10;
	}

	offset = (0,0,amount);
	for(i = 0;i < frames;i++)
	{
		self teleport(self.origin + offset);
		wait(0.05);
	}
}

//Function Number: 4
dog_wall_and_window_hop(traversename,height)
{
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	startnode = self getnegotiationstartnode();
/#
	assert(IsDefined(startnode));
#/
	self orientmode("face angle",startnode.angles[1]);
	if(IsDefined(startnode.traverse_height))
	{
		realheight = startnode.traverse_height - startnode.origin[2];
		self thread teleportthread(realheight - height);
	}
	else if(height != 36)
	{
		self thread teleportthreadex(height - 36,0.2,7);
	}

	debug_anim_print("traverse::dog_wall_and_window_hop() - Setting " + traversename);
	self setanimstate(traversename);
	maps/mp/animscripts/shared::donotetracksfortime(1,"done");
	debug_anim_print("traverse::dog_wall_and_window_hop() - " + traversename);
	self.traversecomplete = 1;
}

//Function Number: 5
dog_jump_down(height,frames,time)
{
	self endon("killanimscript");
	self traversemode("noclip");
	if(!(IsDefined(time)))
	{
		time = 0.3;
	}

	startnode = self getnegotiationstartnode();
/#
	assert(IsDefined(startnode));
#/
	self orientmode("face angle",startnode.angles[1]);
	if(IsDefined(startnode.traverse_height))
	{
		realheight = startnode.traverse_height - startnode.origin[2];
		self thread teleportthread(realheight - height);
	}
	else if(height != 40)
	{
		self thread teleportthreadex(height - 40,0.1,frames);
	}

	debug_anim_print("traverse::dog_jump_down() - Setting traverse_jump_down_40");
	self setanimstate("traverse_jump_down_40");
	maps/mp/animscripts/shared::donotetracksfortime(time,"done");
	debug_anim_print("traverse::dog_jump_down() - traverse_jump_down_40 ");
	self traversemode("gravity");
	self.traversecomplete = 1;
}

//Function Number: 6
dog_jump_down_far(height,frames,time)
{
	self endon("killanimscript");
	self traversemode("noclip");
	if(!(IsDefined(time)))
	{
		time = 0.3;
	}

	startnode = self getnegotiationstartnode();
/#
	assert(IsDefined(startnode));
#/
	self orientmode("face angle",startnode.angles[1]);
	if(IsDefined(startnode.traverse_height))
	{
		realheight = startnode.traverse_height - startnode.origin[2];
		self thread teleportthread(realheight - height);
	}
	else if(height != 80)
	{
		self thread teleportthreadex(80 - height,0.1,frames);
	}

	debug_anim_print("traverse::dog_jump_down() - Setting traverse_jump_down_80");
	self setanimstate("traverse_jump_down_80");
	maps/mp/animscripts/shared::donotetracksfortime(time,"done");
	debug_anim_print("traverse::dog_jump_down() - traverse_jump_down_80 ");
	self traversemode("gravity");
	self.traversecomplete = 1;
}

//Function Number: 7
dog_jump_up(height,frames)
{
	self endon("killanimscript");
	self traversemode("noclip");
	startnode = self getnegotiationstartnode();
/#
	assert(IsDefined(startnode));
#/
	self orientmode("face angle",startnode.angles[1]);
	if(IsDefined(startnode.traverse_height))
	{
		realheight = startnode.traverse_height - startnode.origin[2];
		self thread teleportthread(realheight - height);
	}
	else if(height != 40)
	{
		self thread teleportthreadex(height - 40,0.2,frames);
	}

	debug_anim_print("traverse::dog_jump_up() - Setting traverse_jump_up_40");
	self setanimstate("traverse_jump_up_40");
	maps/mp/animscripts/shared::donotetracksfortime(0.5,"done");
	debug_anim_print("traverse::dog_jump_up() - traverse_jump_up_40  ");
	self traversemode("gravity");
	self.traversecomplete = 1;
}

//Function Number: 8
dog_jump_up_high(height,frames)
{
/#
	assert(self.type == "dog","Only dogs can do this traverse currently.");
#/
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	startnode = self getnegotiationstartnode();
/#
	assert(IsDefined(startnode));
#/
	self orientmode("face angle",startnode.angles[1]);
	if(IsDefined(startnode.traverse_height))
	{
		realheight = startnode.traverse_height - startnode.origin[2];
		self thread teleportthreadex(height - 80,0.2,frames);
	}
	else if(height != 80)
	{
		self thread teleportthreadex(height - 80,0.2,frames);
	}

	debug_anim_print("traverse::dog_jump_up_80() - Setting traverse_jump_up_80");
	self setanimstate("traverse_jump_up_80");
	maps/mp/animscripts/shared::donotetracksfortime(0.6,"done");
	debug_anim_print("traverse::dog_jump_up_80() - traverse_jump_up_80 ");
	self traversemode("gravity");
	self.traversecomplete = 1;
}