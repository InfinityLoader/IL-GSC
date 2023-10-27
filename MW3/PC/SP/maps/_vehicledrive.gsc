/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_vehicledrive.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 194 ms
 * Timestamp: 10/27/2023 2:20:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvarifuninitialized("debug_vehiclegod","off");
	setdvarifuninitialized("debug_vehicleplayerhealth","off");
	setdvarifuninitialized("player_vehicle_dismountable","off");
	precacheshader("tank_shell");
	level.playeronvehicle = 0;
}

//Function Number: 2
vehicle_wait(param_00)
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
			thread vehicle_exit();
		}

		if(param_00)
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 3
vehicle_exit()
{
	level.playeronvehicle = 0;
	level.playervehicle = level.playervehiclenone;
	level notify("player exited vehicle");
	if(isdefined(level.player.oldthreatbias))
	{
		level.player.threatbias = level.player.oldthreatbias;
		level.player.oldthreatbias = undefined;
	}

	if(isdefined(level.vehiclehud))
	{
		level.vehiclehud destroy();
	}

	if(isdefined(level.vehiclehud2))
	{
		level.vehiclehud2 destroy();
	}

	if(isdefined(level.vehiclefireicon))
	{
		level.vehiclefireicon destroy();
	}
}

//Function Number: 4
vehicle_enter()
{
	level.playeronvehicle = 1;
	level.playervehicle = self;
	thread vehicle_ridehandle();
}

//Function Number: 5
setup_vehicle_tank()
{
	vehicle_givehealth();
}

//Function Number: 6
setup_vehicle_other()
{
	vehicle_givehealth();
}

//Function Number: 7
vehicle_givehealth()
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

	if(isdefined(self.healthbuffer))
	{
		self.health = self.health + self.healthbuffer;
		self.currenthealth = self.health;
		self.maxhealth = self.health;
	}
}

//Function Number: 8
protect_player()
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
	thread vehicle_kill_player_ondeath();
	self.maximumhealth = self.health;
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

	thread vehicle_damageset();
	var_03 = gettime();
	for(;;)
	{
		if(self.damaged)
		{
			if(getdvar("debug_vehicleplayerhealth") != "off")
			{
				iprintlnbold("playervehicles health: ",self.health - self.healthbuffer);
			}

			self.damaged = 0;
			var_02 = gettime() + var_01;
		}

		var_04 = gettime();
		if(self.health < self.maximumhealth && var_04 > var_02 && var_04 > var_03)
		{
			if(self.health + var_00 > self.maximumhealth)
			{
				self.health = self.maximumhealth;
			}
			else
			{
				self.health = self.health + var_00;
			}

			var_03 = gettime() + 250;
			if(getdvar("debug_vehicleplayerhealth") != "off")
			{
				iprintlnbold("playervehicles health: ",self.health - self.healthbuffer);
			}
		}

		wait 0.05;
	}
}

//Function Number: 10
vehicle_kill_player_ondeath()
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
vehicle_damageset()
{
	self.damaged = 0;
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00);
		self.damaged = 1;
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
vehicle_hud_tank_fireicon()
{
	if(getdvar("player_vehicle_dismountable") != "off")
	{
		return;
	}

	level endon("player exited vehicle");
	level.player endon("death");
	self endon("death");
	if(isdefined(level.vehiclefireicon))
	{
		level.vehiclefireicon destroy();
	}

	level.vehiclefireicon = newhudelem();
	level.vehiclefireicon.x = -32;
	level.vehiclefireicon.y = -64;
	level.vehiclefireicon.alignx = "center";
	level.vehiclefireicon.aligny = "middle";
	level.vehiclefireicon.horzalign = "right";
	level.vehiclefireicon.vertalign = "bottom";
	level.vehiclefireicon setshader("tank_shell",64,64);
	var_00 = 1;
	level.vehiclefireicon.alpha = var_00;
	for(;;)
	{
		if(var_00)
		{
			if(!self isturretready())
			{
				var_00 = 0;
				level.vehiclefireicon.alpha = var_00;
			}
		}
		else if(self isturretready())
		{
			var_00 = 1;
			level.vehiclefireicon.alpha = var_00;
		}

		wait 0.05;
	}
}

//Function Number: 14
healthoverlay()
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
	var_01 = self.health - self.healthbuffer;
	var_02 = 0;
	var_03 = 0.3;
	for(;;)
	{
		var_04 = self.health - self.healthbuffer / var_01;
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
			var_04 = self.health - self.healthbuffer / var_01;
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