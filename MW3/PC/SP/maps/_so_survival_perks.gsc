/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_so_survival_perks.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 349 ms
 * Timestamp: 10/27/2023 2:20:59 AM
*******************************************************************/

//Function Number: 1
perks_preload()
{
}

//Function Number: 2
perks_init()
{
}

//Function Number: 3
give_perk(param_00)
{
	if(self hasperk(param_00,1))
	{
		return 1;
	}

	self clearperks();
	switch(param_00)
	{
		case "specialty_stalker":
			thread give_perk_stalker();
			break;

		case "specialty_longersprint":
			thread give_perk_longersprint();
			break;

		case "specialty_fastreload":
			thread give_perk_fastreload();
			break;

		case "specialty_quickdraw":
			thread give_perk_quickdraw();
			break;

		case "specialty_detectexplosive":
			thread give_perk_detectexplosive();
			break;

		case "specialty_bulletaccuracy":
			thread give_perk_bulletaccuracy();
			break;

		default:
			thread give_perk_dummy();
			break;
	}

	self notify("give_perk",param_00);
	return 1;
}

//Function Number: 4
take_perk(param_00)
{
	if(!self hasperk(param_00,1))
	{
		return;
	}

	switch(param_00)
	{
		case "specialty_stalker":
			thread take_perk_stalker();
			break;

		case "specialty_longersprint":
			thread take_perk_longersprint();
			break;

		case "specialty_fastreload":
			thread take_perk_fastreload();
			break;

		case "specialty_quickdraw":
			thread take_perk_quickdraw();
			break;

		case "specialty_detectexplosive":
			thread take_perk_detectexplosive();
			break;

		case "specialty_bulletaccuracy":
			thread take_perk_bulletaccuracy();
			break;

		default:
			thread take_perk_dummy();
			break;
	}

	self notify("take_perk",param_00);
}

//Function Number: 5
give_perk_dummy()
{
}

//Function Number: 6
take_perk_dummy()
{
}

//Function Number: 7
give_perk_longersprint()
{
	self setperk("specialty_longersprint",1,0);
}

//Function Number: 8
take_perk_longersprint()
{
	self unsetperk("specialty_longersprint",1);
}

//Function Number: 9
give_perk_fastreload()
{
	self setperk("specialty_fastreload",1,0);
}

//Function Number: 10
take_perk_fastreload()
{
	self unsetperk("specialty_fastreload",1);
}

//Function Number: 11
give_perk_quickdraw()
{
	self setperk("specialty_quickdraw",1,0);
}

//Function Number: 12
take_perk_quickdraw()
{
	self unsetperk("specialty_quickdraw",1);
}

//Function Number: 13
give_perk_detectexplosive()
{
	self setperk("specialty_detectexplosive",1,0);
}

//Function Number: 14
take_perk_detectexplosive()
{
	self unsetperk("specialty_detectexplosive",1);
}

//Function Number: 15
give_perk_bulletaccuracy()
{
	self setperk("specialty_bulletaccuracy",1,0);
}

//Function Number: 16
take_perk_bulletaccuracy()
{
	self unsetperk("specialty_bulletaccuracy",1);
}

//Function Number: 17
give_perk_stalker()
{
	self setperk("specialty_stalker",1,0);
}

//Function Number: 18
take_perk_stalker()
{
	self unsetperk("specialty_stalker",1);
}

//Function Number: 19
perk_hud()
{
	common_scripts\utility::flag_init("HUD_giving_perk");
	common_scripts\utility::flag_init("HUD_taking_perk");
	thread update_on_give_perk();
	thread update_on_take_perk();
}

//Function Number: 20
update_on_give_perk()
{
	self endon("death");
	for(;;)
	{
		self waittill("give_perk",var_00);
		common_scripts\utility::flag_set("HUD_giving_perk");
		while(common_scripts\utility::flag("HUD_taking_perk"))
		{
			wait 0.05;
		}

		wait 1;
		common_scripts\utility::flag_clear("HUD_giving_perk");
	}
}

//Function Number: 21
update_on_take_perk()
{
	self endon("death");
	for(;;)
	{
		self waittill("take_perk",var_00);
		common_scripts\utility::flag_set("HUD_taking_perk");
		while(common_scripts\utility::flag("HUD_giving_perk"))
		{
			wait 0.05;
		}

		wait 1;
		common_scripts\utility::flag_clear("HUD_taking_perk");
	}
}