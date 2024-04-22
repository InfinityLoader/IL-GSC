/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_dev.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 173 ms
 * Timestamp: 4/22/2024 2:09:17 AM
*******************************************************************/

//Function Number: 1
init()
{
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread updatereflectionprobe();
	}
}

//Function Number: 3
updatereflectionprobe()
{
}

//Function Number: 4
reflectionprobebuttons()
{
}

//Function Number: 5
gotonextspawn()
{
}

//Function Number: 6
gotoprevspawn()
{
}

//Function Number: 7
gotonextstartspawn()
{
}

//Function Number: 8
gotoprevstartspawn()
{
}

//Function Number: 9
monitortagnoteworthyevent()
{
}