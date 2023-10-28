/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\zm_combat.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:11:28 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;
#include maps/mp/animscripts/zm_melee;
#include maps/mp/animscripts/zm_utility;

//Function Number: 1
main()
{
	self endon("killanimscript");
	self endon("melee");
	maps/mp/animscripts/zm_utility::initialize("zombie_combat");
	self animmode("zonly_physics",0);
	if(IsDefined(self.combat_animmode))
	{
		self [[ self.combat_animmode ]]();
	}

	self orientmode("face angle",self.angles[1]);
	for(;;)
	{
		if(trymelee())
		{
			return;
		}

		exposedwait();
	}
}

//Function Number: 2
exposedwait()
{
	if(!IsDefined(self.can_always_see) && !IsDefined(self.enemy) || !self cansee(self.enemy))
	{
		self endon("enemy");
		wait(0.2 + randomfloat(0.1));
	}
	else if(!(IsDefined(self.enemy)))
	{
		self endon("enemy");
		wait(0.2 + randomfloat(0.1));
	}
	else
	{
		wait(0.05);
	}
}

//Function Number: 3
trymelee()
{
	if(IsDefined(self.cant_melee) && self.cant_melee)
	{
		return 0;
	}

	if(!(IsDefined(self.enemy)))
	{
		return 0;
	}

	if(distancesquared(self.origin,self.enemy.origin) > 262144)
	{
		return 0;
	}

	canmelee = maps/mp/animscripts/zm_melee::canmeleedesperate();
	if(!(canmelee))
	{
		return 0;
	}

	self thread maps/mp/animscripts/zm_melee::meleecombat();
	return 1;
}