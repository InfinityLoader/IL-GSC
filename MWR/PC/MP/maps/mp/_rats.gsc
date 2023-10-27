/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_rats.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 61 ms
 * Timestamp: 10/27/2023 2:38:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		return;
	}

	level._effect["animated_rat_death"] = loadfx("vfx/blood/dlc_blood_splash_sm");
	var_00 = getentarray("animated_rat","targetname");
	common_scripts\utility::array_thread(var_00,::init_rats);
}

//Function Number: 2
init_rats()
{
	if(!isdefined(self.script_noteworthy))
	{
		return;
	}

	switch(self.script_noteworthy)
	{
		case "frantic":
			break;

		case "run":
			break;

		default:
			break;
	}
}

//Function Number: 3
run_rat(param_00,param_01)
{
	precachempanim(param_00);
	foreach(var_03 in param_01)
	{
		precachempanim(var_03);
	}

	self setcandamage(1);
	self.health = 1;
	self scriptmodelplayanimdeltamotion(param_00);
	self waittill("damage",var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
	playfx(common_scripts\utility::getfx("animated_rat_death"),self.origin,(0,0,1));
	self scriptmodelplayanimdeltamotion(common_scripts\utility::random(param_01));
}