#include maps\_vehicle;
#include maps\_utility;
#using_animtree ("vehicles");
main()
{
	if(IsDefined(self.script_string) && self.script_string == "sink_me")
	{
		level._effect["sink_fx" + self.vehicletype] = LoadFX("vehicle/vexplosion/fx_vexp_nvaboat_machinegun");
		level._effect["explo_fx" + self.vehicletype] = LoadFX("vehicle/vexplosion/fx_vexp_nvaboat");
		level.vehicle_death_thread[self.vehicletype] = ::delete_and_sink_fx;
	}
}
delete_and_sink_fx()
{
	self notify( "nodeath_thread" );
	if(!IsDefined(self.weapon_last_damage))
	{
		self.weapon_last_damage = "hind_rockets";
	}
	if(self.weapon_last_damage == "hind_rockets")
	{
		PlayFX(level._effect["explo_fx" + self.vehicletype], self.origin, AnglesToForward(self.angles));
		self PlaySound("evt_nva_patrol_boat_explo");
	}
	else
	{
		PlayFX(level._effect["sink_fx" + self.vehicletype], self.origin, AnglesToForward(self.angles));
		self PlaySound("evt_nva_patrol_boat_sink");
	}
	waittillframeend;
	self Delete();
} 