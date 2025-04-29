package com.xushuo.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xushuo.config.PassToken;
import com.xushuo.entity.Classes;
import com.xushuo.entity.Exams;
import com.xushuo.service.ClassesService;
import com.xushuo.service.ExamsService;
import com.xushuo.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@RestController
@RequestMapping("/exams")
public class ExamsController {

    @Autowired
    private ExamsService examsService;
    @Autowired
    private ClassesService classesService;

    /**
     * 分页查询
     */
    @PostMapping("/selectPage")
    public Result selectPage(@RequestBody Map<String,String> mp) {
        PageHelper.startPage(Integer.parseInt(mp.get("currentPage").toString()), Integer.parseInt(mp.get("pagesize").toString()));
        List<Exams> list = examsService.queryAllByLimit(mp);
        for(Exams exams: list){
            List<String> ccidList = new ArrayList<>();
            if(exams.getCcid()!=null){
                String[] ccid = exams.getCcid().split(",");
                List<Classes> classesList = classesService.queryCondition(new Classes());
                for(Classes classes: classesList){
                    if(Arrays.asList(ccid).contains(classes.getId().toString())){
                        //拼接
                        ccidList.add(classes.getName());
                    }
                }
                exams.setCname(String.join("，", ccidList));
            }
        }
        PageInfo<Exams> pageInfo = new PageInfo<Exams>(list);
        return Result.success(pageInfo);
    }

    /**
     * 查询所有
     */
    @PostMapping("/queryAll")
    public Result queryAll(@RequestBody Exams exams) {
        List<Exams> list = examsService.queryCondition(exams);
        return Result.success(list);
    }

    /**
     * 通过主键查询单条数据
     */
    @GetMapping("/selectOne")
    public Result selectOne(Integer id) {
        Exams exams = examsService.queryById(id);
        return Result.success(exams);
    }

    /**
     * 新增
     */
    @RequestMapping("/add")
    public Result add(@RequestBody Exams exams) {
        List<Exams> examsList = examsService.queryCondition(new Exams());
        for(Exams exams2: examsList){
            if(exams2.getTitle().equals(exams.getTitle())){
                return Result.error("试卷名不能重复，请重试");
            }
        }
        Date date = new Date();
        exams.setCreateTime(date);
        examsService.insert(exams);
        return Result.success("操作成功");
    }

    /**
     * 修改
     */
    @RequestMapping("/edit")
    public Result edit(@RequestBody Exams exams) {
        examsService.update(exams);
        return Result.success("操作成功");
    }

    /**
     * 删除
     */
    @GetMapping("/deleteById")
    public Result deleteById(Integer id) {
        examsService.deleteById(id);
        return Result.success("操作成功");
    }

    /**
     * 前端分页查询
     */
    @PostMapping("/frontPage")
    @PassToken
    public Result frontPage(@RequestBody Map<String,String> mp) {
        PageHelper.startPage(Integer.parseInt(mp.get("currentPage").toString()), Integer.parseInt(mp.get("pagesize").toString()));
        List<Exams> list = examsService.queryAllByLimit(mp);
        PageInfo<Exams> pageInfo = new PageInfo<Exams>(list);
        return Result.success(pageInfo);
    }

    /**
     * 前端通过主键查询单条数据
     */
    @GetMapping("/frontOne")
    @PassToken
    public Result frontOne(Integer id) {
        Exams exams = examsService.queryById(id);
        return Result.success(exams);
    }

    /**
     * 前端查询所有
     */
    @PostMapping("/frontAll")
    @PassToken
    public Result frontAll(@RequestBody Exams exams) {
        List<Exams> list = examsService.queryCondition(exams);
        return Result.success(list);
    }

    @PostMapping("/generateExam")
    @PassToken
    public Result generateExam(@RequestBody Map<String, Object> params) {
        try {
            List<Exams> examsList = examsService.queryCondition(new Exams());
            if(params.get("title")==null){
                return Result.error("试卷名不能为空");
            }
            String title = params.get("title").toString();
            for(Exams exams2: examsList){
                if(exams2.getTitle().equals(title)){
                    return Result.error("试卷名不能重复，请重试");
                }
            }
            return examsService.generateExam(params);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("生成试卷失败：" + e.getMessage());
        }
    }

    @PostMapping("/upload")
    @PassToken
    public Result uploadExam(@RequestParam("file") MultipartFile file) {
        try {
            String filePath = examsService.uploadExamFile   (file);
            return Result.success("上传成功", filePath);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("上传失败：" + e.getMessage());
        }
    }

    @GetMapping("/preview/{id}")
    @PassToken
    public void previewExam(@PathVariable("id") Long id, HttpServletResponse response) {
        try {
            // 设置响应头，支持浏览器直接预览PDF
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=exam.pdf");
            
            examsService.previewExam(id, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @GetMapping("/download/{id}")
    @PassToken
    public void downloadExam(@PathVariable("id") Long id, HttpServletResponse response) {
        try {
            Exams exam = examsService.queryById(id.intValue());
            if (exam == null) {
                throw new RuntimeException("试卷不存在");
            }
            examsService.downloadExam(id, response);
        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.getWriter().write("下载失败：" + e.getMessage());
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    @GetMapping("/list")
    @PassToken
    public Result getExamsList(@RequestParam Map<String, Object> params) {
        try {
            return examsService.getExamsList(params);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("获取试卷列表失败");
        }
    }
}