#import "4GOnly.h"
#include<dlfcn.h>



@implementation FourGOnly

- (UIImage *)iconGlyph
{
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
}

- (UIColor *)selectedColor
{
	return [UIColor blueColor];
}

- (BOOL)isSelected
{
  return _selected;
}

int callback(void *connection, CFStringRef string, CFDictionaryRef dictionary, void *data) {
    return 0;
}

- (void)setSelected:(BOOL)selected
{
	_selected = selected;

  [super refreshState];

  void* handle = dlopen("/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony" , RTLD_LAZY);
  if(!handle)
    return;
  
  CTServerConnectionStruct (*CTServerConnectionCreate)(CFAllocatorRef, int (*)(void *, CFStringRef, CFDictionaryRef, void *), int *)  = dlsym(handle , "_CTServerConnectionCreate");
  CTServerConnectionStruct pikachu =  CTServerConnectionCreate(kCFAllocatorDefault, callback, NULL);

  void (*CTServerConnectionSetRATSelection)() = dlsym(handle, "_CTServerConnectionSetRATSelection");

  if(_selected)
  {
    CTServerConnectionSetRATSelection(pikachu , kCTRegistrationRATSelection6 , NULL ,  NULL);
  }
  else
  {
    CTServerConnectionSetRATSelection(pikachu , kCTRegistrationRATSelection7 , NULL);
  }
  dlclose(handle);
}

@end
