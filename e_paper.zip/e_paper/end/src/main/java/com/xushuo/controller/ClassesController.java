package com.xushuo.controller;

import com.xushuo.config.PassToken;
import org.springframework.beans.factory.annotation.Autowired;
import com.xushuo.entity.Classes;
import com.xushuo.service.ClassesService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.List;
import java.util.Date;
import com.xushuo.util.Result;

/**
 * 班级表接口
 **/
@RestController
@RequestMapping("/classes")
public class ClassesController {

    @Autowired
    private ClassesService classesService;

    /**
     * 分页查询
     */
    @PostMapping("/selectPage")
    public Result selectPage(@RequestBody Map<String,String> mp) {
        PageHelper.startPage(Integer.parseInt(mp.get("currentPage").toString()), Integer.parseInt(mp.get("pagesize").toString()));
        List<Classes> list = classesService.queryAllByLimit(mp);
        PageInfo<Classes> pageInfo = new PageInfo<Classes>(list);
        return Result.success(pageInfo);
    }

    /**
     * 查询所有
     */
    @PostMapping("/queryAll")
    public Result queryAll(@RequestBody Classes classes) {
        List<Classes> list = classesService.queryCondition(classes);
        return Result.success(list);
    }

    /**
     * 通过主键查询单条数据
     */
    @GetMapping("/selectOne")
    public Result selectOne(Integer id) {
        Classes classes = classesService.queryById(id);
        return Result.success(classes);
    }

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Classes classes) {
        Date date = new Date();
        classes.setCreateTime(date);
        classesService.insert(classes);
        return Result.success("操作成功");
    }

    /**
     * 修改
     */
    @PostMapping("/edit")
    public Result edit(@RequestBody Classes classes) {
        classesService.update(classes);
        return Result.success("操作成功");
    }

    /**
     * 删除
     */
    @GetMapping("/deleteById")
    public Result deleteById(Integer id) {
        classesService.deleteById(id);
        return Result.success("操作成功");
    }

    /**
     * 前端分页查询
     */
    @PostMapping("/frontPage")
    @PassToken
    public Result frontPage(@RequestBody Map<String,String> mp) {
        PageHelper.startPage(Integer.parseInt(mp.get("currentPage").toString()), Integer.parseInt(mp.get("pagesize").toString()));
        List<Classes> list = classesService.queryAllByLimit(mp);
        PageInfo<Classes> pageInfo = new PageInfo<Classes>(list);
        return Result.success(pageInfo);
    }

    /**
     * 前端通过主键查询单条数据
     */
    @GetMapping("/frontOne")
    @PassToken
    public Result frontOne(Integer id) {
        Classes classes = classesService.queryById(id);
        return Result.success(classes);
    }

    /**
     * 前端查询所有
     */
    @PostMapping("/frontAll")
    @PassToken
    public Result frontAll(@RequestBody Classes classes) {
        List<Classes> list = classesService.queryCondition(classes);
        return Result.success(list);
    }

}