/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _shrike.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 164 ms
 * Timestamp: 4/22/2024 2:05:33 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("shrike",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_airplane_shrike");
	level._effect["engineeffect"] = loadfx("vfx/trail/jet_thruster_far");
	level._effect["afterburner"] = loadfx("vfx/fire/jet_afterburner_ignite");
	level._effect["contrail"] = loadfx("vfx/trail/jet_contrail");
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_generic_ai_explo_lrg_runner",undefined,"explo_metal_rand",undefined,undefined,undefined,undefined,undefined,undefined,0);
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_rumble("mig_rumble",0.1,0.2,11300,0.05,0.05);
	maps\_vehicle::build_team("allies");
}

//Function Number: 2
init_local()
{
	thread playengineeffects();
	thread handle_death();
}

//Function Number: 3
playengineeffects()
{
	self endon("death");
	self endon("stop_engineeffects");
	maps\_utility::ent_flag_init("engineeffects");
	maps\_utility::ent_flag_set("engineeffects");
	var_00 = common_scripts\utility::getfx("engineeffect");
	for(;;)
	{
		maps\_utility::ent_flag_wait("engineeffects");
		playfxontag(var_00,self,"tag_engine_right");
		playfxontag(var_00,self,"tag_engine_left");
		maps\_utility::ent_flag_waitopen("engineeffects");
		stopfxontag(var_00,self,"tag_engine_left");
		stopfxontag(var_00,self,"tag_engine_right");
	}
}

//Function Number: 4
playafterburner()
{
	self endon("death");
	self endon("stop_afterburners");
	maps\_utility::ent_flag_init("afterburners");
	maps\_utility::ent_flag_set("afterburners");
	var_00 = common_scripts\utility::getfx("afterburner");
	for(;;)
	{
		maps\_utility::ent_flag_wait("afterburners");
		playfxontag(var_00,self,"tag_engine_right");
		playfxontag(var_00,self,"tag_engine_left");
		maps\_utility::ent_flag_waitopen("afterburners");
		stopfxontag(var_00,self,"tag_engine_left");
		stopfxontag(var_00,self,"tag_engine_right");
	}
}

//Function Number: 5
handle_death()
{
	self waittill("death");
	if(isdefined(self.tag1))
	{
		self.tag1 delete();
	}

	if(isdefined(self.tag2))
	{
		self.tag2 delete();
	}
}

//Function Number: 6
playcontrail()
{
	self.tag1 = add_contrail("tag_engine_right",1);
	self.tag2 = add_contrail("tag_engine_left",-1);
	var_00 = common_scripts\utility::getfx("contrail");
	self endon("death");
	self endon("stop_contrails");
	maps\_utility::ent_flag_init("contrails");
	maps\_utility::ent_flag_set("contrails");
	for(;;)
	{
		maps\_utility::ent_flag_wait("contrails");
		playfxontag(var_00,self.tag1,"tag_origin");
		playfxontag(var_00,self.tag2,"tag_origin");
		maps\_utility::ent_flag_waitopen("contrails");
		stopfxontag(var_00,self.tag1,"tag_origin");
		stopfxontag(var_00,self.tag2,"tag_origin");
	}
}

//Function Number: 7
add_contrail(param_00,param_01)
{
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02.origin = self gettagorigin(param_00);
	var_02.angles = self gettagangles(param_00);
	var_03 = spawnstruct();
	var_03.entity = var_02;
	var_03.forward = -156;
	var_03.up = 0;
	var_03.right = 224 * param_01;
	var_03.yaw = 0;
	var_03.pitch = 0;
	var_03 maps\_utility::translate_local();
	var_02 linkto(self,param_00);
	return var_02;
}

//Function Number: 8
playerisclose(param_00)
{
	var_01 = playerisinfront(param_00);
	if(var_01)
	{
		var_02 = 1;
	}
	else
	{
		var_02 = -1;
	}

	var_03 = common_scripts\utility::flat_origin(param_00.origin);
	var_04 = var_03 + anglestoforward(common_scripts\utility::flat_angle(param_00.angles)) * var_02 * 100000;
	var_05 = pointonsegmentnearesttopoint(var_03,var_04,level.player.origin);
	var_06 = distance(var_03,var_05);
	if(var_06 < 3000)
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
playerisinfront(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = anglestoforward(common_scripts\utility::flat_angle(param_00.angles));
	var_02 = vectornormalize(common_scripts\utility::flat_origin(level.player.origin) - param_00.origin);
	var_03 = vectordot(var_01,var_02);
	if(var_03 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
plane_sound_node()
{
	self waittill("trigger",var_00);
	var_00 endon("death");
	thread plane_sound_node();
	var_00 thread common_scripts\utility::play_loop_sound_on_entity("veh_f15_dist_loop");
	while(playerisinfront(var_00))
	{
		wait(0.05);
	}

	wait(0.5);
	if(isdefined(var_00))
	{
		var_00 thread common_scripts\utility::play_sound_in_space("veh_f15_sonic_boom");
		var_00 waittill("reached_end_node");
		var_00 stop_sound("veh_f15_dist_loop");
		var_00 delete();
	}
}

//Function Number: 11
stop_sound(param_00)
{
	self notify("stop sound" + param_00);
}