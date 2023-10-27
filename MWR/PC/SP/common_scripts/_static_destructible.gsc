/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_static_destructible.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 2:45:29 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = getentarray("static_destructible","script_noteworthy");
	common_scripts\utility::array_thread(var_00,::static_destructible_think);
}

//Function Number: 2
static_destructible_think()
{
	self setcandamage(1);
	self.destroyed_fx_id = loadfx(self.script_parameters);
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 linkto(self);
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05);
		if(var_05 != "MOD_MELEE" && var_05 != "MOD_IMPACT")
		{
			playfxontag(self.destroyed_fx_id,var_00,"tag_origin");
			var_06 = getent(self.target,"targetname");
			var_06 delete();
			self delete();
			wait(15);
			var_00 delete();
			break;
		}

		wait(0.05);
	}
}