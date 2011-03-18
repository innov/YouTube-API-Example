package com.examples.youtubeapi.controller
{
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Actions to take when a video search is performed (Hit the search button!)
	 */
	
	public class SearchVideoCommand extends SignalCommand
	{
		[Inject]
		public var searchString:String;
		
		public function SearchVideoCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//trace('I searched: ' + searchString);
		}
	}
}