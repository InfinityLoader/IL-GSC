/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_gun.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 67 ms
 * Timestamp: 10/27/2023 2:37:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
	setup_bot_gun();
}

//Function Number: 2
setup_callbacks()
{
	level.bot_funcs["gametype_think"] = ::bot_gun_think;
}

//Function Number: 3
setup_bot_gun()
{
}

//Function Number: 4
bot_gun_pick_personality_from_weapon(param_00,param_01)
{
	if(isdefined(param_00))
	{
		var_02 = level.bot_weap_personality[param_00];
		if(isdefined(var_02))
		{
			var_03 = strtok(var_02,"| ");
			if(maps\mp\_utility::getweaponclass(param_00) == "weapon_pistol")
			{
				var_03 = ["cqb","run_and_gun"];
			}

			if(var_03.size > 0)
			{
				var_04 = undefined;
				if(common_scripts\utility::array_contains(var_03,param_01))
				{
					var_04 = param_01;
				}
				else
				{
					var_04 = common_scripts\utility::random(var_03);
				}

				maps\mp\bots\_bots_util::bot_set_personality(var_04);
				return;
			}
		}
	}
}

//Function Number: 5
bot_gun_think()
{
	self notify("bot_gun_think");
	self endon("bot_gun_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("owner_disconnect");
	var_00 = "";
	var_01 = self.personality;
	wait(0.1);
	for(;;)
	{
		var_02 = self getcurrentweapon();
		if(var_02 != "none" && !maps\mp\_utility::iskillstreakweapon(var_02) && var_02 != var_00)
		{
			var_00 = var_02;
			if(self botgetdifficultysetting("advancedPersonality") && self botgetdifficultysetting("strategyLevel") > 0)
			{
				var_03 = maps\mp\_utility::getbaseweaponname(var_02);
				bot_gun_pick_personality_from_weapon(var_03,var_01);
			}
		}

		self [[ self.personality_update_function ]]();
		wait(0.05);
	}
}