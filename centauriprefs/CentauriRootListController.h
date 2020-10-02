#import <Preferences/PSListController.h>
#import <Preferences/PSTableCell.h>
#import <AudioToolbox/AudioServices.h>

@interface CentauriRootListController : PSListController
@end

@interface PSControlTableCell : PSTableCell
- (UIControl *)control;
@end

@interface PSSwitchTableCell : PSControlTableCell
- (id)initWithStyle:(int)style reuseIdentifier:(id)identifier specifier:(id)specifier;
@end

@interface CentauriSwitch : PSSwitchTableCell
@end

@interface CentauriTableCell : PSTableCell
@end