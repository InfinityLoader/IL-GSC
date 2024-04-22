/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_urban_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 55 ms
 * Timestamp: 4/22/2024 2:18:41 AM
*******************************************************************/

//Function Number: 1
main()
{
	level thread setup_audio();
}

//Function Number: 2
setup_audio()
{
	ambientplay("amb_ext_urban_front");
}

//Function Number: 3
aud_lockdown_siren()
{
	playsoundatpos((-142,6,2550),"lockdown_siren");
	wait(3);
	playsoundatpos((-142,6,2550),"lockdown_siren");
	wait(3);
	playsoundatpos((-142,6,2550),"lockdown_siren");
}