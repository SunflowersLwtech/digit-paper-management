package com.xushuo.controller;


import com.xushuo.util.Result;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.lang.System;
/**
 * 系统操作控制器
 */
@RestController
@RequestMapping("file")
public class FileController {

	@Value("${uploadDir}")
	private String uploadDir;

	@RequestMapping("/imgUpload")
	public Result UploadFIle(@RequestParam("file") MultipartFile multiFile) {
		try {
			SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
			String name = sf.format(new Date());
			//获取文件的扩展名
			String ext = FilenameUtils.getExtension(multiFile.getOriginalFilename());
			//以绝对路径保存重名命后的图片
			multiFile.transferTo(new File(uploadDir+"/"+name + "." + ext));
			//jsonObject.put("code",name + "." + ext);
			String url = "/api/upload/"+name + "." + ext;
			return Result.success("上传成功",url);
		} catch (IOException e) {
			e.printStackTrace();
			return Result.error("上传失败");
		}
	}



}

