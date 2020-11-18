#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>

@interface NSUserDefaults (Centauri)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

@interface BCUIRingItemView: UIView
@property (nonatomic, assign, readwrite, getter=isEmpty) BOOL empty;
- (void)handleTap:(id)sender;
@end

@interface _CDBatterySaver
+ (id)batterySaver;
- (BOOL)setPowerMode:(long long)arg1 error:(id*)arg2;
- (long long)getPowerMode;
@end

static NSString *domain = @"com.mtac.centauri";
static NSString *PostNotificationString = @"com.mtac.centauri/preferences.changed";
static BOOL enabled;
static BOOL enableLowPowerTap;
static BOOL enableHaptics;
static BOOL hideEmptyBatteryRings;
static BOOL hideBackground;

%group Tweak 
%hook BCUIRingItemView
- (void)didMoveToWindow {
	%orig;
	if (enableLowPowerTap) {
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
		tapGesture.numberOfTapsRequired = 1;
		if (!self.isEmpty) {
			[self addGestureRecognizer:tapGesture];
		}
	}
}
%new
- (void)handleTap:(id)sender {
	long long state = [[%c(_CDBatterySaver) batterySaver] getPowerMode];
	switch (state) {
		case 0:
		[[%c(_CDBatterySaver) batterySaver] setPowerMode:1 error:nil];
		break;
		case 1:
		[[%c(_CDBatterySaver) batterySaver] setPowerMode:0 error:nil];\
		break;
	}
	if (enableHaptics) AudioServicesPlaySystemSound(1519);
}
- (void)layoutSubviews {
	%orig;
	if (hideEmptyBatteryRings) {
		self.hidden = self.isEmpty;
	}
}
%end

%hook SBHWidgetStackViewController
- (BOOL)_shouldDrawSystemBackgroundMaterialForWidget:(id)arg1 {
	return !hideBackground;
}
%end
%end

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSNumber *enabledValue = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enabled" inDomain:domain];
	enabled = (enabledValue) ? [enabledValue boolValue] : NO;
	NSNumber *enableLowPowerTapValue = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enableLowPowerTap" inDomain:domain];
	enableLowPowerTap = (enableLowPowerTapValue) ? [enableLowPowerTapValue boolValue] : NO;
	NSNumber *hideEmptyBatteryRingsValue = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"hideEmptyBatteryRings" inDomain:domain];
	hideEmptyBatteryRings = (hideEmptyBatteryRingsValue) ? [hideEmptyBatteryRingsValue boolValue] : NO;
	NSNumber *enableHapticsValue = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enableHaptics" inDomain:domain];
	enableHaptics = (enableHapticsValue) ? [enableHapticsValue boolValue] : NO;
	NSNumber *hideBackgroundValue = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"hideBackground" inDomain:domain];
	hideBackground = (hideBackgroundValue) ? [hideBackgroundValue boolValue] : NO;
	
}

%ctor {
	notificationCallback(NULL, NULL, NULL, NULL, NULL);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, notificationCallback, (CFStringRef)PostNotificationString, NULL, CFNotificationSuspensionBehaviorCoalesce);
	if (enabled) {
		%init(Tweak);
	}
}
