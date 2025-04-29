package com.xushuo.controller;

import com.xushuo.config.PassToken;
import org.springframework.beans.factory.annotation.Autowired;
import com.xushuo.entity.User;
import com.xushuo.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.List;
import java.util.Date;
import com.xushuo.util.Result;

/**
 * 用户表接口
 **/
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 分页查询
     */
    @PostMapping("/selectPage")
    public Result selectPage(@RequestBody Map<String,String> mp) {
        PageHelper.startPage(Integer.parseInt(mp.get("currentPage").toString()), Integer.parseInt(mp.get("pagesize").toString()));
        List<User> list = userService.queryAllByLimit(mp);
        PageInfo<User> pageInfo = new PageInfo<User>(list);
        return Result.success(pageInfo);
    }

    /**
     * 查询所有
     */
    @PostMapping("/queryAll")
    public Result queryAll(@RequestBody User user) {
        List<User> list = userService.queryCondition(user);
        return Result.success(list);
    }

    /**
     * 通过主键查询单条数据
     */
    @GetMapping("/selectOne")
    public Result selectOne(Integer id) {
        User user = userService.queryById(id);
        return Result.success(user);
    }

    /**
     * 新增
     */
    @RequestMapping("/add")
    public Result add(@RequestBody User user) {
        List<User> userList = userService.queryCondition(new User());
        for(int i=0;i<userList.size();i++){
            if(user.getPhone().equals(userList.get(i).getPhone())){
                return Result.error("账号已注册，请重试！！");
            }
        }
        for(int i=0;i<userList.size();i++){
            if(user.getType().equals("02") && user.getSno().equals(userList.get(i).getSno())){
                return Result.error("学号不能重复，请重试！！");
            }
        }
        Date date = new Date();
        user.setCreateTime(date);
        userService.insert(user);
        return Result.success("操作成功");
    }

    /**
     * 修改
     */
    @RequestMapping("/edit")
    public Result edit(@RequestBody User user) {
        List<User> userList = userService.queryCondition(new User());
        for(int i=0;i<userList.size();i++){
            if(user.getPhone().equals(userList.get(i).getPhone()) && userList.get(i).getId()!=user.getId()){
                return Result.error("账号已注册，请重试！！");
            }
        }
        for(int i=0;i<userList.size();i++){
            if(user.getType().equals("02") && user.getSno().equals(userList.get(i).getSno()) && userList.get(i).getId()!=user.getId()){
                return Result.error("学号不能重复，请重试！！");
            }
        }
        userService.update(user);
        return Result.success("操作成功");
    }

    /**
     * 删除
     */
    @GetMapping("/deleteById")
    public Result deleteById(Integer id) {
        userService.deleteById(id);
        return Result.success("操作成功");
    }

    /**
     * 前端分页查询
     */
    @PostMapping("/frontPage")
    @PassToken
    public Result frontPage(@RequestBody Map<String,String> mp) {
        PageHelper.startPage(Integer.parseInt(mp.get("currentPage").toString()), Integer.parseInt(mp.get("pagesize").toString()));
        List<User> list = userService.queryAllByLimit(mp);
        PageInfo<User> pageInfo = new PageInfo<User>(list);
        return Result.success(pageInfo);
    }

    /**
     * 前端通过主键查询单条数据
     */
    @GetMapping("/frontOne")
    @PassToken
    public Result frontOne(Integer id) {
        User user = userService.queryById(id);
        return Result.success(user);
    }

    /**
     * 前端查询所有
     */
    @PostMapping("/frontAll")
    @PassToken
    public Result frontAll(@RequestBody User user) {
        List<User> list = userService.queryCondition(user);
        return Result.success(list);
    }

}