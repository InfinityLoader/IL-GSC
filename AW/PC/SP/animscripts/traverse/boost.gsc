/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\boost.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 174 ms
 * Timestamp: 10/27/2023 1:53:08 AM
*******************************************************************/

//Function Number: 1
precache_boost_fx_npc()
{
	level._effect["boost_dust_npc"] = loadfx("vfx/smoke/jetpack_exhaust_npc");
	level._effect["boost_dust_impact_ground"] = loadfx("vfx/smoke/jetpack_ground_impact_runner");
}

//Function Number: 2
rocket_jump_human(param_00,param_01,param_02)
{
	var_03 = [];
	var_03["traverseAnim"] = param_00;
	var_03["traverseNotetrackFunc"] = ::newhandletraversenotetracks;
	if(isdefined(param_02) && param_02 == "landassist")
	{
		var_03["traverseNotetrackFunc"] = ::newhandletraversenotetracks_landassist;
	}

	self.is_using_boost = 1;
	animscripts\traverse\shared::dotraverse(var_03);
	if(isdefined(self) && isalive(self) && isdefined(param_01) && param_01)
	{
		soundscripts\_snd::snd_message("boost_land_npc");
		self setflaggedanimknoballrestart("boostJumpLand",%boost_jump_land_2_run_b,%body,1,0.2,1);
		animscripts\shared::donotetracks("boostJumpLand",::newhandletraversenotetracks);
	}

	self.is_using_boost = undefined;
}

//Function Number: 3
newhandletraversenotetracks_landassist(param_00)
{
	switch(param_00)
	{
		case "boost_begin":
			break;

		case "land_assist":
			break;

		case "assist_thrusters":
			break;

		case "boost_end":
			break;

		case "distort_begin":
			break;

		default:
			break;
	}
}

//Function Number: 4
newhandletraversenotetracks(param_00)
{
	switch(param_00)
	{
		case "boost_begin":
			break;

		case "boost_end":
			break;

		default:
			break;
	}
}

//Function Number: 5
newhandleboostbegin()
{
	soundscripts\_snd::snd_message("boost_jump_npc");
	if(!maps\_utility::ent_flag_exist("boost_end"))
	{
		maps\_utility::ent_flag_init("boost_end");
	}

	thread newhandlespawngroundimpact();
	playfxontag(common_scripts\utility::getfx("boost_dust_npc"),self,"J_SpineLower");
	maps\_utility::ent_flag_wait("boost_end");
	stopfxontag(common_scripts\utility::getfx("boost_dust_npc"),self,"J_SpineLower");
	maps\_utility::ent_flag_clear("boost_end");
}

//Function Number: 6
newhandleboostend()
{
	maps\_utility::ent_flag_set("boost_end");
}

//Function Number: 7
newhandlespawngroundimpact()
{
	var_00 = self.origin + (0,0,64);
	var_01 = self.origin - (0,0,150);
	var_02 = bullettrace(var_00,var_01,0,undefined);
	var_03 = common_scripts\utility::getfx("boost_dust_impact_ground");
	var_00 = var_02["position"];
	var_04 = vectortoangles(var_02["normal"]);
	var_04 = var_04 + (90,0,0);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoup(var_04);
	playfx(var_03,var_00,var_06,var_05);
}

//Function Number: 8
land_assist_thrusters(param_00)
{
	playfxontag(common_scripts\utility::getfx("landass_exhaust_smk_lf_npc"),param_00,"J_MainRoot");
	playfxontag(common_scripts\utility::getfx("landass_exhaust_smk_rt_npc"),param_00,"J_MainRoot");
	param_00 soundscripts\_snd::snd_message("boost_land_assist_npc");
}

//Function Number: 9
land_assist_thrusters_with_land(param_00)
{
	playfxontag(common_scripts\utility::getfx("landass_exhaust_smk_lf_npc"),param_00,"J_MainRoot");
	playfxontag(common_scripts\utility::getfx("landass_exhaust_smk_rt_npc"),param_00,"J_MainRoot");
	param_00 soundscripts\_snd::snd_message("boost_land_assist_npc");
	wait(0.05);
	var_01 = physicstrace(param_00.origin,param_00.origin + (0,0,-5120));
	var_02 = anglestoforward(param_00.angles);
	playfx(common_scripts\utility::getfx("landass_impact_smk_rnr"),var_01,var_02);
	wait(0.35);
	var_01 = physicstrace(param_00.origin,param_00.origin + (0,0,-5120));
	playfx(common_scripts\utility::getfx("landass_impact_smk_rnr"),var_01,var_02);
	param_00 soundscripts\_snd::snd_message("boost_land_assist_npc_ground");
}

//Function Number: 10
handletraversenotetrackslandassist(param_00)
{
	if(param_00 == "assist_thrusters")
	{
		land_assist_thrusters(self);
		return;
	}

	if(param_00 == "assist_thrusters_2")
	{
		land_assist_thrusters(self);
		return;
	}

	if(param_00 == "fx_start")
	{
		land_assist_thrusters(self);
		return;
	}

	animscripts\traverse\shared::handletraversenotetracks(param_00);
}