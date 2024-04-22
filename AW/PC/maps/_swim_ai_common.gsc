/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _swim_ai_common.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 142 ms
 * Timestamp: 4/22/2024 2:23:24 AM
*******************************************************************/

//Function Number: 1
override_footsteps()
{
	wait(0.1);
	var_00 = level._effect["swim_kick_bubble"];
	if(isdefined(var_00))
	{
		animscripts\utility::setfootstepeffect("default",var_00);
		animscripts\utility::setfootstepeffect("asphalt",var_00);
		animscripts\utility::setfootstepeffect("brick",var_00);
		animscripts\utility::setfootstepeffect("carpet",var_00);
		animscripts\utility::setfootstepeffect("cloth",var_00);
		animscripts\utility::setfootstepeffect("concrete",var_00);
		animscripts\utility::setfootstepeffect("cushion",var_00);
		animscripts\utility::setfootstepeffect("dirt",var_00);
		animscripts\utility::setfootstepeffect("foliage",var_00);
		animscripts\utility::setfootstepeffect("grass",var_00);
		animscripts\utility::setfootstepeffect("gravel",var_00);
		animscripts\utility::setfootstepeffect("mud",var_00);
		animscripts\utility::setfootstepeffect("rock",var_00);
		animscripts\utility::setfootstepeffect("sand",var_00);
		animscripts\utility::setfootstepeffect("wood",var_00);
		animscripts\utility::setfootstepeffect("water",var_00);
		animscripts\utility::setfootstepeffectsmall("default",var_00);
		animscripts\utility::setfootstepeffectsmall("asphalt",var_00);
		animscripts\utility::setfootstepeffectsmall("brick",var_00);
		animscripts\utility::setfootstepeffectsmall("carpet",var_00);
		animscripts\utility::setfootstepeffectsmall("cloth",var_00);
		animscripts\utility::setfootstepeffectsmall("concrete",var_00);
		animscripts\utility::setfootstepeffectsmall("cushion",var_00);
		animscripts\utility::setfootstepeffectsmall("dirt",var_00);
		animscripts\utility::setfootstepeffectsmall("foliage",var_00);
		animscripts\utility::setfootstepeffectsmall("grass",var_00);
		animscripts\utility::setfootstepeffectsmall("gravel",var_00);
		animscripts\utility::setfootstepeffectsmall("mud",var_00);
		animscripts\utility::setfootstepeffectsmall("rock",var_00);
		animscripts\utility::setfootstepeffectsmall("sand",var_00);
		animscripts\utility::setfootstepeffectsmall("wood",var_00);
		animscripts\utility::setfootstepeffectsmall("water",var_00);
		override_footstep_notetrack_scripts();
	}
}

//Function Number: 2
restore_footsteps()
{
	animscripts\utility::unsetfootstepeffect("default");
	animscripts\utility::unsetfootstepeffect("asphalt");
	animscripts\utility::unsetfootstepeffect("brick");
	animscripts\utility::unsetfootstepeffect("carpet");
	animscripts\utility::unsetfootstepeffect("cloth");
	animscripts\utility::unsetfootstepeffect("concrete");
	animscripts\utility::unsetfootstepeffect("cushion");
	animscripts\utility::unsetfootstepeffect("dirt");
	animscripts\utility::unsetfootstepeffect("foliage");
	animscripts\utility::unsetfootstepeffect("grass");
	animscripts\utility::unsetfootstepeffect("gravel");
	animscripts\utility::unsetfootstepeffect("mud");
	animscripts\utility::unsetfootstepeffect("rock");
	animscripts\utility::unsetfootstepeffect("sand");
	animscripts\utility::unsetfootstepeffect("wood");
	animscripts\utility::unsetfootstepeffect("water");
	animscripts\utility::unsetfootstepeffectsmall("default");
	animscripts\utility::unsetfootstepeffectsmall("asphalt");
	animscripts\utility::unsetfootstepeffectsmall("brick");
	animscripts\utility::unsetfootstepeffectsmall("carpet");
	animscripts\utility::unsetfootstepeffectsmall("cloth");
	animscripts\utility::unsetfootstepeffectsmall("concrete");
	animscripts\utility::unsetfootstepeffectsmall("cushion");
	animscripts\utility::unsetfootstepeffectsmall("dirt");
	animscripts\utility::unsetfootstepeffectsmall("foliage");
	animscripts\utility::unsetfootstepeffectsmall("grass");
	animscripts\utility::unsetfootstepeffectsmall("gravel");
	animscripts\utility::unsetfootstepeffectsmall("mud");
	animscripts\utility::unsetfootstepeffectsmall("rock");
	animscripts\utility::unsetfootstepeffectsmall("sand");
	animscripts\utility::unsetfootstepeffectsmall("wood");
	animscripts\utility::unsetfootstepeffectsmall("water");
	restore_footstep_notetrack_scripts();
}

//Function Number: 3
override_water_footsteps()
{
	wait(0.1);
	var_00 = level._effect["swim_kick_bubble"];
	animscripts\utility::setfootstepeffect("water",var_00);
	animscripts\utility::setfootstepeffectsmall("water",var_00);
	override_footstep_notetrack_scripts();
}

//Function Number: 4
restore_water_footsteps()
{
	animscripts\utility::unsetfootstepeffect("water");
	animscripts\utility::unsetfootstepeffectsmall("water");
	restore_footstep_notetrack_scripts();
}

//Function Number: 5
override_footstep_notetrack_scripts()
{
	level.notetracks["footstep_right_large"] = ::notetrackfootstep;
	level.notetracks["footstep_right_small"] = ::notetrackfootstep;
	level.notetracks["footstep_left_large"] = ::notetrackfootstep;
	level.notetracks["footstep_left_small"] = ::notetrackfootstep;
}

//Function Number: 6
restore_footstep_notetrack_scripts()
{
	level.notetracks["footstep_right_large"] = ::animscripts\notetracks::notetrackfootstep;
	level.notetracks["footstep_right_small"] = ::animscripts\notetracks::notetrackfootstep;
	level.notetracks["footstep_left_large"] = ::animscripts\notetracks::notetrackfootstep;
	level.notetracks["footstep_left_small"] = ::animscripts\notetracks::notetrackfootstep;
}

//Function Number: 7
notetrackfootstep(param_00,param_01)
{
	var_02 = issubstr(param_00,"left");
	var_03 = issubstr(param_00,"large");
	playfootstep(var_02,var_03);
}

//Function Number: 8
playfootstep(param_00,param_01)
{
	if(!isai(self))
	{
		self playsound("step_run_dirt");
		return;
	}

	var_02 = "water";
	var_03 = "J_Ball_RI";
	if(param_00)
	{
		var_03 = "J_Ball_LE";
	}

	var_04 = "run";
	thread maps\_utility::play_sound_on_entity("foot_flipper_underwater");
	playbubbleeffect(var_03,var_02);
}

//Function Number: 9
playbubbleeffect(param_00,param_01)
{
	if(!isdefined(level.optionalstepeffects[param_01]))
	{
		return 0;
	}

	var_02 = self gettagorigin(param_00);
	var_03 = self.angles;
	var_04 = anglestoforward(var_03);
	var_05 = var_04 * -1;
	var_06 = (0,0,1);
	playfxontag(level._effect["step_" + param_01],self,param_00);
	return 1;
}