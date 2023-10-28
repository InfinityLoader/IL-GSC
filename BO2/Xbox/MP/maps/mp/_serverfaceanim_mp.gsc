/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_serverfaceanim_mp.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 4
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:13:51 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;

//Function Number: 1
init()
{
	for(;;)
	{
		level waittill("connecting",player);
		player thread onplayerspawned();
	}
}

//Function Number: 2
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self thread init_serverfaceanim();
	}
}

//Function Number: 3
init_serverfaceanim()
{
	self.do_face_anims = 1;
	if(!(IsDefined(level.face_event_handler)))
	{
		level.face_event_handler = spawnstruct();
		level.face_event_handler.events = [];
		level.face_event_handler.events["death"] = "face_death";
		level.face_event_handler.events["grenade danger"] = "face_alert";
		level.face_event_handler.events["bulletwhizby"] = "face_alert";
		level.face_event_handler.events["projectile_impact"] = "face_alert";
		level.face_event_handler.events["explode"] = "face_alert";
		level.face_event_handler.events["alert"] = "face_alert";
		level.face_event_handler.events["shoot"] = "face_shoot_single";
		level.face_event_handler.events["melee"] = "face_melee";
		level.face_event_handler.events["damage"] = "face_pain";
		level thread wait_for_face_event();
	}
}

//Function Number: 4
wait_for_face_event()
{
	while(1)
	{
		level waittill("face",face_notify,ent);
		if(IsDefined(ent) && IsDefined(ent.do_face_anims) && ent.do_face_anims)
		{
			if(IsDefined(level.face_event_handler.events[face_notify]))
			{
				ent sendfaceevent(level.face_event_handler.events[face_notify]);
			}
		}
	}
}