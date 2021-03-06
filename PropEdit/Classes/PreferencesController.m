/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * file         PreferencesController.m
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

#import "PreferencesController.h"
#import "ApplicationController.h"

@implementation PreferencesController

@synthesize defaultLocation;
@synthesize showDotFiles;
@synthesize showHiddenFiles;
@synthesize sortDirectories;
@synthesize app;

- ( void )dealloc
{
    [ customLocation release ];
    [ defaultLocation release ];
    [ showDotFiles release ];
    [ showHiddenFiles release ];
    [ sortDirectories release ];
    [ app release ];
    [ super dealloc ];
}

- ( void )setPreferences
{
    NSInteger  location;
    NSString * customLocationPath;
    
    location = [ [ app.preferences.values objectForKey: @"DefaultLocation" ] integerValue ];
    
    if( customLocation != nil )
    {
        [ defaultLocation removeItemWithTitle: [ customLocation title ] ];
        [ customLocation release ];
        
        customLocation = nil;
    }
    
    if( location == 5 )
    {
        customLocationPath = [ app.preferences.values objectForKey: @"CustomLocation" ];
        
        [ defaultLocation addItemWithTitle: customLocationPath ];
        [ defaultLocation selectItemWithTitle: customLocationPath ];
        
        customLocation = [ [ defaultLocation itemWithTitle: customLocationPath ] retain ];
    }
    else
    {
        [ defaultLocation  selectItemWithTag: location ];
    }
    
    [ showDotFiles     setIntValue:       [ app.preferences.values boolForKey:     @"ShowDotFiles" ] ];
    [ showHiddenFiles  setIntValue:       [ app.preferences.values boolForKey:     @"ShowHiddenFiles" ] ];
    [ sortDirectories  setIntValue:       [ app.preferences.values boolForKey:     @"SortDirectories" ] ];
}

- ( IBAction )save: ( id )sender
{
    [ app.preferences.values setBool: [ showDotFiles     intValue ] forKey: @"ShowDotFiles" ];
    [ app.preferences.values setBool: [ showHiddenFiles  intValue ] forKey: @"ShowHiddenFiles" ];
    [ app.preferences.values setBool: [ sortDirectories  intValue ] forKey: @"SortDirectories" ];
    
    if( [ [ defaultLocation selectedItem ] tag ] > 0 )
    {
        [ app.preferences.values setInteger: [ [ defaultLocation selectedItem ] tag ] forKey: @"DefaultLocation" ];
    }
    else
    {
        [ app.preferences.values setInteger: 5                                         forKey: @"DefaultLocation" ];
        [ app.preferences.values setObject: [ [ defaultLocation selectedItem ] title ] forKey: @"CustomLocation" ];
    }
    
    [ app.preferences.values synchronize ];
    [ self.window orderOut: sender ];
    [ NSApp endSheet: self.window returnCode: 0 ];
}

- ( IBAction )close: ( id )sender
{
    [ self.window orderOut: sender ];
    [ NSApp endSheet: self.window returnCode: 1 ];
}

- ( IBAction )customLocation: ( id )sender
{
    NSOpenPanel * openPanel;
    
    ( void )sender;
    
    openPanel = [ NSOpenPanel openPanel ];
    
    [ openPanel setCanChooseDirectories: YES ];
    [ openPanel setCanChooseFiles:       NO ];
    [ openPanel beginSheetModalForWindow: self.window completionHandler: ^( NSInteger returnCode )
        {
            NSString * filename;
            
            ( void )returnCode;
            
            if( customLocation != nil )
            {
                [ defaultLocation removeItemWithTitle: [ customLocation title ] ];
                [ customLocation release ];
                
                customLocation = nil;
            }
            
            filename = [ openPanel.URL path ];
            
            [ defaultLocation addItemWithTitle: filename ];
            [ defaultLocation selectItemWithTitle: filename ];
            
            customLocation = [ [ defaultLocation itemWithTitle: filename ] retain ];
        }
    ];
}

@end
