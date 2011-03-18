package com.examples.youtubeapi.controller
{
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Actions to take when a video thumbnail is clicked
	 * ID of the video clicked
	 */
	
	public class VideoThumbnailClickCommand extends SignalCommand
	{
		[Inject]
		public var videoId:String;
		
		public function VideoThumbnailClickCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//
		}
	}
}