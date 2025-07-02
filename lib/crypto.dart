import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;

// Encryption and decryption methods for one game
class GameCrypto {

  final String gamePassword;
  late final encrypt.Key key;
  late final encrypt.Encrypter encrypter;

  GameCrypto(this.gamePassword) {
    // Initialize the key
    key = encrypt.Key.fromUtf8(gamePassword.padRight(32, '0').substring(0, 32));
    // Initialize the encrypter
    encrypter = encrypt.Encrypter(encrypt.AES(key));
  }

  String encryptString(String toEncrypt) {
    return encryptData(utf8.encode(toEncrypt));
  }

  List<String> encryptStringList(List<String> toEncrypt) {
    List<String> encryptedValues = toEncrypt.map((value) {
      return encryptString(value);
    }).toList();
    return encryptedValues;
  }
  
  List<String> encryptList(List<Uint8List> toEncrypt) {
    List<String> encryptedValues = toEncrypt.map((value) {
      return encryptData(value);
    }).toList();
    return encryptedValues;
  }
  
  String encryptData(Uint8List toEncrypt) {
    // Generate a random IV
    final iv = encrypt.IV.fromLength(16);
    // Encrypt the plaintext
    final encrypted = encrypter.encryptBytes(toEncrypt, iv: iv);
    // Combine IV and ciphertext, then encode in base64
    return '${base64.encode(iv.bytes)}:${encrypted.base64}';
  }

  String decryptString(String cryptText) {
    return utf8.decode(decryptData(cryptText));
  }

  List<String> decryptStringList(List<String> cryptTextList) {
    List<String> decryptedValues = cryptTextList.map((value) {
      return decryptString(value);
    }).toList();
    return decryptedValues;
  }

  List<List<int>> decryptList(List<String> cryptTextList) {
    List<List<int>> decryptedValues = cryptTextList.map((value) {
      return decryptData(value);
    }).toList();
    return decryptedValues;
  }

  List<int> decryptData(String cryptText) {
    // Split the IV and the ciphertext
    final parts = cryptText.split(':');
    final iv = encrypt.IV.fromBase64(parts[0]);
    final encryptedData = encrypt.Encrypted.fromBase64(parts[1]);
    // Decrypt the base64 encoded text
    final decrypted = encrypter.decryptBytes(encryptedData, iv: iv);
    return decrypted; // Return the decrypted plaintext
  }
}
