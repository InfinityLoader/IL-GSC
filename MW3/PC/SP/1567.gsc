/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1567.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:21:16 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("ucav",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_ucav");
	level._effect["jettrail"] = loadfx("smoke/jet_contrail");
	maps\_vehicle::build_deathfx("explosions/large_vehicle_explosion",undefined,"explo_metal_rand");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_mainturret();
}

//Function Number: 2
init_local()
{
	thread func_3E5A();
	self.missiletags[0] = "tag_missile_left";
	self.missiletags[1] = "tag_missile_right";
	self.nextmissiletag = 0;
}

//Function Number: 3
func_3A9C(param_00)
{
	return param_00;
}

//Function Number: 4
func_3A9D()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 1;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	return var_00;
}

//Function Number: 5
func_3E5A()
{
	playfxontag(level._effect["jettrail"],self,"TAG_JET_TRAIL");
}

//Function Number: 6
func_3E81()
{
	self waittill("trigger",var_00);
	var_00 endon("death");
	thread func_3E81();
	var_00 thread maps\_utility::play_sound_on_entity("veh_uav_flyby");
}

//Function Number: 7
func_3E82()
{
	self waittill("trigger",var_00);
	var_00 endon("death");
	thread func_3E82();
	var_00 setvehweapon("ucav_sidewinder");
	var_01 = common_scripts\utility::get_linked_ent();
	var_00 fireweapon(var_00.missiletags[var_00.nextmissiletag],var_01,(0,0,0));
	var_00.nextmissiletag++;
	if(var_00.nextmissiletag >= var_00.missiletags.size)
	{
		var_00.nextmissiletag = 0;
	}
}