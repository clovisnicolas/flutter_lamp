#import "LampPlugin.h"
#import <AVFoundation/AVFoundation.h>

@implementation LampPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"github.com/clovisnicolas/flutter_lamp"
            binaryMessenger:[registrar messenger]];
  LampPlugin* instance = [[LampPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"turnOn" isEqualToString:call.method]) {
     NSNumber *intensity = call.arguments[@"intensity"];
     [self turnOnWithIntensity:intensity.doubleValue];
     result(nil);
  }
   else if ([@"turnOff" isEqualToString:call.method]) {
       [self turnOff];
       result(nil);
    }
   else if ([@"hasLamp" isEqualToString:call.method]) {
       result([NSNumber numberWithBool:[self hasLamp]]);
   }
  else {
    result(FlutterMethodNotImplemented);
  }
}


- (bool) hasLamp
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    return ([device hasTorch] && [device hasFlash]);
}

- (void) turnOff
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash]){
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}

- (void)turnOnWithIntensity:(float)level
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash]){
        [device lockForConfiguration:nil];
        NSError *error = nil;
        float acceptedLevel = (level < AVCaptureMaxAvailableTorchLevel ? level : AVCaptureMaxAvailableTorchLevel);
        NSLog(@"FLash level: %f", acceptedLevel);
        [device setTorchModeOnWithLevel:acceptedLevel error:&error];
        [device unlockForConfiguration];
    }
}


@end
