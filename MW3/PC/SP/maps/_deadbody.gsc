/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_deadbody.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 2:20:04 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.scr_anim["dead_guy"]["death1"] = %exposed_death_nerve;
	level.scr_anim["dead_guy"]["death2"] = %exposed_death_falltoknees;
	level.scr_anim["dead_guy"]["death3"] = %exposed_death_headtwist;
	level.scr_anim["dead_guy"]["death4"] = %exposed_crouch_death_twist;
	level.scr_anim["dead_guy"]["death5"] = %exposed_crouch_death_fetal;
	level.scr_anim["dead_guy"]["death6"] = %death_sitting_pose_v1;
	level.scr_anim["dead_guy"]["death7"] = %death_sitting_pose_v2;
	level.scr_anim["dead_guy"]["death8"] = %death_pose_on_desk;
	level.scr_anim["dead_guy"]["death9"] = %death_pose_on_window;
	level.max_number_of_dead_bodies["ead_guy"] = #animtree;
	level.dead_body_count = 1;
	var_00 = getdvarint("ragdoll_max_simulating") - 6;
	if(var_00 > 0)
	{
		level.var_4075 = var_00;
	}
	else
	{
		level.var_4075 = 0;
	}

	var_01 = spawnstruct();
	var_01.bodies = [];
	common_scripts\utility::run_thread_on_targetname("trigger_body",::trigger_body,var_01);
	common_scripts\utility::run_thread_on_targetname("dead_body",::spawn_dead_body,var_01);
}

//Function Number: 2
trigger_body(param_00)
{
	self waittill("trigger");
	var_01 = getentarray(self.target,"targetname");
	common_scripts\utility::array_thread(var_01,::spawn_dead_body,param_00);
}

//Function Number: 3
spawn_dead_body(param_00)
{
	if(!getdvarint("ragdoll_enable") && isdefined(self.script_parameters) && self.script_parameters == "require_ragdoll")
	{
		return;
	}

	if(level.var_4075 == 0)
	{
		return;
	}

	var_01 = undefined;
	if(isdefined(self.script_index))
	{
		var_01 = self.script_index;
	}
	else
	{
		level.dead_body_count++;
		if(level.dead_body_count > 3)
		{
			level.dead_body_count = 1;
		}

		var_01 = level.dead_body_count;
	}

	var_02 = spawn("script_model",(0,0,0));
	var_02.origin = self.origin;
	var_02.angles = self.angles;
	var_02.animname = "dead_guy";
	var_02 maps\_utility::assign_animtree();
	param_00 que_body(var_02);
	var_02 [[ level.scr_deadbody[var_01] ]]();
	if(!isdefined(self.script_trace))
	{
		var_03 = bullettrace(var_02.origin + (0,0,5),var_02.origin + (0,0,-64),0,undefined);
		var_02.origin = var_03["position"];
	}

	var_02 setflaggedanim("flag",var_02 maps\_utility::getanim(self.script_noteworthy),1,0,1);
	var_02 waittillmatch("end","flag");
	if(!isdefined(self.script_start))
	{
		var_02 startragdoll();
	}
}

//Function Number: 4
que_body(param_00)
{
	self.bodies[self.bodies.size] = param_00;
	if(self.bodies.size <= level.var_4075)
	{
		return;
	}

	self.bodies[0] delete();
	self.bodies = common_scripts\utility::array_removeundefined(self.bodies);
}