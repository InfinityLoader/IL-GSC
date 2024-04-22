/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_levity_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 56 ms
 * Timestamp: 4/22/2024 2:17:55 AM
*******************************************************************/

//Function Number: 1
main()
{
	level thread setup_audio();
	level.aud_piston_ent = [];
	level.aud_piston_ent[1] = spawn("script_origin",(249,-2260,1418));
	level.aud_piston_ent[2] = spawn("script_origin",(249,-1996,1418));
	level.aud_piston_ent[3] = spawn("script_origin",(-225,-1996,1418));
	level.aud_piston_ent[4] = spawn("script_origin",(-225,-2260,1418));
}

//Function Number: 2
setup_audio()
{
}

//Function Number: 3
event_aud(param_00)
{
	playsoundatpos((0,-2225,1311),"mp_levity_hanger_door_verb");
	playsoundatpos((0,-2225,1311),"mp_levity_hanger_door");
}