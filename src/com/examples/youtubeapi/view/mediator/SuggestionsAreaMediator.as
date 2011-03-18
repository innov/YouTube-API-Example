package com.examples.youtubeapi.view.mediator
{
	import com.examples.youtubeapi.signals.VideosFeedSignal;
	import com.examples.youtubeapi.view.components.SuggestionsArea;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Display suggested videos
	 */
	
	public class SuggestionsAreaMediator extends Mediator
	{
		[Inject]
		public var view:SuggestionsArea;
		
		[Inject]
		public var videosFeedSignal:VideosFeedSignal;
		
		public function SuggestionsAreaMediator()
		{
			super();
		}
		
		/**
		 * When the videos are received
		 * 
		 */		
		override public function onRegister():void
		{
			videosFeedSignal.add(onSuggestionsFeedReady);
		}
		
		/**
		 * 
		 * Display the video thumbnails in the List
		 * 
		 */		
		private function onSuggestionsFeedReady(suggestions:ArrayCollection):void
		{
			view.currentSuggestions.dataProvider = suggestions;
		}
	}
}