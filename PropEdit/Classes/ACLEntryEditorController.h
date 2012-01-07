/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @header      ACLEntryEditorController.h
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

@class DSCLHelper;
@class ACLEntry;
@class User;
@class Group;

@interface ACLEntryEditorController: NSWindowController
{
@protected
    
    NSPopUpButton * _entrySelect;
    NSPopUpButton * _userSelect;
    NSMatrix      * _baseMatrix;
    NSMatrix      * _directoryMatrix;
    NSMatrix      * _fileMatrix;
    DSCLHelper    * _dscl;
    NSArray       * _users;
    NSArray       * _groups;
    ACLEntry      * _acl;
    User          * _user;
    Group         * _group;
    
@private
    
    id _ACLEntryEditorController_Reserved[ 5 ] __attribute__( ( unused ) );
}

@property( atomic, retain ) IBOutlet NSPopUpButton * entrySelect;
@property( atomic, retain ) IBOutlet NSPopUpButton * userSelect;
@property( atomic, retain ) IBOutlet NSMatrix      * baseMatrix;
@property( atomic, retain ) IBOutlet NSMatrix      * directoryMatrix;
@property( atomic, retain ) IBOutlet NSMatrix      * fileMatrix;
@property( atomic, readwrite, retain ) ACLEntry    * acl;
@property( atomic, readwrite, retain ) User        * user;
@property( atomic, readwrite, retain ) Group       * group;

- ( IBAction )cancel: ( id )sender;
- ( IBAction )save: ( id )sender;

@end
