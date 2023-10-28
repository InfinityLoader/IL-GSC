/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\traverse\zm_shared.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:11:25 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/animscripts/utility;
#include maps/mp/animscripts/zm_run;
#include maps/mp/animscripts/zm_shared;

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
handletraversealignment()
{
	self traversemode("nogravity");
	self traversemode("noclip");
	if(IsDefined(self.traverseheight) && IsDefined(self.traversestartnode.traverse_height))
	{
		currentheight = self.traversestartnode.traverse_height - self.traversestartz;
		self thread teleportthread(currentheight - self.traverseheight);
	}
}

//Function Number: 5
dosimpletraverse(traversealias,no_powerups,traversestate)
{
	if(!(IsDefined(traversestate)))
	{
		traversestate = "zm_traverse";
	}

	if(IsDefined(level.ignore_traverse))
	{
		if(self [[ level.ignore_traverse ]]())
		{
			return;
		}
	}

	if(IsDefined(level.zm_traversal_override))
	{
		traversealias = self [[ level.zm_traversal_override ]](traversealias);
	}

	if(!(self.has_legs))
	{
		traversestate = traversestate + "_crawl";
		traversealias = traversealias + "_crawl";
	}

	self dotraverse(traversestate,traversealias,no_powerups);
}

//Function Number: 6
dotraverse(traversestate,traversealias,no_powerups)
{
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	old_powerups = 0;
	if(IsDefined(no_powerups) && no_powerups)
	{
		old_powerups = self.no_powerups;
		self.no_powerups = 1;
	}

	self.is_traversing = 1;
	self notify("zombie_start_traverse");
	self.traversestartnode = self getnegotiationstartnode();
/#
	assert(IsDefined(self.traversestartnode));
#/
	self orientmode("face angle",self.traversestartnode.angles[1]);
	self.traversestartz = self.origin[2];
	if(IsDefined(self.pre_traverse))
	{
		self [[ self.pre_traverse ]]();
	}

	self setanimstatefromasd(traversestate,traversealias);
	self maps/mp/animscripts/zm_shared::donotetracks("traverse_anim");
	self traversemode("gravity");
	self.a.nodeath = 0;
	if(IsDefined(self.post_traverse))
	{
		self [[ self.post_traverse ]]();
	}

	self maps/mp/animscripts/zm_run::needsupdate();
	if(!(self.isdog))
	{
		self maps/mp/animscripts/zm_run::moverun();
	}

	self.is_traversing = 0;
	self notify("zombie_end_traverse");
	if(IsDefined(no_powerups) && no_powerups)
	{
		self.no_powerups = old_powerups;
	}
}