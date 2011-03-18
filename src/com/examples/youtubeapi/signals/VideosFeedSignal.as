package com.examples.youtubeapi.signals
{
	import mx.collections.ArrayCollection;
	
	import org.osflash.signals.Signal;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Carries the videos from a feed
	 */
	
	public class VideosFeedSignal extends Signal
	{
		public function VideosFeedSignal(...parameters)
		{
			super(ArrayCollection);
		}
	}
}