package com.examples.youtubeapi.signals
{
	import mx.collections.ArrayCollection;
	
	import org.osflash.signals.Signal;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Carries the comments of a video
	 */
	
	public class CommentsFeedSignal extends Signal
	{
		public function CommentsFeedSignal(...parameters)
		{
			super(ArrayCollection);
		}
	}
}