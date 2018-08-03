<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="main">
    <head>
    	<regionBase>
    		<region id="rgLua" left="0%" top="0%" width="100%" height="100%" zIndex="0">
    			<region id="rgHeart" width="10%" height="10%" zIndex="1" />
    		</region>
    	</regionBase>
    	<descriptorBase>
    		<descriptor id="dLua" region="rgLua" />
    		<descriptor id="dHeart" region="rgHeart" />
    	</descriptorBase>
    	<connectorBase>
    		<causalConnector id="onBeginStart">
				<simpleCondition role="onBegin" />
				<simpleAction role="start" />
			</causalConnector>
			<causalConnector id="onEndStop">
				<simpleCondition role="onEnd" />
				<simpleAction role="stop" />	
			</causalConnector>
			<causalConnector id="onBeginSet">
				<simpleCondition role="onBegin" />
				<connectorParam name="var" />
				<simpleAction role="set" value="$var" />
			</causalConnector>
			<causalConnector id="onSelectionStop">
				<simpleCondition role="onSelection" />
				<simpleAction role="stop" />
			</causalConnector>
			<causalConnector id="onKeySelectionStop">
				<connectorParam name="key" />
				<simpleCondition role="onSelection" key="$key" />
				<simpleAction role="stop" />
			</causalConnector>
    	</connectorBase>
    </head>
    <body>
    	<port id="p1" component="mainCtx" />
    	
        <media id="sett" type="application/x-ginga-settings">
            <property name="service.currentKeyMaster" value=""/>
        </media>

    	<context id="mainCtx">
    		<port id="pHeart" component="heart" />
    		<media id="settings" refer="sett" instance="instSame" />
    		<media id="lua" src="script.lua" descriptor="dLua">
    			<property name="placeholder" value="0" />
    		</media>
    		<media id="heart" src="heartbeat.gif" descriptor="dHeart" />

    		<link xconnector="onBeginStart">
    			<bind component="heart" role="onBegin" />
    			<bind component="lua" role="start" />
    		</link>
    		<link xconnector="onBeginSet">
    			<bind component="lua" role="onBegin" />
    			<bind component="sett" interface="service.currentKeyMaster" role="set">
    				<bindParam name="var" value="lua" />
    			</bind>
    		</link>
    		<link xconnector="onEndStop">
    			<bind component="heart" role="onEnd" />
    			<bind component="lua" role="stop" />
    		</link>
    		<link xconnector="onKeySelectionStop">
    			<bind component="heart" role="onSelection">
    				<bindParam name="key" value="RED" />
    			</bind>
    			<bind component="heart" role="stop" />
    		</link>
    	</context>
    </body>
</ncl>

