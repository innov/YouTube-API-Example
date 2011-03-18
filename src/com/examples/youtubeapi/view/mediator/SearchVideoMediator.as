package com.examples.youtubeapi.view.mediator
{
	import com.examples.youtubeapi.signals.SearchVideoSignal;
	import com.examples.youtubeapi.view.components.SearchVideo;
	
	import flash.events.MouseEvent;
	
	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.Button;
	import spark.components.TextInput;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Displays a search bar.
	 */
	
	public class SearchVideoMediator extends Mediator
	{
		[Inject]
		public var view:SearchVideo;
		
		[Inject]
		public var searchVideoSignal:SearchVideoSignal;
		
		private var _searchButton:Button;
		private var _searchField:TextInput;
		private var _searchSignal:NativeSignal;
		
		public function SearchVideoMediator()
		{
			super();
		}
		
		/**
		 * Component objects references
		 * Click signal on the submit button 
		 * 
		 */		
		override public function onRegister():void
		{
			_searchButton = view.submitSearchButton;
			_searchField = view.searchField;
			
			_searchSignal = new NativeSignal(_searchButton, MouseEvent.CLICK, MouseEvent);
			_searchSignal.add(onSearchButtonClick);
		}
		
		/**
		 * 
		 * When a search is made.
		 * Dispatch the search term, to make a search
		 */		
		private function onSearchButtonClick(event:MouseEvent):void
		{
			var searchValue:String = _searchField.text;
			searchVideoSignal.dispatch(searchValue);
		}
		
		
	}
}