package com.examples.youtubeapi
{
	import com.examples.youtubeapi.controller.CommentsFeedCommand;
	import com.examples.youtubeapi.controller.SearchVideoCommand;
	import com.examples.youtubeapi.controller.VideoThumbnailClickCommand;
	import com.examples.youtubeapi.controller.VideosFeedCommand;
	import com.examples.youtubeapi.service.CommentsFeedService;
	import com.examples.youtubeapi.service.VideosFeedService;
	import com.examples.youtubeapi.signals.CommentsFeedSignal;
	import com.examples.youtubeapi.signals.SearchVideoSignal;
	import com.examples.youtubeapi.signals.VideoThumbnailClickSignal;
	import com.examples.youtubeapi.signals.VideosFeedSignal;
	import com.examples.youtubeapi.view.components.CommentsArea;
	import com.examples.youtubeapi.view.components.MostPopularArea;
	import com.examples.youtubeapi.view.components.SearchResultsArea;
	import com.examples.youtubeapi.view.components.SearchVideo;
	import com.examples.youtubeapi.view.components.SuggestionsArea;
	import com.examples.youtubeapi.view.itemrenderer.VideoThumbnailRenderer;
	import com.examples.youtubeapi.view.mediator.CommentsAreaMediator;
	import com.examples.youtubeapi.view.mediator.MostPopularAreaMediator;
	import com.examples.youtubeapi.view.mediator.SearchResultsAreaMediator;
	import com.examples.youtubeapi.view.mediator.SearchVideoMediator;
	import com.examples.youtubeapi.view.mediator.SuggestionsAreaMediator;
	import com.examples.youtubeapi.view.mediator.VideoThumbnailRendererMediator;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.SignalContext;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Bootstrap, Main Application
	 */
	
	public class MainContext extends SignalContext
	{
		public function MainContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			//feeds
			injector.mapSingleton(VideosFeedService);
			injector.mapSingleton(CommentsFeedService);
			
			//signals and commands
			signalCommandMap.mapSignalClass(VideoThumbnailClickSignal, VideoThumbnailClickCommand);
			signalCommandMap.mapSignalClass(VideosFeedSignal, VideosFeedCommand);
			signalCommandMap.mapSignalClass(CommentsFeedSignal, CommentsFeedCommand);
			signalCommandMap.mapSignalClass(SearchVideoSignal, SearchVideoCommand);
			
			//views and components
			mediatorMap.mapView(VideoThumbnailRenderer, VideoThumbnailRendererMediator);
			mediatorMap.mapView(SearchResultsArea, SearchResultsAreaMediator);
			mediatorMap.mapView(MostPopularArea, MostPopularAreaMediator);
			mediatorMap.mapView(CommentsArea, CommentsAreaMediator);
			mediatorMap.mapView(SearchVideo, SearchVideoMediator);
			mediatorMap.mapView(SuggestionsArea, SuggestionsAreaMediator);
			mediatorMap.mapView(YouTubeAPIExample, MainMediator);
		}
	}
}