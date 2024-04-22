/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_spinning_displays.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 93 ms
 * Timestamp: 4/22/2024 2:03:25 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = spawnstruct();
	var_00.cardfx = loadfx("vfx/destructible/greece_spinning_display_flying_cards_01");
	init_displays(var_00);
}

//Function Number: 2
get_num_card_tags(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "greece_spinning_display_stand_01":
			var_01 = 14;
			break;

		case "greece_spinning_display_stand_02":
			var_01 = 43;
			break;
	}

	return var_01;
}

//Function Number: 3
get_num_visible_card_tags()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < self.numcardtags;var_01++)
	{
		if(self.cardtagvisible[var_01])
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 4
init_displays(param_00)
{
	param_00.displays = getentarray("spinningDisplayStand","targetname");
	if(!isdefined(param_00.displays))
	{
		return;
	}

	if(param_00.displays.size == 0)
	{
		return;
	}

	for(var_01 = 0;var_01 < param_00.displays.size;var_01++)
	{
		var_02 = param_00.displays[var_01];
		var_02 init_card_tags();
		if(!isdefined(var_02.origin))
		{
			var_02.origin = (0,0,0);
		}

		var_02 useanimtree(#animtree);
		var_02 setcandamage(1);
		var_02.displayhealth = 50;
		var_02 thread display_update(param_00);
	}
}

//Function Number: 5
init_card_tags()
{
	self.numcardtags = get_num_card_tags(self.model);
	self.cardtagvisible = [];
	self.cardtagnames = [];
	for(var_00 = 0;var_00 < self.numcardtags;var_00++)
	{
		self.cardtagnames[self.cardtagnames.size] = "tag_card_" + var_00 + 1;
		self.cardtagvisible[self.cardtagvisible.size] = 1;
	}
}

//Function Number: 6
get_spin_snd_alias(param_00)
{
	var_01 = "";
	switch(param_00)
	{
		case "greece_spinning_display_stand_01":
			var_01 = "postcard_carousel_spin_sm_01";
			break;

		case "greece_spinning_display_stand_02":
			var_01 = "postcard_carousel_spin_lrg_01";
			break;
	}

	return var_01;
}

//Function Number: 7
get_crash_snd_alias(param_00)
{
	var_01 = "";
	switch(param_00)
	{
		case "greece_spinning_display_stand_01":
			var_01 = "postcard_carousel_crash_sm_01";
			break;

		case "greece_spinning_display_stand_02":
			var_01 = "postcard_carousel_crash_lrg_01";
			break;
	}

	return var_01;
}

//Function Number: 8
display_update(param_00)
{
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05);
		var_06 = var_04 - self.origin;
		var_06 = vectornormalize((var_06[0],var_06[1],0));
		var_07 = vectorcross(var_06,(0,0,1));
		var_08 = vectornormalize((var_03[0],var_03[1],0));
		var_09 = vectordot(var_07,var_08);
		var_0A = %greece_spinning_display_01_spin_ccw;
		if(var_09 > 0)
		{
			var_0A = %greece_spinning_display_01_spin_cw;
		}

		thread maps\_utility::play_sound_on_entity(get_spin_snd_alias(self.model));
		var_0B = getanimlength(var_0A);
		self setanimknobrestart(var_0A,1,0.05);
		var_0C = get_num_visible_card_tags();
		if(var_0C == 0)
		{
			self.displayhealth = self.displayhealth - var_01;
			if(self.displayhealth <= 0)
			{
				self physicslaunchclient(var_04,var_03 * var_01 * 0.75);
				thread maps\_utility::play_sound_on_entity(get_crash_snd_alias(self.model));
				return;
			}
		}
		else
		{
			var_0D = 0;
			for(var_0E = 0;var_0E < self.numcardtags;var_0E++)
			{
				if(!self.cardtagvisible[var_0E])
				{
					continue;
				}

				if(var_0C <= self.numcardtags * 0.25 || randomfloat(1) <= 0.5)
				{
					playfxontag(param_00.cardfx,self,self.cardtagnames[var_0E]);
					wait(0.05);
					self hidepart(self.cardtagnames[var_0E]);
					self.cardtagvisible[var_0E] = 0;
					var_0D = 1;
				}
			}

			if(var_0D)
			{
				thread maps\_utility::play_sound_on_entity("postcard_debris_scatter_01");
			}
		}

		wait(var_0B * 0.3);
	}
}