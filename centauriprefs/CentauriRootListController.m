#include "CentauriRootListController.h"
#import "spawn.h"

#define tint [UIColor colorWithRed: 0.20 green: 0.29 blue: 0.37 alpha: 1.00]

@implementation CentauriRootListController
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}
	return _specifiers;
}
- (void)respring {
	AudioServicesPlaySystemSound(1519);
	pid_t pid;
	const char *args[] = {"killall", "-9", "SpringBoard", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char *const *)args, NULL);
}
- (void)sourceCode {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/MTACS/centauri"]];
}
- (void)twitter {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/MTAC8"]];
}
@end

@implementation CentauriSwitch
- (id)initWithStyle:(int)style reuseIdentifier:(id)identifier specifier:(id)specifier {
	self = [super initWithStyle:style reuseIdentifier:identifier specifier:specifier];
	if (self) {
		[((UISwitch *)[self control]) setOnTintColor:tint];
	}
	return self;
}
@end

@implementation CentauriTableCell
- (void)tintColorDidChange {
	[super tintColorDidChange];

	self.textLabel.textColor = tint;
	self.textLabel.highlightedTextColor = tint;
}
- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
	[super refreshCellContentsWithSpecifier:specifier];

	if ([self respondsToSelector:@selector(tintColor)]) {
		self.textLabel.textColor = tint;
		self.textLabel.highlightedTextColor = tint;
	}
}
@end