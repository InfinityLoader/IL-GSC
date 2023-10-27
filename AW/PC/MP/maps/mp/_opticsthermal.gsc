/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_opticsthermal.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 1:49:13 AM
*******************************************************************/

//Function Number: 1
opticsthermal_think()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	if(isagent(self))
	{
		return;
	}

	var_00 = 0.65;
	self.opticsthermalenabled = 0;
	self.orbitalthermalmode = 0;
	self.has_opticsthermal = 0;
	for(;;)
	{
		var_01 = !self.has_opticsthermal;
		var_01 = var_01 | self.has_opticsthermal && self playerads() < var_00;
		var_01 = var_01 | self isusingturret();
		var_01 = var_01 | self.orbitalthermalmode;
		if(var_01)
		{
			opticsthermal_blur_off(self);
		}
		else
		{
			opticsthermal_blur(self,0.05);
		}

		wait(0.05);
	}
}

//Function Number: 2
opticsthermal_blur(param_00,param_01)
{
	if(param_00.opticsthermalenabled)
	{
		return;
	}

	param_00 enablephysicaldepthoffieldscripting(3);
	param_00 setphysicaldepthoffield(70,0,40,80);
	param_00.opticsthermalenabled = 1;
}

//Function Number: 3
opticsthermal_blur_off(param_00)
{
	if(!param_00.opticsthermalenabled)
	{
		return;
	}

	param_00 disablephysicaldepthoffieldscripting();
	param_00.opticsthermalenabled = 0;
}