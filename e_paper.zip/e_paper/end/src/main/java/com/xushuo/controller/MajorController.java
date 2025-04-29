package com.xushuo.controller;

import com.xushuo.config.PassToken;
import org.springframework.beans.factory.annotation.Autowired;
import com.xushuo.entity.Major;
import com.xushuo.service.MajorService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.List;
import java.util.Date;
import com.xushuo.util.Result;

/**
 * 专业表接口
 **/
@RestController
@RequestMapping("/major")
public class MajorController {

    @Autowired
    private MajorService majorService;

    /**
     * 分页查询
     */
    @PostMapping("/selectPage")
    public Result selectPage(@RequestBody Map<String,String> mp) {
        PageHelper.startPage(Integer.parseInt(mp.get("currentPage").toString()), Integer.parseInt(mp.get("pagesize").toString()));
        List<Major> list = majorService.queryAllByLimit(mp);
        PageInfo<Major> pageInfo = new PageInfo<Major>(list);
        return Result.success(pageInfo);
    }

    /**
     * 查询所有
     */
    @PostMapping("/queryAll")
    public Result queryAll(@RequestBody Major major) {
        List<Major> list = majorService.queryCondition(major);
        return Result.success(list);
    }

    /**
     * 通过主键查询单条数据
     */
    @GetMapping("/selectOne")
    public Result selectOne(Integer id) {
        Major major = majorService.queryById(id);
        return Result.success(major);
    }

    /**
     * 新增
     */
    @RequestMapping("/add")
    public Result add(@RequestBody Major major) {
        Date date = new Date();
        major.setCreateTime(date);
        majorService.insert(major);
        return Result.success("操作成功");
    }

    /**
     * 修改
     */
    @RequestMapping("/edit")
    public Result edit(@RequestBody Major major) {
        majorService.update(major);
        return Result.success("操作成功");
    }

    /**
     * 删除
     */
    @GetMapping("/deleteById")
    public Result deleteById(Integer id) {
        majorService.deleteById(id);
        return Result.success("操作成功");
    }

    /**
     * 前端分页查询
     */
    @PostMapping("/frontPage")
    @PassToken
    public Result frontPage(@RequestBody Map<String,String> mp) {
        PageHelper.startPage(Integer.parseInt(mp.get("currentPage").toString()), Integer.parseInt(mp.get("pagesize").toString()));
        List<Major> list = majorService.queryAllByLimit(mp);
        PageInfo<Major> pageInfo = new PageInfo<Major>(list);
        return Result.success(pageInfo);
    }

    /**
     * 前端通过主键查询单条数据
     */
    @GetMapping("/frontOne")
    @PassToken
    public Result frontOne(Integer id) {
        Major major = majorService.queryById(id);
        return Result.success(major);
    }

    /**
     * 前端查询所有
     */
    @PostMapping("/frontAll")
    @PassToken
    public Result frontAll(@RequestBody Major major) {
        List<Major> list = majorService.queryCondition(major);
        return Result.success(list);
    }

}