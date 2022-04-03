import 'dart:core';

class en {
  static Map<String, String> keys() {
    return {
      /// common
      'cancel': "Cancel",
      'OK': "OK",
      'success': "Success",
      'error': "Error",
      'failed': "Failed",
      'reload': 'Reload',
      'noMoreData': 'No More Data',
      'noData': 'No Data',
      'operationFailed': 'Operation Failed',
      'needLoginToOperate': 'Need Log In To Operate',
      'hasCopiedToClipboard': "Has Copied To Clipboard",
      'networkError': "Network Error",

      'home': "Home",
      'gallery': "Gallery",
      'setting': 'Setting',

      /// login page
      'login': 'Login',
      'logout': 'Logout',
      'passwordLogin': 'Password Login',
      'cookieLogin': 'Cookie Login',
      'youHaveLoggedInAs': 'Hello:   ',
      'cookieIsBlack': 'Cookie is Black',
      'cookieFormatError': 'Cookie Format Error',
      'invalidCookie': 'Invalid Cookie',
      'loginFail': 'Login Failed',
      'userName': 'UserName',
      'password': 'Password',
      'needCaptcha': 'Need captcha, please login via cookie or web again.',
      'userNameOrPasswordMismatch': 'Username or password mismatch',
      'copyCookies': 'Copy Cookies',
      'tap2Copy': 'Tap to Copy',

      /// request
      'sadPanda': 'Sad Panda: No Data',

      /// gallery page
      'getGallerysFailed': "Get Gallerys Failed",
      'refreshGalleryFailed': 'Refresh Gallery Failed',
      'tabBarSetting': 'TabBar Setting',

      /// details page
      'read': 'Read',
      'download': 'Download',
      'favorite': 'Favorite',
      'rating': 'Rating',
      'torrent': 'Torrent',
      'archive': 'Archive',
      'statistic': 'Statistic',
      'similar': 'Similar',
      'downloading': "Downloading",
      'resume': "Resume",
      'pause': 'Pause',
      'finished': 'Finished',
      'submit': 'Submit',
      'chooseFavorite': 'Choose Favorite',
      'uploader': 'Uploader',
      'allComments': 'All Comments',
      'noComments': 'No Comments',
      'getGalleryDetailFailed': 'Get Gallery Detail Failed',
      'invisible2User': 'This Gallery is invisible to You',
      'invisibleHints': 'This gallery is removed or unavailable.',
      'refreshGalleryDetailsFailed': 'Refresh Gallery Details Failed',
      'failToGetThumbnails': "Fail To Get Thumbnails",
      'favoriteGalleryFailed': "Favorite Gallery Failed",
      'ratingFailed': 'Rating Failed',
      'voteTagFailed': 'Vote Tag Failed',
      'beginToDownload': 'Begin To Download',
      'resumeDownload': 'Resume Download',
      'pauseDownload': 'Pause Download',

      /// comment page
      'newComment': 'New Comment',
      'commentTooShort': 'Comment is Too Short',
      'sendCommentFailed': 'Send Comment Failed',
      'voteCommentFailed': 'Vote Comment Failed',

      /// EHImage
      'reloadImage': "Reload Image",

      /// read page
      'parsingPage': "Parsing Page",
      'parsingURL': "Parsing URL",
      'parsePageFailed': "Parse Page Failed",
      'parseURLFailed': "Parse URL Failed",
      'loading': "Loading",

      /// setting page
      'account': 'Account',
      'EH': 'EH',
      'style': 'Style',
      'advanced': 'Advanced',
      'about': 'About',
      'accountSetting': 'Account Setting',
      'styleSetting': 'Style Setting',
      'advancedSetting': 'Advanced Setting',
      'ehSetting': 'EH Site Setting',
      'readSetting': 'Read Setting',
      'downloadSetting': 'Download Setting',

      /// eh setting page
      'site': 'Site',
      'siteSetting': 'Site Setting',

      /// style setting page
      'enableTagZHTranslation': 'Translate tag name into chinese',
      'version': 'Version',
      'downloadTagTranslationHint': 'Downloading data..., downloaded: ',
      'themeMode': 'Theme Mode',
      'dark': 'Dark',
      'light': 'Light',
      'followSystem': 'Follow System',
      'listStyle': 'Gallery List Style',
      'listWithoutTags': 'List(Without Tags)',
      'listWithTags': 'List',
      'waterfallFlowWithImageOnly': 'Waterfall Flow(Image Only)',
      'waterfallFlowWithImageAndInfo': 'Waterfall Flow',
      'coverStyle': 'Cover Style',
      'cover': 'Cover',
      'adaptive': 'Adaptive',
      'enableTabletLayout': 'Enable Tablet Layout',

      /// advanced setting page
      'enableDomainFronting': 'Enable Domain Fronting',
      'enableLogging': 'Enable Logging',
      'openLog': 'Open Log',
      'clearLogs': 'Clear Logs',
      'clearImagesCache': 'Clear Images Cache',

      /// read setting page
      'readDirection': 'Read Direction',
      'top2bottom': 'Top to Bottom',
      'left2right': 'Left to Right',
      'right2left': 'Right to Left',
      'enablePageTurnAnime': 'Enable Page Turn Anime',
      'preloadDistanceInOnlineMode': 'Preload Distance(Online)',
      'ScreenHeight': 'Screen Height',
      'preloadPageCount': 'Preload Page Count',

      /// log page
      'logList': 'Log List',

      /// download page
      'delete': 'Delete',

      /// search dialog
      'searchConfig': 'Search Config',
      'addTabBar': 'Add Tab Bar',
      'updateTabBar': 'Update Tab Bar',
      'filterConfig': 'Filter Config',
      'tabBarName': 'TabBar Name',
      'searchType': 'Search Type',
      'popular': 'Popular',
      'ranklist': 'Ranklist',
      'watched': 'Watched',
      'history': 'History',
      'keyword': 'Keyword',
      'searchGalleryName': 'Search Gallery Name',
      'searchGalleryTags': 'Search Gallery Tags',
      'searchGalleryDescription': 'Search Gallery Description',
      'searchExpungedGalleries': 'Search Expunged Galleries',
      'onlyShowGalleriesWithTorrents': 'Only Show Galleries With Torrents',
      'searchLowPowerTags': 'Search LowPower Tags',
      'searchDownVotedTags': 'Search DownVoted Tags',
      'pageAtLeast': 'Page At Least',
      'pageAtMost': 'Page At Most',
      'pagesBetween': 'Pages Between',
      'to': 'to',
      'minimumRating': 'Minimum Rating',
      'disableFilterForLanguage': 'Disable Filter For Language',
      'disableFilterForUploader': 'Disable Filter For Uploader',
      'disableFilterForTags': 'Disable Filter For Tags',
      'searchName': 'Search Name',
      'searchTags': 'Search Tags',
      'searchNote': 'Search Note',
      'allTime': 'All-Time',
      'year': 'Year',
      'month': 'Month',
      'day': 'Day',

      /// ranklist view
      'getRanklistFailed': 'Get Ranklist Failed',

      /// search page
      'search': 'Search',
      'searchFailed': 'Search Failed',
      'fileSearchFailed': 'File Search Failed',

      /// about page
      'author': 'Author',

      /// download setting page
      'downloadPath': 'Download Path',
      'downloadTaskConcurrency': 'Download Task Concurrency',
      'needRestart': 'Need Restart',
      'downloadTimeout': 'Download Timeout',

      /// tag namespace
      'language': 'Language',
      'artist': 'Artist',
      'character': 'Character',
      'female': 'Female',
      'male': 'Male',
      'parody': 'Parody',
      'group': 'Group',
      'mixed': 'Mixed',
      'Coser': 'Coser',
      'cosplayer': 'Cosplayer',
      'reclass': 'Reclass',
      'temp': 'Temp',
      'other': 'Other',
    };
  }
}
