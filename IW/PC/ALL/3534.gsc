/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3534.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:30:03 AM
*******************************************************************/

//Function Number: 1
func_139F9()
{
	self endon("death");
	self endon("disconnect");
	self notify("setDodge");
	self endon("setDodge");
	self endon("removeArchetype");
	thread func_5802();
	for(;;)
	{
		self waittill("dodgeBegin");
		scripts\mp\_utility::func_D915("dodge",self);
		if(isdefined(self.var_45D6) && self.var_45D6 == 1)
		{
			continue;
		}

		if(isdefined(self.var_13118) && self.var_13118 != "")
		{
			continue;
		}

		self.var_5812 = 1;
		scripts\mp\_missions::func_D991("ch_scout_dodge_uses");
		if(scripts\mp\_utility::_hasperk("specialty_dodge_defense"))
		{
			self setclientomnvar("ui_light_armor",1);
		}

		thread func_139FB();
		var_00 = self getnormalizedmovement();
		for(;;)
		{
			if(var_00[0] > 0)
			{
				if(var_00[1] <= 0.7 && var_00[1] >= -0.7)
				{
					self setscriptablepartstate("dodge","dodge_forward");
					break;
				}

				if(var_00[0] > 0.5 && var_00[1] > 0.7)
				{
					self setscriptablepartstate("dodge","dodge_forward_right");
					break;
				}

				if(var_00[0] > 0.5 && var_00[1] < -0.7)
				{
					self setscriptablepartstate("dodge","dodge_forward_left");
					break;
				}
			}

			if(var_00[0] < 0)
			{
				if(var_00[1] < 0.4 && var_00[1] > -0.4)
				{
					self setscriptablepartstate("dodge","dodge_back");
					break;
				}

				if(var_00[0] < -0.5 && var_00[1] > 0.5)
				{
					self setscriptablepartstate("dodge","dodge_back_right");
					break;
				}

				if(var_00[0] < -0.5 && var_00[1] < -0.5)
				{
					self setscriptablepartstate("dodge","dodge_back_left");
					break;
				}
			}

			if(var_00[1] > 0.4)
			{
				self setscriptablepartstate("dodge","dodge_right");
				break;
			}

			if(var_00[1] < -0.4)
			{
				self setscriptablepartstate("dodge","dodge_left");
				break;
			}
			else
			{
				break;
			}
		}

		if(isdefined(self.var_5809))
		{
			triggerfx(self.var_5809);
		}

		foreach(var_02 in level.players)
		{
			if(isdefined(var_02) && var_02 != self)
			{
				playfxontagforclients(level._effect["dash_trail"],self,"tag_shield_back",var_02);
			}
		}

		if(!self isjumping())
		{
		}

		self playlocalsound("synaptic_dash");
		self playsound("synaptic_dash_npc");
		wait(1.5);
		self setscriptablepartstate("dodge","default");
	}
}

//Function Number: 2
func_5802()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	self endon("setDodge");
	for(;;)
	{
		var_00 = self method_842B(1);
		var_01 = self method_842D(1);
		if(var_00 >= var_01)
		{
			self setclientomnvar("ui_dodge_charges",1);
		}
		else
		{
			self setclientomnvar("ui_dodge_charges",0);
		}

		wait(0.05);
	}
}

//Function Number: 3
func_139FB()
{
	level endon("game_ended");
	scripts\common\utility::waittill_any_3("dodgeEnd","death","disconnect");
	self.var_5812 = 0;
	if(scripts\mp\_utility::_hasperk("specialty_dodge_defense"))
	{
		self setclientomnvar("ui_light_armor",0);
	}

	if(isdefined(self))
	{
		stopfxontag(level._effect["dash_trail"],self,"tag_shield_back");
	}

	if(isdefined(self.var_5809))
	{
		self.var_5809 delete();
	}
}