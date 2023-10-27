/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\dlc4\simple_action.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 320 ms
 * Timestamp: 10/26/2023 11:58:39 PM
*******************************************************************/

//Function Number: 1
setupsimplebtaction(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = ::simpleaction_begin;
	}

	if(!isdefined(param_01))
	{
		param_01 = ::simpleaction_tick;
	}

	if(!isdefined(param_02))
	{
		param_02 = ::simpleaction_end;
	}

	scripts\aitypes\dlc4\bt_action_api::setupbtaction("simple_action",param_00,param_01,param_02);
}

//Function Number: 2
simpleaction_begin(param_00)
{
	scripts\asm\dlc4\dlc4_asm::setasmaction(self.simple_action);
	scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00,self.simple_action,self.simple_action);
	scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00,self.simple_action);
	var_01 = scripts\aitypes\dlc4\bt_state_api::btstate_getinstancedata(param_00);
	var_01.simple_action = self.simple_action;
	self.simple_action = undefined;
}

//Function Number: 3
simpleaction_tick(param_00)
{
	if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00))
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 4
simpleaction_end(param_00)
{
	self method_841F();
	scripts\asm\dlc4\dlc4_asm::clearasmaction();
	var_01 = scripts\aitypes\dlc4\bt_state_api::btstate_getinstancedata(param_00);
	var_02 = var_01.simple_action;
	var_01.simple_action = undefined;
	self notify(var_02 + "_done");
}

//Function Number: 5
dosimpleaction_immediate(param_00,param_01)
{
	self.simple_action = param_01;
	scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00,"simple_action");
}

//Function Number: 6
dosimpleaction(param_00,param_01)
{
	self.simple_action = param_01;
	self.nextaction = "simple_action";
}