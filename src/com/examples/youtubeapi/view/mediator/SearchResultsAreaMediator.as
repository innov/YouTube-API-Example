package com.examples.youtubeapi.view.mediator
{
	import com.examples.youtubeapi.signals.VideosFeedSignal;
	import com.examples.youtubeapi.view.components.SearchResultsArea;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Display videos from a search
	 */
	
	public class SearchResultsAreaMediator extends Mediator
	{
		[Inject]
		public var view:SearchResultsArea;
		
		[Inject]
		public var videosFeedSignal:VideosFeedSignal;
		
		public function SearchResultsAreaMediator()
		{
			super();
		}
		
		/**
		 * When the videos are received... 
		 * 
		 */		
		override public function onRegister():void
		{
			videosFeedSignal.add(onSearchVideosDataReceived);
		}
		
		/**
		 * 
		 * Display the video thumbnails in the List
		 * 
		 */		
		private function onSearchVideosDataReceived(videos:ArrayCollection):void
		{
			view.searchResultsVideos.dataProvider = videos;
		}
	}
}