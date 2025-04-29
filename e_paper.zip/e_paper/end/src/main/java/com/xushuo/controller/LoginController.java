package com.xushuo.controller;

import com.xushuo.entity.Admin;
import com.xushuo.entity.User;
import com.xushuo.service.*;
import com.xushuo.util.MapToObj;
import com.xushuo.util.Result;
import com.xushuo.util.TokenUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * 公共接口
 **/
@RestController
public class LoginController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private UserService userService;

    /**
     * 登陆
     */
    @PostMapping("/login")
    public Result login(@RequestBody HashMap<String, String> map, HttpSession session) {
        if(map.get("type").isEmpty()){
            return Result.error("人员类型缺失！");
        }
        String type = map.get("type");
        String account = map.get("phone");
        String password = map.get("password");
        if(type.equals("01")){
            Admin admin = new Admin();
            admin.setUsername(account);
            List<Admin> adminList = adminService.queryCondition(admin);
            if(adminList.size()==0){
                return Result.error("账号不存在！");
            }
            Admin loginAccount = adminList.get(0);
            if(!loginAccount.getPassword().equals(password)){
                return Result.error("密码错误，请重试！");
            }
            String token = TokenUtils.getToken(loginAccount.getId().toString(), loginAccount.getPassword(),type);
            loginAccount.setToken(token);
            return Result.success("登录成功", loginAccount);
        }
        if(type.equals("02")){
            User user = new User();
            user.setPhone(account);
            user.setType("01");
            List<User> userList = userService.queryCondition(user);
            if(userList.size()==0){
                return Result.error("账号不存在！");
            }
            User loginAccount = userList.get(0);
            if(!loginAccount.getPassword().equals(password)){
                return Result.error("密码错误，请重试！");
            }
            String token = TokenUtils.getToken(loginAccount.getId().toString(), loginAccount.getPassword(),type);
            loginAccount.setToken(token);
            return Result.success("登录成功", loginAccount);
        }
        if(type.equals("03")){
            User user = new User();
            user.setPhone(account);
            user.setType("02");
            List<User> userList = userService.queryCondition(user);
            if(userList.size()==0){
                return Result.error("账号不存在！");
            }
            User loginAccount = userList.get(0);
            if(!loginAccount.getPassword().equals(password)){
                return Result.error("密码错误，请重试！");
            }
            String token = TokenUtils.getToken(loginAccount.getId().toString(), loginAccount.getPassword(),type);
            loginAccount.setToken(token);
            return Result.success("登录成功", loginAccount);
        }
        return Result.error("系统错误");
    }

    /**
     * 注册
     */
    @PostMapping("/register")
    public Result register(@RequestBody HashMap<String, Object> map) throws Exception {
        if(map.get("type")==null){
            return Result.error("人员类型缺失！");
        }
        if (!map.get("password").equals(map.get("repassword"))){
            return Result.error("请输入两次相同密码！");
        }
        String type = map.get("type").toString();
        Date date = new Date();
        if(type.equals("01") || type.equals("02")){
            User user =  MapToObj.mapToObj(map,User.class);
            List<User> userList = userService.queryCondition(new User());
            for(int i=0;i<userList.size();i++){
                if(user.getPhone().equals(userList.get(i).getPhone())){
                    return Result.error("账号已注册，请重试！！");
                }
            }
            if(type.equals("02")){
                for(int i=0;i<userList.size();i++){
                    if(user.getSno().equals(userList.get(i).getSno())){
                        return Result.error("学号不能重复，请重试！！");
                    }
                }
            }

            user.setCreateTime(date);
            userService.insert(user);
            return Result.success("注册成功");
        }
        return Result.error("系统错误");
    }

    /**
     * 修改信息
     */
    @Transactional
    @RequestMapping("/updateUser")
    public Result edit(@RequestBody HashMap<String, Object> map, HttpSession session) {
        try {
            if(map.get("type")==null){
                return Result.error("人员类型缺失！");
            }
            String type = map.get("type").toString();
            if(type.equals("01")){
                map.remove("createTime");
                Admin admin =  MapToObj.mapToObj(map,Admin.class);
                List<Admin> adminList = adminService.queryCondition(new Admin());
                for(int i=0;i<adminList.size();i++){
                    if(admin.getUsername().equals(adminList.get(i).getUsername())){
                        return Result.error("账号重复，请重试！！");
                    }
                }
                adminService.update(admin);
                //重新生成token
                Admin loginAccount = adminService.queryById(admin.getId());
                String token = TokenUtils.getToken(loginAccount.getId().toString(), loginAccount.getPassword(),type);
                loginAccount.setToken(token);
                return Result.success("修改成功", loginAccount);
            }
            if(type.equals("02") || type.equals("03")){
                map.remove("createTime");
                User user =  MapToObj.mapToObj(map,User.class);
                if(type.equals("02")){
                    user.setType("01");
                }
                if(type.equals("03")){
                    user.setType("02");
                }
                List<User> userList = userService.queryCondition(new User());
                for(int i=0;i<userList.size();i++){
                    if(user.getPhone().equals(userList.get(i).getPhone()) && userList.get(i).getId()!=user.getId()){
                        return Result.error("账号重复，请重试！！");
                    }
                    if(user.getType().equals("02") && user.getSno().equals(userList.get(i).getSno())  && userList.get(i).getId()!=user.getId() ){
                        return Result.error("学号不能重复，请重试！！");
                    }
                }
                userService.update(user);
                //重新生成token
                User loginAccount = userService.queryById(user.getId());
                String token = TokenUtils.getToken(loginAccount.getId().toString(), loginAccount.getPassword(),type);
                loginAccount.setToken(token);
                return Result.success("修改成功", loginAccount);
            }
            return Result.error("系统失败");
        }catch (Exception e){
            e.printStackTrace();
            return Result.error("修改失败");
        }
    }

}