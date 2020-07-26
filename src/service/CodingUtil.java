package service;


import sun.misc.BASE64Decoder;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Base64;


import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


public class CodingUtil {

    public CodingUtil(){

    }
    /*
    base64
     */

    public static String encodeByteToBase64String(byte[] textbytes){
        Base64.Encoder encoder = Base64.getEncoder();
        return encoder.encodeToString(textbytes);
    }
    public static String encodeStringToBase64String(String text){
        Base64.Encoder encoder = Base64.getEncoder();
        return encoder.encodeToString(text.getBytes());
    }

    public static String decodeBase64StringToString(String base64String) throws IOException {
        BASE64Decoder decoder = new BASE64Decoder();
        byte[]bytes = decoder.decodeBuffer(base64String);
        return new String(bytes);
    }

    /*
    md5
     */




        /**利用MD5进行加密*/
        public static String EncoderByMd5(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException{
            //确定计算方法
            MessageDigest md5=MessageDigest.getInstance("MD5");

            //加密后的字符串
            String newstr=encodeByteToBase64String(md5.digest(str.getBytes("utf-8")));
            return newstr;
        }

        /**判断用户密码是否正确
         *newpasswd 用户输入的密码
         *oldpasswd 正确密码*/
        public static boolean checkpassword(String newpasswd,String oldpasswd) throws NoSuchAlgorithmException, UnsupportedEncodingException{
            if(EncoderByMd5(newpasswd).equals(oldpasswd))
                return true;
            else
                return false;
        }


}
