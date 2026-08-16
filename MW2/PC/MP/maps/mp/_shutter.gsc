/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_shutter.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	level.inc = 0;
	common_scripts\utility::array_levelthread(getentarray("wire", "targetname"), ::wirewander);
	leftshutters = getentarray("shutter_left", "targetname");
	addshutters = getentarray("shutter_right_open", "targetname");
	for(i = 0;i < addshutters.size;i++)
	{
		leftshutters[leftshutters.size] = addshutters[i];
	}

	addshutters = getentarray("shutter_left_closed", "targetname");
	for(i = 0;i < addshutters.size;i++)
	{
		leftshutters[leftshutters.size] = addshutters[i];
	}

	for(i = 0;i < leftshutters.size;i++)
	{
		shutter = leftshutters[i];
		shutter rotateto((shutter.angles[0],shutter.angles[1] + 180,shutter.angles[2]), 0.1);
	}

	wait 0.2;
	for(i = 0;i < leftshutters.size;i++)
	{
		leftshutters[i].startyaw = leftshutters[i].angles[1];
	}

	rightshutters = getentarray("shutter_right", "targetname");
	addshutters = getentarray("shutter_left_open", "targetname");
	for(i = 0;i < addshutters.size;i++)
	{
		rightshutters[rightshutters.size] = addshutters[i];
	}

	addshutters = getentarray("shutter_right_closed", "targetname");
	for(i = 0;i < addshutters.size;i++)
	{
		rightshutters[rightshutters.size] = addshutters[i];
	}

	for(i = 0;i < rightshutters.size;i++)
	{
		rightshutters[i].startyaw = rightshutters[i].angles[1];
	}

	addshutters = undefined;
	winddirection = "left";
	for(;;)
	{
		common_scripts\utility::array_levelthread(leftshutters, ::shutterwanderleft, winddirection);
		common_scripts\utility::array_levelthread(rightshutters, ::shutterwanderright, winddirection);
		level waittill("wind blows", winddirection);
	}
}

windcontroller()
{
	for(;;)
	{
		winddirection = "left";
		if(randomint(100) > 50)
		{
			winddirection = "right";
		}

		level notify("wind blows", winddirection);
		wait 2 + randomfloat(10);
	}
}

shutterwanderleft(shutter, winddirection)
{
	level.inc++;
	level endon("wind blows");
	newyaw = shutter.startyaw;
	if(winddirection == "left")
	{
		newyaw = newyaw + 179.9;
	}

	newtime = 0.2;
	shutter rotateto((shutter.angles[0],newyaw,shutter.angles[2]), newtime);
	wait newtime + 0.1;
	for(;;)
	{
		rot = randomint(80);
		if(randomint(100) > 50)
		{
			rot = rot * -1;
		}

		newyaw = shutter.angles[1] + rot;
		altyaw = shutter.angles[1] + rot * -1;
		if(newyaw < shutter.startyaw || newyaw > shutter.startyaw + 179)
		{
			newyaw = altyaw;
		}

		dif = abs(shutter.angles[1] - newyaw);
		newtime = dif * 0.02 + randomfloat(2);
		if(newtime < 0.3)
		{
			newtime = 0.3;
		}

		shutter rotateto((shutter.angles[0],newyaw,shutter.angles[2]), newtime, newtime * 0.5, newtime * 0.5);
		wait newtime;
	}
}

shutterwanderright(shutter, winddirection)
{
	level.inc++;
	level endon("wind blows");
	newyaw = shutter.startyaw;
	if(winddirection == "left")
	{
		newyaw = newyaw + 179.9;
	}

	newtime = 0.2;
	shutter rotateto((shutter.angles[0],newyaw,shutter.angles[2]), newtime);
	wait newtime + 0.1;
	for(;;)
	{
		rot = randomint(80);
		if(randomint(100) > 50)
		{
			rot = rot * -1;
		}

		newyaw = shutter.angles[1] + rot;
		altyaw = shutter.angles[1] + rot * -1;
		if(newyaw < shutter.startyaw || newyaw > shutter.startyaw + 179)
		{
			newyaw = altyaw;
		}

		dif = abs(shutter.angles[1] - newyaw);
		newtime = dif * 0.02 + randomfloat(2);
		if(newtime < 0.3)
		{
			newtime = 0.3;
		}

		shutter rotateto((shutter.angles[0],newyaw,shutter.angles[2]), newtime, newtime * 0.5, newtime * 0.5);
		wait newtime;
	}
}

wirewander(wire)
{
	origins = getentarray(wire.target, "targetname");
	org1 = origins[0].origin;
	org2 = origins[1].origin;
	angles = vectortoangles(org1 - org2);
	ent = spawn("script_model", (0,0,0));
	ent.origin = common_scripts\utility::vector_multiply(org1, 0.5) + common_scripts\utility::vector_multiply(org2, 0.5);
	ent.angles = angles;
	wire linkto(ent);
	rottimer = 2;
	rotrange = 0.9;
	dist = 4 + randomfloat(2);
	ent rotateroll(dist * 0.5, 0.2);
	wait 0.2;
	for(;;)
	{
		rottime = rottimer + randomfloat(rotrange) - rotrange * 0.5;
		ent rotateroll(dist, rottime, rottime * 0.5, rottime * 0.5);
		wait rottime;
		ent rotateroll(dist * -1, rottime, rottime * 0.5, rottime * 0.5);
		wait rottime;
	}
}