/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_smokegrenade.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 15 ms
 * Timestamp: 10/27/2023 3:01:35 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/killstreaks/_airsupport;
#include maps/mp/killstreaks/_dogs;

//Function Number: 1
init()
{
	level.willypetedamageradius = 300;
	level.willypetedamageheight = 128;
	level.sound_smoke_start = "wpn_smoke_hiss_start";
	level.sound_smoke_loop = "wpn_smoke_hiss_lp";
	level.sound_smoke_stop = "wpn_smoke_hiss_end";
	level.smokesoundduration = 8;
	level.fx_smokegrenade_single = "smoke_center_mp";
	precacheitem(level.fx_smokegrenade_single);
}

//Function Number: 2
watchsmokegrenadedetonation(owner)
{
	owner addweaponstat("willy_pete_mp","used",1);
	self waittill("explode",position,surface);
	if(!IsDefined(level.water_duds) || level.water_duds == 1)
	{
		if(IsDefined(surface) && surface == "water")
		{
			return;
		}
	}

	onefoot = VectorScale((0,0,1));
	startpos = position + onefoot;
	ent = spawntimedfx(level.fx_smokegrenade_single,position,(0,0,1),12);
	ent thread blocksight();
	if(IsDefined(owner))
	{
		owner.smokegrenadetime = GetTime();
		owner.smokegrenadeposition = position;
	}

	thread playsmokesound(position,level.smokesoundduration,level.sound_smoke_start,level.sound_smoke_stop,level.sound_smoke_loop);
	damageeffectarea(owner,startpos,level.willypetedamageradius,level.willypetedamageheight,undefined);
}

//Function Number: 3
damageeffectarea(owner,position,radius,height,killcament)
{
	effectarea = spawn("trigger_radius",position,0,radius,height);
	owner thread maps/mp/killstreaks/_dogs::flash_dogs(effectarea);
	effectarea delete();
}

//Function Number: 4
blocksight()
{
	self endon("death");
	radius = 64;
	fxblocksight(self,radius);
	for(;;)
	{
		wait(0.75);
		radius = clamp(radius * 1.5,10,150);
		fxblocksight(self,radius);
	}
}