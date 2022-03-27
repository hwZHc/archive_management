package edu.nuist.studentadmin.utils;

import java.security.MessageDigest;
import java.util.Formatter;

public class Md5Util {
    public static String md5(String str) {
        try {
            // 生成一个MD5加密计算摘要
            MessageDigest md = MessageDigest.getInstance("MD5");
            // 计算md5函数
            md.update(str.getBytes());
            return toHexString(md.digest());
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

	private static String toHexString(byte[] digest) {
		// TODO Auto-generated method stub
		Formatter formatter=new Formatter();
		for(byte b:digest) {
			formatter.format("%02x",b);
		}
		String res=formatter.toString();
		formatter.close();
		return res;
	}
}

