package service;


public class SearchingUtil {

    public SearchingUtil(){

    }

    /**
     * 根据搜索特殊字符串
     * @param
     * @return 取不到返回null
     */
    public static String specialStr(String str){
        Integer index=str.indexOf("%");
        Integer index1=str.indexOf("_");
        Integer index2=str.indexOf("\\");
        StringBuffer stringBuffer = new StringBuffer(str);
        if(index!=-1) {
            stringBuffer.insert(index, "\\");
        }
        if(index1!=-1) {
            stringBuffer.insert(index1, "\\");
        }
        if(index2!=-1) {
            stringBuffer.insert(index2, "\\");
        }
        return stringBuffer.toString();

    }


    public static String specialStrKeyword(String str){
        if(str==null||str==""){
            return null;
        }
        StringBuffer stringBuffer = new StringBuffer(str);
        int length=str.length();
        for (int i = 0; i <length; i++) {
            char chari=stringBuffer.charAt(i);
//            if(i==0){
//                if(chari=='%'||chari=='_'||chari=='\\'){
//                    stringBuffer.insert(i, "\\");
//                    i++;
//                    length++;
//                }
//            }else{
//                if(chari=='%'||chari=='_'||chari=='\\'){
//                    stringBuffer.insert(i, "%\\");
//                    i+=2;
//                    length+=2;
//                }else{
                    stringBuffer.insert(i, "%");
                    i++;
                    length++;
                //}
            //}
        }
        return stringBuffer.toString();

    }

}
