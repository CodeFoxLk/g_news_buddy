

class ReqHeaders {
  Map<String, String>? header;

  Future<Map<String, String>?> getHeader(String? contentType) async {
    header ??= {};

    // AppDeviceDetails appConfigs = await AppDeviceDetails().getAppDeviceDetails();

    // header!["Content-Type"] = contentType;
    // header!["os"] = Platform.operatingSystem;
    // header!["buildNumber"] = appConfigs.packageInfo!.buildNumber;
    // header!["packageName"] = appConfigs.packageInfo!.packageName;
    // header!["app-version"] = appConfigs.packageInfo!.version;
    // header!["platform-version"] = Platform.version;

    // if (Platform.isAndroid) {
    //   header!["os-version"] = appConfigs.deviceData!["version.release"];
    //   header!["manufacturer"] = appConfigs.deviceData!["brand"];
    //   header!["model"] = appConfigs.deviceData!["model"];
    //   header!["sdk"] = appConfigs.deviceData!["sdkInt"];
    // }
    // if (Platform.isIOS) {
    //   header!["systemName"] = appConfigs.deviceData!["systemName"];
    //   header!["version"] = appConfigs.deviceData!["version"];
    //   header!["name"] = appConfigs.deviceData!["name"];
    //   header!["model"] = appConfigs.deviceData!["model"];
    // }

    return header;
  }
}
