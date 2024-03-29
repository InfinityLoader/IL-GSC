#include animscripts\utility;
#include animscripts\traverse\zombie_shared;
#using_animtree ("generic_human");
main()
{
	if( IsDefined( self.is_zombie ) && self.is_zombie )
	{
		if ( self.has_legs == true )
		{
			if ( self.animname == "monkey_zombie" )
			{
				jump_down_monkey();
			}
			else
			{
				jump_down_zombie();
			}
		}
		else
		{
			jump_down_crawler();
		}
	}
}
jump_down_zombie()
{
	traverseData = [];
	traverseData[ "traverseAnim" ] = %ai_zombie_jump_down_waterfall;
	DoTraverse( traverseData );
}
jump_down_crawler()
{
	traverseData = [];
	traverseData[ "traverseAnim" ] = %ai_zombie_crawl_jump_down_waterfall;
	DoTraverse( traverseData );
}
jump_down_monkey()
{
	traverseData = [];
	traverseData[ "traverseAnim" ] = %ai_zombie_monkey_jump_down_waterfall;
	DoTraverse( traverseData );
}
 