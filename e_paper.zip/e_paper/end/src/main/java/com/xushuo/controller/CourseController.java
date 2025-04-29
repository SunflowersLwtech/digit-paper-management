package com.xushuo.controller;

import com.xushuo.config.PassToken;
import org.springframework.beans.factory.annotation.Autowired;
import com.xushuo.entity.Course;
import com.xushuo.service.CourseService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.List;
import java.util.Date;
import com.xushuo.util.Result;

/**
 * 课程表接口
 **/
@RestController
@RequestMapping("/course")
public class CourseController {

    @Autowired
    private CourseService courseService;

    /**
     * 分页查询
     */
    @PostMapping("/selectPage")
    public Result selectPage(@RequestBody Map<String,String> mp) {
        PageHelper.startPage(Integer.parseInt(mp.get("currentPage").toString()), Integer.parseInt(mp.get("pagesize").toString()));
        List<Course> list = courseService.queryAllByLimit(mp);
        PageInfo<Course> pageInfo = new PageInfo<Course>(list);
        return Result.success(pageInfo);
    }

    /**
     * 查询所有
     */
    @PostMapping("/queryAll")
    public Result queryAll(@RequestBody Course course) {
        List<Course> list = courseService.queryCondition(course);
        return Result.success(list);
    }

    /**
     * 通过主键查询单条数据
     */
    @GetMapping("/selectOne")
    public Result selectOne(Integer id) {
        Course course = courseService.queryById(id);
        return Result.success(course);
    }

    /**
     * 新增
     */
    @RequestMapping("/add")
    public Result add(@RequestBody Course course) {
        Date date = new Date();
        course.setCreateTime(date);
        courseService.insert(course);
        return Result.success("操作成功");
    }

    /**
     * 修改
     */
    @RequestMapping("/edit")
    public Result edit(@RequestBody Course course) {
        courseService.update(course);
        return Result.success("操作成功");
    }

    /**
     * 删除
     */
    @GetMapping("/deleteById")
    public Result deleteById(Integer id) {
        courseService.deleteById(id);
        return Result.success("操作成功");
    }

    /**
     * 前端分页查询
     */
    @PostMapping("/frontPage")
    @PassToken
    public Result frontPage(@RequestBody Map<String,String> mp) {
        PageHelper.startPage(Integer.parseInt(mp.get("currentPage").toString()), Integer.parseInt(mp.get("pagesize").toString()));
        List<Course> list = courseService.queryAllByLimit(mp);
        PageInfo<Course> pageInfo = new PageInfo<Course>(list);
        return Result.success(pageInfo);
    }

    /**
     * 前端通过主键查询单条数据
     */
    @GetMapping("/frontOne")
    @PassToken
    public Result frontOne(Integer id) {
        Course course = courseService.queryById(id);
        return Result.success(course);
    }

    /**
     * 前端查询所有
     */
    @PostMapping("/frontAll")
    @PassToken
    public Result frontAll(@RequestBody Course course) {
        List<Course> list = courseService.queryCondition(course);
        return Result.success(list);
    }

}