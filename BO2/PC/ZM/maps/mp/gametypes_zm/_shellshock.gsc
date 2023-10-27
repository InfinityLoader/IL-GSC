/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\_shellshock.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 95 ms
 * Timestamp: 10/27/2023 3:02:43 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;

//Function Number: 1
init()
{
	precacheshellshock("frag_grenade_mp");
	precacheshellshock("damage_mp");
	precacherumble("artillery_rumble");
	precacherumble("grenade_rumble");
}

//Function Number: 2
shellshockondamage(cause,damage)
{
	if(cause == "MOD_EXPLOSIVE" || cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH" || cause == "MOD_PROJECTILE" || cause == "MOD_PROJECTILE_SPLASH")
	{
		time = 0;
		if(damage >= 90)
		{
			time = 4;
		}
		else if(damage >= 50)
		{
			time = 3;
		}
		else if(damage >= 25)
		{
			time = 2;
		}
		else if(damage > 10)
		{
			time = 2;
		}

		if(time)
		{
			if(self mayapplyscreeneffect())
			{
				self shellshock("frag_grenade_mp",0.5);
			}
		}
	}
}

//Function Number: 3
endondeath()
{
	self waittill("death");
	waittillframeend;
	self notify("end_explode");
}

//Function Number: 4
endontimer(timer)
{
	self endon("disconnect");
	wait(timer);
	self notify("end_on_timer");
}

//Function Number: 5
rcbomb_earthquake(position)
{
	playrumbleonposition("grenade_rumble",position);
	earthquake(0.5,0.5,self.origin,512);
}