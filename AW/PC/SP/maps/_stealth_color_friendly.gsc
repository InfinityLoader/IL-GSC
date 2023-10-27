/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_stealth_color_friendly.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 97 ms
 * Timestamp: 10/27/2023 2:00:48 AM
*******************************************************************/

//Function Number: 1
stealth_color_friendly_main()
{
	friendly_init();
	var_00 = self._stealth.behavior.ai_functions["color"]["hidden"];
	thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_00,"color_friendly");
	var_00 = self._stealth.behavior.ai_functions["color"]["spotted"];
	thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_00,"color_friendly");
}

//Function Number: 2
friendly_color_hidden()
{
	maps\_utility::disable_ai_color();
	self.fixednode = 0;
}

//Function Number: 3
friendly_color_spotted()
{
	maps\_utility::enable_ai_color();
}

//Function Number: 4
friendly_init()
{
	friendly_default_color_behavior();
	self._stealth.plugins.color_system = 1;
}

//Function Number: 5
friendly_custom_color_behavior(param_00)
{
	foreach(var_03, var_02 in param_00)
	{
		maps\_stealth_shared_utilities::ai_create_behavior_function("color",var_03,var_02);
	}

	var_04 = self._stealth.behavior.ai_functions["color"]["hidden"];
	thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_04,"color_friendly");
	var_04 = self._stealth.behavior.ai_functions["color"]["spotted"];
	thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_04,"color_friendly");
}

//Function Number: 6
friendly_default_color_behavior()
{
	var_00 = [];
	var_00["hidden"] = ::friendly_color_hidden;
	var_00["spotted"] = ::friendly_color_spotted;
	friendly_custom_color_behavior(var_00);
}