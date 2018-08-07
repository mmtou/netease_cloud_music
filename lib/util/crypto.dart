import 'dart:math';
import 'package:encrypt/encrypt.dart';

const modulus =
    '00e0b509f6259df8642dbc35662901477df22677ec152b5ff68ace615bb7b725152b3ab17a876aea8a5aa76d2e417629ec4ee341f56135fccf695280104e0312ecbda92557c93870114af6c9d05c4f7f0c3685b7a46bee255932575cce10b424d813cfe4875d3e82047b97ddef52741d546b8e289dc6935b3ece0462db0a22b8e7';
const nonce = '0CoJUm6Qyw8W8jud';
const pubKey = '010001';

class Crypto {
  createSecretKey(int size) {
    const keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String key = '';
    for (var i = 0; i < size; i++) {
      var posDouble = Random().nextDouble() * keys.length;
      var posInt = posDouble.floor();
      key = key + keys.split('')[posInt];
    }
    return key;
  }

  aesEncrypt(String text, String secKey) {
    final encrypter = new Encrypter(new AES(secKey));
    final plainText = text;

    final encryptedText = encrypter.encrypt(plainText);

    print(encryptedText); // db066ce180f62f020617eb720b891c1efcc48b217cb83272812a8efe3b30e7eae4373ddcede4ea77bdae77d126d95457b3759b1983bf4cb4a6a5b051a5690bdf
    return encryptedText;
  }

  zfill(String str, int size) {
    while (str.length < size) str = '0' + str;
    return str;
  }

  rsaEncrypt(String text, String pubKey, String modulus) {
    String _text = '';
    _text.split('').map((String item) {
      _text = item + _text;
    });
    const biText = _text.radix,
        biEx = bigInt(pubKey, 16),
        biMod = bigInt(modulus, 16),
        biRet = biText.modPow(biEx, biMod);
    return zfill(biRet.toString(16), 256);
  }

}

//String.prototype.hexEncode = function() {
//  let hex, i
//
//  let result = ''
//  for (i = 0; i < this.length; i++) {
//    hex = this.charCodeAt(i).toString(16)
//    result += ('' + hex).slice(-4)
//  }
//  return result
//}


function rsaEncrypt(text, pubKey, modulus) {
  const _text = text.split('').reverse().join('')
  const biText = bigInt(new Buffer(_text).toString('hex'), 16),
      biEx = bigInt(pubKey, 16),
      biMod = bigInt(modulus, 16),
      biRet = biText.modPow(biEx, biMod)
  return zfill(biRet.toString(16), 256)
}

function Encrypt(obj) {
  const text = JSON.stringify(obj)
  const secKey = createSecretKey(16)
  const encText = aesEncrypt(aesEncrypt(text, nonce), secKey)
  const encSecKey = rsaEncrypt(secKey, pubKey, modulus)
  return {
    params: encText,
    encSecKey: encSecKey
  }
}

module.exports = Encrypt