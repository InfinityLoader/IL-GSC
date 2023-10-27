/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_stealth_accuracy_friendly.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 87 ms
 * Timestamp: 10/27/2023 2:00:43 AM
*******************************************************************/

//Function Number: 1
stealth_accuracy_friendly_main()
{
	friendly_init();
	var_00 = self._stealth.behavior.ai_functions["accuracy"]["hidden"];
	thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_00,"accuracy_friendly");
	var_00 = self._stealth.behavior.ai_functions["accuracy"]["spotted"];
	thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_00,"accuracy_friendly");
}

//Function Number: 2
friendly_acc_hidden()
{
	self.baseaccuracy = self._stealth.behavior.goodaccuracy;
	self.accuracy = self._stealth.behavior.goodaccuracy;
}

//Function Number: 3
friendly_acc_spotted()
{
	self.baseaccuracy = self._stealth.behavior.old_baseaccuracy;
	self.accuracy = self._stealth.behavior.old_accuracy;
}

//Function Number: 4
friendly_init()
{
	self._stealth.behavior.goodaccuracy = 50;
	self._stealth.behavior.old_baseaccuracy = self.baseaccuracy;
	self._stealth.behavior.old_accuracy = self.accuracy;
	friendly_default_acc_behavior();
	self._stealth.plugins.accaracy_mod = 1;
}

//Function Number: 5
friendly_custom_acc_behavior(param_00)
{
	foreach(var_03, var_02 in param_00)
	{
		maps\_stealth_shared_utilities::ai_create_behavior_function("accuracy",var_03,var_02);
	}

	var_04 = self._stealth.behavior.ai_functions["accuracy"]["hidden"];
	thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_04,"accuracy_friendly");
	var_04 = self._stealth.behavior.ai_functions["accuracy"]["spotted"];
	thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_04,"accuracy_friendly");
}

//Function Number: 6
friendly_default_acc_behavior()
{
	var_00 = [];
	var_00["hidden"] = ::friendly_acc_hidden;
	var_00["spotted"] = ::friendly_acc_spotted;
	friendly_custom_acc_behavior(var_00);
}