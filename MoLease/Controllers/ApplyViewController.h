//
//  ApplyViewController.h
//  MoLease
//
//  Created by Chris Voss on 2/22/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "MoTableViewController.h"

/**
 * guest card application
 */
@interface ApplyViewController : MoTableViewController <MFMailComposeViewControllerDelegate, UITextFieldDelegate> {
    
    /**
     * name field
     */
    UITextField *_nameField;
    
    /**
     * email field
     */
    UITextField *_emailField;
    
    /**
     * cell phone field
     */
    UITextField *_cellField;
    
    /**
     * notes field
     */
    UITextField *_specialNotes;
    
    /**
     * phone field
     */
    UITextField *_phoneField;
    
    /**
     * address
     */
    UITextField *_addressField1;
    
    /**
     * address 2
    */
    UITextField *_addressField2;
    
}

- (void)sendEmail;

@end
