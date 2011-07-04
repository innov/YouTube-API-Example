package com.examples.youtubeapi
{
	import ca.newcommerce.youtube.events.StandardVideoFeedEvent;
	import ca.newcommerce.youtube.events.VideoDataEvent;
	import ca.newcommerce.youtube.events.VideoFeedEvent;
	import ca.newcommerce.youtube.feeds.VideoFeed;
	import ca.newcommerce.youtube.reference.SearchOrder;
	import ca.newcommerce.youtube.reference.SearchTime;
	import ca.newcommerce.youtube.reference.SearchType;
	import ca.newcommerce.youtube.webservice.YouTubeDataClient;
	import ca.newcommerce.youtube.webservice.YouTubeFeedClient;
	
	import com.examples.youtubeapi.service.CommentsFeedService;
	import com.examples.youtubeapi.service.VideosFeedService;
	import com.examples.youtubeapi.signals.SearchVideoSignal;
	import com.examples.youtubeapi.signals.VideoThumbnailClickSignal;
	
	import flash.events.Event;
	import flash.system.Security;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Main Application File
	 * Access services and listens for signals
	 */
	
	public class MainMediator extends Mediator
	{
		[Inject]
		public var view:YouTubeAPIExample;
		
		[Inject]
		public var commentsService:CommentsFeedService;
		
		[Inject]
		public var videosFeedService:VideosFeedService;
		
		[Inject]
		public var searchVideoSignal:SearchVideoSignal;
		
		[Inject]
		public var videoThumbnailClicked:VideoThumbnailClickSignal;
		
		private var _searchTerm:String;
		
		public function MainMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			initAPI();
		}

		/**
		 * Initialize, add search signal
		 * get the most popular videos from the API
		 */	
		private function initAPI():void
		{
			Security.allowDomain('youtube.com', 'www.youtube.com', 'http://www.youtube.com');
			
			//get the most popular videos
			var clientFeed:YouTubeFeedClient = YouTubeFeedClient.getInstance();
			clientFeed.getStandardFeed(SearchType.STD_TOP_RATED, SearchTime.TIME_TODAY);
			clientFeed.addEventListener(StandardVideoFeedEvent.STANDARD_VIDEO_DATA_RECEIVED, onMostPopularDataReceived);
			
			//when you start a search
			searchVideoSignal.add(onVideoSearch);
			
			//when you click a video thumbnail
			videoThumbnailClicked.add(onVideoThumbnailClicked);
		}

		/**
		 * 
		 * The user has clicked a thumbnail, and wants to see the video
		 * Change to the Watching states and get the video data
		 */		
		private function onVideoThumbnailClicked(videoId:String):void
		{
			var fixedVideoID:String = videoId.substr(videoId.lastIndexOf('/') + 1);
			var clientData:YouTubeDataClient = YouTubeDataClient.getInstance();
			var clientFeed:YouTubeFeedClient = YouTubeFeedClient.getInstance();
			
			view.currentState = 'Watching';
			view.moviePlayer.videoId = fixedVideoID;
			
			clientFeed.addEventListener(VideoDataEvent.VIDEO_INFO_RECEIVED, onVideoDataReceived);
			clientFeed.addEventListener(VideoFeedEvent.RELATED_VIDEOS_DATA_RECEIVED, onRelatedVideosDataReceived);
			clientFeed.getVideo(fixedVideoID);
			clientFeed.getRelatedVideos(fixedVideoID);
		}
		
		/**
		 * When you do a search, change to the SearchResults state
		 * Make the search on the YouTube API
		 */		
		private function onVideoSearch(searchTerm:String):void
		{
			_searchTerm = searchTerm;
			
			view.currentState = 'SearchResults';
			view.searchResultsLabel.text = 'Search Results for: ' + _searchTerm;
			if (view.moviePlayer) view.moviePlayer.stopVideo();
			
			//search in YouTube API
			var clientFeed:YouTubeFeedClient = YouTubeFeedClient.getInstance();
			clientFeed.getVideos(_searchTerm);
			clientFeed.addEventListener(VideoFeedEvent.VIDEO_DATA_RECEIVED, onVideoSearchDataReceived);
		}

		/**
		 * 
		 * Parse the results from the search
		 */		
		private function onVideoSearchDataReceived(event:VideoFeedEvent):void
		{
			videosFeedService.parseVideoFeed(event.feed.id + '?q=' + _searchTerm);
		}

		/**
		 * 
		 * Parse the results from the most popular videos
		 */	
		private function onMostPopularDataReceived(event:StandardVideoFeedEvent):void
		{
			videosFeedService.parseVideoFeed(event.feed.id);
		}
			
		/**
		 * 
		 * Parse the results from the related videos, of a video that the user selected
		 */		
		private function onRelatedVideosDataReceived(event:VideoFeedEvent):void
		{
			videosFeedService.parseVideoFeed(event.feed.id);
		}
		
		/**
		 * 
		 * The data of the video clicked has been received
		 * Parse the comments, and set the title of the video
		 */		
		private function onVideoDataReceived(event:VideoDataEvent):void
		{
			view.currentVideoTitle.text = event.video.title;
			commentsService.parseCommentsFeed(event.video.commentFeedUri);
		}
	}
}