package com.examples.youtubeapi.view.mediator
{
	import com.examples.youtubeapi.signals.VideosFeedSignal;
	import com.examples.youtubeapi.view.components.MostPopularArea;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Display most popular videos
	 */
	
	public class MostPopularAreaMediator extends Mediator
	{
		[Inject]
		public var view:MostPopularArea;
		
		[Inject]
		public var videosFeedSignal:VideosFeedSignal;
		
		public function MostPopularAreaMediator()
		{
			super();
		}
		
		/**
		 * When the videos are received... 
		 * 
		 */		
		override public function onRegister():void
		{
			videosFeedSignal.add(onMostPopularVideosDataReceived);
		}
		
		/**
		 * 
		 * Display the video thumbnails in the List
		 * 
		 */		
		private function onMostPopularVideosDataReceived(videos:ArrayCollection):void
		{
			view.mostPopularVideos.dataProvider = videos;
		}
	}
}