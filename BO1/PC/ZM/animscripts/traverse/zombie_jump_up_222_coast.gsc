#include animscripts\utility;
#include animscripts\traverse\zombie_shared;
#using_animtree ("generic_human");
main()
{
	if( IsDefined( self.is_zombie ) && self.is_zombie )
	{
		if ( !self.isdog )
		{
			if ( self.has_legs == true )
			{
				if ( self.animname == "director_zombie" )
				{
					jump_up_director();
				}
				else if( self.animname == "quad_zombie" )
				{
					jump_up_quad();
				}
				else if ( self.animname == "monkey_zombie" )
				{
					jump_up_monkey();
				}
				else
				{
					jump_up_zombie();
				}
			}
			else
			{
				jump_up_crawler();
			}
		}
		else
		{
			dog_jump_up(222, 7);
		}
	}
}
jump_up_zombie()
{
	traverseData = [];
	traverseData[ "traverseAnim" ] = %ai_zombie_jump_up_222;
	DoTraverse( traverseData );
}
jump_up_director()
{
	traverseData = [];
	traverseData[ "traverseAnim" ] = %ai_zombie_boss_jump_up_222_coast;
	DoTraverse( traverseData );
}
jump_up_quad()
{
	traverseData = [];
	traverseData[ "traverseAnim" ] = %ai_zombie_jump_up_222;
	DoTraverse( traverseData );
}
jump_up_monkey()
{
	traverseData = [];
	traverseData[ "traverseAnim" ] = %ai_zombie_monkey_jump_up_222;
	DoTraverse( traverseData );
}
jump_up_crawler()
{
	traverseData = [];
	traverseData[ "traverseAnim" ] = %ai_zombie_crawl_jump_up_222_coast;
	DoTraverse( traverseData );
}
 