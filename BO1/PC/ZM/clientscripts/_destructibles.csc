
#include clientscripts\_utility;
#include clientscripts\_lights;
destructible_thread(client_num)
{
	owner = getlocalplayers()[client_num];
	if(isdefined(owner))
	{
		if(!isdefined(self.script_light_label))
		{
			return;
		}
		self.lights = get_lights_by_label(self.script_light_label);
		if(self.lights.size == 0)
		{
			println("*** Client : Destructable " + self.destructibledef + " at " + self.origin + " cannot find any lights labelled + " + self.script_light_label);
			return;
		}
		level._num_lit_destructibles ++;
		owner endon("disconnect");
		println("Waiting for broken");
		self waittill( "broken", broken_notify );
		println("Got broken.");
		switch_light_mixers(self.lights);
		println("Switched.");
		return;
	}
}
init(client_num)
{
	if(IsSplitScreenHost(client_num))
	{
		level._num_lit_destructibles = 0;
		array_thread( getentarray( client_num, "destructible", "targetname" ), ::destructible_thread, client_num );
		waittillframeend;
		println("*** Client : Lit destructibles " + level._num_lit_destructibles);
	}
} 