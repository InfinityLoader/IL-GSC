/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_stealth_behavior_friendly.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 101 ms
 * Timestamp: 10/27/2023 2:00:47 AM
*******************************************************************/

//Function Number: 1
stealth_behavior_friendly_main()
{
	friendly_init();
	var_00 = self._stealth.behavior.ai_functions["state"]["hidden"];
	thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_00,"friendly_behavior");
	var_00 = self._stealth.behavior.ai_functions["state"]["spotted"];
	thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_00,"friendly_behavior");
}

//Function Number: 2
friendly_state_hidden()
{
	thread maps\_utility::set_battlechatter(0);
	self._stealth.behavior.oldgrenadeammo = self.grenadeammo;
	self.grenadeammo = 0;
	self.forcesidearm = undefined;
	self.ignoreme = 1;
}

//Function Number: 3
friendly_state_spotted()
{
	thread maps\_utility::set_battlechatter(1);
	if(isdefined(self._stealth.behavior.oldgrenadeammo))
	{
		self.grenadeammo = self._stealth.behavior.oldgrenadeammo;
	}
	else
	{
		self.grenadeammo = 3;
	}

	self.ignoreme = 0;
	self pushplayer(0);
	maps\_utility::disable_cqbwalk();
	thread friendly_spotted_getup_from_prone();
	self allowedstances("prone","crouch","stand");
	if(self.type != "dog" || !isdefined(self.in_melee) || !self.in_melee)
	{
		maps\_utility::anim_stopanimscripted();
	}
}

//Function Number: 4
friendly_spotted_getup_from_prone(param_00)
{
	self endon("death");
	if(self._stealth.logic.stance != "prone")
	{
		return;
	}

	maps\_utility::ent_flag_set("_stealth_custom_anim");
	var_01 = "_stealth_prone_2_run_roll";
	if(isdefined(param_00))
	{
		self orientmode("face angle",param_00[1] + 20);
	}

	thread maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity",var_01);
	var_02 = getanimlength(maps\_utility::getanim_generic(var_01));
	wait(var_02 - 0.2);
	self notify("stop_animmode");
	maps\_utility::ent_flag_clear("_stealth_custom_anim");
}

//Function Number: 5
friendly_init()
{
	maps\_utility::ent_flag_init("_stealth_custom_anim");
	maps\_utility::ent_flag_init("_stealth_override_goalpos");
	self._stealth.behavior = spawnstruct();
	self._stealth.behavior.ai_functions = [];
	friendly_default_state_behavior();
	self._stealth.plugins = spawnstruct();
	thread maps\_stealth_shared_utilities::ai_stealth_pause_handler();
}

//Function Number: 6
friendly_custom_state_behavior(param_00)
{
	foreach(var_03, var_02 in param_00)
	{
		maps\_stealth_shared_utilities::ai_create_behavior_function("state",var_03,var_02);
	}

	var_04 = self._stealth.behavior.ai_functions["state"]["hidden"];
	thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_04,"friendly_behavior");
	var_04 = self._stealth.behavior.ai_functions["state"]["spotted"];
	thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_04,"friendly_behavior");
}

//Function Number: 7
friendly_default_state_behavior()
{
	var_00 = [];
	var_00["hidden"] = ::friendly_state_hidden;
	var_00["spotted"] = ::friendly_state_spotted;
	friendly_custom_state_behavior(var_00);
}