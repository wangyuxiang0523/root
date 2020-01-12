package com.fh.utils;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

public class CopyFile {
    public  static String copyFile(CommonsMultipartFile photo, String mkdirName) {
         String oldName=  photo.getOriginalFilename();
         Long time= System.currentTimeMillis();
        String suffix= oldName.substring(oldName.lastIndexOf("."));
        String newFileName=time+suffix;
      HttpServletRequest request=((ServletRequestAttributes)(RequestContextHolder.currentRequestAttributes())).getRequest();
    String realPath=  request.getServletContext().getRealPath("/");
       realPath=realPath+"commons/"+mkdirName;
       File file=new File(realPath);
       if(!file.exists()){
           file.mkdirs();
       }
        try {
            photo.transferTo(new File(realPath+"/"+newFileName));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "commons/"+mkdirName+"/"+newFileName;
    }
}
