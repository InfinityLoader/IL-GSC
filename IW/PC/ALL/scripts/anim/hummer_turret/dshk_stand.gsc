/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\hummer_turret\dshk_stand.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 181 ms
 * Timestamp: 10/26/2023 11:59:15 PM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = self method_8164();
	var_01 = func_7927();
	self.var_5270 = "stand";
	scripts\anim\utility::func_12E5F();
	self.var_D8E0 = %gazgunner_aim;
	self.var_17E4 = %gaz_turret_aim_6_add;
	self.var_17E5 = %gaz_turret_aim_4_add;
	self.var_17E0 = %additive_gazgunner_aim_leftright;
	self.var_17E3 = %gaz_turret_idle;
	self.var_17E1 = %gaz_turret_idle;
	self.var_17E2 = %gaz_turret_fire;
	self.var_17E6 = %additive_gazgunner_usegun;
	self.var_12A5F = %gazgunner_death;
	self.var_12A5E = var_01;
	self.var_12A7F[0] = %gaz_turret_paina;
	self.var_12A7F[1] = %gaz_turret_painb;
	self.var_12A66 = %gaz_turret_flincha;
	self.var_12A81 = %gaz_turret_paina;
	self.var_12A93 = %gazgunner;
	var_02 = [];
	var_02["humvee_turret_flinchA"] = %gaz_turret_flincha;
	var_02["humvee_turret_flinchB"] = %gaz_turret_flinchb;
	self.var_12A92 = var_02;
	var_00 func_FA6A();
	thread scripts\anim\hummer_turret\minigun_code::main(var_00);
}

//Function Number: 2
func_7927()
{
	var_00 = %gaz_turret_death;
	if(isdefined(self.var_E500))
	{
		if(isdefined(level.var_5F07))
		{
			var_00 = self [[ level.var_5F07 ]]();
		}
	}

	return var_00;
}

//Function Number: 3
func_FA6A()
{
	self method_83D0(#animtree);
	self.var_C937 = %humvee_passenger_2_turret_minigun;
	self.var_129B8 = %humvee_turret_2_passenger_minigun;
}