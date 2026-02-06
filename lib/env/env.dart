import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'DISCOVERY_URL', obfuscate: true)
  static final String discoveryUrl = _Env.discoveryUrl;

  @EnviedField(varName: 'FULL_IMAGE_URL', obfuscate: true)
  static final String fullImageUrl = _Env.fullImageUrl;

  @EnviedField(varName: 'THUMBNAIL_IMAGE_URL', obfuscate: true)
  static final String thumbnailImageUrl = _Env.thumbnailImageUrl;

  @EnviedField(varName: 'PRIVATE_KEY', obfuscate: true)
  static final String privateKey = _Env.privateKey;

  @EnviedField(varName: 'PUBLIC_KEY', obfuscate: true)
  static final String publicKey = _Env.publicKey;

  @EnviedField(varName: 'VERSION', obfuscate: true)
  static final String version = _Env.version;
}
