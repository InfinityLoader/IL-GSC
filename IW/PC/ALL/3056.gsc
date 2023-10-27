/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3056.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:26:05 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	lib_0B95::func_31C5("support_drone",param_00,param_01,param_02);
	lib_0B95::func_31A6(::func_966B);
	lib_0B95::func_3186(param_00);
	lib_0B95::func_3187(0.3,1.6,2048);
	lib_0B95::func_31A3(1500);
	lib_0B95::func_31C4("allies");
	var_03 = randomfloatrange(0,1);
	lib_0B95::func_31C8("pocket_drone_turret","tag_turret","veh_mil_air_un_pocketdrone_gun",undefined,"manual",undefined,0);
	level._effect["_mini_drone_spark"] = loadfx("vfx/core/expl/generator_sparks_a.vfx");
	level._effect["_mini_drone_smoke"] = loadfx("vfx/core/smktrail/smoke_trail_black_heli.vfx");
	level._effect["_support_drone_spawn"] = loadfx("vfx/core/expl/grenade_flash.vfx");
	level._effect["drone_damage_sparks"] = loadfx("vfx/core/expl/generator_sparks_a.vfx");
	lib_0B95::func_31A0();
}

//Function Number: 2
func_966B()
{
	self endon("death");
	self.var_ED12 = 0;
	self.var_5958 = 1;
	self.var_1D63 = 1;
	self.var_627C = 1;
	thread scripts\sp\_vehicle::func_1320C("running");
	waittillframeend;
	self method_81F1(self.var_EEDE);
}

//Function Number: 3
func_B786()
{
	self endon("death");
	var_00 = level.var_13203[self.classname];
	for(;;)
	{
		self waittill("damage");
		playfxontag(level._effect["_mini_drone_smoke"],self,"tag_engine");
		if(self.health - self.var_8CB6 <= var_00 * 0.5)
		{
			while(isalive(self))
			{
				playfxontag(level._effect["_mini_drone_smoke"],self,"tag_engine");
				playfxontag(level._effect["_mini_drone_spark"],self,"tag_engine");
				wait(randomfloatrange(1,2));
			}
		}
	}
}