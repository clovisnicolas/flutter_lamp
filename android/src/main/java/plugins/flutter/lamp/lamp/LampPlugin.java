package plugins.flutter.lamp.lamp;

import android.content.pm.PackageManager;
import android.hardware.Camera;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * LampPlugin
 */
public class LampPlugin implements MethodCallHandler {

    private LampPlugin(Registrar registrar) {
        this._registrar = registrar;
        this._camera = this.getCamera();
    }

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "github.com/clovisnicolas/flutter_lamp");
        channel.setMethodCallHandler(new LampPlugin(registrar));
    }

    private Camera _camera;
    private Registrar _registrar;

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch(call.method){
            case "turnOn":
                this.turn(true);
                result.success(null);
                break;
            case "turnOff":
                this.turn(false);
                result.success(null);
                break;
            case "hasLamp":
                result.success(this.hasLamp());
                break;
            default:
                result.notImplemented();
        }
    }

    private Camera getCamera() {
        try {
            return Camera.open();
        } catch (Exception e) {
            System.out.println("Failed to get camera : " + e.toString());
            return null;
        }
    }

    private void turn(boolean on) {
        Camera.Parameters params;
        if (_camera == null || !hasLamp()) {
            return;
        }
        params = _camera.getParameters();
        params.setFlashMode(on ? Camera.Parameters.FLASH_MODE_TORCH : Camera.Parameters.FLASH_MODE_OFF);
        _camera.setParameters(params);
        if (on) {
            _camera.startPreview();
        } else {
            _camera.stopPreview();
        }
    }

    private boolean hasLamp() {
        return _registrar.context().getApplicationContext().getPackageManager().hasSystemFeature(PackageManager.FEATURE_CAMERA_FLASH);
    }

}
