/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_rambo.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 2:20:35 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.ramboanims))
	{
		return;
	}

	if(!isdefined(level.subclass_spawn_functions))
	{
		level.subclass_spawn_functions = [];
	}

	level.subclass_spawn_functions["militia"] = ::enable_militia_behavior;
	anim.ramboanims = spawnstruct();
	level.ramboanims.coverleft90 = animscripts/utility::array(%favela_chaotic_cornerl_hop90,%favela_chaotic_cornerl_high90,%favela_chaotic_cornerl_mid90);
	level.ramboanims.coverleft45 = animscripts/utility::array(%favela_chaotic_cornerl_high45,%favela_chaotic_cornerl_mid45);
	level.ramboanims.coverleftgrenade = %favela_chaotic_cornerl_grenade;
	level.ramboanims.coverright90 = animscripts/utility::array(%favela_chaotic_cornerr_med90,%favela_chaotic_cornerr_low90,%favela_chaotic_cornerr_high90);
	level.ramboanims.coverright45 = animscripts/utility::array(%favela_chaotic_cornerr_med45,%favela_chaotic_cornerr_low45,%favela_chaotic_cornerr_high45);
	level.ramboanims.coverrightgrenade = %favela_chaotic_cornerr_grenade;
	level.ramboanims.coverstand = animscripts/utility::array(%favela_chaotic_standcover_firea,%favela_chaotic_standcover_fireb,%favela_chaotic_standcover_firec);
	level.ramboanims.coverstandfail = animscripts/utility::array(%favela_chaotic_standcover_gunjama,%favela_chaotic_standcover_gunjamb);
	level.ramboanims.coverstandgrenade = animscripts/utility::array(%favela_chaotic_standcover_grenadefirea);
	level.ramboanims.covercrouch = animscripts/utility::array(%favela_chaotic_crouchcover_firea,%favela_chaotic_crouchcover_fireb,%favela_chaotic_crouchcover_firec);
	level.ramboanims.covercrouchfail = animscripts/utility::array(%favela_chaotic_crouchcover_gunjama,%favela_chaotic_crouchcover_gunjamb);
	level.ramboanims.covercrouchgrenade = animscripts/utility::array(%favela_chaotic_crouchcover_grenadefirea);
	setrambogrenadeoffsets();
}

//Function Number: 2
setrambogrenadeoffsets()
{
	animscripts/combat_utility::func_238B(%favela_chaotic_cornerr_grenade,(52.4535,10.107,64.2898));
	animscripts/combat_utility::func_238B(%favela_chaotic_cornerl_grenade,(19.1753,-18.9954,49.3355));
	animscripts/combat_utility::func_238B(%favela_chaotic_standcover_grenadefirea,(6.66898,-0.135193,72.117));
	animscripts/combat_utility::func_238B(%favela_chaotic_crouchcover_grenadefirea,(4.53614,-10.4574,59.7186));
}

//Function Number: 3
enable_militia_behavior()
{
	if(self.type == "dog")
	{
		return;
	}

	self.neverenablecqb = 1;
	self.maxfaceenemydist = 256;
	if(animscripts/combat_utility::func_23BD())
	{
		return;
	}

	if(animscripts/utility::func_CEA(self.weapon))
	{
		return;
	}

	self.disable_blindfire = undefined;
	self.favor_blindfire = 1;
	self.rambochance = 0.9;
	self.ramboaccuracymult = 1;
	self.baseaccuracy = 0.75;
	self.neversprintforvariation = undefined;
}

//Function Number: 4
disable_militia_behavior()
{
	self.favor_blindfire = undefined;
	self.rambochance = undefined;
	self.neverenablecqb = 0;
	self.maxfaceenemydist = 512;
	self.ramboaccuracymult = undefined;
}