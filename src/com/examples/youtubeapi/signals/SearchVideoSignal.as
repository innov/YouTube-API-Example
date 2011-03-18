package com.examples.youtubeapi.signals
{
	import org.osflash.signals.Signal;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Carries the search string...
	 */
	
	public class SearchVideoSignal extends Signal
	{
		public function SearchVideoSignal(...parameters)
		{
			super(String);
		}
	}
}