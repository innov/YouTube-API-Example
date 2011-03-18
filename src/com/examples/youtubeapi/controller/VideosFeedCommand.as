package com.examples.youtubeapi.controller
{
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Actions to take when videos are received from the feed.
	 * Videos are a bunch of Objects Inside an Array Collection
	 */
	
	public class VideosFeedCommand extends SignalCommand
	{
		[Inject]
		public var videos:ArrayCollection;
		
		public function VideosFeedCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//trace(videos);
		}
	}
}