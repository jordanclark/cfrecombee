component {
	cfprocessingdirective( preserveCase=true );

	function init(
		required string secretKey
	,	required string apiUrl= "https://rapi.recombee.com"
	,	string defaultDatabaseId= ""
	,	numeric httpTimeOut= 120
	,	boolean debug= ( request.debug ?: false )
	,	numeric timeSync= server.recombeeTimeSync ?: 0;
	) {
		this.secretKey= arguments.secretKey;
		this.apiUrl= arguments.apiUrl;
		this.defaultDatabaseId= arguments.defaultDatabaseId;
		this.httpTimeOut= arguments.httpTimeOut;
		this.debug= arguments.debug;
		this.epoch= createDate(1970,1,1);
		this.offSet= getTimeZoneInfo().utcTotalOffset;
		return this;
	}
	
	//  ---------------------------------------------------------------------------------------------------------- 
	//  ITEM METHODS 
	//  https://docs.recombee.com/api.html#items 
	//  ---------------------------------------------------------------------------------------------------------- 

	function addItem(
		string databaseId= this.defaultDatabaseId
	,	required string itemId
	,	array batch
	) {
		return this.runRequest( api= "PUT /{databaseId}/items/{itemId}", argumentCollection= arguments );
	}

	function deleteItem(
		string databaseId= this.defaultDatabaseId
	,	required string itemId
	,	array batch
	) {
		return this.runRequest( api= "DELETE /{databaseId}/items/{itemId}", argumentCollection= arguments );
	}

	function listItems(
		string databaseId= this.defaultDatabaseId
	,	string filter
	,	numeric count= 10
	,	numeric offset= 0
	,	boolean returnProperties= false
	,	string includedProperties
	,	array batch
	) {
		if ( len( arguments.includedProperties ) ) {
			arguments.returnProperties= true;
		}
		return this.runRequest( api= "GET /{databaseId}/items/list/", argumentCollection= arguments );
	}

	//  ---------------------------------------------------------------------------------------------------------- 
	//  ITEM PROPERTIES METHODS 
	//  https://docs.recombee.com/api.html#item-properties 
	//  https://docs.recombee.com/api.html#set-item-values 
	//  ---------------------------------------------------------------------------------------------------------- 

	function addItemProperty(
		string databaseId= this.defaultDatabaseId
	,	required string propertyName
	,	required string type
	,	array batch
	) {
		return this.runRequest( api= "PUT /{databaseId}/items/properties/{propertyName}?type={type}", argumentCollection= arguments );
	}

	function deleteItemProperty(
		string databaseId= this.defaultDatabaseId
	,	required string propertyName
	,	array batch
	) {
		return this.runRequest( api= "DELETE /{databaseId}/items/properties/{propertyName}", argumentCollection= arguments );
	}

	function getItemPropertyInfo(
		string databaseId= this.defaultDatabaseId
	,	required string propertyName
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/items/properties/{propertyName}", argumentCollection= arguments );
	}

	function listItemProperties(
		string databaseId= this.defaultDatabaseId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/items/properties/list/", argumentCollection= arguments );
	}

	function setItemValues(
		string databaseId= this.defaultDatabaseId
	,	required string itemId
	,	required boolean cascadeCreate
	,	array batch
	) {
		arguments[ "!cascadeCreate" ]= arguments.cascadeCreate;
		structDelete( arguments, "cascadeCreate" );
		return this.runRequest( api= "POST /{databaseId}/items/{itemId}", argumentCollection= arguments );
	}

	function getItemValues(
		string databaseId= this.defaultDatabaseId
	,	required string itemId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/items/{itemId}", argumentCollection= arguments );
	}

	//  ---------------------------------------------------------------------------------------------------------- 
	//  USERS METHODS 
	//  https://docs.recombee.com/api.html#users 
	//  ---------------------------------------------------------------------------------------------------------- 

	function addUser(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	array batch
	) {
		return this.runRequest( api= "PUT /{databaseId}/users/{userId}", argumentCollection= arguments );
	}

	function deleteUser(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	array batch
	) {
		return this.runRequest( api= "DELETE /{databaseId}/users/{userId}", argumentCollection= arguments );
	}

	function mergeUser(
		string databaseId= this.defaultDatabaseId
	,	required string targetUserId
	,	required string sourceUserId
	,	boolean cascadeCreate
	,	array batch
	) {
		return this.runRequest( api= "PUT /{databaseId}/users/{targetUserId}/merge/{sourceUserId}", argumentCollection= arguments );
	}

	function listUsers(
		string databaseId= this.defaultDatabaseId
	,	string filter
	,	numeric count= 10
	,	numeric offset= 0
	,	boolean returnProperties= false
	,	string includedProperties
	,	array batch
	) {
		if ( len( arguments.includedProperties ) ) {
			arguments.returnProperties= true;
		}
		return this.runRequest( api= "GET /{databaseId}/users/list/", argumentCollection= arguments );
	}

	//  ---------------------------------------------------------------------------------------------------------- 
	//  USER PROPERTIES METHODS 
	//  https://docs.recombee.com/api.html#user-properties 
	//  https://docs.recombee.com/api.html#values-of-user-properties 
	//  ---------------------------------------------------------------------------------------------------------- 

	function addUserProperty(
		string databaseId= this.defaultDatabaseId
	,	required string propertyName
	,	required string type
	,	array batch
	) {
		return this.runRequest( api= "PUT /{databaseId}/users/properties/{propertyName}?type={type}", argumentCollection= arguments );
	}

	function deleteUserProperty(
		string databaseId= this.defaultDatabaseId
	,	required string propertyName
	,	array batch
	) {
		return this.runRequest( api= "DELETE /{databaseId}/users/properties/{propertyName}", argumentCollection= arguments );
	}

	function getUserPropertyInfo(
		string databaseId= this.defaultDatabaseId
	,	required string propertyName
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/users/properties/{propertyName}", argumentCollection= arguments );
	}

	function listUserProperties(
		string databaseId= this.defaultDatabaseId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/users/properties/list/", argumentCollection= arguments );
	}

	function setUserValues(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	required boolean cascadeCreate
	,	array batch
	) {
		arguments[ "!cascadeCreate" ]= arguments.cascadeCreate;
		structDelete( arguments, "cascadeCreate" );
		return this.runRequest( api= "POST /{databaseId}/users/{userId}", argumentCollection= arguments );
	}

	function getUserValues(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/users/{userId}", argumentCollection= arguments );
	}

	//  ---------------------------------------------------------------------------------------------------------- 
	//  USER-ITEM DETAIL-VIEW METHODS 
	//  https://docs.recombee.com/api.html#detail-views 
	//  ---------------------------------------------------------------------------------------------------------- 

	function addUserDetailView(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	required string itemId
	,	string timestamp
	,	numeric duration
	,	boolean cascadeCreate
	,	array batch
	) {
		arguments.timestamp= this.zDateFormat( arguments.timestamp ?: "" );
		return this.runRequest( api= "POST /{databaseId}/detailviews/", argumentCollection= arguments );
	}

	function deleteUserDetailView(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	required string itemId
	,	string timestamp
	,	array batch
	) {
		arguments.timestamp= this.epothDateFormat( arguments.timestamp ?: "" );
		return this.runRequest( api= "DELETE /{databaseId}/detailviews/", argumentCollection= arguments );
	}

	function listItemDetailViews(
		string databaseId= this.defaultDatabaseId
	,	required string itemId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/items/{itemId}/detailviews/", argumentCollection= arguments );
	}

	function listUserDetailViews(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/users/{userId}/detailviews/", argumentCollection= arguments );
	}

	//  ---------------------------------------------------------------------------------------------------------- 
	//  USER-ITEM PURCHASE METHODS 
	//  https://docs.recombee.com/api.html#purchases 
	//  ---------------------------------------------------------------------------------------------------------- 

	function addUserPurchase(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	required string itemId
	,	string timestamp
	,	boolean cascadeCreate
	,	numeric amount
	,	numeric price
	,	numeric profit
	,	array batch
	) {
		arguments.timestamp= this.zDateFormat( arguments.timestamp ?: "" );
		return this.runRequest( api= "POST /{databaseId}/purchases/", argumentCollection= arguments );
	}

	function deleteUserPurchase(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	required string itemId
	,	string timestamp
	,	array batch
	 ) {
		arguments.timestamp= this.epothDateFormat( arguments.timestamp ?: "" );
		return this.runRequest( api= "DELETE /{databaseId}/purchases/", argumentCollection= arguments );
	}

	function listItemPurchases(
		string databaseId= this.defaultDatabaseId
	,	required string itemId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/items/{itemId}/purchases/"
	,	argumentCollection= arguments );
	}

	function listUserPurchases(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/users/{userId}/purchases/", argumentCollection= arguments );
	}

	//  ---------------------------------------------------------------------------------------------------------- 
	//  USER-ITEM RATING METHODS 
	//  https://docs.recombee.com/api.html#ratings 
	//  ---------------------------------------------------------------------------------------------------------- 

	function addUserRating(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	required string itemId
	,	string timestamp
	,	numeric rating
	,	boolean cascadeCreate
	,	array batch
	) {
		arguments.timestamp= this.zDateFormat( arguments.timestamp ?: "" );
		return this.runRequest( api= "POST /{databaseId}/ratings/", argumentCollection= arguments );
	}

	function deleteUserRating(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	required string itemId
	,	string timestamp
	,	array batch
	) {
		arguments.timestamp= this.epothDateFormat( arguments.timestamp ?: "" );
		return this.runRequest( api= "DELETE /{databaseId}/ratings/", argumentCollection= arguments );
	}

	function listItemRatings(
		string databaseId= this.defaultDatabaseId
	,	required string itemId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/items/{itemId}/ratings/", argumentCollection= arguments );
	}

	function listUserRatings(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/users/{userId}/ratings/", argumentCollection= arguments );
	}

	//  ---------------------------------------------------------------------------------------------------------- 
	//  USER-ITEM CART ADDITION METHODS 
	//  https://docs.recombee.com/api.html#cart-additions 
	//  ---------------------------------------------------------------------------------------------------------- 

	function addUserCartAddition(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	required string itemId
	,	string timestamp
	,	boolean cascadeCreate
	,	numeric amount
	,	numeric price
	,	array batch
	) {
		arguments.timestamp= this.zDateFormat( arguments.timestamp ?: "" );
		return this.runRequest( api= "POST /{databaseId}/cartadditions/", argumentCollection= arguments );
	}

	function deleteUserCartAddition(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	required string itemId
	,	string timestamp
	,	array batch
	) {
		arguments.timestamp= this.epothDateFormat( arguments.timestamp ?: "" );
		return this.runRequest( api= "DELETE /{databaseId}/cartadditions/", argumentCollection= arguments );
	}

	function listItemCartAdditions(
		string databaseId= this.defaultDatabaseId
	,	required string itemId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/items/{itemId}/cartadditions/", argumentCollection= arguments );
	}

	function listUserCartAdditions(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/users/{userId}/cartadditions/", argumentCollection= arguments );
	}

	//  ---------------------------------------------------------------------------------------------------------- 
	//  USER-ITEM BOOKMARK METHODS 
	//  https://docs.recombee.com/api.html#bookmarks 
	//  ---------------------------------------------------------------------------------------------------------- 

	function addUserBookmark(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	required string itemId
	,	string timestamp
	,	boolean cascadeCreate
	,	array batch
	) {
		arguments.timestamp= this.zDateFormat( arguments.timestamp ?: "" );
		return this.runRequest( api= "POST /{databaseId}/bookmarks/", argumentCollection= arguments );
	}

	function deleteUserBookmark(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	required string itemId
	,	string timestamp
	,	array batch
	) {
		arguments.timestamp= this.epothDateFormat( arguments.timestamp ?: "" );
		return this.runRequest( api= "DELETE /{databaseId}/bookmarks/", argumentCollection= arguments );
	}

	function listItemBookmarks(
		string databaseId= this.defaultDatabaseId
	,	required string itemId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/items/{itemId}/bookmarks/", argumentCollection= arguments );
	}

	function listUserBookmarks(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/users/{userId}/bookmarks/", argumentCollection= arguments );
	}

	//  ---------------------------------------------------------------------------------------------------------- 
	//  RECOMMENDATIONS METHODS 
	//  https://docs.recombee.com/api.html#recommendations 
	//  ---------------------------------------------------------------------------------------------------------- 

	function getUserRecommendations(
		string databaseId= this.defaultDatabaseId
	,	required string userId
	,	required numeric count
	,	string filter
	,	string booster
	,	boolean cascadeCreate
	,	string scenario
	,	boolean returnProperties= false
	,	string includedProperties
	,	numeric diversity
	,	string minRelevance
	,	numeric rotationRate
	,	numeric rotationTime
	,	array batch
	) {
		if ( len( arguments.includedProperties ) ) {
			arguments.returnProperties= true;
		}
		return this.runRequest( api= "GET /{databaseId}/users/{userId}/recomms/", argumentCollection= arguments );
	}

	function getItemRecommendations(
		string databaseId= this.defaultDatabaseId
	,	required string itemId
	,	required numeric count
	,	string targetUserId
	,	numeric userImpact
	,	string filter
	,	string booster
	,	boolean cascadeCreate
	,	string scenario
	,	boolean returnProperties= false
	,	string includedProperties
	,	numeric diversity
	,	string minRelevance
	,	numeric rotationRate
	,	numeric rotationTime
	,	array batch
	) {
		if ( len( arguments.includedProperties ) ) {
			arguments.returnProperties= true;
		}
		return this.runRequest( api= "POST /{databaseId}/items/{itemId}/recomms/", argumentCollection= arguments );
	}

	function getItemRecommendations(
		string databaseId= this.defaultDatabaseId
	,	required string itemId
	,	required numeric count
	,	string targetUserId
	,	numeric userImpact
	,	string filter
	,	string booster
	,	boolean cascadeCreate
	,	string scenario
	,	boolean returnProperties= false
	,	string includedProperties
	,	numeric diversity
	,	string minRelevance
	,	numeric rotationRate
	,	numeric rotationTime
	,	array batch
	) {
		if ( len( arguments.includedProperties ) ) {
			arguments.returnProperties= true;
		}
		return this.runRequest( api= "POST /{databaseId}/items/{itemId}/recomms/", argumentCollection= arguments );
	}

	//  ---------------------------------------------------------------------------------------------------------- 
	//  SERIES METHODS 
	//  https://docs.recombee.com/api.html#series-definition 
	//  https://docs.recombee.com/api.html#series-items 
	//  ---------------------------------------------------------------------------------------------------------- 

	function addSeries(
		string databaseId= this.defaultDatabaseId
	,	required string seriesId
	,	array batch
	) {
		return this.runRequest( api= "PUT /{databaseId}/series/{seriesId}", argumentCollection= arguments );
	}

	function deleteSeries(
		string databaseId= this.defaultDatabaseId
	,	required string seriesId
	,	array batch
	) {
		return this.runRequest( api= "DELETE /{databaseId}/series/{seriesId}", argumentCollection= arguments );
	}

	function listSeries(
		string databaseId= this.defaultDatabaseId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/series/list/", argumentCollection= arguments );
	}

	function listSeriesItems(
		string databaseId= this.defaultDatabaseId
	,	required string seriesId
	,	array batch
	) {
		return this.runRequest( api= "GET /{databaseId}/series/{seriesId}/items/", argumentCollection= arguments );
	}

	function insertToSeries(
		string databaseId= this.defaultDatabaseId
	,	required string seriesId
	,	required string itemType
	,	required string itemId
	,	required numeric time
	,	boolean cascadeCreate
	,	array batch
	) {
		return this.runRequest( api= "POST /{databaseId}/series/{seriesId}/items/", argumentCollection= arguments );
	}

	function deleteFromSeries(
		string databaseId= this.defaultDatabaseId
	,	required string seriesId
	,	required string itemType
	,	required string itemId
	,	required numeric time
	,	array batch
	) {
		return this.runRequest( api= "DELETE /{databaseId}/series/{seriesId}/items/", argumentCollection= arguments );
	}

	//  ---------------------------------------------------------------------------------------------------------- 
	//  MISC METHODS 
	//  ---------------------------------------------------------------------------------------------------------- 

	function deleteDatabase(
		string databaseId= this.defaultDatabaseId
	) {
		return this.apiRequest( api= "DELETE /{databaseId}/", argumentCollection= arguments );
	}

	function batch(
		string databaseId= this.defaultDatabaseId
	,	required array requests
		 boolean distinctRecomms
	) {
		var out= this.runRequest( api= "POST /{databaseId}/batch/", argumentCollection= arguments );
		out.batchSuccess= true;
		out.batchErrors= "";
		out.problems= 0;
		if ( out.success && structKeyExists( out, "Response" ) && isArray( out.response ) ) {
			var req= 0;
			var res= 0;
			var x= 0;
			for ( x=1 ; x<=arrayLen( out.response ) ; x++ ) {
				req= arguments.requests[ x ];
				res= out.response[ x ];
				req.success= false;
				if ( isStruct( res ) ) {
					structAppend( req, res, false );
					if ( structKeyExists( req, "code" ) && listFind( "200,201,409", req.code ) ) {
						req.success= true;
					} else if ( structKeyExists( req, "json" ) && isSimpleValue( req.json ) && req.json == "ok" ) {
						req.success= true;
					}
				}
				if ( !req.success ) {
					out.problems += 1;
					out.batchSuccess= false;
					if ( structKeyExists( req, "json" ) && isStruct( req.json ) && structKeyExists( req.json, "error" ) ) {
						out.batchErrors &= req.json.error & "|";
					}
				}
			}
		}
		structDelete( out, "args" );
		return out;
	}

	//  ---------------------------------------------------------------------------------------------------------- 
	//  API / PRIVATE METHODS 
	//  ---------------------------------------------------------------------------------------------------------- 

	function runRequest( required string api, array batch ) {
		if ( structKeyExists( arguments, "batch" ) && isArray( arguments.batch ) ) {
			return this.apiBatchRequest( argumentCollection= arguments );
		} else {
			structDelete( arguments, "batch" );
			return this.apiRequest( argumentCollection= arguments );
		}
	}

	struct function apiRequest( required string api ) {
		var http= {};
		var item= "";
		var out= {
			args= arguments
		,	success= false
		,	error= ""
		,	status= ""
		,	statusCode= 0
		,	response= ""
		,	verb= listFirst( arguments.api, " " )
		,	requestUrl= listRest( arguments.api, " " )
		};
		structDelete( out.args, "api" );
		//  replace {var} in url 
		for ( item in out.args ) {
			//  strip NULL values 
			if ( isNull( out.args[ item ] ) ) {
				structDelete( out.args, item );
			} else if ( isSimpleValue( arguments[ item ] ) && arguments[ item ] == "null" ) {
				arguments[ item ]= javaCast( "null", 0 );
			} else if ( findNoCase( "{#item#}", out.requestUrl ) ) {
				out.requestUrl= replaceNoCase( out.requestUrl, "{#item#}", out.args[ item ], "all" );
				structDelete( out.args, item );
			}
		}
		if ( out.verb == "GET" ) {
			out.requestUrl &= this.structToQueryString( out.args, true );
		} else if ( !structIsEmpty( out.args ) ) {
			out.body= serializeJSON( out.args );
		}
		//  HMAC 
		out.requestUrl &= ( find( "?", out.requestUrl ) ? "&" : "?" );
		out.requestUrl &= "hmac_timestamp=" & ( dateDiff( "s", this.epoch, dateAdd("s", this.offset, now() ) ) + server.recombeeTimeSync );
		out.requestUrl &= "&hmac_sign=" & hashSign( out.requestUrl );
		out.requestUrl= this.apiUrl & out.requestUrl;
		this.debugLog( "API: #uCase( out.verb )#: #out.requestUrl#" );
		if ( structKeyExists( out, "body" ) ) {
			this.debugLog( out.body );
		}
		// this.debugLog( out );
		cftimer( type="debug", label="recombee request" ) {
			cfhttp( charset="UTF-8", throwOnError=false, userAgent="recombee-cfml-api-client/1.6.1", url=out.requestUrl, timeOut=this.httpTimeOut, result="http", method=out.verb ) {
				if ( out.verb == "POST" || out.verb == "PUT" || out.verb == "PATCH" ) {
					cfhttpparam( name="content-type", type="header", value="application/json" );
				}
				if ( structKeyExists( out, "body" ) ) {
					cfhttpparam( type="body", value=out.body );
				}
			}
		}
		// this.debugLog( http );
		out.response= toString( http.fileContent );
		// this.debugLog( out.response );
		out.statusCode= http.responseHeader.Status_Code ?: 500;
		this.debugLog( out.statusCode );
		if ( left( out.statusCode, 1 ) == 4 || left( out.statusCode, 1 ) == 5 ) {
			out.error= "status code error: #out.statusCode#";
		} else if ( out.response == "Connection Timeout" || out.response == "Connection Failure" ) {
			out.error= out.response;
		} else if ( left( out.statusCode, 1 ) == 2 ) {
			out.success= true;
		}
		//  parse response 
		try {
			out.response= deserializeJSON( out.response );
			if ( isNull( out.response ) ) {
				out.response= "";
			}
			if ( isStruct( out.response ) && out.statusCode == "401" && structKeyExists( out.response, "message" ) ) {
				out.response.error= out.response.message;
			}
			if ( isStruct( out.response ) && structKeyExists( out.response, "error" ) ) {
				out.success= false;
				out.error= out.response.error;
				if ( reFindNoCase( "Token has expired .+ you are -?[0-9]+s off", out.error ) ) {
					server.recombeeTimeSync += reReplaceNoCase( out.error, ".+you are (\-?[0-9]+)s off.*", "\1" );
					this.debugLog( "Changed time sync to: " & server.recombeeTimeSync );
				}
			} else if ( isStruct( out.response ) && structKeyExists( out.response, "status" ) && out.response.status == 400 ) {
				out.success= false;
				out.error= out.response.detail;
			} else if ( isStruct( out.response ) && structKeyExists( out.response, "message" ) && find( "already exists", out.response.message ) && out.statusCode == 409 ) {
				out.success= true;
				out.error= "";
				out.response= out.response.message;
			}
		} catch (any cfcatch) {
			out.error= "JSON Error: " & cfcatch.message;
		}
		if ( len( out.error ) ) {
			out.success= false;
		}
		return out;
	}

	array function apiBatchRequest( required array batch, required string api ) {
		var item= "";
		var b= arguments.batch;
		var out= {
			"method"= listFirst( arguments.api, " " )
		,	"path"= listDeleteAt( listRest( arguments.api, " " ), 1, "/" )
		,	"params"= {}
		};
		structDelete( arguments, "databaseId" );
		structDelete( arguments, "batch" );
		structDelete( arguments, "api" );
		//  replace {var} in url, strip nulls and build params object 
		for ( item in arguments ) {
			if ( isNull( arguments[ item ] ) ) {
				structDelete( arguments, item );
			} else if ( isSimpleValue( arguments[ item ] ) && arguments[ item ] == "null" ) {
				out.params[ item ]= javaCast( "null", 0 );
			} else if ( findNoCase( "{#item#}", out.path ) ) {
				out.path= replaceNoCase( out.path, "{#item#}", arguments[ item ], "all" );
				structDelete( arguments, item );
			} else {
				out.params[ item ]= arguments[ item ];
			}
		}
		this.debugLog( "API Add Batch: #uCase( out.method )#: #out.path#" );
		if ( request.debug && request.dump ) {
			this.debugLog( out );
		}
		arrayAppend( b, out );
		return b;
	}

	function debugLog( required input ) {
		if ( structKeyExists( request, "log" ) && isCustomFunction( request.log ) ) {
			if ( isSimpleValue( arguments.input ) ) {
				request.log( "recombee: " & arguments.input );
			} else {
				request.log( "recombee: (complex type)" );
				request.log( arguments.input );
			}
		} else if( this.debug ) {
			cftrace( text=( isSimpleValue( arguments.input ) ? arguments.input : "" ), var=arguments.input, category="recombee", type="information" );
		}
		return;
	}

	string function hashSign( required string sInput, required string sKey= this.secretKey ) {
		var out= lCase( hmac( arguments.sInput, arguments.sKey, "HmacSHA1", "utf-8" ) );
		this.debugLog( "hmac: #out#" );
		return out;
	}

	string function nullify( required string input ) {
		return ( !len( arguments.input ) ? "null" : arguments.input );
	}

	string function zDateFormat( required string date ) {
		if ( !len( arguments.date ) ) {
			return "";
		}
		arguments.date= dateAdd( "s", this.offSet, arguments.date );
		return dateFormat( arguments.date, "yyyy-mm-dd" ) & "T" & timeFormat( arguments.date, "HH:mm:ss") & "Z";
	}

	numeric function epothDateFormat( required string date ) {
		if ( !len( arguments.date ) ) {
			return 0;
		}
		return dateDiff( "s", this.epoch, dateAdd( "s", this.offset, arguments.date ) );
	}

	string function structToQueryString( required struct stInput, boolean bEncode= true ) {
		var sOutput= "";
		var sItem= "";
		var sValue= "";
		var amp= "?";
		for ( sItem in stInput ) {
			if ( !isNull( stInput[ sItem ] ) ) {
				sValue= stInput[ sItem ];
				if ( bEncode ) {
					sOutput &= amp & sItem & "=" & urlEncodedFormat( sValue );
				} else {
					sOutput &= amp & sItem & "=" & sValue;
				}
				amp= "&";
			}
		}
		return sOutput;
	}

}
