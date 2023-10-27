/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3602.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:30:52 AM
*******************************************************************/

//Function Number: 1
func_8543()
{
	level thread func_8545();
}

//Function Number: 2
func_8545()
{
	for(;;)
	{
		level waittill("player_spawned",var_00);
		if(isai(var_00))
		{
			continue;
		}
	}
}

//Function Number: 3
func_8544()
{
}

//Function Number: 4
func_8541()
{
	self.var_853E = 1;
	self iprintlnbold("gravWave");
	self radiusdamage(self.origin,256,50,33,self,"MOD_EXPLOSIVE","distortionfield_grenade_mp");
	thread func_8542();
	thread func_8540();
	return 1;
}

//Function Number: 5
func_8546()
{
	self endon("gravWave_end");
	self endon("death");
	for(;;)
	{
		self waittill("gravWaveHit",var_00);
		var_00 shellshock("concussion_grenade_mp",1.5);
		var_00 thread func_2025();
	}
}

//Function Number: 6
func_2025(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	var_01 = spawn("script_model",self.origin);
	var_01 setmodel("tag_origin");
	thread func_ABFD(var_01,param_00);
	wait(3);
	var_02 = self getplayerangles(1);
	self setworldupreference(undefined);
	self unlink();
	var_01 delete();
	self notify("dropGravWave");
}

//Function Number: 7
func_ABFD(param_00,param_01)
{
	self endon("dropGravWave");
	self endon("death");
	self endon("disconnect");
	var_02 = func_2A96(param_00);
	var_03 = func_7E1C();
	var_04 = self.origin;
	var_05 = anglestoup(self.angles);
	self method_84DC(var_05,160);
	self shellshock("concussion_grenade_mp",3,0,1);
	self notify("flashbang",self.origin,1,30,param_01,1);
	param_00.origin = self.origin;
	param_00.angles = self.angles;
	if(param_00.var_10DD9[2] < var_04[2])
	{
		param_00.var_10DD9 = self.origin + (0,0,12);
	}

	self playerlinkto(param_00);
	param_00 moveto(param_00.var_10DD9,0.45,0.1,0.1);
	var_06 = 0;
	var_07 = int(var_02 / 2);
	var_08 = int(var_02 / 4);
	var_09 = int(var_08 * -1);
	wait(0.45);
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		var_0A = randomfloatrange(0.4,0.7);
		if(self.origin[2] > param_00.var_10DD9[2] + var_07)
		{
			var_06 = randomintrange(var_09,0);
		}
		else if(self.origin[2] < param_00.var_10DD9[2] - var_07)
		{
			var_06 = randomintrange(0,var_08);
		}
		else
		{
			var_06 = randomintrange(var_09,var_08);
		}

		var_0B = var_0A / 6;
		if(var_06 > 0)
		{
			var_0C = scripts\common\trace::func_D307(self.origin,self.origin + (0,0,var_06),self.angles,self,var_03,12);
			if(var_0C)
			{
				param_00 movez(var_06,var_0A,var_0B,var_0B);
			}
		}
		else if(var_04[2] + 34 < self.origin[2] + var_06)
		{
			param_00 movez(var_06,var_0A,var_0B,var_0B);
		}

		wait(var_0A);
	}
}

//Function Number: 8
func_2A96(param_00)
{
	var_01 = func_7E1C();
	var_02 = scripts\common\trace::func_D305(self.origin,self.origin + (0,0,256),self.angles,self,var_01,0,12);
	var_03 = var_02["position"] - (0,0,72);
	var_04 = var_02["position"] - (0,0,256);
	var_05 = scripts\common\trace::func_D305(var_03,var_04,self.angles,self,var_01,0,12);
	var_06 = var_02["position"][2] - var_05["position"][2];
	if(var_06 < 4)
	{
		var_06 = 4;
	}

	var_07 = var_06 / 2;
	var_07 = var_07 - 36;
	var_08 = self.origin + (0,0,var_07);
	param_00.var_10DD9 = var_08;
	return var_06;
}

//Function Number: 9
func_7E1C()
{
	var_00 = ["physicscontents_solid","physicscontents_glass","physicscontents_item","physicscontents_clipshot","physicscontents_actor","physicscontents_playerclip","physicscontents_fakeactor","physicscontents_vehicle","physicscontents_structural"];
	var_01 = physics_createcontents(var_00);
	return var_01;
}

//Function Number: 10
func_20FE(param_00)
{
	self endon("dropGravWave");
	self endon("death");
	var_01 = randomintrange(90,270);
	self setorigin(param_00.origin);
	self setplayerangles(param_00.angles);
	self setworldupreference(param_00);
	var_02 = param_00.angles;
	var_02 = var_02 * (1,1,0);
	var_02 = var_02 + (0,0,var_01);
	var_03 = 1.5;
	param_00 rotateto(var_02,var_03,0.1,0.1);
}

//Function Number: 11
func_853F()
{
	if(!isdefined(self))
	{
		return;
	}

	self.var_853E = 0;
	self setscriptablepartstate("gravWave","gravwaveOff",0);
	self notify("gravWave_end");
}

//Function Number: 12
func_8542()
{
	self endon("gravWave_end");
	scripts\common\utility::waittill_any_3("death","disconnect","game_ended");
	thread func_853F();
}

//Function Number: 13
func_9E17()
{
	if(!isdefined(self.var_853E))
	{
		return 0;
	}

	return self.var_853E;
}

//Function Number: 14
func_8540()
{
	self endon("disconnect");
	self endon("gravWave_end");
	self method_846F("ges_hold");
	self setscriptablepartstate("gravWave","gravwaveOn",0);
}