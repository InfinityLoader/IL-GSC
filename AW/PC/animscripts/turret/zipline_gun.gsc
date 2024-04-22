/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: turret\zipline_gun.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 27 ms
 * Timestamp: 4/22/2024 1:59:47 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.a.movement = "stop";
	var_00 = self getturret();
	var_01 = 0;
	if(issubstr(var_00.model,"_left"))
	{
		var_01 = 1;
	}

	if(var_01)
	{
		self.primaryturretanim = %ziplinegunnerleft_aim;
	}
	else
	{
		self.primaryturretanim = %ziplinegunnerright_aim;
	}

	self clearanim(%body,0.2);
	self setturretanim(self.primaryturretanim);
	self setanimknobrestart(self.primaryturretanim,1,0.2,1);
}