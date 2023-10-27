/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\dog_stop.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 6
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 3:04:07 AM
*******************************************************************/

#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;

//Function Number: 1
main()
{
	debug_anim_print("dog_stop::main()");
	self endon("killanimscript");
	self setaimanimweights(0,0);
	self thread lookattarget("attackIdle");
	while(1)
	{
		if(shouldattackidle())
		{
			self randomattackidle();
			maps/mp/animscripts/shared::donotetracks("done");
		}
		else
		{
			self set_orient_mode("face current");
			debug_anim_print("dog_stop::main() - Setting stop_idle");
			self notify("stop tracking");
			self setaimanimweights(0,0);
			self setanimstate("stop_idle");
			maps/mp/animscripts/shared::donotetracks("done");
			self thread lookattarget("attackIdle");
		}

		debug_anim_print("dog_stop::main() - stop idle loop notify done.");
	}
}

//Function Number: 2
isfacingenemy(tolerancecosangle)
{
/#
	assert(IsDefined(self.enemy));
#/
	vectoenemy = self.enemy.origin - self.origin;
	disttoenemy = length(vectoenemy);
	if(disttoenemy < 1)
	{
		return 1;
	}

	forward = AnglesToForward(self.angles);
	val1 = forward[0] * vectoenemy[0] + forward[1] * vectoenemy[1];
	val2 = forward[0] * vectoenemy[0] + forward[1] * vectoenemy[1] / disttoenemy;
	return forward[0] * vectoenemy[0] + forward[1] * vectoenemy[1] / disttoenemy > tolerancecosangle;
}

//Function Number: 3
randomattackidle()
{
	if(isfacingenemy(-0.5))
	{
		self set_orient_mode("face current");
	}
	else
	{
		self set_orient_mode("face enemy");
	}

	if(should_growl())
	{
		debug_anim_print("dog_stop::main() - Setting stop_attackidle_growl");
		self setanimstate("stop_attackidle_growl");
		return;
	}

	idlechance = 33;
	barkchance = 66;
	if(IsDefined(self.mode))
	{
		if(self.mode == "growl")
		{
			idlechance = 15;
			barkchance = 30;
		}
		else if(self.mode == "bark")
		{
			idlechance = 15;
			barkchance = 85;
		}
	}

	rand = randomint(100);
	if(rand < idlechance)
	{
		debug_anim_print("dog_stop::main() - Setting stop_attackidle");
		self setanimstate("stop_attackidle");
	}
	else if(rand < barkchance)
	{
		debug_anim_print("dog_stop::main() - Setting stop_attackidle_bark ");
		self setanimstate("stop_attackidle_bark");
	}
	else
	{
		debug_anim_print("dog_stop::main() - Setting stop_attackidle_growl ");
		self setanimstate("stop_attackidle_growl");
	}
}

//Function Number: 4
shouldattackidle()
{
	return IsDefined(self.enemy) && isalive(self.enemy) && distancesquared(self.origin,self.enemy.origin) < 1000000;
}

//Function Number: 5
should_growl()
{
	if(IsDefined(self.script_growl))
	{
		return 1;
	}

	if(!(isalive(self.enemy)))
	{
		return 1;
	}

	return !self cansee(self.enemy);
}

//Function Number: 6
lookattarget(lookposeset)
{
	self endon("killanimscript");
	self endon("stop tracking");
	debug_anim_print("dog_stop::lookAtTarget() - Starting look at " + lookposeset);
	self.rightaimlimit = 90;
	self.leftaimlimit = -90;
	self.upaimlimit = 45;
	self.downaimlimit = -45;
	self maps/mp/animscripts/shared::setanimaimweight(1,0.2);
	self maps/mp/animscripts/shared::trackloop();
}