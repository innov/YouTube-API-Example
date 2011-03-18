package com.examples.youtubeapi.controller
{
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Actions to take when the comments from a video are recieved
	 */
	
	public class CommentsFeedCommand extends SignalCommand
	{
		[Inject]
		public var comments:ArrayCollection;
		
		public function CommentsFeedCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//trace(comments);
		}
	}
}