/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_vehicledrive.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 14
 * Decompile Time: 240 ms
 * Timestamp: 10/27/2023 2:34:47 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvarifuninitialized("debug_vehiclegod","off");
	setdvarifuninitialized("debug_vehicleplayerhealth","off");
	setdvarifuninitialized("player_vehicle_dismountable","off");
	precacheshader("tank_shell");
	level.var_3ED7 = 0;
}

//Function Number: 2
func_3ED8(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}
	else if(param_00)
	{
		if(getdvar("player_vehicle_dismountable") == "off")
		{
			self makeunusable();
		}
	}

	self endon("death");
	self endon("stop_vehicle_wait");
	while(self.health > 0)
	{
		if(!param_00)
		{
			self waittill("trigger");
		}
		else
		{
			param_00 = 0;
			self useby(level.player);
		}

		var_01 = self getvehicleowner();
		if(isdefined(var_01) && isplayer(var_01))
		{
			thread vehicle_enter();
		}
		else
		{
			thread func_3ED9();
		}

		if(param_00)
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 3
func_3ED9()
{
	level.var_3ED7 = 0;
	level.var_23D1 = level.var_25D3;
	level notify("player exited vehicle");
	if(isdefined(level.player.oldthreatbias))
	{
		level.player.threatbias = level.player.oldthreatbias;
		level.player.oldthreatbias = undefined;
	}

	if(isdefined(level.var_3EDB))
	{
		level.var_3EDB destroy();
	}

	if(isdefined(level.vehiclehud2))
	{
		level.vehiclehud2 destroy();
	}

	if(isdefined(level.var_3EDD))
	{
		level.var_3EDD destroy();
	}
}

//Function Number: 4
vehicle_enter()
{
	level.var_3ED7 = 1;
	level.var_23D1 = self;
	thread vehicle_ridehandle();
}

//Function Number: 5
func_3EDF()
{
	func_3EE1();
}

//Function Number: 6
setup_vehicle_other()
{
	func_3EE1();
}

//Function Number: 7
func_3EE1()
{
	var_00 = maps\_utility::getdifficulty();
	if(var_00 == "easy")
	{
		self.health = 3000;
	}
	else if(var_00 == "medium")
	{
		self.health = 2500;
	}
	else if(var_00 == "hard")
	{
		self.health = 2000;
	}
	else if(var_00 == "fu")
	{
		self.health = 1300;
	}
	else
	{
		self.health = 2000;
	}

	if(isdefined(self.var_1203))
	{
		self.health = self.health + self.var_1203;
		self.var_2523 = self.health;
		self.maxhealth = self.health;
	}
}

//Function Number: 8
func_3EE2()
{
	level endon("player exited vehicle");
	self endon("death");
	var_00 = level.player.health;
	while(isalive(level.player))
	{
		level.player waittill("damage",var_01);
		if(self.health <= 0)
		{
			level.player kill((0,0,0));
		}

		level.player.health = level.player.health + int(var_01 * 0.2);
	}
}

//Function Number: 9
vehicle_ridehandle()
{
	level endon("player exited vehicle");
	self endon("no_regen_health");
	self endon("death");
	thread func_3EE6();
	self.var_3EE4 = self.health;
	switch(maps\_utility::getdifficulty())
	{
		case "gimp":
			var_00 = 100;
			var_01 = 2700;
			break;

		case "easy":
			var_00 = 75;
			var_01 = 2700;
			break;

		case "medium":
			var_00 = 50;
			var_01 = 2700;
			break;

		case "hard":
			var_00 = 30;
			var_01 = 3700;
			break;

		case "fu":
			var_00 = 20;
			var_01 = 4700;
			break;

		default:
			var_00 = 50;
			var_01 = 2700;
			break;
	}

	if(self.vehicletype == "crusader_player")
	{
		self setmodel("vehicle_crusader2_viewmodel");
	}

	var_02 = gettime();
	if(getdvar("debug_vehiclegod") != "off")
	{
		for(;;)
		{
			self waittill("damage");
			self.health = self.maxhealth;
		}
	}

	thread func_3EE7();
	var_03 = gettime();
	for(;;)
	{
		if(self.var_3EE5)
		{
			if(getdvar("debug_vehicleplayerhealth") != "off")
			{
				iprintlnbold("playervehicles health: ",self.health - self.var_1203);
			}

			self.var_3EE5 = 0;
			var_02 = gettime() + var_01;
		}

		var_04 = gettime();
		if(self.health < self.var_3EE4 && var_04 > var_02 && var_04 > var_03)
		{
			if(self.health + var_00 > self.var_3EE4)
			{
				self.health = self.var_3EE4;
			}
			else
			{
				self.health = self.health + var_00;
			}

			var_03 = gettime() + 250;
			if(getdvar("debug_vehicleplayerhealth") != "off")
			{
				iprintlnbold("playervehicles health: ",self.health - self.var_1203);
			}
		}

		wait 0.05;
	}
}

//Function Number: 10
func_3EE6()
{
	level endon("player exited vehicle");
	self waittill("death");
	level.player enablehealthshield(0);
	for(;;)
	{
		level.player kill();
		wait 0.1;
	}

	wait 0.5;
	level.player enablehealthshield(1);
}

//Function Number: 11
func_3EE7()
{
	self.var_3EE5 = 0;
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00);
		self.var_3EE5 = 1;
	}
}

//Function Number: 12
vehicle_reloadsound()
{
	for(;;)
	{
		self waittill("turret_fire");
		wait 0.5;
		self playsound("tank_reload");
	}
}

//Function Number: 13
func_3EE9()
{
	if(getdvar("player_vehicle_dismountable") != "off")
	{
		return;
	}

	level endon("player exited vehicle");
	level.player endon("death");
	self endon("death");
	if(isdefined(level.var_3EDD))
	{
		level.var_3EDD destroy();
	}

	level.var_3EDD = newhudelem();
	level.var_3EDD.x = -32;
	level.var_3EDD.y = -64;
	level.var_3EDD.alignx = "center";
	level.var_3EDD.aligny = "middle";
	level.var_3EDD.horzalign = "right";
	level.var_3EDD.vertalign = "bottom";
	level.var_3EDD setshader("tank_shell",64,64);
	var_00 = 1;
	level.var_3EDD.alpha = var_00;
	for(;;)
	{
		if(var_00)
		{
			if(!self isturretready())
			{
				var_00 = 0;
				level.var_3EDD.alpha = var_00;
			}
		}
		else if(self isturretready())
		{
			var_00 = 1;
			level.var_3EDD.alpha = var_00;
		}

		wait 0.05;
	}
}

//Function Number: 14
func_1EB6()
{
	self endon("death");
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 0;
	var_00 setshader("splatter_alt_sp",640,480);
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.alpha = 0;
	var_01 = self.health - self.var_1203;
	var_02 = 0;
	var_03 = 0.3;
	for(;;)
	{
		var_04 = self.health - self.var_1203 / var_01;
		var_05 = 0.5 + 0.5 * var_04;
		if(var_04 < 0.75 || var_02)
		{
			if(!var_02)
			{
				var_02 = 1;
			}

			var_06 = 1 - var_04 + var_03;
			var_00 fadeovertime(0.05);
			var_00.alpha = var_06;
			wait 0.1;
			var_00 fadeovertime(var_05 * 0.2);
			var_00.alpha = var_06 * 0.5;
			wait var_05 * 0.2;
			var_00 fadeovertime(var_05 * 0.3);
			var_00.alpha = var_06 * 0.3;
			wait var_05 * 0.3;
			var_04 = self.health - self.var_1203 / var_01;
			var_05 = 0.3 + 0.7 * var_04;
			if(var_04 > 0.9)
			{
				var_02 = 0;
				var_00 fadeovertime(0.5);
				var_00.alpha = 0;
				wait var_05 * 0.5 - 0.1;
			}
			else
			{
				wait var_05 * 0.5 - 0.1;
			}

			continue;
		}

		wait 0.05;
	}
}