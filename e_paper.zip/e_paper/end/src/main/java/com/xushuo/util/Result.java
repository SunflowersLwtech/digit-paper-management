package com.xushuo.util;


import java.io.Serializable;

/**
 * 控制层通用结果集
 */

public class Result implements Serializable {

    private int code;
    private String msg;
    private Object data;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public static Result success(String msg, Object data){
        return success(200,msg,data);
    }

    public static Result success(String msg){
        return success(200,msg,null);
    }

    public static Result success(Object data){
        return success(200,"操作成功",data);
    }

    public static Result error(String msg){
        return error(400,msg,null);
    }

    public static Result success(int code, String msg, Object data){
        Result result = new Result();
        result.setCode(code);
        result.setMsg(msg);
        result.setData(data);
        return result;
    }

    public static Result error(int code, String msg, Object data){
        Result result = new Result();
        result.setCode(code);
        result.setMsg(msg);
        result.setData(data);
        return result;
    }
}
