/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_teargrenades.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 9
 * Decompile Time: 1 ms
 * Timestamp: 10/28/2023 12:13:53 AM
*******************************************************************/

#include maps/mp/gametypes/_perplayer;

//Function Number: 1
main()
{
	level.tearradius = 170;
	level.tearheight = 128;
	level.teargasfillduration = 7;
	level.teargasduration = 23;
	level.tearsufferingduration = 3;
	level.teargrenadetimer = 4;
	precacheshellshock("teargas");
	fgmonitor = maps/mp/gametypes/_perplayer::init("tear_grenade_monitor",::startmonitoringtearusage,::stopmonitoringtearusage);
	maps/mp/gametypes/_perplayer::enable(fgmonitor);
}

//Function Number: 2
startmonitoringtearusage()
{
	self thread monitortearusage();
}

//Function Number: 3
stopmonitoringtearusage(disconnected)
{
	self notify("stop_monitoring_tear_usage");
}

//Function Number: 4
monitortearusage()
{
	self endon("stop_monitoring_tear_usage");
	wait(0.05);
	if(!(self hasweapon("tear_grenade_mp")))
	{
		return;
	}

	prevammo = self getammocount("tear_grenade_mp");
	while(1)
	{
		ammo = self getammocount("tear_grenade_mp");
		if(ammo < prevammo)
		{
			num = prevammo - ammo;
/#
#/
			for(i = 0;i < num;i++)
			{
				grenades = getentarray("grenade","classname");
				bestdist = undefined;
				bestg = undefined;
				for(g = 0;g < grenades.size;g++)
				{
					if(!(IsDefined(grenades[g].teargrenade)))
					{
						dist = distance(grenades[g].origin,48 + VectorScale((0,0,1)));
						if(!IsDefined(bestdist) || dist < bestdist)
						{
							bestdist = dist;
							bestg = g;
						}
					}
				}

				if(IsDefined(bestdist))
				{
					grenades[bestg].teargrenade = 1;
					grenades[bestg] thread teargrenade_think(self.team);
				}
			}
		}

		prevammo = ammo;
		wait(0.05);
	}
}

//Function Number: 5
teargrenade_think(team)
{
	wait(level.teargrenadetimer);
	ent = spawnstruct();
	ent thread tear(self.origin);
}

//Function Number: 6
tear(pos)
{
	trig = spawn("trigger_radius",pos,0,level.tearradius,level.tearheight);
	starttime = GetTime();
	self thread teartimer();
	self endon("tear_timeout");
	while(1)
	{
		trig waittill("trigger",player);
		if(player.sessionstate != "playing")
		{
			continue;
		}

		time = GetTime() - starttime / 1000;
		currad = level.tearradius;
		curheight = level.tearheight;
		if(time < level.teargasfillduration)
		{
			currad = currad * time / level.teargasfillduration;
			curheight = curheight * time / level.teargasfillduration;
		}

		offset = 32 + VectorScale((0,0,1)) - pos;
		offset2d = (offset[0],offset[1],0);
		if(lengthsquared(offset2d) > currad * currad)
		{
			continue;
		}

		if(player.origin[2] - pos[2] > curheight)
		{
			continue;
		}

		player.teargasstarttime = GetTime();
		if(!(IsDefined(player.teargassuffering)))
		{
			player thread teargassuffering();
		}
	}
}

//Function Number: 7
teartimer()
{
	wait(level.teargasduration);
	self notify("tear_timeout");
}

//Function Number: 8
teargassuffering()
{
	self endon("death");
	self endon("disconnect");
	self.teargassuffering = 1;
	if(self mayapplyscreeneffect())
	{
		self shellshock("teargas",60);
	}

	while(1)
	{
		if(GetTime() - self.teargasstarttime > level.tearsufferingduration * 1000)
		{
			break;
		}

		wait(1);
	}

	self shellshock("teargas",1);
	if(self mayapplyscreeneffect())
	{
		self.teargassuffering = undefined;
	}
}

//Function Number: 9
drawcylinder(pos,rad,height)
{
	time = 0;
	while(1)
	{
		currad = rad;
		curheight = height;
		if(time < level.teargasfillduration)
		{
			currad = currad * time / level.teargasfillduration;
			curheight = curheight * time / level.teargasfillduration;
		}

		for(r = 0;r < 20;r++)
		{
			theta = r / 20 * 360;
			theta2 = r + 1 / 20 * 360;
			line(pos + (cos(theta) * currad,sin(theta) * currad,0),pos + (cos(theta2) * currad,sin(theta2) * currad,0));
			line(pos + (cos(theta) * currad,sin(theta) * currad,curheight),pos + (cos(theta2) * currad,sin(theta2) * currad,curheight));
			line(pos + (cos(theta) * currad,sin(theta) * currad,0),pos + (cos(theta) * currad,sin(theta) * currad,curheight));
		}

		time = time + 0.05;
		if(time > level.teargasduration)
		{
			break;
		}

		wait(0.05);
	}
}