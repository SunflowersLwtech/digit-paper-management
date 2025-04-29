package com.xushuo.controller;

import com.xushuo.config.PassToken;
import org.springframework.beans.factory.annotation.Autowired;
import com.xushuo.entity.Question;
import com.xushuo.service.QuestionService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.List;
import java.util.Date;
import com.xushuo.util.Result;

/**
 * 题目表接口
 **/
@RestController
@RequestMapping("/question")
public class QuestionController {

    @Autowired
    private QuestionService questionService;

    /**
     * 分页查询
     */
    @PostMapping("/selectPage")
    public Result selectPage(@RequestBody Map<String,String> mp) {
        PageHelper.startPage(Integer.parseInt(mp.get("currentPage").toString()), Integer.parseInt(mp.get("pagesize").toString()));
        List<Question> list = questionService.queryAllByLimit(mp);
        PageInfo<Question> pageInfo = new PageInfo<Question>(list);
        return Result.success(pageInfo);
    }

    /**
     * 查询所有
     */
    @PostMapping("/queryAll")
    public Result queryAll(@RequestBody Question question) {
        List<Question> list = questionService.queryCondition(question);
        return Result.success(list);
    }

    /**
     * 通过主键查询单条数据
     */
    @GetMapping("/selectOne")
    public Result selectOne(Integer id) {
        Question question = questionService.queryById(id);
        return Result.success(question);
    }

    /**
     * 新增
     */
    @RequestMapping("/add")
    public Result add(@RequestBody Question question) {
        Date date = new Date();
        question.setCreateTime(date);
        questionService.insert(question);
        return Result.success("操作成功");
    }

    /**
     * 修改
     */
    @RequestMapping("/edit")
    public Result edit(@RequestBody Question question) {
        questionService.update(question);
        return Result.success("操作成功");
    }

    /**
     * 删除
     */
    @GetMapping("/deleteById")
    public Result deleteById(Integer id) {
        questionService.deleteById(id);
        return Result.success("操作成功");
    }

    /**
     * 前端分页查询
     */
    @PostMapping("/frontPage")
    @PassToken
    public Result frontPage(@RequestBody Map<String,String> mp) {
        PageHelper.startPage(Integer.parseInt(mp.get("currentPage").toString()), Integer.parseInt(mp.get("pagesize").toString()));
        List<Question> list = questionService.queryAllByLimit(mp);
        PageInfo<Question> pageInfo = new PageInfo<Question>(list);
        return Result.success(pageInfo);
    }

    /**
     * 前端通过主键查询单条数据
     */
    @GetMapping("/frontOne")
    @PassToken
    public Result frontOne(Integer id) {
        Question question = questionService.queryById(id);
        return Result.success(question);
    }

    /**
     * 前端查询所有
     */
    @PostMapping("/frontAll")
    @PassToken
    public Result frontAll(@RequestBody Question question) {
        List<Question> list = questionService.queryCondition(question);
        return Result.success(list);
    }

}