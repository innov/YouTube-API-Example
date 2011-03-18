package com.examples.youtubeapi.signals
{
	import org.osflash.signals.Signal;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Carries the ID of the video clicked
	 */
	
	public class VideoThumbnailClickSignal extends Signal
	{
		public function VideoThumbnailClickSignal(...parameters)
		{
			super(String);
		}
	}
}